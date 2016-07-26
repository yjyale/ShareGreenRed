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
 
<%--  * Copyright 2012 Yale University
      * Author: Yue Ji 
      * Created on May 16, 2012, 3:15 PM
      * GRMain.jsp
--%>
<%@ page contentType="text/html" session="true"%>
<%@ page import="javax.servlet.*,java.util.Map" session="true" %>
<%@ page pageEncoding="UTF-8"%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<html>
  <head>
    <title>Yale University Library Security Check Items</title>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <link rel="stylesheet" type="text/css" href="css/screen.css">
    <script src="js/prototype.js" type="text/javascript"></script> 
    <script src="js/bridge.js" type="text/javascript"></script>
    <script src="js/ajax_library.js" type="text/javascript"></script>
  </head>
  <body onload="document.myForm.nBarcode.focus();">
    <center>
    <div id="header">
        <% String gateName = "No this exit", gateNameD = "No this exit", gateC = "0";
           Map parmMap = request.getParameterMap();   

           if (parmMap.containsKey("gate")) {
              switch (request.getParameter("gate").charAt(0)) {
                case 'a': 
                    gateName = "SML HIGH STREET EXIT";
                    gateNameD = "SML High";
                    gateC = "a";
                    break;
                case 'b': 
                    gateName = "SML WALL STREET EXIT";
                    gateNameD = "SML Wall";
                    gateC = "b";
                    break;
                case 'c': 
                    gateName = "BASS EXIT";
                    gateNameD = "Bass";
                    gateC = "c";
                    break;
                default: 
                    gateName = "No this exit";
                    gateNameD = "No this exit";
                    gateC = "0";
              }
              /*
              request.getSession().setAttribute("gateName",gateName);
              request.getSession().setAttribute("gateNameD",gateNameD);
              **/
           }
           /*
           else {
                gateName = request.getSession().getAttribute("gateName").toString();
                gateNameD = request.getSession().getAttribute("gateNameD").toString();
           } */
            out.print(gateName); %>
    </div>

    <div id="sound_element"></div>
    
    <form action="error/ErrorPage.html" name="myForm" id="myForm" method="post" onsubmit="prepareSubmit('src/CheckDueDate.jsp'); return false;">
        <label id="slabel">Input Item Barcode</label><br>
        <input type="text" name="nBarcode" id="idBarcode" value="" style="width:18em;height:1em;">
        <input type="hidden" name="counting" id="counting">  
        <input type="hidden" name="sbarcode" id="sbarcode">
        <input type="hidden" name="gateD" id="gateD" value="<% out.print(gateNameD); %>">
        <div id="status"></div>
        <p>
        <input type='button' value='Change Exit' class='button' onclick="window.location.href='index.html'" >
         &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
         <input type='reset' value='Refresh' class='button' onclick="window.location.href='GRMain.jsp?gate=<% out.print(gateC); %>'">
    </form>
    <div id="footer" align="center">
        <a href="http://www.library.yale.edu/htmldocs/copyright.html" target=new>
            &copy; 2012 Yale University Library</a> | 
            Send problems and questions to <a href="mailto:prodsys@mailman.yale.edu" target=new>Enterprise Systems and Programming</a> | 
            This file last modified: February 18, 2013.    
    </div>  
    </center>
  </body>
</html>