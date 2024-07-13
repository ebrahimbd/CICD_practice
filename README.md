 
```markdown
# Jenkins Setup

1. Install Node.js 16.x and Yarn:

```bash
curl -s https://deb.nodesource.com/setup_16.x | sudo bash
npm install -g yarn
```

2. Install OpenJDK 11:

```bash
sudo apt update
sudo apt install openjdk-11-jdk
```

3. Install Jenkins:

```bash
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] https://pkg.jenkins.io/debian-stable binary/ | sudo tee /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt-get update
sudo apt-get install jenkins
sudo systemctl start jenkins
sudo systemctl enable jenkins
```

4. Access Jenkins:

Visit `http://your_server_ip_or_domain:8080` in your web browser.

5. Retrieve Jenkins Unlock Key:

```bash
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```

Copy the password and paste it in the Jenkins web interface to proceed with the setup.

6. Open Port 8080 for Jenkins (if using a firewall):

```bash
sudo ufw allow 8080
```

7. Jenkins GitHub Webhook:

Add a GitHub webhook with the URL `http://your_server_ip_or_domain:8080/github-webhook/`.

# Docker and Docker Compose Setup

Make sure Docker and Docker Compose are installed on your server. If not, use the following commands:

## Install Docker:

```bash
sudo apt update \
&& sudo apt install -y apt-transport-https ca-certificates curl software-properties-common \
&& curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
&& sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" \
&& apt-cache policy docker-ce \
&& sudo apt install -y docker-ce \
&& sudo usermod -aG docker ${USER} \
&& sudo systemctl status docker \
&& sudo chmod 666 /var/run/docker.sock
```

## Install Docker Compose:

```bash
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose \
&& sudo chmod +x /usr/local/bin/docker-compose \
&& docker-compose --version \
&& sudo chmod 666 /var/run/docker.sock
```

# Jenkins Pipeline Example:

```groovy
pipeline {
    agent any
    stages {
        stage('Build and Run Docker') {
            steps {
                // Get code from a GitHub repository
                git url: 'https://github.com/ebrahimbd/CICD_practice.git', branch: 'main'

                sh "run_docker.sh"
            }
        }
    }
}
```

Make sure to adjust the GitHub repository URL in the Jenkins pipeline according to your project.
```

Feel free to customize the instructions based on your specific needs.


The error "bad interpreter: /bin/bash^M: no such file or directory" indicates that your script has Windows-style line endings (CRLF) instead of Unix-style line endings (LF). The ^M character represents the carriage return (CR) from Windows line endings.

To fix this issue, you can convert the line endings in your script to Unix format. You can use the `dos2unix` command to do this. If it's not installed on your system, you can install it using your package manager. For example, on Ubuntu, you can use:

```bash
sudo apt-get install dos2unix
```

Once installed, run the following command to convert the line endings:

```bash
dos2unix setup.sh
```

Afterwards, try running your setup script again:

```bash
./setup.sh
```

This should resolve the "bad interpreter" issue. The dos2unix command will remove the Windows-style line endings and replace them with Unix-style line endings.



Design patterns are categorized into three main types: Creational, Structural, and Behavioral. Here’s a comprehensive list with class diagrams and examples for each type:

### Creational Patterns

1. **Factory Method Pattern**
2. **Abstract Factory Pattern**
3. **Builder Pattern**
4. **Prototype Pattern**
5. **Singleton Pattern**

#### 1. Factory Method Pattern

**Class Diagram:**
```
+---------------------+         +--------------------+
|     Creator         |<>------>|   Product          |
|---------------------|         |--------------------|
| +factoryMethod()    |         | +operation()       |
+---------------------+         +--------------------+
          |
          |
          |
+---------------------+         +--------------------+
| ConcreteCreator     |<>------>| ConcreteProduct    |
|---------------------|         |--------------------|
| +factoryMethod()    |         | +operation()       |
+---------------------+         +--------------------+
```

**Example Code:**
```python
from abc import ABC, abstractmethod

class Product(ABC):
    @abstractmethod
    def operation(self):
        pass

class ConcreteProduct(Product):
    def operation(self):
        return "ConcreteProduct"

class Creator(ABC):
    @abstractmethod
    def factory_method(self):
        pass

    def some_operation(self):
        product = self.factory_method()
        return product.operation()

class ConcreteCreator(Creator):
    def factory_method(self):
        return ConcreteProduct()

