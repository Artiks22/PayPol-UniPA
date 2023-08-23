<%--
  Created by IntelliJ IDEA.
  User: zarti
  Date: 02/08/2023
  Time: 15:42
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Creazione Carta!</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</head>
<body>
<form action="${pageContext.request.contextPath}/CardManager/CreateCard" method="POST">
    <label for="email">Inserire email:</label><br>
    <input type="text" name="email" id="email"><br>
    <label for="valore">Inserire credito creazione carta:</label><br>
    <input type="text" name="valore" id="valore"><br>
    <button type="submit">Crea carta</button>
</form>
</body>
</html>
