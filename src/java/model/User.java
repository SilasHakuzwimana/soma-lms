/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

/**
 *
 * @author hakus
 */

import java.time.ZoneId;
import java.sql.Timestamp;
import java.time.ZonedDateTime;



public class User {

    private int id;
    private String regNumber;
    private String fullName;
    private String email;
    private String phone;
    private String password;
    private String role;
    private String status;
    private String profileImage;
    private String bio;

    private ZonedDateTime createdAt;
    private ZonedDateTime updatedAt;
    private ZonedDateTime lastLogin;

    private static final ZoneId KIGALI_ZONE = ZoneId.of("Africa/Kigali");

    public User() {
        ZonedDateTime now = ZonedDateTime.now(KIGALI_ZONE);
        this.createdAt = now;
        this.updatedAt = now;
        this.lastLogin = now;
    }

    // Getters
    public int getId() {
        return id;
    }

    public String getRegNumber() {
        return regNumber;
    }

    public String getFullName() {
        return fullName;
    }

    public String getEmail() {
        return email;
    }

    public String getPhone() {
        return phone;
    }

    public String getPassword() {
        return password;
    }

    public String getRole() {
        return role;
    }

    public String getStatus() {
        return status;
    }

    public String getProfileImage() {
        return profileImage;
    }

    public String getBio() {
        return bio;
    }

    public ZonedDateTime getCreatedAt() {
        return createdAt;
    }

    public ZonedDateTime getUpdatedAt() {
        return updatedAt;
    }

    public ZonedDateTime getLastLogin() {
        return lastLogin;
    }

    // Setters
    public void setId(int id) {
        this.id = id;
    }

    public void setRegNumber(String regNumber) {
        this.regNumber = regNumber;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setProfileImage(String profileImage) {
        this.profileImage = profileImage;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public void setCreatedAt(ZonedDateTime createdAt) {
        this.createdAt = createdAt.withZoneSameInstant(KIGALI_ZONE);
    }

    public void setUpdatedAt(ZonedDateTime updatedAt) {
        this.updatedAt = updatedAt.withZoneSameInstant(KIGALI_ZONE);
    }

    public void setLastLogin(ZonedDateTime lastLogin) {
        this.lastLogin = lastLogin.withZoneSameInstant(KIGALI_ZONE);
    }
}
