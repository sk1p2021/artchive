import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class MainApplication {
    private static List<Artwork> inventory = new ArrayList<>();

    private static void addArtwork(Scanner scanner) {
        System.out.println("Enter artwork details:");
        System.out.print("Title: ");
        String title = scanner.nextLine();
        System.out.print("Creation Date: ");
        String creationDate = scanner.nextLine();
        System.out.print("Medium: ");
        String medium = scanner.nextLine();
        System.out.print("Dimensions: ");
        String dimensions = scanner.nextLine();
        System.out.print("Price: ");
        double price = Double.parseDouble(scanner.nextLine());
        inventory.add(new Artwork(title, creationDate, medium, dimensions, price));
        System.out.println("Artwork added.\n");
    }

    private static void listArtworks() {
        if (inventory.isEmpty()) {
            System.out.println("No artworks in inventory.\n");
            return;
        }
        inventory.forEach(System.out::println);
        System.out.println();
    }

    private static void markAsSold(Scanner scanner) {
        System.out.print("Enter the title of the artwork to mark as sold: ");
        String title = scanner.nextLine();
        for (Artwork artwork : inventory) {
            if (artwork.getTitle().equals(title)) {
                artwork.markAsSold();
                System.out.println("Artwork marked as sold.\n");
                return;
            }
        }
        System.out.println("Artwork not found.\n");
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        while (true) {
            System.out.println("Art Inventory System");
            System.out.println("1. Add Artwork");
            System.out.println("2. List Artworks");
            System.out.println("3. Mark Artwork as Sold");
            System.out.println("4. Exit");
            System.out.print("Select an option: ");
            String option = scanner.nextLine();
            switch (option) {
                case "1":
                    addArtwork(scanner);
                    break;
                case "2":
                    listArtworks();
                    break;
                case "3":
                    markAsSold(scanner);
                    break;
                case "4":
                    scanner.close();
                    return;
                default:
                    System.out.println("Invalid option selected.\n");
                    break;
            }
        }
    }
}