# Usage
creator = ConcreteCreator()
print(creator.some_operation())  # Output: ConcreteProduct
```

#### 2. Abstract Factory Pattern

**Class Diagram:**
```
+---------------------+         +--------------------+
|    AbstractFactory  |<>------>|  AbstractProductA  |
|---------------------|         |--------------------|
| +createProductA()   |         |--------------------|
| +createProductB()   |         |  +operationA()     |
+---------------------+         +--------------------+
          |
          |
          |
+---------------------+         +--------------------+
| ConcreteFactory     |<>------>|  ConcreteProductA  |
|---------------------|         |--------------------|
| +createProductA()   |         |  +operationA()     |
| +createProductB()   |         +--------------------+
+---------------------+         
```

**Example Code:**
```python
from abc import ABC, abstractmethod

class AbstractProductA(ABC):
    @abstractmethod
    def operation_a(self):
        pass

class AbstractProductB(ABC):
    @abstractmethod
    def operation_b(self):
        pass

class ConcreteProductA1(AbstractProductA):
    def operation_a(self):
        return "ProductA1"

class ConcreteProductA2(AbstractProductA):
    def operation_a(self):
        return "ProductA2"

class ConcreteProductB1(AbstractProductB):
    def operation_b(self):
        return "ProductB1"

class ConcreteProductB2(AbstractProductB):
    def operation_b(self):
        return "ProductB2"

class AbstractFactory(ABC):
    @abstractmethod
    def create_product_a(self):
        pass

    @abstractmethod
    def create_product_b(self):
        pass

class ConcreteFactory1(AbstractFactory):
    def create_product_a(self):
        return ConcreteProductA1()

    def create_product_b(self):
        return ConcreteProductB1()

class ConcreteFactory2(AbstractFactory):
    def create_product_a(self):
        return ConcreteProductA2()

    def create_product_b(self):
        return ConcreteProductB2()

# Usage
factory1 = ConcreteFactory1()
product_a1 = factory1.create_product_a()
product_b1 = factory1.create_product_b()

print(product_a1.operation_a())  # Output: ProductA1
print(product_b1.operation_b())  # Output: ProductB1

factory2 = ConcreteFactory2()
product_a2 = factory2.create_product_a()
product_b2 = factory2.create_product_b()

print(product_a2.operation_a())  # Output: ProductA2
print(product_b2.operation_b())  # Output: ProductB2
```

#### 3. Builder Pattern

**Class Diagram:**
```
+---------------------+         +--------------------+
|     Director        |<>------>|  Builder           |
|---------------------|         |--------------------|
| +construct()        |         |--------------------|
+---------------------+         | +buildPart()       |
          |                     +--------------------+
          |                              /|\
          |                               |
+---------------------+         +--------------------+
| ConcreteBuilder     |<>------>| Product           |
|---------------------|         |--------------------|
| +buildPart()        |         |--------------------|
+---------------------+         | +setPart()        |
                                +--------------------+
```

**Example Code:**
```python
class Product:
    def __init__(self):
        self.parts = []

    def add(self, part):
        self.parts.append(part)

    def list_parts(self):
        return ", ".join(self.parts)

class Builder:
    def build_part(self):
        pass

class ConcreteBuilder(Builder):
    def __init__(self):
        self.product = Product()

    def build_part_a(self):
        self.product.add("PartA")

    def build_part_b(self):
        self.product.add("PartB")

    def get_product(self):
        return self.product

class Director:
    def __init__(self, builder):
        self.builder = builder

    def construct(self):
        self.builder.build_part_a()
        self.builder.build_part_b()

# Usage
builder = ConcreteBuilder()
director = Director(builder)
director.construct()
product = builder.get_product()
print(f"Product parts: {product.list_parts()}")  # Output: Product parts: PartA, PartB
```

#### 4. Prototype Pattern

**Class Diagram:**
```
+---------------------+
|    Prototype        |
|---------------------|
| +clone()            |
+---------------------+
         |
         |
+---------------------+
| ConcretePrototype   |
|---------------------|
| +clone()            |
+---------------------+
```

**Example Code:**
```python
import copy

class Prototype:
    def clone(self):
        pass

class ConcretePrototype(Prototype):
    def __init__(self, value):
        self.value = value

    def clone(self):
        return copy.deepcopy(self)

