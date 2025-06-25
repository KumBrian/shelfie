import { StyleSheet, Text, useColorScheme, View } from "react-native";
import { Slot, Stack } from "expo-router";
import { Colors } from "../constants/Colors";
import { StatusBar } from "expo-status-bar";

const RootLayout = () => {
  const colorScheme = useColorScheme();
  const theme = Colors[colorScheme] || Colors.light;
  return (
    <>
      <StatusBar style="auto" />
      <Stack
        screenOptions={{
          headerStyle: { backgroundColor: theme.navBackground },
          headerTintColor: theme.title,
          headerTitleAlign: "center",
          headerTitleStyle: { fontWeight: "bold" },
          headerBackButtonMenuEnabled: true,
        }}
      >
        <Stack.Screen
          name="index"
          options={{
            title: "Home",
          }}
        ></Stack.Screen>
        <Stack.Screen
          name="about"
          options={{
            title: "About",
          }}
        ></Stack.Screen>
        <Stack.Screen
          name="contact"
          options={{
            title: "Contact",
          }}
        ></Stack.Screen>
      </Stack>
    </>
  );
};

export default RootLayout;

const styles = StyleSheet.create({});
