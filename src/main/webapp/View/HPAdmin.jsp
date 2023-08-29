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
    <title>HomePage Admin</title>
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
    <h3 class="mb-5"><strong>Funzionalità Admin</strong></h3>



    <div class="row mt-2">
<%--DIV CONTENTENTE L'ALERT RIGUARDANTE L'OPERAZIONE RIUSCITA CON SUCCESSO O MENO--%>
        <div id="responseDiv"></div>

        <%--CREAZIONE DI CARTA FUNCTIONALITY--%>
        <div class="col-lg-3 col-md-12 mb-4  mx-auto">
                        <div class="card">
                <div class="bg-image hover-overlay ripple" data-mdb-ripple-color="light">
                    <img src="img/card%20creazionecarta.jpg" class="img-fluid" />
                    <a href="#!">
                        <div class="mask" style="background-color: rgba(251, 251, 251, 0.15);"></div>
                    </a>
                </div>
                <div class="card-body">
                    <h5 class="card-title">Crea Nuova Carta</h5>
                    <p class="card-text">
                        Registra una nuova Carta di Credito per conto di un cliente.
                    </p>
                    <button type="button" class="btn btn-warning"  style="--bs-btn-bg: #e0a800" data-bs-toggle="modal" data-bs-target="#modal1">
                        Vai
                    </button>
                </div>
            </div>
        </div>
            <%--BLOCCARE/SBLOCCARE CARTA FUNCTIONALITY--%>
        <div class="col-lg-3 col-md-6 mb-4 mx-auto">
            <div class="card">
                <div class="bg-image hover-overlay ripple" data-mdb-ripple-color="light">
                    <img src="img/card%20bloccasblocca.jpg" class="img-fluid" />
                    <a href="#!">
                        <div class="mask" style="background-color: rgba(251, 251, 251, 0.15);"></div>
                    </a>
                </div>
                <div class="card-body">
                    <h5 class="card-title">Gestione Carta</h5>
                    <p class="card-text">
                        Sblocca o Blocca una data Carta di Credito.
                    </p>
                    <button type="button" class="btn btn-warning"  style="--bs-btn-bg: #e0a800" data-bs-toggle="modal" data-bs-target="#modal2">
                        Vai
                    </button>
                </div>
            </div>
        </div>

    <%--BLOCCARE/SBLOCCARE SELLER FUNCTIONALITY--%>
    <div class="col-lg-3 col-md-6 mb-4 mx-auto">
        <div class="card">
            <div class="bg-image hover-overlay ripple" data-mdb-ripple-color="light">
                <img src="img/card%20bloccasbloccamerch.jpg" class="img-fluid" />
                <a href="#!">
                    <div class="mask" style="background-color: rgba(251, 251, 251, 0.15);"></div>
                </a>
            </div>
            <div class="card-body">
                <h5 class="card-title">Gestione Venditori</h5>
                <p class="card-text">
                    Sblocca o Blocca una dato Venditore.
                </p>
                <button type="button" class="btn btn-warning"  style="--bs-btn-bg: #e0a800" data-bs-toggle="modal" data-bs-target="#modal4">
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



<!-- MODAL NUMERO 1 -- CREAZIONE CARTA -->
<div class="modal fade" id="modal1">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">Creazione Carta di Credito</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
                <form id="formCreazione" action="${pageContext.request.contextPath}/CardManager/CreateCard" method="POST">
                    <label for="email">Inserire Email:</label><br>
                    <input type="text" name="email" id="email"><br>
                    <label for="valore">Inserire credito iniziale carta:</label><br>
                    <input type="text" name="valore" id="valore"><br><br>
                    <button id="createCardButton" class="btn btn-primary" type="submit" data-bs-dismiss="modal" > Crea carta</button>
                </form>
            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-danger text-white" style="--bs-btn-bg: #dc3545" data-bs-dismiss="modal">Chiudi</button>
            </div>

        </div>
    </div>
</div>

<!-- MODAL NUMERO 2 -- BLOCCO SBLOCCO CARTA -->
<div class="modal fade" id="modal2">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">Creazione Carta di Credito</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
                <form id="formUpdateStatus" action="${pageContext.request.contextPath}/CardManager/UpdateStatusCard" method="POST">
                    <label for="cardNumber">Inserisci Numero Carta:</label><br>
                    <input type="text" id="cardNumber" name="cardNumber"><br>
                    <label for="movimento">Operazione:</label><br>