# Usage
prototype = ConcretePrototype("value")
cloned = prototype.clone()
print(prototype.value)  # Output: value
print(cloned.value)     # Output: value
```

#### 5. Singleton Pattern

**Class Diagram:**
```
+---------------------+
|     Singleton       |
|---------------------|
| -instance: Singleton|
|---------------------|
| +get_instance()     |
+---------------------+
```

**Example Code:**
```python
class SingletonMeta(type):
    _instances = {}

    def __call__(cls, *args, **kwargs):
        if cls not in cls._instances:
            cls._instances[cls] = super().__call__(*args, **kwargs)
        return cls._instances[cls]

class Singleton(metaclass=SingletonMeta):
    def some_business_logic(self):
        pass

# Usage
singleton1 = Singleton()
singleton2 = Singleton()
print(singleton1 is singleton2)  # Output: True
```

### Structural Patterns

1. **Adapter Pattern**
2. **Bridge Pattern**
3. **Composite Pattern**
4. **Decorator Pattern**
5. **Facade Pattern**
6. **Flyweight Pattern**
7. **Proxy Pattern**

#### 1. Adapter Pattern

**Class Diagram:**
```
+---------------------+         +--------------------+
|      Target         |<>------>|   Adaptee          |
|---------------------|         |--------------------|
| +request()          |         |--------------------|
+---------------------+         | +specificRequest() |
          |                     +--------------------+
          |
+---------------------+
|    Adapter          |
|---------------------|
| +request()          |
+---------------------+
```

**Example Code:**
```python
class Target:
    def request(self):
        return "Target: The default target's behavior."

class Adaptee:
    def specific_request(self):
        return ".eetpadA eht fo roivaheb laicepS"

class Adapter(Target):
    def __init__(self, adaptee):
        self.adaptee = adaptee

    def request(self):
        return f"Adapter: (TRANSLATED) {self.adaptee.specific_request()[::-1]}"

# Usage
adaptee = Adaptee()
adapter = Adapter(adaptee)
print(adapter.request())  # Output: Adapter: (TRANSLATED) Special behavior of the Adaptee.
```

#### 2. Bridge Pattern

**Class Diagram:**
```
+---------------------+         +--------------------+
|      Abstraction    |<>------>| Implementor        |
|---------------------|         |--------------------|
| +operation()        |         |--------------------|
+---------------------+         | +operation_impl()  |
          |                     +--------------------+
          |
+---------------------+
| RefinedAbstraction  |
|---------------------|
| +operation()        |
+---------------------+
          |
+---------------------+
| ConcreteImplementor |
|---------------------|
| +operation_impl()   |
+---------------------+
```

**Example Code:**
```python
class Implementor:
    def operation_impl(self):
        pass

class ConcreteImplementorA(Implementor):
    def operation_impl(self):
        return "ConcreteImplementorA: Here's the result on the platform A."

class ConcreteImplementorB(Implementor):
    def operation_impl(self):
        return "ConcreteImplementorB: Here's the result on the platform B."

class Ab

straction:
    def __init__(self, implementor):
        self.implementor = implementor

    def operation(self):
        return self.implementor.operation_impl()

# Usage
implementor_a = ConcreteImplementorA()
abstraction = Abstraction(implementor_a)
print(abstraction.operation())  # Output: ConcreteImplementorA: Here's the result on the platform A.

implementor_b = ConcreteImplementorB()
abstraction = Abstraction(implementor_b)
print(abstraction.operation())  # Output: ConcreteImplementorB: Here's the result on the platform B.
```

#### 3. Composite Pattern

**Class Diagram:**
```
+---------------------+
|    Component        |
|---------------------|
| +operation()        |
+---------------------+
          |
          |
+---------------------+       +--------------------+
|   Composite         |<>-----|   Leaf             |
|---------------------|       |--------------------|
| +add(Component)     |       | +operation()       |
| +remove(Component)  |       +--------------------+
| +operation()        |
+---------------------+
```

**Example Code:**
```python
class Component:
    def operation(self):
        pass

class Leaf(Component):
    def operation(self):
        return "Leaf"

class Composite(Component):
    def __init__(self):
        self._children = []

    def add(self, component):
        self._children.append(component)

    def remove(self, component):
        self._children.remove(component)

    def operation(self):
        results = []
        for child in self._children:
            results.append(child.operation())
        return f"Branch({'+'.join(results)})"

# Usage
leaf1 = Leaf()
leaf2 = Leaf()
composite = Composite()
composite.add(leaf1)
composite.add(leaf2)
print(composite.operation())  # Output: Branch(Leaf+Leaf)
```

#### 4. Decorator Pattern

**Class Diagram:**
```
+---------------------+
|   Component         |
|---------------------|
| +operation()        |
+---------------------+
          |
          |
