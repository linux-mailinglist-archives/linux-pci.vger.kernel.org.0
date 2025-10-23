Return-Path: <linux-pci+bounces-39182-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C68C02BA6
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 19:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0426D1AA453E
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 17:29:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D923314C3;
	Thu, 23 Oct 2025 17:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="l2LFOxmf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895E71EA7FF
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761240513; cv=none; b=Dpj79seIiI/w4n4Hg2njfIG8bmHxw0fzLNiBEalS0uRtWSj3meVRJpQFBya1rviUegD5IJc1dFxzcMV2ysZ9phKmVP7iO1uh/EKxK9as8SPro2mMu2lTrLADQHxjrHgSd7JhIdgoTqwKyLFf+ZDLE8R4UNlvfOMbf5LuJhL5T8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761240513; c=relaxed/simple;
	bh=9h+tAmuuvK9EqxjAQukL4RGSRcJTnFax99ceow6JrNs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ickM8ZsWAVtDFeEx2mB8jlbcErCb13dFaBDrFE8Y1n3GsNcuEC6j/BSAqaSaN2alzhoCigcwynr+lF8bQ08mFLSLIWq16YnyljpzY9Qm+ZpDhGsJkXqJkyJ4cHKIrYTV5JFDk34qOI/wzuHdT1NvKD62WEYJWSaDOxVIwnWqX90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=l2LFOxmf; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 0DEAC240029
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 19:28:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1761240510; bh=h0DeGFcALHELGR30GG6cngIwx4x0xFLg1HmmpECNVtg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Autocrypt:OpenPGP:From;
	b=l2LFOxmf54lVhptC3AUx0k4Znrq6bU+po05OvHAAdjvmmTUiCeH/6j89ob841KZv+
	 EZ6hKgU47rni9ehqjnYcVYOATgDFWe0B99eo9Ez3m01tFXOULY2iO4e6xlwESqe+PE
	 MNVdDI7s7N8VCi2JIeVfk8PuySxiS2LzGwlolxC+dOB09subJrvF/f/w4NuNJtRWLh
	 j//sh3qtHWs+Pg7ZalURFcKy7DhypVOZyt6tgcXS8kqH9ZpEjlNGehzg/+QvjoJvga
	 CZqmH6ngCXmiyvtEczwTYFH2klIMEddlgCBVAEXFcYIDFPOEhWJyOiTzSMjIrppvWh
	 9Vqof9Cxf6GyA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cstKZ3R4Cz6v2t;
	Thu, 23 Oct 2025 19:28:18 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>
Cc: Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Leon Romanovsky <leon@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Gary Guo <gary@garyguo.net>,
	bjorn3_gh@protonmail.com,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,
	Trevor Gross <tmgross@umich.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Markus Probst <markus.probst@posteo.de>,
	rust-for-linux@vger.kernel.org,
	linux-leds@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 2/2] rust: leds: add basic led classdev abstractions
