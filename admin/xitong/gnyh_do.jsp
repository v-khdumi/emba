<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
//�����û�_ά��
String operate = request.getParameter("operate");
String gnid = request.getParameter("gnid");
String yhid = request.getParameter("yhid");

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));

if (operate.equals("add")) //����
{
  try
  {
    database.open();
  
    database.update("insert into t_yh_gn(yhid, gnid) values('" + yhid + "', '" + gnid + "')");
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/xitong/gnyh_do.jsp��" + Global.getInstance().getTime() + "��" + e.getMessage());
  }
  finally
  {
    database.close();
  }
  
  out.println("<script language='javascript'>");
  out.println("alert('�������ݳɹ�');");
  out.println("window.parent.parent.work_query();");
  out.println("</script>");
}

if (operate.equals("delete")) //ɾ��
{
  try
  {
    database.open();
  
  	database.update("delete from t_yh_gn where yhid = '" + yhid + "' and gnid = '" + gnid + "'");
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/xitong/jsyh_do.jsp��" + Global.getInstance().getTime() + "��" + e.getMessage());
  }
  finally
  {
    database.close();
  }
  
  out.println("<script language='javascript'>");
  out.println("alert('ɾ�����ݳɹ�');");
  out.println("window.parent.parent.work_query();");
  out.println("</script>");
}
%>