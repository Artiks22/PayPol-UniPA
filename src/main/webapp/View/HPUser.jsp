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
                    <button id="bottoneGenerazione" type="button" class="btn btn-warning"  style="--bs-btn-bg: #e0a800" data-bs-toggle="modal" data-bs-target="#modal1">
                        Vai
                    </button>
                </div>
            </div>
        </div>

        <%-- CARD LISTA CARTE IN POSSESSO --%>
        <div class="col-lg-3 col-md-6 mb-4 mx-auto">
            <div class="card">
                <div class="bg-image hover-overlay ripple" data-mdb-ripple-color="light">
                    <img src="img/Card%20List.jpg" class="img-fluid" />
                    <a href="#!">
                        <div class="mask" style="background-color: rgba(251, 251, 251, 0.15);"></div>
                    </a>
                </div>
                <div class="card-body">
                    <h5 class="card-title">Lista Carte in Possesso</h5>
                    <p class="card-text">
                        Genera la lista di carte ricaricabili in proprio possesso e le varie informazioni ad esse relative.
                    </p>
                    <button id="bottonecheckCarte" type="button" class="btn btn-warning"  style="--bs-btn-bg: #e0a800" data-bs-toggle="modal" data-bs-target="#modal3">
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
                    <button type="button" class="btn btn-warning"  style="--bs-btn-bg: #e0a800" data-bs-toggle="modal" data-bs-target="#modal2">
                        Vai
                    </button>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- MODAL NUMERO 1 -- GENERAZIONE REPORT CARTA  -->
<div class="modal fade" id="modal1">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">Genera Report Transazioni Carte</h4>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <!-- Modal body -->
                <div class="modal-body">
                    <%--                <button type="button" class="btn btn-danger text-white" style="--bs-btn-bg: #dc3545">Genera PDF</button>--%>
<%--                    <button id="bottoneGenerazione" type="button" class="btn btn-warning"  style="--bs-btn-bg: #e0a800" >Genera Report</button>--%>

                    <div id="transactionHistoryDiv">
                        <table id="transactionHistoryTable" class="table table-hover">
                            <thead>
                            <tr>
                                <th scope="col">ID Movimento</th>
                                <th scope="col">Data Movimento</th>
                                <th scope="col">Carta Ricevente</th>
                                <th scope="col">Importo</th>
                            </tr>
                            </thead>
                            <tbody>

                            </tbody>
                        </table>
                    </div>
                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-danger text-white" style="--bs-btn-bg: #dc3545" data-bs-dismiss="modal" onclick="resetFunction()">Chiudi</button>
                </div>

            </div>
        </div>
    </div>


<!-- MODAL NUMERO 2 -- CONTROLLO CREDITO RESIDUO -->
<div class="modal fade" id="modal2">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">Controllo credito residuo</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <!-- Modal body -->
            <div id="divBalance" class="modal-body">
                <form id="formCheckBalance" action="${pageContext.request.contextPath}/CardManager/checkBalance" method="GET" class="form-container">
                    <label for="checkCredito">Numero Carta:</label><br>
                    <input type="text" placeholder="Inserire Num. Carta" id="checkCredito" name="CardCredit"><br><br>
                    <button id="checkBalanceButton" class="btn btn-primary" type="submit"> Effettua Operazione</button>
                </form>
                <br>
                <div id="balanceResult"></div>

            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-danger text-white" style="--bs-btn-bg: #dc3545" data-bs-dismiss="modal" onclick="chiudiFunction()">Chiudi</button>
            </div>

        </div>
    </div>
</div>

<!-- MODAL NUMERO 3 -- GENERAZIONE LISTA CARTE  -->
<div class="modal fade" id="modal3">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">Lista di Carte in Possesso:</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">

                <div id="ListaCarteDiv">
                    <table id="CardListTable" class="table table-hover">
                        <thead>
                        <tr>
                            <th scope="col">Numero Carta</th>
                            <th scope="col">Data Creazione</th>
                            <th scope="col">Data Scadenza</th>
                            <th scope="col">CVV</th>
                        </tr>
                        </thead>
                        <tbody>

                        </tbody>
                    </table>
                </div>
            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-danger text-white" style="--bs-btn-bg: #dc3545" data-bs-dismiss="modal" onclick="resetFunction2()">Chiudi</button>
            </div>

        </div>
    </div>