+---------------------+       +--------------------+
|   Decorator         |<>-----|   ConcreteComponent|
|---------------------|       |--------------------|
| +operation()        |       | +operation()       |
+---------------------+       +--------------------+
          |
+---------------------+
| ConcreteDecoratorA  |
|---------------------|
| +operation()        |
+---------------------+
          |
+---------------------+
| ConcreteDecoratorB  |
|---------------------|
| +operation()        |
+---------------------+
```

**Example Code:**
```python
class Component:
    def operation(self):
        pass

class ConcreteComponent(Component):
    def operation(self):
        return "ConcreteComponent"

class Decorator(Component):
    def __init__(self, component):
        self._component = component

    def operation(self):
        return self._component.operation()

class ConcreteDecoratorA(Decorator):
    def operation(self):
        return f"ConcreteDecoratorA({self._component.operation()})"

class ConcreteDecoratorB(Decorator):
    def operation(self):
        return f"ConcreteDecoratorB({self._component.operation()})"

# Usage
simple = ConcreteComponent()
print(simple.operation())  # Output: ConcreteComponent

decorator1 = ConcreteDecoratorA(simple)
print(decorator1.operation())  # Output: ConcreteDecoratorA(ConcreteComponent)

decorator2 = ConcreteDecoratorB(decorator1)
print(decorator2.operation())  # Output: ConcreteDecoratorB(ConcreteDecoratorA(ConcreteComponent))
```

#### 5. Facade Pattern

**Class Diagram:**
```
+---------------------+
|   Facade            |
|---------------------|
| +operation()        |
+---------------------+
          |
          |
+---------------------+       +--------------------+
|   Subsystem1        |       |   Subsystem2       |
|---------------------|       |--------------------|
| +operation1()       |       | +operation2()      |
+---------------------+       +--------------------+
```

**Example Code:**
```python
class Subsystem1:
    def operation1(self):
        return "Subsystem1: Ready!"

class Subsystem2:
    def operation2(self):
        return "Subsystem2: Go!"

class Facade:
    def __init__(self, subsystem1, subsystem2):
        self._subsystem1 = subsystem1
        self._subsystem2 = subsystem2

    def operation(self):
        results = []
        results.append(self._subsystem1.operation1())
        results.append(self._subsystem2.operation2())
        return "\n".join(results)

# Usage
subsystem1 = Subsystem1()
subsystem2 = Subsystem2()
facade = Facade(subsystem1, subsystem2)
print(facade.operation())
# Output:
# Subsystem1: Ready!
# Subsystem2: Go!
```

#### 6. Flyweight Pattern

**Class Diagram:**
```
+---------------------+
|   FlyweightFactory  |
|---------------------|
| +getFlyweight(key)  |
+---------------------+
          |
          |
+---------------------+       +--------------------+
|   Flyweight         |       |   ConcreteFlyweight|
|---------------------|       |--------------------|
| +operation()        |       | +operation()       |
+---------------------+       +--------------------+
```

**Example Code:**
```python
class Flyweight:
    def __init__(self, shared_state):
        self._shared_state = shared_state

    def operation(self, unique_state):
        s = str(self._shared_state)
        u = str(unique_state)
        return f"Flyweight: Displaying shared ({s}) and unique ({u}) state."

class FlyweightFactory:
    _flyweights = {}

    def __init__(self, initial_flyweights):
        for state in initial_flyweights:
            self._flyweights[self.get_key(state)] = Flyweight(state)

    def get_key(self, state):
        return "_".join(sorted(state))

    def get_flyweight(self, shared_state):
        key = self.get_key(shared_state)
        if not self._flyweights.get(key):
            self._flyweights[key] = Flyweight(shared_state)
        return self._flyweights[key]

# Usage
factory = FlyweightFactory([["a", "b", "c"], ["d", "e", "f"]])
flyweight = factory.get_flyweight(["a", "b", "c"])
print(flyweight.operation(["1", "2", "3"]))
# Output: Flyweight: Displaying shared (['a', 'b', 'c']) and unique (['1', '2', '3']) state.
```

#### 7. Proxy Pattern

**Class Diagram:**
```
+---------------------+
|   Subject           |
|---------------------|
| +request()          |
+---------------------+
          |
          |
