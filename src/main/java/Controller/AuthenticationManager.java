package Controller;

import java.io.*;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

import Model.ConnectionDB;
import Model.ServiziUtenti;
import Model.Utente;
import Utils.PasswordEncryption;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.json.JSONObject;

@WebServlet(name = "AuthenticationManager", urlPatterns ={"/AuthenticationManager",
                                                         "/AuthenticationManager/login",
                                                         "/AuthenticationManager/registration",
                                                         "/AuthenticationManager/logout"})
public class AuthenticationManager extends HttpServlet {


    protected void registration(HttpServletRequest request, HttpServletResponse response) throws NoSuchAlgorithmException, SQLException, IOException {
        System.out.println("test2 sono arrivato a questo punto?");
        ServiziUtenti serviziUtenti = new ServiziUtenti();
        JSONObject Jlocation = new JSONObject();
        PasswordEncryption passwordEncryption = new PasswordEncryption();

        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String nome = request.getParameter("nome");
        String cognome = request.getParameter("cognome");
        int userType = Integer.parseInt(request.getParameter("tipoUtente"));

        boolean userEsistente = false;
        try {
            userEsistente = serviziUtenti.checkUtenteEsistente(email);
        } catch (SQLException e){
            e.printStackTrace();
        }

        if(!userEsistente) {
            //cifro la password
            String passwordCifrata = passwordEncryption.cypher(password);

            boolean inserito = false;
            try {
                inserito = serviziUtenti.aggiungiUtente(nome, cognome, email, passwordCifrata, userType);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            if(inserito){
                Utente utente = null;
                try {
                   utente = serviziUtenti.getUtente(email, password);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                Jlocation.put("success", true);
                Jlocation.put("address", "/PayPol/");
                Jlocation.put("message", "utente registrato correttamente");
                Jlocation.put("user", utente);
                String location = Jlocation.toString();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(location);
            }
            else{

                Jlocation.put("success", false);
                Jlocation.put("message", "errore durante la registrazione");
                String location = Jlocation.toString();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(location);

            }
        } else {
            Jlocation.put("success", false);
            Jlocation.put("message", "l'email inserita risulta gia' esistente o associata ad un altro account");
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        }
}


    protected void login(HttpServletRequest request, HttpServletResponse response) throws SQLException, IOException, NoSuchAlgorithmException, ServletException {

        ServiziUtenti serviziUtenti = new ServiziUtenti();
        JSONObject Jlocation = new JSONObject();

        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");
        String password = request.getParameter("password");


        PasswordEncryption passwordEncryption = new PasswordEncryption();
        String encryptedPassword = passwordEncryption.cypher(password);
        Utente utente = new Utente();
        try {
            utente = serviziUtenti.getUtente(email, encryptedPassword);
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if(utente.getNome()!=null){

            //generiamo la sessione


            int userType = utente.getUserType();
            HttpSession session = request.getSession(true);
            session.setMaxInactiveInterval(60*15);
            session.setAttribute("currentSessionUser", utente);
            session.setAttribute("userType", userType);


            Jlocation.put("success", true);
            Jlocation.put("message", "Login effettuato con successo");
            Jlocation.put("UserType", utente.getUserType());
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);



//            switch(utente.getUserType()){
//                case 1:
//                    response.sendRedirect("/PayPol/View/HPUser.jsp");
//                    break;
//
//                case 2:
//                    response.sendRedirect("/PayPol/View/HPSeller.jsp");
//                    break;
//
//                case 3:
//                    response.sendRedirect("/PayPol/View/HPAdmin.jsp");
//                    break;
//
//                default:
//                    response.sendRedirect("/PayPol/index.jsp");
//
//            }
        }
        else{

            Jlocation.put("success", false);
            Jlocation.put("message", "Combinazione di email e password errata");
            String location = Jlocation.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);




        }

    }

    protected void logout(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, SQLException{

        ConnectionDB connectionDB = new ConnectionDB();
        HttpSession session = request.getSession(false);
        System.out.println("invalidata sessione con ID:" + session.getId());
        session.invalidate();

        //request.getRequestDispatcher("/index.jsp").forward(request, response);
        response.sendRedirect("/PayPol/index.jsp");
        }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uri = request.getRequestURI();

        switch(uri){

            case "/PayPol/AuthenticationManager":

                request.getRequestDispatcher("/View/registrationPage.jsp").forward(request, response);

                break;

            case "/PayPol/AuthenticationManager/login":

                try {
                    login(request,response);
                } catch (SQLException | NoSuchAlgorithmException ex) {
                    Logger.getLogger(AuthenticationManager.class.getName()).log(Level.SEVERE, null, ex);
                }

                break;


           case "/PayPol/AuthenticationManager/logout":

                try {
                    logout(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(AuthenticationManager.class.getName()).log(Level.SEVERE, null, ex);
                }


                break;

        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uri = request.getRequestURI();
        //System.out.println("test");
        switch(uri){


            case "/PayPol/AuthenticationManager/registration":

                try {
                    registration(request,response);
                } catch (SQLException | NoSuchAlgorithmException ex) {
                    Logger.getLogger(AuthenticationManager.class.getName()).log(Level.SEVERE, null, ex);
                }


                break;

        }
    }




    }
