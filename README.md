## SSM Port Forwarding Project

### Introduction
This project stemmed from a real-world scenario encountered in my professional role. It aims to address the need for establishing direct connections to development servers for troubleshooting and debugging purposes.

### Use Case
In the context of our project, there arose a necessity for developers to establish direct links to our development servers. This project facilitates the setup of a PostgreSQL database accessible from local PCs. Notably, our VPC operates on a private network, and communication is facilitated via VPC endpoints utilizing the AWS PrivateLink network infrastructure.

Moreover, this connectivity solution played a pivotal role during our penetration testing exercises, allowing us to identify and address any vulnerabilities stemming from residual artifacts or data manipulation.

### Getting Started
To utilize this project effectively, follow these steps:

1. **Installation**: Clone this repository to your local machine.
```git clone https://github.com/Roondel/ssm-port-forwarding-project.git```

2. **Configuration**: Adjust configurations such as AWS credentials and database settings as per your environment.

3. **Execution**: Run the provided scripts to initiate the port forwarding setup.

4. **Access**: Once the setup is complete, access the PostgreSQL database from your local machine using the designated port.

### Contributions
Contributions are welcome! Feel free to submit issues, feature requests, or pull requests via GitHub.

### License
This project is licensed under the [MIT License](LICENSE).

### Acknowledgments
Special thanks to the team for their collaboration and feedback during the development of this project.

### Disclaimer
This project is intended for educational and informational purposes only. Use it responsibly and in accordance with your organization's policies and guidelines.

---