+---------------------+       +--------------------+
|   RealSubject       |       |   Proxy            |
|---------------------|       |--------------------|
| +request()          |       | +request()         |
+---------------------+       +--------------------+
```

**Example Code:**
```python
class Subject:
    def request(self):
        pass

class RealSubject(Subject):
    def request(self):
        return "RealSubject: Handling request."

class Proxy(Subject):
    def __init__(self, real_subject):
        self._real_subject = real_subject

    def request(self):
        if self.check_access():
            return f"Proxy: {self._real_subject.request()}"
        else:
            return "Proxy: Access denied."

    def check_access(self):
        return True

# Usage
real_subject = RealSubject()
proxy = Proxy(real_subject)
print(proxy.request())  # Output: Proxy: RealSubject: Handling request.
```

### Behavioral Patterns

1. **Chain of Responsibility Pattern**
2. **Command Pattern**
3. **Interpreter Pattern**
4. **Iterator Pattern**
5. **Mediator Pattern**
6. **Memento Pattern**
7. **Observer Pattern**
8. **State Pattern**
9. **Strategy Pattern**
10. **Template Method Pattern**
11. **Visitor Pattern**

#### 1. Chain of Responsibility Pattern

**Class Diagram:**
```
+---------------------+
|    Handler          |
|---------------------|
| +set_next(handler)  |
| +handle(request)    |
+---------------------+
          |
          |
+---------------------+       +--------------------+
| ConcreteHandler1    |       | ConcreteHandler2   |
|---------------------|       |--------------------|
| +handle(request)    |       | +handle(request)   |
+---------------------+       +--------------------+
```

**Example Code:**
```python
class Handler:
    _next_handler = None

    def set_next(self, handler):
        self._next_handler = handler
        return handler

    def handle(self, request):
        if self._next_handler:
            return self._next_handler.handle(request)
        return None

class ConcreteHandler1(Handler):
    def handle(self, request):
        if request == "one":
            return f"Handler1: {request}"
        else:
            return super().handle(request)

class ConcreteHandler2(Handler):
    def handle(self, request):
        if request == "two":
            return f"Handler2: {request}"
        else:
            return super().handle(request)

# Usage
handler1 = ConcreteHandler1()
handler2 = ConcreteHandler2()
handler1.set_next(handler2)

print(handler1.handle("one"))  # Output: Handler1: one
print(handler1.handle("two"))  # Output: Handler2: two
print(handler1.handle("three"))  # Output: None
```

####

 2. Command Pattern

**Class Diagram:**
```
+---------------------+
|    Command          |
|---------------------|
| +execute()          |
+---------------------+
          |
          |
+---------------------+       +--------------------+
| ConcreteCommand     |       | Receiver           |
|---------------------|       |--------------------|
| +execute()          |       | +action()          |
+---------------------+       +--------------------+
          |
+---------------------+
| Invoker             |
|---------------------|
| +set_command(cmd)   |
| +execute_command()  |
+---------------------+
```

**Example Code:**
```python
class Command:
    def execute(self):
        pass

class SimpleCommand(Command):
    def __init__(self, payload):
        self._payload = payload

    def execute(self):
        print(f"SimpleCommand: See, I can do simple things like printing ({self._payload})")

class ComplexCommand(Command):
    def __init__(self, receiver, a, b):
        self._receiver = receiver
        self._a = a
        self._b = b

    def execute(self):
        print("ComplexCommand: Complex stuff should be done by a receiver object")
        self._receiver.do_something(self._a)
        self._receiver.do_something_else(self._b)

class Receiver:
    def do_something(self, a):
        print(f"Receiver: Working on ({a}.)")

    def do_something_else(self, b):
        print(f"Receiver: Also working on ({b}.)")

class Invoker:
    _on_start = None
    _on_finish = None

    def set_on_start(self, command):
        self._on_start = command

    def set_on_finish(self, command):
        self._on_finish = command

    def do_something_important(self):
        print("Invoker: Does anybody want something done before I begin?")
        if isinstance(self._on_start, Command):
            self._on_start.execute()

        print("Invoker: ...doing something really important...")

        print("Invoker: Does anybody want something done after I finish?")
        if isinstance(self._on_finish, Command):
            self._on_finish.execute()

# Usage
invoker = Invoker()
invoker.set_on_start(SimpleCommand("Say Hi!"))
receiver = Receiver()
invoker.set_on_finish(ComplexCommand(receiver, "Send email", "Save report"))

