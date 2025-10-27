Return-Path: <linux-pci+bounces-39464-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF307C1153D
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 21:11:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 353084FF4DD
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 20:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE754324B07;
	Mon, 27 Oct 2025 20:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="rw3RPwDt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAB4321F5E
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 20:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761595575; cv=none; b=WzuMb8WRViuFP+jvfPVo1HcIdI1YcXB9vSz4bI0CIcFbbVknsJL1uDSXh2XjZshP2SdAb/tkVEZqlXxfW3NXG2mwevSxekRXUzUxMeq0KXPgDNzYSS0Y4vTIX7eoFg+ubT6h5pvtxI6bs4RnmRDh/ldPVq1vAfEH0N6Es9PFyaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761595575; c=relaxed/simple;
	bh=Garq7VO1PdQbR41KtGI+fTjLqRCsro5auWy0YdckOkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LXaB1ObQkLRDKDyhZCG2y4iZULWiBD9aQQBIn6//HqHOz3QI4g90/68zDdwY0ogu64aD3TXHWqmL0vLTWmVOrv9ihW17yHnI4zBxAoOgqMNTF1j2+db6a9ZI0AHO+cL1d4IfN8PysmdElayc+mCTJV1iEqzW8tLU3pU8zgPA+W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=rw3RPwDt; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id AF7ED240027
	for <linux-pci@vger.kernel.org>; Mon, 27 Oct 2025 21:06:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1761595564; bh=qm2cnUKzVLRN3dgzzMumdrxbcUv5Pqw48DSmrrD/IkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Autocrypt:OpenPGP:From;
	b=rw3RPwDt/YxYgLLxXZ2ONVrAStx5KO+CBvD9+W0to1J8a+hxm23dYa922qw0SGodV
	 lyKMxv3UIPmQ5PArWvOyh9v1saLrH5a+czSZD9bCVtoN5PzOsNcSJwhVGGsaVFKoZ+
	 mCgHLCWhOYE5op5WTENznHLGWaNt3ouVz/95ocibAtiLXuOo67VNNgT3mPPUstwVUd
	 bgyKv3yW9ukRc5GZWFOvigM8YJQTmJ735g6F3AteI1DVxb5hdOB3QJA3XIAE3oBHB2
	 JPBS0rJIUnUIitumVipuFsQBEn0MiGWdC8DmZNBJs63kpEAxdKjeezSpEJOjGDNWl+
	 YCaAPtCnzqnkw==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4cwPdj0nD4z9rxK;
	Mon, 27 Oct 2025 21:06:01 +0100 (CET)
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
Subject: [PATCH v7 1/2] rust: Add trait to convert a device reference to a bus device reference
Date: Mon, 27 Oct 2025 20:06:03 +0000
Message-ID: <20251027200547.1038967-2-markus.probst@posteo.de>
In-Reply-To: <20251027200547.1038967-1-markus.probst@posteo.de>
References: <20251027200547.1038967-1-markus.probst@posteo.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5573; i=markus.probst@posteo.de; h=from:subject; bh=Garq7VO1PdQbR41KtGI+fTjLqRCsro5auWy0YdckOkA=; b=owEBbQKS/ZANAwAIATR2H/jnrUPSAcsmYgBo/9B7gUvu7Zhh52kQWYQjztQ4KWXF/nHONfwKs xNpc2Z3Qi+JAjMEAAEIAB0WIQSCdBjE9KxY53IwxHM0dh/4561D0gUCaP/QewAKCRA0dh/4561D 0luND/4tPX7HQmtzU6jLks8vsqblaucYlVLZWnkZpTZbv7qGBd5//essk+V+y3d3M7gu/I/v5LU GXOyDzARcd5Bcl0zAx3uMZPvMf1mOsUQYxQxeMJmcJO8cvw1KObGuowwNHlLHI0U9ddEawkYuhW CRz3koY7rFnh1XdodHyEPR+ziHK925qLZNpVDWYLiMayGiX/PppZVXshbVGiBApvoe59y5Rd9R5 FFqqzwoXfHNpDtHbNQtePB7icdfxWHTu4jNvznMZ9LtNe5zNBymNVQQxdFdstcxeHEb4Rtnk8Mw cWdi1fa2J3SpWISg2/pFJJhhzAgsrIMCu4eobWB3JXkRf6moLJZcx3JZ9it6t/lH/Qx+vgVghUg KTUh4MEPPLwN1epxGsObGizRVZ/M5e+Cqcprp0VMskXV6nefuX5QRoCxIxP+uheGfxQmmMR9KDB zZjRrb7LE4IJidBRXjZo2F4rddebWnfpS816ELbKBst/cWNJysXAQW+DCmvi0yNBeej90kHHMwy Z8UucOJ4JrBUW3OY1gwavEpud1pnaJna3+k+xYfx+do934cO7xum/ggyUoq04YEKnjqunx2Wad9 SEJygnZU55re+Pps77Zw2ntiW5RbUko4HlsFkTwCSd9YYVMTmtCfErEaiq6Kw3Yy83E80d6KoCM Db2oMjDQ3WCDE0A=
 =
X-Developer-Key: i=markus.probst@posteo.de; a=openpgp; fpr=827418C4F4AC58E77230C47334761FF8E7AD43D2
Content-Transfer-Encoding: 8bit
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


