<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
String gnid = request.getParameter("gnid");
String gnmc = "";
ResultSet rs = null;

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));

try
{
  database.open();

	rs = database.query("select * from t_gn where gnid = '" + gnid + "'");
	if (rs.next())
    gnmc = rs.getString("mc");
}
catch (Exception e)
{
  (new Log()).log("error", "admin/xitong/gnyh.jsp��" + Global.getInstance().getTime() + "��" + e.getMessage());
}
finally
{
  database.close();
}
%>

<html>
<head>
<title>�����û�</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312"> 
<link href="../../style/style.css" rel="stylesheet" type="text/css">
<script language="javascript">
function work_query()
{
  work_query_yx();
  work_query_wx();
}

function work_query_yx()
{
  document.gnyh_yx_form.action = "gnyh_select.jsp?gnid=<%=gnid%>";
  document.gnyh_yx_form.submit();
}

function work_query_wx()
{
  document.gnyh_wx_form.action = "gnyh_unselect.jsp?gnid=<%=gnid%>";
  document.gnyh_wx_form.submit();
}

function work_key()
{
  if (event.keyCode == 13)
    work_query();
}
</script>
</head>
<body class="background" style="text-align:center;" onload="work_query();" onkeydown="work_key();">

<br><br>

<table border="0" cellpadding="0" cellspacing="5" align="center">
  <tr>
    <td width="20" height="25"><img src="../../style/images/title2.gif" border="0" width="25" height="25"></td>
    <td class="title">�����û�</td>
  </tr>
</table>

<table width="95%" border="0" cellpadding="0" cellspacing="0" class="box_bottom">
  <tr>
    <td height="60" class="text">
        �������ƣ�<%=gnmc%>&nbsp;
        <input type="button" value="��ѯ" class="button" onclick="work_query();">
    </td>
  </tr>
</table>

<br>

<table width="95%" border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td width="48%" height="340" class="text">
      <form name="gnyh_yx_form" method="post" target="gnyh_yx_frame">
      &nbsp;��ѡ�û���<input type="text" name="yxyhmc" class="input">&nbsp;&nbsp;<input type="button" class="button" value="��ѯ" onclick="work_query_yx();">
      </form>
      
      <br>
      
      <iframe name="gnyh_yx_frame" src="gnyh_select.jsp" frameborder="0" scrolling="no" width="100%" height="100%"></iframe>
    </td>
    <td width="4%">&nbsp;</td>
    <td width="48%" class="text">
      <form name="gnyh_wx_form" method="post" target="gnyh_wx_frame">
      &nbsp;δѡ�û���<input type="text" name="wxyhmc" class="input">&nbsp;&nbsp;<input type="button" class="button" value="��ѯ" onclick="work_query_wx();">
      </form>
      
      <br>
      
      <iframe name="gnyh_wx_frame" src="gnyh_unselect.jsp" frameborder="0" scrolling="no" width="100%" height="100%"></iframe>
    </td>
  </tr>
</table>
</body>
</html>