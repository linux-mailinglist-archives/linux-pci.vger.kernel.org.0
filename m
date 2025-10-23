Return-Path: <linux-pci+bounces-39183-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB21C02BA7
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 19:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E6081AA451D
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 17:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F328F347BAB;
	Thu, 23 Oct 2025 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="RvxeRid9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C8512ECD11
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761240516; cv=none; b=TZuKj3W8wTqdsdsPC+WPKt74yf/RfpDt0KBudkF4d9AzrzGdDFX6SLJGNPKpqcVdjGImua4I/MGFxkKymr4zdgHB5gOWcIWmpmg09yVvUm31dxVkgI5b0xlV+mAYKWDcJBMn+sKOIJqY3DuU9Knk0t+76mVT8lfuvyYeZdcV9HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761240516; c=relaxed/simple;
	bh=AHFDoYfjon/4tGZlpCp8TVU857N1RhEo3OW1MemkxkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3NeNM+/O3Zkp4bNYdYJuKid3+FjouxvkoXCqbpkiktLmB+vHaJBYg3JVGdpHMogTfNl3SR78EIkOLSRW3p96p3DuW0zLuLJtT95oQ2enJ1Ev0OZv1DUemAO/Mieo7fLHpkqxlcFq+B6nwVjBy6rz8+Te1KBeX2pjGdC2nUh4jY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=RvxeRid9; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id F0C37240101
	for <linux-pci@vger.kernel.org>; Thu, 23 Oct 2025 19:28:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1761240512; bh=RrvubjSJi3MqTyvAC8OUUj/Q0ANkEdPC8q50Ec7fUD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Autocrypt:OpenPGP:From;
	b=RvxeRid9xPMZH5REw69NSanJ75+9X6YG24esm/ENW0Whf8nnH8LZE4OvWNys9QQkD
	 AvRiUfhF53N8aVxw3jHvUTcuT1+iizAvYEUO4EEOe+W5HqsXfWg1QYgK7Gq9t3IZ72
	 4sUfMC9laQjYr7d/JzmgS9x1dV5JZ+n7n6ozgO91Jl08xuz9b2jvJ5P8JpgMQP+9Ul
	 uOh2J/XNKwRkuqiddsx2r/cjoDGt/sJOE83rzc0VLzCgC5OK16ukDZuYwmiEyZ2Oqz
	 GImGQEHqDLrFBekeyUhJAQ99n0o/Q41+FS1AMYZk3Ksd0iDYziTmgXZl5bqD0/Ptcf
	 SGCTY8kj/MZNw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cstKW5tSHz6v2J;
	Thu, 23 Oct 2025 19:28:15 +0200 (CEST)
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
Subject: [PATCH v6 1/2] rust: Add trait to convert a device reference to a bus device reference
Date: Thu, 23 Oct 2025 17:28:18 +0000
Message-ID: <20251023172803.730677-2-markus.probst@posteo.de>
In-Reply-To: <20251023172803.730677-1-markus.probst@posteo.de>
References: <20251023172803.730677-1-markus.probst@posteo.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5467; i=markus.probst@posteo.de; h=from:subject; bh=AHFDoYfjon/4tGZlpCp8TVU857N1RhEo3OW1MemkxkA=; b=owEBbQKS/ZANAwAIATR2H/jnrUPSAcsmYgBo+mQk7ds/yPGUoEze9yaiY7baeuYuxgf9yNmUC g0US3spVCqJAjMEAAEIAB0WIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaPpkJAAKCRA0dh/4561D 0oo4D/9wbqvRM1QMq4Bwjg9o8KhrhZOjTqksjwkfS93pUsyfugqgkEFh1HIl1ksiikdNlexNb5E VtehOU0vOL3akZTLamwLS5nm5won8MOL8s1Iy+yQsPEGxzwM1kP0u8xBQ6n/0cocR3VImK8LNRG ycnwcHZpj2dfxEjcA+T+dTBPBERZ9XLQdBzSVKX5bfnNsQpaqdoGhAlVrxSv5BsFFY4ou7cbLys zUdoRXjZBHVQe6CVoksy0xJLG2JFYvKyWgKm1rM/N0Mo/juBU2BzO5BKZK6jWLxb6DOjnHAMimo 5aV4E0ybOw0ceGYc7Wzoa1iUoc2L1oS1TQaSNPMn7Z9LcKxn3ZL3xs040Hn8QCF52hj/8fJWi65 ZQ8pl/Waz7NLBlrS88q1PXFNyidycdBhdld0ZxHO22kom7KriwsH7cLbmfstnYw7NmaoSOrTGV5 GzxTSTQ2rorR3rswNsQzeTCWs0aLBLtFO6y5HwxBMfZ0y3/RVogHL4hr6tGryD4GpMXsOa7S4By btPz+fQDWsrRk3VMvY/wlqREjn3TYHIz3vlYSxNMPMYjx/lP4WJCjTLGdWIWP+c7uqpZ+ULu9/S BKjk7knCeDz5XRPEuKfC35WKJtJMdt9L4/8is7bOROV7RDXM8ZD4jJHVJsooeMDXNtlREcH+2li dxqRb9n2I/YLHxA=
 =
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp; fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Content-Transfer-Encoding: 8bit
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=xsFNBGiDvXgBEADAXUceKafpl46S35UmDh2wRvvx+UfZbcTjeQOlSwKP7YVJ4JOZrVs93qReNLkO
  WguIqPBxR9blQ4nyYrqSCV+MMw/3ifyXIm6Pw2YRUDg+WTEOjTixRCoWDgUj1nOsvJ9tVAm76Ww+
  /pAnepVRafMID0rqEfD9oGv1YrfpeFJhyE2zUw3SyyNLIKWD6QeLRhKQRbSnsXhGLFBXCqt9k5JA
  RhgQof9zvztcCVlT5KVvuyfC4H+HzeGmu9201BVyihJwKdcKPq+n/aY5FUVxNTgtI9f8wIbmfAja
  oT1pjXSp+dszakA98fhONM98pOq723o/1ZGMZukyXFfsDGtA3BB79HoopHKujLGWAGskzClwTjRQ
  xBqxh/U/lL1pc+0xPWikTNCmtziCOvv0KA0arDOMQlyFvImzX6oGVgE4ksKQYbMZ3Ikw6L1Rv1J+
  FvN0aNwOKgL2ztBRYscUGcQvA0Zo1fGCAn/BLEJvQYShWKeKqjyncVGoXFsz2AcuFKe1pwETSsN6
  OZncjy32e4ktgs07cWBfx0v62b8md36jau+B6RVnnodaA8++oXl3FRwiEW8XfXWIjy4umIv93tb8
  8ekYsfOfWkTSewZYXGoqe4RtK80ulMHb/dh2FZQIFyRdN4HOmB4FYO5sEYFr9YjHLmDkrUgNodJC
  XCeMe4BO4iaxUQARAQABzRdtYXJrdXMucHJvYnN0QHBvc3Rlby5kZcLBkQQTAQgAOxYhBIJ0GMT0
  rFjncjDEczR2H/jnrUPSBQJog714AhsDBQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJEDR2
  H/jnrUPSgdkQAISaTk2D345ehXEkn5z2yUEjaVjHIE7ziqRaOgn/QanCgeTUinIv6L6QXUFvvIfH
  1OLPwQ1hfvEg9NnNLyFezWSy6jvoVBTIPqicD/r3FkithnQ1IDkdSjrarPMxJkvuh3l7XZHo49GV
  HQ8i5zh5w4YISrcEtE99lJisvni2Jqx7we5tey9voQFDyM8jxlSWv3pmoUTCtBkX/eKHJXosgsuS
  B4TGDCVPOjla/emI5c9MhMG7O4WEEmoSdPbmraPw66YZD6uLyhV4DPHbiDWRzXWnClHSyjB9rky9
  lausFxogvu4l9H+KDsXIadNDWdLdu1/enS/wDd9zh5S78rY2jeXaG4mnf4seEKamZ7KQ6FIHrcyP
  ezdDzssPQcTQcGRMQzCn6wP3tlGk7rsfmyHMlFqdRoNNv+ZER/OkmZFPW655zRfbMi0vtrqK2Awm
  9ggobb1oktfd9PPNXMUY+DNVlgR2G7jLnenSoQausLUm0pHoNE8TWFv851Y6SOYnvn488sP1Tki5
  F3rKwclawQFHUXTCQw+QSh9ay8xgnNZfH+u9NY7w3gPoeKBOAFcBc2BtzcgekeWS8qgEmm2/oNFV
  G0ivPQbRx8FjRKbuF7g3YhgNZZ0ac8FneuUtJ2PkSIFTZhaAiC0utvxk0ndmWFiW4acEkMZGrLaM
  L2zWNjrqwsD2zsFNBGiDvXgBEADCXQy1n7wjRxG12DOVADawjghKcG+5LtEf31WftHKLFbp/HArj
  BhkT6mj+CCI1ClqY+FYU5CK/s0ScMfLxRGLZ0Ktzawb78vOgBVFT3yB1yWBTewsAXdqNqRooaUNo
  8cG/NNJLjhccH/7PO/FWX5qftOVUJ/AIsAhKQJ18Tc8Ik73v427EDxuKb9mTAnYQFA3Ev3hAiVbO
  6Rv39amVOfJ8sqwiSUGidj2Fctg2aB5JbeMln0KCUbTD1LhEFepeKypfofAXQbGwaCjAhmkWy/q3
  IT1mUrPxOngbxdRoOx1tGUC0HCMUW1sFaJgQPMmDcR0JGPOpgsKnitsSnN7ShcCr1buel7vLnUMD
  +TAZ5opdoF6HjAvAnBQaijtK6minkrM0seNXnCg0KkV8xhMNa6zCs1rq4GgjNLJue2EmuyHooHA4
  7JMoLVHcxVeuNTp6K2+XRx0Pk4e2Lj8IVy9yEYyrywEOC5XRW37KJjsiOAsumi1rkvM7QREWgUDe
  Xs0+RpxI3QrrANh71fLMRo7LKRF3Gvw13NVCCC9ea20P4PwhgWKStkwO2NO+YJsAoS1QycMi/vKu
  0EHhknYXamaSV50oZzHKmX56vEeJHTcngrM8R1SwJCYopCx9gkz90bTVYlitJa5hloWTYeMD7FNj
  Y6jfVSzgM/K4gMgUNDW/PPGeMwARAQABwsF2BBgBCAAgFiEEgnQYxPSsWOdyMMRzNHYf+OetQ9IF
  AmiDvXgCGwwACgkQNHYf+OetQ9LHDBAAhk+ab8+WrbS/b1/gYW3q1KDiXU719nCtfkUVXKidW5Ec
  Idlr5HGt8ilLoxSWT2Zi368iHCXS0WenGgPwlv8ifvB7TOZiiTDZROZkXjEBmU4nYjJ7GymawpWv
  oQwjMsPuq6ysbzWtOZ7eILx7cI0FjQeJ/Q2baRJub0uAZNwBOxCkAS6lpk5Fntd2u8CWmDQo4SYp
  xeuQ+pwkp0yEP30RhN2BO2DXiBEGSZSYh+ioGbCHQPIV3iVj0h6lcCPOqopZqyeCfigeacBI0nvN
  jHWz/spzF3+4OS+3RJvoHtAQmProxyGib8iVsTxgZO3UUi4TSODeEt0i0kHSPY4sCciOyXfAyYoD
  DFqhRjOEwBBxhr+scU4C1T2AflozvDwq3VSONjrKJUkhd8+WsdXxMdPFgBQuiKKwUy11mz6KQfcR
  wmDehF3UaUoxa+YIhWPbKmycxuX/D8SvnqavzAeAL1OcRbEI/HsoroVlEFbBRNBZLJUlnTPs8ZcU
  4+8rq5YX1GUrJL3jf6SAfSgO7UdkEET3PdcKFYtS+ruV1Cp5V0q4kCfI5jk25iiz8grM2wOzVSsc
  l1mEkhiEPH87HP0whhb544iioSnumd3HJKL7dzhRegsMizatupp8D65A2JziW0WKopa1iw9fti3A
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Implement the `AsBusDevice` trait for converting a `Device` reference to a
bus device reference for all bus devices.

