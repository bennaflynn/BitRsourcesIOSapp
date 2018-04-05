
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Configuration;

[Route("[controller]/[action]")]
    public class LocationAPI : Controller
    {
        
        private readonly IConfiguration                 _configuration;
        public ApplicationDbContext context;
    
        // Constructor.
        public LocationAPI(
                ApplicationDbContext context,
                IConfiguration configuration
            ) {  
            this.context = context;
            _configuration =     configuration;
        }
        
        // Generates a fake collection for demonstration purposes. 
        public List<LoginVM> GetFakeData() {
            List<LoginVM> logins = new List<LoginVM>();
            logins.Add(new LoginVM() { Email = "bob@home.com",
                                                Password = "password" });
            logins.Add(new LoginVM() { Email = "fakeuser@home.com",
                                                Password = "password" });
            return logins;
        }

        // This Action method does not require authentication.
        [HttpGet]    
        public IEnumerable<LoginVM> Public() {
            return GetFakeData();
        }

        // This Action method requires authentication.
        [HttpGet] 
        // Since we have cookie authentication and Jwt authentication we must
        // specify that we want Jwt authentication here.
        //[ClaimRequirement("Custom Mobile Validator", "Logged In")]
        public IEnumerable<LoginVM> Protected() {
            return GetFakeData();
        }

        //This is the GET method that pulls up all the ATM locations
        [HttpGet]
        public List<LocationVM> GetAllATMS() {

            List<LocationVM> locations = new List<LocationVM>();

            var atms = context.ATMs;
            foreach(var a in atms) {
                LocationVM atm = new LocationVM {
                    Lat = a.Lat,
                    Long = a.Long
                };
                locations.Add(atm);
            }
            return locations;
        }

        
        public class LocationVM {
            public float Lat {get;set;}
            public float Long {get;set;}
        }
        
        // It would be better to put this class in a ViewModels folder.
        public class LoginVM {
            [Required]
            public string Email       { get; set; }

            [Required]
            public string Password    { get; set; }

            // We can set this parameter from a mobile phone application.
            public bool   MobileApp   { get; set; }
        }

        // It would be better to put this class in a ViewModels folder.
        public class RegisterVM {
            [Required]
            public string Email { get; set; }

            [Required]
            [StringLength(100, ErrorMessage = "PASSWORD_MIN_LENGTH", 
                               MinimumLength = 6)]
            public string Password { get; set; }
        }
    }