<%--                    <input list="operation" name="movimento" id="movimento">--%>
                    <input class="form-control" list="operation" id="movimento" name="movimento" placeholder="Scegli operazione fra Blocco o Sblocco"><br>
                    <datalist id="operation">
                        <option value="Blocca">
                        <option value="Sblocca">
                    </datalist>
                    <button id="blockUnblockButton" class="btn btn-primary" type="submit" data-bs-dismiss="modal"> Effettua Operazione</button>
                </form>
            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-danger text-white" style="--bs-btn-bg: #dc3545" data-bs-dismiss="modal">Chiudi</button>
            </div>

        </div>
    </div>
</div>

<!-- MODAL NUMERO 3 -- CONTROLLO CREDITO RESIDUO -->
<div class="modal fade" id="modal3">
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
                    <button id="checkBalanceButton" class="btn btn-primary" type="submit" > Effettua Operazione</button>
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

<!-- MODAL NUMERO 4 -- BLOCCO SBLOCCO VENDITORI -->
<div class="modal fade" id="modal4">
    <div class="modal-dialog modal-dialog-centered" role="document">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title">Creazione Carta di Credito</h4>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
                <form id="formUpdateStatusMerch" action="${pageContext.request.contextPath}/AdminUserManager/modifyStatus" method="POST">
                    <label for="emailSeller">Inserisci Email Venditore:</label><br>
                    <input type="text" id="emailSeller" name="emailSeller"><br>
                    <label for="movimento">Operazione:</label><br>
                    <%--                    <input list="operation" name="movimento" id="movimento">--%>
                    <input class="form-control" list="operation" id="movimento" name="movimento" placeholder="Scegli operazione fra Blocco o Sblocco"><br>
                    <datalist id="operation">
                        <option value="Blocca">
                        <option value="Sblocca">
                    </datalist>
                    <button id="blockUnblockButton" class="btn btn-primary" type="submit" data-bs-dismiss="modal"> Effettua Operazione</button>
                </form>
            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button type="button" class="btn btn-danger text-white" style="--bs-btn-bg: #dc3545" data-bs-dismiss="modal">Chiudi</button>
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
    $('#modal4').on('shown.bs.modal', function () {
        $('#myInput').trigger('focus')
    })

    $('#formCreazione')
        .ajaxForm({
            url : '${pageContext.request.contextPath}/CardManager/CreateCard', // or whatever
            dataType : 'json',
            success : function (response) {

                if (response.success) {
                    // Se success è true, inserisci l'alert all'interno del messaggio.
                    var htmlToInsert = `
                          <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <strong>Operazione Eseguita con successo!</strong>   ` + response.message +
                            `<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                          </div>`;
                    $("#responseDiv").html(htmlToInsert);

                } else {
                    // Se success è false, aggiungi un messaggio di errore
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

    $('#formUpdateStatus')
        .ajaxForm({
            url : '${pageContext.request.contextPath}/CardManager/UpdateStatusCard', // or whatever
            dataType : 'json',
            success : function (response) {

                if (response.success) {
                    // Se success è true, inserisci l'alert all'interno del messaggio.
                    var htmlToInsert = `
                          <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <strong>Operazione Eseguita con successo!</strong>   ` + response.message +
                        `<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                          </div>`;
                    $("#responseDiv").html(htmlToInsert);

                } else {
                    // Se success è false, aggiungi un messaggio di errore
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
            error: function(xhr, status, error) {
                console.log("Errore nella richiesta AJAX: " + error);
            }


        });

    $('#formUpdateStatusMerch')
        .ajaxForm({
            url : '${pageContext.request.contextPath}/AdminUserManager/modifyStatus', // or whatever
            dataType : 'json',
            success : function (response) {

                if (response.success) {
                    // Se success è true, inserisci l'alert all'interno del messaggio.
                    var htmlToInsert = `
                          <div class="alert alert-success alert-dismissible fade show" role="alert">
                            <strong>Operazione Eseguita con successo!</strong>   ` + response.message +
                        `<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                          </div>`;
                    $("#responseDiv").html(htmlToInsert);

                } else {
                    // Se success è false, aggiungi un messaggio di errore
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

    //NON PIÙ NECESSARI, SOLUZIONE ALTERNATIVA
    // $(document).ready(function() {
    //     $("#formCreazione").submit(function(event) {
    //         // Prevent default form submission
    //         event.preventDefault();
    //
    //
    //         // chiudo modal dopo il submit
    //         $("#modal1").modal("hide");
    //         $('body').removeClass('modal-open');
    //         $('.modal-backdrop').remove();
    //     });
    // });

    // $(document).ready(function() {
    //     $("#formUpdateStatus").submit(function(event) {
    //         // Prevent default form submission
    //         event.preventDefault();
    //
    //         // chiudo modal dopo il submit
    //         $("#modal2").modal("hide");
    //         $('body').removeClass('modal-open');
    //         $('.modal-backdrop').remove();
    //     });
    // });


    function chiudiFunction() {
        $('#balanceResult').empty()
    }





</script>
</html>
