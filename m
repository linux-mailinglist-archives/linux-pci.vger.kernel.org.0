Return-Path: <linux-pci+bounces-44076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E4CCF661E
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 02:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96F7630ABCC0
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 01:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B555321CC58;
	Tue,  6 Jan 2026 01:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="qLpHpgx5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BCC21018A
	for <linux-pci@vger.kernel.org>; Tue,  6 Jan 2026 01:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767664277; cv=none; b=MKRCvI5UL+HCRx+Qcac+RgGbLREPD/lOo3nCCRLjZmQoqDxwA7UEYMZTyTbIxSLQc0SbcDPZqUN5WtjbUlkKjKM/oXBvD+rf4ASgVVwzkcVt0kgnoj7o8CmO09MEnzft1irMBZAREbzZqExj/UJmzIlOMdF6nLqIvIGxAbEdPbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767664277; c=relaxed/simple;
	bh=NrFVmHpqGiFc4KTRNLdR0xr2E6CieYiGK6FSMD985oE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YWAfu3gafmSFaGIlbBYv+F7qez3TbbOGOAfPP6zCyBKMfXZtoIF3ZbBD3p6awp3sOqybID7EkgvXPz98Jr0P7DOs27IcHTlcf3HGrgSo5IueVAjavExE7LpsG0TYsR2EbP8W3eEuZbZvqx9M70HRh1WQgRDukI7M64akXGSsfqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=qLpHpgx5; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 29975240103
	for <linux-pci@vger.kernel.org>; Tue,  6 Jan 2026 02:42:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1767663773; bh=wme5I2kMCGMxH2FpT6bqyV/3UOhpwx7GsUYd9f0Uhv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=qLpHpgx5tc7oTEG3ElhrLWJZyJYlJWhlCBlYvS+6MSqIk8EDH3+P13bdz0PgXPK1Y
	 u7PRMuA6NeyDRiAyv2aqqODDf7c1pRYP6KuTwrb9xvjloTrYIZUlL95vzxP0N+to9T
	 5vB296SKaoJkaHGpKTWaesj0sIK3ZQK4rFemE1R5CXBrqJVxlehN1QmFObpqpyGnEq
	 JqGhFvvscc+qHwzc7xe0/0+FmuNyB5JCU7XAi9BeoMEnC5WRgXW8KOoGkpR5KK4nul
	 JZOsKixd61Cc5Gs6TglpRmYXlnBWxrWCm1yXMceqtPedYcErTtvMnOcPSlW6zxOyU3
	 QuZtUbRk/3iWg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dlYp21lrRz6twR;
	Tue,  6 Jan 2026 02:42:50 +0100 (CET)
From: Markus Probst <markus.probst@posteo.de>
Date: Tue, 06 Jan 2026 01:42:52 +0000
Subject: [PATCH v10 1/3] rust: leds: add basic led classdev abstractions
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260106-rust_leds-v10-1-e0a1564884f9@posteo.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=18142;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=NrFVmHpqGiFc4KTRNLdR0xr2E6CieYiGK6FSMD985oE=;
 b=owEBiQJ2/ZANAwAIATR2H/jnrUPSAcsmYgBpXGiXYDqQ5cytH/Kgla7jO1QBN/cTX+jejIvqd
 8re+8X9f8qJAk8EAAEIADkWIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaVxolxsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMSwyLDIACgkQNHYf+OetQ9KbYRAArM8/fS4muuHHc8F5xanwgQLexSIbjhO
 yyWeUWL80YmyOXB2ELA2sV8xt0rl6fJmTxcXKORZjBy6nv1FmoNifavun8utjXz784s/g02RhKi
 WFblHdIPYeVezFnoV9GgPWKOyIEmMskYvjw+GL0YqH3wqn6l7fdyGcJwa8/YjxwP3TTSx45WSfC
 H20/hGqgWnnKYMl0AwLZOWrXKrzuD+TX0WXVZm4OmQO3w4S83NXMUAG3vo1CIU24jHEQ2HwXVV7
 gzPFpTkr+lYape1EtQHGEZSCt8cFwaJEJ0ctQ+XtM9zVWAlXFyUe+f7NERlMv11bnY7ghtW/eUl
 /PQ3oY3lk7x8ue93GnCUWBRPLvKU/ygvXS5NHL7abLpYlttL5kmDoW2gU2ecEHl8qY2aGlO40B8
 NVDR/a7dbmul6pORCYkdrnJTH+pFRG+Z43BnYK023/F7bD12ldP65nF2QD9igZYvVduylewHpXy
 EIJKyrMikuwxHLC2833gFrcPC+shO+LOdR2LwmsAmMjW69pJl5rKg09UqkqhzSDV1bznjC+60Ku
 j4n/3rfqXojtzQ4U/uf6T/TAt+ZvP7NczLzbXaFy3i5LaY0BPm9RZAtla7DR7WTm8AoqreyQ92d
 Ay7fh0KUp068NUdvk7LQSGyWCTUBeyfRqNPUnOuT8UO1J2qrJoKo=
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
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
 MAINTAINERS        |   7 +
 rust/kernel/led.rs | 450 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs |   1 +
 3 files changed, 458 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 765ad2daa218..8c8648a26f93 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14269,6 +14269,13 @@ F:	drivers/leds/
 F:	include/dt-bindings/leds/
 F:	include/linux/leds.h
 
