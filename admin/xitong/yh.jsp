<%@ page contentType="text/html;charset=gb2312" %>

<html>
<head>
<title>�û�����</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link href="../../style/style.css" rel="stylesheet" type="text/css">
<script language="javascript" src="../../style/tool.js"></script>
<script language="javascript">
function work_add() //����
{
  window.open("yh_add.jsp");
}

function work_query() //��ѯ
{
  document.yh_form.target = "yh_frame";
  document.yh_form.action = "yh_list.jsp";
  document.yh_form.submit();
}

function work_key()
{
  if (event.keyCode == 13)
    work_query();
}
</script>
</head>
<body class="background" style="text-align:center;" onload="work_query();" onkeydown="work_key();">
<table width="95%" border="0" cellpadding="0" cellspacing="0" align="center">
  <tr>
    <td height="60" class="text">
      <form name="yh_form" method="post">&nbsp;
        �û����ƣ�<input type="text" name="yhmc" class="input" style="width:100px;">&nbsp;
        ״̬��<select name="zt" class="select">
                <option value=""></option>
                <option value="Y">ʹ��</option>
                <option value="N">ͣ��</option>
             </select>&nbsp;
        <input type="button" value="��ѯ" class="button" onclick="work_query();">&nbsp;
        <input type="button" value="����" class="button" onclick="work_add();">
      </form>
    </td>
  </tr>
  <tr>
    <td height="400" class="box_top">
      <iframe name="yh_frame" src="" frameborder="0" scrolling="no" width="100%" height="100%"></iframe>
    </td>
  </tr>
</table>
</body>
</html>