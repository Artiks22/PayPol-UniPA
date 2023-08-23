<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
  <title>JSP - Hello World</title>

<%--  Boostrap components --%>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4bw+/aepP/YC94hEpVNVgiZdgIC5+VKNBQNGCHeKRQN+PtmoHDEXuppvnDJzQIu9" crossorigin="anonymous">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.5.0/font/bootstrap-icons.css" rel="stylesheet" type="text/css" />
  <link rel="stylesheet" href="path/to/font-awesome/css/font-awesome.min.css">

<%--  Jquery--%>
  <script src="https://code.jquery.com/jquery-3.6.1.min.js" integrity="sha256-o88AwQnZB+VDvE9tvIXrMQaPlFFSUTR+nldQm1LuPXQ=" crossorigin="anonymous"></script>
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js" type="text/javascript"></script>

</head>
<body>

<div class="pb-4">
  <jsp:include page="/View/components/navbar.jsp"></jsp:include>
</div>

<!-- Carousel wrapper -->
<div id="introCarousel" class="carousel slide carousel-fade shadow-2-strong" data-mdb-ride="carousel">
  <!-- Indicators -->
  <ol class="carousel-indicators">
    <li data-mdb-target="#introCarousel" data-mdb-slide-to="0" class="active"></li>
    <li data-mdb-target="#introCarousel" data-mdb-slide-to="1"></li>
    <li data-mdb-target="#introCarousel" data-mdb-slide-to="2"></li>
  </ol>

  <!-- Inner -->
  <div class="carousel-inner">
    <!-- Single item -->
    <div class="carousel-item active">
      <div class="mask" style="background-color: rgba(0, 0, 0, 0.6);">
        <div class="d-flex justify-content-center align-items-center h-100">
          <div class="text-white text-center">
            <h1 class="mb-3">Learn Bootstrap 5 with MDB</h1>
            <h5 class="mb-4">Best & free guide of responsive web design</h5>
            <a class="btn btn-outline-light btn-lg m-2" href="https://www.youtube.com/watch?v=c9B4TPnak1A"
               role="button" rel="nofollow" target="_blank">Start tutorial</a>
            <a class="btn btn-outline-light btn-lg m-2" href="https://mdbootstrap.com/docs/standard/"
               target="_blank" role="button">Download MDB UI KIT</a>
          </div>
        </div>
      </div>
    </div>

    <!-- Single item -->
    <div class="carousel-item">
      <div class="mask" style="background-color: rgba(0, 0, 0, 0.3);">
        <div class="d-flex justify-content-center align-items-center h-100">
          <div class="text-white text-center">
            <h2>You can place here any content</h2>
          </div>
        </div>
      </div>
    </div>

    <!-- Single item -->
    <div class="carousel-item">
      <div class="mask" style="
                background: linear-gradient(
                  45deg,
                  rgba(29, 236, 197, 0.7),
                  rgba(91, 14, 214, 0.7) 100%
                );
              ">
        <div class="d-flex justify-content-center align-items-center h-100">
          <div class="text-white text-center">
            <h2>And cover it with any mask</h2>
            <a class="btn btn-outline-light btn-lg m-2"
               href="https://mdbootstrap.com/docs/standard/content-styles/masks/" target="_blank" role="button">Learn
              about masks</a>
          </div>
        </div>
      </div>
    </div>
  </div>
  <!-- Inner -->

  <!-- Controls -->
  <a class="carousel-control-prev" href="#introCarousel" role="button" data-mdb-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="carousel-control-next" href="#introCarousel" role="button" data-mdb-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>
<!-- Carousel wrapper -->
</header>
<!--Main Navigation-->