+LED SUBSYSTEM [RUST]
+M:	Markus Probst <markus.probst@posteo.de>
+L:	linux-leds@vger.kernel.org
+L:	rust-for-linux@vger.kernel.org
+S:	Maintained
+F:	rust/kernel/led.rs
+
 LEGO MINDSTORMS EV3
 R:	David Lechner <david@lechnology.com>
 S:	Maintained
diff --git a/rust/kernel/led.rs b/rust/kernel/led.rs
new file mode 100644
index 000000000000..cdd9b0300b72
--- /dev/null
+++ b/rust/kernel/led.rs
@@ -0,0 +1,450 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Abstractions for the leds driver model.
+//!
+//! C header: [`include/linux/leds.h`](srctree/include/linux/leds.h)
+
+use core::{
+    marker::PhantomData,
+    mem::transmute,
+    ptr::NonNull, //
+};
+
+use crate::{
+    container_of,
+    device::{
+        self,
+        property::FwNode,
+        AsBusDevice,
+        Bound, //
+    },
+    devres::Devres,
+    error::{
+        from_result,
+        to_result,
+        VTABLE_DEFAULT_ERROR, //
+    },
+    macros::vtable,
+    prelude::*,
+    str::CStrExt,
+    types::{
+        ARef,
+        Opaque, //
+    }, //
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
+/// This structure represents the Rust abstraction for a C `struct led_init_data` with additional
+/// fields from `struct led_classdev`.
+#[derive(Default)]
+pub struct InitData<'a> {
+    fwnode: Option<ARef<FwNode>>,
+    devicename: Option<&'a CStr>,
+    devname_mandatory: bool,
+    initial_brightness: u32,
+    default_trigger: Option<&'a CStr>,
+    color: Color,
+}
+
+impl InitData<'static> {
+    /// Creates a new [`InitData`].
+    pub fn new() -> Self {
+        Self::default()
+    }
+}
+
+impl<'a> InitData<'a> {
+    /// Sets the firmware node.
+    pub fn fwnode(self, fwnode: Option<ARef<FwNode>>) -> Self {
+        Self { fwnode, ..self }
+    }
+
+    /// Sets the device name.
+    pub fn devicename(self, devicename: &'a CStr) -> Self {
+        Self {
+            devicename: Some(devicename),
+            ..self
+        }
+    }
+
+    /// Sets if a device name is mandatory.
+    pub fn devicename_mandatory(self, mandatory: bool) -> Self {
+        Self {
+            devname_mandatory: mandatory,
+            ..self
+        }
+    }
+
+    /// Sets the initial brightness value for the led.
+    ///
+    /// The default brightness is 0.
+    /// If [`LedOps::brightness_get`] is implemented, this value will be ignored.
+    pub fn initial_brightness(self, brightness: u32) -> Self {
+        Self {
+            initial_brightness: brightness,
+            ..self
+        }
+    }
+
+    /// Set the default led trigger.
+    ///
+    /// This value can be overwritten by the "linux,default-trigger" fwnode property.
+    pub fn default_trigger(self, trigger: &'a CStr) -> Self {
+        Self {
+            default_trigger: Some(trigger),
+            ..self
+        }
+    }
+
+    /// Sets the color of the led.
+    ///
+    /// This value can be overwritten by the "color" fwnode property.
+    pub fn color(self, color: Color) -> Self {
+        Self { color, ..self }
+    }
+}
+
+/// Trait defining the operations for a LED driver.
+///
+/// # Examples
+/// ```
+/// use kernel::{
+///      device,
+///      devres::Devres,
+///      led,
+///      macros::vtable,
+///      platform,
+///      prelude::*, //
+///  };
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
+///         _classdev: &led::Device<Self>,
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
+///         led::InitData::new(),
+///         MyLedOps,
+///     ), GFP_KERNEL)
+/// }
+/// ```
+/// Led drivers must implement this trait in order to register and handle a [`Device`].
+#[vtable]
+pub trait LedOps: Send + 'static + Sized {
+    /// The bus device required by the implementation.
+    #[allow(private_bounds)]
+    type Bus: AsBusDevice<Bound>;
+    /// If set true, [`LedOps::brightness_set`] and [`LedOps::blink_set`] must perform the
+    /// operation immediately. If set false, they must not sleep.
+    const BLOCKING: bool;
+    /// The max brightness level.
+    const MAX_BRIGHTNESS: u32;
+
+    /// Sets the brightness level.
+    ///
+    /// See also [`LedOps::BLOCKING`].
+    fn brightness_set(
+        &self,
+        dev: &Self::Bus,
+        classdev: &Device<Self>,
+        brightness: u32,
+    ) -> Result<()>;
+
+    /// Gets the current brightness level.
+    fn brightness_get(&self, _dev: &Self::Bus, _classdev: &Device<Self>) -> u32 {
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
+    /// See also [`LedOps::BLOCKING`].
+    fn blink_set(
+        &self,
+        _dev: &Self::Bus,
+        _classdev: &Device<Self>,
+        _delay_on: &mut usize,
+        _delay_off: &mut usize,
+    ) -> Result<()> {
+        build_error!(VTABLE_DEFAULT_ERROR)
+    }
+}
+
+/// Led colors.
+#[derive(Copy, Clone, Debug, Default)]
+#[repr(u32)]
+#[non_exhaustive]
+#[expect(
+    missing_docs,
+    reason = "it shouldn't be necessary to document each color"
+)]
+pub enum Color {
+    #[default]
+    White = bindings::LED_COLOR_ID_WHITE,
+    Red = bindings::LED_COLOR_ID_RED,
+    Green = bindings::LED_COLOR_ID_GREEN,
+    Blue = bindings::LED_COLOR_ID_BLUE,
+    Amber = bindings::LED_COLOR_ID_AMBER,
+    Violet = bindings::LED_COLOR_ID_VIOLET,
+    Yellow = bindings::LED_COLOR_ID_YELLOW,
+    Ir = bindings::LED_COLOR_ID_IR,
+    Multi = bindings::LED_COLOR_ID_MULTI,
+    Rgb = bindings::LED_COLOR_ID_RGB,
+    Purple = bindings::LED_COLOR_ID_PURPLE,
+    Orange = bindings::LED_COLOR_ID_ORANGE,
+    Pink = bindings::LED_COLOR_ID_PINK,
+    Cyan = bindings::LED_COLOR_ID_CYAN,
+    Lime = bindings::LED_COLOR_ID_LIME,
+}
+
+impl TryFrom<u32> for Color {
+    type Error = Error;
+
+    fn try_from(value: u32) -> core::result::Result<Self, Self::Error> {
+        const _: () = {
+            assert!(bindings::LED_COLOR_ID_MAX == 15);
+        };
+        if value < bindings::LED_COLOR_ID_MAX {
+            // SAFETY:
+            // - `Color` is represented as `u32`
+            // - the const block above guarantees that no additional color has been added
+            // - `value` is guaranteed to be in the color id range
+            Ok(unsafe { transmute::<u32, Color>(value) })
+        } else {
+            Err(EINVAL)
+        }
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
+                    // - `parent.as_raw()` is guaranteed to be a pointer to a valid `device`
+                    //    or a null pointer.
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
index f812cf120042..231818e0614b 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -108,6 +108,7 @@
 pub mod jump_label;
 #[cfg(CONFIG_KUNIT)]
 pub mod kunit;
+pub mod led;
 pub mod list;
 pub mod maple_tree;
 pub mod miscdevice;

-- 
2.51.2