invoker.do_something_important()
```

#### 3. Interpreter Pattern

**Class Diagram:**
```
+---------------------+
|  AbstractExpression |
|---------------------|
| +interpret(context) |
+---------------------+
          |
          |
+---------------------+       +--------------------+
| TerminalExpression  |       | NonTerminalExpression|
|---------------------|       |--------------------|
| +interpret(context) |       | +interpret(context)|
+---------------------+       +--------------------+
```

**Example Code:**
```python
class Context:
    def __init__(self, input):
        self.input = input
        self.output = 0

class AbstractExpression:
    def interpret(self, context):
        pass

class TerminalExpression(AbstractExpression):
    def interpret(self, context):
        context.output += 1

class NonTerminalExpression(AbstractExpression):
    def interpret(self, context):
        context.output += 2

# Usage
context = Context("some input")
expressions = [TerminalExpression(), NonTerminalExpression()]

for expression in expressions:
    expression.interpret(context)

print(context.output)  # Output: 3
```

#### 4. Iterator Pattern

**Class Diagram:**
```
+---------------------+
|  Iterator           |
|---------------------|
| +next()             |
+---------------------+
          |
          |
+---------------------+       +--------------------+
| ConcreteIterator    |       | Aggregate          |
|---------------------|       |--------------------|
| +next()             |       | +createIterator()  |
+---------------------+       +--------------------+
          |
+---------------------+
| ConcreteAggregate   |
|---------------------|
| +createIterator()   |
+---------------------+
```

**Example Code:**
```python
class Iterator:
    def __init__(self, collection):
        self._collection = collection
        self._index = 0

    def __next__(self):
        try:
            value = self._collection[self._index]
        except IndexError:
            raise StopIteration()
        self._index += 1
        return value

class Iterable:
    def __init__(self, collection):
        self._collection = collection

    def __iter__(self):
        return Iterator(self._collection)

# Usage
collection = Iterable([1, 2, 3, 4, 5])
for item in collection:
    print(item)
```

#### 5. Mediator Pattern

**Class Diagram:**
```
+---------------------+
|   Mediator          |
|---------------------|
| +notify(sender, evt)|
+---------------------+
          |
          |
+---------------------+       +--------------------+
| ConcreteMediator    |       | Colleague          |
|---------------------|       |--------------------|
| +notify(sender, evt)|       | +receive(evt)      |
+---------------------+       +--------------------+
          |
+---------------------+
| ConcreteColleague   |
|---------------------|
| +receive(evt)       |
+---------------------+
```

**Example Code:**
```python
class Mediator:
    def notify(self, sender, event):
        pass

class ConcreteMediator(Mediator):
    def __init__(self, component1, component2):
        self._component1 = component1
        self._component1.set_mediator(self)
        self._component2 = component2
        self._component2.set_mediator(self)

    def notify(self, sender, event):
        if event == "A":
            print("Mediator reacts on A and triggers B:")
            self._component2.do_c()
        elif event == "D":
            print("Mediator reacts on D and triggers C:")
            self._component1.do_b()

class BaseComponent:
    def __init__(self, mediator=None):
        self._mediator = mediator

    def set_mediator(self, mediator):
        self._mediator = mediator

class Component1(BaseComponent):
    def do_a(self):
        print("Component 1 does A.")
        self._mediator.notify(self, "A")

    def do_b(self):
        print("Component 1 does B.")

class Component2(BaseComponent):
    def do_c(self):
        print("Component 2 does C.")
        self._mediator.notify(self, "D")

    def do_d(self):
        print("Component 2 does D.")

# Usage
component1 = Component1()
component2 = Component2()
mediator = ConcreteMediator(component1, component2)

component1.do_a()
component2.do_d()
```

#### 6. Memento Pattern

**Class Diagram:**
```
+---------------------+
|   Memento           |
|---------------------|
| +get_state()        |
+---------------------+
          |
          |
+---------------------+       +--------------------+
| Originator          |       | Caretaker          |
|---------------------|       |--------------------|
| +set_state(state)   |       | +save()            |
| +create_memento()   |       | +restore()         |
+---------------------+       +--------------------+
```

**Example Code:**
```python
class Memento:
    def __init__(self, state):
        self._state = state

    def get_state(self):
        return self._state

class Originator:
    _state = None

    def __init__(self, state):
        self._state = state

    def set_state(self, state):
        self._state = state

    def save(self):
        return Memento(self._state)

    def restore(self, memento):
        self._state = memento.get_state()

