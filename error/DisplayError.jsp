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
 
<%--  * Copyright 2004 Yale University
      * @Author  Yue Ji 
      * Created on November 10, 2003, 12:23 PM
      * DisplayError.jsp
      * $Id: DisplayError.jsp,v 1.1 2005/08/18 16:26:05 yuej Exp $ (CVS)
--%>
<%@ page isErrorPage="true" %>
<%@ page import="java.util.*,java.io.*" %>
<html>
<!-- $Id: DisplayError.jsp,v 1.1 2005/08/18 16:26:05 yuej Exp $ (CVS) -->
<head>
<title>Error Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body background="image/background.gif" vlink="#8080ff" alink="#8080ff" link="#8080ff" topmargin=0 leftmargin=0 marginwidth=0 marginheight=0>
<center>
<blockquote>
<font color="#0080ff" size=5 face="Arial, Helvetica, sans-serif"><b>Error Message</b></FONT><p>
<div><font face="Arial, Helvetica, sans-serif" color="#0080ff" size=3>
You have encountered an error. <br>
If you would like to report this error, <br>
you may email to <a href="error/ReportProblem.jsp" target='new'><b>Enterprise Systems and Programming.</b></a><br>
Or click <a href="error/DetailError.jsp" target='new'><b>here</B></A> to see more detail.
</FONT><p>
<font face="Arial, Helvetica, sans-serif" color="#0080ff" size=4>Thank you!</FONT>
</FONT></div></center><p>

<% 
String errorTypeString = "", statusCodeString = "";
Object status_code = request.getAttribute("javax.servlet.error.status_code");
Object message = request.getAttribute("javax.servlet.error.message");
Object error_type = request.getAttribute("javax.servlet.error.exception_type");
Object request_uri = request.getAttribute("javax.servlet.error.request_uri");

