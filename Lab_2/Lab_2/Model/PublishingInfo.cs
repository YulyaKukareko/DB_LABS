using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lab_2.Model
{
    class PublishingInfo
    {
        int id;
        int circulation;
        DateTime date;


        public PublishingInfo()
        {

        }

        public PublishingInfo(int id, int circulation, DateTime date)
        {
            this.id = id;
            this.circulation = circulation;
            this.date = date;
        }

        public PublishingInfo(int circulation, DateTime date)
        {
            this.circulation = circulation;
            this.date = date;
        }

        public int Id
        {
            set { id = value; }
            get { return id; }
        }

        public int Circulation
        {
            set { circulation = value; }
            get { return circulation; }
        }

        public DateTime Date
        {
            set { date = value; }
            get { return date; }
        }

        public override string ToString()
        {
            return "id = " + this.id + " circulation = " + this.circulation + " date = " + this.date;
        }
    }
}
