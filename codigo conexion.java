package newpackage;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import javax.swing.JOptionPane;

public class Conexion {

    // Se recomienda actualizar el driver a cj (para MySQL Connector/J 8.0+)
    private final String DRIVER = "com.mysql.cj.jdbc.Driver"; 
    private final String URL = "jdbc:mysql://localhost:3306/";
    private final String DB = "romaledesserts";
    private final String USER = "root";
    private final String PASSWORD = "12345";
    
    public Connection cadena;
    private static Conexion instancia;
    
    private Conexion(){
        this.cadena = null;
    }
    
    public Connection conectar(){
        try {
            Class.forName(DRIVER);
            // Parámetros opcionales para evitar problemas con la zona horaria y SSL
            String urlCompleta = URL + DB + "?useSSL=false&serverTimezone=UTC";
            this.cadena = DriverManager.getConnection(urlCompleta, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            JOptionPane.showMessageDialog(null, "Error al cargar el driver JDBC: " + e.getMessage());
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "Error al conectar con la base de datos: " + e.getMessage());
        }
        return this.cadena;
    }
    
    public void desconectar(){
        try {
            if (this.cadena != null && !this.cadena.isClosed()) {
                this.cadena.close();
            }
        } catch (SQLException e) {
            JOptionPane.showMessageDialog(null, "Error al cerrar la conexión: " + e.getMessage());
        }
    }
    
    public synchronized static Conexion getInstancia(){
        if (instancia == null){
            instancia = new Conexion();
        }
        return instancia;
    }
}
