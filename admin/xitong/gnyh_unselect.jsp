<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
//�����û�_δѡ�б�
String wxyhmc = request.getParameter("wxyhmc");
String gnid = request.getParameter("gnid");
ResultSet rs = null;
Vector v = new Vector();
Vector v_all = new Vector();
Properties p = null;

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));

try
{
  database.open();

  rs = database.query(" select t_yh.*, t_bm.mc bmmc" +
                      " from t_yh, t_bm" +
                      " where t_yh.bmid = t_bm.bmid" +
                      "       and t_yh.mc like '%" + wxyhmc + "%'" +
                      "       and not exists (select t_yh_gn.*" +
                      "                       from t_yh_gn" +
                      "                       where t_yh_gn.yhid = t_yh.yhid" +
                      "                             and t_yh_gn.gnid = '" + gnid + "')");
  while (rs.next())
  {
    p = new Properties();

	 	p.setProperty("yhid", rs.getString("yhid"));
    p.setProperty("yhmc", rs.getString("mc"));
    p.setProperty("bmmc", rs.getString("bmmc"));
      
    v_all.add(p);
  }
}
catch (Exception e)
{
  (new Log()).log("error", "admin/xitong/gnyh_unselect.jsp��" + Global.getInstance().getTime() + "��" + e.getMessage());
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
<title>�����û�_δѡ�б�</title>
<link href="../../style/style.css" rel="stylesheet" type="text/css">
<script language="javascript">
function work_add(obj)
{
  document.gnyh_unselect_frame.location.href = "gnyh_do.jsp?operate=add&gnid=<%=gnid%>&yhid=" + obj;
}

function work_go(obj) 
{
  document.gnyh_unselect_form.action = "gnyh_unselect.jsp";
  document.gnyh_unselect_form.target = "_self";
  document.gnyh_unselect_form.cpage.value = obj;
  document.gnyh_unselect_form.submit();
  
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
    document.gnyh_unselect_form.action = "gnyh_unselect.jsp";
    document.gnyh_unselect_form.target = "_self";
    document.gnyh_unselect_form.cpage.value = obj;
    document.gnyh_unselect_form.submit();
  }  
  
  return false;
}
</script>
</head>
<body>
<form name="gnyh_unselect_form" method="post">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr><td width="100%" valign="top">
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
        	<td height="30" align="center" class="th box_left box_top" nowrap>�û�</td>
        	<td align="center" class="th box_left box_top" nowrap>����</td>
        	<td align="center" class="th box_left box_top box_right" nowrap>����</td>
        </tr>
    <%for (i = 0; i < v.size(); i++)
      {%>
        <tr>
          <td height="30" align="center" class="td box_top box_left" nowrap><%=(((Properties) v.get(i)).getProperty("yhmc"))%></td>
          <td align="center" class="td box_top box_left" nowrap><%=(((Properties) v.get(i)).getProperty("bmmc"))%></td>
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
<input type="hidden" name="gnid" value="<%=gnid%>">
</form>

<iframe name="gnyh_unselect_frame" src="" frameborder="0" scrolling="no" width="0" height="0"></iframe>

</body>
</html>