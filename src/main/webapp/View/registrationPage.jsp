<%--
  Created by IntelliJ IDEA.
  User: zarti
  Date: 26/07/2023
  Time: 15:13
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">


    <%--  bootstrap components --%>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" type="text/css" />
<%--    jquery --%>
    <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>



    <title>PayPol Registration</title>
</head>
<body>

<div class="pb-4">
    <jsp:include page="/View/components/navbar.jsp"></jsp:include>
</div>

<section >

    <h1> Registra nuovo utente! </h1>

<%-- action="${pageContext.request.contextPath}/AuthenticationManager/registration" method="POST" */--%>
    <form id="form">



        <br>
        <fieldset>
            <legend>Tipologia Utente:</legend>
            <div>

                <input type="radio" id="tipoUtente2" name="tipoUtente" value="2" checked>
                <label for="tipoUtente2">Negoziante</label><br>


                <input type="radio" id="tipoUtente1" name="tipoUtente" value="1">
                <label for="tipoUtente1">Cliente</label><br>
            </div>
        </fieldset>



        <label for="email">Email</label><br>
        <input type="email" id="email" name="email"><br>

        <label for="nome">Nome:</label><br>
        <input type="text" id="nome" name="nome"><br>

        <label for="Cognome">Cognome:</label><br>
        <input type="text" id="cognome" name="cognome"><br>

        <div class="mb-3" id="registrationPassword">
        <label for="password">Password:</label><br>
        <input type="password" id="password" name="password"><br>
        </div>

        <label for="confirmpassword">Conferma password:</label><br>
        <input type="password" id="confirmpassword" name="confirmpassword"><br>

        <button id="btn-submit" type="submit"> Conferma registrazione</button>
    </form>

</section>
</body>
<script>


    function _validate() {

        let validation=true;
        //regex stock trovata su internet
        //Minimum eight characters, at least one uppercase letter, one lowercase letter, one number and one special character:
        let passRegex=/^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$/;
        let emailRegex = /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/g;
        let textRegex = /^[a-zA-Z ]+$/;

        if($("#email").val().match(emailRegex)===null){

            validation=false;
        }

        let pass1= document.getElementById("password").value
        let pass2=document.getElementById("confirmpassword").value
        if($("#password").val().match(passRegex)===null || pass1 != pass2 )  {

            let message='la password deve essere lunga almeno 8 caratteri, deve contenere una lettera maiuscola,un numero e un carattere speciale';
            $("#registrationPassword").append('<span class="badge rounded-pill text-bg-danger">'+message+'</span>')

            validation=false;
        }

        if($("#nome").val().match(textRegex)===null){

            validation=false;
        }

        if($("#cognome").val().match(textRegex)===null){


            validation=false;
        }

        return validation;



    }

    function sendData(){

        $("#form").submit(function(event) {
            console.log("sus? ");
            event.preventDefault();

            let validation = _validate();

            if(validation){
               // var valoreSelezionato = $('input[name="scelta"]:checked').val();
                var data = {
                    email:$('#email').val(),
                    password:$("#password").val(),
                    nome: $("#nome").val(),
                    cognome: $("#cognome").val(),
                    tipoUtente: $('input[name="tipoUtente"]:checked').val(),

                };

                var url = '/PayPol/AuthenticationManager/registration';

                $.post(url,data,(response)=> {

                    if(response.success){

                        let message = response.message;

                        const alert = '<div class="alert alert-success col-3 position-fixed top-0 end-0 m-5 p-3" style="z-index: 11" role="alert">'+message+'</div>';

                        $('.row').append(alert);

                        window.location=response.address;
                    }
                    else{

                        let message = response.message;

                        const alert = '<div class="alert alert-danger col-3 position-fixed top-0 end-0 m-5 p-3" style="z-index: 11" role="alert">'+message+'</div>';

                        $('.row').append(alert);

                    }

                });

            }

        });
    }

    $(document).ready(()=> {sendData();} );

</script>


</html>