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

    public void checkBalance(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, SQLException {
        ServiziCarta serviziCarta = new ServiziCarta();

        JSONObject JObj = new JSONObject();
        request.setCharacterEncoding("UTF-8");
        String numCarta = request.getParameter("CardCredit");
        String balance = null;
        boolean isBlocked;

        try {
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
        } else {

            try {
                balance = serviziCarta.checkCredito(numCarta);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            if (balance == null) {
                JObj.put("failed", false);
                JObj.put("message", "Attenzione! Il numero di carta inserito non è esistente!");
                String obj = JObj.toString();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(obj);
            } else {


                JObj.put("success", true);
                JObj.put("message", "Il credito residuo della carta selezionata è:");
                JObj.put("value", balance + "$");

                String obj = JObj.toString();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(obj);

            }
        }
    }

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


    public void updateBalance(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, SQLException {
        ServiziCarta serviziCarta = new ServiziCarta();
        JSONObject JObj = new JSONObject();
        request.setCharacterEncoding("UTF-8");

        String numCarta = request.getParameter("numCarta");
        String operazione = request.getParameter("sceltaMovimento");
        float value = Float.parseFloat(request.getParameter("importoMov"));
        boolean sceltamov = false;

        float creditoAttuale = 0;


        boolean isBlocked;
        boolean inseritoMovimento;

        try {
            isBlocked = ServiziCarta.getCardStatus(numCarta);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        if (isBlocked) {
            JObj.put("failed", false);
            JObj.put("message", "Attenzione! La carta risulta essere bloccata e non è possibile effettuare l'operazione!");
            String obj = JObj.toString();
            response.setContentType("application/json");
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(obj);
        } else {
            if (operazione.equals("Accredito")) {
                sceltamov = true;
            }
            try {
                creditoAttuale = Float.parseFloat(ServiziCarta.checkCredito(numCarta));
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            if (!sceltamov && creditoAttuale < value) {
                JObj.put("failed", false);
                JObj.put("message", "Attenzione! Il valore inserito e' superiore al credito presente sul conto");
                String obj = JObj.toString();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(obj);

            } else if (!sceltamov && creditoAttuale > value) {
                String creditoaggiornato;
                try {
                    LocalDate dataoggi = LocalDate.now();
                    creditoaggiornato = ServiziCarta.updateBalance(numCarta, value, sceltamov);
                    inseritoMovimento = ServiziMovimenti.creaMovimenti(Date.valueOf(dataoggi),-value,numCarta);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }



                JObj.put("success", true);
                JObj.put("message", "Operazione di accredito eseguita con successo, nuovo credito:");
                JObj.put("value", creditoaggiornato + "$");
                String obj = JObj.toString();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(obj);
            } else if (sceltamov) {
                String creditoaggiornato;
                try {
                    LocalDate dataoggi = LocalDate.now();
                    creditoaggiornato = ServiziCarta.updateBalance(numCarta, value, sceltamov);
                    inseritoMovimento = ServiziMovimenti.creaMovimenti(Date.valueOf(dataoggi),value,numCarta);
                } catch (SQLException e) {
                    throw new RuntimeException(e);
                }



                JObj.put("success", true);
                JObj.put("message", "Operazione di addebito eseguita con successo, nuovo credito:");
                JObj.put("value", creditoaggiornato + "$");
                String obj = JObj.toString();
                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(obj);
            }
        }
    }


    public void UpdateStatusCard(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException, SQLException {
        ServiziCarta serviziCarta = new ServiziCarta();
        JSONObject JObj = new JSONObject();
        request.setCharacterEncoding("UTF-8");


        String numCarta = request.getParameter("cardNumber");
        String operazione= request.getParameter("movimento");
        boolean statoCarta;
        boolean cartaEsistente;


        try {
            statoCarta = serviziCarta.getCardStatus(numCarta);

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        try {
            cartaEsistente = serviziCarta.cardExists(numCarta);

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
                    JObj.put("message", "La carta è stata bloccata con successo!");
                    response.setContentType("application/json");
                    String location = JObj.toString();
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(location);
                } else if (statoCarta) {
                    JObj.put("success", false);
                    JObj.put("message", "La carta risulta già essere Bloccata!");
                    response.setContentType("application/json");
                    String location = JObj.toString();
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(location);
                }

            } else if (operazione.equals("Sblocca")) {
                if(statoCarta) {
                    //                carta esiste è bloccata con Flag =1, la sblocco
                    try {
                        ServiziCarta.updateCardStatus(numCarta, false);
                    } catch (SQLException e) {
                        throw new RuntimeException(e);
                    }
                    JObj.put("success", true);
                    JObj.put("message", "La carta è stata sbloccata con successo!");
                    response.setContentType("application/json");
                    String location = JObj.toString();
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(location);
                } else if (!statoCarta) {
                    JObj.put("success", false);
                    JObj.put("message", "La carta risulta già essere sbloccata!");
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