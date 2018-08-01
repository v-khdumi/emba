<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
//��ɫ�û�_δѡ�б�
String wxyhmc = request.getParameter("wxyhmc");
String jsid = request.getParameter("jsid");
ResultSet rs = null;
Vector v = new Vector();
Vector v_all = new Vector();
Properties p = null;

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));

try
{
  database.open();

  rs = database.query("select * from t_yh where jsid <> '" + jsid + "' and mc like '%" + wxyhmc + "%'");
  while (rs.next())
  {
    p = new Properties();

	 	p.setProperty("yhid", rs.getString("yhid"));
    p.setProperty("yhmc", rs.getString("mc"));
      
    v_all.add(p);
  }
}
catch (Exception e)
{
  (new Log()).log("error", "admin/xitong/jsyh_unselect.jsp��" + Global.getInstance().getTime() + "��" + e.getMessage());
}
finally
{
  database.close();
}

//���´����ҳ�б���ʾ
int rpage = 8; //ÿҳ��¼��
int npage = 0; //��ҳ��
int nrow = 0; //�ܼ�¼��
int i = 0;

int cpage = 1; //��ǰҳ��
if (request.getParameter("cpage") != null)
  cpage = Integer.parseInt(request.getParameter("cpage"));

nrow = v_all.size();
if (nrow < rpage)
  npage = 1;
else
{
  if ((nrow % rpage) == 0)
    npage = nrow / rpage;
  else
    npage = nrow / rpage + 1;
}

i = 0;
while (i < v_all.size())
{
  if (((cpage == 1) && (i < rpage)) || ((cpage != 1) && (i >= (cpage - 1) * rpage) && (i < cpage * rpage)))
    v.add(v_all.get(i));
    
  if (i >= cpage * rpage)
    break;
    
  i = i + 1;
}
%>

<html>
<head>
<title>��ɫ�û�_δѡ�б�</title>
<link href="../../style/style.css" rel="stylesheet" type="text/css">
<script language="javascript">
function work_add(obj)
{
  document.jsyh_unselect_frame.location.href = "jsyh_do.jsp?operate=add&jsid=<%=jsid%>&yhid=" + obj;
}

function work_go(obj) 
{
  document.jsyh_unselect_form.action = "jsyh_unselect.jsp";
  document.jsyh_unselect_form.target = "_self";
  document.jsyh_unselect_form.cpage.value = obj;
  document.jsyh_unselect_form.submit();
  
  return false;
}

function work_jump(obj) 
{
  if ((obj < 1) && (event.keyCode == 13))
    alert("ҳ������С��1");
  
  if ((obj > <%=npage%>) && (event.keyCode == 13)) 
    alert("ҳ�����ܴ���" + <%=npage%>);
  
  if ((obj >= 1) && (obj <= <%=npage%>) && (event.keyCode == 13)) 
  {
    document.jsyh_unselect_form.action = "jsyh_unselect.jsp";
    document.jsyh_unselect_form.target = "_self";
    document.jsyh_unselect_form.cpage.value = obj;
    document.jsyh_unselect_form.submit();
  }  
  
  return false;
}
</script>
</head>
<body>
<form name="jsyh_unselect_form" method="post">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr><td width="100%" valign="top">
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
        	<td height="30" align="center" class="th box_left box_top" nowrap>�û�</td>
        	<td align="center" class="th box_left box_top box_right" nowrap>����</td>
        </tr>
    <%for (i = 0; i < v.size(); i++)
      {%>
        <tr>
          <td height="30" align="center" class="td box_top box_left" nowrap><%=(((Properties) v.get(i)).getProperty("yhmc"))%></td>
          <td align="center" class="td box_top box_left box_right" nowrap><a href="javascript:work_add('<%=(((Properties) v.get(i)).getProperty("yhid"))%>');"><img src="../../style/images/add.png" border="0" alt="����"></a></td>
        </tr>
    <%}%>
      </table>
  </td></tr>
  <tr><td align="right" class="box_top">
      <table border="0" cellpadding="0" cellspacing="0">
        <tr><td class="text">��<%=nrow%>�� ��<%=cpage%>/<%=npage%>ҳ</td>
            <td class="text">
          <%if (cpage > 1)
            {%>
              &nbsp;<a href="" onclick="return work_go(<%=(cpage - 1)%>);">��һҳ</a>
          <%}
            else
            {%>
              &nbsp;��һҳ
          <%}
   
            if (cpage < npage)
            {%>
              <a href="" onclick="return work_go(<%=(cpage + 1)%>);">��һҳ</a>
          <%}
            else
            {%>
              ��һҳ
          <%}%>
            </td>
            <td valign="top" class="text">&nbsp;��<input type="text" style="height:16px; width:20px;" value="<%=cpage%>" class="input" onkeydown="work_jump(this.value);">ҳ</td>
        </tr>
      </table>
  </td></tr>
</table>
<input type="hidden" name="cpage" value="<%=cpage%>">
<input type="hidden" name="wxyhmc" value="<%=wxyhmc%>">
<input type="hidden" name="jsid" value="<%=jsid%>">
</form>

<iframe name="jsyh_unselect_frame" src="" frameborder="0" scrolling="no" width="0" height="0"></iframe>

</body>
</html>