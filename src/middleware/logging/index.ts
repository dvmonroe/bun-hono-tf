import { createMiddleware } from 'hono/factory'
import { createLogger } from './loggers'
import { createLogEntry } from './utils'
import { LogLevel } from './types'

export const LoggingMiddleware = () => {
  const logger = createLogger();

  return createMiddleware(async (c, next) => {
    const start = Date.now();

    try {
      await next();
      const status = c.res.status;
      const logLevel: LogLevel =
        status >= 500 ? "error" : status >= 400 ? "warn" : "info";
      logger.log(createLogEntry(c, start, logLevel, status));
    } catch (error) {
      const errorMessage =
        error instanceof Error ? error.message : "Unknown error";
      logger.log(createLogEntry(c, start, "error", 500, errorMessage));
      throw error;
    }
  });
};
