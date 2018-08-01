<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Log" %>

<%
//���ܹ���_ά��
String operate = request.getParameter("operate");

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));
  
if (operate.equals("add")) //����
{
  String gnid = Global.getInstance().getYear() + Global.getInstance().getMonth() + Global.getInstance().getDay() + Global.getInstance().getHour() + Global.getInstance().getMinute() + Global.getInstance().getSecond();
  String mc = request.getParameter("mc");
  String ms = request.getParameter("ms");
  String wj = request.getParameter("wj");
  String mkid = request.getParameter("mkid");
  String zt = request.getParameter("zt");  
  ResultSet rs = null;
  
  String xh = request.getParameter("xh");
  if (xh.equals(""))
    xh = "0";
  
  try
  {
    database.open();
    
    database.update("insert into t_gn(gnid, mc, ms, wj, mkid, xh, zt) values('" + gnid + "', '" + mc + "', '" + ms + "', '" + wj + "', '" + mkid + "', '" + xh + "', '" + zt + "')");
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/xitong/gn_do.jsp��" + Global.getInstance().getTime() + "��" + e.getMessage());
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
  String gnid = request.getParameter("gnid");
  String mc = request.getParameter("mc");
  String ms = request.getParameter("ms");
  String wj = request.getParameter("wj");
  String mkid = request.getParameter("mkid");
  String zt = request.getParameter("zt");
  ResultSet rs = null;
  
  String xh = request.getParameter("xh");
  if (xh.equals(""))
    xh = "0";
  
  try
  {
    database.open();
    
    database.update("update t_gn set mc = '" + mc + "', ms = '" + ms + "', wj = '" + wj + "', mkid = '" + mkid + "', xh = '" + xh + "', zt = '" + zt + "' where gnid = '" + gnid + "'");
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/xitong/gn_do.jsp��" + Global.getInstance().getTime() + "��" + e.getMessage());
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
  String gnid = request.getParameter("list");
  
  try
  {
    database.open();

    database.update("delete from t_gn where gnid = '" + gnid + "'");
    
    database.update("delete from t_js_gn where gnid = '" + gnid + "'");
    
    database.update("delete from t_yh_gn where gnid = '" + gnid + "'");
  }
  catch (Exception e)
  {
    (new Log()).log("error", "admin/xitong/gn_do.jsp��" + Global.getInstance().getTime() + "��" + e.getMessage());
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