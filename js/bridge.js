/*
 *  Copyright (c) 2013-2015 Yale University. All rights reserved.
 *
 *  THIS SOFTWARE IS PROVIDED "AS IS," AND ANY EXPRESS OR IMPLIED
 *  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, ARE EXPRESSLY
 *  DISCLAIMED. IN NO EVENT SHALL YALE UNIVERSITY OR ITS EMPLOYEES BE
 *  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 *  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED, THE COSTS OF
 *  PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA OR
 *  PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 *  LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 *  NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 *  SOFTWARE, EVEN IF ADVISED IN ADVANCE OF THE POSSIBILITY OF SUCH
 *  DAMAGE.
 *
 *  Redistribution and use of this software in source or binary forms,
 *  with or without modification, are permitted, provided that the
 *  following conditions are met:
 *
 *  1. Any redistribution must include the above copyright notice and
 *  disclaimer and this list of conditions in any related documentation
 *  and, if feasible, in the redistributed software.
 *
 *  2. Any redistribution must include the acknowledgment, "This product
 *  includes software developed by Yale University," in any related
 *  documentation and, if feasible, in the redistributed software.
 *
 *  3. The names "Yale" and "Yale University" must not be used to endorse
 *  or promote products derived from this software.
 */
 
function chk_submit() {
    var theForm = document.getElementById("firstForm");
    var gate = theForm.gate.options[theForm.gate.selectedIndex].value;

    if (gate == "0") {
        document.getElementById("submitmsg").innerHTML = "No library exit was selected!";
        return false;
    }

    document.firstForm["gateI"].value = gate;
    theForm.action = 'GRMain.jsp?gate=' + gate
    theForm.method = 'post';
    theForm.submit();    
}

function reset_page() {
    document.getElementById("submitmsg").innerHTML = "";
}

function prepareSubmit(url) {
    var inBarcode = document.getElementById('idBarcode').value;
    var sBarcode = document.getElementById('sbarcode').value;
    var inCount = document.getElementById('counting').value;
    var inGate = document.getElementById('gateD').value;

    if (inBarcode == sBarcode) {
        document.getElementById('idBarcode').value = '';
        return false;
    }

    if ((inBarcode == '') || (inBarcode == null) || (!(isDigits(inBarcode)) && inBarcode.indexOf("YAL") < 0)) {
// document.getElementById("sound_element").innerHTML = "<embed src='sound/s_stop.wav' height=0 width=0 hidden=true autostart=true loop=false></embed>";
        document.bgColor = 'red';
        document.getElementById("header").style.background = 'red';
        document.getElementById("footer").style.background = 'red';
        document.getElementById('status').innerHTML = 'STOP';
        document.getElementById('status').style.color = 'white';
// document.getElementById('refresh').innerHTML = '<a href="GRMain.jsp">Refresh</a>';
        document.myForm["idBarcode"].value = '';
        setTimeout(function() { document.getElementById('idBarcode').focus(); }, 1);
// document.getElementById('counting').value = '0';
        document.getElementById('sbarcode').value = '';
        return false;
    }

    if ((inCount == null) || (inCount == ""))
        inCount = 0;
    document.getElementById('sbarcode').value = inBarcode;
    postData = 'inBarcode=' + inBarcode + '&counting=' + inCount + '&gate=' + inGate;

    callAjax(url,'POST',postData,trackingCallback);
}

function trackingCallback() {
// console.debug ('readyState=' + myRequest.readyState);
    if (myRequest.readyState == 4) {
        if (myRequest.status == 200) {
            var description = '';
            var xmlResponse =  myRequest.responseXML;
            var daList = xmlResponse.getElementsByTagName('record');
            var rStatus = daList[0].getAttribute("status").trim();
            var rCount = daList[0].getAttribute("counting").trim();

            if (rStatus.indexOf('red') == 0) {
// document.getElementById("sound_element").innerHTML = "<embed src='sound/s_stop.wav' height=0 width=0 hidden=true autostart=true loop=false>";
                document.bgColor = 'red';
                document.getElementById("header").style.background = 'red';
                document.getElementById("footer").style.background = 'red';
                document.getElementById('status').innerHTML = 'STOP';
                document.getElementById('status').style.color = 'white';
                document.myForm["idBarcode"].value = '';
                setTimeout(function() { document.getElementById('idBarcode').focus(); }, 1);
                document.getElementById('counting').value = rCount;
            }

            if (rStatus.indexOf('green') == 0) {
// document.getElementById("sound_element").innerHTML = "<embed src='sound/s_pass.wav' height=0 width=0 hidden=true autostart=true loop=false>";
               document.bgColor = 'green';
               document.getElementById("header").style.background = 'green';
               document.getElementById("footer").style.background = 'green';
               document.getElementById('status').innerHTML = 'PASS ' + rCount;
               document.getElementById('status').style.color = 'white';
// document.getElementById('refresh').innerHTML = '<a href="GRMain.jsp">Refresh</a>';
               document.getElementById('counting').value = rCount;
               document.myForm["idBarcode"].value = '';
               setTimeout(function() { document.getElementById('idBarcode').focus(); }, 1);
            }

            if (rStatus.indexOf('yellow') == 0) {
               document.bgColor = 'green';
               document.getElementById("header").style.background = 'green';
               document.getElementById("footer").style.background = 'green';
               document.getElementById('status').innerHTML = 'PASS,<font size=5>Proceed to next item.</font>';
               document.getElementById('status').style.color = 'white';
               document.getElementById('counting').value = rCount;
               document.myForm["idBarcode"].value = '';
               setTimeout(function() { document.getElementById('idBarcode').focus(); }, 1);
            }

	} else
            alert ('An error occurred: ' + myRequest.statusText);
    }
/*
    else
        $('ResultDisplay').innerHTML= '<font color=#B34700><b>Searching ... </b></font>' + '<img src="img/radar1.gif" />';
*/
}

// check 0-9 digit
function isDigits(strString) {
    var strValidChars = "0123456789";
    var strChar, i;

// test strString consists of valid characters listed above
    for (i = 0; i < strString.length; i++) {
        strChar = strString.charAt(i);
        if (strValidChars.indexOf(strChar) < 0) 
           return false;  
    }
    return true;
}

String.prototype.trim = function () 
{ return this.replace(/^\s*/, "").replace(/\s*$/, ""); }