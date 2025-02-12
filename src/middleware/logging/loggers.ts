import { LogEntry, Logger } from './types'

export class DevelopmentLogger implements Logger {
  private readonly colors = {
    error: '\x1b[31m',
    success: '\x1b[32m',
    reset: '\x1b[0m'
  };

  log(entry: LogEntry): void {
    const { level, method, status, duration, error, url } = entry;
    const statusColor = this.getStatusColor(status);
    const urlObj = new URL(url);
    const urlPath = urlObj.pathname + urlObj.search;

    console.log(
      [
        level.toUpperCase(),
        method,
        urlPath,
        `${statusColor}${status}${this.colors.reset}`,
        `${duration}ms`,
        error && `Error: ${error}`
      ]
        .filter(Boolean)
        .join(' ')
    );
  }

  private getStatusColor(status: number): string {
    return status >= 400 ? this.colors.error : this.colors.success;
  }
}

export class ProductionLogger implements Logger {
  private buffer: LogEntry[] = [];
  private readonly batchSize = 100;
  private readonly flushInterval = 5000;

  constructor() {
    setInterval(() => this.flush(), this.flushInterval);
  }

  log(entry: LogEntry): void {
    this.buffer.push(entry);
    if (this.buffer.length >= this.batchSize) {
      this.flush();
    }
  }

  private flush(): void {
    if (this.buffer.length === 0) return;

    this.buffer.forEach(entry => {
      console.log(JSON.stringify(entry));
    });
    this.buffer = [];
  }
}

let loggerInstance: Logger | null = null;

export function createLogger(): Logger {
  if (!loggerInstance) {
    loggerInstance = process.env.NODE_ENV === 'development'
      ? new DevelopmentLogger()
      : new ProductionLogger();
  }
  return loggerInstance;
} 
