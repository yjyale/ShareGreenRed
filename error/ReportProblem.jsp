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
      * Created on March 16, 2004, 4:41 PM
      * ReportProblem.jsp
--%>
<%@page contentType="text/html"%>
<html>
<head> 
<title>YUL Write Email Form</title>
<% String CAS_FILTER_USER = "edu.yale.its.tp.cas.client.filter.user"; %>
<link rel="stylesheet" 
href="../css/WriteEmailForm.css" type="text/css" />
</head>
<body  class="WriteEmailForm_body">
<center>
<FORM METHOD="POST" ACTION="SendEmail.jsp">
    <table class="WriteEmailForm_table" CELLPADDING="2" CELLSPACING="10">
        <tr class="WriteEmailForm_bgcolor1">
            <td COLSPAN=2 ALIGN="center">
                <b><p class="WriteEmailForm_title">Problem Report Form</p></b>
            </td>
        </tr>
        <tr class="WriteEmailForm_bgcolor2">
            <td COLSPAN=2>
                <table>
                    <colgroup width=160 ALIGN="center">
                    </colgroup>
                    <colgroup width=160>
                    </colgroup>
                    <tr>
                        <td>
                            <b><p class="WriteEmailForm_subtitle">Your Name: </p></b>
                        </td>
                        <td>
                            <input TYPE="text" NAME="name" class="WriteEmailForm_input_text" value="<%=request.getSession().getAttribute("OpFirstName")%> (<%=request.getSession().getAttribute("OpLastName")%>)" size=56>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="WriteEmailForm_bgcolor2">
            <td COLSPAN=2>
                <table>
                    <colgroup width=160 ALIGN="center">
                    </colgroup>
                    <colgroup width=160>
                    </colgroup>
                    <tr>
                        <td>
                            <b><p class="WriteEmailForm_subtitle">Email Address: </p></b>
                        </td>
                        <td>
                            <input TYPE="text" NAME="emailaddress" class="WriteEmailForm_input_text" value="<%=(String)session.getAttribute(CAS_FILTER_USER)%>@mail.yale.edu" size=56>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="WriteEmailForm_bgcolor2">
            <td COLSPAN=2>
                <table>
                    <colgroup width=160 ALIGN="center">
                    </colgroup>
                    <colgroup width=160>
                    </colgroup>
                    <tr>
                        <td>
                            <b><p class="WriteEmailForm_subtitle">Subject: </p></b>
                    	</td>
                         <td>
                            <INPUT TYPE="text" NAME="subject" class="WriteEmailForm_input_text" value="Problem Report" size=56>
                         </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr class="WriteEmailForm_bgcolor2">
            <td COLSPAN=2 ALIGN="center">
                <table>
                    <colgroup width=260>
                    </colgroup>
                    <colgroup width=60>
                    </colgroup>
                    <tr>
                        <td ALIGN="center">
                            <b><p class="WriteEmailForm_subtitle">Your Suggestions or Problems: </p></b><p>
                        </td>
                        <td>
                            <INPUT TYPE="submit" value="Send" class="WriteEmailForm_submit_button">
                        </td>
                    </tr>
                    <tr>
                        <td COLSPAN=2 ALIGN="center">
                            <textarea NAME="comments" ROWS=8 COLS=66 class="WriteEmailForm_input_text">
                                Status code: <%=request.getSession().getAttribute("status_codeAttribute")%>
                                Message: <%=request.getSession().getAttribute("messageAttribute")%>
                                Error type: <%=request.getSession().getAttribute("error_typeAttribute")%>
                                Request URI: <%=request.getSession().getAttribute("request_uriAttribute")%>
                            </textarea>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</FORM>
</center>
</body>
<html>