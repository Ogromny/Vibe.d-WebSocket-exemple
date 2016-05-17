import vibe.d;

shared static
this ()
{
	auto settings = new HTTPServerSettings;
	settings.port = 8080;
	settings.bindAddresses = ["127.0.0.1"];

	auto router = new URLRouter;
	router.get ("/", &index);
	router.get ("*", serveStaticFiles ("./public/"));
	router.get ("/ws", handleWebSockets (&handleWebSocket));

	listenHTTP (settings, router);
}

void
index (HTTPServerRequest request, HTTPServerResponse response)
{
	response.render! ("index.dt", request);
}

void
handleWebSocket (scope WebSocket socket)
{
	logInfo ("Socket connected !");

	while (socket.waitForData)
	 {
		 if (!socket.connected)
		  {
			  break;
		  }

		 auto text = socket.receiveText;
		 logInfo ("Received: %s.", text);

		 socket.send ("Yo bro !");
	 }

	socket.close; // socket ended !
	logInfo ("Socket closed !");
}
