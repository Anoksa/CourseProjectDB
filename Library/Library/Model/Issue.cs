using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library.Model
{
    class Issue
    {
        public int Id { get; set; }
        public int BookId { get; set; }
        public DateTime IssueDate { get; set; }
        public int ReaderCard { get; set; }

        public Issue(int id, int bookId, DateTime date, int readerCard)
        {
            this.Id = id;
            this.BookId = bookId;
            this.IssueDate = date;
            this.ReaderCard = readerCard;
        }
    }
}
