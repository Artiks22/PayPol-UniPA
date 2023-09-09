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
                                                "/AdminUserManager/getMovements",
                                                "/AdminUserManager/getCards"})

public class AdminUserManager extends HttpServlet {

    //Funzionalità ADMIN utilizzata per aggiornare lo status del venditore Bloccato/Sbloccato
    public void UpdateSellerStatus(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, SQLException {
        ServiziUtenti serviziUtente = new ServiziUtenti();
        JSONObject JObj = new JSONObject();
        request.setCharacterEncoding("UTF-8");
        String emailseller = request.getParameter("emailSeller");
        String operazione= request.getParameter("movimento");
        boolean statoSeller;
        boolean userExists;

        //lo status viene recuperato mediante l'email associata al negoziante
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
                    //Se l'utente esiste e lo status del Venditore è NON BLOCCATO (Flag posto a false 0)
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
                    //Se l'utente esiste e lo status del Venditore è BLOCCATO (Flag posto a true 1)
                    JObj.put("success", false);
                    JObj.put("message", "Il negoziante risulta già essere Bloccato!");
                    response.setContentType("application/json");
                    String location = JObj.toString();
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(location);
                }

            } else if (operazione.equals("Sblocca")) {
                if(statoSeller) {
                    //Se l'utente esiste e lo status del Venditore è GIÀ BLOCCATO (Flag posto a true 1) -> procedo sbloccandolo
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
                    //Se l'utente esiste e lo status del Venditore è GIÀ SBLOCCATO (Flag posto a false 0) -> messaggio errore
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

        ServiziUtenti serviziUtente = new ServiziUtenti();
        ServiziMovimenti serviziMovimenti = new ServiziMovimenti();
        HttpSession session = request.getSession(false);
        request.setCharacterEncoding("UTF-8");
        JSONObject JObj = new JSONObject();

        //Recupero l'oggetto utente dalla http session, e in particolare mi servo del parametro idUser salvato all'interno dello stesso.
        Utente utente = (Utente) session.getAttribute("currentSessionUser");
        int id  = utente.getId();

        //Richiamo la funzione ed ottengo l'intera lista di movimenti mediante uso di ArrayList
        ArrayList<Movimenti> movimenti =  serviziMovimenti.ottieniMovimenti(id);


        if(utente.getUserType() == 2){
            boolean statoSeller = serviziUtente.getSellerStatus(utente.getEmail());
            //Controllo sullo status del Venditore (Se bloccato non può effettuare operazioni)
            if (statoSeller){
                JObj.put("success", false);
                JObj.put("message", "L'account dal quale cerchi di recuperare la lista transazioni risulta bloccato!");

                String jobj = JObj.toString();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(jobj);
            }
            else { //se sbloccato può procedere con l'operazione di recupero dei movimenti.
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
        } else { //Stesso codice precedente ma riguardante le altre tipologie di utente.
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

    //funzionalità Utente e Venditore per recuperare la lista delle carte in possesso
    public void getCardsUser(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, SQLException {
        ServiziUtenti serviziUtenti = new ServiziUtenti();
        HttpSession session = request.getSession(false);
        JSONObject JObj = new JSONObject();
        //Recupero l'oggetto utente dalla http session, e in particolare mi servo del parametro idUser salvato all'interno dello stesso.
        Utente utente = (Utente) session.getAttribute("currentSessionUser");
        int id  = utente.getId();
        request.setCharacterEncoding("UTF-8");

        //Chiamo la funzione per ottenere l'arraylist delle carte dell'utente.
        ArrayList<Carta> carte =  serviziUtenti.ottieniCarte(id);

        if(utente.getUserType() == 2){
            //Controllo sullo status del Venditore (Se bloccato non può effettuare operazioni)
            boolean statoSeller = serviziUtenti.getSellerStatus(utente.getEmail());
            if (statoSeller){
                JObj.put("success", false);
                JObj.put("message", "L'account dal quale cerchi di recuperare la lista di carte in possesso risulta bloccato!");

                String jobj = JObj.toString();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(jobj);
            }
            else {
                if(carte!=null) { //se è in possesso di carte le inserisce nell'oggetto json della risposta

                    JObj.put("success", true);
                    JObj.put("message", "carte ottenute");
                    JObj.put("cards", carte);

                    String jobj = JObj.toString();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(jobj);
                } else { //se non è in possesso di carte -> messaggio di errore
                    JObj.put("success", false);
                    JObj.put("message", "Non sono presenti carte in possesso.");
                    String location = JObj.toString();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(location);
                }
            }
        } else { //Stesso codice precedente ma riguardante le altre tipologie di utente.
            if(carte!=null) {

                JObj.put("success", true);
                JObj.put("message", "carte ottenute");
                JObj.put("cards", carte);

                String jobj = JObj.toString();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(jobj);
            } else {
                JObj.put("success", false);
                JObj.put("message", "Non sono presenti carte in possesso.");
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

            case "/PayPol/AdminUserManager/getCards":
            {
                try {
                    getCardsUser(request,response);
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