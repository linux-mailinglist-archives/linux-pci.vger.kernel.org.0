Return-Path: <linux-pci+bounces-41636-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E656C6F35E
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 15:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 406003871F8
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 14:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EF1365A17;
	Wed, 19 Nov 2025 14:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="qnZpNv3x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C3C0364E96
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 14:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561496; cv=none; b=XSIm3YxIxfjn+VPYADBkhtpY6StpluZSEXZnkS/9iiuFWWUuBGUx725tWB6XVT/zADXBSYGo+G7eJddpgiR2dct9dPoG4SwWLM91tDtZ6PBHfzHCp6n2xEY6bY/0ZawuX3tXsPYR2054I9J+ZkHICba7OhYHY+2weZyv6SoxpK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561496; c=relaxed/simple;
	bh=QYt2D6TCLcoCb8hD9WrVGYk0tnqyKZI+KpUzwfLWJPs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Rkq6cwGUbC+4bc2jTOAiblo0J1NHukR2uIIrWhybFVSh7z6NNdRdoRnXi3R5xNAv4nKgMfoL+w9EDU3FZo0I3qUiKnwuMV9vb6vxX7fxRymppHafSavvhDkOAxS7f2/2MuF3bRSUeTaR+Yx+U7f0i+A8daPetn3drThpEMoFBjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=qnZpNv3x; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 0771B24002D
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 15:11:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1763561486; bh=YQmlGTqcdgyCjAinwbQZx4Jor61kriIjWS/BuOoDFfI=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=qnZpNv3xvNO/9oIyfO5PyttFly6B9r8exj0zvgc7fF9Pb8xPR+1yF28aZQ/xBxt2J
	 T1GPDdIV+m2h5vD7T2vaDq39f6PtWhvtjP2EorxhUDX+X9OmABa45ooEbZJ32xF9G7
	 Ns7OfIxtbXAw/niNBEM3QSAWXGtSRRgWPGzRaqwX3oUcxu/IkIU8iFaW/YwyIaDPSF
	 8su0PmYVhoHIxMfELqDsWK+crhiPKMM6AYpfdXWqscTu23dckCxFmNPDhAlGoRtz96
	 GHVrJmQm7x8F+cum0OQ915rzumwQY1H/sEX3bNkejnqf7hFfodF3/ZdBUOV/YRRJvc
	 XdlpZLqoYJDjw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dBNgt0Njzz6twB;
	Wed, 19 Nov 2025 15:11:22 +0100 (CET)
From: Markus Probst <markus.probst@posteo.de>
Date: Wed, 19 Nov 2025 14:11:24 +0000
Subject: [PATCH v9 2/3] rust: leds: split generic and normal led classdev
 abstractions up
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-rust_leds-v9-2-86c15da19063@posteo.de>
References: <20251119-rust_leds-v9-0-86c15da19063@posteo.de>
In-Reply-To: <20251119-rust_leds-v9-0-86c15da19063@posteo.de>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-leds@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 Markus Probst <markus.probst@posteo.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=15003;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=QYt2D6TCLcoCb8hD9WrVGYk0tnqyKZI+KpUzwfLWJPs=;
 b=owEBbQKS/ZANAwAIATR2H/jnrUPSAcsmYgBpHdAEqjxE44vl1Oxk5vEcmkorJrBf3vWdodM+1
 /uhB/XfBy2JAjMEAAEIAB0WIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaR3QBAAKCRA0dh/4561D
 0kWzD/9mUnNbEfJ3OT5wPxilJZdHyPYMydLAyDUfFylv4QxeWpyf0fbnt8RMmE1UGfDpeY3QcSN
 KX6b0s7fQvxg7isKxTD9bAZ3kjKfRIZLFYr1n0LhkkuhsXxjOEBCF+zNRddzhQypH5N6OFFaLZ4
 DVp4zwHt7GLilTXlbYIpGLowco9ESvmTRHbTZOdzVJCoTeMw2up85hhohUgxpnYmjALSK44zs1P
 jcmSpUJWZ9hxqDxQKZRY1Z/PTYA5orto5IYyhfHC3q4V4CWmTR14lL6rD8/GDIB+NNz2tisyX5K
 nMxxP5Ih73eeUCk6g21tjlvMOiFUrdD/Y3fQ9+bMbeaX/SGUq9+mrveqqF57rCGqTmz8zb9PBT4
 fieOFlKIHXmkFvYSSdcicy77NlF0nJF2cK82OYhLgklo7Luuw1ngkXTIzzc4jAYg4e45kVc1gfd
 igu2qxuSnk2K42WosDeo1d8PU8c3dqOq4J32pIw+cSC4KvaQGCWKqpk1w9SHNmYxXkx7hLGLqVb
 ib2OsYvasMI7WSXFjdoksOByAYNiIyGWBZ1Ivcu9EOMuOr0RnvPbfNQlziOZ9FreNq70aVnN4Z1
 O3mWioYnZ1O36BeVf1++p04k8tHy0f5HkNjK38ht17GSfEq/S2SZTEJuYHfKjpzPqD5+cheSJBg
 ySuyaGgKe6pm+Ug==
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Move code specific to normal led class devices into a separate file and
introduce the `led::Mode` trait to allow for other types of led class
devices.

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 MAINTAINERS               |   1 +
 rust/kernel/device.rs     |   2 +-
 rust/kernel/led.rs        | 128 +++++++++++++++++++++++++++++++++++-----------
 rust/kernel/led/normal.rs |  39 ++++++++++++++
 4 files changed, 139 insertions(+), 31 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 80cb030911b7..ca11b9064e3f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14118,6 +14118,7 @@ L:	linux-leds@vger.kernel.org
 L:	rust-for-linux@vger.kernel.org
 S:	Maintained
 F:	rust/kernel/led.rs
