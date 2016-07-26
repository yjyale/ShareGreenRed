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
 
<%@ page import="java.util.*, java.io.*"%>
<html>
<!-- $Id: DetailError.jsp,v 1.1 2005/08/18 16:26:05 yuej Exp $ (CVS) -->
<head>
<title>Error Page</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<P>
Here are the attributes of the application:
<%-- The following for loop presents all the attributes stored in the implicit application object. --%>
<%
  Enumeration loop = application.getAttributeNames();
  while (loop.hasMoreElements()){
    String name =  (String) loop.nextElement();
%>
	<BR><%=name%>:  
	<%=application.getAttribute( name).toString()%>
<%
  }
%>
<hr>
<P>
Here are the attributes of the session:
<%-- The following for loop presents all the attributes stored in the implicit session object. --%>
<%
  loop = session.getAttributeNames();
  while (loop.hasMoreElements()){
    String name =  (String) loop.nextElement();
%>
	<BR><%=name%>:  
	<%=session.getAttribute( name).toString()%>
<%
  }
%>
<hr>
<P>
Here are the attributes of the request:
<%-- The following for loop presents all the attributes stored in the implicit request object. --%>
<%
  loop = request.getAttributeNames();
  while (loop.hasMoreElements()){
    String name =  (String) loop.nextElement();
%>
	<BR><%=name%>:  
	<%=request.getAttribute( name).toString()%>
<%
  }
%>
<P>
Here are the parameters of the request:
<%-- This block shows all the request parameters sent by the user. There are two loops because request attributes
     can have more than only value per name.  The out loop steps through all the parameters and then inner loop
	 steps through all the values for each parameter. --%>
<%
  loop = request.getParameterNames();
  while (loop.hasMoreElements()){
    String name = (String) loop.nextElement();
    for(int index = 0; index < request.getParameterValues(name).length; index++){
%>
	<BR><%=name%>:  
	<%=request.getParameterValues( name)[index]%>
<%
    }
  }
%>
<%-- the implit page attributes cannot be displayed because as soon as the page 
     that throws an error is out of scope, the attributes are no longer available --%>

</body>
</html>
