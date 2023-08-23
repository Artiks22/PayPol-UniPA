package Model;

import java.sql.*;
import java.time.LocalDate;

public class ServiziCarta {


    public ServiziCarta(){

    }

    public static String checkCredito(String numCarta) throws SQLException {


        ConnectionDB connessioneDB = new ConnectionDB();
        Connection connection = connessioneDB.getConnection();

        String statement = "SELECT CardCredit FROM cards WHERE CardNum=?";
        PreparedStatement query = connection.prepareStatement(statement);

        query.setString(1, numCarta);
        ResultSet resultSet = query.executeQuery();

        String balance = null;
        if (resultSet.next()) {
            balance = String.valueOf(resultSet.getFloat("CardCredit"));
        }

        query.close();
        resultSet.close();
        connection.close();

        return balance;
    }

    public static String updateBalance(String numCarta, float valore, boolean operazione) throws SQLException {
        ConnectionDB connessioneDB = new ConnectionDB();
        Connection connection = connessioneDB.getConnection();

        float creditoattuale = Float.parseFloat(checkCredito(numCarta));
        float creditoupdated = 0;


        if(operazione) {
            creditoupdated = creditoattuale + valore;

        } else {

            creditoupdated = creditoattuale - valore;
        }
        String update = "UPDATE cards SET CardCredit=? WHERE CardNum=?";

        PreparedStatement query = connection.prepareStatement(update);
        query.setFloat(1, creditoupdated);
        query.setString(2, numCarta);


        query.executeUpdate();
        query.close();
        connection.close();

        return String.valueOf(creditoupdated);
    }

    public static void creaCarta(String numCarta, int idUser, float value, LocalDate dataCreazione, LocalDate dataScadenza, String cvv) throws SQLException {

        ConnectionDB connessioneDB = new ConnectionDB();
        Connection connection = connessioneDB.getConnection();
        String creazione = "INSERT INTO cards(CardNum, CreatDate, ExpireDate, FlagBlocked, CVV, CardCredit, OwnerID) VALUES (?,?,?,?,?,?,?)";
        PreparedStatement query = connection.prepareStatement(creazione);
        query.setString(1, numCarta);
        query.setDate(2, Date.valueOf(dataCreazione));
        query.setDate(3, Date.valueOf(dataScadenza));
        query.setBoolean(4, false);
        query.setString(5, cvv);
        query.setFloat(6, value);
        query.setInt(7, idUser);


        query.executeUpdate();
        query.close();
        connection.close();
    }

    public static boolean getCardStatus(String numCarta) throws SQLException {
        ConnectionDB connessioneDB = new ConnectionDB();
        Connection connection = connessioneDB.getConnection();
        boolean statoCarta=false;

        String create = "SELECT FlagBlocked from cards WHERE CardNum=?";
        PreparedStatement query=connection.prepareStatement(create);
        query.setString(1, numCarta);
        ResultSet result = query.executeQuery();
        if(result.next()) {

            statoCarta = result.getBoolean("FlagBlocked");
        }
        query.close();
        connection.close();
        return statoCarta;
    }

    public static void updateCardStatus(String numCarta, boolean op) throws SQLException {
        ConnectionDB connessioneDB = new ConnectionDB();
        Connection connection = connessioneDB.getConnection();
        String create = "UPDATE cards SET FlagBlocked=? WHERE CardNum=?";
        PreparedStatement query=connection.prepareStatement(create);
        query.setBoolean(1, op);
        query.setString(2, numCarta);

        query.executeUpdate();
        query.close();
        connection.close();
    }

    public static boolean cardExists(String numCarta) throws SQLException {
        ConnectionDB connessioneDB = new ConnectionDB();
        Connection connection = connessioneDB.getConnection();
        boolean flagEsistente=false;
        String check="SELECT * FROM cards where CardNum=?";
        PreparedStatement query=connection.prepareStatement(check);

        query.setString(1, numCarta);
        ResultSet resultSet = query.executeQuery();

        if(resultSet.next()) {

            flagEsistente=true;

        }

        query.close();
        resultSet.close();
        connection.close();

        return flagEsistente;
    }

}
