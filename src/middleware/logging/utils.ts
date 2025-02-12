import { Context } from 'hono'
import { LogLevel, LogEntry } from './types'

export function createLogEntry(
  c: Context,
  start: number,
  level: LogLevel,
  status: number,
  error?: string,
): LogEntry {
  const path = c.req.path;

  return {
    level,
    timestamp: new Date().toISOString(),
    method: c.req.method,
    url: c.req.url,
    path,
    queryParams: new URLSearchParams(c.req.query()).toString() || undefined,
    status,
    ...(error && { error }),
    ip: c.req.header('x-forwarded-for') || 'unknown',
    userAgent: c.req.header('user-agent'),
    duration: Date.now() - start,
  }
} 
