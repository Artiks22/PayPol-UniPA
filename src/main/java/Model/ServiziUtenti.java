package Model;

import java.security.NoSuchAlgorithmException;
import java.sql.*;
import java.util.ArrayList;

public class ServiziUtenti {

    public ServiziUtenti() {
    }


    public boolean checkUtenteEsistente(String email) throws SQLException, NoSuchAlgorithmException {

        boolean presente=false;

        String statement = "SELECT * FROM users WHERE email=?";

        ConnectionDB dataSource = new ConnectionDB();
        Connection connection = dataSource.getConnection();

        PreparedStatement query = connection.prepareStatement(statement);
        query.setString(1,email);

        ResultSet resultSet = query.executeQuery();

        if(resultSet.next()){

            presente=true;
        }

        query.close();
        resultSet.close();
        connection.close();

        return presente;

    }

    public boolean aggiungiUtente(String nome, String cognome, String email, String password, int userType) throws SQLException {
        boolean inserito = false;


            String statementinsert = "INSERT INTO users(Nome, Cognome, Email, Password, UserType, sellerBlocked) VALUES(?,?,?,?,?,?)";
            ConnectionDB dataSource = new ConnectionDB();
            Connection connection = dataSource.getConnection();

            PreparedStatement query = connection.prepareStatement(statementinsert);
            query.setString(1, nome);
            query.setString(2, cognome);
            query.setString(3, email);
            query.setString(4, password);
            query.setInt(5, userType);

        if (userType == 2) {
            query.setInt(6, 0);
        }
        else {
            //query.setNull(6, Types.INTEGER);
            query.setInt(6, 2);
        }

        int rowCount = query.executeUpdate();
        if(rowCount!=0){
            inserito=true;
        }

        query.close();
        connection.close();

        return inserito;
    }

    public ArrayList<Utente> getUtenti() throws SQLException{

        ArrayList<Utente> utenti = new ArrayList<>();

        String statement = "SELECT * FROM users";

        ConnectionDB connessioneDB = new ConnectionDB();
        Connection connection = connessioneDB.getConnection();

        PreparedStatement query = connection.prepareStatement(statement);

        ResultSet resultSet = query.executeQuery();

        while(resultSet.next()){

            Utente utente= new Utente();

            utente.setId(resultSet.getInt("idUser"));
            utente.setEmail(resultSet.getNString("Email"));
            utente.setPassword(resultSet.getNString("Password"));
            utente.setNome(resultSet.getNString("Nome"));
            utente.setCognome(resultSet.getNString("Cognome"));
            utente.setUserType(Integer.parseInt(resultSet.getNString("UserType")));

            utenti.add(utente);

        }

        query.close();
        resultSet.close();
        connection.close();

        return utenti;

    }

    public Utente getUtente(String email,String password) throws SQLException, NoSuchAlgorithmException{

        Utente utente = new Utente();
        String statement = "SELECT * FROM users WHERE email=? and password=?";

        ConnectionDB connessioneDB = new ConnectionDB();
        Connection connection = connessioneDB.getConnection();

        PreparedStatement query = connection.prepareStatement(statement);
        query.setString(1,email);
        query.setString(2,password);

        ResultSet resultSet = query.executeQuery();

        if(resultSet.next()){

            utente.setId(resultSet.getInt("idUser"));
            utente.setEmail(resultSet.getNString("Email"));
//            utente.setPassword(resultSet.getNString("Password"));
            utente.setNome(resultSet.getNString("Nome"));
            utente.setCognome(resultSet.getNString("Cognome"));
            utente.setUserType(Integer.parseInt(resultSet.getNString("UserType")));
        }

        query.close();
        resultSet.close();
        connection.close();

        return utente;

    }

    public int getIdUtente(String email) throws SQLException, NoSuchAlgorithmException{

        String statement = "SELECT * FROM users WHERE email=?";

        ConnectionDB connessioneDB = new ConnectionDB();
        Connection connection = connessioneDB.getConnection();

        PreparedStatement query = connection.prepareStatement(statement);
        query.setString(1,email);

        ResultSet resultSet = query.executeQuery();
        int id = 0;

        if(resultSet.next())
            id = resultSet.getInt("idUser");


        query.close();
        resultSet.close();
        connection.close();

        return id;

    }

    public static boolean getSellerStatus(String Email) throws SQLException {
        ConnectionDB connessioneDB = new ConnectionDB();
        Connection connection = connessioneDB.getConnection();
        boolean statoUtente=false;

        String create = "SELECT SellerBlocked from users WHERE Email=?";
        PreparedStatement query=connection.prepareStatement(create);
        query.setString(1, Email);
        ResultSet result = query.executeQuery();
        if(result.next()) {

            statoUtente = result.getBoolean("SellerBlocked");
        }
        query.close();
        connection.close();
        return statoUtente;
    }
    public static void updateSellerStatus(String Email, boolean op) throws SQLException {
        ConnectionDB connessioneDB = new ConnectionDB();
        Connection connection = connessioneDB.getConnection();
        String create = "UPDATE users SET SellerBlocked=? WHERE Email=?";
        PreparedStatement query=connection.prepareStatement(create);
        query.setBoolean(1, op);
        query.setString(2, Email);

        query.executeUpdate();
        query.close();
        connection.close();
    }
}
