<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
//���ܹ���_�б�
String operate = request.getParameter("operate");
String mkid = request.getParameter("mkid");
String gnmc = request.getParameter("gnmc");
ResultSet rs = null;
Vector v = new Vector();
Vector v_all = new Vector();
Properties p = null;

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));

try
{
  database.open();

  if (operate.equals("mk")) //��ȫ�����һ��ģ��
    rs = database.query(" select t_gn.*, t_bs.mc bsmc, t_mk.mc mkmc" +
                        " from t_gn, t_bs, t_mk" +
                        " where t_gn.mkid = t_mk.mkid" +
                        "       and t_mk.bsid = t_bs.bsid" +
                        "       and t_mk.mkid like '%" + mkid + "%'" +
                        "       and t_gn.mc like '%" + gnmc + "%'" +
                        " order by t_bs.xh, t_mk.xh, t_gn.xh");
  else //��һ����ʽ
    rs = database.query(" select t_gn.*, t_bs.mc bsmc, t_mk.mc mkmc" +
                        " from t_gn, t_bs, t_mk" +
                        " where t_gn.mkid = t_mk.mkid" +
                        "       and t_mk.bsid = t_bs.bsid" +
                        "       and t_bs.bsid like '%" + mkid + "%'" +
                        "       and t_gn.mc like '%" + gnmc + "%'" +
                        " order by t_bs.xh, t_mk.xh, t_gn.xh");
  while (rs.next())
  {
    p = new Properties();

	 	p.setProperty("gnid", rs.getString("gnid"));
    p.setProperty("gnmc", rs.getString("mc"));
    p.setProperty("xh", rs.getString("xh"));
    p.setProperty("wj", rs.getString("wj"));
    p.setProperty("bsmc", rs.getString("bsmc"));
    p.setProperty("mkmc", rs.getString("mkmc"));
    
    if (rs.getString("zt").equals("Y"))
      p.setProperty("zt", "ʹ��");
    else
      p.setProperty("zt", "ͣ��");

    v_all.add(p);
  }
}
catch (Exception e)
{
  (new Log()).log("error", "admin/xitong/gn_list.jsp��" + Global.getInstance().getTime() + "��" + e.getMessage());
}
finally
{
  database.close();
}

//���´����ҳ�б���ʾ
int rpage = 10; //ÿҳ��¼��
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
<title>���ܹ���_�б�</title>
<link href="../../style/style.css" rel="stylesheet" type="text/css">
<script language="javascript">
function work_modify(obj)
{
  window.open("gn_modify.jsp?list=" + obj);
}

function work_delete(obj)
{
  if (window.confirm("ȷ��ɾ������"))
    document.gn_list_frame.location.href = "gn_do.jsp?operate=delete&list=" + obj;
}

function work_set(obj)
{
  window.open("gnyh.jsp?gnid=" + obj);
}

function work_go(obj) 
{
  document.gn_list_form.action = "gn_list.jsp";
  document.gn_list_form.target = "_self";
  document.gn_list_form.cpage.value = obj;
  document.gn_list_form.submit();
  
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
    document.gn_list_form.action = "gn_list.jsp";
    document.gn_list_form.target = "_self";
    document.gn_list_form.cpage.value = obj;
    document.gn_list_form.submit();
  }  
  
  return false;
}
</script>
</head>
<body>
<form name="gn_list_form" method="post">
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr><td width="100%" valign="top">
      <table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
        	<td height="30" align="center" class="th box_left" nowrap>��ʽ</td>
        	<td align="center" class="th box_left" nowrap>ģ��</td>
        	<td align="center" class="th box_left" nowrap>����</td>
        	<td align="center" class="th box_left" nowrap>�ļ�</td>
        	<td align="center" class="th box_left" nowrap>���</td>
        	<td align="center" class="th box_left" nowrap>״̬</td>
        	<td align="center" class="th box_left box_right" nowrap>����</td>
        </tr>
    <%for (i = 0; i < v.size(); i++)
      {%>
        <tr>
          <td height="30" align="center" class="td box_top box_left" nowrap><%=(((Properties) v.get(i)).getProperty("bsmc"))%></td>
          <td align="center" class="td box_top box_left" nowrap><%=(((Properties) v.get(i)).getProperty("mkmc"))%></td>
          <td align="center" class="td box_top box_left" nowrap><%=(((Properties) v.get(i)).getProperty("gnmc"))%></td>
          <td align="center" class="td box_top box_left" nowrap><%=(((Properties) v.get(i)).getProperty("wj"))%></td>
          <td align="center" class="td box_top box_left" nowrap><%=(((Properties) v.get(i)).getProperty("xh"))%></td>
          <td align="center" class="td box_top box_left" nowrap><%=(((Properties) v.get(i)).getProperty("zt"))%></td>
          <td align="center" class="td box_top box_left box_right" nowrap>
            <a href="javascript:work_modify('<%=(((Properties) v.get(i)).getProperty("gnid"))%>');"><img src="../../style/images/pencil.png" border="0" alt="�޸�"></a>&nbsp;
            <a href="javascript:work_delete('<%=(((Properties) v.get(i)).getProperty("gnid"))%>');"><img src="../../style/images/cross.png" border="0" alt="ɾ��"></a>&nbsp;
            
          </td>
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
<input type="hidden" name="operate" value="<%=operate%>">
<input type="hidden" name="mkid" value="<%=mkid%>">
<input type="hidden" name="gnmc" value="<%=gnmc%>">
</form>

<iframe name="gn_list_frame" src="" frameborder="0" scrolling="no" width="0" height="0"></iframe>

</body>
</html>