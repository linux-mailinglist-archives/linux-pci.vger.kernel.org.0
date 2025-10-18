Return-Path: <linux-pci+bounces-38633-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D1894BEDC14
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 22:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E9504E7B9B
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 20:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D352D949A;
	Sat, 18 Oct 2025 20:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="gYOQXG41"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463902836A4
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 20:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760821185; cv=none; b=meEP6fCRh2D42lR0ZrVSOzuFMINMalom0VtFCoaLxEpK5DKqdQjaczS6cBhuTz428dsgYpVJlbn1sXxuxyOORAbbU6W2I1GmpqR1H/OQ79IH64N9qoq+aWRDa8A/4kGprSOeJNL6d4mVwNdNKGcKlnckneWcIwqvmQ8hQma6vQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760821185; c=relaxed/simple;
	bh=RCcTbaW5Rz4zsoAlDMcqww/CGBu4BzS0JbMOr6YEZHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hlsI39nvQt5PlrW8lXEYITAbCKN7supxGtVkmZAOEs18hwEUUyN3/qwvAY/RqHuXqrOF5XH77gVQqF6bC1khVHFJY9KuhTbfEtbyqunubYgMx/ej/Zh6vlWfXhV5lPE8fuC3+7BX54FlOF9oTQq2QFrchoppVcYeHV4Otnk+taA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=gYOQXG41; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id D7AEB240104
	for <linux-pci@vger.kernel.org>; Sat, 18 Oct 2025 22:59:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1760821175; bh=tZ+zmJaTSj3qqf88WH9BVovPMXRtbf3v8h9Fl8nwR98=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Autocrypt:OpenPGP:From;
	b=gYOQXG41qFBz1ZqqNEEPwV+2647xcCwuatEmhx0l6/krd4Nc9zaifWywMjS/LZA4y
	 7+7ryMp76bqvzJfo7uEdniVD5s0b1KfDgkU1GctH8DunmZ8TDFQ2My7QbXcwAj743c
	 mGjdgwara1I/GqAO8/jHgt5BIqx3mgHeApkfYR0EmwuMjmrhGMiRjgZ8bsA1XdopJ4
	 CNxntJm8pw4oh1nh2OIJCFBP5tK0WZofWKK4O+2QEoisbuA1YM0/4OIgLbB1zburBG
	 gLnq5gGI3k5ISXqpiDplt3rnIZLMpDdUzBogGTr9qTqLy3q5pW3Xd+aNU8lzyto9DC
	 zqlQgK1OAZT1w==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cpvFc5J87z9rxL;
	Sat, 18 Oct 2025 22:59:32 +0200 (CEST)
From: Markus Probst <markus.probst@posteo.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Danilo Krummrich <dakr@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Igor Korotin <igor.korotin.linux@gmail.com>,
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
	Daniel Almeida <daniel.almeida@collabora.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	kwilczynski@kernel.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-leds@vger.kernel.org,
	Markus Probst <markus.probst@posteo.de>
Subject: [PATCH v5 1/2] rust: Add trait to convert a device reference to a bus device reference
Date: Sat, 18 Oct 2025 20:59:34 +0000
Message-ID: <20251018205912.1528811-2-markus.probst@posteo.de>
In-Reply-To: <20251018205912.1528811-1-markus.probst@posteo.de>
References: <20251018205912.1528811-1-markus.probst@posteo.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5668; i=markus.probst@posteo.de; h=from:subject; bh=RCcTbaW5Rz4zsoAlDMcqww/CGBu4BzS0JbMOr6YEZHw=; b=owEBbQKS/ZANAwAIATR2H/jnrUPSAcsmYgBo8/8fuK+NIKTy0f4Yc+4njfTXvlqhfKC/Krpww brGyFFrrhCJAjMEAAEIAB0WIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaPP/HwAKCRA0dh/4561D 0nYKD/oCwKQL8li5QThDheIv4cXSIQQltV2JhePWcNT5DVILCeB9HGI1fSl4A5am0hdmWJ0k0Ju LSwtLJbgbGNae0CqIK2Cu1ITAdpddLCDVCKvMBx9K4d1zatgJcX9pGSz7zxBtL/9OheEqb/otsN 1sW9H+cnWbIzGFqOMfaUyF+c6TBTIO/Tb/LblhFg1E30r7G87sMOGe7RMtZ86JAb5/bZhIlXLTe HTwRFB7ULDRC9m6v2fi93fH26x+yew0VRFx4FaavlXi/gNL5pbc0bxdIwpepXbnwQCYUe7W9t34 vBV0kj5FkZ0GJY5kaCj7tTuqpJ/KWDIBT4IombkfByMORrSkm6Hi5x7YLeaPlviTInnhR9zv3dc 2IjmnZncC0+nKzogoNVOkhe2sfgu97xIah1p87sSrqjrrLAlXshbl6OIbMogXympu1WA/U6kLIj 0CT7zXb+hNXaPsNoIZ++7xOWB4fnBLnJevV3gncRxfKH1qOm5Np0LkcgZks1CWj+Riu8lH5gpnp tzCYrEuOsN14ZsEsrc85CRoJUrtbcXFhLi8pC/sgHyph+LnZfjwQeRfbuhAwL9oFg0gL0wQBg5t pdpdJnFxaA5ELZH+2LU8JFpNYy5wQhmSiOxv41kc46GFdQze3/OOkc56k7zbOo2vbDdso28L83o WIhmfzkuf/Y/NCA=
 =
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp; fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Content-Transfer-Encoding: 8bit
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
  aBeNN4ijKZchBXHPgVx+YtWRHfcm4l8=
