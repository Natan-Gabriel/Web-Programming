package webubb.model;

import webubb.domain.Asset;
import webubb.domain.Station;
import webubb.domain.User;

import java.sql.*;
import java.util.ArrayList;

/**
 * Created by forest.
 */
public class DBManager {
    private Statement stmt;

    public DBManager() {
        connect();
    }

    public void connect() {
        try {
            Class.forName("org.gjt.mm.mysql.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost/db", "root", "password");
            stmt = con.createStatement();
        } catch(Exception ex) {
            System.out.println("eroare la connect:"+ex.getMessage());
            ex.printStackTrace();
        }
    }

    public User authenticate(String username, String password) {
        ResultSet rs;
        User u = null;
        System.out.println(username+" "+password);
        try {
            rs = stmt.executeQuery("select * from users where username='"+username+"' and password='"+password+"'");
            if (rs.next()) {
                u = new User(rs.getInt("id"), rs.getString("username"), rs.getString("password"));
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return u;
    }

    public ArrayList<Asset> getUserAssets(int userid) {
        ArrayList<Asset> assets = new ArrayList<Asset>();
        ResultSet rs;
        try {
            rs = stmt.executeQuery("select * from assets where userid="+userid);
            while (rs.next()) {
                assets.add(new Asset(
                        rs.getInt("id"),
                        rs.getInt("userid"),
                        rs.getString("description"),
                        rs.getInt("value")
                ));
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return assets;
    }

    public ArrayList<String> getChooseStation(int userid) {
        ArrayList<String> assets = new ArrayList<String>();
        ResultSet rs;
        try {
            rs = stmt.executeQuery("select distinct current from stations");
            while (rs.next()) {
                assets.add(rs.getString("current"));
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        System.out.println(assets);
        return assets;
    }
    public ArrayList<String> getChooseNext(int userid,String name) {
        ArrayList<String> assets = new ArrayList<String>();
        ResultSet rs,rs1,rs2;
        try {
            System.out.println(name);
            //rs = stmt.executeQuery("select next from stations where current='Tottenham Court Road'");//+ name);
            String str="select next from stations where current='"+ name+"'";
            rs = stmt.executeQuery(str);
            while (rs.next()) {
                assets.add(rs.getString("next"));
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            String str1="select id from state where current='"+ name+"'";
            rs1 = stmt.executeQuery(str1);
            int id=-1;
            while (rs1.next()) {
                id=rs1.getInt("id");
            }
            String str2="SELECT COUNT(*) FROM state";
            rs2 = stmt.executeQuery(str1);
            int count=-1;
            while (rs2.next()) {
                count=rs1.getInt("COUNT(*)");
            }
            if(count==1 && id!=-1)
                return assets;

            String str="insert into state(current) values ('"+ name+"')";
            stmt.executeUpdate(str);
            rs1.close();
            rs2.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        //System.out.println(assets);
        return assets;
    }

    public ArrayList<String> getPrevStation(int userid) {
        ArrayList<String> assets = new ArrayList<String>();
        ResultSet rs,rs1,rs2;
        try {

            //rs = stmt.executeQuery("select next from stations where current='Tottenham Court Road'");//+ name);
            String str="SELECT current FROM state ORDER BY id DESC LIMIT 1";
            rs = stmt.executeQuery(str);
            String last="";
            while (rs.next())
            {
                last=rs.getString("current");
                assets.add(last);
            }
//            str="select next from stations where current='"+ last+"'";
//            rs1 = stmt.executeQuery(str);
//            while (rs1.next()) {
//                assets.add(rs1.getString("next"));
//            }
            rs.close();
            //rs1.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        //System.out.println(assets);
        return assets;
    }


    public ArrayList<String> getChoosePrev(int userid) {
        ArrayList<String> assets = new ArrayList<String>();
        ResultSet rs,rs1,rs2;
        try {
            //String str="DELETE FROM state WHERE id=(SELECT MAX(id) FROM state)";
            rs2=stmt.executeQuery("SELECT MAX(id) FROM state");
            int res=0;
            while (rs2.next())
            {
                res=rs2.getInt("MAX(id)");
            }
            String str="DELETE FROM state WHERE id="+res;
            stmt.execute(str);
            rs2.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        try {

            //rs = stmt.executeQuery("select next from stations where current='Tottenham Court Road'");//+ name);
            String str="SELECT current FROM state ORDER BY id DESC LIMIT 1";
            rs = stmt.executeQuery(str);
            String last="";
            while (rs.next())
            {
                last=rs.getString("current");
            }
            str="select next from stations where current='"+ last+"'";
            rs1 = stmt.executeQuery(str);
            while (rs1.next()) {
                assets.add(rs1.getString("next"));
            }
            rs.close();
            rs1.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        //System.out.println(assets);
        return assets;
    }

    public ArrayList<String> getRoute(int userid) {
        ArrayList<String> assets = new ArrayList<String>();
        ResultSet rs;
        try {
            //rs = stmt.executeQuery("select next from stations where current='Tottenham Court Road'");//+ name);
            String str="select current from state";
            rs = stmt.executeQuery(str);
            while (rs.next()) {
                assets.add(rs.getString("current"));
            }
            rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        try {
            String str="delete from  state";
            stmt.execute(str);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        //System.out.println(assets);
        return assets;
    }

    public boolean updateAsset(Asset asset) {
        int r = 0;
        try {
            r = stmt.executeUpdate("update assets set description='"+asset.getDescription()+"', value="+asset.getValue()+
                    " where id="+asset.getId());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        if (r>0) return true;
        else return false;
    }

}