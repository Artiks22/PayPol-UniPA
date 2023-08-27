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
    <title>Benvenuto Utente</title>
    <%--  Boostrap components --%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" type="text/css" />

    <%--  Jquery--%>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
    <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
    <script src="https://malsup.github.io/jquery.form.js"></script>
</head>
<body>

<div class="pb-5">
    <jsp:include page="/View/components/navbarlogged.jsp"></jsp:include>
</div>

<section class="text-center">
    <h3 class="mb-5"><strong>Funzionalità Utente</strong></h3>



    <div class="row mt-2">
        <%--DIV CONTENTENTE L'ALERT RIGUARDANTE L'OPERAZIONE RIUSCITA CON SUCCESSO O MENO--%>
        <div id="responseDiv"></div>

        <%--ADDEBITO O ACCREDITO FUNCTION--%>
        <div class="col-lg-3 col-md-12 mb-4  mx-auto">
            <div class="card">
                <div class="bg-image hover-overlay ripple" data-mdb-ripple-color="light">
                    <img src="img/addebitoaccredito.jpg" class="img-fluid" />
                    <a href="#!">
                        <div class="mask" style="background-color: rgba(251, 251, 251, 0.15);"></div>
                    </a>
                </div>
                <div class="card-body">
                    <h5 class="card-title">Accredito / Addebito Carta</h5>
                    <p class="card-text">
                        Effettuare accredito o addebito su carta di credito.
                    </p>
                    <button type="button" class="btn btn-warning"  style="--bs-btn-bg: #e0a800" data-bs-toggle="modal" data-bs-target="#modal1">
                        Vai
                    </button>
                </div>
            </div>
        </div>
        <%--GENERAZIONE REPORT CON LE OPERAZIONI FATTE--%>
        <div class="col-lg-3 col-md-6 mb-4 mx-auto">
            <div class="card">
                <div class="bg-image hover-overlay ripple" data-mdb-ripple-color="light">
                    <img src="img/Transaction%20History.jpg" class="img-fluid" />
                    <a href="#!">
                        <div class="mask" style="background-color: rgba(251, 251, 251, 0.15);"></div>
                    </a>
                </div>
                <div class="card-body">
                    <h5 class="card-title">Generazione Report Operazioni</h5>
                    <p class="card-text">
                        Genera un report delle operazioni contenente accrediti e addebiti delle proprie carte.
                    </p>
                    <button type="button" class="btn btn-warning"  style="--bs-btn-bg: #e0a800" data-bs-toggle="modal" data-bs-target="#modal2">
                        Vai
                    </button>
                </div>
            </div>
        </div>

        <%--CHECK BALANCE FUNCTIONALITY--%>
        <div class="col-lg-3 col-md-6 mb-4 mx-auto">
            <div class="card">
                <div class="bg-image hover-overlay ripple" data-mdb-ripple-color="light">
                    <img src="img/card%20balance.jpg" class="img-fluid" />
                    <a href="#!">
                        <div class="mask" style="background-color: rgba(251, 251, 251, 0.15);"></div>
                    </a>
                </div>
                <div class="card-body">
                    <h5 class="card-title">Controllo Credito Residuo</h5>
                    <p class="card-text">
                        Controlla credito residuo su Carta di Credito
                    </p>
                    <button type="button" class="btn btn-warning"  style="--bs-btn-bg: #e0a800" data-bs-toggle="modal" data-bs-target="#modal3">
                        Vai
                    </button>
                </div>
            </div>
        </div>
    </div>
</section>



</body>
<script>

</script>
</html>
