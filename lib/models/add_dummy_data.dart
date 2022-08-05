import 'package:travel_app/models/database.dart';
import 'package:travel_app/models/travel_icons_icons.dart';

getTravelIcon(type) {
  var icon = TravelIcons.ac;
  switch (type) {
    case 'wifi':
      icon = TravelIcons.wifi;
      break;
    case 'pool':
      icon = TravelIcons.pool;
      break;
    case 'dinner':
      icon = TravelIcons.dinner;
      break;
    case 'ac':
      icon = TravelIcons.ac;
      break;
    default:
  }
  return icon;
}

var dsc_lorem = [
  'sit amet purus gravida quis blandit turpis cursus in hac habitasse platea dictumst quisque sagittis purus sit amet volutpat consequat mauris nunc congue nisi vitae suscipit tellus mauris a diam maecenas sed enim ut sem viverra aliquet eget sit amet tellus cras adipiscing enim eu turpis egestas pretium aenean pharetra',
  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
  'dignissim cras tincidunt lobortis feugiat vivamus at augue eget arcu dictum varius duis at consectetur lorem donec massa sapien faucibus et molestie ac feugiat sed lectus vestibulum mattis ullamcorper velit sed ullamcorper morbi tincidunt ornare massa eget egestas purus viverra accumsan in nisl nisi scelerisque eu ultrices vitae auctor eu',
  'viverra adipiscing at in tellus integer feugiat scelerisque varius morbi enim nunc faucibus a pellentesque sit amet porttitor eget dolor morbi non arcu risus quis varius quam quisque id diam vel quam elementum pulvinar etiam non quam lacus suspendisse faucibus interdum posuere lorem ipsum dolor sit amet consectetur adipiscing elit',
  'mauris augue neque gravida in fermentum et sollicitudin ac orci phasellus egestas tellus rutrum tellus pellentesque eu tincidunt tortor aliquam nulla facilisi cras fermentum odio eu feugiat pretium nibh ipsum consequat nisl vel pretium lectus quam id leo in vitae turpis massa sed elementum tempus egestas sed sed risus pretium'
];

