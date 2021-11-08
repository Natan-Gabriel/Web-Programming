using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using lab9v1.Models;
using lab9v1.DataAbstractionLayer;
using System.Security.Cryptography;
using System.Runtime.InteropServices.WindowsRuntime;
using System.Web.Script.Serialization;
using System.Collections;
using Newtonsoft.Json;
using System.Diagnostics;
using Microsoft.SqlServer.Server;

namespace lab9v1.Controllers
{
    public class MainController : Controller
    {
        string str;
        string name;

        public ActionResult Index()
        {
            return View("Login");
        }
        public string Test()
        {
            return "It's working";
        }
        public ActionResult Login()
        {
            name = Request.Params["name"];
            string password= Request.Params["password"];

            DAL dal = new DAL();
            bool res=dal.Login(name,password);
            if (res == true)

            {
                Session["user"] = "your";

                return View("Destinations");
            }
            else
                return View("Login");

        }

        public ActionResult Logout()
        {
            Session["user"] = null;
            Debug.Write(Session["user"]);

            return View("Login");
        }



        public string GetDestinations()
        {

            DAL dal = new DAL();
            List<Destination> dlist = dal.GetDestinations();
            ViewData["destinationList"] = dlist;

            string result = "";// "<table><thead><th>Id</th><th>Location</th><th>Country</th><th>Description</th><th>Targets</th><th>Cost</th></thead>";

            foreach (Destination dest in dlist)
            {
                result += "<tr class='asset-name' tabindex='1'><td>" + dest.id + "</td><td>" + dest.location + "</td><td>" + dest.country + "</td><td>" + dest.description + "</td><td>" + dest.targets + "</td><td>" + dest.cost + "</td><td></tr>";
            }


            return result;
        }

        public string GetDestinationsSorted()
        {
            int step = 4;
            int currPage = int.Parse(Request.Params["currPage"]);
            DAL dal = new DAL();
            List<Destination> dlist = dal.GetDestinationsSorted();
            ViewData["destinationList"] = dlist;
            var res = dlist.Skip(currPage).Take(step);

            string result = "";

            foreach (Destination dest in res)
            {
                result += "<tr class='asset-name' tabindex='1'><td>" + dest.id + "</td><td>" + dest.location + "</td><td>" + dest.country + "</td><td>" + dest.description + "</td><td>" + dest.targets + "</td><td>" + dest.cost + "</td><td></tr>";
            }

            return result;
        }
        public string GetSelectedDestination()
        {
           
            int curr = 0;
            try
            {
                curr = int.Parse(Request.Params["curr"]);
            }
            catch (Exception e) {; }
            DAL dal = new DAL();
            Destination dest = dal.GetDestinations()[curr];

            string tempString ="";
            tempString += dest.id + ";";
            tempString +=dest.location+";";
            tempString+=dest.country + ";";
            tempString+=dest.description + ";";
            tempString+=dest.targets + ";";
            tempString+=dest.cost.ToString() + ";";

            return tempString;

          
           
        }


        public ActionResult AddDestination()
        {
            bool gone = (Session["user"] == null);
            Debug.Write(gone);
            if (gone)
            {
                Debug.WriteLine("login");
                return View("Login");
            }
            Debug.WriteLine("AddNewDestination");
            return View("AddNewDestination");
        }


        public ActionResult SaveDestination()
        {
            Destination dest = new Destination();
            try
            {
                dest.id = 1;
                dest.location = Request.Params["location"];
                dest.country = Request.Params["country"];
                dest.description = Request.Params["description"];
                dest.targets = Request.Params["targets"];
                dest.cost = int.Parse(Request.Params["cost"]);
            }
            catch (Exception e) {; }
            DAL dal = new DAL();
            dal.SaveDestination(dest);

            return View("Destinations");
        }
        public ActionResult UpdateDestination()
        {
            bool gone = (Session["user"] == null);
            if (gone)
            {
                Debug.WriteLine("login");
                return View("Login");
            }
            return View("UpdateDestination");
        }

        public ActionResult UpdateDb()
        {
            string location = Request.Params["location"];
            Debug.Write("Aici",location);
            string country = Request.Params["country"];
            Debug.Write("Aici", country);
            string description = Request.Params["description"];
            Debug.Write("Aici", description);
            string targets = Request.Params["targets"];
            Debug.Write("Aici", targets);
            int cost = int.Parse(Request.Params["cost"]);
            Debug.Write("Aici", Request.Params["cost"]);
            int id = int.Parse(Request.Params["id"]);

            DAL dal = new DAL();
            dal.UpdateDestination(id, location, country, description, targets, cost);
            return View("Destinations");
        }

        public ActionResult DeleteDestination()
        {

            bool gone = (Session["user"] == null);
            if (gone)
            {
                Debug.WriteLine("login");
                return View("Login");
            }

            int curr = 0;
            try
            {
                curr = int.Parse(Request.Params["curr"]);
            }
            catch (Exception e) {; }

            
            

            DAL dal = new DAL();
            dal.DeleteDestination(curr);
            return View("Destinations");
        }
    }
}