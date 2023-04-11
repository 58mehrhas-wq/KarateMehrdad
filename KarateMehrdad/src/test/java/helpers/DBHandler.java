package helpers;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

import net.minidev.json.JSONObject;

public class DBHandler {

    private static String connectionUrl = "jdbc:sqlite://Users//mehrdadfhassani//Documents//Source/Exercis_Files_for_SQL//db;database=test.db";

    public static void addNewJobWithName(String jobName) {
        try(Connection connect = DriverManager.getConnection(connectionUrl)) {
            connect.createStatement().execute("INSERT INTO [moe].[toe].[sue] (bla, bla2, bla3) VALUES ('"+jobName+"', 60, 200)");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public static JSONObject getMinAndMaxLevelsForJob(String jobName){
        JSONObject json = new JSONObject();

        try(Connection connect = DriverManager.getConnection(connectionUrl)) {
            ResultSet rs = connect.createStatement().executeQuery("SELECT * FROM [moe].[toe].[sue] where job_desc = '"+jobName+"'");
            rs.next();
            json.put("minLvl",rs.getString("min_lvl"));
            json.put("maxLvl",rs.getString("max_lvl"));

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return json;

    }
    
}