The `AsBusDevice` trait allows abstractions to provide the bus device in
class device callbacks. It must not be used by drivers and is intended for
bus and class device abstractions only.

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 rust/kernel/auxiliary.rs |  7 +++++++
 rust/kernel/device.rs    | 30 ++++++++++++++++++++++++++++++
 rust/kernel/pci.rs       |  7 +++++++
 rust/kernel/platform.rs  |  7 +++++++
 rust/kernel/usb.rs       |  6 ++++++
 5 files changed, 57 insertions(+)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index e11848bbf206..cd1121191137 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -15,6 +15,7 @@
 };
 use core::{
     marker::PhantomData,
+    mem::offset_of,
     ptr::{addr_of_mut, NonNull},
 };
 
@@ -239,6 +240,12 @@ extern "C" fn release(dev: *mut bindings::device) {
     }
 }
 
+// SAFETY: `auxilary::Device` is a transparent wrapper of `struct auxiliary_device`.
+// The offset is guaranteed to point to a valid device field inside `auxilary::Device`.
+unsafe impl<Ctx: device::DeviceContext> device::AsBusDevice<Ctx> for Device<Ctx> {
+    const OFFSET: usize = offset_of!(bindings::auxiliary_device, dev);
+}
+
 // SAFETY: `Device` is a transparent wrapper of a type that doesn't depend on `Device`'s generic
 // argument.
 kernel::impl_device_context_deref!(unsafe { Device });
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 1321e6f0b53c..d7024c2bb90f 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -511,6 +511,36 @@ impl DeviceContext for Core {}
 impl DeviceContext for CoreInternal {}
 impl DeviceContext for Normal {}
 
