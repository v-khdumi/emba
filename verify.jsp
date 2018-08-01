<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Encrypt" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Xml" %>
<%@ page import="xcflow.Log" %>

<%
//��¼��֤
String user = request.getParameter("user");
String password = request.getParameter("password");
String success = "false";
String system_name = "";
String system_right = "";
String system_service = "";
String system_year = "";
String system_version = "";
String system_database = "";
ResultSet rs = null;
Properties p = new Properties();
String message = null;

Global.getInstance().setPath(session.getServletContext().getRealPath(""));

try
{

  Xml xml = new Xml(Global.getInstance().getPath() + "/WEB-INF/config.xml");
  system_name = xml.select("/config/system/name");
  system_right = xml.select("/config/system/right");
  system_service = xml.select("/config/system/service");
  system_year = xml.select("/config/system/year");
  system_version = xml.select("/config/system/version");
  system_database = xml.select("/config/system/database");
}
catch (Exception e)
{
  (new Log()).log("error", "verify.jsp��" + Global.getInstance().getTime() + "��" + e.getMessage());
}

Database database = new Database(system_database);

try
{
	
  database.open();
	
  rs = database.query("select * from t_yh where dm = '" + user + "'");
 
  if (rs.next())
  {
    if (rs.getString("mm").equals(Encrypt.getInstance().getEncString(password)))
    {
      success = "true";
	
      p.setProperty("yhid", rs.getString("yhid")); //�û�ID
      p.setProperty("yhdm", user); //�û�����
      p.setProperty("yhmc", rs.getString("mc")); //�û�����
      p.setProperty("jsid", rs.getString("jsid")); //��ɫID
      p.setProperty("system", system_name); //ϵͳ����
      p.setProperty("right", system_right); //��Ȩ����
      p.setProperty("service", system_service); //����֧��
      p.setProperty("year", system_year); //ʹ�����
      p.setProperty("version", system_version); //ϵͳ�汾
      p.setProperty("database", system_database); //Ĭ�����ݿ�
      database.update("insert into t_rz(yhdm, rq, sj, nr, lx, ip) values('" + user + "', '" + Global.getInstance().getDate() + "', '" + Global.getInstance().getTime() + "', '��¼ϵͳ�ɹ�', '1', '" + request.getRemoteAddr() + "')");
    }
    else
    {
      message = "�˺������벻ƥ��";
      
      database.update("insert into t_rz(yhdm, rq, sj, nr, lx, ip) values('" + user + "', '" + Global.getInstance().getDate() + "', '" + Global.getInstance().getTime() + "', '��¼�������', '1', '" + request.getRemoteAddr() + "')");
    }
  }
  else
  {
    message = "��¼�û�������";
  
    database.update("insert into t_rz(yhdm, rq, sj, nr, lx, ip) values('" + user + "', '" + Global.getInstance().getDate() + "', '" + Global.getInstance().getTime() + "', '��¼�û�������', '1', '" + request.getRemoteAddr() + "')");
  }
}
catch (Exception e)
{
  (new Log()).log("error", "verify.jsp��" + Global.getInstance().getTime() + "��" + e.getMessage());
}
finally
{
  database.close();
}

if (success.equals("false"))
{
  request.setAttribute("message", message);
  request.getRequestDispatcher("login.jsp").forward(request, response);
}

if (success.equals("true"))
{
  session.setAttribute("global", p);
  //session.setMaxInactiveInterval(60 * 30); //�Ự��ʱ30����
  session.setMaxInactiveInterval(60 * 60 * 24); //�Ự��ʱ24Сʱ
  
  response.sendRedirect("admin/admin.jsp");
}
%>