+F:	rust/kernel/led/
 
 LEGO MINDSTORMS EV3
 R:	David Lechner <david@lechnology.com>
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 660cb2b48c07..d330248ff2aa 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -333,7 +333,7 @@ pub(crate) fn as_raw(&self) -> *mut bindings::device {
     }
 
     /// Returns a reference to the parent device, if any.
-    #[cfg_attr(not(CONFIG_AUXILIARY_BUS), expect(dead_code))]
+    #[cfg_attr(not(any(CONFIG_AUXILIARY_BUS, CONFIG_LEDS_CLASS)), expect(dead_code))]
     pub(crate) fn parent(&self) -> Option<&Device> {
         // SAFETY:
         // - By the type invariant `self.as_raw()` is always valid.
diff --git a/rust/kernel/led.rs b/rust/kernel/led.rs
index fca55f02be8d..d51735322093 100644
--- a/rust/kernel/led.rs
+++ b/rust/kernel/led.rs
@@ -44,14 +44,18 @@
     }, //
 };
 
+mod normal;
+
+pub use normal::Normal;
+
 /// The led class device representation.
 ///
-/// This structure represents the Rust abstraction for a C `struct led_classdev`.
+/// This structure represents the Rust abstraction for a led class device.
 #[pin_data(PinnedDrop)]
 pub struct Device<T: LedOps> {
     ops: T,
     #[pin]
-    classdev: Opaque<bindings::led_classdev>,
+    classdev: Opaque<<T::Mode as private::Mode>::Type>,
 }
 
 /// The led init data representation.
@@ -153,6 +157,7 @@ pub fn color(self, color: Color) -> Self {
 /// #[vtable]
 /// impl led::LedOps for MyLedOps {
 ///     type Bus = platform::Device<device::Bound>;
+///     type Mode = led::Normal;
 ///     const BLOCKING: bool = false;
 ///     const MAX_BRIGHTNESS: u32 = 255;
 ///
@@ -184,6 +189,12 @@ pub trait LedOps: Send + 'static + Sized {
     /// The bus device required by the implementation.
     #[allow(private_bounds)]
     type Bus: AsBusDevice<Bound>;
+
+    /// The led mode to use.
+    ///
+    /// See [`Mode`].
+    type Mode: Mode;
+
     /// If set true, [`LedOps::brightness_set`] and [`LedOps::blink_set`] must perform the
     /// operation immediately. If set false, they must not sleep.
     const BLOCKING: bool;
@@ -270,6 +281,42 @@ fn try_from(value: u32) -> core::result::Result<Self, Self::Error> {
     }
 }
 
