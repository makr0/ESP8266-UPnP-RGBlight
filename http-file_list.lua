return function (connection, args)
   connection:send("HTTP/1.0 200 OK\r\nContent-Type: text/html; charset=utf-8\r\nCache-Control: private, no-store\r\n\r\n")
   connection:send('<!DOCTYPE html><html><head><title>Files</title></head>')
   connection:send('<body>')
   coroutine.yield()

   local remaining, used, total=file.fsinfo()
   connection:send("<b>Total size: </b> " .. total .. " bytes<br/>\n")
   connection:send("<b>In Use: </b> " .. used .. " bytes<br/>\n")
   connection:send("<b>Free: </b> " .. remaining .. " bytes<br/>\n")

   connection:send("<ul>\n")
   l = file.list()
   for name, size in pairs(l) do

      local isHttpFile = string.match(name, "(http%-)") ~= nil
      if isHttpFile then
         local url = string.match(name, "http%-(.*)")
         connection:send('   <li><a href="' .. url .. '">' .. url .. "</a></li>\n")
         coroutine.yield()
      end
   end
   connection:send("</ul>\n")
   connection:send("</p>\n")
   connection:send('</body></html>')
end
