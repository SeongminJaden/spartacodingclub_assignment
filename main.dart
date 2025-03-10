import 'dart:io';

class Product {
  String name;
  int price;

  Product(this.name, this.price);
}

class ShoppingMall {
  final List<Product> products = [
    Product('셔츠', 45000),
    Product('원피스', 30000),
    Product('반팔티', 35000),
    Product('반바지', 38000),
    Product('양말', 5000),
  ];

  List<Product> cart = [];
  int totalPrice = 0;

  void showProducts() {
    print('\n📌 ---- 상품 목록 ----');
    for (var i = 0; i < products.length; i++) {
      print('${i + 1}. ${products[i].name} - ${products[i].price}원');
    }
    print('----------------------');
  }

  void addToCart(int productIndex, int quantity) {
    if (productIndex >= 1 && productIndex <= products.length && quantity > 0) {
      var selectedProduct = products[productIndex - 1];

      for (var i = 0; i < quantity; i++) {
        cart.add(selectedProduct);
      }

      totalPrice += selectedProduct.price * quantity;

      print('\n🛒 장바구니에 담긴 상품');
      print('상품명: ${selectedProduct.name}');
      print('가격: ${selectedProduct.price}원');
      print('수량: $quantity개');
      print('총 가격: ${selectedProduct.price * quantity}원');
      print('---------------------------------------------');
    } else {
      print('❌ 입력값이 올바르지 않아요!');
    }
  }

  void showCart() {
    if (cart.isEmpty) {
      print('\n🛒 장바구니에 담긴 상품이 없습니다.');
    } else {
      var productNames = cart.map((product) => product.name).toSet().toList();
      print('\n🛒 장바구니에 ${productNames.join(", ")}이(가) 담겨있네요.');
      print('총 $totalPrice 원 입니다!');
    }
  }

  void showTotal() {
    print('\n🛒 현재 장바구니 총 가격: $totalPrice 원');
  }

  void clearCart() {
    if (cart.isEmpty) {
      print('\n❌ 이미 장바구니가 비어있습니다.');
    } else {
      cart.clear();
      totalPrice = 0;
      print('\n🛒 장바구니를 초기화했습니다.');
    }
  }
}

void main() {
  var shoppingMall = ShoppingMall();
  bool isRunning = true;

  while (isRunning) {
    print('\n--- 쇼핑몰 프로그램 ---');
    print('---------------------------------------------');
    print('[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니 목록 확인');
    print('[4] 종료 / [5] 장바구니 총 가격 보기 / [6] 장바구니 초기화');
    print('---------------------------------------------');
    stdout.write('원하는 작업을 선택하세요: ');

    var choice = stdin.readLineSync()?.trim();

    switch (choice) {
      case '1':
        shoppingMall.showProducts();
        break;

      case '2':
        stdout.write('담고 싶은 상품 번호를 입력하세요: ');
        var productIndex = int.tryParse(stdin.readLineSync()?.trim() ?? '');

        if (productIndex != null &&
            productIndex > 0 &&
            productIndex <= shoppingMall.products.length) {
          var selectedProduct = shoppingMall.products[productIndex - 1];
          print(
            '\n📌 선택한 상품: ${selectedProduct.name} (${selectedProduct.price}원)',
          );

          stdout.write('수량을 입력하세요 (1개 이상): ');
          var quantity = int.tryParse(stdin.readLineSync()?.trim() ?? '');

          if (quantity != null && quantity > 0) {
            shoppingMall.addToCart(productIndex, quantity);
          } else {
            print('❌ 0개보다 많은 개수의 상품만 담을 수 있어요!');
          }
        } else {
          print('❌ 입력값이 올바르지 않아요!');
        }
        break;

      case '3':
        shoppingMall.showCart();
        break;

      case '4':
        stdout.write('\n정말 종료하시겠습니까? (5 입력 시 종료): ');
        var confirmExit = stdin.readLineSync()?.trim();
        if (confirmExit == '5') {
          print('\n이용해 주셔서 감사합니다 ~ 안녕히 가세요! 👋');
          isRunning = false;
        } else {
          print('❌ 종료하지 않습니다.');
        }
        break;

      case '5':
        shoppingMall.showTotal();
        break;

      case '6':
        shoppingMall.clearCart();
        break;

      default:
        print('❌ 잘못된 선택입니다. 다시 시도하세요.');
    }
  }
}
