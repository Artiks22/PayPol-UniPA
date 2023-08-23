package Controller;

import java.io.*;
import java.sql.Connection;
import java.sql.SQLException;

import Model.Carta;
import Model.ConnectionDB;
import Model.ServiziCarta;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.json.JSONObject;

@WebServlet(name = "checkBalance", value = "/checkBalance")
public class checkBalance extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


        ServiziCarta serviziCarta = new ServiziCarta();

        JSONObject JObj = new JSONObject();
        request.setCharacterEncoding("UTF-8");
        String numCarta = request.getParameter("CardCredit");
        String balance = null;
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
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}