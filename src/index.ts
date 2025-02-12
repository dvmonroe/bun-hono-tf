import { Hono } from 'hono'
import { loggingMiddleware } from './middleware/logging'

const app = new Hono()

app.use('*', loggingMiddleware)

app.get('/', (c) => {
  return c.text('Hello World!')
})

app.get('/health', (c) => {
  return c.text('OK', 200)
})

export default app