Date: Thu, 23 Oct 2025 17:28:20 +0000
Message-ID: <20251023172803.730677-3-markus.probst@posteo.de>
In-Reply-To: <20251023172803.730677-1-markus.probst@posteo.de>
References: <20251023172803.730677-1-markus.probst@posteo.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=15201; i=markus.probst@posteo.de; h=from:subject; bh=9h+tAmuuvK9EqxjAQukL4RGSRcJTnFax99ceow6JrNs=; b=owEBbQKS/ZANAwAIATR2H/jnrUPSAcsmYgBo+mQnWaSu8UMraopNwFIpQc/riJ7x5H6IvI+LC 6jkNiSXOvuJAjMEAAEIAB0WIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaPpkJwAKCRA0dh/4561D 0l92D/0amHvZ8ChNdlEzjPhuhVteXsIUiWVBs73lA9bYZRF73731Brw9rKWLBLiCL+vXcfZnNJE vrEpQaQ8Vn5+VCiQ5qtFmDNe/tZI2MsBlMr/leWlIe86SKK3vVWOrxjNoQXu0p7hCQ4vY2zFtnG eJ2M21th3OvD9FBOiCTitFmcq75KPZPf5D7R6idpgTZwPI/Sq6BAlnjyHuvRqjPHPWXVI6yWbxB 2AvxmHeU63LSd8JGik32xtZMjIyexNKoEgBBdOM0hRYROHp4qfHQzgjaZCWjysb/spsWGficbuW /+BxbFYcf8N4K963PYOK6ACBWm/ln8v6wDnVxuP1yubTCglF28zilPG7fNPgDpyCRj5h3VZSrp9 AmKts2hz2q21SDV63eQ8hbUmmJljYuxFk938Wl49UTC8CHM//LQyToVYl7EUx3p5YkkojY+FxyY xH8S4tzF9/xB1deiZwjzv+lqRBWg/umhtl8o7s200q6NLs1eUuv//0S1PLnxstOIN7tLdHCqfYs 2P8HPMrAlkA0KoEkp9qNhUgvpHQFxobKJ+lK8+PfOYKMM8wle7s8fV0GfucPor2qLioCQflDVI3 zrX5Q9q1GlNHr34mQE5IoCVFXJv2CAySsQsZz3TJRilzmkKS8yiFbf3d5RS0nGCyPKaO+0dweCF C/0gsLtIxKNVAnA
 ==
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp; fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Content-Transfer-Encoding: 8bit
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Implement the core abstractions needed for led class devices, including:

* `led::LedOps` - the trait for handling leds, including
  `brightness_set`, `brightness_get` and `blink_set`

* `led::InitData` - data set for the led class device

* `led::Device` - a safe wrapper around `led_classdev`

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 rust/kernel/led.rs | 375 +++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs |   1 +
 2 files changed, 376 insertions(+)
 create mode 100644 rust/kernel/led.rs

