class Artwork:
    def __init__(self, title, creation_date, medium, dimensions, price):
        self.title = title
        self.creation_date = creation_date
        self.medium = medium
        self.dimensions = dimensions
        self.price = price
        self.is_sold = False

    def mark_as_sold(self):
        self.is_sold = True

    def __str__(self):
        return (f"Title: {self.title}, Date: {self.creation_date}, Medium: {self.medium}, "
                f"Dimensions: {self.dimensions}, Price: ${self.price:.2f}, Sold: {'Yes' if self.is_sold else 'No'}")

def add_artwork(artworks):
    print("Enter artwork details:")
    title = input("Title: ")
    creation_date = input("Creation Date: ")
    medium = input("Medium: ")
    dimensions = input("Dimensions: ")
    price = float(input("Price: "))
    artworks.append(Artwork(title, creation_date, medium, dimensions, price))
    print("Artwork added.\n")

def list_artworks(artworks):
    if not artworks:
        print("No artworks in inventory.\n")
    else:
        for artwork in artworks:
            print(artwork)
        print()

def mark_as_sold(artworks):
    title = input("Enter the title of the artwork to mark as sold: ")
    for artwork in artworks:
        if artwork.title == title:
            artwork.mark_as_sold()
            print("Artwork marked as sold.\n")
            return
    print("Artwork not found.\n")

if __name__ == "__main__":
    artworks = []
    while True:
        print("Art Inventory System")
        print("1. Add Artwork")
        print("2. List Artworks")
        print("3. Mark Artwork as Sold")
        print("4. Exit")
        option = input("Select an option: ")

        if option == "1":
            add_artwork(artworks)
        elif option == "2":
            list_artworks(artworks)
        elif option == "3":
            mark_as_sold(artworks)
        elif option == "4":
            break
        else:
            print("Invalid option selected.\n")
