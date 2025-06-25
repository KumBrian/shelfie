import { StyleSheet, Text, View, Image, useColorScheme } from "react-native";
import { Link } from "expo-router";
import Logo from "../assets/splash-icon.png";
import { Colors } from "../constants/Colors";

const Home = () => {
  const colorScheme = useColorScheme();
  const theme = Colors[colorScheme] ?? Colors.light;
  return (
    <View style={[styles.container, { backgroundColor: theme.background }]}>
      <Image
        source={Logo}
        style={[styles.logo, { backgroundColor: theme.navBackground }]}
      />
      <Text style={[styles.title, { color: theme.text }]}>The Number 1</Text>
      <Text style={{ marginTop: 10, marginBottom: 30, color: theme.text }}>
        Reading List App
      </Text>

      <Link
        href="/about"
        style={[
          styles.card,
          { backgroundColor: theme.navBackground, color: theme.text },
        ]}
      >
        About
      </Link>
      <Link
        href="/contact"
        style={[
          styles.card,
          { backgroundColor: theme.navBackground, color: theme.text },
        ]}
      >
        Contact
      </Link>
    </View>
  );
};

export default Home;

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
    marginVertical: 20,
    padding: 20,
    borderRadius: 10,
    boxShadow: "4px 4px rgba(0,0,0,0.1)",
  },
});
