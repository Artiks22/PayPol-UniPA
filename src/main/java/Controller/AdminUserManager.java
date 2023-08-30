package Controller;

import java.io.*;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.ArrayList;

import Model.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.json.JSONObject;

@WebServlet(name = "AdminUserManager", urlPatterns ={"/AdminUserManager",
                                                "/AdminUserManager/modifyStatus",
                                                "/AdminUserManager/getMovements",})

public class AdminUserManager extends HttpServlet {


    public void UpdateSellerStatus(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, SQLException {
        ServiziUtenti serviziUtente = new ServiziUtenti();

        JSONObject JObj = new JSONObject();
        request.setCharacterEncoding("UTF-8");


        String emailseller = request.getParameter("emailSeller");
        String operazione= request.getParameter("movimento");
        boolean statoSeller;
        boolean userExists;


        try {
            statoSeller = serviziUtente.getSellerStatus(emailseller);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        try {
            userExists = serviziUtente.checkUtenteEsistente(emailseller);

        } catch (SQLException | NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }

        if(!userExists) {
            JObj.put("success", false);
            JObj.put("message", "Il negoziante non risulta presente nel database!");

            String location = JObj.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        } else {

            if(operazione.equals("Blocca")) {
                if(!statoSeller) {
                    //carta esiste e non è bloccata Flag = 0
                    try {
                        ServiziUtenti.updateSellerStatus(emailseller, true);
                    } catch (SQLException e) {
                        throw new RuntimeException(e);
                    }
                    JObj.put("success", true);
                    JObj.put("message", "Il negoziante è stato bloccato con successo!");
                    response.setContentType("application/json");
                    String location = JObj.toString();
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(location);
                } else if (statoSeller) {
                    JObj.put("success", false);
                    JObj.put("message", "Il negoziante risulta già essere Bloccato!");
                    response.setContentType("application/json");
                    String location = JObj.toString();
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(location);
                }

            } else if (operazione.equals("Sblocca")) {
                if(statoSeller) {
                    //                carta esiste è bloccata con Flag =1, la sblocco
                    try {
                        ServiziUtenti.updateSellerStatus(emailseller, false);
                    } catch (SQLException e) {
                        throw new RuntimeException(e);
                    }
                    JObj.put("success", true);
                    JObj.put("message", "Il negoziante è stato sbloccato con successo!");
                    response.setContentType("application/json");
                    String location = JObj.toString();
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(location);
                } else if (!statoSeller) {
                    JObj.put("success", false);
                    JObj.put("message", "Il negoziante risulta già NON essere bloccato!");
                    response.setContentType("application/json");
                    String location = JObj.toString();
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(location);
                }

            }
        }
    }


    public void getTransactionHistory(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, SQLException {

        ServiziMovimenti serviziMovimenti = new ServiziMovimenti();
        HttpSession session = request.getSession(false);
        Utente utente = (Utente) session.getAttribute("currentSessionUser");
        ServiziUtenti serviziUtenti = new ServiziUtenti();
        JSONObject JObj = new JSONObject();
        int id  = utente.getId();
        request.setCharacterEncoding("UTF-8");
        //Chiamo la funzione per ottenere l'intera lista di movimenti
        ArrayList<Movimenti> movimenti =  serviziMovimenti.ottieniMovimenti(id);
        ServiziUtenti serviziUtente = new ServiziUtenti();

        if(utente.getUserType() == 2){
            boolean statoSeller = serviziUtente.getSellerStatus(utente.getEmail());
            if (statoSeller){
                JObj.put("success", false);
                JObj.put("message", "L'account dal quale cerchi di recuperare la lista transazioni risulta bloccato!");

                String jobj = JObj.toString();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(jobj);
            }
            else {
                if(movimenti!=null) {

                    JObj.put("success", true);
                    JObj.put("message", "movimenti ottenuti");
                    JObj.put("movements", movimenti);

                    String jobj = JObj.toString();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(jobj);
                } else {
                    JObj.put("success", false);
                    JObj.put("message", "Non sono presenti movimenti");
                    String location = JObj.toString();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(location);
                }
            }
        } else {
            if(movimenti!=null) {

                JObj.put("success", true);
                JObj.put("message", "movimenti ottenuti");
                JObj.put("movements", movimenti);

                String jobj = JObj.toString();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(jobj);
            } else {
                JObj.put("success", false);
                JObj.put("message", "Non sono presenti movimenti");
                String location = JObj.toString();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(location);
            }
        }
    }



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uri = request.getRequestURI();

        switch(uri){
            case "/PayPol/AdminUserManager/getMovements":
            {
                try {
                    getTransactionHistory(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(AdminUserManager.class.getName()).log(Level.SEVERE, null, ex);
                }
            }

            break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uri = request.getRequestURI();
        switch (uri) {
            case "/PayPol/AdminUserManager/modifyStatus":

                try {
                    UpdateSellerStatus(request, response);
                } catch (SQLException ex) {
                    Logger.getLogger(CardManager.class.getName()).log(Level.SEVERE, null, ex);
                }

                break;
        }
    }
}