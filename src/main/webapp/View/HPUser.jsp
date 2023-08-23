<%--
  Created by IntelliJ IDEA.
  User: zarti
  Date: 01/08/2023
  Time: 11:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Utente</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
    <jsp:include page="/View/Styles/styletest.jsp"></jsp:include>
</head>
<body>
<h1>Funzioni Utente</h1>
<!-- A button to open the popup form -->

<a href="${pageContext.request.contextPath}/AuthenticationManager/logout">Logout</a><br>
<button class="open-button" onclick="openForm()">Open Form</button>

<!-- The form -->
<div class="form-popup" id="myForm">

        <form action="${pageContext.request.contextPath}/CardManager/checkBalance" method="GET" class="form-container">
            <h1>Controllo Credito Residuo!</h1>
            <label for="checkCredito">Numero Carta</label>
            <input type="text" placeholder="Inserire Num. Carta" id="checkCredito" name="CardCredit"><br>
            <button id="btn-submit" type="submit"  class="btn"> Check Credito</button>
            <button type="button" class="btn cancel" onclick="closeForm()">Close</button>
        </form>

</div>

</body>
<script>
    function openForm() {
        document.getElementById("myForm").style.display = "block";
    }

    function closeForm() {
        document.getElementById("myForm").style.display = "none";
    }
</script>
</html>
