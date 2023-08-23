package Controller;

import java.io.*;

import Model.ServiziCarta;
import Model.ServiziUtenti;
import Utils.CardGenUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.json.JSONObject;

import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

@WebServlet(name = "CreateCard", value = "/CreateCard")
public class CreateCard extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ServiziCarta serviziCarta = new ServiziCarta();
        ServiziUtenti serviziUtenti = new ServiziUtenti();
        JSONObject JObj = new JSONObject();
        CardGenUtil cardGen = new CardGenUtil();


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
            request.setCharacterEncoding("UTF-8");

            try {
                ServiziCarta.creaCarta(numCarta, id, value, datacreazione, scadenza, cvv);
            } catch (SQLException e) {
                throw new RuntimeException(e);
            }
            JObj.put("message", "Carta registrata! ");
            response.setContentType("application/json");
            String location = JObj.toString();
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        }
        else{
            JObj.put("message", "Errore! Carta non registrata ");
            response.setContentType("application/json");
            String location = JObj.toString();
            response.setCharacterEncoding("UTF-8");
            response.getWriter().write(location);
        }

    }
}