using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using System.Collections.ObjectModel;
using Library.Model;
using System.Data.SqlClient;
using System.Windows;
using Library.View;
using System.Drawing;
using System.IO;
using Library.ViewModel;

namespace Library.ViewModel
{
    class BookViewModel : ViewModelBase
    {
        public BookViewModel()
        {
            Load();
        }

        public ICommand UpdateCommand => new RelayCommand(obj => Update());
        private void Update()
        {
            Books.Clear();
            Load();
        }

        private void Load()
        {
            DB.getInstance();

            string sqlExpression = "exec BookSummary";

            if (DB.SqlConnection.State != System.Data.ConnectionState.Open)
            {
                DB.SqlConnection.Open();
            }

            if (DB.SqlConnection.State == System.Data.ConnectionState.Open)
            {
                SqlCommand command = new SqlCommand(sqlExpression, DB.SqlConnection);
                SqlDataReader reader = command.ExecuteReader();

                if (reader.HasRows) // если есть данные 
                {
                    while (reader.Read()) // построчно считываем данные 
                    {
                        object id = reader["Id"];
                        object title = reader["Title"];
                        object author = reader["Author"];
                        object description = reader["Description"];
                        object year = reader["PYear"];
                        object status = reader["Status"];
                        object image = reader["Image"];
                           
                        Books.Add(new Book(Convert.ToInt32(id.ToString()), title.ToString(), author.ToString(), description.ToString(),
                            Convert.ToInt32(year.ToString()),status.ToString(), (byte[])image));
                        
                    }
                }
                reader.Close();
            }
            DB.SqlConnection.Close();
        }

        private Book selectedBook;

        public Book SelectedBook
        {
            get => selectedBook;
            set
            {
                selectedBook = value;
                OnPropertyChanged("GetImage");
                OnPropertyChanged("GetDescription");
                OnPropertyChanged("GetDownloads");
                
            }
        }
        public string GetDescription
        {
            get
            {
                if (selectedBook != null)
                    return selectedBook.Description;
                return "";
            }
        }

        
        public byte[] GetImage
        {
            get
            {
                if (selectedBook != null)
                    return selectedBook.ImageF;
                return null;
                
            }
        }

   

       

        public string GetDownloads
        {
            get
            {
                if(selectedBook!=null)
                {
                    
                    DB.SqlConnection.Open();
                    SqlCommand command = DB.SqlConnection.CreateCommand();
                    command.CommandText = "Exec DCount " + selectedBook.Id;
                    var temp = command.ExecuteScalar();
                    string result = "Количество скачиваний: " + temp.ToString();
                    DB.SqlConnection.Close();
                    return result;
                }
                return "";
            }
            
        }

        public Image byteArrayToImage(byte[] arra)
        {
            using (MemoryStream memory = new MemoryStream(arra))
            {
                Image img = Image.FromStream(memory);
                return img;
            }
        }


        public ObservableCollection<Book> Books { get; set; } = new ObservableCollection<Book>();

        public ICommand LoginCommand => new RelayCommand(obj => OpenLoginWindow());

        private void OpenLoginWindow()
        {
            var LoginW = new Login();
            LoginW.Show();
        }

        public ICommand AddCommand => new RelayCommand(obj => AddBook());

        private void AddBook()
        {
            var AddBook = new AddBook();
            AddBook.Show();
        }

        public ICommand DeleteCommand => new RelayCommand(obj => DeleteBook());

        private void DeleteBook()
        {
            if (selectedBook != null)
            {
                DB.SqlConnection.Open();
                SqlCommand command = DB.SqlConnection.CreateCommand();
                command.CommandText = "Exec FindByID " + selectedBook.Id;
                var temp = command.ExecuteScalar();
                int fid = (int)temp;
                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = $"exec DeleteBook '" +selectedBook.Title+"', "+selectedBook.Id;
                cmd.Connection = DB.SqlConnection;
                cmd.ExecuteNonQuery();

                
                command.CommandText = "Exec DeleteF " + fid;
                command.ExecuteNonQuery();
                Books.Remove(selectedBook);
                DB.SqlConnection.Close();
            }
            else
                MessageBox.Show("Выберите книгу для удаления");
        }

        public ICommand AddUser => new RelayCommand(obj => AddNewUser());

        private void AddNewUser()
        {
            var AddUser = new AddUser();
            AddUser.Show();
        }

        public ICommand DownloadCommand => new RelayCommand(obj => DownloadFile());

        private void DownloadFile()
        {
            if(selectedBook!= null)
            {
                DB.SqlConnection.Open();
                SqlCommand command = DB.SqlConnection.CreateCommand();
                command.CommandText = "Exec FindByID "+selectedBook.Id;
                var temp = command.ExecuteScalar();
                int fid = (int)temp;
                command.CommandText = "Exec FindBFile " + fid;
                var temp1 = command.ExecuteScalar();
                byte[] file = (byte[])temp1;

                command.CommandText = "Exec FindNameBy " + fid;
                temp1 = command.ExecuteScalar();
                string fName = temp1.ToString();
                List<Model.File> Files = new List<Model.File>();
                Files.Add(new Model.File(fid, fName, file));

                DB.SqlConnection.Close();



                if (Files.Count > 0)
                {
                    using (System.IO.FileStream fs = new System.IO.FileStream(Files[0].FName, FileMode.OpenOrCreate))
                    {
                        fs.Write(file, 0, file.Length);
                        MessageBox.Show("Файл сохранён");
                    }
                }

                DateTime date = DateTime.Now;
                DB.SqlConnection.Open();
                SqlCommand command1 = DB.SqlConnection.CreateCommand();
                command1.CommandText = "Exec AddIssue "+selectedBook.Id +", '"+date.ToString("d")+"',"+User.user.CardId;
                command1.ExecuteNonQuery();
                DB.SqlConnection.Close();
                
            }
            else
            {
                MessageBox.Show("Выберите книгу");
            }
        }

