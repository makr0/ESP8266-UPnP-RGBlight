Fnordlicht UPnP Server on ESP8266

## Features

* announces itself as Fnordlicht via UPnP
* based on [nodemcu-httpserver](https://github.com/marcoskirsch/nodemcu-httpserver)
* UPnP Lua Script from [nodemcu-ssdp](https://github.com/pastukhov/nodemcu-ssdp)

## How to use

1. modify init.lua to contain your wifi credentials
2. Upload all files starting with http, init.lua and upnp.lua to your ESP

   Restart the server. This will execute init.lua which will compile the server code.

3. For making your own scripts refer to [nodemcu-httpserver](https://github.com/marcoskirsch/nodemcu-httpserver)