+/// Bus devices can implement this trait to allow abstractions to provide the bus device in
+/// class device callbacks.
+///
+/// This must not be used by drivers and is intended for bus and class device abstractions only.
+///
+/// # Safety
+///
+/// `AsBusDevice::OFFSET` must be a offset to a device field in the implemented struct.
+pub(crate) unsafe trait AsBusDevice<Ctx: DeviceContext>: AsRef<Device<Ctx>> {
+    /// The relative offset to the device field.
+    ///
+    /// Use `offset_of!(bindings, field)` macro to avoid breakage.
+    const OFFSET: usize;
+
+    /// Convert a reference to [`Device`] into `Self`.
+    ///
+    /// # Safety
+    ///
+    /// `dev` must be contained in `Self`.
+    unsafe fn from_device(dev: &Device<Ctx>) -> &Self
+    where
+        Self: Sized,
+    {
+        let raw = dev.as_raw();
+        // SAFETY: `raw - Self::OFFSET` is guaranteed by the safety requirements
+        // to be a valid pointer to `Self`.
+        unsafe { &*raw.byte_sub(Self::OFFSET).cast::<Self>() }
+    }
+}
+
 /// # Safety
 ///
 /// The type given as `$device` must be a transparent wrapper of a type that doesn't depend on the
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 7fcc5f6022c1..d78f6feeaae9 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -19,6 +19,7 @@
 };
 use core::{
     marker::PhantomData,
+    mem::offset_of,
     ops::Deref,
     ptr::{addr_of_mut, NonNull},
 };