OpenPGP: url=https://posteo.de/keys/markus.probst@posteo.de.asc; preference=encrypt

Implement the `IntoBusDevice` trait for converting a `Device` reference to a
bus device reference for all bus devices. `Device` implements this trait as a
fallback.

The `IntoBusDevice` trait allows abstractions to provide the bus device in
class device callbacks.

Signed-off-by: Markus Probst <markus.probst@posteo.de>
---
 rust/kernel/auxiliary.rs |  7 +++++++
 rust/kernel/device.rs    | 41 ++++++++++++++++++++++++++++++++++++++++
 rust/kernel/i2c.rs       |  7 +++++++
 rust/kernel/pci.rs       |  7 +++++++
 rust/kernel/usb.rs       |  6 ++++++
 5 files changed, 68 insertions(+)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index e11848bbf206..dea24265f549 100644
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
+unsafe impl<Ctx: device::DeviceContext> device::IntoBusDevice<Ctx> for Device<Ctx> {
+    const OFFSET: usize = offset_of!(bindings::auxiliary_device, dev);
+}
+
 // SAFETY: `Device` is a transparent wrapper of a type that doesn't depend on `Device`'s generic
 // argument.
 kernel::impl_device_context_deref!(unsafe { Device });
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index 1321e6f0b53c..5527854a195f 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -511,6 +511,47 @@ impl DeviceContext for Core {}
 impl DeviceContext for CoreInternal {}
 impl DeviceContext for Normal {}
 
+/// Bus devices can implement this trait to allow abstractions to provide the bus device in
+/// class device callbacks.
+///
+/// # Safety
+///
+/// `IntoBusDevice::OFFSET` must be a offset to a device field in the implemented struct.
+pub(crate) unsafe trait IntoBusDevice<Ctx: DeviceContext>:
+    AsRef<Device<Ctx>>
+{
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
+// SAFETY: `Device` is a transparent wrapper of `device`.
+unsafe impl<Ctx: DeviceContext> IntoBusDevice<Ctx> for Device<Ctx> {
+    const OFFSET: usize = 0;
+}
+
+impl<Ctx: DeviceContext> AsRef<Device<Ctx>> for Device<Ctx> {
+    fn as_ref(&self) -> &Device<Ctx> {
+        self
+    }
+}
+
 /// # Safety
 ///
 /// The type given as `$device` must be a transparent wrapper of a type that doesn't depend on the
diff --git a/rust/kernel/i2c.rs b/rust/kernel/i2c.rs
index 7fccffebbd6c..e9a7e09b0116 100644
--- a/rust/kernel/i2c.rs
+++ b/rust/kernel/i2c.rs
@@ -15,6 +15,7 @@
 
 use core::{
     marker::PhantomData,
+    mem::offset_of,
     ptr::{from_ref, NonNull},
 };
 
@@ -465,6 +466,12 @@ fn as_raw(&self) -> *mut bindings::i2c_client {
     }
 }
 
+// SAFETY: `I2cClient` is a transparent wrapper of `struct i2c_client`.
+// The offset is guaranteed to point to a valid device field inside `I2cClient`.
+unsafe impl<Ctx: device::DeviceContext> device::IntoBusDevice<Ctx> for I2cClient<Ctx> {
+    const OFFSET: usize = offset_of!(bindings::i2c_client, dev);
+}
+
 // SAFETY: `I2cClient` is a transparent wrapper of a type that doesn't depend on `I2cClient`'s generic
 // argument.
 kernel::impl_device_context_deref!(unsafe { I2cClient });
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 7fcc5f6022c1..ad00a5c1294a 100644
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
+unsafe impl<Ctx: device::DeviceContext> device::IntoBusDevice<Ctx> for Device<Ctx> {
+    const OFFSET: usize = offset_of!(bindings::pci_dev, dev);
+}
+
 // SAFETY: `Device` is a transparent wrapper of a type that doesn't depend on `Device`'s generic
 // argument.
 kernel::impl_device_context_deref!(unsafe { Device });
diff --git a/rust/kernel/usb.rs b/rust/kernel/usb.rs
index 14ddb711bab3..8862004e54f9 100644
--- a/rust/kernel/usb.rs
+++ b/rust/kernel/usb.rs
@@ -324,6 +324,12 @@ fn as_raw(&self) -> *mut bindings::usb_interface {
     }
 }
 
+// SAFETY: `usb::Interface` is a transparent wrapper of `struct usb_interface`.
+// The offset is guaranteed to point to a valid device field inside `usb::Interface`.
+unsafe impl<Ctx: device::DeviceContext> device::IntoBusDevice<Ctx> for Interface<Ctx> {
+    const OFFSET: usize = offset_of!(bindings::usb_interface, dev);
+}
+
 // SAFETY: `Interface` is a transparent wrapper of a type that doesn't depend on
 // `Interface`'s generic argument.
 kernel::impl_device_context_deref!(unsafe { Interface });
-- 
2.49.1


