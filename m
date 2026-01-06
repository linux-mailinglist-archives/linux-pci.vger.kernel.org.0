Return-Path: <linux-pci+bounces-44073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2244CF65C4
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 02:51:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C18B3008777
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 01:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A8B3254B0;
	Tue,  6 Jan 2026 01:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="hkAMihuu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0B6324718
	for <linux-pci@vger.kernel.org>; Tue,  6 Jan 2026 01:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767663784; cv=none; b=M/1btJ2KRCNOVEdvBU+7I9QYNNfgNqppW4BVt5KvusoksS5mv4qPbYHZFFAI7o2Gs3ck3dSBFh4k57qRwlMv7ZcXa6CMZhe4xbqQ2KodLKNy+Yh/7CG9w2114zVzkAj5lVRjy+8WRWVMxy3ip4+nMO/q9TJQBppMbUVye47wRDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767663784; c=relaxed/simple;
	bh=nIqnAceonbGB/2oB1eINOb4+WYLeVHmgN0nc+oAtOxk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C+i9tsJNq76k3GW7TLegLmoaBD1CiCYAb3IPJu7NkjBTiE4rF8PEh07iOKakiAowBjm8MSFwqMElwOOibGJsXPCwqkm8qEjgOntVUc9RAtx+p2QmZKDp0lT8WRJCT+cjKn9Jeaz30cnAUHTydItAzezGi5j0n9aa4prNdEQIXas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=hkAMihuu; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 1C198240028
	for <linux-pci@vger.kernel.org>; Tue,  6 Jan 2026 02:42:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1767663775; bh=2RjjrqofrchJM3YLxOfkW/tRlD6NvG1dZWyjOUVO45M=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=hkAMihuu+yRvFx9WrY4fh2umVvoCtxOSWehFBzT8LnTG/UCw/vlu+ZJQXYJaExryl
	 FKPCtGWgIW+SJlrhhi4gAEd0pkcQnhWkClLQADtZnnMF+Ktyd7oecI4s1Ggm3nHyp9
	 K56wJPRURlmO9dAL4XBgarAp2QRmtGTdXUIsTmul8orUAZsFWV6UIqynvLludCIOUG
	 LufG4C8enFvVAG2rS4EezlbPmhgzMvSky49NrgRBj9NfezmPGJYNY20ouulCMTjhsk
	 Su3JPbfKFprSJOJkHHHrjLxJcZCDNGmFTS/gex9xeeEmmonGE/ujA8JoigxSGuqKAW
	 OElHo2UeBRmlg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dlYp4130tz6txc;
	Tue,  6 Jan 2026 02:42:52 +0100 (CET)
From: Markus Probst <markus.probst@posteo.de>
Date: Tue, 06 Jan 2026 01:42:53 +0000
Subject: [PATCH v10 2/3] rust: leds: split generic and normal led classdev
 abstractions up
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-rust_leds-v10-2-e0a1564884f9@posteo.de>
References: <20260106-rust_leds-v10-0-e0a1564884f9@posteo.de>
In-Reply-To: <20260106-rust_leds-v10-0-e0a1564884f9@posteo.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=23506;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=nIqnAceonbGB/2oB1eINOb4+WYLeVHmgN0nc+oAtOxk=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBpXGiXKZAM1N6ofkoU/wDyFB0t8fKvA6Q0jv1xD
 N9NY9cFL0mJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaVxolxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQNHYf+OetQ9K3ww//e+QnBrr9rIs9N9bWRwCVSEcN4qlkN1k
 6ieKKl/b034gxUMTbzIvwsCbsNB1KsJZ10NRwGzzXAbHIkR6HDLwcFYrhO9F2WSyFmBnXQhgWnf
 nREDwqTkhgb5YfINgKJsTh0wUDXhiMG2Ko9fCBh5ukXrg2bwibWno4VPFuann6m8ELXxdng6Tiq
 h/URRlSn5tPXGIo2Qg8gTQwoneLSy+lttfg0kAJU3ne6kmFAs3jU2zbZA+otgTS+rUVQUVsoeQ2
 8rPqcuWitPawf+yUoFWzuOY96dsFQb/gLSp0U0SX0bjBg+OYfruoTCOCHmYfUBSvviorq+rmAXW
 M/DtOtxG+cWrXxUPmnVkbM7FoeyjtV4tbJoEFHs2Us6DMfHmzLVjptaLxOK+UA/bDYkmhDoSSX2
 KifLnEfbtDKyloXOG5FLD0LPtON1f2w6dleSGPog0yLi9j/Zd29xELoGH/dHRlxHqwMY0zMRPy4
 DcZIxypM5DfxWPcl9uk4F5QiYz7tTrm/TvclRn6/L+b/dcyrm39IrFgr02R8K/XLVVFIS+2Ptwg
 0yFxqMnJ7AgwIhKfsTedaUBXQ/6aNWT6sQ73GbCU8gn2rx0Vo6QQG/4qQKhoX9I8kI/mXpBmNDd
 OIQ9XD0JAOijREk14nJCkgXfVsMOQo8XBs/NxwNBmkoZvhHrEst0=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Move code specific to normal led class devices into a separate file and
