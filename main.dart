import 'dart:io';

class Product {
  String name;
  int price;

  Product(this.name, this.price);
}

class ShoppingMall {
  // 상품 목록
  final List<Product> products = [
    Product('셔츠', 45000),
    Product('원피스', 30000),
    Product('반팔티', 35000),
    Product('반바지', 38000),
    Product('양말', 5000),
  ];

  List<Product> cart = [];
  int totalPrice = 0;

  // 상품 목록을 출력하는 메서드
  void showProducts() {
    print('---- 상품 목록 ----');
    for (var i = 0; i < products.length; i++) {
      print('${i + 1}. ${products[i].name} - ${products[i].price}원');
    }
    print('-------------------');
  }

  // 상품을 장바구니에 담는 메서드 (수량 추가)
  void addToCart(int productIndex, int quantity) {
    if (productIndex >= 1 && productIndex <= products.length && quantity > 0) {
      var selectedProduct = products[productIndex - 1];

      for (var i = 0; i < quantity; i++) {
        cart.add(selectedProduct);
      }

      totalPrice += selectedProduct.price * quantity;

      // ✅ 선택한 상품 출력
      print('\n🛒 장바구니에 담긴 상품');
      print('상품명: ${selectedProduct.name}');
      print('가격: ${selectedProduct.price}원');
      print('수량: $quantity개');
      print('총 가격: ${selectedProduct.price * quantity}원');
      print('---------------------------------------------');
    } else {
      print('입력값이 올바르지 않아요!');
    }
  }

  // 장바구니 총 가격을 출력하는 메서드
  void showTotal() {
    print('\n🛒 현재 장바구니 총 가격: $totalPrice 원');
  }
}

void main() {
  var shoppingMall = ShoppingMall();
  bool isRunning = true;

  while (isRunning) {
    print('\n--- 쇼핑몰 프로그램 ---');
    print('---------------------------------------------');
    print('[1] 상품 목록 보기 / [2] 장바구니에 담기 / [3] 장바구니 총 가격 보기 / [4] 종료');
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
        shoppingMall.showTotal();
        break;

      case '4':
        print('이용해 주셔서 감사합니다 ~ 안녕히 가세요! 👋');
        isRunning = false;
        break;

      default:
        print('❌ 잘못된 선택입니다. 다시 시도하세요.');
    }
  }
}