statusCodeString = (String) status_code.toString();
statusCodeString = statusCodeString.substring(0,3);
%>
<center>
<table border=1 cellpadding=10>
    <colgroup align=left width=180>
    </colgroup>
    <colgroup align=left width=300>
    </colgroup>
    <tbody>
        <tr>
            <th align=left>
              <font color="#0080ff" size=2 face="Arial, Helvetica, sans-serif"><b>Status code</b></font>
            </th>
            <td>
              <font color="#0080ff" size=2 face="Arial, Helvetica, sans-serif"><% out.print(statusCodeString); %></font>
            </td>
        </tr>
        <tr>
            <th align=left>
              <font color="#0080ff" size=2 face="Arial, Helvetica, sans-serif"><b>Message</b></font>
            </th>
            <td>
              <font color="#0080ff" size=2 face="Arial, Helvetica, sans-serif"><% out.print(message.toString()); %></font>
            </td>
        </tr>
        <tr>
            <th align=left>
              <font color="#0080ff" size=2 face="Arial, Helvetica, sans-serif"><b>Error type</b></font>
            </th>
            <td>
              <font color="#0080ff" size=2 face="Arial, Helvetica, sans-serif">
                <% if (error_type != null) {
                        errorTypeString = error_type.toString();
                   }
                   else {
                    if (statusCodeString.equals("400"))
                        errorTypeString = "Client Error - Bad Request: THe request could not be understood by the server due to malformed syntax. The client SHOULD NOT repeat the request without modifications.";
                    else if (statusCodeString.equals("401"))
                        errorTypeString = "Client Error - Unauthorized: The request requires user authentication. The response MUST include a WWW-Authenticate header field containing a challenge applicable to the requested resource. The client MAY repeat the request with a suitable Authorization header field. If the request already included Authorization credentials, then the 401 response indicates that authorization has been refused for those credentials. If the 401 response contains the same challenge as the prior response, and the user agent has already attempted authentication at least once, then the user SHOULD be presented the entity that was given in the response, since that entity MAY include relevant diagnostic information.";
                    else if (statusCodeString.equals("403"))
                        errorTypeString = "Client Error - Forbidden: The server understood the request, but is refusing to fulfill it. Authorization will not help and the request SHOULD NOT be repeated. If the request method was not HEAD and the server wishes to make public why the request has not been fulfilled, it SHOULD describe the reason for the refusal in the entity. This status code is commonly used when the server does not wish to reveal exactly why the request has been refused, or when no other response is applicable.";
                    else if (statusCodeString.equals("404"))
                        errorTypeString = "Client Error - Not Found: The server has not found anything matching the Request-URI. No indication is given of whether the condition is temporary or permanent. If the server does not wish to make this information available to the client, the status code 403 (Forbidden) can be used instead. The 410 (Gone) status code SHOULD be used if the server knows, through some internally configurable mechanism, that an old resource is permanently unavailable and has no forwarding address.";
                    else if (statusCodeString.equals("406"))
                        errorTypeString = "Client Error - Not Acceptable: The resource identified by the request is only capable of generating response entities which have content characteristics not acceptable according to the accept headers sent in the request. Unless it was a HEAD request, the response SHOULD include an entity containing a list of available entity characteristics and location(s) from which the user or user agent can choose the one most appropriate. The entity format is specified by the media type given in the Content-Type header field. Depending upon the format and the capabilities of the user agent, selection of the most appropriate choice may be performed automatically. However, this specification does not define any standard for such automatic selection. Note: HTTP/1.1 servers are allowed to return responses which are not acceptable according to the accept headers sent in the request. In some cases, this may even be preferable to sending a 406 response. User agents are encouraged to inspect the headers of an incoming response to determine if it is acceptable. If the response could be unacceptable, a user agent SHOULD temporarily stop receipt of more data and query the user for a decision on further actions.";
                    else if (statusCodeString.equals("408"))
                        errorTypeString = "Client Error - Request Timeout: The client did not produce a request within the time that the server was prepared to wait. The client MAY repeat the request without modifications at any later time.";
                    else if (statusCodeString.equals("500"))
                        errorTypeString = "Server Error - Internal Server Error: The server encountered an unexpected condition, which prevented it from fulfilling the request.";
                    else if (statusCodeString.equals("501"))
                        errorTypeString = "Server Error - Not Implemented: The server does not support the functionality required to fulfill the request. This is the appropriate response when the server does not recognize the request method and is not capable of supporting it for any resource.";
                    else if (statusCodeString.equals("502"))
                        errorTypeString = "Server Error - Bad Gateway: The server, while acting as a gateway or proxy, received an invalid response from the upstream server it accessed in attempting to fulfill the request.";
                    else if (statusCodeString.equals("503"))
                        errorTypeString = "Server Error - Service Unavailable: The server is currently unable to handle the request due to a temporary overloading or maintenance of the server. The implication is that this is a temporary condition which will be alleviated after some delay. If known, the length of the delay may be indicated in a Retry-After header. If no Retry-After is given, the client SHOULD handle the response as it would for a 500 response. Note: The existence of the 503 status code does not imply that a server must use it when becoming overloaded. Some servers may wish to simply refuse the connection.";
                    else if (statusCodeString.equals("504"))
                        errorTypeString = "Server Error - Gateway Timeout: The server, while acting as a gateway or proxy, did not receive a timely response from the upstream server it accessed in attempting to complete the request.";
                    else if (statusCodeString.equals("505"))
                        errorTypeString = "Server Error - HTTP Version Not Supported: The server does not support, or refuses to support, the HTTP protocol version that was used in the request message. The server is indicating that it is unable or unwilling to complete the request using the same major version as the client other than with this error message. The response SHOULD contain an entity describing why that version is not supported and what other protocols are supported by that server.";
                    else   errorTypeString = "Unknown Error.";
                   } 
                   out.print(errorTypeString);  %>
            </td>
        </tr>
        <tr>
            <th align=left>
              <font color="#0080ff" size=2 face="Arial, Helvetica, sans-serif"><b>Request URI</b></font>
            </th>
            <td>
              <font color="#0080ff" size=2 face="Arial, Helvetica, sans-serif"><% out.print(request_uri.toString()); %></font>
            </td>
        </tr>
    </tbody>
</table>
</center>
<% request.getSession().setAttribute("status_codeAttribute", status_code);
request.getSession().setAttribute("messageAttribute", message);
request.getSession().setAttribute("error_typeAttribute", errorTypeString);
request.getSession().setAttribute("request_uriAttribute", request_uri); %>
</blockquote>
</body>
</html>
