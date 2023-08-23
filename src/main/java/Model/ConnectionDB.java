/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author zarti
 */
public class ConnectionDB {
    
    private String database_name="paypol";
    private String username="root";
    private String password="root";
    private String url="jdbc:mysql://localhost:3306/"+database_name;
    
    Connection connection;
    
    public Connection getConnection(){
        
        try{
            
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = (Connection) DriverManager.getConnection(this.url,this.username,this.password);

        }catch(SQLException | ClassNotFoundException sqlex){
            
            System.err.println(sqlex);

        }
        
        return connection;
    }
    
}
