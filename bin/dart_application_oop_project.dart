void main() {
  BankAccount account1 = BankAccount(500);
  SavingsBankAccount account2 = SavingsBankAccount(1500);

  account1.deposit(100);
  account1.withdraw(200);

  account2.deposit(150);
  account2.withdraw(200);

  Client client1 = Client("John Doe", "123 Main St", "555-1234", account1);
  Client client2 = Client("Jane Smith", "456 Elm St", "555-5678", account2);

  account1.owner = client1;
  account2.owner = client2;

  print(client1);
  print(client2);
}

class BankAccount {
  int accountID;
  double balance;
  static int _nextID = 1;
  Client? owner;

  BankAccount([this.balance = 0]) : accountID = _nextID++;

  double get getBalance => balance;
  set setBalance(double amount) => balance = amount;

  void deposit(double amount) {
    if (amount > 0) {
      balance += amount;
      print('Deposited $amount. New balance: $balance');
    } else {
      print('Deposit amount must be positive');
    }
  }

  void withdraw(double amount) {
    if (amount > 0 && balance >= amount) {
      balance -= amount;
      print('Withdrew $amount. New balance: $balance');
    } else {
      print('Insufficient balance or invalid amount');
    }
  }

  @override
  String toString() {
    return 'BankAccount(ID: $accountID, Balance: $balance)';
  }
}

class SavingsBankAccount extends BankAccount {
  double minimumBalance;
  SavingsBankAccount(double balance, [this.minimumBalance = 1000])
      : super(balance) {
    if (balance < minimumBalance) {
      throw ArgumentError('Initial balance must be >= minimum balance');
    }
  }

  @override
  void withdraw(double amount) {
    if (amount > 0 && balance - amount >= minimumBalance) {
      balance -= amount;
      print('Withdrew $amount. New balance: $balance');
    } else {
      print('Cannot withdraw below minimum balance or invalid amount');
    }
  }

  @override
  void deposit(double amount) {
    if (amount >= 100) {
      super.deposit(amount);
    } else {
      print('Deposit amount must be at least 100');
    }
  }

  @override
  String toString() {
    return 'SavingsBankAccount(ID: $accountID, Balance: $balance, Minimum Balance: $minimumBalance)';
  }
}

class Client {
  String name;
  String address;
  String phoneNumber;
  BankAccount account;

  Client(this.name, this.address, this.phoneNumber, this.account);

  @override
  String toString() {
    return 'Client(Name: $name, Address: $address, Phone: $phoneNumber, Account: ${account.accountID})';
  }
}
