<%-- 
    Document   : logout.jsp
    Created on : May 10, 2025, 11:49:12 PM
    Author     : hakus
--%>

<%@ page language="java" %>
<%
    session.invalidate();
    response.sendRedirect("logout");
%>