</div>

    </body>
<script>

    $('#modal1').on('shown.bs.modal', function () {
        $('#myInput').trigger('focus')
    })
    $('#modal2').on('shown.bs.modal', function () {
        $('#myInput').trigger('focus')
    })
    $('#modal3').on('shown.bs.modal', function () {
        $('#myInput').trigger('focus')
    })


    $("#bottoneGenerazione").click(function() {
        $.ajax({
            url: '${pageContext.request.contextPath}/AdminUserManager/getMovements',
            method: "GET",
            dataType: "json",
            success: function(response) {
                if (response.success) {
                    var movements = response.movements;
                    var tableBody = $("#transactionHistoryTable tbody");

                    // Itera attraverso i movimenti e crea le righe della tabella
                    $.each(movements, function(index, movement) {
                        var row = $("<tr>");
                        row.append($("<td>").text(movement.idMovimento));
                        row.append($("<td>").text(movement.dataMovimento));
                        row.append($("<td>").text(movement.cartaRicevente));
                        row.append($("<td>").text(movement.importo));
                        tableBody.append(row);
                    });


                } else {
                    $("#modal1").modal("hide");
                    $('body').removeClass('modal-open');
                    $('.modal-backdrop').remove();
                    var htmlToInsert = `
                          <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <strong>Operazione Fallita!</strong>   ` + response.message +
                        `<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                          </div>`;
                    $("#responseDiv").html(htmlToInsert);
                }
            },
            error: function() {
                console.log("Errore nella richiesta AJAX");
            }
        });
    });


    $("#bottonecheckCarte").click(function() {
        $.ajax({
            url: '${pageContext.request.contextPath}/AdminUserManager/getCards',
            method: "GET",
            dataType: "json",
            success: function(response) {
                if (response.success) {
                    var cards = response.cards;
                    var tableBody = $("#CardListTable tbody");
                    console.log(cards);
                    // Itera attraverso i movimenti e crea le righe della tabella
                    $.each(cards, function(index, carta) {
                        var row = $("<tr>");
                        row.append($("<td>").text(carta.cardNum));
                        row.append($("<td>").text(carta.creationDate));
                        row.append($("<td>").text(carta.expireDate));
                        row.append($("<td>").text(carta.cvv));
                        tableBody.append(row);
                    });


                } else {
                    $("#modal3").modal("hide");
                    $('body').removeClass('modal-open');
                    $('.modal-backdrop').remove();
                    var htmlToInsert = `
                          <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <strong>Operazione Fallita!</strong>   ` + response.message +
                        `<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                          </div>`;
                    $("#responseDiv").html(htmlToInsert);
                }
            },
            error: function() {
                console.log("Errore nella richiesta AJAX");
            }
        });
    });




    $('#formCheckBalance')
        .ajaxForm({
            url : '${pageContext.request.contextPath}/CardManager/checkBalance', // or whatever
            dataType : 'json',
            success : function (response) {

                if (response.success) {

                    var htmlToInsert = `
                          <div class="alert alert-primary alert-dismissible fade show" role="alert"> ` + response.message + `<strong>` + response.value +
                        `<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                          </div>`;
                    $("#balanceResult").html(htmlToInsert);

                } else {
                    // Se success è false, aggiungi un messaggio di errore
                    $("#modal2").modal("hide");
                    $('body').removeClass('modal-open');
                    $('.modal-backdrop').remove();

                    var htmlToInsert = `
                          <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <strong>Operazione Fallita!</strong>   ` + response.message +
                        `<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                          </div>`;
                    $("#responseDiv").html(htmlToInsert);
                }
            },
            error: function(xhr, status, error) {
                console.log("Errore nella richiesta AJAX: " + error);
            }


        });

    function chiudiFunction() {
        $('#balanceResult').empty()
    }
    function resetFunction() {
        $("#transactionHistoryTable tbody").empty()
    }
    function resetFunction2() {
        $("#CardListTable tbody").empty()
    }


</script>
</html>
