import UIKit
import GoogleSignIn
import FBSDKLoginKit
import Firebase

class LogIn_ViewController: UIViewController,GIDSignInUIDelegate,FBSDKLoginButtonDelegate {
    
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var emailTaxt: UITextField!
    @IBOutlet weak var passworText: UITextField!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        backgroundImg.loadGif(name: "Loading")
        
        setupFacebookButton()
        setupGoogleButton()
        
        ModelNotification.ConnectedUser.observe { (user) in
            print("User is: ", user)
            if(user != nil){
                self.loadMainController()
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        spinner.stopAnimating()
        spinner.isHidden = true
        Model.instance.getConnectedUser()
    }
    
    func loadMainController(){
        self.performSegue(withIdentifier: "LogedIn", sender: self)
    }
    
    fileprivate func setupGoogleButton(){
        let googleButton = GIDSignInButton()
        googleButton.frame = CGRect(x: 16, y: 476, width: view.frame.width - 32, height: 50)
        view.addSubview(googleButton)
        
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    fileprivate func setupFacebookButton(){
        let facebookLoginButton = FBSDKLoginButton()
        facebookLoginButton.frame = CGRect(x: 16, y: 416, width: view.frame.width - 32, height: 50)
        view.addSubview(facebookLoginButton)
        
        facebookLoginButton.delegate = self
        facebookLoginButton.readPermissions = ["email"]
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("Did Log out of facebook")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil{
            print(error)
            return
        }
        getEmailFromFacebook()
    }
    
    func getEmailFromFacebook(){
        let accessToken = FBSDKAccessToken.current()
        
        let credntials = FacebookAuthProvider.credential(withAccessToken: (accessToken?.tokenString)!)
        
        Auth.auth().signIn(with: credntials) { (user, error) in
            if error != nil{
                print("ERROR - Something went wrong with our FB user: ",error)
                return
            }
            print(user, "Loged In")
            self.loadMainController()
            return
        }
        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, err) in
            if err != nil{
                print("ERROR - Failed to start graph request: ",err)
                return
            }
            print("Result: ", result)
        }
    }
    
    @IBAction func SignInWithEmail(_ sender: UIButton) {
        
        Auth.auth().createUser(withEmail: emailTaxt.text!, password: passworText.text!){ (user, error) in
            if error != nil{
                print("ERROR - Something went wrong with our user: ",error)
                return
            }
            print(user, "Loged In")
            self.loadMainController()
            return
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
