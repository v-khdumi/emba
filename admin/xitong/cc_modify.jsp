<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
String hwid = request.getParameter("list");
String hwmc = null;
String bh = null;
String sl= null;
String zt = null;
ResultSet rs = null;
Vector v_js = new Vector();
Properties p = null;
int i = 0;

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));

try
{
  database.open();

  rs = database.query("select * from t_cc where hwid = '" + hwid + "'");
  if (rs.next())
  {
    hwmc = rs.getString("hwmc");
    bh = rs.getString("bh");
	sl = rs.getString("sl");
    zt = rs.getString("zt");
  }
}
catch (Exception e)
{
  (new Log()).log("error", "admin/xitong/cc_modify.jsp��" + Global.getInstance().getTime() + "��" + e.getMessage());
}
finally
{
  database.close();
}
%>

<html>
<head>
<title>��ʽ����_�޸�</title>
<link href="../../style/style.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../../style/tool.js"></script>
<script language="javascript">
function work_save()
{
  if (document.cc_modify_form.hwmc.value == "")
  {
    alert("���Ʋ���Ϊ��");
    return;
  }

  document.cc_modify_form.target = "cc_modify_frame";
  document.cc_modify_form.action = "cc_do.jsp?operate=modify";
  document.cc_modify_form.submit();
}

function work_back()
{
  window.opener.parent.work_query();

  window.close();
}
</script>
</head>
<body style="text-align:center;" class="background">

<br><br>

<table border="0" cellpadding="0" cellspacing="5" align="center">
  <tr>
    <td width="20" height="25"><img src="../../style/images/title2.gif" border="0" width="25" height="25"></td>
    <td class="title">�ִ�����_�޸�</td>
  </tr>
</table>

<br>

<form name="cc_modify_form" method="post">
<table border="0" cellpadding="0" cellspacing="0" align="center">
  <tr><td height="40" align="right" class="text">��&nbsp;&nbsp;&nbsp;&nbsp;�ƣ�</td>
      <td><input type="text" name="hwmc" value="<%=hwmc%>"></td>
  </tr>
  <tr><td height="40" align="right" class="text">��&nbsp;&nbsp;&nbsp;&nbsp;�ţ�</td>
      <td><input type="text" name="bh" value="<%=bh%>" style="width:50px;"></td>
  </tr>
  <tr><td height="40" align="right" class="text">��&nbsp;&nbsp;&nbsp;&nbsp;����</td>
      <td><input type="text" name="sl" value="<%=sl%>" style="width:50px;"></td>
  </tr>
  <tr><td height="40" align="right" class="text">״&nbsp;&nbsp;&nbsp;&nbsp;̬��</td>
      <td><select name="zt" class="select">
            <option value="Y">ʹ��</option>
            <option value="N">ͣ��</option>
          </select>
      </td>
  </tr>
  <tr>
    <td colspan="2" height="80" align="center" class="text">
      <input type="button" class="button" onclick="work_save();" value="����">&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="button" class="button" onclick="window.close();" value="�ر�">
    </td>
  </tr>
</table>
<input type="hidden" name="hwid" value="<%=hwid%>">
</form>

<iframe name="cc_modify_frame" src="" frameborder="0" scrolling="no" width="0" height="0"></iframe>

<script language="javascript">
  work_select(document.cc_modify_form.zt, '<%=zt%>');
</script>

</body>
</html>