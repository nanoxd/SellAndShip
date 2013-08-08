Product.delete_all
Product.create!(title: 'Hammer',
  description:
    %{<p>
        A hammer is a tool meant to deliver an impact to an object. The most common uses for hammers are to drive nails, fit parts, forge metal and break apart objects
      </p>},
  image_url:   'hammer.jpg',
  price: 19.99)
# . . .
Product.create!(title: 'Phillips Screwdriver',
  description:
    %{<p>
        A screwdriver screws on screws :).
      </p>},
  image_url: 'screwdriver.jpg',
  price: 9.95)
# . . .

Product.create!(title: 'Drill',
  description:
    %{<p>
         A drill is a tool fitted with a cutting tool attachment or driving tool attachment, usually a drill bit or driver bit, used for drilling holes in various materials or fastening various materials together with the use of fasteners.
      </p>},
  image_url: 'drill.jpg',
  price: 34.95)
