import java.util.ArrayList;
import java.util.Scanner;

public class AnimalRegistry {
    private static ArrayList<Animal> animals = new ArrayList<>();
    private static Scanner scanner = new Scanner(System.in);

    public static void main(String[] args) {
        boolean quit = false;
        while (!quit) {
            printMenu();
            int choice = scanner.nextInt();
            scanner.nextLine();

            switch (choice) {
                case 1:
                    addAnimal();
                    break;
                case 2:
                    showAnimalCommands();
                    break;
                case 3:
                    teachAnimalCommands();
                    break;
                case 4:
                    showAnimals();
                    break;
                case 5:
                    quit = true;
                    break;
                default:
                    System.out.println("Invalid choice.");
                    break;
            }
        }
    }

    private static void printMenu() {
        System.out.println("\nAnimal Registry Menu:");
        System.out.println("---------------------");
        System.out.println("1. Add an animal");
        System.out.println("2. Show animal commands");
        System.out.println("3. Teach animal commands");
        System.out.println("4. Show animals");
        System.out.println("5. Quit");
        System.out.print("Enter your choice: ");
    }

    private static void addAnimal() {
        try (Counter counter = new Counter()) {
            System.out.print("Enter the name of the animal: ");
            String name = scanner.nextLine();

            System.out.print("Enter the type of the animal: ");
            String type = scanner.nextLine();

            Animal newAnimal = new Animal(name, type);
            newAnimal.classify();

            animals.add(newAnimal);

            System.out.println(name + " the " + type + " has been added.");
        } catch (Exception e) {
            System.out.println(e.getLocalizedMessage());
        }

    }

    private static void showAnimalCommands() {
        System.out.print("Enter the name of the animal: ");
        String name = scanner.nextLine();

        Animal animal = findAnimal(name);
        if (animal != null) {
            animal.showCommands();
        } else {
            System.out.println("Animal not found.");
        }
    }

    private static void teachAnimalCommands() {
        System.out.print("Enter the name of the animal to teach: ");
        String name = scanner.nextLine();

        Animal animal = findAnimal(name);
        if (animal != null) {
            System.out.print("Enter the command to teach: ");
            String command = scanner.nextLine();

            animal.addCommand(command);

            System.out.println(command + " has been added to " + name + "'s commands.");
        } else {
            System.out.println("Animal not found.");
        }
    }
    private static void showAnimals() {
        if (animals.isEmpty()) {
            System.out.println("Registry is empty");
        }
        for (Animal animal : animals) {
            System.out.println(animal);
        }
    }
    private static Animal findAnimal(String name) {
        for (Animal animal : animals) {
            if (animal.getName().equalsIgnoreCase(name)) {
                return animal;
            }
        }
        return null;
    }
};