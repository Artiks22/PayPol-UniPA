<%--
  Created by IntelliJ IDEA.
  User: zarti
  Date: 07/08/2023
  Time: 16:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Benvenuto Negoziante</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</head>
<body>
<jsp:include page="/View/components/navbar.jsp"></jsp:include>
<h1>Funzioni Negoziante</h1><br>

<a href="${pageContext.request.contextPath}/AdminUserManager/getMovements">Ottieni transaction History!</a><br>
<a href="${pageContext.request.contextPath}/AuthenticationManager/logout">Logout</a><br>

</body>
</html>
