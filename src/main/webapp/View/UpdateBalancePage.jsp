<%--
  Created by IntelliJ IDEA.
  User: zarti
  Date: 01/08/2023
  Time: 12:46
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>
      Update Balance
    </title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/js/bootstrap.bundle.min.js" integrity="sha384-HwwvtgBNo3bZJJLYd8oVXjrBZt8cqVSpeBNS5n7C8IVInixGAoxmnlMuBnhbgrkm" crossorigin="anonymous"></script>
</head>
<body>

<form action="${pageContext.request.contextPath}/CardManager/updateBalance" method="POST">
  <div class="switch-body">
  <label for="sceltaMovimento">Tipologia operazione:</label><br>
  <input list="movimento" id="sceltaMovimento" name="sceltaMovimento"><br>
  <datalist id="movimento">
    <option value="Accredito">
    <option value="Addebito">
  </datalist>
  <label for="numCarta">Numero Carta:</label><br>
  <input type="text" id="numCarta" name="numCarta"><br>
  <label for="importoMov">Importo:</label><br>

  <input type="text" id="importoMov" name="importoMov"><br>





  <button id="btn-submit" type="submit"> Effettua Operazione</button>
  </div>
</form>



</body>


</html>

