import Kitura
import HeliumLogger

// Initialize HeliumLogger
HeliumLogger.use()

let api = MyApi()

Kitura.addHTTPServer(onPort: 8080, with: api.myApiRoutes())
Kitura.run()
