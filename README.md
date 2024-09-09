# Product Manager App

A Flutter-based mobile application for managing a list of products with support for adding, updating, and deleting products. The app uses SQLite for local data storage and provides a clean user interface for product management.

## Features

- **Add Product**: Users can add a new product with details like product name, description, and unit price.
- **Update Product**: Existing products can be updated with new information.
- **Delete Product**: Users can delete products from the list.
- **Product List**: View a list of all products stored locally.
- **SQLite Integration**: Data is stored persistently on the device using SQLite.
- **User-Friendly UI**: Simple and intuitive interface for easy navigation.

## Screenshots
(Add screenshots of your app here if available)

## Getting Started

### Prerequisites

- Flutter SDK: [Installation Guide](https://flutter.dev/docs/get-started/install)
- A device or emulator to run the app (Android or iOS)
- SQLite for Flutter

### Installation

1. Clone the repository:

    ```bash
    git clone https://github.com/an90ass/Product-Manager.git
    ```

2. Navigate to the project directory:

    ```bash
    cd product_manager_app
    ```

3. Install the required dependencies:

    ```bash
    flutter pub get
    ```

4. Run the app:

    ```bash
    flutter run
    ```

### Folder Structure

```bash
lib/
├── data/
│   ├── dbHelper.dart    # SQLite database helper
├── models/
│   ├── product.dart     # Product model
├── screens/
│   ├── product_add.dart # Screen to add a product
│   ├── product_detail.dart # Screen for product details and actions
│   ├── product_list.dart # Main screen displaying product list
