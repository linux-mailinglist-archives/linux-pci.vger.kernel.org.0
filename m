Return-Path: <linux-pci+bounces-41307-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBD4C60955
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 18:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2D3AF34A4F0
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 17:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AE93064B1;
	Sat, 15 Nov 2025 17:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="B+PDPrAq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D250D3064B3
	for <linux-pci@vger.kernel.org>; Sat, 15 Nov 2025 17:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763227571; cv=none; b=Qj9Q/9udflQpJZhByVIU7ySb02VR9RlB3HcHJk3f5FDPS8wGg6dVpeu9xcXRJN4AFLE8ssRmd3sHotmm2XHWgzjuduc8XdIgMwid6jZXRCo8YTbBL6y1LQRs2ZD7ES+wXLRpXNuNpv9yakpqkf8suCFqTQZUA//9ZccRZ3flX+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763227571; c=relaxed/simple;
	bh=Uohd819v/S6bIx68JfE/asm+yhU2CxYdcSIDKKM7zLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p7cQGKSUAZHbzm+wuOt3+d2BqTxhMi2nW1M4D6zTNwSaxaji3D1J53cmD/O/yTL2KulZoUH91pOglLhPcS/ESY/fo5z5oE35Ef3emSWw/GVDLXHCC9YlBH5ODNF+JyTHdX3yApqsw1ZkDmP4yjHAOGsmmhrTycZlX9omeOGYtr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=B+PDPrAq; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 310BC240027
	for <linux-pci@vger.kernel.org>; Sat, 15 Nov 2025 18:26:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1763227567; bh=zqKg1rOa6hGcURHxMPuTQZ+rpn6vivHG4MhrXG7HuXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=B+PDPrAqbcnfmqLEN/DD+XLbWiPXCem9loYJoD6Tk0EM4bJTi5gPPBqtKrP6ZQSXi
	 SsLoiM7e7hBXbLHnA+4sPBU6VZEbYqaS/JPXjD8I8ZE30H44zs7HXHhnDYZ3v/4Bvu
	 QsRG6Uda5xGzHzfROFmLRnPuKAeuEG63riYhQC0zBNiprJvrLnhaWMZjR+2eVs42CS
	 vxLxQLFljdDUJZUCKl2cQieHRIsSxJQZGivllXX5l2jE8xpDQeg2lrJ7cSDlon1Bzs
	 u82eD2Xnj3Cj7t1bShQTDSY0l/sj/BekQehL38ToSIm5CAuuv4p78GYlbNIVftkuIN
	 RcCQRf4CsRvBg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4d81BN28Lnz9rxP;
	Sat, 15 Nov 2025 18:26:04 +0100 (CET)
