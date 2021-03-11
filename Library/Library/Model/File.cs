using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Library.Model
{
    class File
    {
        public int ID { get; set; }
        public string FName { get; set; }
        public byte[] DFile { get; set; }

        public File() { }

        public File(int id, string fName, byte[] dFile)
        {
            this.ID = id;
            this.FName = fName;
            this.DFile = DFile;
        }


    }
}
