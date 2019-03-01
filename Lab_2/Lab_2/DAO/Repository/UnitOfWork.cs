using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Lab_2.DAO.Service;
using Lab_2.Model;

namespace Lab_2.DAO.Repository
{
    class UnitOfWork
    {
        private PublishingContext context;
        private IRepository<PublishingInfo> publishingRepository;

        public UnitOfWork(PublishingContext context)
        {
            this.context = context;
        }

        public IRepository<PublishingInfo> PublishingRepository
        {
            get
            {
                if (publishingRepository == null)
                    publishingRepository = new SQLPublishingRepository(context);
                return publishingRepository;
            }
        }
    }
}
