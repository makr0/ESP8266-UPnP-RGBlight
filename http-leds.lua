NUM_LEDS=5

function HSV2RGB(h, s, v)
  local i
  local f, w, q, t
  local hue

  if s == 0.0 then
    r = v
    g = v
    b = v
  else
    hue = h
    if hue == 1.0 then
      hue = 0.0
    end
    hue = hue * 6.0

    i = math.floor(hue)
    f = hue - i
    w = v * (1.0 - s)
    q = v * (1.0 - (s * f))
    t = v * (1.0 - (s * (1.0 - f)))
    if i == 0 then
      r = v
      g = t
      b = w
    elseif i == 1 then
      r = q
      g = v
      b = w
    elseif i == 2 then
      r = w
      g = v
      b = t
    elseif i == 3 then
      r = w
      g = q
      b = v
    elseif i == 4 then
      r = t
      g = w
      b = v
    elseif i == 5 then
      r = v
      g = w
      b = q
    end
  end

  return string.char(r*255, g*255, b*255)
end
function rainbow()
  hue=0.0

  tmr.alarm(0, 100, 1, function()
    ws2812.writergb(4, HSV2RGB(hue,1,1):rep(NUM_LEDS) )
    hue=hue+0.005
    if hue>=1.0 then hue=0.0 end
  end)
end

function spinner(step,color)
  red=string.char(255,0 , 0)
  black=string.char(0, 0, 0)
  step=0
  tmr.alarm(0, 100, 1, function()
    ws2812.writergb(4, black:rep(step)..red..black:rep(NUM_LEDS-step-1))
    step=step+1
    if step==NUM_LEDS then step=0 end
  end)
end

return function (connection, args)
  connection:send("HTTP/1.0 200 OK\r\nContent-Type: text/html; charset=utf-8\r\nCache-Control: private, no-store\r\n\r\n")
  connection:send('<!DOCTYPE html><html><head><title>LEDs</title></head>')
  connection:send('<body>')
  connection:send('<h1>LEDs</h1>')

  local buttons = [===[
  <a href="?mode=rainbow">rainbow</a>
  <a href="?mode=spinner">spinner</a>
  ]===]

  connection:send(buttons)

  if args['mode'] ~= '' then
    tmr.stop(0)
    if args['mode'] == 'rainbow' then rainbow() end
    if args['mode'] == 'spinner' then spinner() end
  end
  connection:send('</body></html>')
end
