<%--
  Created by IntelliJ IDEA.
  User: athakur
  Date: 4/29/20
  Time: 1:20 PM
  To change this template use File | Settings | File Templates.
--%>
<html>
<head><title>A First JSP page</title></head>
<body><h1>JSP example</h1>
<p>
  It is now
  <%= new java.util.Date() %></p>
<p>
<form method=POST>Please enter your age here <input name=age></form>
<%
  int value = 0;
  int target = 21;
  boolean havevalue = false;
  try {
    value = Integer.parseInt(request.getParameter("age"));
    havevalue = true;
  } catch (Exception e) {}

  if (havevalue && (value < 0 || value > 120)) {
    out.println("WARNING - input value is not in range");
  } else if (havevalue)  {
    String word = (value < target) ? "will be " : "were ";
    String word2 = (value < target) ? "from now" : "ago";
    int diff = Math.abs(value-target);
    out.println ("You "+word+target+" ......  "+diff+" years "+word2);
  } else {
%>
You are requested to enter your age in years on this form.
<% } %>
<hr>
<p>You are coming from <%= request.getRequestURI() %></p>
</body>
</html>
