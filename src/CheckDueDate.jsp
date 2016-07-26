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
 
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%@ page import="javax.naming.*,javax.sql.*,java.sql.*,java.util.*" %><%!
/* Copyright 2012 Yale University
 * Author  Yue Ji 
 * Created on May 17 2012, 10:00 AM
 * Updated on August 14 2012, 2:45 PM
 * Updated on September 04 2012, 9:13 AM - add more item types, let non 39002 prefix pass.
 * Updated on February 18 2013, 8:44 AM - add Borrow Direct item types, let YAL prefix pass, eg YAL10503000, YAL10524595. PASS_STOP is O(other).
 * CheckDueDate.jsp
 */

Connection con = null, conMySQL = null;
//PreparedStatement pstmt = null, pstmtRedItem = null, pstmtRedTrans = null, pstmtRenew = null, pstmtIns = null, pstmtInsRed = null, pstmtSEQ = null;
PreparedStatement pstmt = null, pstmtRenew = null, pstmtIns = null, pstmtInsRed = null, pstmtSEQ = null;
       
public void jspInit() {
   DataSource ds = null, dsMySQL = null;
   Context initCtx = null, envCtx = null; 
   //String sqlGreen = "", sqlRedItem = "", sqlRedTrans = "";  
   String sqlGreen = "";  
  
   try {
        initCtx = new InitialContext();
        envCtx = (Context) initCtx.lookup("java:comp/env");
        
        ds = (DataSource) envCtx.lookup("jdbc/ReportsDB");      
        con = ds.getConnection(); 
        
        dsMySQL = (DataSource) envCtx.lookup("jdbc/MySQLDB");      
        conMySQL = dsMySQL.getConnection(); 

// Green query.
        /*
        sqlGreen = "SELECT CIRC_TRANSACTION_ID, PATRON_ID"
                 + " FROM ITEM_BARCODE"
                 + ", CIRC_TRANSACTIONS"
                 + ", ITEM"
                 + ", ITEM_STATUS"
                 + " WHERE ITEM_BARCODE.ITEM_BARCODE = ?"
                 + " AND ITEM_BARCODE.ITEM_ID = CIRC_TRANSACTIONS.ITEM_ID"
                 + " AND PATRON_GROUP_ID IN (1,3,4,5,6,8,9,14,16,36,44,46,47,48,49,50,51)"
                 + " AND CIRC_TRANSACTIONS.ITEM_ID = ITEM.ITEM_ID"
                 + " AND ITEM.ITEM_TYPE_ID IN (2,6,10,11,12,14,15,16,17,18,19,20,27,28,30,32,35,41,51,55,57,58,61,62,70,72,75,76,77,78,79)"
                 + " AND ITEM.ITEM_ID = ITEM_STATUS.ITEM_ID"
                 + " AND ITEM_STATUS.ITEM_STATUS IN (2,3,4)";
                 
SELECT CIRC_TRANSACTION_ID, CIRC_TRANSACTIONS.PATRON_ID 
FROM ITEM_BARCODE, CIRC_TRANSACTIONS, PATRON_STATS, ITEM, ITEM_STATUS 
WHERE ITEM_BARCODE.ITEM_BARCODE = '39002123456789' 
AND ITEM_BARCODE.ITEM_ID = CIRC_TRANSACTIONS.ITEM_ID 
AND (CIRC_TRANSACTIONS.PATRON_GROUP_ID IN (1,3,4,5,6,8,9,14,16,36,44,46,47,48,49,50,51) 
OR (CIRC_TRANSACTIONS.PATRON_GROUP_ID = 30 
AND CIRC_TRANSACTIONS.PATRON_ID = PATRON_STATS.PATRON_ID
AND PATRON_STATS.PATRON_STAT_ID IN (260,261,262)))
AND CIRC_TRANSACTIONS.ITEM_ID = ITEM.ITEM_ID 
AND ITEM.ITEM_TYPE_ID IN (2,6,10,11,12,14,15,16,17,18,19,20,27,28,30,32,35,41,51,55,57,58,61,62,70,72,75,76,77,78,79) AND ITEM.ITEM_ID = ITEM_STATUS.ITEM_ID AND ITEM_STATUS.ITEM_STATUS IN (2,3,4)
*/
        sqlGreen = "SELECT CIRC_TRANSACTION_ID, CIRC_TRANSACTIONS.PATRON_ID"
                 + " FROM ITEM_BARCODE"
                 + ", CIRC_TRANSACTIONS"
                 + ", PATRON_STATS"
                 + ", ITEM"
                 + ", ITEM_STATUS"
                 + " WHERE ITEM_BARCODE.ITEM_BARCODE = ?"
                 + " AND ITEM_BARCODE.ITEM_ID = CIRC_TRANSACTIONS.ITEM_ID"
                 + " AND (CIRC_TRANSACTIONS.PATRON_GROUP_ID IN (1,3,4,5,6,8,9,14,16,36,44,46,47,48,49,50,51,52)"
                 + " OR (CIRC_TRANSACTIONS.PATRON_GROUP_ID = 30" 
                 + " AND CIRC_TRANSACTIONS.PATRON_ID = PATRON_STATS.PATRON_ID"
                 + " AND PATRON_STATS.PATRON_STAT_ID IN (260,261,262)))"
                 + " AND CIRC_TRANSACTIONS.ITEM_ID = ITEM.ITEM_ID"
                 + " AND ITEM.ITEM_TYPE_ID IN (2,6,10,11,12,14,15,16,17,18,19,20,27,28,30,32,35,41,51,55,57,58,61,62,70,72,75,76,77,78,79)"
                 + " AND ITEM.ITEM_ID = ITEM_STATUS.ITEM_ID"
                 + " AND ITEM_STATUS.ITEM_STATUS IN (2,3,4)";
                 
 // System.out.println(sqlGreen);          
        pstmt = con.prepareStatement(sqlGreen);
/*      
// Red find item query.
        sqlRedItem = "SELECT item_barcode.item_barcode"
                   + ", item_type.item_type_code"
                   + ", item_status_type.item_status_desc"
                   + ", location.location_code"
                   + ", item.item_id"
                   + " FROM item_barcode"
                   + ", item"
                   + ", item_status"
                   + ", item_status_type"
                   + ", item_type"
                   + ", location"
                   + " WHERE item_barcode.item_barcode = ?"
                   + " AND item_barcode.item_id = item.item_id"
                   + " AND item.item_type_id = item_type.item_type_id"
                   + " AND item.item_id = item_status.item_id"
                   + " AND item_status.item_status = item_status_type.item_status_type"
                   + " AND item.perm_location = location.location_id";
                  
        pstmtRedItem = con.prepareStatement(sqlRedItem);
                  
 // Red find circ transaction query.  39002008967318 = Not Charged+Missing
        sqlRedTrans = "SELECT circ_transactions.circ_transaction_id"
                    + ", circ_transactions.current_due_date"
                    + ", patron_group.patron_group_code"
                    + " FROM circ_transactions"
                    + ", patron_group"
                    + " WHERE circ_transactions.item_id = ?"
                    + " AND circ_transactions.patron_group_id = patron_group.patron_group_id";
                 
        pstmtRedTrans = con.prepareStatement(sqlRedTrans);
*/        
        pstmtSEQ = conMySQL.prepareStatement("SELECT max(SEQ) AS maxseq FROM greenred_check");
        
        pstmtRenew = con.prepareStatement("select * from renew_transactions where circ_transaction_id = ?" 
                   + " order by renew_due_date desc");
                
 /* Insert green status.
  INSERT INTO greenred_check
        (SEQ, PASS_STOP, ITEM_BARCODE, RENEWED_ONLINE, EXIT_DATE_TIME,EXIT_DESK)
        VALUES (1,'P','39002061179348','Y','2012-02-16 15:53:12','Bass')
*/
        pstmtIns = conMySQL.prepareStatement("INSERT INTO greenred_check" 
                 + " (SEQ, PASS_STOP, ITEM_BARCODE, RENEWED_ONLINE, EXIT_DATE_TIME,EXIT_DESK)" 
                 + " VALUES (?,?,?,?,?,?)");
 
/* Insert red status.
 INSERT INTO greenred_check
    (SEQ
    , PASS_STOP
    , ITEM_DUE_DATE
    , ITEM_BARCODE
    , ITEM_TYPE_CODE
    , ITEM_STATUS
    , ITEM_PERM_LOCATION_CODE
    , PATRON_GROUP_CODE
    , RENEWED_ONLINE
    , EXIT_DATE_TIME
    , EXIT_DESK)
    VALUES (30,'S','2012-02-16 15:53:12','39002061179348','microform','Renewed','smlref','GRAD','N','2012-02-16 15:53:12','Bass')
*/
        /*
        pstmtInsRed = conMySQL.prepareStatement("INSERT INTO greenred_check"
                    + " (SEQ" 
                    + ", PASS_STOP" 
                    + ", ITEM_DUE_DATE" 
                    + ", ITEM_BARCODE" 
                    + ", ITEM_TYPE_CODE" 
                    + ", ITEM_STATUS" 
                    + ", ITEM_PERM_LOCATION_CODE" 
                    + ", PATRON_GROUP_CODE" 
                    + ", RENEWED_ONLINE" 
                    + ", EXIT_DATE_TIME" 
                    + ", EXIT_DESK)" 
                    + " VALUES (?,?,?,?,?,?,?,?,?,?,?)");
                    **/
       // System.out.println("jspInit finished");                                
   } catch (SQLException ex) {
         System.err.println("Error in database connection. " + ex);
     } catch(Exception e) { 
            System.err.println("Process error in open primary database connection. " + e.getMessage());
       }
}
%><%
mainProcess (request, response, out); 
%>
<%!
private void mainProcess (HttpServletRequest request, HttpServletResponse response, JspWriter out) {
    Calendar cal = null;
//ResultSet rs = null, rsRedItem = null, rsRedTrans = null, rsRenew = null, rsIns = null, rsSEQ = null;  
    ResultSet rs = null, rsRenew = null, rsIns = null, rsSEQ = null; 
    String inputBarcode = request.getParameter("inBarcode").trim();
    String exitGate = request.getParameter("gate").trim();
    int count = Integer.parseInt(request.getParameter("counting"));
    int seq = 0, i = 0;
    String renewOnline = "", itemStatus = "";
 
    try {
        response.setContentType("text/xml");
        out.println("<?xml version=\"1.0\" encoding=\"UTF-8\"?>");
        out.println("<data>");

        cal = Calendar.getInstance();
        cal.setTime( new java.util.Date() );
     
        rsSEQ = pstmtSEQ.executeQuery();                     
        if (rsSEQ.next()) 
            seq = rsSEQ.getInt("maxseq");      
// Set sequential number.                  
        pstmtIns.setInt(1, seq+1); 
           
// Set item barcode.
        pstmtIns.setString(3, inputBarcode);    
        
// Set exit date timestamp. Format 2011-03-29 17:08:36.0
        pstmtIns.setTimestamp(5, new java.sql.Timestamp(cal.getTime().getTime())); 

// Set exit location.
        pstmtIns.setString(6, exitGate); 

// If the barcode's prefix is not 39002, save them as O.
        if ((!inputBarcode.startsWith("39002")) && (!inputBarcode.toUpperCase().startsWith("YAL"))) {
// This is not library's item, let it pass.
            pstmtIns.setString(2, "O"); 

// Set renew online status as nothing.
            pstmtIns.setString(4, ""); 
 
            out.println("<record status=\"yellow\" counting=\"" + count + "\">");  
        }
        else {
          if (inputBarcode.toUpperCase().startsWith("YAL") && (inputBarcode.indexOf("-") > 0))
             inputBarcode = inputBarcode.substring(0,inputBarcode.indexOf("-")) 
                       + inputBarcode.substring(inputBarcode.indexOf("-")+1,inputBarcode.length());
               
// Search in green query.
        pstmt.setString(1, inputBarcode); 
        rs = pstmt.executeQuery();  
     
// Green process.
        if (rs.next()) {
         //   System.out.println("green");
            if (count == 0) 
                count++;
            else {
                if (rs.getString("PATRON_ID").equals(request.getSession().getAttribute("patronID")))
                    count++;
                else
                    count = 1;
            }
    
// Set pass status.
            pstmtIns.setString(2, "P"); 
                                              
// Set if renew online status.
            pstmtRenew.setString(1, rs.getString("CIRC_TRANSACTION_ID").toString()); 
            rsRenew = pstmtRenew.executeQuery();                   
            if (rsRenew.next()) {
                if (rsRenew.getInt("RENEW_LOCATION") == 534)
                    renewOnline = "Y";
                else
                    renewOnline = "N";
            }
            else
                renewOnline = "N";
            pstmtIns.setString(4, renewOnline); 
              
            request.getSession().setAttribute("patronID", rs.getString("PATRON_ID"));
            out.println("<record status=\"green\" counting=\"" + count + "\">"); 
        }
// Red process.
        else {   
          //   System.out.println("red");
// Set stop status.
            pstmtIns.setString(2, "S"); 

// Set renew online status as nothing.
            pstmtIns.setString(4, ""); 
 
            out.println("<record status=\"red\" counting=\"" + count + "\">"); 
        }
        }
// Write into MySQL table.
        pstmtIns.executeUpdate();
        /*
        if (rs.next()) {
            if (count == 0) 
                count++;
            else {
                if (rs.getString("PATRON_ID").equals(request.getSession().getAttribute("patronID")))
                    count++;
                else
                    count = 1;
            }
           
            rsSEQ = pstmtSEQ.executeQuery();                     
            if (rsSEQ.next()) 
                seq = rsSEQ.getInt("maxseq");      
// Set sequential number.                  
            pstmtIns.setInt(1, seq+1); 
           
// Set item barcode.
            pstmtIns.setString(3, inputBarcode);    
        
// Set pass status.
            pstmtIns.setString(2, "P"); 
                                              
// Set if renew online status.
            pstmtRenew.setString(1, rs.getString("CIRC_TRANSACTION_ID").toString()); 
            rsRenew = pstmtRenew.executeQuery();                   
            if (rsRenew.next()) {
                if (rsRenew.getInt("RENEW_LOCATION") == 534)
                    renewOnline = "Y";
                else
                    renewOnline = "N";
            }
            else
                renewOnline = "N";
            pstmtIns.setString(4, renewOnline); 

// Set exit date timestamp. Format 2011-03-29 17:08:36.0
            pstmtIns.setTimestamp(5, new java.sql.Timestamp(cal.getTime().getTime())); 

// Set exit location.
            pstmtIns.setString(6, exitGate); 
 
// Write into MySQL table.
            pstmtIns.executeUpdate();
              
            request.getSession().setAttribute("patronID", rs.getString("PATRON_ID"));
            out.println("<record status=\"green\" counting=\"" + count + "\">"); 
        }
// Red process.
        else {   
            count = 0;
            out.println("<record status=\"red\" counting=\"" + count + "\">"); 
            rsSEQ = pstmtSEQ.executeQuery();                     
            if (rsSEQ.next()) 
                seq = rsSEQ.getInt("maxseq");
                   
// Set sequential number.                  
            pstmtInsRed.setInt(1, seq+1); 
                    
// Set stop status.
            pstmtInsRed.setString(2, "S"); 
                                      
// Set item barcode.
            pstmtInsRed.setString(4, inputBarcode); 
                    
// Set exit date timestamp. Format 2011-03-29 17:08:36.0
            pstmtInsRed.setTimestamp(10, new java.sql.Timestamp(cal.getTime().getTime())); 

// Set exit location.
            pstmtInsRed.setString(11, exitGate);                  
 // Get item data.                   
            pstmtRedItem.setString(1, inputBarcode);
            rsRedItem = pstmtRedItem.executeQuery();  
            itemStatus = "";
            i = 0;
            while (rsRedItem.next()) {
                if (i == 0) {
                    pstmtInsRed.setString(5, rsRedItem.getString("item_type_code")); 
                    pstmtInsRed.setString(7, rsRedItem.getString("location_code")); 
                    pstmtRedTrans.setString(1, rsRedItem.getString("item_id"));
                }
          
                itemStatus = itemStatus + rsRedItem.getString("item_status_desc") + ", ";
                i++;      
            }
            if (i > 0) {
                if (itemStatus.length() > 100)
                    itemStatus = itemStatus.substring(0,100);
                pstmtInsRed.setString(6, itemStatus.substring(0,itemStatus.length()-2));      
          
// Get item circ transaction data.                   
                rsRedTrans = pstmtRedTrans.executeQuery();  
                if (rsRedTrans.next()) {
// Set item due date timestamp. e.g. 2012-03-05 13:59:12.
                    pstmtInsRed.setTimestamp(3, rsRedTrans.getTimestamp("current_due_date")); 
                
// Set circ transaction patron group belong to.
                    pstmtInsRed.setString(8, rsRedTrans.getString("patron_group_code"));
          
// Set if renew online status.
                    pstmtRenew.setString(1, rsRedTrans.getString("circ_transaction_id").toString()); 
                    rsRenew = pstmtRenew.executeQuery();                   
                    if (rsRenew.next()) {
                        if (rsRenew.getInt("RENEW_LOCATION") == 534)
                            renewOnline = "Y";
                        else
                            renewOnline = "N";
                        }
                        else
                            renewOnline = "N";
                    
                    pstmtInsRed.setString(9, renewOnline); 
                }
// No circ transaction.
                else {
                    pstmtInsRed.setTimestamp(3, null); 
                    pstmtInsRed.setString(8, null);
                    pstmtInsRed.setString(9, null);                   
                }
            }
// No item and circ transaction data.
            else {
                pstmtInsRed.setTimestamp(3, null); 
                pstmtInsRed.setString(5, null); 
                pstmtInsRed.setString(6, null); 
                pstmtInsRed.setString(7, null); 
                pstmtInsRed.setString(8, null);
                pstmtInsRed.setString(9, null); 
            }
            
            pstmtInsRed.executeUpdate();
        } 
        */
        out.println("</record>");
        out.println("</data>");
/*
pstmtIns.close();
       pstmtRenew.close();
        pstmtSEQ.close();
        pstmtHolding.close();
        stmt.close();
        con.close();*/
        return;
    } catch (Exception e) {}
}
%>