+/// The led mode.
+///
+/// Each led mode has its own led class device type with different capabilities.
+///
+/// See [`Normal`].
+pub trait Mode: private::Mode {}
+
+impl<T: private::Mode> Mode for T {}
+
+type RegisterFunc<T> =
+    unsafe extern "C" fn(*mut bindings::device, *mut T, *mut bindings::led_init_data) -> i32;
+
+type UnregisterFunc<T> = unsafe extern "C" fn(*mut T);
+
+mod private {
+    pub trait Mode {
+        type Type;
+        const REGISTER: super::RegisterFunc<Self::Type>;
+        const UNREGISTER: super::UnregisterFunc<Self::Type>;
+
+        /// # Safety
+        /// `raw` must be a valid pointer to [`Self::Type`].
+        unsafe fn device<'a>(raw: *mut Self::Type) -> &'a crate::device::Device;
+
+        /// # Safety
+        /// `led_cdev` must be a valid pointer to `led_classdev` embedded within [`Self::Type`].
+        unsafe fn from_classdev(led_cdev: *mut bindings::led_classdev) -> *mut Self::Type;
+
+        /// # Safety
+        /// `raw` must be a valid pointer to [`Self::Type`].
+        unsafe fn pre_brightness_set(_raw: *mut Self::Type, _brightness: u32) {}
+
+        fn release(_led_cdev: &mut Self::Type) {}
+    }
+}
+
 // SAFETY: A `led::Device` can be unregistered from any thread.
 unsafe impl<T: LedOps + Send> Send for Device<T> {}
 
