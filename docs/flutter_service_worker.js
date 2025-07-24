'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "7763dca7a0b5316c19e5b7bad9d9e62c",
"version.json": "8a7a4a7ca212f1af18cfedb8ecd2a222",
"index.html": "6f489aa97269b3feec44b6f91445b66b",
"/": "6f489aa97269b3feec44b6f91445b66b",
"main.dart.js": "939a9b87ddefd3dfc235bbd74cedcada",
"flutter.js": "f393d3c16b631f36852323de8e583132",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "c1010ab242dae95c22b4f9056b54db7c",
"assets/AssetManifest.json": "0e8fdc18404d25340da5c009ad414879",
"assets/NOTICES": "4553221923edf35d1135039ccad50d17",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "bfd74cfbdf4c7350e819619dd931f86b",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "0117f3fc9488d93e3596a2c4551f8257",
"assets/fonts/MaterialIcons-Regular.otf": "3aa07bbf69b6df4dd5704719a189c94b",
"assets/assets/images/hand_gesture/winter_png.png": "84f3adba6ce23c11e4072f84e998c5d7",
"assets/assets/images/hand_gesture/hoodie_png.png": "e5a2ec918ad91c59d3ced22dc0d94ae5",
"assets/assets/images/hand_gesture/pajama_png.png": "2c3a889000e46e0ba6ce55e83504f7c3",
"assets/assets/images/hand_gesture/brown_png.png": "08a190c758c4e188273ba17234e0d4f2",
"assets/assets/images/hand_gesture/black_png.png": "cdaadab8a27d0346ed5a1e1ec99b2fa9",
"assets/assets/images/hand_gesture/white_png.png": "5a365cbf9f019f19cdc7380307046339",
"assets/assets/images/hand_gesture/pe_uniform_png.png": "142b6cd7e9cf525dca16fad17a6e86a6",
"assets/assets/images/hand_gesture/folder_16_png.png": "df1b29760ac66bd7ac7cb5dfb94f1a66",
"assets/assets/images/hand_gesture/school_uniform_png.png": "df2ad3b83a89ca4bf8f1f54910938289",
"assets/assets/images/hand_gesture/red_2_png.png": "668f5047bbb329356306f51f0d814475",
"assets/assets/images/blush/1_png.png": "13c91539905e9d180535bcc3c2813ea5",
"assets/assets/images/blush/2_png.png": "883cfbe40b42f1746fad7a105b523de7",
"assets/assets/images/base_body_png.png": "5384da11b282feb50dbada1c87242b98",
"assets/assets/images/ahoge/silver_png.png": "6c3d26f6e470348fb1091e99098a5750",
"assets/assets/images/ahoge/brown_png.png": "b1d2a11a5ab2fa6d2d12108174af4f0f",
"assets/assets/images/ahoge/green_png.png": "4467232a32d91778843e29b04d762ff2",
"assets/assets/images/ahoge/blond_png.png": "901ac27b43101fa866ed0539d676ba2e",
"assets/assets/images/ahoge/blue_png.png": "c4643e58850c2620308b27f696ef52f1",
"assets/assets/images/ahoge/dark_png.png": "1c76633d5de8725de94431a99260173b",
"assets/assets/images/ahoge/pink_png.png": "e25a0682bd0ea237ee0453b8028d47c7",
"assets/assets/images/ahoge/red_png.png": "f1573f123853e35781aa8b1a9d66173a",
"assets/assets/images/costume/school_uniform_4_png.png": "c57d06ccdf94b770054ef04694c1940f",
"assets/assets/images/costume/swimsuit_5_png.png": "b72e0d9446b2ca871e97f1eed481fcd6",
"assets/assets/images/costume/sswimsuit_png.png": "b7451525dc22a0b4b707c7ce8b8f3d81",
"assets/assets/images/costume/casual_clothing_2_png.png": "e4dcd2e51eceac670d65067f6b791f4e",
"assets/assets/images/costume/lab_coat_png.png": "8f361aebad8d5c3270935b58591b187b",
"assets/assets/images/costume/black_hoodie_png.png": "6262f2605e064454ebd228826e34fd6c",
"assets/assets/images/costume/hoodie_1_png.png": "8412f695a4382b64ba900cce8ef933cd",
"assets/assets/images/costume/winter_outfit_png.png": "5356d5dba21a729176ebedc0e8045d55",
"assets/assets/images/costume/school_uniform_5_png.png": "d3066ba7df3dac3afd0993e4a28d1467",
"assets/assets/images/costume/pajama_png.png": "2d2c67fe18077f4d854cc587ffaa7aa6",
"assets/assets/images/costume/swimsuit_4_png.png": "f394512e35eff3e9f0aa57ccff56de12",
"assets/assets/images/costume/casual_clothing_3_png.png": "7ba62ce7bb2dff9a59f0a16028556612",
"assets/assets/images/costume/casual_clothing_8_png.png": "e438bb7bcaca1164f5ebfffbb43c6a2e",
"assets/assets/images/costume/school_uniform_6_png.png": "2dc3d99e37487c649d0eb6539904cf87",
"assets/assets/images/costume/winter_outfit2_png.png": "6c5d80f4c025d59abff225bd71f531fb",
"assets/assets/images/costume/pajama_2_png.png": "afbb35d1bcf29d1f9dc4c03cbdb17346",
"assets/assets/images/costume/casual_clothing_9_png.png": "97e0f5277fd0bc9a912ec1e9178a9f76",
"assets/assets/images/costume/maid_png.png": "6c220061dcc9235b00c8f6f5e31815c6",
"assets/assets/images/costume/pe_uniform_png.png": "250abec87bf4dbe9dab5f891529c850c",
"assets/assets/images/costume/towel_png.png": "97ad2180d93ac02d302145006a06af12",
"assets/assets/images/costume/casual_clothing_png.png": "a9c4612b4d5c6fb7d344b1dce86a70f2",
"assets/assets/images/costume/underwear_2_png.png": "f600efbc7371d3353efa82c970b376a0",
"assets/assets/images/costume/swimsuit_2_png.png": "49d3205d1ae3523ce26419fe3545202b",
"assets/assets/images/costume/school_uniform_3_png.png": "6b1acb551aef61bda1f4a6f27daec6bf",
"assets/assets/images/costume/underwear_3_png.png": "99e8f5c0d2dc8a1e63f569d6260843b0",
"assets/assets/images/costume/swimsuit_3_png.png": "695eca1fcc7e355cdecf5e4482d195a9",
"assets/assets/images/costume/casual_clothing_4_png.png": "e1ee233f9a571eb64277fb99ba920f4b",
"assets/assets/images/costume/school_uniform_2_png.png": "68cef09a4ef16db051024cbb0f9ebbd2",
"assets/assets/images/costume/casual_clothing5_png.png": "3675abd7944a1cb71848e0064a826e14",
"assets/assets/images/costume/kimono_1_png.png": "491d19117240bda307b383630d9573d5",
"assets/assets/images/costume/summer_dress_png.png": "25276f521bde4cb571531fc1a5b54070",
"assets/assets/images/costume/underwear_1_png.png": "be96b32e6f508b109d2dfd346daa9002",
"assets/assets/images/costume/casual_clothing_6_png.png": "ac607661160598e1ed7cd65af6c6a04f",
"assets/assets/images/costume/kimono_3_png.png": "7c48c134073c884497dc9f73a80f5f00",
"assets/assets/images/costume/kimono_2_png.png": "a7dd469726d479f5fb605e16dae22db3",
"assets/assets/images/costume/school_uniform_1_png.png": "a0a565d94e21cdabe443bbf7ce136876",
"assets/assets/images/costume/casual_clothing_7_png.png": "e862c10c3fb841482d4a5330f1750b4f",
"assets/assets/images/hair_front/middle_part/silver_png.png": "74e945a6c8d7f8b04e663bff6becd62d",
"assets/assets/images/hair_front/middle_part/brown_png.png": "78f8702b09c61b747bb0d2f71a4e7a69",
"assets/assets/images/hair_front/middle_part/green_png.png": "d81e74970e85a878ea27e2998d0d0043",
"assets/assets/images/hair_front/middle_part/blond_png.png": "8fb9cecd9082a77166bec6873a08fc5a",
"assets/assets/images/hair_front/middle_part/blue_png.png": "71d2f04fc203fb7a40883dd970705f5e",
"assets/assets/images/hair_front/middle_part/dark_png.png": "6bd4756b20f745d33a2c682d191d9108",
"assets/assets/images/hair_front/middle_part/pink_png.png": "2f31d9cad1d0c13e1472866c75d26470",
"assets/assets/images/hair_front/middle_part/red_png.png": "a51f7683fe6fbf1816ed28be6acc5a08",
"assets/assets/images/hair_front/short/silver_png.png": "ba0e4ff8758443c3f762c046fbfdf737",
"assets/assets/images/hair_front/short/blondie_copy_png.png": "bfe81038d0541db70d0ac5a2368e31f9",
"assets/assets/images/hair_front/short/brown_png.png": "46ebbbf80ff935022a021d3938c055c4",
"assets/assets/images/hair_front/short/green_png.png": "2a3ad2a407afaed6af4b53d182741093",
"assets/assets/images/hair_front/short/blue_png.png": "a9cb6b69a640b813ba14a2d70fe147b5",
"assets/assets/images/hair_front/short/pink_png.png": "353b74b90798a3046835302dc057e2db",
"assets/assets/images/hair_front/short/dark_copy_png.png": "3de87e33188c556c806515706b5346f1",
"assets/assets/images/hair_front/short/red_png.png": "e773191209f161a1b84976d8568c5117",
"assets/assets/images/hair_front/side/silver_png.png": "4dc1241a76e0b85e49d1810c4f47b2e6",
"assets/assets/images/hair_front/side/brown_png.png": "941952ed6f5e811425512456a2282302",
"assets/assets/images/hair_front/side/green_png.png": "5db311c029125db4148468db29598074",
"assets/assets/images/hair_front/side/blond_png.png": "28190f7f76709a80d4af9981c829e499",
"assets/assets/images/hair_front/side/blue_png.png": "716943d59f17ca7474d900903a2ec52e",
"assets/assets/images/hair_front/side/dark_png.png": "9215c4915866f6352f7924587d87a292",
"assets/assets/images/hair_front/side/pink_png.png": "fae1f5bdb52b22ad799e30838a268211",
"assets/assets/images/hair_front/side/red_png.png": "b4264e169e118175d1987e06315393bb",
"assets/assets/images/hair_front/hime_cut/silver_png.png": "dc3a3986cb43cee0ad320c34a03e1955",
"assets/assets/images/hair_front/hime_cut/blondie_png.png": "3f19c46c0e7a4a32b7a2750a295ab44d",
"assets/assets/images/hair_front/hime_cut/brown_png.png": "a74dbfb73130cbd4c6bc9fe0b437fb34",
"assets/assets/images/hair_front/hime_cut/green_png.png": "b7ef4d5a1199f9ae7e4ea0ffe8c056cb",
"assets/assets/images/hair_front/hime_cut/blue_png.png": "eb1a92397732e8f6b149d637f714c69d",
"assets/assets/images/hair_front/hime_cut/dark_png.png": "a01de3d82e193b451b90a3d5e9752950",
"assets/assets/images/hair_front/hime_cut/pink_png.png": "7a0832958ca675d6b19279704da92deb",
"assets/assets/images/hair_front/hime_cut/red_png.png": "c41f0cc72888a26adfbd1b72b248e35a",
"assets/assets/images/hair_front/curl/silvr_png.png": "19afc9a21ba9eb6b65f93f22083acf53",
"assets/assets/images/hair_front/curl/brown_png.png": "5df2736548bda19ce484cd2f0ddc5d7c",
"assets/assets/images/hair_front/curl/green_png.png": "fdf28359071fcad71cbd07a1cc02eac3",
"assets/assets/images/hair_front/curl/blond_png.png": "5a9a92b4b31df631d91f0d6aa470d895",
"assets/assets/images/hair_front/curl/blue_png.png": "7dc7f7c3ecf2c3b80752f0b862c1634f",
"assets/assets/images/hair_front/curl/dark_png.png": "c59c4505a624eb0ac870aeac8c69cfa7",
"assets/assets/images/hair_front/curl/pink_png.png": "858eed3fe9b343b5e8bd883071df4e8a",
"assets/assets/images/hair_front/curl/red_png.png": "7acf125aa6424b2b5ef0266da13ba12e",
"assets/assets/images/hair_front/long/silver_png.png": "8120e7ef4c14e179ac8811263dcfa02d",
"assets/assets/images/hair_front/long/blondie_png.png": "c8cae6b0b3554958dbde494dcd7b42a2",
"assets/assets/images/hair_front/long/brown_png.png": "2352efe461e0576bd9edc8cd92d243f9",
"assets/assets/images/hair_front/long/green_png.png": "8aed757d6597146b40f5ea786f929d10",
"assets/assets/images/hair_front/long/blue_png.png": "442779abc90782c8d008c8e8db4a7344",
"assets/assets/images/hair_front/long/dark_png.png": "a65dedb0f1f5461fe78a86e2317386e9",
"assets/assets/images/hair_front/long/pink_png.png": "a9fc16fba0cc9a41f843ec24351baab6",
"assets/assets/images/hair_front/long/red_png.png": "e8bc2e9af2bc56075f1bc2a4bcf3e165",
"assets/assets/images/hair_front/hime_cut_short/silver_png.png": "dd2191e7bd2c564ed09b36453700af9a",
"assets/assets/images/hair_front/hime_cut_short/blondie_png.png": "72bc0aea30da80c8278defb3ec050a83",
"assets/assets/images/hair_front/hime_cut_short/brown_png.png": "9320a16ace7b5e30206e1eb5c7ae7d3b",
"assets/assets/images/hair_front/hime_cut_short/green_png.png": "83dc6804e9b148fcc6e288538d21e7a6",
"assets/assets/images/hair_front/hime_cut_short/blue_png.png": "112ac0892ee5d98e9e4f3c8bf87c5b77",
"assets/assets/images/hair_front/hime_cut_short/dark_png.png": "888c53db9300ebeea7f1e20dffeb7311",
"assets/assets/images/hair_front/hime_cut_short/pink_png.png": "e889861ddf078438ddd2c63ba19d9216",
"assets/assets/images/hair_front/hime_cut_short/red_png.png": "cb0715e89fa42c5ad7bc4a6feeba092b",
"assets/assets/images/hair_front/short_bob/silver_png.png": "6aa1a8b2a756ceeaa180d23405f4bbbe",
"assets/assets/images/hair_front/short_bob/blondie_png.png": "7a9bc26d4b9d21fb2953e370f49926a8",
"assets/assets/images/hair_front/short_bob/brown_png.png": "f3a1709e99df0233454b80d379385317",
"assets/assets/images/hair_front/short_bob/green_png.png": "7ae15ba55070577ee746d639a49d0ab6",
"assets/assets/images/hair_front/short_bob/blue_png.png": "5f2479cb7580b9b971dd51575c074556",
"assets/assets/images/hair_front/short_bob/dark_png.png": "a7e3663c11a93327dafad5b2f50fcbe8",
"assets/assets/images/hair_front/short_bob/pink_png.png": "a5df9961cc7a9be56d03873aacbc1e05",
"assets/assets/images/hair_front/short_bob/red_png.png": "691431d272cb5baf8a368d8950a6c800",
"assets/assets/images/accessories_front/circle_glasses_png.png": "1eb415b3bd7dfbadf5ff2e288db1a6f4",
"assets/assets/images/accessories_front/band_1_png.png": "32b54dd8bcfa468482b35a0ad64d5db6",
"assets/assets/images/accessories_front/choker_png.png": "2f9484e5434068f72bb1023ba601e8ae",
"assets/assets/images/accessories_front/white_ribbon_png.png": "cb6d54ae2e55504d6bbd42ff2ba85474",
"assets/assets/images/accessories_front/yellow_ribbon_png.png": "00ad58cfa2cc280f4fb9768bee83a532",
"assets/assets/images/accessories_front/band_2_png.png": "af1bfa679e299a17391e5d6f9242aa66",
"assets/assets/images/accessories_front/black_glasses_png.png": "4b0eabfb23206034223bad5a2ed4ea0a",
"assets/assets/images/accessories_front/black_ribbon_png.png": "2735a6f3fe5e58ad0bc47bd545264f6b",
"assets/assets/images/accessories_front/band3_png.png": "52b237cf83247657e210892dc96dfd7f",
"assets/assets/images/accessories_front/red_glasses_png.png": "3e73e0e7bc5bb43636791d916c6e2664",
"assets/assets/images/accessories_front/ribbon_png.png": "4776911f93a1a8e64b2b4337aa7fc5ac",
"assets/assets/images/accessories_front/rose_2_png.png": "b203f50bf1318c6ac3bd5361ad596e88",
"assets/assets/images/accessories_front/rose_png.png": "44fb600fbff5bf6843bcb1eb4e099cd5",
"assets/assets/images/accessories_front/flower_png.png": "a7c641e0b844e1282b11064f22f5369a",
"assets/assets/images/expression/o_png.png": "80035e7f96a88f36618e07f6496b55ea",
"assets/assets/images/expression/smile_2_png.png": "043f571d35c896eb9a3d805e4342e87a",
"assets/assets/images/expression/shocked_png.png": "93730496e93611fa288b1222a91f0268",
"assets/assets/images/expression/angry_png.png": "3c3cadb526f485b6c05ab44cb85198fb",
"assets/assets/images/expression/annoyed_png.png": "59eda4da1fc53658b03fb2491168cb03",
"assets/assets/images/expression/sad_png.png": "865014141a28dc44888b51e1b3c8887f",
"assets/assets/images/expression/laugh_png.png": "440b9986c17752238bdb975df7700899",
"assets/assets/images/expression/delighted_png.png": "89b2546185ecf9f89387c5dd3b0c56a9",
"assets/assets/images/expression/smile_png.png": "97e5de6203bce3abf97d914f2b44af97",
"assets/assets/images/expression/normal_png.png": "6420157992dc2141ce1615fa8e8ac1a9",
"assets/assets/images/expression/sleepy_png.png": "ca66a5cb52f3cb2eba8df30bcf257540",
"assets/assets/images/expression/color_edit_png.png": "39e62ddd4408f395a789edbb8eb9ddf1",
"assets/assets/images/expression/smug_png.png": "5573ac94a753d2a82b46ba5a591a6323",
"assets/assets/images/hair_behind/twin_tail/silver_png.png": "ad4818241f1b494db4ed596c623945c2",
"assets/assets/images/hair_behind/twin_tail/blondie_png.png": "8981f3d086e2ce6d5cb33b5a14d81f83",
"assets/assets/images/hair_behind/twin_tail/brown_png.png": "ffc6f46b08c226e0d2e2ce098589cdb1",
"assets/assets/images/hair_behind/twin_tail/green_png.png": "7283d98cd91d7603e2d5029b8ec38922",
"assets/assets/images/hair_behind/twin_tail/blue_png.png": "71651b5d53adcda5053c99b129cbbde8",
"assets/assets/images/hair_behind/twin_tail/dark_png.png": "22b484ed61269870a1b865a9437a8a43",
"assets/assets/images/hair_behind/twin_tail/pink_png.png": "ea2299bfb5eff24267f7d2eb70c32861",
"assets/assets/images/hair_behind/twin_tail/red_png.png": "1043d4b9dcfdc75001beffd29a3a2902",
"assets/assets/images/hair_behind/short_hair_2/silver_png.png": "d9a157d65562b5a834142e22d3734eac",
"assets/assets/images/hair_behind/short_hair_2/blondie_png.png": "9aa58fccf6bfd5d06110c3ae7f76a94e",
"assets/assets/images/hair_behind/short_hair_2/brown_png.png": "80da136e3874f9ba54152255d2663efa",
"assets/assets/images/hair_behind/short_hair_2/green_png.png": "3632d26727ab41d0520a9a002a3805f3",
"assets/assets/images/hair_behind/short_hair_2/blue_png.png": "a137d8c7ae0c27a90c9ef5bbfdcc82b5",
"assets/assets/images/hair_behind/short_hair_2/dark_png.png": "9fbb3591397f9702348852106a1b7d2f",
"assets/assets/images/hair_behind/short_hair_2/pink_png.png": "be85ae811d81861bb1a6540fa0f62758",
"assets/assets/images/hair_behind/short_hair_2/red_png.png": "cacb9e26f7b933afe602c73f723597cf",
"assets/assets/images/hair_behind/long_hair_hime_cut/silver_png.png": "120a05cf01d90560eff48ed9f2f55a65",
"assets/assets/images/hair_behind/long_hair_hime_cut/blondie_png.png": "7536eb8809854da9d5fde86257c3be3c",
"assets/assets/images/hair_behind/long_hair_hime_cut/brown_png.png": "520a4d2a8e6001b12f3ce964b80d7b70",
"assets/assets/images/hair_behind/long_hair_hime_cut/green_png.png": "0aac98d1413252ac421d9769fffd8d58",
"assets/assets/images/hair_behind/long_hair_hime_cut/blue_png.png": "c580b2726df17cf2813cf56203559c07",
"assets/assets/images/hair_behind/long_hair_hime_cut/dark_png.png": "c93fda9470f7ae0266bd10fc4a28bf55",
"assets/assets/images/hair_behind/long_hair_hime_cut/pink_png.png": "cb6884986c16f8019829e79b87b4a530",
"assets/assets/images/hair_behind/long_hair_hime_cut/red_png.png": "b3a51385df231fe9e0f2fb92fe1e291c",
"assets/assets/images/hair_behind/short_curly/silver_png.png": "03d4c453901f88b9ec9ba998a1fa0860",
"assets/assets/images/hair_behind/short_curly/brown_png.png": "884511f2cdbecfc497dc1e0d4a3928d8",
"assets/assets/images/hair_behind/short_curly/green_png.png": "a4a77271acef8ee56b6339ed966964a4",
"assets/assets/images/hair_behind/short_curly/blond_png.png": "812e861b8a3dcad0da9f0727dd8e6c94",
"assets/assets/images/hair_behind/short_curly/blue_png.png": "8ebb2e401303d8349e1e0bffd9aa9d27",
"assets/assets/images/hair_behind/short_curly/dark_png.png": "aa5afd9ddacbf03cde27f3489c2fa500",
"assets/assets/images/hair_behind/short_curly/pink_png.png": "20349f11e5f9227b83b289f18fb363d4",
"assets/assets/images/hair_behind/short_curly/red_png.png": "cb9503f7107d20848830d14c8ae67299",
"assets/assets/images/hair_behind/twintail_3/silver_png.png": "3ad4d3a8577ab974c4a053e11c9aae14",
"assets/assets/images/hair_behind/twintail_3/brown_png.png": "2b6c38a98aeaf32b0f90ec5f6aab8e9c",
"assets/assets/images/hair_behind/twintail_3/green_png.png": "25a3d0ece740306d5d6d2464cd491e42",
"assets/assets/images/hair_behind/twintail_3/blond_png.png": "6e9108d4630603773651f883fb155289",
"assets/assets/images/hair_behind/twintail_3/rred_png.png": "fab6586baba6ad162e712f2aab5a89ba",
"assets/assets/images/hair_behind/twintail_3/blue_png.png": "48e69182e2b3d76db2a276b481c8f0ee",
"assets/assets/images/hair_behind/twintail_3/dark_png.png": "c2dd5501fb774eb0c0fb0e4c846c9fc1",
"assets/assets/images/hair_behind/twintail_3/pink_png.png": "486bd600784a46df52ae1c094caea050",
"assets/assets/images/hair_behind/short_hair/silver_png.png": "9c512b4aa4110c28738e073b142b5b5f",
"assets/assets/images/hair_behind/short_hair/blondie_png.png": "4db5f67c391d9184c6259b962ee1d4db",
"assets/assets/images/hair_behind/short_hair/brown_png.png": "982023390944986ca8abcfda55adf9c4",
"assets/assets/images/hair_behind/short_hair/green_png.png": "46008b9214a7381a358c00bf39938544",
"assets/assets/images/hair_behind/short_hair/blue_png.png": "3b42c13565233613c780dd16943b5fb7",
"assets/assets/images/hair_behind/short_hair/dark_png.png": "4735cc05a429de7ef40b4da9bc410478",
"assets/assets/images/hair_behind/short_hair/pink_png.png": "a4ab24c1655332f5eb0121149ae11dd9",
"assets/assets/images/hair_behind/short_hair/red_png.png": "f266fa621738cd18f1a161703857d20c",
"assets/assets/images/hair_behind/twin_tail_2/silver_png.png": "479434ecf96d49a50938225816a67dbf",
"assets/assets/images/hair_behind/twin_tail_2/brown_png.png": "eccda3f89025b9aa03044ca49b9877f5",
"assets/assets/images/hair_behind/twin_tail_2/green_png.png": "bfbfa45fb6a9314c651110e725b4cc46",
"assets/assets/images/hair_behind/twin_tail_2/blond_png.png": "201819b72c13803696090200b26d1331",
"assets/assets/images/hair_behind/twin_tail_2/blue_png.png": "2eb8ef988d89447406fa624cac84348f",
"assets/assets/images/hair_behind/twin_tail_2/dark_png.png": "8a5d435cdbcfd28ba92e2747095af020",
"assets/assets/images/hair_behind/twin_tail_2/pink_png.png": "4fb939b2a9c1cf58b72ae0ac7ceda840",
"assets/assets/images/hair_behind/twin_tail_2/red_png.png": "317a3964d64317e17e30da8293e0623d",
"assets/assets/images/hair_behind/short_bob/silver_png.png": "f9523890be6d357c05f7168fa704fa82",
"assets/assets/images/hair_behind/short_bob/blondie_png.png": "69bebb85fd26b54d7ffebaafd353d15f",
"assets/assets/images/hair_behind/short_bob/brown_png.png": "7c10dc0ff5a2a256f813fcb91ede49d6",
"assets/assets/images/hair_behind/short_bob/green_png.png": "038e5ed88950e835d61f1edd7a6254ad",
"assets/assets/images/hair_behind/short_bob/blue_png.png": "f5b54fb90c2561decf105ed6a7c55606",
"assets/assets/images/hair_behind/short_bob/dark_png.png": "8388b142f6eaae589efe3758a8e10d57",
"assets/assets/images/hair_behind/short_bob/pink_png.png": "7bdd9c450f7087e112ff46ee74b84876",
"assets/assets/images/hair_behind/short_bob/red_png.png": "7cbc84ff87d6426305a96ae82f5121e5",
"assets/assets/images/hair_behind/long_curl/silver_png.png": "ad2c0f13333612d50c31501308dc461e",
"assets/assets/images/hair_behind/long_curl/blondie_png.png": "1b1293ce00ea728808617e878c80316f",
"assets/assets/images/hair_behind/long_curl/brown_png.png": "926bd02e94a7c4a36c217f207d54c64f",
"assets/assets/images/hair_behind/long_curl/green_png.png": "2f7cd1ab8440707d351af320c1b2d3b0",
"assets/assets/images/hair_behind/long_curl/blue_png.png": "b91fe0aab3ec474cd93d02a9ca6b5cd1",
"assets/assets/images/hair_behind/long_curl/dark_png.png": "495900dd1f08857d8921bb1e60a3d3a0",
"assets/assets/images/hair_behind/long_curl/pink_png.png": "d66095baf0ee41210f7850f310e8c77e",
"assets/assets/images/hair_behind/long_curl/red_png.png": "be9ba8224e739b88e287b586e5bf8f46",
"assets/assets/metadata.json": "f34326c80d72809b66794aca5e947169",
"assets/assets/metadata.json.backup": "f34326c80d72809b66794aca5e947169",
"canvaskit/skwasm.js": "694fda5704053957c2594de355805228",
"canvaskit/skwasm.js.symbols": "262f4827a1317abb59d71d6c587a93e2",
"canvaskit/canvaskit.js.symbols": "48c83a2ce573d9692e8d970e288d75f7",
"canvaskit/skwasm.wasm": "9f0c0c02b82a910d12ce0543ec130e60",
"canvaskit/chromium/canvaskit.js.symbols": "a012ed99ccba193cf96bb2643003f6fc",
"canvaskit/chromium/canvaskit.js": "671c6b4f8fcc199dcc551c7bb125f239",
"canvaskit/chromium/canvaskit.wasm": "b1ac05b29c127d86df4bcfbf50dd902a",
"canvaskit/canvaskit.js": "66177750aff65a66cb07bb44b8c6422b",
"canvaskit/canvaskit.wasm": "1f237a213d7370cf95f443d896176460",
"canvaskit/skwasm.worker.js": "89990e8c92bcb123999aa81f7e203b1c"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
