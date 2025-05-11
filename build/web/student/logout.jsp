<%-- 
    Document   : logout.jsp
    Created on : May 10, 2025, 11:46:47 PM
    Author     : hakus
--%>

<%@ page language="java" %>
<%
    session.invalidate();
    response.sendRedirect("logout");
%>
