using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


using lab9v1.Models;
using MySql.Data.MySqlClient;

namespace lab9v1.DataAbstractionLayer
{
    public class DAL
    {
        public List<Student> GetStudentsFromGroup(int group_id)
        {
            MySql.Data.MySqlClient.MySqlConnection conn;
            string myConnectionString;

            myConnectionString = "server=localhost;uid=root;pwd=password;database=db;";
            List<Student> slist = new List<Student>();

            System.Diagnostics.Debug.WriteLine(group_id);



            try
            {
                conn = new MySql.Data.MySqlClient.MySqlConnection();
                conn.ConnectionString = myConnectionString;
                conn.Open();

                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = "select * from students where group_id=" + group_id;
                MySqlDataReader myreader = cmd.ExecuteReader();

                while (myreader.Read())
                {
                    Console.WriteLine(group_id);
                    Student stud = new Student();
                    
                    stud.Id = myreader.GetInt32("id");
                    stud.Nume = myreader.GetString("name");
                    stud.Password = myreader.GetString("password");
                    stud.Group_id = myreader.GetInt32("group_id");
                    slist.Add(stud);
                }
                myreader.Close();
                
            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {
                Console.Write(ex.Message);
            }
            return slist;
        }

        public bool Login(string name,string password)
        {
            MySql.Data.MySqlClient.MySqlConnection conn;
            string myConnectionString;

            myConnectionString = "server=localhost;uid=root;pwd=password;database=db;";
            List<Destination> dlist = new List<Destination>();



            int index = 0;
            try
            {
                conn = new MySql.Data.MySqlClient.MySqlConnection();
                conn.ConnectionString = myConnectionString;
                conn.Open();

                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = "select * from users where username='" + name + "' and password='" + password + "'" ;
                MySqlDataReader myreader = cmd.ExecuteReader();
                while (myreader.Read())
                {
                    index += 1;
                }
                myreader.Close();

            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {
                Console.Write(ex.Message);
            }
            if (index == 0)
                return false;
            return true;
        }

        public List<Destination> GetDestinationsSorted()
        {
            MySql.Data.MySqlClient.MySqlConnection conn;
            string myConnectionString;

            myConnectionString = "server=localhost;uid=root;pwd=password;database=db;";
            List<Destination> dlist = new List<Destination>();




            try
            {
                conn = new MySql.Data.MySqlClient.MySqlConnection();
                conn.ConnectionString = myConnectionString;
                conn.Open();

                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = "select * from destinations order by country";
                MySqlDataReader myreader = cmd.ExecuteReader();

                while (myreader.Read())
                {
                    Destination dest = new Destination();

                    dest.id = myreader.GetInt32("id");
                    dest.location = myreader.GetString("location");
                    dest.country = myreader.GetString("country");
                    dest.description = myreader.GetString("description");
                    dest.targets = myreader.GetString("targets");
                    dest.cost = myreader.GetInt32("cost");
                    dlist.Add(dest);
                }
                myreader.Close();

            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {
                Console.Write(ex.Message);
            }
            return dlist;
        }

        public List<Destination> GetDestinations()
        {
            MySql.Data.MySqlClient.MySqlConnection conn;
            string myConnectionString;

            myConnectionString = "server=localhost;uid=root;pwd=password;database=db;";
            List<Destination> dlist = new List<Destination>();




            try
            {
                conn = new MySql.Data.MySqlClient.MySqlConnection();
                conn.ConnectionString = myConnectionString;
                conn.Open();

                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = "select * from destinations ";
                MySqlDataReader myreader = cmd.ExecuteReader();

                while (myreader.Read())
                {
                    Destination dest = new Destination();

                    dest.id = myreader.GetInt32("id");
                    dest.location = myreader.GetString("location");
                    dest.country = myreader.GetString("country");
                    dest.description = myreader.GetString("description");
                    dest.targets = myreader.GetString("targets");
                    dest.cost = myreader.GetInt32("cost");
                    dlist.Add(dest);
                }
                myreader.Close();

            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {
                Console.Write(ex.Message);
            }
            return dlist;
        }

        public void SaveDestination(Destination dest)
        {
            MySql.Data.MySqlClient.MySqlConnection conn;
            string myConnectionString;

            myConnectionString = "server=localhost;uid=root;pwd=password;database=db;";

            try
            {
                conn = new MySql.Data.MySqlClient.MySqlConnection();
                conn.ConnectionString = myConnectionString;
                conn.Open();

                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = "insert into destinations(location,country,description,targets,cost) values('" + dest.location + "','" + dest.country + "','" + dest.description + "','" + dest.targets + "'," + dest.cost + ")";
                //cmd.CommandText = "insert into destinations values(" + dest.id + ",'" + dest.location + "','" + dest.country + "','" + dest.description + "','" + dest.targets + "'," + dest.cost + ")";
                //cmd.CommandText = "insert into destinations values("+location + "','" +country + "','" + description + "','" + targets + "'," + cost + ")";
                //cmd.CommandText = "insert into destinations values (22,'21','21','21','21',21)";
                cmd.ExecuteNonQuery();

            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {
                Console.Write(ex.Message);
            }

        }

        public void UpdateDestination(int id,string location,string country,string description,string targets,int cost)
        {
            MySql.Data.MySqlClient.MySqlConnection conn;
            string myConnectionString;

            myConnectionString = "server=localhost;uid=root;pwd=password;database=db;";

            try
            {
                conn = new MySql.Data.MySqlClient.MySqlConnection();
                conn.ConnectionString = myConnectionString;
                conn.Open();

                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = "update destinations set location='" + location + "',country='" + country + "',description='" + description + "',targets='" + targets + "',cost=" + cost + " where id="+ id;
                //cmd.CommandText = "update destinations set location='" + location + "' where id=" + id ;
                //cmd.CommandText = "update destinations set location='102' where id=7;";
                //cmd.CommandText = "insert into destinations values (22,'21','21','21','21',21)";
                cmd.ExecuteNonQuery();

            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {
                Console.Write(ex.Message);
            }

        }
        public void DeleteDestination(int id)
        {
            MySql.Data.MySqlClient.MySqlConnection conn;
            string myConnectionString;

            myConnectionString = "server=localhost;uid=root;pwd=password;database=db;";

            try
            {
                conn = new MySql.Data.MySqlClient.MySqlConnection();
                conn.ConnectionString = myConnectionString;
                conn.Open();

                MySqlCommand cmd = new MySqlCommand();
                cmd.Connection = conn;
                cmd.CommandText = "delete from destinations where id = (select id from(select id from destinations order by id limit " + id+ ",1) as destinations)";
                cmd.ExecuteNonQuery();

            }
            catch (MySql.Data.MySqlClient.MySqlException ex)
            {
                Console.Write(ex.Message);
            }

        }
    }
}