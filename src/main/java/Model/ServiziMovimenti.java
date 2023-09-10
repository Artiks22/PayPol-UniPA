package Model;

import java.sql.*;
import java.util.ArrayList;

public class ServiziMovimenti
    
{
    public ServiziMovimenti() {
    }
    //funzione che inserisce nella tabella apposita al db i movimenti effettuati
    public static boolean creaMovimenti(Date dataMovimento, float importo, String cartaRicevente) throws SQLException {
        boolean inserito = false;


        String statementinsert = "INSERT INTO movimenti(dataMovimento, importo, cartaRicevente) VALUES(?,?,?)";
        ConnectionDB dataSource = new ConnectionDB();
        Connection connection = dataSource.getConnection();

        PreparedStatement query = connection.prepareStatement(statementinsert);
        query.setDate(1, dataMovimento);
        query.setFloat(2, importo);
        query.setString(3, cartaRicevente);

        int rowCount = query.executeUpdate();
        if(rowCount!=0){
            inserito=true;
        }

        query.close();
        connection.close();

        return inserito;
    }

    //funzione restituente arraylist di movimenti, per fare il fetch di tutti i movimenti effettuati da un utente.
    //Per fare ho effettuato un inner join per ottenere tutti i movimenti dell'utente (dato ownerID) con tutte le carte in suo possesso
    public ArrayList<Movimenti> ottieniMovimenti(int idOwner) throws SQLException {

        ArrayList<Movimenti> movimenti = new ArrayList<>();

        String statement = "SELECT movimenti.* FROM (movimenti INNER JOIN cards ON movimenti.cartaRicevente = cards.CardNum) WHERE cards.OwnerID = ?  ";

        ConnectionDB connessioneDB = new ConnectionDB();
        Connection connection = connessioneDB.getConnection();

        PreparedStatement query = connection.prepareStatement(statement);
        query.setInt(1,idOwner);
        ResultSet resultSet = query.executeQuery();

        if(!resultSet.next()) {
            movimenti = null;
            return movimenti;
        }

        while(resultSet.next()){

            Movimenti movimento = new Movimenti();

            movimento.setIdMovimento(resultSet.getString("idMovimento"));
            movimento.setDataMovimento(resultSet.getDate("dataMovimento"));
            movimento.setImporto(resultSet.getFloat("importo"));
            movimento.setCartaRicevente(resultSet.getString("cartaRicevente"));

            movimenti.add(movimento);

        }

        query.close();
        resultSet.close();
        connection.close();

        return movimenti;


    }
    
    
}