@@ -593,6 +594,12 @@ pub fn set_master(&self) {
     }
 }
 
+// SAFETY: `pci::Device` is a transparent wrapper of `struct pci_dev`.
+// The offset is guaranteed to point to a valid device field inside `pci::Device`.
+unsafe impl<Ctx: device::DeviceContext> device::AsBusDevice<Ctx> for Device<Ctx> {
+    const OFFSET: usize = offset_of!(bindings::pci_dev, dev);
+}
+
 // SAFETY: `Device` is a transparent wrapper of a type that doesn't depend on `Device`'s generic
 // argument.
 kernel::impl_device_context_deref!(unsafe { Device });
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 7205fe3416d3..7197264b5a53 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -19,6 +19,7 @@
 
 use core::{
     marker::PhantomData,
+    mem::offset_of,
     ptr::{addr_of_mut, NonNull},
 };
 
@@ -285,6 +286,12 @@ pub fn io_request_by_name(&self, name: &CStr) -> Option<IoRequest<'_>> {
     }
 }
 
+// SAFETY: `platform::Device` is a transparent wrapper of `struct platform_device`.
+// The offset is guaranteed to point to a valid device field inside `platform::Device`.
+unsafe impl<Ctx: device::DeviceContext> device::AsBusDevice<Ctx> for Device<Ctx> {
+    const OFFSET: usize = offset_of!(bindings::platform_device, dev);
+}
+
 macro_rules! define_irq_accessor_by_index {
     (
         $(#[$meta:meta])* $fn_name:ident,
diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 14ddb711bab3..ec21261baf6a 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -324,6 +324,12 @@ fn as_raw(&self) -> *mut bindings::usb_interface {
     }
 }
 
+// SAFETY: `usb::Interface` is a transparent wrapper of `struct usb_interface`.
+// The offset is guaranteed to point to a valid device field inside `usb::Interface`.
+unsafe impl<Ctx: device::DeviceContext> device::AsBusDevice<Ctx> for Interface<Ctx> {
+    const OFFSET: usize = offset_of!(bindings::usb_interface, dev);
+}
+
 // SAFETY: `Interface` is a transparent wrapper of a type that doesn't depend on
 // `Interface`'s generic argument.
 kernel::impl_device_context_deref!(unsafe { Interface });
-- 
2.51.0


