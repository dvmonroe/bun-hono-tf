import { Context, Next } from 'hono'
import { createLogEntry, logRequest } from '../logger'

export async function loggingMiddleware(c: Context, next: Next) {
  const start = Date.now()
  
  try {
    await next()
    logRequest(createLogEntry(c, start, 'info', c.res.status))
  } catch (err) {
    const errorMessage = err instanceof Error ? err.message : 'Unknown error'
    logRequest(createLogEntry(c, start, 'error', 500, errorMessage))
    throw err
  }
}
