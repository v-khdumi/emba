<%@ page contentType="text/html;charset=gb2312" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page import="xcflow.Global" %>
<%@ page import="xcflow.Database" %>
<%@ page import="xcflow.Encrypt" %>
<%@ page import="xcflow.Log" %>

<%
//�޸�����ά��
String password_old = request.getParameter("password_old");
String password_new = request.getParameter("password_new");
String dm = ((Properties) session.getAttribute("global")).getProperty("yhdm");
ResultSet rs = null;
String message = "";

Database database = new Database(((Properties) session.getAttribute("global")).getProperty("database"));

try
{
  database.open();

  //�жϾ������Ƿ���ȷ
  rs = database.query("select * from t_yh where dm = '" + dm + "' and mm = '" + Encrypt.getInstance().getEncString(password_old) + "'");
  if (! rs.next())
  {
    request.setAttribute("message", "�ɵ����벻��ȷ");
    request.getRequestDispatcher("message.jsp").forward(request, response);
    return;
 	}

  database.update("update t_yh set mm = '" + Encrypt.getInstance().getEncString(password_new) + "' where dm = '" + dm + "'");

  message = "�޸�����ɹ�";
}
catch (Exception e)
{
  (new Log()).log("error", "admin/password_do.jsp��" + Global.getInstance().getTime() + "��" + e.getMessage());
}
finally
{
  database.close();
}

request.setAttribute("message", message);
request.getRequestDispatcher("message.jsp").forward(request, response);
%>