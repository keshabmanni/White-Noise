class CategoryModel {
  String category;
  int categoryId;

  CategoryModel({this.categoryId, this.category});
}

List<CategoryModel> categoryItems = [
  CategoryModel(categoryId: 1, category: "RAIN"),
  CategoryModel(categoryId: 2, category: "Forest"),
  CategoryModel(categoryId: 3, category: "Natural"),
  CategoryModel(categoryId: 4, category: "River"),
  CategoryModel(categoryId: 5, category: "Flow"),
  CategoryModel(categoryId: 6, category: "Outer"),
  CategoryModel(categoryId: 7, category: "City"),
  CategoryModel(categoryId: 8, category: "Underwater"),
  CategoryModel(categoryId: 9, category: "Waterfall"),
];
