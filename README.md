#  <#Title#>

VM uygulamanın beyni hesaplamalar burada olacak yani işin mantığı burada.. Kullanıcının View ile olan etkileşimi de diyebiliriz. Hem kullanıcı dokunduğunda hem de işlenmesi için model

snapshot unit test temel olarak görünümlere birim testleridir. unit testler uygulamamızın iş mantığını korumaktır. peki görünümlerin bütünlüğünü nasıl koruruz? Görüntünün, formatın ve hatta otomatik düzenin tutarlı kalmasını nasıl sağlayabiliriz? Peki formatın tutarlı kalmasını ve yanlışlıkla değiştirilmemesini nasıl sağlayacağız? Gelecekteki biz ve hatta meslektaşlarımız mıo? Bu simgenin farklı bir simge değil, hesap makinesi olarak kalmasını nasıl sağlayabiliriz? bütün bunların cevabı ise snapshot testidir. 

Snapshot testinin çalışma şekli, çerçevenin bir UI componentinin ana ekran görüntüsünü almasıdır. Diyelim ki yerel görünümü geliştirdik ve formattan memnunuz bu görünümün ana kopyasını kaydetmek için snapshot test kullanabiliriz.

Temel olarak bir ekran görüntüsü veya bir jpeg dosyası alır ve bu jpeg dosyasını projemize kaydeder, gelecekte bir snapshot test yaptığımızda, testin yaptığı şey mevcut olanı karşılaştırmak olacaktır ve herhangi bir tutarsızlık bulursa, o zaman test başarısız olacaktır ve bazı değişiklikleri gereksiz yere yapıp yapmadığından emin olmak testi yürüten kişiye kalmıştır, veya bu snapshot testlerini güncellemesi gerekebilir.

Testte aynı simulatörü kullanmak önemli yoksa başarısız bir test elde ederiz.

UI Test ler snapshot veya unit testlerinden farklı olarak öncelikle kullanıcı arayüzünü test eder. Ekran öğelerinin iş mantığıyla nasıl etkileşime girdiğini test eder. 


cmd + shift + o ile hızlı arama 
