<?php
/**
 * Plugin Name:       Contact Slide-in
 * Description:       WP plugin that attaches a slide-in contact form
 * Requires at least: 5.8
 * Requires PHP:      7.0
 * Version:           0.1.0
 * Author:            Greg Rozmarynowycz
 * License:           GPL-2.0-or-later
 * License URI:       https://www.gnu.org/licenses/gpl-2.0.html
 * Text Domain:      contact-slide-in
 */

add_action( 'admin_menu', 'contact_slide_in_init_menu' );

/**
 * Init Admin Menu.
 *
 * @return void
 */
function contact_slide_in_init_menu() {
    add_menu_page( __( 'Contact Slide-in', 'contact-slide-in'), __( 'Contact Slide-in', 'contact-slide-in'), 'manage_options', 'contact-slide-in', 'contact_slide_in_admin_page', 'dashicons-admin-post', '2.1' );
}

/**
 * Init Admin Page.
 *
 * @return void
 */
function contact_slide_in_admin_page() {
    require_once plugin_dir_path( __FILE__ ) . 'templates/app.php';
}

add_action( 'admin_enqueue_scripts', 'contact_slide_in_admin_enqueue_scripts' );

/**
 * Enqueue scripts and styles.
 *
 * @return void
 */
function contact_slide_in_admin_enqueue_scripts() {
    wp_enqueue_style( 'contact-slide-in-style', plugin_dir_url( __FILE__ ) . 'build/index.css' );
    wp_enqueue_script( 'contact-slide-in-script', plugin_dir_url( __FILE__ ) . 'build/index.js', array( 'wp-element' ), '1.0.0', true );
}