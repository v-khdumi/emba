<%@ page contentType="text/html;charset=gb2312" %>

<html>
<head>
<title>�޸�����</title>
<link href="../style/style.css" rel="stylesheet" type="text/css">
<script language="javascript">
function work_ok()
{
  if (document.password_form.password_old.value == "")
  {
    alert("�ɵ����벻��Ϊ��");
    return;
  }

  if (document.password_form.password_new.value == "")
  {
    alert("�µ����벻��Ϊ��");
    return;
  }
  
  if (document.password_form.password_new1.value == "")
  {
    alert("ȷ�����벻��Ϊ��");
    return;
  }
  
  if (document.password_form.password_new.value != document.password_form.password_new1.value)
  {
    alert("�µ������ȷ�����벻һ��");
    return;
  }
  
  document.password_form.submit();
}
</script>
</head>
<body style="text-align:center;" class="background">
<br><br>

<table border="0" cellpadding="0" cellspacing="5">
  <tr>
    <td width="20" height="25"><img src="../style/images/title2.gif" border="0" width="25" height="25"></td>
    <td class="title">�޸�����</td>
  </tr>
</table>

<br>
 
<form method="post" name="password_form" action="password_do.jsp">
<table border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td height="50" align="right" class="text">&nbsp;&nbsp;�ɵ����룺</td>
    <td><input class="input" type="password" style="width: 300px;" name="password_old"></td>
  </tr>
  <tr>
    <td height="50" align="right" class="text">&nbsp;&nbsp;�µ����룺</td>
    <td><input class="input" type="password" style="width: 300px;" name="password_new"></td>
  </tr>
  <tr>
    <td height="50" align="right" class="text">&nbsp;&nbsp;ȷ�����룺</td>
    <td><input class="input" type="password" style="width: 300px;" name="password_new1"></td>
  </tr>
  <tr>
    <td colspan="2" height="80" align="center">&nbsp;&nbsp;
      <input type="button" value="ȷ��" class="button" onclick="work_ok();">&nbsp;&nbsp;&nbsp;&nbsp;
      <input type="button" value="ȡ��" class="button" onclick="window.close();">
    </td>
  </tr>
</table>
</form>
</body>
</html>