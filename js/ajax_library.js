var myRequest = getXMLHttpRequest();

//Yue updated on 11/17/2011 10:36AM.
function getXMLHttpRequest() {
    var request = null;

    if (window.XMLHttpRequest) {
//For Non IE Browser
        request = new XMLHttpRequest();
    }
    else if (window.ActiveXObject) {
//For IE Browser
        try {
             request = new ActiveXObject("Microsoft.XMLHTTP");
        } catch (e1) {
             try {
                 request = new ActiveXObject("MSXML2.XMLHTTP");
             }
             catch (e2) {
                try {
                    request = new ActiveXObject("MSXML3.XMLHTTP");
                }
                catch (e3) {
                    alert("Create Ajax Failed!" + e3)
                }
             }
          }
    }
    else {
//Unknown Browser
        alert("Unknown Browser!");
    }
    return request;
}

/* Yue commented on 11/17/2011 10:20AM.
function getXMLHttpRequest() {
//var activeXVersions = ["Msxml2.DOMDocument.6.0","Msxml2.DOMDocument.3.0","Msxml2.XMLHTTP","Microsoft.XMLHTTP"];
    var activeXVersions = ["Msxml2.DOMDocument.6.0","Msxml2.XMLHTTP","Microsoft.XMLHTTP"];

    try {
        return new XMLHttpRequest;
    } catch (e) {
    for (var i=0; i < activeXVersions.length; i++) {
        try {
            return new ActiveXObject(activeXVersions[i]);
	} catch (e) {}
    }
   } 
   return null;
}
*/

function callAjax(url,method,data,callback) {
// Assign default values if not passed
    var method = (method == null) ? "GET" : method; // Default method
    var data = (data == null) ? '' : data;  // Default POST data
    var callback = (callback == null) ? handleAjaxResponse : callback; //Default callBack function
    var myRandom = parseInt(Math.random()*99999999);
    var rUrl = '';
    if (url.indexOf('?') == -1) {
        rUrl = url + '?rand=' + myRandom;
    } else {
	rUrl = url + '&rand=' + myRandom;
    }

    myRequest.open(method, rUrl, true);

// Set the content type in the POST request 
    if (method == 'POST') {
        myRequest.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    }
    myRequest.onreadystatechange  = callback;
    myRequest.send (data);
}

//  Default callback handler
function handleAjaxResponse() {
    try {
        console.debug('readyState=' + myRequest.readyState);
    } catch (err) {}
    if (myRequest.readyState == 4) {
        if (myRequest.status == 200) {
            alert("You are in the default handler. You probably made a mistake when typing the name of the callback handler.");
        } else {
            alert ('An error occurred: ' + myRequest.statusText);
	}
    }
}