introduce the `led::Mode` trait to allow for other types of led class
devices in `led::LedOps`.

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 MAINTAINERS               |   1 +
 rust/kernel/led.rs        | 242 ++++++----------------------------------------
 rust/kernel/led/normal.rs | 223 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 256 insertions(+), 210 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8c8648a26f93..d17c8f577ff3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14275,6 +14275,7 @@ L:	linux-leds@vger.kernel.org
 L:	rust-for-linux@vger.kernel.org
 S:	Maintained
 F:	rust/kernel/led.rs
+F:	rust/kernel/led/
 
 LEGO MINDSTORMS EV3
 R:	David Lechner <david@lechnology.com>
diff --git a/rust/kernel/led.rs b/rust/kernel/led.rs
index cdd9b0300b72..a9eb2e8e480c 100644
--- a/rust/kernel/led.rs
+++ b/rust/kernel/led.rs
@@ -33,15 +33,9 @@
     }, //
 };
 
-/// The led class device representation.
-///
-/// This structure represents the Rust abstraction for a C `struct led_classdev`.
-#[pin_data(PinnedDrop)]
-pub struct Device<T: LedOps> {
-    ops: T,
-    #[pin]
-    classdev: Opaque<bindings::led_classdev>,
-}
+mod normal;
+
+pub use normal::{Device, Normal};
 
 /// The led init data representation.
 ///
