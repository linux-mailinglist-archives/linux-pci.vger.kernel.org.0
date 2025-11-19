Return-Path: <linux-pci+bounces-41637-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3822EC6F487
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 15:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D9F465007AC
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 14:12:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9872A364E9F;
	Wed, 19 Nov 2025 14:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="T9s+5sNJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD1E365A0F
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 14:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561498; cv=none; b=D6kYqJDG1pIdLi8FNDfKuV8qqFlkQf87+FYkNFzd+N7w4/iCNw/OFbGIJ2LXA1Q4sgGNGoifzLZHodhSOsozJbAkLWuxctC9KdcygEb73X9gOOYIW5x9bsFpxUUpmIjd1IKe5Jvh9FjCg9X5wtRT962AECMv5gy1dLhqy9TV/pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561498; c=relaxed/simple;
	bh=DY3Bm4NtAYa457ryVSDZmJmWwlLWDBAI1VLaFfmXsF8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PDNBrFUp4RbtPuU1TqFPkBRd1NOnojipaPa/PRl0W14WSUFUDJRzB+JJQDq1tza/XNWbEoJ/GUnQ8X5XTyWA21kMdWVzcz3SGNaRXsayByiCPQouzdyDfuzkY6JH/32ILWBRDSewTh5BkJQ9OvZWfITfOsxe1ISCpPjAE1ooLoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=T9s+5sNJ; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id D86C1240029
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 15:11:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1763561487; bh=2sINMZR+Orb1e0bIRwpcjQBgTeoK31kcru61/G6qYSE=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=T9s+5sNJsvVqhcIx9hnG4w3R9ao42HMDT6S6TlOh5CfFMd1lxjG8TO6JGIMrxpION
	 T8px82F96vBUQi5ZyZ5q/3zTIlDookWY6xxNOie9MbjVxLAegJYAGnWgG4dEibPGmO
	 vqSAZU/HDO0ME1dmpGE6FtXow3kranS0QssufJ7ww1Y2L01Hf0BEajyqcATDHRzh1X
	 HvthiCY/xCIN4bhJf6OySR8M3l3h8XhSpfjaTjZRT9e3YxDxUkF+vpyRLWlM4h5jvr
	 40rkZwO/8WQktEAqgs4uZGcdbGGM1y4PQDvTJEirVcgoS+kJexyw9KrK9bbycR/5LP
	 BeFMEqUW8opdg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dBNgw4QZgz6v2f;
	Wed, 19 Nov 2025 15:11:24 +0100 (CET)
From: Markus Probst <markus.probst@posteo.de>
Date: Wed, 19 Nov 2025 14:11:26 +0000
Subject: [PATCH v9 3/3] rust: leds: add multicolor classdev abstractions
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251119-rust_leds-v9-3-86c15da19063@posteo.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9583;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=DY3Bm4NtAYa457ryVSDZmJmWwlLWDBAI1VLaFfmXsF8=;
 b=owEBbQKS/ZANAwAIATR2H/jnrUPSAcsmYgBpHdAEEYjQaao77eh/AETH+S0LG0GOjWF9QgXQe
 83ayJq+TMiJAjMEAAEIAB0WIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaR3QBAAKCRA0dh/4561D
 0uT3D/90bs7tPvN5PTqcymMqxechfcFSJQiuBcupF00h7mtW+e3zc8rqqeG+Po8Ud/gfj2k1kKN
 FOjexFRC0EWSXn08YPxqaE0j2InwrXyMl7y6OyfdSivRU9EUtv/b4E8x9/wPwc0chTf/PkteLqr
 +T0JPWkvLnG/Uv/Bd2fSbhEPP62fpqLg2Wn4UXDpmAxPSJ2axyh4qOP0ic4sX04DAgJL+vfxDp2
 9GG2JKhNFRvvok13cYFUW9tJ+pQldKgBUOHOQbewvZ7ywNYdQP9hgQQlSqXtBOqJTxMlke/dhu8
 PPemVGlSkN/cMQolkjEWkgmVKSasJeZ/0Dlc4Gy+QyOL4B2UZmwocVAjnBLNnM7P8WMFR6FK21I
 jH2BaMBrPIeQ+cTHnrkqICrhTvwrVYJOrcZ67WdFyd6ScIDzLTKnjAGiZtoGG9cE4S2kyqWI8En
 Q2a4+Q4wQgx0BSg/8mxTPrZGCYkhHeFfat6IG8SMyn8Sc7RPP5WAHojWXQiloel2aufHhSW7IP0
 dJEcwVrhZmQOjmW6vSyl+n8CX1vU3G+c/6VnN9CoadUA3+3qab8qsxGDIOQaZlppQ54VTV83jw1
 rJcQRn8ougqfcLwiYk4zEvq4+0pbHE69CrMhFndr5OJUE/eRkum9R0K52SI2IR9X0Vg8lWWbGzT
 jUrF305DM+u9TTA==
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
 rust/kernel/led.rs              |  13 ++-
 rust/kernel/led/multicolor.rs   | 195 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 208 insertions(+), 1 deletion(-)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index f92abb578b56..8825b6df9c9e 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -62,6 +62,7 @@
 #include <linux/ioport.h>
 #include <linux/jiffies.h>
 #include <linux/jump_label.h>
+#include <linux/led-class-multicolor.h>
 #include <linux/mdio.h>
 #include <linux/mm.h>
 #include <linux/miscdevice.h>
diff --git a/rust/kernel/led.rs b/rust/kernel/led.rs
index d51735322093..7c1f6252605f 100644
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
@@ -285,7 +289,14 @@ fn try_from(value: u32) -> core::result::Result<Self, Self::Error> {
 ///
 /// Each led mode has its own led class device type with different capabilities.
 ///
-/// See [`Normal`].
+#[cfg_attr(
+    CONFIG_LEDS_CLASS_MULTICOLOR,
+    doc = "See [`Normal`] and [`MultiColor`]."
+)]
+#[cfg_attr(
+    not(CONFIG_LEDS_CLASS_MULTICOLOR),
+    doc = "See [`Normal`] and `MultiColor`."
+)]
 pub trait Mode: private::Mode {}
 
 impl<T: private::Mode> Mode for T {}
diff --git a/rust/kernel/led/multicolor.rs b/rust/kernel/led/multicolor.rs
new file mode 100644
index 000000000000..db5935448bd7
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
+    pub const fn new(color: Color) -> Self {
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
+    pub const fn channel(mut self, channel: u32) -> Self {
+        self.channel = channel;
+        self
+    }
+
+    /// Set the initial intensity of the subled.
+    pub const fn initial_intensity(mut self, intensity: u32) -> Self {
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


