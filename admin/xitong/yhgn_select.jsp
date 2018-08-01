<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
//�û�����_��ѡ�б�
String yxgnmc = request.getParameter("yxgnmc");
String yhid = request.getParameter("yhid");
ResultSet rs = null;
Vector v = new Vector();
Vector v_all = new Vector();
Properties p = null;

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));

try
{
  database.open();

  rs = database.query(" select t_gn.*, t_mk.mc mkmc" +
                      " from t_yh_gn, t_gn, t_mk" +
                      " where t_yh_gn.gnid = t_gn.gnid" +
                      "       and t_gn.mkid = t_mk.mkid" +
                      "       and t_yh_gn.yhid = '" + yhid + "'" +
                      "       and t_gn.mc like '%" + yxgnmc + "%'");
  while (rs.next())
  {
    p = new Properties();

	 	p.setProperty("gnid", rs.getString("gnid"));
    p.setProperty("gnmc", rs.getString("mc"));
    p.setProperty("mkmc", rs.getString("mkmc"));
      
    v_all.add(p);
  }
}
catch (Exception e)
{
  (new Log()).log("error", "admin/yonghu/yhgn_select.jsp��" + Global.getInstance().getTime() + "��" + e.getMessage());
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
<title>�û�����_��ѡ�б�</title>
<link href="../../style/style.css" rel="stylesheet" type="text/css">
<script language="javascript">
function work_delete(obj)
{
  if (window.confirm("ȷ��ɾ������"))
    document.yhgn_select_frame.location.href = "yhgn_do.jsp?operate=delete&yhid=<%=yhid%>&gnid=" + obj;
}

function work_go(obj) 
{
  document.yhgn_select_form.action = "yhgn_select.jsp";
  document.yhgn_select_form.target = "_self";
  document.yhgn_select_form.cpage.value = obj;
  document.yhgn_select_form.submit();
  
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
    document.yhgn_select_form.action = "yhgn_select.jsp";
    document.yhgn_select_form.target = "_self";
    document.yhgn_select_form.cpage.value = obj;
    document.yhgn_select_form.submit();
  }  
  
  return false;
}
</script>
</head>
<body>
<form name="yhgn_select_form" method="post">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr><td width="100%" valign="top">
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
        	
        	<td height="30" align="center" class="th box_left box_top" nowrap>ģ��</td>
        	<td align="center" class="th box_left box_top" nowrap>����</td>
        	<td align="center" class="th box_left box_top box_right" nowrap>����</td>
        </tr>
    <%for (i = 0; i < v.size(); i++)
      {%>
        <tr>
          <td height="30" align="center" class="td box_top box_left" nowrap><%=(((Properties) v.get(i)).getProperty("mkmc"))%></td>
          <td align="center" class="td box_top box_left" nowrap><%=(((Properties) v.get(i)).getProperty("gnmc"))%></td>
          <td align="center" class="td box_top box_left box_right" nowrap><a href="javascript:work_delete('<%=(((Properties) v.get(i)).getProperty("gnid"))%>');"><img src="../../style/images/cross.png" border="0" alt="ɾ��"></a></td>
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
<input type="hidden" name="yxgnmc" value="<%=yxgnmc%>">
<input type="hidden" name="yhid" value="<%=yhid%>">
</form>

<iframe name="yhgn_select_frame" src="" frameborder="0" scrolling="no" width="0" height="0"></iframe>

</body>
</html>
