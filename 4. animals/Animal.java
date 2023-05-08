import java.util.ArrayList;

public class Animal {
    private String name;
    private String type;
    private String classification;
    private ArrayList<String> commands = new ArrayList<>();

    public Animal(String name, String type) {
        this.name = name;
        this.type = type;
    }

    public String getName() {
        return name;
    }

    public void classify() {
        if (type.equalsIgnoreCase("cat") ||
                type.equalsIgnoreCase("dog") ||
                type.equalsIgnoreCase("hamster")) {
            classification = "pet";
        } else if (type.equalsIgnoreCase("horse") ||
                type.equalsIgnoreCase("donkey") ||
                type.equalsIgnoreCase("camel")) {
            classification = "pack animal";
        } else {
            classification = "Unknown";
        }
        System.out.println(name + " the " + type + " is classified as a " + classification);
    }

    public void showCommands() {
        if (commands.isEmpty()) {
            System.out.println(name + " does not know any commands yet.");
        } else {
            System.out.println(commands);
        }
    };

    public void addCommand(String command) {
        if (commands.contains(command)) {
            System.out.println(command + "already added");
        } else {
            commands.add(command);
        }
    }

    @Override
    public String toString() {
        return name + " " + type + " " + classification;
    }
}