@@ -278,24 +325,22 @@ unsafe impl<T: LedOps + Send> Send for Device<T> {}
 unsafe impl<T: LedOps + Sync> Sync for Device<T> {}
 
 impl<T: LedOps> Device<T> {
-    /// Registers a new led classdev.
-    ///
-    /// The [`Device`] will be unregistered on drop.
-    pub fn new<'a>(
+    fn __new<'a>(
         parent: &'a T::Bus,
         init_data: InitData<'a>,
         ops: T,
+        func: impl FnOnce(bindings::led_classdev) -> Result<<T::Mode as private::Mode>::Type> + 'a,
     ) -> impl PinInit<Devres<Self>, Error> + 'a {
         Devres::new(
             parent.as_ref(),
             try_pin_init!(Self {
                 ops,
-                classdev <- Opaque::try_ffi_init(|ptr: *mut bindings::led_classdev| {
+                classdev <- Opaque::try_ffi_init(|ptr: *mut <T::Mode as private::Mode>::Type| {
                     // SAFETY: `try_ffi_init` guarantees that `ptr` is valid for write.
-                    // `led_classdev` gets fully initialized in-place by
-                    // `led_classdev_register_ext` including `mutex` and `list_head`.
+                    // `T::Mode::Type` (and the embedded led_classdev) gets fully initialized
+                    // in-place by `T::Mode::REGISTER` including `mutex` and `list_head`.
                     unsafe {
-                        ptr.write(bindings::led_classdev {
+                        ptr.write((func)(bindings::led_classdev {
                             brightness_set: (!T::BLOCKING)
                                 .then_some(Adapter::<T>::brightness_set_callback),
                             brightness_set_blocking: T::BLOCKING
@@ -309,7 +354,7 @@ pub fn new<'a>(
                                 .map_or(core::ptr::null(), CStr::as_char_ptr),
                             color: init_data.color as u32,
                             ..bindings::led_classdev::default()
-                        })
+                        })?)
                     };
 
                     let mut init_data_raw = bindings::led_init_data {
@@ -326,11 +371,11 @@ pub fn new<'a>(
                     };
 
                     // SAFETY:
-                    // - `parent.as_raw()` is guaranteed to be a pointer to a valid `device`
-                    //    or a null pointer.
-                    // - `ptr` is guaranteed to be a pointer to an initialized `led_classdev`.
+                    // - `parent.as_ref().as_raw()` is guaranteed to be a pointer to a valid
+                    //    `device`.
+                    // - `ptr` is guaranteed to be a pointer to an initialized `T::Mode::Type`.
                     to_result(unsafe {
-                        bindings::led_classdev_register_ext(
+                        (<T::Mode as private::Mode>::REGISTER)(
                             parent.as_ref().as_raw(),
                             ptr,
                             &mut init_data_raw,
@@ -350,15 +395,22 @@ pub fn new<'a>(
     /// `led::Device`.
     unsafe fn from_raw<'a>(led_cdev: *mut bindings::led_classdev) -> &'a Self {
         // SAFETY: The function's contract guarantees that `led_cdev` points to a `led_classdev`
-        // field embedded within a valid `led::Device`. `container_of!` can therefore
-        // safely calculate the address of the containing struct.
-        unsafe { &*container_of!(Opaque::cast_from(led_cdev), Self, classdev) }
+        // embedded within a `led::Device` and thus is embedded within `T::Mode::Type`.
+        let raw = unsafe { <T::Mode as private::Mode>::from_classdev(led_cdev) };
+
+        // SAFETY: The function's contract guarantees that `raw` points to a `led_classdev` field
+        // embedded within a valid `led::Device`. `container_of!` can therefore safely calculate
+        // the address of the containing struct.
+        unsafe { &*container_of!(Opaque::cast_from(raw), Self, classdev) }
     }
 
     fn parent(&self) -> &device::Device<Bound> {
-        // SAFETY:
-        // - `self.classdev.get()` is guaranteed to be a valid pointer to `led_classdev`.
-        unsafe { device::Device::from_raw((*(*self.classdev.get()).dev).parent) }
+        // SAFETY: `self.classdev.get()` is guaranteed to be a valid pointer to `T::Mode::Type`.
+        let device = unsafe { <T::Mode as private::Mode>::device(self.classdev.get()) };
+        // SAFETY: `led::Device::__new` doesn't allow to register a class device without an parent.
+        let parent = unsafe { device.parent().unwrap_unchecked() };
+        // SAFETY: the existence of `self` guarantees that `parent` is bound to a driver.
+        unsafe { parent.as_bound() }
     }
 }
 
@@ -376,11 +428,17 @@ impl<T: LedOps> Adapter<T> {
         brightness: u32,
     ) {
         // SAFETY: The function's contract guarantees that `led_cdev` is a valid pointer to a
-        // `led_classdev` embedded within a `led::Device`.
+        // `T::Mode::Type` embedded within a `led::Device`.
         let classdev = unsafe { Device::<T>::from_raw(led_cdev) };
         // SAFETY: `classdev.parent()` is guaranteed to be contained in `T::Bus`.
         let parent = unsafe { T::Bus::from_device(classdev.parent()) };
 
+        // SAFETY: `classdev.classdev.get()` is guaranteed to be a valid pointer to a
+        // `T::Mode::Type`.
+        unsafe {
+            <T::Mode as private::Mode>::pre_brightness_set(classdev.classdev.get(), brightness);
+        }
+
         let _ = classdev.ops.brightness_set(parent, classdev, brightness);
     }
 
@@ -394,11 +452,17 @@ impl<T: LedOps> Adapter<T> {
     ) -> i32 {
         from_result(|| {
             // SAFETY: The function's contract guarantees that `led_cdev` is a valid pointer to a
-            // `led_classdev` embedded within a `led::Device`.
+            // `T::Mode::Type` embedded within a `led::Device`.
             let classdev = unsafe { Device::<T>::from_raw(led_cdev) };
             // SAFETY: `classdev.parent()` is guaranteed to be contained in `T::Bus`.
             let parent = unsafe { T::Bus::from_device(classdev.parent()) };
 
+            // SAFETY: `classdev.classdev.get()` is guaranteed to be a valid pointer to a
+            // `T::Mode::Type`.
+            unsafe {
+                <T::Mode as private::Mode>::pre_brightness_set(classdev.classdev.get(), brightness);
+            }
+
             classdev.ops.brightness_set(parent, classdev, brightness)?;
             Ok(0)
         })
@@ -410,7 +474,7 @@ impl<T: LedOps> Adapter<T> {
     /// This function is called on getting the brightness of a led.
     unsafe extern "C" fn brightness_get_callback(led_cdev: *mut bindings::led_classdev) -> u32 {
         // SAFETY: The function's contract guarantees that `led_cdev` is a valid pointer to a
-        // `led_classdev` embedded within a `led::Device`.
+        // `T::Mode::Type` embedded within a `led::Device`.
         let classdev = unsafe { Device::<T>::from_raw(led_cdev) };
         // SAFETY: `classdev.parent()` is guaranteed to be contained in `T::Bus`.
         let parent = unsafe { T::Bus::from_device(classdev.parent()) };
@@ -431,7 +495,7 @@ impl<T: LedOps> Adapter<T> {
     ) -> i32 {
         from_result(|| {
             // SAFETY: The function's contract guarantees that `led_cdev` is a valid pointer to a
-            // `led_classdev` embedded within a `led::Device`.
+            // `T::Mode::Type` embedded within a `led::Device`.
             let classdev = unsafe { Device::<T>::from_raw(led_cdev) };
             // SAFETY: `classdev.parent()` is guaranteed to be contained in `T::Bus`.
             let parent = unsafe { T::Bus::from_device(classdev.parent()) };
@@ -456,17 +520,21 @@ impl<T: LedOps> PinnedDrop for Device<T> {
     fn drop(self: Pin<&mut Self>) {
         let raw = self.classdev.get();
         // SAFETY: The existence of `self` guarantees that `self.classdev.get()` is a pointer to a
-        // valid `struct led_classdev`.
-        let dev: &device::Device = unsafe { device::Device::from_raw((*raw).dev) };
+        // valid `T::Mode::Type`.
+        let dev: &device::Device = unsafe { <T::Mode as private::Mode>::device(raw) };
 
         let _fwnode = dev
             .fwnode()
             // SAFETY: the reference count of `fwnode` has previously been
-            // incremented in `led::Device::new`.
+            // incremented in `led::Device::__new`.
             .map(|fwnode| unsafe { ARef::from_raw(NonNull::from(fwnode)) });
 
         // SAFETY: The existence of `self` guarantees that `self.classdev` has previously been
-        // successfully registered with `led_classdev_register_ext`.
-        unsafe { bindings::led_classdev_unregister(self.classdev.get()) };
+        // successfully registered with `T::Mode::REGISTER`.
+        unsafe { (<T::Mode as private::Mode>::UNREGISTER)(raw) };
+
+        // SAFETY: The existence of `self` guarantees that `self.classdev.get()` is a pointer to a
+        // valid `T::Mode::Type`.
+        <T::Mode as private::Mode>::release(unsafe { &mut *raw });
     }
 }
diff --git a/rust/kernel/led/normal.rs b/rust/kernel/led/normal.rs
new file mode 100644
index 000000000000..13feeb3256f3
--- /dev/null
+++ b/rust/kernel/led/normal.rs
@@ -0,0 +1,39 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Led mode for the `struct led_classdev`.
+//!
+//! C header: [`include/linux/leds.h`](srctree/include/linux/leds.h)
+
+use super::*;
+
+/// The led mode for the `struct led_classdev`. Leds with this mode can only have a fixed color.
+pub enum Normal {}
+
+impl private::Mode for Normal {
+    type Type = bindings::led_classdev;
+    const REGISTER: RegisterFunc<Self::Type> = bindings::led_classdev_register_ext;
+    const UNREGISTER: UnregisterFunc<Self::Type> = bindings::led_classdev_unregister;
+
+    unsafe fn device<'a>(raw: *mut Self::Type) -> &'a device::Device {
+        // SAFETY:
+        // - The function's contract guarantees that `raw` is a valid pointer to `led_classdev`.
+        unsafe { device::Device::from_raw((*raw).dev) }
+    }
+
+    unsafe fn from_classdev(led_cdev: *mut bindings::led_classdev) -> *mut Self::Type {
+        led_cdev
+    }
+}
+
+impl<T: LedOps<Mode = Normal>> Device<T> {
+    /// Registers a new led classdev.
+    ///
+    /// The [`Device`] will be unregistered on drop.
+    pub fn new<'a>(
+        parent: &'a T::Bus,
+        init_data: InitData<'a>,
+        ops: T,
+    ) -> impl PinInit<Devres<Self>, Error> + 'a {
+        Self::__new(parent, init_data, ops, Ok)
+    }
+}

-- 
2.51.0