diff --git a/rust/kernel/led.rs b/rust/kernel/led.rs
new file mode 100644
index 000000000000..1c1e23a0414c
--- /dev/null
+++ b/rust/kernel/led.rs
@@ -0,0 +1,375 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Abstractions for the leds driver model.
+//!
+//! C header: [`include/linux/leds.h`](srctree/include/linux/leds.h)
+
+use core::{marker::PhantomData, pin::Pin, ptr::NonNull};
+
+use pin_init::{pin_data, pinned_drop, PinInit};
+
+use crate::{
+    build_error, container_of,
+    device::{self, property::FwNode, Bound, AsBusDevice},
+    devres::Devres,
+    error::{from_result, to_result, Error, Result, VTABLE_DEFAULT_ERROR},
+    macros::vtable,
+    str::CStr,
+    try_pin_init,
+    types::{ARef, Opaque},
+};
+
+/// The led class device representation.
+///
+/// This structure represents the Rust abstraction for a C `struct led_classdev`.
+#[pin_data(PinnedDrop)]
+pub struct Device<T: LedOps> {
+    ops: T,
+    #[pin]
+    classdev: Opaque<bindings::led_classdev>,
+}
+
+/// The led init data representation.
+///
+/// This structure represents the Rust abstraction for a C `struct led_init_data`.
+#[derive(Default)]
+pub struct InitData<'a> {
+    fwnode: Option<&'a FwNode>,
+    default_label: Option<&'a CStr>,
+    devicename: Option<&'a CStr>,
+    devname_mandatory: bool,
+}
+
+impl InitData<'static> {
+    /// Creates a new [`InitData`]
+    pub fn new() -> Self {
+        Self::default()
+    }
+}
+
+impl<'a> InitData<'a> {
+    /// Sets the firmware node
+    pub fn fwnode<'b, 'c>(self, fwnode: &'b FwNode) -> InitData<'c>
+    where
+        'a: 'c,
+        'b: 'c,
+    {
+        InitData {
+            fwnode: Some(fwnode),
+            ..self
+        }
+    }
+
+    /// Sets a default label
+    pub fn default_label<'b, 'c>(self, label: &'b CStr) -> InitData<'c>
+    where
+        'a: 'c,
+        'b: 'c,
+    {
+        InitData {
+            default_label: Some(label),
+            ..self
+        }
+    }
+
+    /// Sets the device name
+    pub fn devicename<'b, 'c>(self, devicename: &'b CStr) -> InitData<'c>
+    where
+        'a: 'c,
+        'b: 'c,
+    {
+        InitData {
+            devicename: Some(devicename),
+            ..self
+        }
+    }
+
+    /// Sets if a device name is mandatory
+    pub fn devicename_mandatory(self, mandatory: bool) -> Self {
+        Self {
+            devname_mandatory: mandatory,
+
+            ..self
+        }
+    }
+}
+
+/// Trait defining the operations for a LED driver.
+///
+/// # Examples
+///
+///```
+/// # use kernel::{
+/// #     c_str, device, devres::Devres,
+/// #     error::Result, led,
+/// #     macros::vtable, platform, prelude::*,
+/// # };
+/// # use core::pin::Pin;
+///
+/// struct MyLedOps;
+///
+///
+/// #[vtable]
+/// impl led::LedOps for MyLedOps {
+///     type Bus = platform::Device<device::Bound>;
+///     const BLOCKING: bool = false;
+///     const MAX_BRIGHTNESS: u32 = 255;
+///
+///     fn brightness_set(
+///         &self,
+///         _dev: &platform::Device<device::Bound>,
+///         _brightness: u32
+///     ) -> Result<()> {
+///         // Set the brightness for the led here
+///         Ok(())
+///     }
+/// }
+///
+/// fn register_my_led(
+///     parent: &platform::Device<device::Bound>,
+/// ) -> Result<Pin<KBox<Devres<led::Device<MyLedOps>>>>> {
+///     KBox::pin_init(led::Device::new(
+///         parent,
+///         led::InitData::new()
+///             .default_label(c_str!("my_led")),
+///         MyLedOps,
+///     ), GFP_KERNEL)
+/// }
+///```
+/// Led drivers must implement this trait in order to register and handle a [`Device`].
+#[vtable]
+pub trait LedOps: Send + 'static + Sized {
+    /// The bus device required by the implementation.
+    #[allow(private_bounds)]
+    type Bus: AsBusDevice<Bound>;
+    /// If set true, [`LedOps::brightness_set`] and [`LedOps::blink_set`] must perform the
+    /// operation immediately. If set false, they must not sleep.
+    const BLOCKING: bool;
+    /// The max brightness level
+    const MAX_BRIGHTNESS: u32;
+
+    /// Sets the brightness level.
+    ///
+    /// See also [`LedOps::BLOCKING`]
+    fn brightness_set(&self, dev: &Self::Bus, brightness: u32) -> Result<()>;
+
+    /// Gets the current brightness level.
+    fn brightness_get(&self, _dev: &Self::Bus) -> u32 {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+
+    /// Activates hardware accelerated blinking.
+    ///
+    /// delays are in milliseconds. If both are zero, a sensible default should be chosen.
+    /// The caller should adjust the timings in that case and if it can't match the values
+    /// specified exactly. Setting the brightness to 0 will disable the hardware accelerated
+    /// blinking.
+    ///
+    /// See also [`LedOps::BLOCKING`]
+    fn blink_set(
+        &self,
+        _dev: &Self::Bus,
+        _delay_on: &mut usize,
+        _delay_off: &mut usize,
+    ) -> Result<()> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+}
+
+// SAFETY: A `led::Device` can be unregistered from any thread.
+unsafe impl<T: LedOps + Send> Send for Device<T> {}
+
+// SAFETY: `led::Device` can be shared among threads because all methods of `led::Device`
+// are thread safe.
+unsafe impl<T: LedOps + Sync> Sync for Device<T> {}
+
+impl<T: LedOps> Device<T> {
+    /// Registers a new led classdev.
+    ///
+    /// The [`Device`] will be unregistered on drop.
+    pub fn new<'a>(
+        parent: &'a T::Bus,
+        init_data: InitData<'a>,
+        ops: T,
+    ) -> impl PinInit<Devres<Self>, Error> + 'a {
+        Devres::new(
+            parent.as_ref(),
+            try_pin_init!(Self {
+                ops,
+                classdev <- Opaque::try_ffi_init(|ptr: *mut bindings::led_classdev| {
+                    // SAFETY: `try_ffi_init` guarantees that `ptr` is valid for write.
+                    // `led_classdev` gets fully initialized in-place by
+                    // `led_classdev_register_ext` including `mutex` and `list_head`.
+                    unsafe {
+                        ptr.write(bindings::led_classdev {
+                            max_brightness: T::MAX_BRIGHTNESS,
+                            brightness_set: (!T::BLOCKING)
+                                .then_some(Adapter::<T>::brightness_set_callback),
+                            brightness_set_blocking: T::BLOCKING
+                                .then_some(Adapter::<T>::brightness_set_blocking_callback),
+                            brightness_get: T::HAS_BRIGHTNESS_GET
+                                .then_some(Adapter::<T>::brightness_get_callback),
+                            blink_set: T::HAS_BLINK_SET.then_some(Adapter::<T>::blink_set_callback),
+                            ..bindings::led_classdev::default()
+                        })
+                    };
+
+                    let fwnode = init_data.fwnode.map(ARef::from);
+
+                    let mut init_data = bindings::led_init_data {
+                        fwnode: fwnode
+                            .as_ref()
+                            .map_or(core::ptr::null_mut(), |fwnode| fwnode.as_raw()),
+                        default_label: init_data
+                            .default_label
+                            .map_or(core::ptr::null(), CStr::as_char_ptr),
+                        devicename: init_data
+                            .devicename
+                            .map_or(core::ptr::null(), CStr::as_char_ptr),
+                        devname_mandatory: init_data.devname_mandatory,
+                    };
+
+                    // SAFETY:
+                    // - `parent.as_raw()` is guaranteed to be a pointer to a valid `device`
+                    //    or a null pointer.
+                    // - `ptr` is guaranteed to be a pointer to an initialized `led_classdev`.
+                    to_result(unsafe {
+                        bindings::led_classdev_register_ext(
+                            parent.as_ref().as_raw(),
+                            ptr,
+                            &mut init_data,
+                        )
+                    })?;
+
+                    core::mem::forget(fwnode); // keep the reference count incremented
+
+                    Ok::<_, Error>(())
+                }),
+            }),
+        )
+    }
+
+    /// # Safety
+    /// `led_cdev` must be a valid pointer to a `led_classdev` embedded within a
+    /// `led::Device`.
+    unsafe fn from_raw<'a>(led_cdev: *mut bindings::led_classdev) -> &'a Self {
+        // SAFETY: The function's contract guarantees that `led_cdev` points to a `led_classdev`
+        // field embedded within a valid `led::Device`. `container_of!` can therefore
+        // safely calculate the address of the containing struct.
+        unsafe { &*container_of!(Opaque::cast_from(led_cdev), Self, classdev) }
+    }
+
+    fn parent(&self) -> &device::Device<Bound> {
+        // SAFETY:
+        // - `self.classdev.get()` is guaranteed to be a valid pointer to `led_classdev`.
+        unsafe { device::Device::from_raw((*(*self.classdev.get()).dev).parent) }
+    }
+}
+
+struct Adapter<T: LedOps> {
+    _p: PhantomData<T>,
+}
+
+impl<T: LedOps> Adapter<T> {
+    /// # Safety
+    /// `led_cdev` must be a valid pointer to a `led_classdev` embedded within a
+    /// `led::Device`.
+    /// This function is called on setting the brightness of a led.
+    unsafe extern "C" fn brightness_set_callback(
+        led_cdev: *mut bindings::led_classdev,
+        brightness: u32,
+    ) {
+        // SAFETY: The function's contract guarantees that `led_cdev` is a valid pointer to a
+        // `led_classdev` embedded within a `led::Device`.
+        let classdev = unsafe { Device::<T>::from_raw(led_cdev) };
+        // SAFETY: `classdev.parent()` is guaranteed to be contained in `T::Bus`.
+        let parent = unsafe { T::Bus::from_device(classdev.parent()) };
+
+        let _ = classdev.ops.brightness_set(parent, brightness);
+    }
+
+    /// # Safety
+    /// `led_cdev` must be a valid pointer to a `led_classdev` embedded within a
+    /// `led::Device`.
+    /// This function is called on setting the brightness of a led immediately.
+    unsafe extern "C" fn brightness_set_blocking_callback(
+        led_cdev: *mut bindings::led_classdev,
+        brightness: u32,
+    ) -> i32 {
+        from_result(|| {
+            // SAFETY: The function's contract guarantees that `led_cdev` is a valid pointer to a
+            // `led_classdev` embedded within a `led::Device`.
+            let classdev = unsafe { Device::<T>::from_raw(led_cdev) };
+            // SAFETY: `classdev.parent()` is guaranteed to be contained in `T::Bus`.
+            let parent = unsafe { T::Bus::from_device(classdev.parent()) };
+
+            classdev.ops.brightness_set(parent, brightness)?;
+            Ok(0)
+        })
+    }
+
+    /// # Safety
+    /// `led_cdev` must be a valid pointer to a `led_classdev` embedded within a
+    /// `led::Device`.
+    /// This function is called on getting the brightness of a led.
+    unsafe extern "C" fn brightness_get_callback(led_cdev: *mut bindings::led_classdev) -> u32 {
+        // SAFETY: The function's contract guarantees that `led_cdev` is a valid pointer to a
+        // `led_classdev` embedded within a `led::Device`.
+        let classdev = unsafe { Device::<T>::from_raw(led_cdev) };
+        // SAFETY: `classdev.parent()` is guaranteed to be contained in `T::Bus`.
+        let parent = unsafe { T::Bus::from_device(classdev.parent()) };
+
+        classdev.ops.brightness_get(parent)
+    }
+
+    /// # Safety
+    /// `led_cdev` must be a valid pointer to a `led_classdev` embedded within a
+    /// `led::Device`.
+    /// `delay_on` and `delay_off` must be valid pointers to `usize` and have
+    /// exclusive access for the period of this function.
+    /// This function is called on enabling hardware accelerated blinking.
+    unsafe extern "C" fn blink_set_callback(
+        led_cdev: *mut bindings::led_classdev,
+        delay_on: *mut usize,
+        delay_off: *mut usize,
+    ) -> i32 {
+        from_result(|| {
+            // SAFETY: The function's contract guarantees that `led_cdev` is a valid pointer to a
+            // `led_classdev` embedded within a `led::Device`.
+            let classdev = unsafe { Device::<T>::from_raw(led_cdev) };
+            // SAFETY: `classdev.parent()` is guaranteed to be contained in `T::Bus`.
+            let parent = unsafe { T::Bus::from_device(classdev.parent()) };
+
+            classdev.ops.blink_set(
+                parent,
+                // SAFETY: The function's contract guarantees that `delay_on` points to a `usize`
+                // and is exclusive for the period of this function.
+                unsafe { &mut *delay_on },
+                // SAFETY: The function's contract guarantees that `delay_off` points to a `usize`
+                // and is exclusive for the period of this function.
+                unsafe { &mut *delay_off },
+            )?;
+            Ok(0)
+        })
+    }
+}
+
+#[pinned_drop]
+impl<T: LedOps> PinnedDrop for Device<T> {
+    fn drop(self: Pin<&mut Self>) {
+        let raw = self.classdev.get();
+        // SAFETY: The existence of `self` guarantees that `self.classdev.get()` is a pointer to a
+        // valid `struct led_classdev`.
+        let dev: &device::Device = unsafe { device::Device::from_raw((*raw).dev) };
+
+        let _fwnode = dev
+            .fwnode()
+            // SAFETY: the reference count of `fwnode` has previously been
+            // incremented in `led::Device::new`.
+            .map(|fwnode| unsafe { ARef::from_raw(NonNull::from(fwnode)) });
+
+        // SAFETY: The existence of `self` guarantees that `self.classdev` has previously been
+        // successfully registered with `led_classdev_register_ext`.
+        unsafe { bindings::led_classdev_unregister(self.classdev.get()) };
+    }
+}
diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index 3dd7bebe7888..c03b7b242a2b 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -103,6 +103,7 @@
 pub mod jump_label;
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
+pub mod led;
 pub mod list;
 pub mod maple_tree;
 pub mod miscdevice;
-- 
2.51.0