var data1 = Place(
  img:
      'https://firebasestorage.googleapis.com/v0/b/testdatabase-b2a97.appspot.com/o/belot.jpeg?alt=media&token=7d29a6f5-d351-4b05-8815-e5040284f2e6',
  judul: 'Borneo Island',
  agen: "Mak Panjul",
  dsc: dsc_lorem[0],
  favorite: true,
  harga: 40.2,
  fasilitas: ['wifi', 'ac'],
  lokasi: 'Borneo',
  star: 3.2,
  tag: Tag(popular: false, recom: true),
);
var data2 = Place(
  img:
      'https://firebasestorage.googleapis.com/v0/b/testdatabase-b2a97.appspot.com/o/gili.jpg?alt=media&token=07ffef59-0022-4d41-8380-28c154f37214',
  judul: 'Gili Beach',
  agen: "Andre",
  dsc: dsc_lorem[1],
  favorite: false,
  harga: 500,
  fasilitas: ['wifi', 'ac', 'pool', 'dinner'],
  lokasi: 'Gili, Indonesia',
  star: 4.5,
  tag: Tag(popular: false, recom: false),
);
var data3 = Place(
  img:
      'https://firebasestorage.googleapis.com/v0/b/testdatabase-b2a97.appspot.com/o/mercure_hotel.jpg?alt=media&token=98eab20e-0723-4e6f-ad46-234850038f26',
  judul: 'Mercure Hotel',
  agen: "Alexander",
  dsc: dsc_lorem[2],
  favorite: true,
  harga: 1000,
  fasilitas: ['wifi', 'ac'],
  lokasi: 'Jakarta, Kemayoran',
  star: 3,
  tag: Tag(popular: true, recom: false),
);
var data4 = Place(
  img:
      'https://firebasestorage.googleapis.com/v0/b/testdatabase-b2a97.appspot.com/o/sameru.jpg?alt=media&token=7c992d50-a25b-46d3-8cc3-3ef1034c4ed3',
  judul: 'Sameru Mountain',
  agen: "Kang Asep",
  dsc: dsc_lorem[0],
  favorite: true,
  harga: 30.5,
  fasilitas: ['dinner'],
  lokasi: 'East Java, Indonesia',
  star: 5,
  tag: Tag(popular: true, recom: true),
);
var data5 = Place(
  img:
      'https://firebasestorage.googleapis.com/v0/b/testdatabase-b2a97.appspot.com/o/shangri.jpg?alt=media&token=7995e986-38e3-4d08-8599-80dbf762ab11',
  judul: 'Shangri-La Hotel',
  agen: "Josh",
  dsc: dsc_lorem[4],
  favorite: true,
  harga: 250,
  fasilitas: ['wifi', 'ac', 'dinner', 'pool'],
  lokasi: 'Tokyo, Japan',
  star: 4.5,
  tag: Tag(popular: true, recom: true),
);
var data6 = Place(
  img:
      'https://firebasestorage.googleapis.com/v0/b/testdatabase-b2a97.appspot.com/o/pura_ulundanu.jpg?alt=media&token=bedc1af5-5427-442c-96c7-b4ed492038cd',
  judul: 'Ulun Danu Bratan',
  agen: "Bli Made",
  dsc: dsc_lorem[4],
  favorite: true,
  harga: 100,
  fasilitas: ['wifi', 'dinner'],
  lokasi: 'Bali, Indonesia',
  star: 5,
  tag: Tag(popular: true, recom: true),
);
var data7 = Place(
  img:
      'https://firebasestorage.googleapis.com/v0/b/testdatabase-b2a97.appspot.com/o/borneo.jpg?alt=media&token=f3b1d7e7-1c92-46fd-8345-dfe421ca3210',
  judul: 'Borneo Island',
  agen: "Mak Panjul",
  dsc: dsc_lorem[0],
  favorite: false,
  harga: 40.2,
  fasilitas: ['dinner'],
  lokasi: 'Kalimantan,Indonesia',
  star: 3.8,
  tag: Tag(popular: false, recom: true),
);
var data8 = Place(
  img:
      'https://firebasestorage.googleapis.com/v0/b/testdatabase-b2a97.appspot.com/o/rianjani.jpg?alt=media&token=3fa23b3e-bc95-4d9f-8978-70763afd379c',
  judul: 'Rinjani Mountain',
  agen: "Dollan",
  dsc: dsc_lorem[2],
  favorite: false,
  harga: 350,
  fasilitas: ['dinner'],
  lokasi: 'Lombok, Indonesia',
  star: 4.7,
  tag: Tag(popular: true, recom: false),
);
var data9 = Place(
  img:
      'https://firebasestorage.googleapis.com/v0/b/testdatabase-b2a97.appspot.com/o/rianjani.jpg?alt=media&token=3fa23b3e-bc95-4d9f-8978-70763afd379c',
  judul: 'Borneo Island',
  agen: "Mak Panjul",
  dsc: dsc_lorem[0],
  favorite: true,
  harga: 40.2,
  fasilitas: ['wifi', 'ac'],
  lokasi: 'Borneo',
  star: 3.2,
  tag: Tag(popular: false, recom: true),
);
var data10 = Place(
  img:
      'https://firebasestorage.googleapis.com/v0/b/testdatabase-b2a97.appspot.com/o/gunungagung.jpg?alt=media&token=6dc00427-0c57-469e-be55-f8ab799a1d76',
  judul: 'Gunung Agung',
  agen: "Pak Ketut",
  dsc: dsc_lorem[4],
  favorite: false,
  harga: 99.9,
  fasilitas: ['dinner'],
  lokasi: 'Bali, Indonesia',
  star: 4.1,
  tag: Tag(popular: false, recom: false),
);
