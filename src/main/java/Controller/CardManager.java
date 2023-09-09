package Controller;

import java.io.*;
import java.security.NoSuchAlgorithmException;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.logging.Level;
import java.util.logging.Logger;

import Model.ServiziCarta;
import Model.ServiziMovimenti;
import Model.ServiziUtenti;
import Model.Utente;
import Utils.CardGenUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.json.JSONObject;

@WebServlet(name = "CardManager", urlPatterns ={"/CardManager",
                                                "/CardManager/checkBalance",
                                                "/CardManager/CreateCard",
                                                "/CardManager/updateBalance",
                                                "/CardManager/UpdateStatusCard"})
public class CardManager extends HttpServlet {

    //funzione per il controllo del credito
    public void checkBalance(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, SQLException {

        HttpSession session = request.getSession(false);
        Utente utente = (Utente) session.getAttribute("currentSessionUser");
        ServiziUtenti serviziUtente = new ServiziUtenti();
        ServiziCarta serviziCarta = new ServiziCarta();

        JSONObject JObj = new JSONObject();
        request.setCharacterEncoding("UTF-8");
        String numCarta = request.getParameter("CardCredit"); //prendo il parametro numero di carta dal form
        String balance = null;
        boolean isBlocked; //flag per la verifica del blocco sul venditore

        //controllo stato venditore -> viene controllato a prescindere, l'unico usertype che utilizza il flag è il venditore, altrimenti è posto a "non bloccato" di default.
        boolean statoSeller = serviziUtente.getSellerStatus(utente.getEmail());
        if (statoSeller) { //se bloccato
            JObj.put("success", false);
            JObj.put("message", "L'account dal quale cerchi di effettuare i movimenti risulta bloccato!");

            String jobj = JObj.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(jobj);
        } else { //altrimenti non bloccato

            try { //controllo lo status della carta (anche quella può essere bloccata)
                isBlocked = ServiziCarta.getCardStatus(numCarta);
            } catch (
                    SQLException e) {
                throw new RuntimeException(e);
            }
            if (isBlocked) {
                JObj.put("failed", false);
                JObj.put("message", "Attenzione! La carta risulta essere bloccata e non è possibile effettuare l'operazione!");
                String obj = JObj.toString();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(obj);
            } else { //se non è bloccata procedo con l'operazione di controllo del credito

                try {
                    balance = serviziCarta.checkCredito(numCarta);
                } catch (SQLException e) {
                    e.printStackTrace();
                }
                if (balance == null) { //se restituisce null è il caso in cui la query a db restituisce null perchè non trova corrispondenza
                    JObj.put("failed", false);
                    JObj.put("message", "Attenzione! Il numero di carta inserito non è esistente!");
                    String obj = JObj.toString();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(obj);
                } else {


                    JObj.put("success", true);
                    JObj.put("message", "Il credito residuo della carta selezionata è:  ");
                    JObj.put("value", balance + "€");

                    String obj = JObj.toString();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(obj);

                }
            }
        }
    }
    //funzione per la creazione carte
    public void CreateCard (HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, SQLException {
        ServiziCarta serviziCarta = new ServiziCarta();
        ServiziUtenti serviziUtenti = new ServiziUtenti();
        JSONObject JObj = new JSONObject();
        CardGenUtil cardGen = new CardGenUtil();



        request.setCharacterEncoding("UTF-8");
        String email = request.getParameter("email");
        float value = Float.parseFloat(request.getParameter("valore"));

        int id;

        try {
            id = serviziUtenti.getIdUtente(email);
        } catch (SQLException | NoSuchAlgorithmException e) {
            throw new RuntimeException(e);
        }
        if(id!=0) {
            String numCarta = CardGenUtil.generazioneNumeroCarta();
            String cvv = CardGenUtil.generazioneCvv();
            LocalDate datacreazione = LocalDate.now();
            LocalDate scadenza = datacreazione.plusYears(5);


            try {
                ServiziCarta.creaCarta(numCarta, id, value, datacreazione, scadenza, cvv);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            JObj.put("message", "Carta registrata!");
            JObj.put("success", true);
            response.setContentType("application/json");
            String location = JObj.toString();
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        }
        else{
            JObj.put("success", false);
            JObj.put("message", "Errore! Carta non registrata ");
            response.setContentType("application/json");
            String location = JObj.toString();
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        }

    }

//funzione per aggiornare il balance delle carte di credito
    public void updateBalance(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, SQLException {

        JSONObject JObj = new JSONObject();
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession(false);
        Utente utente = (Utente) session.getAttribute("currentSessionUser");
        ServiziUtenti serviziUtente = new ServiziUtenti();
        ServiziCarta serviziCarta = new ServiziCarta();

        String numCarta = request.getParameter("numCarta");
        String operazione = request.getParameter("sceltaMovimento");
        float value = Float.parseFloat(request.getParameter("importoMov"));
        boolean sceltamov = false;
        float creditoAttuale = 0;

        boolean isBlocked;
        boolean inseritoMovimento;

        if (utente.getUserType() == 2 || utente.getUserType() == 3 ) { //controllo se ad effettuare l'azione sia un negoziante o admin -> l'utente non può
            boolean statoSeller = serviziUtente.getSellerStatus(utente.getEmail()); //check se lo stato seller è bloccato
            if (statoSeller) {
                JObj.put("success", false);
                JObj.put("message", "L'account dal quale cerchi di effettuare i movimenti risulta bloccato!");

                String jobj = JObj.toString();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(jobj);
            } else { //se non bloccato controlla anche lo status della carta
                try {
                    isBlocked = ServiziCarta.getCardStatus(numCarta);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }
                if (isBlocked) { //carta bloccata
                    JObj.put("failed", false);
                    JObj.put("message", "La carta risulta essere bloccata e non è possibile effettuare l'operazione!");
                    String obj = JObj.toString();
                    response.setContentType("application/json");
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(obj);
                } else { //carta non bloccata
                    if (operazione.equals("Accredito")) { //se l'operazione scelta è accredito cambia il flag a true, altrimenti lo lascia su false (addebito)
                        sceltamov = true;
                    }
                    try {
                        creditoAttuale = Float.parseFloat(ServiziCarta.checkCredito(numCarta)); //retrieve del creditoattuale su carta
                    } catch (SQLException e) {
                        throw new RuntimeException(e);
                    }
                    if (!sceltamov && creditoAttuale < value) { //se la scelta del movimento è ADDEBITO (flag sceltamov false) e il credito disponibile è minore di quello da addebitare
                        JObj.put("failed", false);
                        JObj.put("message", "Il valore inserito e' superiore al credito presente sul conto");
                        String obj = JObj.toString();
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");
                        response.getWriter().write(obj);

                    } else if (!sceltamov && creditoAttuale > value) { //se la scelta movimento è addebito e il credito è sufficiente procede
                        String creditoaggiornato;
                        try {
                            LocalDate dataoggi = LocalDate.now();
                            creditoaggiornato = ServiziCarta.updateBalance(numCarta, value, sceltamov);
                            inseritoMovimento = ServiziMovimenti.creaMovimenti(Date.valueOf(dataoggi), -value, numCarta);
                        } catch (SQLException e) {
                            throw new RuntimeException(e);
                        }


                        JObj.put("success", true);
                        JObj.put("message", "Addebito Eseguito, nuovo credito:");
                        JObj.put("value", creditoaggiornato + "€");
                        String obj = JObj.toString();
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");
                        response.getWriter().write(obj);
                    } else if (sceltamov) {
                        String creditoaggiornato;
                        try {
                            LocalDate dataoggi = LocalDate.now();
                            creditoaggiornato = ServiziCarta.updateBalance(numCarta, value, sceltamov);
                            inseritoMovimento = ServiziMovimenti.creaMovimenti(Date.valueOf(dataoggi), value, numCarta);
                        } catch (SQLException e) {
                            throw new RuntimeException(e);
                        }


                        JObj.put("success", true);
                        JObj.put("message", "Accredito eseguito, nuovo credito:");
                        JObj.put("value", creditoaggiornato + "€");
                        String obj = JObj.toString();
                        response.setContentType("application/json");
                        response.setCharacterEncoding("UTF-8");
                        response.getWriter().write(obj);
                    }
                }
            }
        } else {
            JObj.put("failed", false);
            JObj.put("message", "L'utente corrente non risulta essere un Negoziante, pertanto non può effettuare l'azione desiderata.");
            String obj = JObj.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(obj);
        }
    }

//funzione per blocco e sblocco delle carte da parte dell'admin.
    public void UpdateStatusCard(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, SQLException {
        ServiziCarta serviziCarta = new ServiziCarta();
        JSONObject JObj = new JSONObject();
        request.setCharacterEncoding("UTF-8");


        String numCarta = request.getParameter("cardNumber");
        String operazione= request.getParameter("movimento");
        boolean statoCarta;
        boolean cartaEsistente;

        try {
            cartaEsistente = serviziCarta.cardExists(numCarta);//verifico l'esistenza della carta in base al numero inserito.

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        try {
            statoCarta = serviziCarta.getCardStatus(numCarta); //ottengo lo status della carta

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }


        if(!cartaEsistente) {
            JObj.put("success", false);
            JObj.put("message", "La carta non risulta presente nel database!");
            response.setContentType("application/json");
            String location = JObj.toString();
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        } else {

            if(operazione.equals("Blocca")) {
                if(!statoCarta) {
                    //carta esiste e non è bloccata Flag = 0
                    try {
                        ServiziCarta.updateCardStatus(numCarta, true);
                    } catch (SQLException e) {
                        throw new RuntimeException(e);
                    }
                    JObj.put("success", true);
                    JObj.put("message", "La carta è stata bloccata");
                    response.setContentType("application/json");
                    String location = JObj.toString();
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(location);
                } else if (statoCarta) {
                    JObj.put("success", false);
                    JObj.put("message", "La carta risulta già essere Bloccata");
                    response.setContentType("application/json");
                    String location = JObj.toString();
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(location);
                }

            } else if (operazione.equals("Sblocca")) {
                if(statoCarta) {
                    //carta esiste è bloccata con Flag =1, la sblocco
                    try {
                        ServiziCarta.updateCardStatus(numCarta, false);
                    } catch (SQLException e) {
                        throw new RuntimeException(e);
                    }
                    JObj.put("success", true);
                    JObj.put("message", "La carta è stata sbloccata");
                    response.setContentType("application/json");
                    String location = JObj.toString();
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(location);
                } else if (!statoCarta) {
                    JObj.put("success", false);
                    JObj.put("message", "La carta risulta già essere sbloccata");
                    response.setContentType("application/json");
                    String location = JObj.toString();
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(location);
                }

            }
        }
    }



    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {


        String uri = request.getRequestURI();
        switch(uri){
            case "/PayPol/CardManager/checkBalance":

                try {
                    checkBalance(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(CardManager.class.getName()).log(Level.SEVERE, null, ex);
                }

                break;


        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String uri = request.getRequestURI();
        switch(uri){
            case "/PayPol/CardManager/CreateCard":

                try {
                    CreateCard(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(CardManager.class.getName()).log(Level.SEVERE, null, ex);
                }

                break;

            case "/PayPol/CardManager/checkBalance":

                try {
                    checkBalance(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(CardManager.class.getName()).log(Level.SEVERE, null, ex);
                }

                break;

            case "/PayPol/CardManager/updateBalance":

                try {
                    updateBalance(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(CardManager.class.getName()).log(Level.SEVERE, null, ex);
                }


                break;

            case "/PayPol/CardManager/UpdateStatusCard":

                try {
                    UpdateStatusCard(request,response);
                } catch (SQLException ex) {
                    Logger.getLogger(CardManager.class.getName()).log(Level.SEVERE, null, ex);
                }


                break;

        }

    }
}