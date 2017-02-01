import VPlayApps 1.0
import QtQuick 2.0

App {
    // You get free licenseKeys from http://v-play.net/licenseKey
    // With a licenseKey you can:
    //  * Publish your games & apps for the app stores
    //  * Remove the V-Play Splash Screen or set a custom one (available with the Pro Licenses)
    //  * Add plugins to monetize, analyze & improve your apps (available with the Pro Licenses)
    //licenseKey: "<generate one from http://v-play.net/licenseKey>"

    // property to store whether user is logged
    property bool userLoggedIn: false

    // login page is always visible if user is not logged in
    LoginPage {
        z: 1 // show login above actual app pages
        visible: opacity > 0
        enabled: visible
        opacity: userLoggedIn ? 0 : 1 // hide if user is logged in
        onLoginSucceeded: userLoggedIn = true

        Behavior on opacity { NumberAnimation { duration: 250 } } // page fade in/out
    }

    // navigation with actual app pages
    Navigation {
        id: nav
        enabled: userLoggedIn

        NavigationItem {
            title: "Main"
            icon: IconType.square

            NavigationStack {
                splitView: tablet
                MainPage {
                    onLogoutClicked: userLoggedIn = false
                }
            }
        } // navigation item

        NavigationItem {
            title: "Profile"
            icon: IconType.circle

            NavigationStack {
                ProfilePage {
                    onLogoutClicked: {
                        userLoggedIn = false
                        // jump to main page after logout
                        nav.currentIndex = 0
                        nav.currentNavigationItem.navigationStack.popAllExceptFirst()
                    }
                }
            }
        } // navigation item
    } // navigation

}
