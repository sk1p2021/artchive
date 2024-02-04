public class Artwork {
    private String title;
    private String creationDate;
    private String medium;
    private String dimensions;
    private double price;
    private boolean isSold;

    public Artwork(String title, String creationDate, String medium, String dimensions, double price) {
        this.title = title;
        this.creationDate = creationDate;
        this.medium = medium;
        this.dimensions = dimensions;
        this.price = price;
        this.isSold = false;
    }

    public String getTitle() {
        return title;
    }

    public void markAsSold() {
        isSold = true;
    }

    @Override
    public String toString() {
        return String.format("Title: %s, Date: %s, Medium: %s, Dimensions: %s, Price: $%.2f, Sold: %s",
                title, creationDate, medium, dimensions, price, isSold ? "Yes" : "No");
    }
}
