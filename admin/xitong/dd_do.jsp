<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
//��������_ά��
String operate = request.getParameter("operate");

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));
  
if (operate.equals("add")) //����
{
  String ddid = Global.getInstance().getYear() + Global.getInstance().getMonth() + Global.getInstance().getDay() + Global.getInstance().getHour() + Global.getInstance().getMinute() + Global.getInstance().getSecond();
  String dd = request.getParameter("dd");
  String ddrq = request.getParameter("ddrq");  
  ResultSet rs = null;
  
  String dddz = request.getParameter("dddz");
  
  
  try
  {
	  
    database.open();
		
  		
    //�ж��Ƿ��Ѿ�����
    rs = database.query("select * from t_dd where dd = '" + dd + "'");
    if (rs.next())
    {
      out.println("<script language='javascript'>");
      out.println("alert('�����Ѿ�����');");
      out.println("</script>");
      
      return;
	 	}

    database.update("insert into t_dd(ddid, dd, dddz, ddrq) values('" + ddid + "', '" + dd + "', '" + dddz + "', '" + ddrq + "')");
	
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/xitong/dd_do.jsp��" + Global.getInstance().getTime() + "��" + e.getMessage());
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
  String ddid = request.getParameter("ddid");
  String dd = request.getParameter("dd");
  String ddrq = request.getParameter("ddrq");
  ResultSet rs = null;
  
  String dddz = request.getParameter("dddz");
  
  try
  {
    database.open();
 
    //�ж��Ƿ��Ѿ�����
    rs = database.query("select * from t_dd where dd = '" + dd + "' and ddid != '" + ddid + "'");
    if (rs.next())
    {
      out.println("<script language='javascript'>");
      out.println("alert('�����Ѿ�����');");
      out.println("</script>");
      
      return;
	 	}
 
    database.update("update t_dd set dd = '" + dd + "', dddz = '" + dddz + "', ddrq = '" + ddrq + "' where ddid = '" + ddid + "'");
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/xitong/dd_do.jsp��" + Global.getInstance().getTime() + "��" + e.getMessage());
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
  String ddid = request.getParameter("list");
  ResultSet rs = null;
  
  try
  {
    database.open();
  
    //�ж��Ƿ���ģ��
    rs = database.query("select * from t_mk where ddid = '" + ddid + "'");
    if (rs.next())
    {
      out.println("<script language='javascript'>");
      out.println("alert('�ð�ʽ����ģ�飬����ɾ��');");
      out.println("</script>");
      
      return;
	 	}
	 	
    database.update("delete from t_dd where ddid = '" + ddid + "'");
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/xitong/dd_do.jsp��" + Global.getInstance().getTime() + "��" + e.getMessage());
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