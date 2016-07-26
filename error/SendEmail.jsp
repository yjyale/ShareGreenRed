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
      * Author: Yue Ji 
      * Created on March 15, 2004, 3:33 PM
      * SendEmail.jsp
--%>
<%@ page import="java.util.Properties,javax.mail.*,javax.mail.internet.*" %>
<html>
<head><title>YUL Send Email</title></head>
<body>
<%!
public class MyAuthenticator extends Authenticator {
}%>
<%
String CAS_FILTER_USER = "edu.yale.its.tp.cas.client.filter.user";
String host = (String)session.getAttribute(CAS_FILTER_USER) + ".mail.yale.edu";
String from = request.getParameter("emailaddress");
from = request.getParameter("name") + '<' + from + '>';
String to = "prodsys@mailman.yale.edu";
String subject = request.getParameter("subject");
String messagecontent = request.getParameter("comments");

Properties props = System.getProperties();
props.put("mail.smtp.host", host);
Authenticator authi = new MyAuthenticator();
Session mailsession = Session.getInstance(props,authi);
//Session mailsession = Session.getDefaultInstance(props, authi); // Tomcat 4 is OK for the default.

MimeMessage emailmessage = new MimeMessage(mailsession);
emailmessage.setFrom(new InternetAddress(from));
emailmessage.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
emailmessage.setSubject(subject);
emailmessage.setText(messagecontent);

//mailsession.setDebug(true);
Transport.send(emailmessage);
%>
<center><font size=3 face="Arial, Helvetica, sans-serif" color="#0033CC">Your message has been successfully sent to <font color=red><% out.print(to); %></font>  <br>Thank you!
</center></font>
<% request.getSession().setAttribute("status_codeAttribute", null);
request.getSession().setAttribute("messageAttribute", null);
request.getSession().setAttribute("error_typeAttribute", null);
request.getSession().setAttribute("request_uriAttribute", null); %>
</body>
</html>