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
 
<%-- * Copyright 2005 Yale University
     * @Author  Yue Ji 
     * Created on May 3, 2005 3:17 PM
     * DisplayError403.jsp
--%>
<%@ page isErrorPage="true" %>
<%@ page import="java.util.*,java.io.*" %>
<html>
<head>
  <title>Error - user does not have role.
  </title>
  <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body background="image/background.gif" vlink="#8080ff" alink="#8080ff" link="#8080ff" 
      topmargin=0 leftmargin=0 marginwidth=0 marginheight=0>
<center>
<% String statusCodeString = "";
Object status_code = request.getAttribute("javax.servlet.error.status_code");
statusCodeString = (String) status_code.toString();
statusCodeString = statusCodeString.substring(0,3);
if (statusCodeString.equals("403")) { %>
    <font color="#0080ff" size=5 face="Arial, Helvetica, sans-serif">
    <b>Apologies -- you currently don't have a role with access to this application.</b><p>
    <font size=3>Please contact your supervisor <br>
                 and ask that he/she contact the Library IT at<br> 
    <a class="Footer" href="WriteEmailForm.jsp" target=new>
        Enterprise Systems and Programming Group</a></font></FONT>
<% } %>
</center>
</body>
</html>