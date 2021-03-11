using System;
using System.Collections.Generic;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library.Model
{
    class Book
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string Author { get; set; }
        public int Year { get; set; }
        public string Description { get; set; }
        public string Status { get; set; }
        public byte[] ImageF;


        public Book() { }
        public Book(int id, string title, string author, string description,  int year,string status, byte[] image)
        {
            this.Id = id;
            this.Title = title;
            this.Author = author;
            this.Description = description;
            this.Year = year;
            this.Status = status;
            this.ImageF = image;
            
        }
    }

  
}
