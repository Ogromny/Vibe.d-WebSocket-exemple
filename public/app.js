alert ("loaded")

var socket = new WebSocket (getBaseURL () + '/ws');

socket.onopen = function ()
{
    socket.send ("I'm connected bro !");
}

socket.onmessage = function (message)
{
    alert ("I have received " + message);
}

socket.onclose = function ()
{
    //
}

function getBaseURL ()
{
    var href = window.location.href.substring (7); // http://
    var idx  = href.indexOf ("/");
    return 'ws://' + href.substring (0, idx);
}
