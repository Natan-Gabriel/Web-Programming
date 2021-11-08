<%--
  Created by IntelliJ IDEA.
  User: forest
  Date: 5/17/2018
  Time: 7:43 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
  <head>
    <title>$Title$</title>
  </head>
  <body>
  <%
    response.addHeader("Cache-Control", "no-cache,no-store,private,must-revalidate,max-stale=0,post-check=0,pre-check=0");
    if (session.getAttribute("user") == null) {
      response.sendRedirect("index.html");
    }
    /*response.addHeader("Pragma", "no-cache");
    response.addDateHeader ("Expires", 0);*/
  %>
  <form action="LoginController" method="post">
    Enter username : <input type="text" name="username"> <BR>
    Enter password : <input type="password" name="password"> <BR>
    <input type="submit" value="Login"/>
  </form>
  $END$
  </body>
</html>
