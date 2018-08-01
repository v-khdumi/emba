<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
//��ʽ����_ά��
String operate = request.getParameter("operate");

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));
  
if (operate.equals("add")) //����
{
  String bsid = Global.getInstance().getYear() + Global.getInstance().getMonth() + Global.getInstance().getDay() + Global.getInstance().getHour() + Global.getInstance().getMinute() + Global.getInstance().getSecond();
  String mc = request.getParameter("mc");
  String zt = request.getParameter("zt");  
  ResultSet rs = null;
  
  String xh = request.getParameter("xh");
  if (xh.equals(""))
    xh = "0";
  
  try
  {
    database.open();
    
    //�ж��Ƿ��Ѿ�����
    rs = database.query("select * from t_bs where mc = '" + mc + "'");
    if (rs.next())
    {
      out.println("<script language='javascript'>");
      out.println("alert('�����Ѿ�����');");
      out.println("</script>");
      
      return;
	 	}
    
    database.update("insert into t_bs(bsid, mc, xh, zt) values('" + bsid + "', '" + mc + "', '" + xh + "', '" + zt + "')");
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/xitong/bs_do.jsp��" + Global.getInstance().getTime() + "��" + e.getMessage());
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
  String bsid = request.getParameter("bsid");
  String mc = request.getParameter("mc");
  String zt = request.getParameter("zt");
  ResultSet rs = null;
  
  String xh = request.getParameter("xh");
  if (xh.equals(""))
    xh = "0";
  
  try
  {
    database.open();
 
    //�ж��Ƿ��Ѿ�����
    rs = database.query("select * from t_bs where mc = '" + mc + "' and bsid != '" + bsid + "'");
    if (rs.next())
    {
      out.println("<script language='javascript'>");
      out.println("alert('�����Ѿ�����');");
      out.println("</script>");
      
      return;
	 	}
 
    database.update("update t_bs set mc = '" + mc + "', xh = '" + xh + "', zt = '" + zt + "' where bsid = '" + bsid + "'");
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/xitong/bs_do.jsp��" + Global.getInstance().getTime() + "��" + e.getMessage());
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
  String bsid = request.getParameter("list");
  ResultSet rs = null;
  
  try
  {
    database.open();
  
    //�ж��Ƿ���ģ��
    rs = database.query("select * from t_mk where bsid = '" + bsid + "'");
    if (rs.next())
    {
      out.println("<script language='javascript'>");
      out.println("alert('�ð�ʽ����ģ�飬����ɾ��');");
      out.println("</script>");
      
      return;
	 	}
	 	
    database.update("delete from t_bs where bsid = '" + bsid + "'");
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/xitong/bs_do.jsp��" + Global.getInstance().getTime() + "��" + e.getMessage());
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