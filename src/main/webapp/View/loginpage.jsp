<%@ page import="Model.Utente" %><%--
  Created by IntelliJ IDEA.
  User: zarti
  Date: 01/08/2023
  Time: 09:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Login</title>

<%--  bootstrap components --%>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" type="text/css" />

  <%--  Jquery--%>
  <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>
  <script src="https://malsup.github.io/jquery.form.js"></script>



  <jsp:include page="/View/Styles/loginpageStyle.jsp"></jsp:include>
</head>

<body>

<div class="pb-4">
  <jsp:include page="/View/components/navbar.jsp"></jsp:include>
</div>

<div id="alertDiv"> </div>

<section class="vh-100">
  <div class="container-fluid">
    <div class="row">
      <div class="col-sm-6 text-black">

        <div class="px-5 ms-xl-4">

          <span class=" justify-content-center h1 fw-bold mb-0 ">Effettua il login!</span>
        </div>

        <div class="d-flex align-items-top justify-content-center h-custom-2 px-5 ms-xl-4 mt-5 pt-5 pt-xl-0 mt-xl-n5">

          <form id="loginForm" style="width: 23rem;" action="${pageContext.request.contextPath}/AuthenticationManager/login" method="GET">

            <h3 class="fw-normal mb-3 pb-3" style="letter-spacing: 1px;">Log in</h3>

            <div class="form-outline mb-4">
              <input type="email"  id="email" name="email" class="form-control form-control-lg" />
              <label class="form-label" for="email">Indirizzo Email</label>
            </div>

            <div class="form-outline mb-4">
              <input type="password" id="password" name="password" class="form-control form-control-lg" />
              <label class="form-label" for="password">Password</label>
            </div>

            <div class="pt-1 mb-4">
              <button type="submit" id="btn-submit" style="--bs-btn-bg: rgba(53,162,220,0.8)" class="btn btn-info btn-lg btn-block" type="button">Login</button>
            </div>


            <p>Non hai un account? <a href="${pageContext.request.contextPath}/View/registrationPage.jsp" class="link-info">Registrati qui</a></p>

          </form>

        </div>

      </div>
      <div class="col-sm-6 px-6 d-none d-sm-block">
        <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/img3.webp"
             alt="Login image" class="w-100 vh-100" style="object-fit: cover; object-position: left;">
      </div>
    </div>
  </div>
</section>



</body>

<script>


  $(document).ready(()=>{


  $('#loginForm')
          .ajaxForm({
            url : '${pageContext.request.contextPath}/AuthenticationManager/login', // or whatever
            dataType : 'json',
            success : function (response) {

              if (response.success) {
                // console.log(response);
                redirectFunction(response.UserType);
<%--                <% Utente  currentUser = (Utente) session.getAttribute("currentSessionUser"); %>--%>
<%--                let userType =  <% currentUser.getUserType(); %>--%>



              } else  {
                var htmlToInsert = `
                          <div class="alert alert-danger alert-dismissible fade show" role="alert">
                            <strong>Errore!</strong>   ` + response.message +
                        `<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                          </div>`;

                $("#alertDiv").html(htmlToInsert);


              }
            },
            error: function(xhr, status, error) {
              console.log("Errore nella richiesta AJAX: " + error);
            }


          });
  });

  function redirectFunction(userType){



    switch (userType) {
      case 1:
        window.location.href = "/PayPol/View/HPUser.jsp";
        break;
      case 2:
        window.location.href = "/PayPol/View/HPSeller.jsp";
        break;
      case 3:
        window.location.href = "/PayPol/View/HPAdmin.jsp";
        break;
      default:
        console.log("Errore login");
    }
  }
</script>
</html>