From: Markus Probst <markus.probst@posteo.de>
Date: Sat, 15 Nov 2025 17:26:06 +0000
Subject: [PATCH v8 4/4] rust: leds: add multicolor classdev abstractions
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251115-rust_leds-v8-4-d9a41f355538@posteo.de>
References: <20251115-rust_leds-v8-0-d9a41f355538@posteo.de>
In-Reply-To: <20251115-rust_leds-v8-0-d9a41f355538@posteo.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9531;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=Uohd819v/S6bIx68JfE/asm+yhU2CxYdcSIDKKM7zLI=;
 b=owEBbQKS/ZANAwAIATR2H/jnrUPSAcsmYgBpGLeiXjdtIOhoUbd0+4XTbYeQmUy/cSXUFP6HL
 EifxJFwJ1aJAjMEAAEIAB0WIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaRi3ogAKCRA0dh/4561D
 0g22D/0Vake9v7h9gKLTz7I+t7b8STaVgeJKrkel5YlOEdbVt44QckXzVbEyKnRaxOYz7Hy2Tk8
 Uunl0WR/lQQ6a0lXKH3osHu/zeTM6YZRJ0oTuWmKR/tZyrZG+BYJakZySvpodRTDvmo4vgerXK5
 7cSxfHFMwfR1+nZWP/MdNlNJedSjFBJqYJbkgPKLSGtCglVRaMNqj5/XuQv23cRxqwIxy9YdpKT
 JUJ2iuxlDZjgPTMp44B0ey3tt6OEyqb+0XnFKzGtjo1npOYGFpVdQedRvR6o6mv5ptNOo2uGEqk
 3v2yzcgOf2Csj+yUSnzx+7pABS/6oDa7le4+MZDpIxvxkxJJQb4RROPV5xCMNIjFZjlqUNEs5Kn
 XL8b1cZxQwZwxFbOCMjWfgsDgz/eELR4ip3AoGlX4LaZPRC5lwWYwCgGQKeT4AccoQYFyGzbkJF
 cD/rrgb1rvtjeYswFj85JfK5xHofLFU38EcIbISWRHTjskFjLHyOdL66CoDscRmZlZg9w6+rAvg
 EDPfTi9/ZRjm+ifWyiolsy30llgp8xCu4zbi+RWZ1vzZ/tnXqKa++/dgwcbe597nsNa4A0ybT84
 Todz0B+gRSzsD7PRF63Q+jqB99JCGXeyTWBwODJ5eKOxUOAXnNnEAm0HvbkLZ+haGb0ZM7j7GHs
 3DPgdRhe5/jX0Kw==
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Implement the abstractions needed for multicolor led class devices,
including:

* `led::MultiColor` - the led mode implementation

* `MultiColorSubLed` - a safe wrapper arround `mc_subled`

* `led::Device::new_multicolor()` - the function to register a multicolor
  led class device

* `led::Device::subleds()` - the function to access the brightness and
  intensity of the individual sub leds

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 rust/bindings/bindings_helper.h |   1 +
 rust/kernel/led.rs              |   7 +-
 rust/kernel/led/multicolor.rs   | 195 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 202 insertions(+), 1 deletion(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 2e43c66635a2..ba8605eeecce 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -61,6 +61,7 @@
 #include <linux/ioport.h>
 #include <linux/jiffies.h>
 #include <linux/jump_label.h>
+#include <linux/led-class-multicolor.h>
 #include <linux/mdio.h>
 #include <linux/mm.h>
 #include <linux/miscdevice.h>
diff --git a/rust/kernel/led.rs b/rust/kernel/led.rs
index c55f9852d378..4add9d15a5e0 100644
--- a/rust/kernel/led.rs
+++ b/rust/kernel/led.rs
@@ -44,8 +44,12 @@
     }, //
 };
 
+#[cfg(CONFIG_LEDS_CLASS_MULTICOLOR)]
+mod multicolor;
 mod normal;
 
+#[cfg(CONFIG_LEDS_CLASS_MULTICOLOR)]
+pub use multicolor::{MultiColor, MultiColorSubLed};
 pub use normal::Normal;
 
 /// The led class device representation.