@@ -134,6 +128,7 @@ pub fn color(self, color: Color) -> Self {
 /// #[vtable]
 /// impl led::LedOps for MyLedOps {
 ///     type Bus = platform::Device<device::Bound>;
+///     type Mode = led::Normal;
 ///     const BLOCKING: bool = false;
 ///     const MAX_BRIGHTNESS: u32 = 255;
 ///
@@ -164,6 +159,12 @@ pub trait LedOps: Send + 'static + Sized {
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
@@ -176,12 +177,17 @@ pub trait LedOps: Send + 'static + Sized {
     fn brightness_set(
         &self,
         dev: &Self::Bus,
-        classdev: &Device<Self>,
+        classdev: &<Self::Mode as Mode>::Device<Self>,
         brightness: u32,
     ) -> Result<()>;
 
     /// Gets the current brightness level.
-    fn brightness_get(&self, _dev: &Self::Bus, _classdev: &Device<Self>) -> u32 {
+    fn brightness_get(
+        &self,
+        dev: &Self::Bus,
+        classdev: &<Self::Mode as Mode>::Device<Self>,
+    ) -> u32 {
+        let _ = (dev, classdev);
         build_error!(VTABLE_DEFAULT_ERROR)
     }
 
@@ -195,11 +201,12 @@ fn brightness_get(&self, _dev: &Self::Bus, _classdev: &Device<Self>) -> u32 {
     /// See also [`LedOps::BLOCKING`].
     fn blink_set(
         &self,
-        _dev: &Self::Bus,
-        _classdev: &Device<Self>,
-        _delay_on: &mut usize,
-        _delay_off: &mut usize,
+        dev: &Self::Bus,
+        classdev: &<Self::Mode as Mode>::Device<Self>,
+        delay_on: &mut usize,
+        delay_off: &mut usize,
     ) -> Result<()> {
+        let _ = (dev, classdev, delay_on, delay_off);
         build_error!(VTABLE_DEFAULT_ERROR)
     }
 }
@@ -250,201 +257,16 @@ fn try_from(value: u32) -> core::result::Result<Self, Self::Error> {
     }
 }
 
-// SAFETY: A `led::Device` can be unregistered from any thread.
-unsafe impl<T: LedOps + Send> Send for Device<T> {}
-
-// SAFETY: `led::Device` can be shared among threads because all methods of `led::Device`
-// are thread safe.
-unsafe impl<T: LedOps + Sync> Sync for Device<T> {}
-
-impl<T: LedOps> Device<T> {
-    /// Registers a new led classdev.
-    ///
-    /// The [`Device`] will be unregistered on drop.
-    pub fn new<'a>(
-        parent: &'a T::Bus,
-        init_data: InitData<'a>,
-        ops: T,
-    ) -> impl PinInit<Devres<Self>, Error> + 'a {
-        Devres::new(
-            parent.as_ref(),
-            try_pin_init!(Self {
-                ops,
-                classdev <- Opaque::try_ffi_init(|ptr: *mut bindings::led_classdev| {
-                    // SAFETY: `try_ffi_init` guarantees that `ptr` is valid for write.
-                    // `led_classdev` gets fully initialized in-place by
-                    // `led_classdev_register_ext` including `mutex` and `list_head`.
-                    unsafe {
-                        ptr.write(bindings::led_classdev {
-                            brightness_set: (!T::BLOCKING)
-                                .then_some(Adapter::<T>::brightness_set_callback),
-                            brightness_set_blocking: T::BLOCKING
-                                .then_some(Adapter::<T>::brightness_set_blocking_callback),
-                            brightness_get: T::HAS_BRIGHTNESS_GET
-                                .then_some(Adapter::<T>::brightness_get_callback),
-                            blink_set: T::HAS_BLINK_SET.then_some(Adapter::<T>::blink_set_callback),
-                            max_brightness: T::MAX_BRIGHTNESS,
-                            brightness: init_data.initial_brightness,
-                            default_trigger: init_data.default_trigger
-                                .map_or(core::ptr::null(), CStrExt::as_char_ptr),
-                            color: init_data.color as u32,
-                            ..bindings::led_classdev::default()
-                        })
-                    };
-
-                    let mut init_data_raw = bindings::led_init_data {
-                        fwnode: init_data.fwnode
-                            .as_ref()
-                            .map_or(core::ptr::null_mut(), |fwnode| fwnode.as_raw()),
-                        default_label: core::ptr::null(),
-                        devicename: init_data
-                            .devicename
-                            .map_or(core::ptr::null(), CStrExt::as_char_ptr),
-                        devname_mandatory: init_data.devname_mandatory,
-                    };
-
-                    // SAFETY:
-                    // - `parent.as_raw()` is guaranteed to be a pointer to a valid `device`
-                    //    or a null pointer.
-                    // - `ptr` is guaranteed to be a pointer to an initialized `led_classdev`.
-                    to_result(unsafe {
-                        bindings::led_classdev_register_ext(
-                            parent.as_ref().as_raw(),
-                            ptr,
-                            &raw mut init_data_raw,
-                        )
-                    })?;
-
-                    core::mem::forget(init_data.fwnode); // keep the reference count incremented
-
-                    Ok::<_, Error>(())
-                }),
-            }),
-        )
-    }
-
-    /// # Safety
-    /// `led_cdev` must be a valid pointer to a `led_classdev` embedded within a
-    /// `led::Device`.
-    unsafe fn from_raw<'a>(led_cdev: *mut bindings::led_classdev) -> &'a Self {
-        // SAFETY: The function's contract guarantees that `led_cdev` points to a `led_classdev`
-        // field embedded within a valid `led::Device`. `container_of!` can therefore
-        // safely calculate the address of the containing struct.
-        unsafe { &*container_of!(Opaque::cast_from(led_cdev), Self, classdev) }
-    }
-
-    fn parent(&self) -> &device::Device<Bound> {
-        // SAFETY:
-        // - `self.classdev.get()` is guaranteed to be a valid pointer to `led_classdev`.
-        unsafe { device::Device::from_raw((*(*self.classdev.get()).dev).parent) }
-    }
-}
-
-struct Adapter<T: LedOps> {
-    _p: PhantomData<T>,
-}
-
-impl<T: LedOps> Adapter<T> {
-    /// # Safety
-    /// `led_cdev` must be a valid pointer to a `led_classdev` embedded within a
-    /// `led::Device`.
-    /// This function is called on setting the brightness of a led.
-    unsafe extern "C" fn brightness_set_callback(
-        led_cdev: *mut bindings::led_classdev,
-        brightness: u32,
-    ) {
-        // SAFETY: The function's contract guarantees that `led_cdev` is a valid pointer to a
-        // `led_classdev` embedded within a `led::Device`.
-        let classdev = unsafe { Device::<T>::from_raw(led_cdev) };
-        // SAFETY: `classdev.parent()` is guaranteed to be contained in `T::Bus`.
-        let parent = unsafe { T::Bus::from_device(classdev.parent()) };
-
-        let _ = classdev.ops.brightness_set(parent, classdev, brightness);
-    }
-
-    /// # Safety
-    /// `led_cdev` must be a valid pointer to a `led_classdev` embedded within a
-    /// `led::Device`.
-    /// This function is called on setting the brightness of a led immediately.
-    unsafe extern "C" fn brightness_set_blocking_callback(
-        led_cdev: *mut bindings::led_classdev,
-        brightness: u32,
-    ) -> i32 {
-        from_result(|| {
-            // SAFETY: The function's contract guarantees that `led_cdev` is a valid pointer to a
-            // `led_classdev` embedded within a `led::Device`.
-            let classdev = unsafe { Device::<T>::from_raw(led_cdev) };
-            // SAFETY: `classdev.parent()` is guaranteed to be contained in `T::Bus`.
-            let parent = unsafe { T::Bus::from_device(classdev.parent()) };
-
-            classdev.ops.brightness_set(parent, classdev, brightness)?;
-            Ok(0)
-        })
-    }
-
-    /// # Safety
-    /// `led_cdev` must be a valid pointer to a `led_classdev` embedded within a
-    /// `led::Device`.
-    /// This function is called on getting the brightness of a led.
-    unsafe extern "C" fn brightness_get_callback(led_cdev: *mut bindings::led_classdev) -> u32 {
-        // SAFETY: The function's contract guarantees that `led_cdev` is a valid pointer to a
-        // `led_classdev` embedded within a `led::Device`.
-        let classdev = unsafe { Device::<T>::from_raw(led_cdev) };
-        // SAFETY: `classdev.parent()` is guaranteed to be contained in `T::Bus`.
-        let parent = unsafe { T::Bus::from_device(classdev.parent()) };
-
-        classdev.ops.brightness_get(parent, classdev)
-    }
-
-    /// # Safety
-    /// `led_cdev` must be a valid pointer to a `led_classdev` embedded within a
-    /// `led::Device`.
-    /// `delay_on` and `delay_off` must be valid pointers to `usize` and have
-    /// exclusive access for the period of this function.
-    /// This function is called on enabling hardware accelerated blinking.
-    unsafe extern "C" fn blink_set_callback(
-        led_cdev: *mut bindings::led_classdev,
-        delay_on: *mut usize,
-        delay_off: *mut usize,
-    ) -> i32 {
-        from_result(|| {
-            // SAFETY: The function's contract guarantees that `led_cdev` is a valid pointer to a
-            // `led_classdev` embedded within a `led::Device`.
-            let classdev = unsafe { Device::<T>::from_raw(led_cdev) };
-            // SAFETY: `classdev.parent()` is guaranteed to be contained in `T::Bus`.
-            let parent = unsafe { T::Bus::from_device(classdev.parent()) };
-
-            classdev.ops.blink_set(
-                parent,
-                classdev,
-                // SAFETY: The function's contract guarantees that `delay_on` points to a `usize`
-                // and is exclusive for the period of this function.
-                unsafe { &mut *delay_on },
-                // SAFETY: The function's contract guarantees that `delay_off` points to a `usize`
-                // and is exclusive for the period of this function.
-                unsafe { &mut *delay_off },
-            )?;
-            Ok(0)
-        })
-    }
+/// The led mode.
+///
+/// Each led mode has its own led class device type with different capabilities.
+///
+/// See [`Normal`].
+pub trait Mode: private::Sealed {
+    /// The class device for the led mode.
+    type Device<T: LedOps<Mode = Self>>;
 }
 
-#[pinned_drop]
-impl<T: LedOps> PinnedDrop for Device<T> {
-    fn drop(self: Pin<&mut Self>) {
-        let raw = self.classdev.get();
-        // SAFETY: The existence of `self` guarantees that `self.classdev.get()` is a pointer to a
-        // valid `struct led_classdev`.
-        let dev: &device::Device = unsafe { device::Device::from_raw((*raw).dev) };
-
-        let _fwnode = dev
-            .fwnode()
-            // SAFETY: the reference count of `fwnode` has previously been
-            // incremented in `led::Device::new`.
-            .map(|fwnode| unsafe { ARef::from_raw(NonNull::from(fwnode)) });
-
-        // SAFETY: The existence of `self` guarantees that `self.classdev` has previously been
-        // successfully registered with `led_classdev_register_ext`.
-        unsafe { bindings::led_classdev_unregister(self.classdev.get()) };
-    }
+mod private {
+    pub trait Sealed {}
 }
diff --git a/rust/kernel/led/normal.rs b/rust/kernel/led/normal.rs
new file mode 100644
index 000000000000..710ae438a088
--- /dev/null
+++ b/rust/kernel/led/normal.rs
@@ -0,0 +1,223 @@
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
+impl Mode for Normal {
+    type Device<T: LedOps<Mode = Self>> = Device<T>;
+}
+impl private::Sealed for Normal {}
+
+/// The led class device representation.
+///
+/// This structure represents the Rust abstraction for a led class device.
+#[pin_data(PinnedDrop)]
+pub struct Device<T: LedOps<Mode = Normal>> {
+    ops: T,
+    #[pin]
+    classdev: Opaque<bindings::led_classdev>,
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
+                            brightness_set: (!T::BLOCKING)
+                                .then_some(Adapter::<T>::brightness_set_callback),
+                            brightness_set_blocking: T::BLOCKING
+                                .then_some(Adapter::<T>::brightness_set_blocking_callback),
+                            brightness_get: T::HAS_BRIGHTNESS_GET
+                                .then_some(Adapter::<T>::brightness_get_callback),
+                            blink_set: T::HAS_BLINK_SET.then_some(Adapter::<T>::blink_set_callback),
+                            max_brightness: T::MAX_BRIGHTNESS,
+                            brightness: init_data.initial_brightness,
+                            default_trigger: init_data.default_trigger
+                                .map_or(core::ptr::null(), CStrExt::as_char_ptr),
+                            color: init_data.color as u32,
+                            ..bindings::led_classdev::default()
+                        })
+                    };
+
+                    let mut init_data_raw = bindings::led_init_data {
+                        fwnode: init_data.fwnode
+                            .as_ref()
+                            .map_or(core::ptr::null_mut(), |fwnode| fwnode.as_raw()),
+                        default_label: core::ptr::null(),
+                        devicename: init_data
+                            .devicename
+                            .map_or(core::ptr::null(), CStrExt::as_char_ptr),
+                        devname_mandatory: init_data.devname_mandatory,
+                    };
+
+                    // SAFETY:
+                    // - `parent.as_ref().as_raw()` is guaranteed to be a pointer to a valid
+                    //    `device`.
+                    // - `ptr` is guaranteed to be a pointer to an initialized `led_classdev`.
+                    to_result(unsafe {
+                        bindings::led_classdev_register_ext(
+                            parent.as_ref().as_raw(),
+                            ptr,
+                            &raw mut init_data_raw,
+                        )
+                    })?;
+
+                    core::mem::forget(init_data.fwnode); // keep the reference count incremented
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
+        // SAFETY: `self.classdev.get()` is guaranteed to be a valid pointer to `led_classdev`.
+        unsafe { device::Device::from_raw((*(*self.classdev.get()).dev).parent) }
+    }
+}
+
+// SAFETY: A `led::Device` can be unregistered from any thread.
+unsafe impl<T: LedOps<Mode = Normal> + Send> Send for Device<T> {}
+
+// SAFETY: `led::Device` can be shared among threads because all methods of `led::Device`
+// are thread safe.
+unsafe impl<T: LedOps<Mode = Normal> + Sync> Sync for Device<T> {}
+
+struct Adapter<T: LedOps<Mode = Normal>> {
+    _p: PhantomData<T>,
+}
+
+impl<T: LedOps<Mode = Normal>> Adapter<T> {
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
+        let _ = classdev.ops.brightness_set(parent, classdev, brightness);
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
+            classdev.ops.brightness_set(parent, classdev, brightness)?;
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
+        classdev.ops.brightness_get(parent, classdev)
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
+                classdev,
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
+impl<T: LedOps<Mode = Normal>> PinnedDrop for Device<T> {
+    fn drop(self: Pin<&mut Self>) {
+        let raw = self.classdev.get();
+        // SAFETY: The existence of `self` guarantees that `self.classdev.get()` is a pointer to a
+        // valid `led_classdev`.
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
+        unsafe { bindings::led_classdev_unregister(raw) };
+    }
+}

-- 
2.51.2


