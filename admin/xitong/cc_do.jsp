<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
//�ִ�����_ά��
String operate = request.getParameter("operate");

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));
  
if (operate.equals("add")) //����
{
  String hwid = Global.getInstance().getYear() + Global.getInstance().getMonth() + Global.getInstance().getDay() + Global.getInstance().getHour() + Global.getInstance().getMinute() + Global.getInstance().getSecond();
  String hwmc = request.getParameter("hwmc");
  String sl = request.getParameter("sl");  
  ResultSet rs = null;
  
  String bh = request.getParameter("bh");
  if (bh.equals(""))
    bh = "0";
  
  try
  {
	  
    database.open();
		
    
    //�ж��Ƿ��Ѿ�����
    rs = database.query("select * from t_cc where hwmc = '" + hwmc + "'");
    if (rs.next())
    {
      out.println("<script language='javascript'>");
      out.println("alert('�����Ѿ�����');");
      out.println("</script>");
      
      return;
	 	}

    database.update("insert into t_cc(hwid, hwmc, bh, sl) values('" + hwid + "', '" + hwmc + "', '" + bh + "', '" + sl + "')");
	
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/xitong/cc_do.jsp��" + Global.getInstance().getTime() + "��" + e.getMessage());
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
  String hwid = request.getParameter("hwid");
  String hwmc = request.getParameter("hwmc");
  String sl = request.getParameter("sl");
  ResultSet rs = null;
  
  String bh = request.getParameter("bh");
  if (bh.equals(""))
    bh = "0";
  
  try
  {
    database.open();
 
    //�ж��Ƿ��Ѿ�����
    rs = database.query("select * from t_cc where hwmc = '" + hwmc + "' and hwid != '" + hwid + "'");
    if (rs.next())
    {
      out.println("<script language='javascript'>");
      out.println("alert('�����Ѿ�����');");
      out.println("</script>");
      
      return;
	 	}
 
    database.update("update t_cc set hwmc = '" + hwmc + "', bh = '" + bh + "', sl = '" + sl + "' where hwid = '" + hwid + "'");
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/xitong/cc_do.jsp��" + Global.getInstance().getTime() + "��" + e.getMessage());
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
  String hwid = request.getParameter("list");
  ResultSet rs = null;
  
  try
  {
    database.open();
  
    //�ж��Ƿ���ģ��
    rs = database.query("select * from t_mk where hwid = '" + hwid + "'");
    if (rs.next())
    {
      out.println("<script language='javascript'>");
      out.println("alert('�ð�ʽ����ģ�飬����ɾ��');");
      out.println("</script>");
      
      return;
	 	}
	 	
    database.update("delete from t_cc where hwid = '" + hwid + "'");
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/xitong/cc_do.jsp��" + Global.getInstance().getTime() + "��" + e.getMessage());
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