class Caretaker:
    def __init__(self, originator):
        self._mementos = []
        self._originator = originator

    def backup(self):
        self._mementos.append(self._originator.save())

    def undo(self):
        if not len(self._mementos):
            return
        memento = self._mementos.pop()
        self._originator.restore(memento)

# Usage
originator = Originator("State1")
caretaker = Caretaker(originator)

caretaker.backup()
originator.set_state("State2")
print(originator._state)  # Output: State2

caretaker.undo()
print(originator._state)  # Output: State1
```

#### 7. Observer Pattern

**Class Diagram:**
```
+---------------------+
|   Subject           |
|---------------------|
| +attach(observer)   |
| +detach(observer)   |
| +notify()           |
+---------------------+
          |
          |
+---------------------+       +--------------------+
| ConcreteSubject     |       | Observer           |
|---------------------|       |--------------------|
| +get_state()        |       | +update()          |
+---------------------+       +--------------------+
          |
+---------------------+
| ConcreteObserver    |
|---------------------|
| +update()           |
+---------------------+
```

**Example Code:**
```python
class Subject:
    _state = None
    _observers = []

    def attach(self, observer):
        self._observers.append(observer)

    def detach(self, observer):
        self._observers.remove(observer)

    def notify(self):
        for observer in self._observers:
            observer.update(self._state)

class ConcreteSubject(Subject):
    def set_state(self, state):
        self._

state = state
        self.notify()

class Observer:
    def update(self, state):
        pass

class ConcreteObserver(Observer):
    def __init__(self, name):
        self._name = name

    def update(self, state):
        print(f"{self._name} received update: {state}")

# Usage
subject = ConcreteSubject()
observer1 = ConcreteObserver("Observer1")
observer2 = ConcreteObserver("Observer2")

subject.attach(observer1)
subject.attach(observer2)

subject.set_state("State1")
# Output: 
# Observer1 received update: State1
# Observer2 received update: State1

subject.set_state("State2")
# Output:
# Observer1 received update: State2
# Observer2 received update: State2
```

#### 8. State Pattern

**Class Diagram:**
```
+---------------------+
|   State             |
|---------------------|
| +handle()           |
+---------------------+
          |
          |
+---------------------+       +--------------------+
| ConcreteStateA      |       | Context            |
|---------------------|       |--------------------|
| +handle()           |       | +set_state(state)  |
+---------------------+       +--------------------+
          |
+---------------------+
| ConcreteStateB      |
|---------------------|
| +handle()           |
+---------------------+
```

**Example Code:**
```python
class Context:
    _state = None

    def __init__(self, state):
        self.transition_to(state)

    def transition_to(self, state):
        self._state = state
        self._state.context = self

    def request(self):
        self._state.handle()

class State:
    def __init__(self):
        self.context = None

    def handle(self):
        pass

class ConcreteStateA(State):
    def handle(self):
        print("ConcreteStateA handles request.")
        print("ConcreteStateA wants to change the state of the context.")
        self.context.transition_to(ConcreteStateB())

class ConcreteStateB(State):
    def handle(self):
        print("ConcreteStateB handles request.")
        print("ConcreteStateB wants to change the state of the context.")
        self.context.transition_to(ConcreteStateA())

# Usage
context = Context(ConcreteStateA())
context.request()
context.request()
```

#### 9. Strategy Pattern

**Class Diagram:**
```
+---------------------+
|   Strategy          |
|---------------------|
| +execute()          |
+---------------------+
          |
          |
+---------------------+       +--------------------+
| ConcreteStrategyA   |       | Context            |
|---------------------|       |--------------------|
| +execute()          |       | +set_strategy(st)  |
+---------------------+       | +execute_strategy()|
                              +--------------------+
          |
+---------------------+
| ConcreteStrategyB   |
|---------------------|
| +execute()          |
+---------------------+
```

**Example Code:**
```python
class Context:
    def __init__(self, strategy):
        self._strategy = strategy

    def set_strategy(self, strategy):
        self._strategy = strategy

    def execute_strategy(self, data):
        return self._strategy.execute(data)

class Strategy:
    def execute(self, data):
        pass

class ConcreteStrategyA(Strategy):
    def execute(self, data):
        return sorted(data)

class ConcreteStrategyB(Strategy):
    def execute(self, data):
        return sorted(data, reverse=True)

