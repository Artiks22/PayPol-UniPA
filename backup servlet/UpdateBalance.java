package Controller;

import java.io.*;
import java.sql.SQLException;

import Model.ServiziCarta;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.json.JSONObject;

@WebServlet(name = "UpdateBalance", value = "/updateBalance")
public class
UpdateBalance extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        ServiziCarta serviziCarta = new ServiziCarta();
        JSONObject JObj = new JSONObject();
        request.setCharacterEncoding("UTF-8");

        String numCarta = request.getParameter("numCarta");
        String operazione = request.getParameter("sceltaMovimento");
        float value = Float.parseFloat(request.getParameter("importoMov"));
        boolean sceltamov = false;

        float creditoAttuale = 0;


        boolean isBlocked;

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
                    creditoaggiornato = ServiziCarta.updateBalance(numCarta, value, sceltamov);
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
                    creditoaggiornato = ServiziCarta.updateBalance(numCarta, value, sceltamov);
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
}