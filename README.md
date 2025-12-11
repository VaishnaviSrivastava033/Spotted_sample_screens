# 📱 Spotted WhatsApp Message Management Demo  
A Flutter-based demo application showcasing how Spotted merchants can manage WhatsApp message templates and view message logs.  
This project was built as an assignment to demonstrate UI design, data handling, and workflow understanding based on the provided PRD and sample UI screens.

---

## 🚀 Overview  
This demo simulates a simplified version of Spotted’s internal WhatsApp messaging system for merchants.  
The app contains:

- **A Templates Screen** for viewing available WhatsApp message templates  
- **A Message Logs Screen** for tracking sent message records  
- **Clean, pastel-themed UI** inspired by the sample Spotted merchant screens  
- **Mock data only (no backend/API calls)**  
- **Navigation setup for multi-screen flow**

The goal is to demonstrate the UI structure, user experience, and how messaging workflows could be visualised in a full product.

---

## 🖼 UI Inspiration  
The design is inspired by the Spotted UI samples provided, featuring:

- Soft pastel cards (pink, yellow, green, blue)  
- Rounded 20–24px corners  
- Minimal shadows and clean spacing  
- Friendly icons  
- Simple, modern headers (no AppBars)  
- Light background and airy layout  

This ensures the app visually aligns with Spotted’s brand and design system.

---

## 🧩 Features

### ⭐ Templates Screen
- Displays a list of WhatsApp message templates  
- Template details include:
  - Name  
  - Type (`text`, `media`, `interactive`)  
  - Status (`approved`, `pending`, `rejected`)  
  - Created & last-used timestamps  
- Pastel-colored template cards inspired by Spotted’s UI  
- Tap any card to open a bottom sheet with actions:
  - View Template  
  - Edit Template  
  - Delete Template  

---

### ⭐ Message Logs Screen
- Displays logs of messages sent using WhatsApp templates  
- Each log shows:
  - Customer number  
  - Template name  
  - Message status (`sent`, `delivered`, `read`, `failed`)  
  - Timestamp  
  - Optional error message  
- Filter chips for quick sorting  
- Beautiful pastel log cards with status icon and badge  
- Modern, clean header layout  

---

## 🛠 Tech Stack

- **Flutter 3.x**
- **Dart**
- **Intl package** (timestamp formatting)
- **Material Design components**
- **StatefulWidgets + Mock Data**

No backend or API integration was required for this demo.

---

## 📂 Folder Structure
lib/
├── screens/
│ ├── templates_screen.dart
│ ├── message_logs_screen.dart
├── main.dart
└── widgets/ (optional future components)


---

## 🔄 Data Flow  
### Templates  
- Loaded locally through mock data  
- Can be edited/viewed/deleted through UI actions  
- Represents how merchants create or manage WhatsApp Business API templates  

### Message Logs  
- Simulated list of sent messages  
- Useful for illustrating post-message analytics  
- Reflects how message delivery statuses would appear in the real product  

---

## 🎨 Design Choices  
The UI is crafted to match the feel of Spotted’s internal tools:

- Pastel color palette  
- Elevated rounded cards  
- Clean typography  
- Declarative layout with padding and spacing  
- Friendly visual hierarchy  

This aligns with modern mobile-first product design expectations.

---

## 🚧 Future Enhancements (If extended)
- Add backend integration for real message logs  
- Add WhatsApp API integration for template syncing  
- Add user authentication  
- Add pagination & filtering options  
- Add template creation form  
- Add analytics dashboard for sent messages  

---

## 📬 Contact
This project was created as part of an assignment/demo.  
Feel free to reach out for improvements or collaboration.


## Contact

Vaishnavi Srivastava  
vaishnavisrivastav033@gmail.com 

Made with ❤️ using Flutter