@@ -288,7 +292,8 @@ fn try_from(value: u32) -> core::result::Result<Self, Self::Error> {
 ///
 /// Each led mode has its own led class device type with different capabilities.
 ///
-/// See [`Normal`].
+#[cfg_attr(CONFIG_LEDS_CLASS_MULTICOLOR, doc = "See [`Normal`] and [`MultiColor`].")]
+#[cfg_attr(not(CONFIG_LEDS_CLASS_MULTICOLOR), doc = "See [`Normal`] and `MultiColor`.")]
 pub trait Mode: private::Mode {}
 
 impl<T: private::Mode> Mode for T {}
diff --git a/rust/kernel/led/multicolor.rs b/rust/kernel/led/multicolor.rs
new file mode 100644
index 000000000000..3afefaef6498
--- /dev/null
+++ b/rust/kernel/led/multicolor.rs
@@ -0,0 +1,195 @@
+// SPDX-License-Identifier: GPL-2.0
+
+//! Led mode for the `struct led_classdev_mc`.
+//!
+//! C header: [`include/linux/led-class-multicolor.h`](srctree/include/linux/led-class-multicolor.h)
+
+use crate::{
+    alloc::KVec,
+    error::code::EINVAL,
+    prelude::*, //
+};
+
+use super::*;
+
+/// The led mode for the `struct led_classdev_mc`. Leds with this mode can have multiple colors.
+pub enum MultiColor {}
+
+/// The multicolor sub led info representation.
+///
+/// This structure represents the Rust abstraction for a C `struct mc_subled`.
+#[repr(C)]
+#[derive(Copy, Clone, Debug)]
+pub struct MultiColorSubLed {
+    /// the color of the sub led
+    pub color: Color,
+    /// the brightness of the sub led.
+    ///
+    /// The value will be automatically calculated.
+    /// See `MultiColor::pre_brightness_set`.
+    pub brightness: u32,
+    /// the intensity of the sub led.
+    pub intensity: u32,
+    /// arbitrary data for the driver to store.
+    pub channel: u32,
+    _p: PhantomData<()>, // Only allow creation with `MultiColorSubLed::new`.
+}
+
+// We directly pass a reference to the `subled_info` field in `led_classdev_mc` to the driver via
+// `Device::subleds()`.
+// We need safeguards to ensure `MultiColorSubLed` and `mc_subled` stay identical.
+const _: () = {
+    use core::mem::offset_of;
+
+    const fn assert_same_type<T>(_: &T, _: &T) {}
+
+    let rust_zeroed = MultiColorSubLed {
+        color: Color::White,
+        brightness: 0,
+        intensity: 0,
+        channel: 0,
+        _p: PhantomData,
+    };
+    let c_zeroed = bindings::mc_subled {
+        color_index: 0,
+        brightness: 0,
+        intensity: 0,
+        channel: 0,
+    };
+
+    assert!(offset_of!(MultiColorSubLed, color) == offset_of!(bindings::mc_subled, color_index));
+    assert_same_type(&0u32, &c_zeroed.color_index);
+
+    assert!(
+        offset_of!(MultiColorSubLed, brightness) == offset_of!(bindings::mc_subled, brightness)
+    );
+    assert_same_type(&rust_zeroed.brightness, &c_zeroed.brightness);
+
+    assert!(offset_of!(MultiColorSubLed, intensity) == offset_of!(bindings::mc_subled, intensity));
+    assert_same_type(&rust_zeroed.intensity, &c_zeroed.intensity);
+
+    assert!(offset_of!(MultiColorSubLed, channel) == offset_of!(bindings::mc_subled, channel));
+    assert_same_type(&rust_zeroed.channel, &c_zeroed.channel);
+
+    assert!(size_of::<MultiColorSubLed>() == size_of::<bindings::mc_subled>());
+};
+
+impl MultiColorSubLed {
+    /// Create a new multicolor sub led info.
+    pub fn new(color: Color) -> Self {
+        Self {
+            color,
+            brightness: 0,
+            intensity: 0,
+            channel: 0,
+            _p: PhantomData,
+        }
+    }
+
+    /// Set arbitrary data for the driver.
+    pub fn channel(mut self, channel: u32) -> Self {
+        self.channel = channel;
+        self
+    }
+
+    /// Set the initial intensity of the subled.
+    pub fn initial_intensity(mut self, intensity: u32) -> Self {
+        self.intensity = intensity;
+        self
+    }
+}
+
+impl private::Mode for MultiColor {
+    type Type = bindings::led_classdev_mc;
+    const REGISTER: RegisterFunc<Self::Type> = bindings::led_classdev_multicolor_register_ext;
+    const UNREGISTER: UnregisterFunc<Self::Type> = bindings::led_classdev_multicolor_unregister;
+
+    unsafe fn device<'a>(raw: *mut Self::Type) -> &'a device::Device {
+        // SAFETY:
+        // - The function's contract guarantees that `raw` is a valid pointer to `led_classdev`.
+        unsafe { device::Device::from_raw((*raw).led_cdev.dev) }
+    }
+
+    unsafe fn from_classdev(led_cdev: *mut bindings::led_classdev) -> *mut Self::Type {
+        // SAFETY: The function's contract guarantees that `led_cdev` is a valid pointer to
+        // `led_classdev` embedded within a `Self::Type`.
+        unsafe { container_of!(led_cdev, bindings::led_classdev_mc, led_cdev) }
+    }
+
+    unsafe fn pre_brightness_set(raw: *mut Self::Type, brightness: u32) {
+        // SAFETY: The function's contract guarantees that `raw` is a valid pointer to
+        // `led_classdev_mc`.
+        unsafe { bindings::led_mc_calc_color_components(raw, brightness) };
+    }
+
+    fn release(led_cdev: &mut Self::Type) {
+        // SAFETY: `subled_info` is guaranteed to be a valid array pointer to `mc_subled` with the
+        // length and capacity of `led_cdev.num_colors`. See `led::Device::new_multicolor`.
+        let _subleds_vec = unsafe {
+            KVec::from_raw_parts(
+                led_cdev.subled_info,
+                led_cdev.num_colors as usize,
+                led_cdev.num_colors as usize,
+            )
+        };
+    }
+}
+
+impl<T: LedOps<Mode = MultiColor>> Device<T> {
+    /// Registers a new multicolor led classdev.
+    ///
+    /// The [`Device`] will be unregistered on drop.
+    pub fn new_multicolor<'a>(
+        parent: &'a T::Bus,
+        init_data: InitData<'a>,
+        ops: T,
+        subleds: &'a [MultiColorSubLed],
+    ) -> impl PinInit<Devres<Self>, Error> + 'a {
+        assert!(subleds.len() <= u32::MAX as usize);
+        Self::__new(parent, init_data, ops, |led_cdev| {
+            let mut subleds_vec = KVec::new();
+            subleds_vec.extend_from_slice(subleds, GFP_KERNEL)?;
+            let (subled_info, num_colors, capacity) = subleds_vec.into_raw_parts();
+            debug_assert_eq!(num_colors, capacity);
+
+            let mut used = 0;
+            if subleds.iter().any(|subled| {
+                let bit = 1 << (subled.color as u32);
+                if (used & bit) != 0 {
+                    true
+                } else {
+                    used |= bit;
+                    false
+                }
+            }) {
+                dev_err!(parent.as_ref(), "duplicate color in multicolor led\n");
+                return Err(EINVAL);
+            }
+
+            Ok(bindings::led_classdev_mc {
+                led_cdev,
+                // CAST: We checked above that the length of subleds fits into a u32.
+                num_colors: num_colors as u32,
+                // CAST: The safeguards in the const block ensure that `MultiColorSubLed` has an
+                // identical layout to `mc_subled`.
+                subled_info: subled_info.cast::<bindings::mc_subled>(),
+            })
+        })
+    }
+
+    /// Returns the subleds passed to [`Device::new_multicolor`].
+    pub fn subleds(&self) -> &[MultiColorSubLed] {
+        // SAFETY: The existence of `self` guarantees that `self.classdev.get()` is a pointer to a
+        // valid `led_classdev_mc`.
+        let raw = unsafe { &*self.classdev.get() };
+        // SAFETY: `raw.subled_info` is a valid pointer to `mc_subled[num_colors]`.
+        // CAST: The safeguards in the const block ensure that `MultiColorSubLed` has an identical
+        // layout to `mc_subled`.
+        unsafe {
+            core::slice::from_raw_parts(
+                raw.subled_info.cast::<MultiColorSubLed>(),
+                raw.num_colors as usize,
+            )
+        }
+    }
+}

-- 
2.51.0


