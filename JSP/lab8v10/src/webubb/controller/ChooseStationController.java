package webubb.controller;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import webubb.domain.Asset;
import webubb.domain.Station;
import webubb.model.DBManager;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

public class ChooseStationController extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ((action != null) && action.equals("update")) {
            ;// We update an asset
            /*Station station = new Station(Integer.parseInt(request.getParameter("id")),
                    request.getParameter("current"),
                    request.getParameter("next"));
            DBManager dbmanager = new DBManager();
            Boolean result = dbmanager.updateAsset(asset);
            PrintWriter out = new PrintWriter(response.getOutputStream());
            if (result == true) {
                out.println("Update asset succesfully.");
            } else {
                out.println("Error updating asset!");
            }
            out.flush();*/
        } else if ((action != null) && action.equals("getAll")) {
            int userid = Integer.parseInt(request.getParameter("userid"));

            response.setContentType("application/json");
            DBManager dbmanager = new DBManager();
            ArrayList<String> stations = dbmanager.getChooseStation(userid);
            JSONArray jsonStations = new JSONArray();
            for (int i = 0; i < stations.size(); i++) {
                JSONObject jObj = new JSONObject();
                jObj.put("name", stations.get(i));
                jsonStations.add(jObj);
            }
            PrintWriter out = new PrintWriter(response.getOutputStream());
            out.println(jsonStations.toJSONString());
            out.flush();
        }
        else if ((action != null) && action.equals("getNext")) {
            int userid = Integer.parseInt(request.getParameter("userid"));
            String name = request.getParameter("name");

            response.setContentType("application/json");
            DBManager dbmanager = new DBManager();
            ArrayList<String> stations = dbmanager.getChooseNext(userid,name);
            JSONArray jsonStations = new JSONArray();
            for (int i = 0; i < stations.size(); i++) {
                JSONObject jObj = new JSONObject();
                jObj.put("name", stations.get(i));
                jsonStations.add(jObj);
            }
            PrintWriter out = new PrintWriter(response.getOutputStream());
            out.println(jsonStations.toJSONString());
            out.flush();
        }
        else if ((action != null) && action.equals("getPrev")) {
            int userid = Integer.parseInt(request.getParameter("userid"));

            response.setContentType("application/json");
            DBManager dbmanager = new DBManager();
            ArrayList<String> stations = dbmanager.getChoosePrev(userid);
            JSONArray jsonStations = new JSONArray();
            for (int i = 0; i < stations.size(); i++) {
                JSONObject jObj = new JSONObject();
                jObj.put("name", stations.get(i));
                jsonStations.add(jObj);
            }
            PrintWriter out = new PrintWriter(response.getOutputStream());
            out.println(jsonStations.toJSONString());
            out.flush();
        }
        else if ((action != null) && action.equals("getRoute")) {
            int userid = Integer.parseInt(request.getParameter("userid"));

            response.setContentType("application/json");
            DBManager dbmanager = new DBManager();
            ArrayList<String> stations = dbmanager.getRoute(userid);
            JSONArray jsonStations = new JSONArray();
            for (int i = 0; i < stations.size(); i++) {
                JSONObject jObj = new JSONObject();
                jObj.put("name", stations.get(i));
                jsonStations.add(jObj);
            }
            PrintWriter out = new PrintWriter(response.getOutputStream());
            out.println(jsonStations.toJSONString());
            out.flush();
        }
        else if ((action != null) && action.equals("getPrevStation")) {
            int userid = Integer.parseInt(request.getParameter("userid"));

            response.setContentType("application/json");
            DBManager dbmanager = new DBManager();
            ArrayList<String> stations = dbmanager.getPrevStation(userid);
            JSONArray jsonStations = new JSONArray();
            for (int i = 0; i < stations.size(); i++) {
                JSONObject jObj = new JSONObject();
                jObj.put("name", stations.get(i));
                jsonStations.add(jObj);
            }
            PrintWriter out = new PrintWriter(response.getOutputStream());
            out.println(jsonStations.toJSONString());
            out.flush();
        }

    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}
