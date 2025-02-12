import { Context } from 'hono'

type LogLevel = 'info' | 'error'

interface LogEntry {
  level: LogLevel
  timestamp: string
  method: string
  path: string
  status: number
  error?: string
  ip: string
  userAgent: string | undefined
  duration: number
}

export function createLogEntry(
  c: Context,
  start: number,
  level: LogLevel,
  status: number,
  error?: string
): LogEntry {
  return {
    level,
    timestamp: new Date().toISOString(),
    method: c.req.method,
    path: new URL(c.req.url).pathname,
    status,
    ...(error && { error }),
    ip: c.req.header('x-forwarded-for') || 'unknown',
    userAgent: c.req.header('user-agent'),
    duration: Date.now() - start
  }
}

export function logRequest(entry: LogEntry): void {
  console.log(JSON.stringify(entry))
}
