# clean_architecture_riverpod

Intent: Designed for medium and large Flutter apps.

---

## 🏗️ Clean Architecture Overview

### 📂 Data Layer  
The **Data layer** is responsible for handling data and centralizing the data flow. It typically contains the following folders:

- **Models**  
  - Represent the structure of the data.  
  - Handle data serialization/deserialization (e.g., with JSON or Freezed).  
  - Models can extend or map to entities if you use a Domain layer.  

- **Repositories**  
  - Contain abstract classes (contracts) defining how data is accessed.  
  - Centralize the data flow for the app.  
  - Concrete implementations interact with services for local storage and remote APIs.  

- **Services**  
  - Contain integrations with remote APIs or local services.  
  - Provide raw data fetching or storage functionality.  
  - Repositories call services to get or store data.  

---

### 🎨 Presentation Layer  
The **Presentation layer** handles the **user interface** and **state management**.  
It consumes data from providers (or use cases, if a Domain layer exists) and updates the UI accordingly.  

- **Providers**  
  - A `Provider` is a way to create and share objects or values across your app.  
  - It manages dependencies so you don’t have to create them manually.  
  - This keeps your code **cleaner, reusable, and testable**.  

---

### ⚙️ Core Layer  
The **Core layer** contains shared, reusable code that can be used across the entire app.  
It does not depend on the Data or Presentation layers. Typical contents include:  

- Utils / Helpers (e.g., `hive_secure_helper.dart`)  
- Exceptions (e.g., `app_exceptions.dart`)  
- Types / Wrappers (e.g., `either.dart`)  
- Configuration / Flavor (e.g., `flavor_manager.dart`)  
- Constants (e.g., `app_constants.dart`)  

---

### 🧩 Domain Layer  
Currently, I’m **not using a Domain layer**.  
For now:  
- I work directly with **data models**.  
- I fetch data through **providers** and display it in the UI.  

Later, the Domain layer can be introduced with:  
- **Entities**  
- **Use cases**  
- **Repository interfaces**  

---

✨ This structure keeps responsibilities separated and makes the app more scalable, testable, and maintainable.
