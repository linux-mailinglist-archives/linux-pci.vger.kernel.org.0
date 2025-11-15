Return-Path: <linux-pci+bounces-41303-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CD558C6093A
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 18:26:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EEE51354B9A
	for <lists+linux-pci@lfdr.de>; Sat, 15 Nov 2025 17:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A77C0303A17;
	Sat, 15 Nov 2025 17:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="o5FNgKOc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09583019AB
	for <linux-pci@vger.kernel.org>; Sat, 15 Nov 2025 17:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763227564; cv=none; b=CDuNSRPKVrbfhEqJnbz2A6Io+ILsl+10iA8xr+/c33QjzbGlc2IDQvkE3dB/2JB1Z/PcLJu29faOADTwJmvz8IKzMG74rggktaQMfNC1pSUG4/wgB6grEDQyQg7IckMs6pqwsa9e6Ij8H56z4aKYIMUGuZ+4TrW0gImmV+sYUI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763227564; c=relaxed/simple;
	bh=t68H8rXu6XmkMh+iLw+R6lOjuYBvGB8PMDn92zVlKYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WGQREhPrssf0DYA1K164ofow3ZWO1WUNloBKdkJ3ospkBZ/gfFVbNTfrQ17H4QRcqsPHsD/KifaBsJcGVx5nLMnDyu/9qpIlU9Y6oLyqUrXjjeFbeL5yylWni88dovLpXwZ+em0//jKgZMt3GdYG3B7ovoAMxMApNovN6MMV2BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=o5FNgKOc; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id E3142240104
	for <linux-pci@vger.kernel.org>; Sat, 15 Nov 2025 18:26:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1763227560; bh=4QYoNPwoYQKT22elmcFf1tXNwc4vKowEFwTDurGb5Jc=;
	h=From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:Autocrypt:OpenPGP:From;
	b=o5FNgKOcECtgoQLWpgHmyDu9Nv8iUmGRYVPY5qcgKRbptfMnPNN3SQUmbHen5RViH
	 dL3HIbFTDUB935N7XGhnODoVc84skDXJMDcmaOyG7VqGEpOStDmfS1U1y8l4ui9Fsb
	 ap1vTRyvVBuicK4WhWZrNBLBN9WfSfT3cAg/y9v8HuDibO56gscQ7VPD0XCphZKOch
	 kQm5tBsQp6NA1LmsM5CfXoIq3yXOMxbM46MacIhOlkX9dpDInKi7+HFUAHzXCP68X4
	 f2F8G3MbbAg4DGZWgpvoM234x48gMjUD6DC/0zRZkpscxPdge/1dsS6ckZX+xzUUhg
	 FIQwYlyn+DPhQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4d81BF3Y3bz9rxN;
	Sat, 15 Nov 2025 18:25:57 +0100 (CET)
From: Markus Probst <markus.probst@posteo.de>
Date: Sat, 15 Nov 2025 17:25:59 +0000
Subject: [PATCH v8 1/4] rust: Add trait to convert a device reference to a
 bus device reference
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251115-rust_leds-v8-1-d9a41f355538@posteo.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5575;
 i=markus.probst@posteo.de; h=from:subject:message-id;
 bh=t68H8rXu6XmkMh+iLw+R6lOjuYBvGB8PMDn92zVlKYk=;
 b=kA0DAAgBNHYf+OetQ9IByyZiAGkYt6KgKX/PeBpr9apcWnZAiYnycFTjkPh2p6FjafjF1csrr
 okCMwQAAQgAHRYhBIJ0GMT0rFjncjDEczR2H/jnrUPSBQJpGLeiAAoJEDR2H/jnrUPSyQwP/2we
 dxICIPBqDGQomYu6VqQb9I3KtmDWRKlHsAWkzp1avm8yuaY1VuFsNYIvs+ctHKeFXQ+Ab02H9PW
 nvjjCnJ50f+OAi5tkh5EvcM5EFCiQiLakKE3/heCEmcshkzS5QFvix3k+bYWlWDFZxufyjd3VEO
 VE9v+mnpIPbO9/2Ryqg2R5/Sldy4NqsECwsVPpHejOW29I6TPg5zHPohJZdClbxUFZOTpvFWxNA
 WFW48HtSbDg1YGAQGZ49VYE7kN+g7Eyd/nQ+eiyepJ6dK//BAn3ZJfnNDCn7yzuZt/oh+EDBmlI
 CHGPY/4iURwFGuJV4uIyVqt7n09i3G8c1VfUbnli0/hDw7lzTsPuYtUTPCNeXv9insiTm8y8r1s
 MzHW3jmpsBcpRYQRg7YIj/IaIFK6cKJvJD8FGaWju+AbL6BnHUmexD84riOUD8u1mRkbr1ciE7h
 vJbdtoro6J8KzLtSZ3Bffg7JWuDb7UDWNFpEgHU6NThS1a02YyfhQvx0al6KQpihtiq/R7UOFvM
 +inmn2WG8GVgjJWneAZP+QD0nS03V+G5+5Zw92yiQXJAZA6DjZ465xeRsiAv97SpvZiB0wEHZ/n
 eh0mJi8lqq5l12iw8p1GMFiQfhrjdJfz07sjWN178hTrcTUvtDyIVD5Z9EmPqQ2KRjn31SAW4s2
 +O7Ir
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp;
 fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Autocrypt: addr=markus.probst@posteo.de; prefer-encrypt=mutual;
  keydata=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
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
 rust/kernel/device.rs    | 33 +++++++++++++++++++++++++++++++++
 rust/kernel/pci.rs       |  7 +++++++
 rust/kernel/platform.rs  |  7 +++++++
 rust/kernel/usb.rs       |  6 ++++++
 5 files changed, 60 insertions(+)

diff --git a/rust/kernel/auxiliary.rs b/rust/kernel/auxiliary.rs
index 7a3b0b9c418e..db52062a4355 100644
--- a/rust/kernel/auxiliary.rs
+++ b/rust/kernel/auxiliary.rs
@@ -15,6 +15,7 @@
 };
 use core::{
     marker::PhantomData,
+    mem::offset_of,
     ptr::{addr_of_mut, NonNull},
 };
 
@@ -233,6 +234,12 @@ extern "C" fn release(dev: *mut bindings::device) {
     }
 }
 
+// SAFETY: `auxiliary::Device` is a transparent wrapper of `struct auxiliary_device`.
+// The offset is guaranteed to point to a valid device field inside `auxiliary::Device`.
+unsafe impl<Ctx: device::DeviceContext> device::AsBusDevice<Ctx> for Device<Ctx> {
+    const OFFSET: usize = offset_of!(bindings::auxiliary_device, dev);
+}
+
 // SAFETY: `Device` is a transparent wrapper of a type that doesn't depend on `Device`'s generic
 // argument.
 kernel::impl_device_context_deref!(unsafe { Device });
diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
index a849b7dde2fd..bf09fd0b0199 100644
--- a/rust/kernel/device.rs
+++ b/rust/kernel/device.rs
@@ -511,6 +511,39 @@ impl DeviceContext for Core {}
 impl DeviceContext for CoreInternal {}
 impl DeviceContext for Normal {}
 
+/// Convert device references to bus device references.
+///
+/// Bus devices can implement this trait to allow abstractions to provide the bus device in
+/// class device callbacks.
+///
+/// This must not be used by drivers and is intended for bus and class device abstractions only.
+///
+/// # Safety
+///
+/// `AsBusDevice::OFFSET` must be the offset of the embedded base `struct device` field within a
+/// bus device structure.
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


