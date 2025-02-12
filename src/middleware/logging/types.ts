export type LogLevel = 'debug' | 'info' | 'warn' | 'error'

export interface LogEntry {
  level: LogLevel
  timestamp: string
  method: string
  path: string
  queryParams?: string
  status: number
  error?: string
  ip: string
  userAgent: string | undefined
  duration: number
  url: string
}

export interface Logger {
  log(entry: LogEntry): void
}
