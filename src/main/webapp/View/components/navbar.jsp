<%@ page import="Model.Utente" %><%--
  Created by IntelliJ IDEA.
  User: zarti
  Date: 08/08/2023
  Time: 13:05
  To change this template use File | Settings | File Templates.
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" type="text/css" />
</head>

<style>

  .btn {
    --bs-btn-padding-x: 0.75rem;
    --bs-btn-padding-y: 0.375rem;
    --bs-btn-font-family: ;
    --bs-btn-font-size: 1rem;
    --bs-btn-font-weight: 400;
    --bs-btn-line-height: 1.5;
    /*--bs-btn-color: #212529;*/
  /*  --bs-btn-bg: transparent;*/
    --bs-btn-border-width: 1px;
  /*  --bs-btn-border-color: transparent;*/
    --bs-btn-border-radius: 0.375rem;
  /*  --bs-btn-hover-border-color: transparent;*/
  /*  --bs-btn-box-shadow: inset 0 1px 0 rgba(255, 255, 255, 0.15), 0 1px 1px rgba(0, 0, 0, 0.075);*/
  /*  --bs-btn-disabled-opacity: 0.65;*/
  /*  --bs-btn-focus-box-shadow: 0 0 0 0.25rem rgba(var(--bs-btn-focus-shadow-rgb), .5);*/
  /*  display: inline-block;*/
    /*padding: var(--bs-btn-padding-y) var(--bs-btn-padding-x);*/
    /*font-family: var(--bs-btn-font-family);*/
    /*font-size: var(--bs-btn-font-size);*/
    /*font-weight: var(--bs-btn-font-weight);*/
    /*line-height: var(--bs-btn-line-height);*/
    /*color: var(--bs-btn-color);*/
    /*!*text-align: center;*!*/
    /*text-decoration: none;*/
    /*vertical-align: middle;*/
    /*cursor: pointer;*/
    /*-webkit-user-select: none;*/
    /*-moz-user-select: none;*/
    /*user-select: none;*/
    /*border: var(--bs-btn-border-width) solid var(--bs-btn-border-color);*/
    /*border-radius: var(--bs-btn-border-radius);*/
    /*background-color: var(--bs-btn-bg);*/
    transition: color 0.15s ease-in-out, background-color 0.15s ease-in-out, border-color 0.15s ease-in-out, box-shadow 0.15s ease-in-out;
  }
  .btn-primary {
      --bs-btn-color: #fff;
      --bs-btn-bg: #1e30f3;
      --bs-btn-border-color: #1e30f3;
      --bs-btn-hover-color: #fff;
      --bs-btn-hover-bg: #1a29cf;
      --bs-btn-hover-border-color: #1826c2;
      --bs-btn-focus-shadow-rgb: 64, 79, 245;
      --bs-btn-active-color: #fff;
      --bs-btn-active-bg: #1826c2;
      --bs-btn-active-border-color: #1724b6;
      --bs-btn-active-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
      --bs-btn-disabled-color: #fff;
      --bs-btn-disabled-bg: #1e30f3;
      --bs-btn-disabled-border-color: #1e30f3;
  }
  .btn-outline-dark {
      --bs-btn-color: #212529;
      --bs-btn-border-color: #212529;
      --bs-btn-hover-color: #fff;
      --bs-btn-hover-bg: #212529;
      --bs-btn-hover-border-color: #212529;
      --bs-btn-focus-shadow-rgb: 33, 37, 41;
      --bs-btn-active-color: #fff;
      --bs-btn-active-bg: #212529;
      --bs-btn-active-border-color: #212529;
      --bs-btn-active-shadow: inset 0 3px 5px rgba(0, 0, 0, 0.125);
      --bs-btn-disabled-color: #212529;
      --bs-btn-disabled-bg: transparent;
      --bs-btn-disabled-border-color: #212529;
      --bs-gradient: none;
  }
  .navbar-brand {
    padding-left: 60px;
  }


  .navbar{
    font-size: large;
    margin: 0px;
    padding: 0px;

    -webkit-box-shadow: 0 8px 6px -6px #999;
    -moz-box-shadow: 0 8px 6px -6px #999;
    box-shadow: 0 8px 15px -6px #999;
  }
  .nav-link,.nav-link active{

    color: #3b3b3b;
  }
  .container-fluid{

    background-color: rgb(255, 255, 255);
    margin:0px;
    padding:0px;

  }
  .links {
    float: right;
  }
</style>





<%--    <% --%>
<%--        Utente u = (Utente)request.getSession().getAttribute("currentSessionUser");--%>
<%--        int userType = u.getUserType();--%>
<%--    %>--%>

<%--<%--%>
<%--    if (userType == 1) { %>--%>
<%--<a href="/PayPol/View/HPUser.jsp" id="iconLink">--%>
<%--    <i class="bi bi-house-door"></i>--%>
<%--</a>  <% } else if (userType == 2) { %>--%>
<%--<a href="/PayPol/View/HPSeller.jsp" id="iconLink">--%>
<%--    <i class="bi bi-house-door"></i>--%>
<%--</a> <% } else if (userType == 3) { %>--%>
<%--        <a href="/PayPol/View/HPAdmin.jsp" id="iconLink">--%>
<%--    <i class="bi bi-house-door"></i>--%>
<%--</a> <% } else {  %>--%>
<%--<a href="/PayPol" id="iconLink">--%>
<%--    <i class="bi bi-house-door"></i>--%>
<%--</a> <% } %>--%>


<nav class="navbar navbar-expand-lg bg-light">
  <div class="container-fluid">
    <a class="navbar-brand mt-2 mt-lg-0" href="/PayPol">
      <img src="${pageContext.request.contextPath}/View/img/testlogo.svg" alt="PayPol" width="170" height="50">
    </a>
    <div class="d-flex align-items-center justify-content-center">
        <a href="#" id="iconLink">
            <i class="bi bi-house-door"></i>
        </a>
    </div>
    <div class="d-flex align-items-center m-lg-3">
    <div class="links" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="btn btn-primary btn-sm px-5  me-sm-3 fs-6 fw-bolder" href="${pageContext.request.contextPath}/View/loginpage.jsp">Accedi</a>
<%--          <a class="nav-link active" aria-current="page" href="../loginpage.jsp">Accedi</a>--%>
        </li>
        <li class="nav-item">
          <a id ="registrazione" class="btn btn-outline-dark btn-sm px-5  fs-6 fw-bolder" href="${pageContext.request.contextPath}/View/registrationPage.jsp">Registrati</a>
<%--          <a id="registration" class="nav-link" href="../registrationPage.jsp">Registrati</a>--%>
        </li>
      </ul>
    </div>
    </div>
  </div>
</nav>








</html>