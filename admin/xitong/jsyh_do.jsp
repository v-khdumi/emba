<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
//��ɫ�û�_ά��
String operate = request.getParameter("operate");
String jsid = request.getParameter("jsid");
String yhid = request.getParameter("yhid");

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));

if (operate.equals("add")) //����
{
  try
  {
    database.open();
  
    database.update("update t_yh set jsid = '" + jsid + "' where yhid = '" + yhid + "'");
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
  out.println("alert('�������ݳɹ�');");
  out.println("window.parent.parent.work_query();");
  out.println("</script>");
}

if (operate.equals("delete")) //ɾ��
{
  try
  {
    database.open();
  
  	database.update("update t_yh set jsid = '-1' where yhid = '" + yhid + "'");
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