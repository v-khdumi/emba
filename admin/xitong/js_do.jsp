<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
//��ɫ����
String operate = request.getParameter("operate");

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));
  
if (operate.equals("add")) //����
{
  String jsid = Global.getInstance().getYear() + Global.getInstance().getMonth() + Global.getInstance().getDay() + Global.getInstance().getHour() + Global.getInstance().getMinute() + Global.getInstance().getSecond();
  String mc = request.getParameter("mc");
  String zt = request.getParameter("zt");
  String ymid = request.getParameter("ymid");
  ResultSet rs = null;
  
  String xh = request.getParameter("xh");
  if (xh.equals(""))
    xh = "0";
  
  try
  {
    database.open();
    
    //�ж��Ƿ��Ѿ�����
    rs = database.query("select * from t_js where mc = '" + mc + "'");
    if (rs.next())
    {
      out.println("<script language='javascript'>");
      out.println("alert('�����Ѿ�����');");
      out.println("</script>");
      
      return;
	 	}

    database.update("insert into t_js(jsid, mc, xh, ymid, zt) values('" + jsid + "', '" + mc + "', '" + xh + "', '" + ymid + "', '" + zt + "')");
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/xitong/js_do.jsp��" + Global.getInstance().getTime() + "��" + e.getMessage());
  }
  finally
  {
    database.close();
  }
  
  out.println("<script language='javascript'>");
  out.println("alert('�������ݳɹ�');");
  out.println("window.parent.work_back();");
  out.println("</script>");
}

if (operate.equals("modify")) //�޸�
{
  String jsid = request.getParameter("jsid");
  String mc = request.getParameter("mc");
  String zt = request.getParameter("zt");
  String ymid = request.getParameter("ymid");
  ResultSet rs = null;
  
  String xh = request.getParameter("xh");
  if (xh.equals(""))
    xh = "0";
  
  try
  {
    database.open();
 
    //�ж��Ƿ��Ѿ�����
    rs = database.query("select * from t_js where mc = '" + mc + "' and jsid != '" + jsid + "'");
    if (rs.next())
    {
      out.println("<script language='javascript'>");
      out.println("alert('�����Ѿ�����');");
      out.println("</script>");
      
      return;
	 	}
 
    database.update("update t_js set mc = '" + mc + "', xh = '" + xh + "', ymid = '" + ymid + "', zt = '" + zt + "' where jsid = '" + jsid + "'");
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/xitong/js_do.jsp��" + Global.getInstance().getTime() + "��" + e.getMessage());
  }
  finally
  {
    database.close();
  }
  
  out.println("<script language='javascript'>");
  out.println("alert('�޸����ݳɹ�');");
  out.println("window.parent.work_back();");
  out.println("</script>");
}

if (operate.equals("delete")) //ɾ��
{
  String jsid = request.getParameter("list");
  
  try
  {
    database.open();
  
 	 	database.update("delete from t_js where jsid = '" + jsid + "'");
 	 	
 	 	database.update("delete from t_js_lm where jsid = '" + jsid + "'");
 	 	
 	 	database.update("delete from t_js_gn where jsid = '" + jsid + "'");
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/xitong/js_do.jsp��" + Global.getInstance().getTime() + "��" + e.getMessage());
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