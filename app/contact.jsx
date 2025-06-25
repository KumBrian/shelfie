import { StyleSheet, Text, View, useColorScheme } from "react-native";
import { Link } from "expo-router";
import { Colors } from "../constants/Colors";

const Contact = () => {
  const colorScheme = useColorScheme();
  const theme = Colors[colorScheme] || Colors.light;
  return (
    <View style={[styles.container, { backgroundColor: theme.background }]}>
      <Text style={[styles.title, { color: theme.text }]}>Contact Page</Text>
      <Link
        href="/"
        style={[
          styles.card,
          { backgroundColor: theme.navBackground, color: theme.text },
        ]}
      >
        Go Back
      </Link>
    </View>
  );
};

export default Contact;

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: "center",
    alignItems: "center",
  },
  logo: {
    backgroundColor: "#eee",
    borderRadius: 10,
    width: 200,
    height: 200,
    marginBottom: 20,
  },
  title: {
    fontSize: 24,
    fontWeight: "bold",
  },
  card: {
    backgroundColor: "#eee",
    padding: 20,
    borderRadius: 10,
    boxShadow: "4px 4px rgba(0,0,0,0.1)",
  },
});
