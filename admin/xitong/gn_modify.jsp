<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
String gnid = request.getParameter("list");
String mc = "";
String ms = "";
String wj = "";
String mkid = "";
String mkmc = "";
String xh = "";
String zt = "";
ResultSet rs = null;

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));

try
{
  database.open();

  rs = database.query(" select t_gn.*, t_mk.mc mkmc" +
                      " from t_gn, t_mk" +
                      " where t_gn.mkid = t_mk.mkid" +
                      "       and t_gn.gnid = '" + gnid + "'");
  if (rs.next())
  {
    mc = rs.getString("mc");
    wj = rs.getString("wj");
    mkid = rs.getString("mkid");
    mkmc = rs.getString("mkmc");
    xh = rs.getString("xh");
    zt = rs.getString("zt");

    if (rs.getString("ms") != null)
      ms = rs.getString("ms");
  }
}
catch (Exception e)
{
  (new Log()).log("error", "admin/xitong/gn_modify.jsp��" + Global.getInstance().getTime() + "��" + e.getMessage());
}
finally
{
  database.close();
}
%>

<html>
<head>
<title>���ܹ���_�޸�</title>
<link href="../../style/style.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../../style/tool.js"></script>
<script language="javascript">
function work_mk_back(mkid, mkmc) //ģ��ѡ�񷵻�
{
  document.gn_modify_form.mkid.value = mkid;
  document.gn_modify_form.mkmc.value = mkmc;
}

function work_save()
{
  if (document.gn_modify_form.mc.value == "")
  {
    alert("���Ʋ���Ϊ��");
    return;
  }

  if (document.gn_modify_form.wj.value == "")
  {
    alert("�ļ�����Ϊ��");
    return;
  }

  if (document.gn_modify_form.mkid.value == "")
  {
    alert("ģ�鲻��Ϊ��");
    return;
  }

  document.gn_modify_form.target = "gn_modify_frame";
  document.gn_modify_form.action = "gn_do.jsp?operate=modify";
  document.gn_modify_form.submit();
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
    <td class="title">���ܹ���_�޸�</td>
  </tr>
</table>

<br><br>

<table width="750" height="400" border="0" cellpadding="0" cellspacing="0" align="center">
  <tr>
    <td height="100%" align="center" valign="top">
      <form name="gn_modify_form" method="post">
      <table border="0" cellpadding="0" cellspacing="0" align="center">
        <tr><td height="40" align="right" class="text">��&nbsp;&nbsp;&nbsp;&nbsp;�ƣ�</td>
            <td><input type="text" name="mc" value="<%=mc%>" style="width:250px;"></td>
        </tr>
        <tr><td height="40" align="right" class="text">��&nbsp;&nbsp;&nbsp;&nbsp;����</td>
            <td><input type="text" name="ms" value="<%=ms%>" style="width:250px;"></td>
        </tr>
        <tr><td height="40" align="right" class="text">��&nbsp;&nbsp;&nbsp;&nbsp;����</td>
            <td><input type="text" name="wj" value="<%=wj%>" style="width:250px;"></td>
        </tr>
        <tr><td height="40" align="right" class="text">ģ&nbsp;&nbsp;&nbsp;&nbsp;�飺</td>
            <td><input type="text" name="mkmc" value="<%=mkmc%>" style="width:250px;" readonly></td>
        </tr>
        <tr><td height="40" align="right" class="text">��&nbsp;&nbsp;&nbsp;&nbsp;�ţ�</td>
            <td><input type="text" name="xh" value="<%=xh%>" style="width:50px;"></td>
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
      <input type="hidden" name="mkid" value="<%=mkid%>">
      <input type="hidden" name="gnid" value="<%=gnid%>">
      </form>
    </td>
    <td width="250" align="center" class="box">
      <iframe src="../xitong/mkxz.jsp" frameborder="0" scrolling="auto" width="100%" height="100%"></iframe>
    </td>
  </tr>
</table>

<iframe name="gn_modify_frame" src="" frameborder="0" scrolling="no" width="0" height="0"></iframe>

<script language="javascript">
  work_select(document.gn_modify_form.zt, '<%=zt%>');
</script>
</body>
</html>