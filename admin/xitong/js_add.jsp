<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
ResultSet rs = null;
Vector v_ym = new Vector();
Properties p = null;
int i = 0;

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));

try
{
  database.open();

  rs = database.query("select * from t_ym where zt = 'Y' order by xh");
  while (rs.next())
  {
    p = new Properties();
    p.setProperty("ymid", rs.getString("ymid"));
    p.setProperty("mc", rs.getString("mc"));
    v_ym.add(p);
  }
}
catch (Exception e)
{
  (new Log()).log("error", "admin/xitong/js_add.jsp��" + Global.getInstance().getTime() + "��" + e.getMessage());
}
finally
{
  database.close();
}
%>

<html>
<head>
<title>��ɫ����_����</title>
<link href="../../style/style.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../../style/tool.js"></script>
<script language="javascript">
function work_save()
{
  if (document.js_add_form.mc.value == "")
  {
    alert("���Ʋ���Ϊ��");
    return;
  }

  document.js_add_form.target = "js_add_frame";
  document.js_add_form.action = "js_do.jsp?operate=add";
  document.js_add_form.submit();
}

function work_back()
{
  window.opener.work_query();
  window.close();
}
</script>
</head>
<body style="text-align:center;" class="background">

<br><br>

<table border="0" cellpadding="0" cellspacing="5" align="center">
  <tr>
    <td width="20" height="25"><img src="../../style/images/title2.gif" border="0" width="25" height="25"></td>
    <td class="title">��ɫ����_����</td>
  </tr>
</table>

<br>

<form name="js_add_form" method="post">
<table border="0" cellpadding="0" cellspacing="0" align="center">
  <tr><td height="40" align="right" class="text">��&nbsp;&nbsp;&nbsp;&nbsp;�ƣ�</td>
      <td><input type="text" name="mc"></td>
  </tr>
  <tr><td height="40" align="right" class="text">��&nbsp;&nbsp;&nbsp;&nbsp;�ţ�</td>
      <td><input type="text" name="xh"></td>
  </tr>
  <tr><td height="40" align="right" class="text">ҳ&nbsp;&nbsp;&nbsp;&nbsp;�棺</td>
      <td><select name="ymid" class="select">
            <option value=""></option>
        <%for (i = 0; i < v_ym.size(); i++)
          {%>
            <option value="<%=(((Properties) v_ym.get(i)).getProperty("ymid"))%>"><%=(((Properties) v_ym.get(i)).getProperty("mc"))%></option>
        <%}%>
          </select>
      </td>
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
</form>

<iframe name="js_add_frame" src="" frameborder="0" scrolling="no" width="0" height="0"></iframe>

</body>
</html>