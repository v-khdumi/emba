<%@ page contentType="text/html;charset=gb2312" %>

<%
//�˳�ϵͳ
session.removeAttribute("global");
response.sendRedirect("index.jsp");
%>