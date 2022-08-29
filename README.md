# Flatlist Scroll

<hr />
Flatlist Scroll is library help user scroll fetch data from API with return next number page.
- Scroll paginate return next page number
- Build item widget in listview
- Load more data when user scroll to bottom
- Catch error if response null from API

## Screenshot

<img src="https://raw.githubusercontent.com/RathaIct/Flatlist-Scroll-Plugin/main/demo.gif" width="320" />
<img src="https://raw.githubusercontent.com/RathaIct/Flatlist-Scroll-Plugin/main/demo2.gif" width="320" />

## Usage

```dart
    // Widget fetch data list
    FlatlistScroll(
        // Controller scroll in list
        controller: ScrollController(),
        // Data input in list
        data: data,
        // Return page number start from 1
        onLoadMore: fetchData,
        // Render Widget item in list
        renderItem: (item) => _buildItem(item),
        // Height pixel bottom of list when load more data.
        onLoadMoreThreshold: 300,
      )
```

## អ្នកបង្កើត

<img src="https://raw.githubusercontent.com/RathaIct/KhmerDateDart/main/ratha.jpeg" width="150" />
<hr />
លោក ហ៊ិន រដ្ឋា
<br />
ជំនាញ បង្កើតកម្មវិធីទូរស័ព្ទ
<br />
បទពិសោធន៍ Flutter, ReactNative, Laravel
<br />
ទូរស័ព្ទ 096 659 2250 📞

### គេហទំព័រ

<a href="https://rathadev.site"  target="_blank">Ratha Dev</a>
