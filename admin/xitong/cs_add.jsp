<%@ page contentType="text/html;charset=gb2312" %>

<html>
<head>
<title>ϵͳ����_����</title>
<link href="../../style/style.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../../style/tool.js"></script>
<script language="javascript">
function work_save()
{
  if (document.cs_add_form.dm.value == "")
  {
    alert("���벻��Ϊ��");
    return;
  }
  
  if (document.cs_add_form.mc.value == "")
  {
    alert("���Ʋ���Ϊ��");
    return;
  }
  
  if (document.cs_add_form.nr.value == "")
  {
    alert("���ݲ���Ϊ��");
    return;
  }

  document.cs_add_form.target = "cs_add_frame";
  document.cs_add_form.action = "cs_do.jsp?operate=add";
  document.cs_add_form.submit();
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
    <td class="title">ϵͳ����_����</td>
  </tr>
</table>

<br>

<form name="cs_add_form" method="post">
<table border="0" cellpadding="0" cellspacing="0" align="center">
  <tr><td height="40" align="right" class="text">��&nbsp;&nbsp;&nbsp;&nbsp;�룺</td>
      <td><input type="text" name="dm"></td>
  </tr>
  <tr><td height="40" align="right" class="text">��&nbsp;&nbsp;&nbsp;&nbsp;�ƣ�</td>
      <td><input type="text" name="mc"></td>
  </tr>
  <tr><td height="40" align="right" class="text">��&nbsp;&nbsp;&nbsp;&nbsp;�ݣ�</td>
      <td><input type="text" name="nr"></td>
  </tr>
  <tr>
    <td colspan="2" height="80" align="center" class="text">
      <input type="button" class="button" onclick="work_save();" value="����">&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="button" class="button" onclick="window.close();" value="�ر�">
    </td>
  </tr>
</table>
</form>

<iframe name="cs_add_frame" src="" frameborder="0" scrolling="no" width="0" height="0"></iframe>

</body>
</html>