# Usage
context = Context(ConcreteStrategyA())
data = [3, 1, 4, 1, 5, 9]
print(context.execute_strategy(data))  # Output: [1, 1, 3, 4, 5, 9]

context.set_strategy(ConcreteStrategyB())
print(context.execute_strategy(data))  # Output: [9, 5, 4, 3, 1, 1]
```

#### 10. Template Method Pattern

**Class Diagram:**
```
+---------------------+
|   AbstractClass     |
|---------------------|
| +template_method()  |
| +primitive_operation|
+---------------------+
          |
          |
+---------------------+       +--------------------+
| ConcreteClass       |       | ConcreteClass      |
|---------------------|       |--------------------|
| +primitive_operation|       | +primitive_operation|
+---------------------+       +--------------------+
```

**Example Code:**
```python
class AbstractClass:
    def template_method(self):
        self.primitive_operation1()
        self.primitive_operation2()

    def primitive_operation1(self):
        pass

    def primitive_operation2(self):
        pass

class ConcreteClass1(AbstractClass):
    def primitive_operation1(self):
        print("ConcreteClass1: Implemented Operation1")

    def primitive_operation2(self):
        print("ConcreteClass1: Implemented Operation2")

class ConcreteClass2(AbstractClass):
    def primitive_operation1(self):
        print("ConcreteClass2: Implemented Operation1")

    def primitive_operation2(self):
        print("ConcreteClass2: Implemented Operation2")

# Usage
concrete1 = ConcreteClass1()
concrete1.template_method()
# Output:
# ConcreteClass1: Implemented Operation1
# ConcreteClass1: Implemented Operation2

concrete2 = ConcreteClass2()
concrete2.template_method()
# Output:
# ConcreteClass2: Implemented Operation1
# ConcreteClass2: Implemented Operation2
```

#### 11. Visitor Pattern

**Class Diagram:**
```
+---------------------+
|   Visitor           |
|---------------------|
| +visitElementA()    |
| +visitElementB()    |
+---------------------+
          |
          |
+---------------------+       +--------------------+
| ConcreteVisitor1    |       | Element            |
|---------------------|       |--------------------|
| +visitElementA()    |       | +accept(visitor)   |
| +visitElementB()    |       +--------------------+
+---------------------+                 |
                                       |
+---------------------+       +--------------------+
| ConcreteVisitor2    |       | ConcreteElementA   |
|---------------------|       |--------------------|
| +visitElementA()    |       | +accept(visitor)   |
| +visitElementB()    |       | +operationA()      |
+---------------------+       +--------------------+
          |
+---------------------+       +--------------------+
| ConcreteVisitor3    |       | ConcreteElementB   |
|---------------------|       |--------------------|
| +visitElementA()    |       | +accept(visitor)   |
| +visitElementB()    |       | +operationB()      |
+---------------------+       +--------------------+
```

**Example Code:**
```python
class Visitor:
    def visit_element_a(self, element):
        pass

    def visit_element_b(self, element):
        pass

class ConcreteVisitor1(Visitor):
    def visit_element_a(self, element):
        print(f"{element.operation_a()} + ConcreteVisitor1")

    def visit_element_b(self, element):
        print(f"{element.operation_b()} + ConcreteVisitor1")

class ConcreteVisitor2(Visitor):
    def visit_element_a(self, element):
        print(f"{element.operation_a()} + ConcreteVisitor2")

    def visit_element_b(self, element):
        print(f"{element.operation_b()} + ConcreteVisitor2")

class Element:
    def accept(self, visitor):
        pass

class ConcreteElementA(Element):
    def accept(self, visitor):
        visitor.visit_element_a(self)

    def operation_a(self):
        return "ConcreteElementA"

class ConcreteElementB(Element):
    def accept(self, visitor):
        visitor.visit_element_b(self)

    def operation_b(self):
        return "ConcreteElementB"

# Usage
elements = [ConcreteElementA(), ConcreteElementB()]
visitor1 = ConcreteVisitor1()
visitor2 = ConcreteVisitor2()

for element in elements:
    element.accept(visitor1)
    element.accept(visitor2)
# Output:
# ConcreteElementA + ConcreteVisitor1
# ConcreteElementA + ConcreteVisitor2
# ConcreteElementB + ConcreteVisitor1
# ConcreteElementB + ConcreteVisitor2
```

These examples cover some of the most common design patterns in Python. Each pattern is demonstrated with simple, self-contained examples that illustrate their core concepts and usage.