        public ICommand EditCommand => new RelayCommand(obj => EditBook());

        private void EditBook()
        {
            if (selectedBook != null)
            {
                DB.SqlConnection.Open();
                SqlCommand sql = DB.SqlConnection.CreateCommand();
                sql.CommandText = "Exec FindByID " + selectedBook.Id;
                var sql1 = sql.ExecuteScalar();
                int fid = (int)sql1;
                sql.CommandText = "Exec FindBFile " + fid;
                var temp1 = sql.ExecuteScalar();
                byte[] file = (byte[])temp1;

                sql.CommandText = "Exec FindNameBy " + fid;
                temp1 = sql.ExecuteScalar();
                string fName = temp1.ToString();


                SqlCommand cmd = new SqlCommand();
                cmd.CommandText = $"exec DeleteBook '" + selectedBook.Title + "', "+selectedBook.Id;
                cmd.Connection = DB.SqlConnection;
                cmd.ExecuteNonQuery();
                sql.CommandText = "Exec DeleteF " + fid;
                sql.ExecuteNonQuery();
                DB.SqlConnection.Close();

                
                DB.SqlConnection.Open();
                SqlCommand command = DB.SqlConnection.CreateCommand();
                SqlTransaction transaction = DB.SqlConnection.BeginTransaction();

                try
                {
                    command.Transaction = transaction;
                    if (selectedBook.Status=="Рекомендуем")
                    {
                        command.CommandText = "Exec AddBook '" + selectedBook.Title + "', '" + selectedBook.Author + "','" + selectedBook.Description + "'," + selectedBook.Year + ",'Обычный', @Image";
                    }
                    else
                    {
                        command.CommandText = "Exec AddBook '" + selectedBook.Title + "', '" + selectedBook.Author + "','" + selectedBook.Description + "'," + selectedBook.Year + ",'Рекомендуем', @Image";
                    }

                    command.Parameters.AddWithValue("@Image", selectedBook.ImageF);

                    command.Connection = DB.SqlConnection;
                    int number = command.ExecuteNonQuery();

                    
                    command.CommandText = "Exec AddFile '" + fName + "', @File";
                    command.Parameters.AddWithValue("@File", file);
                    command.ExecuteNonQuery();

                    command.CommandText = "Exec FindBId '" + selectedBook.Title + "'";
                    var temp = command.ExecuteScalar();
                    int bid = (int)temp;

                    command.CommandText = "Exec FindFId '" + fName + "'";
                    temp = command.ExecuteScalar();
                    fid = (int)temp;

                    command.CommandText = "Exec Connection " + bid + "," + fid;
                    command.ExecuteNonQuery();

                    transaction.Commit();
                    
                    DB.SqlConnection.Close();
                    

                }
                catch (Exception ex)
                {
                    transaction.Rollback();
                    MessageBox.Show(ex.ToString());

                }

                Books.Remove(selectedBook);
            }
        }

        public ICommand SearchCommand => new RelayCommand(obj => SearchBook());

        private string search_txt;

        public string SearchB
        {
            get => search_txt;
            set
            {
                search_txt = value;
                OnPropertyChanged("SearchB");
            }
        }

        private void SearchBook()
        {
            Books.Clear();
            DB.SqlConnection.Open();
            SqlCommand command = DB.SqlConnection.CreateCommand();
            command.CommandText = "Exec FindBook '" + SearchB + "'";

            SqlDataReader reader = command.ExecuteReader();

            if (reader.HasRows) // если есть данные 
            {
                while (reader.Read()) // построчно считываем данные 
                {
                    object id = reader["Id"];
                    object title = reader["Title"];
                    object author = reader["Author"];
                    object description = reader["Description"];
                    object year = reader["PYear"];
                    object status = reader["Status"];
                    object image = reader["Image"];

                    Books.Add(new Book(Convert.ToInt32(id.ToString()), title.ToString(), author.ToString(), description.ToString(),
                        Convert.ToInt32(year.ToString()), status.ToString(), (byte[])image));

                }
            }
            reader.Close();
            DB.SqlConnection.Close();
        }
        public ICommand ExportCommand => new RelayCommand(obj => Export());

        private void Export()
        {
            string str = "C:\\XML\\";
            DB.SqlConnection.Open();
            SqlCommand command = DB.SqlConnection.CreateCommand();
            command.CommandText = "exec dbo.ExportToXML '" + str + "'";
            command.ExecuteNonQuery();
            DB.SqlConnection.Close();
        }

        public ICommand ImportCommand => new RelayCommand(obj => Import());

        private void Import()
        {
            DB.SqlConnection.Open();
            SqlCommand command = DB.SqlConnection.CreateCommand();
            command.CommandText = "exec dbo.ImportFromXML";
            command.ExecuteNonQuery();
            DB.SqlConnection.Close();
        }
    }
}
