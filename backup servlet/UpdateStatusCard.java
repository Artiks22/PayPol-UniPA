package Controller;

import java.io.*;
import java.sql.SQLException;

import Model.ServiziCarta;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import org.json.JSONObject;

@WebServlet(name = "UpdateStatusCard", value = "/UpdateStatusCard")
public class UpdateStatusCard extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
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
                    JObj.put("message", "La carta è stata bloccata con successo!");
                    response.setContentType("application/json");
                    String location = JObj.toString();
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(location);
                } else if (statoCarta) {
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
                    JObj.put("message", "La carta è stata sbloccata con successo!");
                    response.setContentType("application/json");
                    String location = JObj.toString();
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(location);
                } else if (!statoCarta) {
                    JObj.put("message", "La carta risulta già essere sbloccata!");
                    response.setContentType("application/json");
                    String location = JObj.toString();
                    response.setCharacterEncoding("UTF-8");
                    response.getWriter().write(location);
                }

            }
        }
    }
}