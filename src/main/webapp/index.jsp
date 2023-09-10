<%@ page import="Model.Utente" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>PayPol HomePage</title>
  <%--  Boostrap components --%>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" type="text/css" />
  <link rel="stylesheet" href="path/to/font-awesome/css/font-awesome.min.css">
  <%--  Jquery--%>
  <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
  <script src="https://malsup.github.io/jquery.form.js"></script>


<%--  style--%>
  <!-- Font Awesome -->
  <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.11.2/css/all.css" />
  <!-- Google Fonts Roboto -->
  <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&display=swap" />

</head>
<body>

<div class="">
  <% session = request.getSession(false);
//  String userType = request.getParameter("userType");
//    System.out.println(userType);

  if (session.getAttribute("currentSessionUser") != null) {
  %>
  <jsp:include page="/View/components/navbarlogged.jsp"></jsp:include> <% } else { %>
  <jsp:include page="/View/components/navbar.jsp"></jsp:include> <% } %>
</div>

<header>
  <style>
    #intro {
      background-image: url("https://mdbootstrap.com/img/new/fluid/city/018.jpg");
      background-repeat:no-repeat;

      background-size:cover;
      /*height: auto;*/

    }


  </style>

  <!-- Background image -->
  <div id="intro" class=" bg-image shadow-2-strong">
    <div class="mask" style="background-color: rgba(0, 0, 0, 0.8);">
      <div class="container d-flex align-items-center  justify-content-center text-center h-100">
        <div class="text-white align-items-center">

<%--BOTTONE DINAMICO PER RITORNARE ALLA HOMEPAGE DELL'UTENTE PERSONALE--%>
  <%
    Utente utente = (Utente) session.getAttribute("currentSessionUser");
    if (utente != null) {
      int userType = utente.getUserType();
      if (userType == 1) {
  %>
  <br><a href="/PayPol/View/HPUser.jsp">
    <button class="btn btn-outline-light">HomePage Personale</button>
  </a>
  <%
  } else if (userType == 2) {
  %>
  <br><a href="/PayPol/View/HPSeller.jsp">
    <button class="btn btn-outline-light">HomePage Personale</button>
  </a>
  <%
  } else if (userType == 3) {
  %>
  <br><a href="/PayPol/View/HPAdmin.jsp">
    <button class="btn btn-outline-light">HomePage Personale</button>
  </a>
  <%
      }
    }
  %>



          <h1 class="pt-5 mb-3">Benvenuto in PayPol!</h1>
          <h5 class="mb-4">Si tratta di un progetto Universitario, oggetto di esame della materia <i>Web systems design and architecture</i> </h5>
          <a href="https://www.unipa.it/persone/docenti/l/marco.lacascia/?pagina=insegnamento&idInsegnamento=148534&idCattedra=142870" target="_blank"><button class="btn btn-outline-light ">Link Insegnamento</button></a><br>
          <br><br><h6>Il progetto di quest'anno (2022/2023) prevedeva lo sviluppo di una semplice web application avente lo scopo di simulare la gestione di carte di credito prepagate. </h6><br><br><br>


          <div>
          <ul class="list-group">
            <li class="list-group-item active"><strong> Funzioni base:</strong>  <i>(Più funzioni opzionali in italic)</i> </li>
            <li class="list-group-item"><strong>Chiunque:</strong><br>
              Accedere a una pagina che controlla il credito residuo di una carta noto il numero <i class="bi bi-check2"></i><br>
              <i>Generare report con le operazioni fatte</i> <i class="bi bi-check2"></i><br>
              <i>Generare report con la lista delle carte in possesso (Non richiesto da consegna)</i> <i class="bi bi-check2"></i></li>
            <li class="list-group-item"><strong>Negoziante:</strong><br>
              Accedere a una pagina in cui può fare un addebito o una ricarica su una carta noto il numero <i class="bi bi-check2"></i><br>
              <i>Generare report con le operazioni fatte</i> <i class="bi bi-check2"></i>
            </li>
            <li class="list-group-item"><strong>Admin:</strong><br>
              Creare una nuova carta <i class="bi bi-check2"></i><br>
              Bloccare/sbloccare una carta noto il numero <i class="bi bi-check2"></i><br>
            <i>Registrare/Disabilitare negozianti </i><i class="bi bi-check2"></i><br>
              <i>Generare report in base a diversi criteri </i><br>
              <i>Abilitare/Disabilitare negozianti <i class="bi bi-check2"></i></i>
            </li>
          </ul>
        </div>
          <br><br><br><br><br><br><br><br><br>
          </div>
        </div>

      </div>
    </div>

</header>



<footer id="sticky-footer" class="flex-shrink-0 py-4 bg-dark text-white-50">
  <div class="container text-center">
    <small>Progetto a cura di <a target="_blank" href="http://www.linkedin.com/in/andreavittorio-calabrese"> <strong>Andrea Vittorio Calabrese</strong> </a> <i>(Mat. 0739241) </i> </small>
  </div>
</footer>
</body>
</html>