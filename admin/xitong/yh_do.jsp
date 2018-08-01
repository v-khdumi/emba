<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Encrypt" %>
<%@ page import="xcflow.Log" %>

<%
//�û�����_ά��
String operate = request.getParameter("operate");

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));
  
if (operate.equals("add")) //����
{
  String yhid = Global.getInstance().getYear() + Global.getInstance().getMonth() + Global.getInstance().getDay() + Global.getInstance().getHour() + Global.getInstance().getMinute() + Global.getInstance().getSecond();
  String mc = request.getParameter("mc");
  String dm = request.getParameter("dm");
  String mm = Encrypt.getInstance().getEncString(request.getParameter("mm"));
  String jsid = request.getParameter("jsid");
  String zt = request.getParameter("zt");
  ResultSet rs = null;
  
  try
  {
    database.open();
    
    //�ж��Ƿ��Ѿ�����
    rs = database.query("select * from t_yh where dm = '" + dm + "'");
    if (rs.next())
    {
      out.println("<script language='javascript'>");
      out.println("alert('�����Ѿ�����');");
      out.println("</script>");
      
      return;
	 	}
    
    database.update("insert into t_yh(yhid, mc, dm, mm, jsid, zt) values('" + yhid + "', '" + mc + "', '" + dm + "', '" + mm + "', '" + jsid + "', '" + zt + "')");
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/yonghu/yh_do.jsp��" + Global.getInstance().getTime() + "��" + e.getMessage());
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
  String yhid = request.getParameter("yhid");
  String mc = request.getParameter("mc");
  String mm = Encrypt.getInstance().getEncString(request.getParameter("mm"));
  String dm = request.getParameter("dm");
  String jsid = request.getParameter("jsid");
  String zt = request.getParameter("zt");
  ResultSet rs = null;
  
  try
  {
    database.open();
 
    //�ж��Ƿ��Ѿ�����
    rs = database.query("select * from t_yh where dm = '" + dm + "' and yhid != '" + yhid + "'");
    if (rs.next())
    {
      out.println("<script language='javascript'>");
      out.println("alert('�����Ѿ�����');");
      out.println("</script>");
      
      return;
	 	}
 
    database.update("update t_yh set mc = '" + mc + "', mm = '" + mm + "', dm = '" + dm + "', jsid = '" + jsid + "', zt = '" + zt + "' where yhid = '" + yhid + "'");
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/yonghu/yh_do.jsp��" + Global.getInstance().getTime() + "��" + e.getMessage());
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
  String yhid = request.getParameter("list");
  
  try
  {
    database.open();
  
 	 	database.update("delete from t_yh where yhid = '" + yhid + "'");
 	 	
 	 	database.update("delete from t_yh_gn where yhid = '" + yhid + "'");
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/yonghu/yh_do.jsp��" + Global.getInstance().getTime() + "��" + e.getMessage());
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