<!--Main layout-->
<main class="mt-5">
  <div class="container">
    <!--Section: Content-->
    <section>
      <div class="row">
        <div class="col-md-6 gx-5 mb-4">
          <div class="bg-image hover-overlay ripple shadow-2-strong" data-mdb-ripple-color="light">
            <img src="https://mdbootstrap.com/img/new/slides/031.jpg" class="img-fluid" />
            <a href="#!">
              <div class="mask" style="background-color: rgba(251, 251, 251, 0.15);"></div>
            </a>
          </div>
        </div>

        <div class="col-md-6 gx-5 mb-4">
          <h4><strong>Facilis consequatur eligendi</strong></h4>
          <p class="text-muted">
            Lorem ipsum dolor sit amet consectetur adipisicing elit. Facilis consequatur
            eligendi quisquam doloremque vero ex debitis veritatis placeat unde animi laborum
            sapiente illo possimus, commodi dignissimos obcaecati illum maiores corporis.
          </p>
          <p><strong>Doloremque vero ex debitis veritatis?</strong></p>
          <p class="text-muted">
            Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quod itaque voluptate
            nesciunt laborum incidunt. Officia, quam consectetur. Earum eligendi aliquam illum
            alias, unde optio accusantium soluta, iusto molestiae adipisci et?
          </p>
        </div>
      </div>
    </section>
    <!--Section: Content-->

    <hr class="my-5" />

    <!--Section: Content-->

    <!--Section: Content-->

    <hr class="my-5" />

    <!--Section: Content-->
    <section class="mb-5">
      <h4 class="mb-5 text-center"><strong>Facilis consequatur eligendi</strong></h4>

      <div class="row d-flex justify-content-center">
        <div class="col-md-6">
          <form>
            <!-- 2 column grid layout with text inputs for the first and last names -->
            <div class="row mb-4">
              <div class="col">
                <div class="form-outline">
                  <input type="text" id="form3Example1" class="form-control" />
                  <label class="form-label" for="form3Example1">First name</label>
                </div>
              </div>
              <div class="col">
                <div class="form-outline">
                  <input type="text" id="form3Example2" class="form-control" />
                  <label class="form-label" for="form3Example2">Last name</label>
                </div>
              </div>
            </div>

            <!-- Email input -->
            <div class="form-outline mb-4">
              <input type="email" id="form3Example3" class="form-control" />
              <label class="form-label" for="form3Example3">Email address</label>
            </div>

            <!-- Password input -->
            <div class="form-outline mb-4">
              <input type="password" id="form3Example4" class="form-control" />
              <label class="form-label" for="form3Example4">Password</label>
            </div>

            <!-- Checkbox -->
            <div class="form-check d-flex justify-content-center mb-4">
              <input class="form-check-input me-2" type="checkbox" value="" id="form2Example3" checked />
              <label class="form-check-label" for="form2Example3">
                Subscribe to our newsletter
              </label>
            </div>

            <!-- Submit button -->
            <button type="submit" class="btn btn-primary btn-block mb-4">
              Sign up
            </button>

            <!-- Register buttons -->
            <div class="text-center">
              <p>or sign up with:</p>
              <button type="button" class="btn btn-primary btn-floating mx-1">
                <i class="fab fa-facebook-f"></i>
              </button>

              <button type="button" class="btn btn-primary btn-floating mx-1">
                <i class="fab fa-google"></i>
              </button>

              <button type="button" class="btn btn-primary btn-floating mx-1">
                <i class="fab fa-twitter"></i>
              </button>

              <button type="button" class="btn btn-primary btn-floating mx-1">
                <i class="fab fa-github"></i>
              </button>
            </div>
          </form>
        </div>
      </div>
    </section>
    <!--Section: Content-->
  </div>
</main>
<!--Main layout-->

<!--Footer-->
<footer class="bg-light text-lg-start">
  <div class="py-4 text-center">
    <a role="button" class="btn btn-primary btn-lg m-2"
       href="https://www.youtube.com/channel/UC5CF7mLQZhvx8O5GODZAhdA" rel="nofollow" target="_blank">
      Learn Bootstrap 5
    </a>
    <a role="button" class="btn btn-primary btn-lg m-2" href="https://mdbootstrap.com/docs/standard/" target="_blank">
      Download MDB UI KIT
    </a>
  </div>

  <hr class="m-0" />

  <div class="text-center py-4 align-items-center">
    <p>Follow MDB on social media</p>
    <a href="https://www.youtube.com/channel/UC5CF7mLQZhvx8O5GODZAhdA" class="btn btn-primary m-1" role="button"
       rel="nofollow" target="_blank">
      <i class="fab fa-youtube"></i>
    </a>
    <a href="https://www.facebook.com/mdbootstrap" class="btn btn-primary m-1" role="button" rel="nofollow"
       target="_blank">
      <i class="fab fa-facebook-f"></i>
    </a>
    <a href="https://twitter.com/MDBootstrap" class="btn btn-primary m-1" role="button" rel="nofollow"
       target="_blank">
      <i class="fab fa-twitter"></i>
    </a>
    <a href="https://github.com/mdbootstrap/mdb-ui-kit" class="btn btn-primary m-1" role="button" rel="nofollow"
       target="_blank">
      <i class="fab fa-github"></i>
    </a>
  </div>

  <!-- Copyright -->
  <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2);">
    © 2020 Copyright:
    <a class="text-dark" href="https://mdbootstrap.com/">MDBootstrap.com</a>
  </div>
  <!-- Copyright -->
</footer>
<!--Footer-->
<!-- MDB -->
<script type="text/javascript" src="js/mdb.min.js"></script>
<!-- Custom scripts -->
<script type="text/javascript" src="js/script.js"></script>




<%--<a href="View/registrationPage.jsp">Registrati!</a>--%>
<%--<a href="View/loginpage.jsp">Login</a><br>--%>
<%--<a href="${pageContext.request.contextPath}/AuthenticationManager/logout">Logout</a>--%>
<%--<a href="View/HPUser.jsp">check credito</a><br>--%>
<%--<a href="View/UpdateBalancePage.jsp">update balance</a><br>--%>
</body>
</html>