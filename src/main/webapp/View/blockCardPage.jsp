<%--
  Created by IntelliJ IDEA.
  User: zarti
  Date: 03/08/2023
  Time: 16:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Cambia status carta!</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</head>
<body>
<form action="${pageContext.request.contextPath}/CardManager/UpdateStatusCard" method="POST">
    <label for="cardNumber">Inserisci Numero Carta:</label><br>
    <input type="text" id="cardNumber" name="cardNumber"><br>
    <label for="movimento">Scegli l'operazione:</label><br>
    <input list="operation" name="movimento" id="movimento"><br>
    <datalist id="operation">
        <option value="Blocca">
        <option value="Sblocca">
    </datalist>
    <button type="submit" id="btn-submit">Effettua Operazione</button>
</form>
</body>
</html>
