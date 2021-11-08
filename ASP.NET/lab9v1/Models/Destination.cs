using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace lab9v1.Models
{
    public class Destination
    {
        public int id { get; set; }
        public string location { get; set; }
        public string country { get; set; }
        public string description { get; set; }
        public string targets { get; set; }
        public int cost { get; set; }
    }
}