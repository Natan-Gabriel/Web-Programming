package webubb.domain;

public class Station {
    private int id;
    private String current;
    private String next;

    public Station(int id, String current, String next) {
        this.id = id;
        this.current = current;
        this.next = next;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCurrent() {
        return current;
    }

    public void setCurrent(String current) {
        this.current = current;
    }

    public String getNext() {
        return next;
    }

    public void setNext(String current) {
        this.next = next;
    }
}
