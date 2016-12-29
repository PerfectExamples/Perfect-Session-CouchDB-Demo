

import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import PerfectSession
import PerfectSessionCouchDB
import CouchDBStORM

let server = HTTPServer()

SessionConfig.name = "TestingCouchDBDrivers"
SessionConfig.idle = 60
SessionConfig.couchDatabase = "perfectsessions"

// Optional
SessionConfig.cookieDomain = "localhost"
SessionConfig.IPAddressLock = true
SessionConfig.userAgentLock = true

CouchDBConnection.host = "localhost"
CouchDBConnection.username = "perfect"
CouchDBConnection.password = "perfect"

let sessionDriver = SessionCouchDBDriver()

server.setRequestFilters([sessionDriver.requestFilter])
server.setResponseFilters([sessionDriver.responseFilter])

server.addRoutes(makeWebDemoRoutes())
server.serverPort = 8181

do {
	// Launch the HTTP server.
	try server.start()
} catch PerfectError.networkError(let err, let msg) {
	print("Network error thrown: \(err) \(msg)")
}
