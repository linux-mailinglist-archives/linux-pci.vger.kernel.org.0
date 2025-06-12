Return-Path: <linux-pci+bounces-29550-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C2AAD7151
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 15:13:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE12E175872
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 13:12:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037ED247DF9;
	Thu, 12 Jun 2025 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DaGf76Ci"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C47244691;
	Thu, 12 Jun 2025 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749733916; cv=none; b=U88M7hQ4Fitl6RrolnfTPKbfF16Zdu2YR9b5TKBSyVZrSrtLYyeQPieY2AzujsJB4ARE+SxGIpVFSBP+0Yd5Ne74iXdc9LiAGujaxK0VETLzB8wUq+L9F0bohA06hdm9rbvZBl0Xw9XlyuaqP11B+DorOrKXzSwuAUgQhC72Dng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749733916; c=relaxed/simple;
	bh=BXkpKmZpMVHv98W9CJXaqaPiDhcl2UYnE2vDmUznyoQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ahwaVj+oVadXB4i/Y87TjM443Nghu2R8NUKyFft2Te8m8pLhLdXwlBG/DeSpAxt+KYAzKu/N1tDvzvPlDO74p0rSAv/aLApZx2fLrcLha8+Rfz6PIdEMY00pv/TaISRC2joZWgJXXEaIeWLpM15E0pWMsRq2YHXDsY/mc85RH1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DaGf76Ci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C63C4CEEA;
	Thu, 12 Jun 2025 13:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749733916;
	bh=BXkpKmZpMVHv98W9CJXaqaPiDhcl2UYnE2vDmUznyoQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DaGf76Cim6AlFDud5GHGa3TuaX3FWe3suNpaVrp/Ki6bH6cl0yHltTRIhKPO6h0Jv
	 NDB1G2bWi5Kp66MoIbu1jk8VraYBQziq7HUP950dDuxkQ0zZAwjLm1b4xnxabeTs5r
	 p/cRLD2hdaKt2Tv6zPjmeo0gg+tuLNcEjKmIWRNM5PRKdsdZFdkj9SD/P01K6yDmjw
	 XmXYswpv0tPm22FbBed037sGqtiPCeIuPwXorWPNXd803P6DS63xLWcdf0uejYHoh5
	 tHuI2LAKMX6K9uB9SwU+OD7nj8/NPVlqWInp8EnM8VxIeHTlBbDm9wWhu8TmevUy4l
	 WJRCAxhafYfYw==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 12 Jun 2025 15:09:43 +0200
Subject: [PATCH v3 1/2] rust: types: add FOREIGN_ALIGN to ForeignOwnable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250612-pointed-to-v3-1-b009006d86a1@kernel.org>
References: <20250612-pointed-to-v3-0-b009006d86a1@kernel.org>
In-Reply-To: <20250612-pointed-to-v3-0-b009006d86a1@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
 Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Tamir Duberstein <tamird@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=19953;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=BXkpKmZpMVHv98W9CJXaqaPiDhcl2UYnE2vDmUznyoQ=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBoStGa3pbJyOJaVAPlewZVD//hAQHEygrqfYq8a
 REKgMcY6DWJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaErRmgAKCRDhuBo+eShj
 dzLKEAC6xbDY9wkOy/Wyrlos9+ttX3BocZrVuKUfeNiaElYpvWicYqXYLe8lS43YFEqnclvuBIn
 9U2Ug998G4UxeAiBE0OZiXSP8Dhl5GXvNqqaOyGIvZyeyqEBE5dbJp5bEEANWh+235McfyMh47W
 hamMQk6ggtGJnksqLVLPrdWnisfvL2l/dyK/FBJ+EV/BdjlXYvVa3TgpyYj8KZVD3zmpYVGs7yC
 z0+JlQ4I6+QU1udZfENvfHp3/scG6KPtLnP1urFTbkFJGI/veN9/eFRCOyTFROL+qjqeMpomwC7
 yGsPiZ1Dsmax0NIqWXtJw+V6nft6kDcrJTxZWTaZF02PTWvTZMg2s9BGIKkfOITzUWGuoVQvybM
 N6bt9hmWj/ROj5xdGNSPncBi/ZEMB2sER96zhaoueUJePkD1Dn9tvtoPH3RJR+ecrIYNlh9jgGR
 l/Y3cOGcicHNXiDO3+Gsx3NcCHmx5anWJ5HC9uzCKmDuQirla2O/pjQHqjHE0J4SzN5UsEoD71Z
 nsztXd6xUc3a+tl8bZWBYw8HqO1sGpwaR6zBj97cFcMlXpTMkSPWJbRPu9EbXX8rOGdo+rLHo5X
 1AD/+Fz0aRt6DI6UrD0aVUF6VCqLx9x41UAjs7T/vkTKU3lYz9PV9NrZMuzg1kkGJDLeq5z3xiU
 cM4NalO/vXRnfUA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7

The current implementation of `ForeignOwnable` is leaking the type of the
opaque pointer to consumers of the API. This allows consumers of the opaque
pointer to rely on the information that can be extracted from the pointer
type.

To prevent this, change the API to the version suggested by Maira
Canal (link below): Remove `ForeignOwnable::PointedTo` in favor of a
constant, which specifies the alignment of the pointers returned by
`into_foreign`.

With this change, `ArcInner` no longer needs `pub` visibility, so change it
to private.

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Suggested-by: Maíra Canal <mcanal@igalia.com>
Link: https://lore.kernel.org/r/20240309235927.168915-3-mcanal@igalia.com
Acked-by: Danilo Krummrich <dakr@kernel.org>
Reviewed-by: Benno Lossin <lossin@kernel.org>
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/alloc/kbox.rs | 41 +++++++++++++++++++++++------------------
 rust/kernel/miscdevice.rs | 10 +++++-----
 rust/kernel/pci.rs        |  2 +-
 rust/kernel/platform.rs   |  2 +-
 rust/kernel/sync/arc.rs   | 24 +++++++++++++-----------
 rust/kernel/types.rs      | 45 ++++++++++++++++++++++-----------------------
 rust/kernel/xarray.rs     |  9 +++++----
 7 files changed, 70 insertions(+), 63 deletions(-)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index c386ff771d50..bffe72f44cb3 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -15,6 +15,7 @@
 use core::ptr::NonNull;
 use core::result::Result;
 
+use crate::ffi::c_void;
 use crate::init::InPlaceInit;
 use crate::types::ForeignOwnable;
 use pin_init::{InPlaceWrite, Init, PinInit, ZeroableOption};
@@ -398,70 +399,74 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
     }
 }
 
-// SAFETY: The `into_foreign` function returns a pointer that is well-aligned.
+// SAFETY: The pointer returned by `into_foreign` comes from a well aligned
+// pointer to `T`.
 unsafe impl<T: 'static, A> ForeignOwnable for Box<T, A>
 where
     A: Allocator,
 {
-    type PointedTo = T;
+    const FOREIGN_ALIGN: usize = core::mem::align_of::<T>();
     type Borrowed<'a> = &'a T;
     type BorrowedMut<'a> = &'a mut T;
 
-    fn into_foreign(self) -> *mut Self::PointedTo {
-        Box::into_raw(self)
+    fn into_foreign(self) -> *mut c_void {
+        Box::into_raw(self).cast()
     }
 
-    unsafe fn from_foreign(ptr: *mut Self::PointedTo) -> Self {
+    unsafe fn from_foreign(ptr: *mut c_void) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        unsafe { Box::from_raw(ptr) }
+        unsafe { Box::from_raw(ptr.cast()) }
     }
 
-    unsafe fn borrow<'a>(ptr: *mut Self::PointedTo) -> &'a T {
+    unsafe fn borrow<'a>(ptr: *mut c_void) -> &'a T {
         // SAFETY: The safety requirements of this method ensure that the object remains alive and
         // immutable for the duration of 'a.
-        unsafe { &*ptr }
+        unsafe { &*ptr.cast() }
     }
 
-    unsafe fn borrow_mut<'a>(ptr: *mut Self::PointedTo) -> &'a mut T {
+    unsafe fn borrow_mut<'a>(ptr: *mut c_void) -> &'a mut T {
+        let ptr = ptr.cast();
         // SAFETY: The safety requirements of this method ensure that the pointer is valid and that
         // nothing else will access the value for the duration of 'a.
         unsafe { &mut *ptr }
     }
 }
 
-// SAFETY: The `into_foreign` function returns a pointer that is well-aligned.
+// SAFETY: The pointer returned by `into_foreign` comes from a well aligned
+// pointer to `T`.
 unsafe impl<T: 'static, A> ForeignOwnable for Pin<Box<T, A>>
 where
     A: Allocator,
 {
-    type PointedTo = T;
+    const FOREIGN_ALIGN: usize = core::mem::align_of::<T>();
     type Borrowed<'a> = Pin<&'a T>;
     type BorrowedMut<'a> = Pin<&'a mut T>;
 
-    fn into_foreign(self) -> *mut Self::PointedTo {
+    fn into_foreign(self) -> *mut c_void {
         // SAFETY: We are still treating the box as pinned.
-        Box::into_raw(unsafe { Pin::into_inner_unchecked(self) })
+        Box::into_raw(unsafe { Pin::into_inner_unchecked(self) }).cast()
     }
 
-    unsafe fn from_foreign(ptr: *mut Self::PointedTo) -> Self {
+    unsafe fn from_foreign(ptr: *mut c_void) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        unsafe { Pin::new_unchecked(Box::from_raw(ptr)) }
+        unsafe { Pin::new_unchecked(Box::from_raw(ptr.cast())) }
     }
 
-    unsafe fn borrow<'a>(ptr: *mut Self::PointedTo) -> Pin<&'a T> {
+    unsafe fn borrow<'a>(ptr: *mut c_void) -> Pin<&'a T> {
         // SAFETY: The safety requirements for this function ensure that the object is still alive,
         // so it is safe to dereference the raw pointer.
         // The safety requirements of `from_foreign` also ensure that the object remains alive for
         // the lifetime of the returned value.
-        let r = unsafe { &*ptr };
+        let r = unsafe { &*ptr.cast() };
 
         // SAFETY: This pointer originates from a `Pin<Box<T>>`.
         unsafe { Pin::new_unchecked(r) }
     }
 
-    unsafe fn borrow_mut<'a>(ptr: *mut Self::PointedTo) -> Pin<&'a mut T> {
+    unsafe fn borrow_mut<'a>(ptr: *mut c_void) -> Pin<&'a mut T> {
+        let ptr = ptr.cast();
         // SAFETY: The safety requirements for this function ensure that the object is still alive,
         // so it is safe to dereference the raw pointer.
         // The safety requirements of `from_foreign` also ensure that the object remains alive for
diff --git a/rust/kernel/miscdevice.rs b/rust/kernel/miscdevice.rs
index f33c13c3ff97..9b46c3f7ac65 100644
--- a/rust/kernel/miscdevice.rs
+++ b/rust/kernel/miscdevice.rs
@@ -217,7 +217,7 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
         // type.
         //
         // SAFETY: The open call of a file can access the private data.
-        unsafe { (*raw_file).private_data = ptr.into_foreign().cast() };
+        unsafe { (*raw_file).private_data = ptr.into_foreign() };
 
         0
     }
@@ -228,7 +228,7 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
     /// must be associated with a `MiscDeviceRegistration<T>`.
     unsafe extern "C" fn release(_inode: *mut bindings::inode, file: *mut bindings::file) -> c_int {
         // SAFETY: The release call of a file owns the private data.
-        let private = unsafe { (*file).private_data }.cast();
+        let private = unsafe { (*file).private_data };
         // SAFETY: The release call of a file owns the private data.
         let ptr = unsafe { <T::Ptr as ForeignOwnable>::from_foreign(private) };
 
@@ -272,7 +272,7 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
     /// `file` must be a valid file that is associated with a `MiscDeviceRegistration<T>`.
     unsafe extern "C" fn ioctl(file: *mut bindings::file, cmd: c_uint, arg: c_ulong) -> c_long {
         // SAFETY: The ioctl call of a file can access the private data.
-        let private = unsafe { (*file).private_data }.cast();
+        let private = unsafe { (*file).private_data };
         // SAFETY: Ioctl calls can borrow the private data of the file.
         let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
 
@@ -297,7 +297,7 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
         arg: c_ulong,
     ) -> c_long {
         // SAFETY: The compat ioctl call of a file can access the private data.
-        let private = unsafe { (*file).private_data }.cast();
+        let private = unsafe { (*file).private_data };
         // SAFETY: Ioctl calls can borrow the private data of the file.
         let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
 
@@ -318,7 +318,7 @@ impl<T: MiscDevice> MiscdeviceVTable<T> {
     /// - `seq_file` must be a valid `struct seq_file` that we can write to.
     unsafe extern "C" fn show_fdinfo(seq_file: *mut bindings::seq_file, file: *mut bindings::file) {
         // SAFETY: The release call of a file owns the private data.
-        let private = unsafe { (*file).private_data }.cast();
+        let private = unsafe { (*file).private_data };
         // SAFETY: Ioctl calls can borrow the private data of the file.
         let device = unsafe { <T::Ptr as ForeignOwnable>::borrow(private) };
         // SAFETY:
diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
index 8435f8132e38..0b4b52804250 100644
--- a/rust/kernel/pci.rs
+++ b/rust/kernel/pci.rs
@@ -89,7 +89,7 @@ extern "C" fn probe_callback(
     extern "C" fn remove_callback(pdev: *mut bindings::pci_dev) {
         // SAFETY: The PCI bus only ever calls the remove callback with a valid pointer to a
         // `struct pci_dev`.
-        let ptr = unsafe { bindings::pci_get_drvdata(pdev) }.cast();
+        let ptr = unsafe { bindings::pci_get_drvdata(pdev) };
 
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `ptr` points to a valid and initialized
diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
index 5b21fa517e55..4e37c5ab014d 100644
--- a/rust/kernel/platform.rs
+++ b/rust/kernel/platform.rs
@@ -79,7 +79,7 @@ extern "C" fn probe_callback(pdev: *mut bindings::platform_device) -> kernel::ff
 
     extern "C" fn remove_callback(pdev: *mut bindings::platform_device) {
         // SAFETY: `pdev` is a valid pointer to a `struct platform_device`.
-        let ptr = unsafe { bindings::platform_get_drvdata(pdev) }.cast();
+        let ptr = unsafe { bindings::platform_get_drvdata(pdev) };
 
         // SAFETY: `remove_callback` is only ever called after a successful call to
         // `probe_callback`, hence it's guaranteed that `ptr` points to a valid and initialized
diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
index c7af0aa48a0a..e7488bf055ef 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -19,6 +19,7 @@
 use crate::{
     alloc::{AllocError, Flags, KBox},
     bindings,
+    ffi::c_void,
     init::InPlaceInit,
     try_init,
     types::{ForeignOwnable, Opaque},
@@ -140,10 +141,9 @@ pub struct Arc<T: ?Sized> {
     _p: PhantomData<ArcInner<T>>,
 }
 
-#[doc(hidden)]
 #[pin_data]
 #[repr(C)]
-pub struct ArcInner<T: ?Sized> {
+struct ArcInner<T: ?Sized> {
     refcount: Opaque<bindings::refcount_t>,
     data: T,
 }
@@ -372,20 +372,22 @@ pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
     }
 }
 
-// SAFETY: The `into_foreign` function returns a pointer that is well-aligned.
+// SAFETY: The pointer returned by `into_foreign` comes from a well aligned
+// pointer to `ArcInner<T>`.
 unsafe impl<T: 'static> ForeignOwnable for Arc<T> {
-    type PointedTo = ArcInner<T>;
+    const FOREIGN_ALIGN: usize = core::mem::align_of::<ArcInner<T>>();
+
     type Borrowed<'a> = ArcBorrow<'a, T>;
     type BorrowedMut<'a> = Self::Borrowed<'a>;
 
-    fn into_foreign(self) -> *mut Self::PointedTo {
-        ManuallyDrop::new(self).ptr.as_ptr()
+    fn into_foreign(self) -> *mut c_void {
+        ManuallyDrop::new(self).ptr.as_ptr().cast()
     }
 
-    unsafe fn from_foreign(ptr: *mut Self::PointedTo) -> Self {
+    unsafe fn from_foreign(ptr: *mut c_void) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        let inner = unsafe { NonNull::new_unchecked(ptr) };
+        let inner = unsafe { NonNull::new_unchecked(ptr.cast::<ArcInner<T>>()) };
 
         // SAFETY: By the safety requirement of this function, we know that `ptr` came from
         // a previous call to `Arc::into_foreign`, which guarantees that `ptr` is valid and
@@ -393,17 +395,17 @@ unsafe fn from_foreign(ptr: *mut Self::PointedTo) -> Self {
         unsafe { Self::from_inner(inner) }
     }
 
-    unsafe fn borrow<'a>(ptr: *mut Self::PointedTo) -> ArcBorrow<'a, T> {
+    unsafe fn borrow<'a>(ptr: *mut c_void) -> ArcBorrow<'a, T> {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        let inner = unsafe { NonNull::new_unchecked(ptr) };
+        let inner = unsafe { NonNull::new_unchecked(ptr.cast::<ArcInner<T>>()) };
 
         // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
         // for the lifetime of the returned value.
         unsafe { ArcBorrow::new(inner) }
     }
 
-    unsafe fn borrow_mut<'a>(ptr: *mut Self::PointedTo) -> ArcBorrow<'a, T> {
+    unsafe fn borrow_mut<'a>(ptr: *mut c_void) -> ArcBorrow<'a, T> {
         // SAFETY: The safety requirements for `borrow_mut` are a superset of the safety
         // requirements for `borrow`.
         unsafe { Self::borrow(ptr) }
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 22985b6f6982..c156808a78d3 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -2,6 +2,7 @@
 
 //! Kernel types.
 
+use crate::ffi::c_void;
 use core::{
     cell::UnsafeCell,
     marker::{PhantomData, PhantomPinned},
@@ -21,15 +22,10 @@
 ///
 /// # Safety
 ///
-/// Implementers must ensure that [`into_foreign`] returns a pointer which meets the alignment
-/// requirements of [`PointedTo`].
-///
-/// [`into_foreign`]: Self::into_foreign
-/// [`PointedTo`]: Self::PointedTo
+/// - Implementations must satisfy the guarantees of [`Self::into_foreign`].
 pub unsafe trait ForeignOwnable: Sized {
-    /// Type used when the value is foreign-owned. In practical terms only defines the alignment of
-    /// the pointer.
-    type PointedTo;
+    /// The alignment of pointers returned by `into_foreign`.
+    const FOREIGN_ALIGN: usize;
 
     /// Type used to immutably borrow a value that is currently foreign-owned.
     type Borrowed<'a>;
@@ -39,18 +35,20 @@ pub unsafe trait ForeignOwnable: Sized {
 
     /// Converts a Rust-owned object to a foreign-owned one.
     ///
+    /// The foreign representation is a pointer to void. Aside from the guarantees listed below,
+    /// there are no other guarantees for this pointer. For example, it might be invalid, dangling
+    /// or pointing to uninitialized memory. Using it in any way except for [`from_foreign`],
+    /// [`try_from_foreign`], [`borrow`], or [`borrow_mut`] can result in undefined behavior.
+    ///
     /// # Guarantees
     ///
-    /// The return value is guaranteed to be well-aligned, but there are no other guarantees for
-    /// this pointer. For example, it might be null, dangling, or point to uninitialized memory.
-    /// Using it in any way except for [`ForeignOwnable::from_foreign`], [`ForeignOwnable::borrow`],
-    /// [`ForeignOwnable::try_from_foreign`] can result in undefined behavior.
+    /// - Minimum alignment of returned pointer is [`Self::FOREIGN_ALIGN`].
     ///
     /// [`from_foreign`]: Self::from_foreign
     /// [`try_from_foreign`]: Self::try_from_foreign
     /// [`borrow`]: Self::borrow
     /// [`borrow_mut`]: Self::borrow_mut
-    fn into_foreign(self) -> *mut Self::PointedTo;
+    fn into_foreign(self) -> *mut c_void;
 
     /// Converts a foreign-owned object back to a Rust-owned one.
     ///
@@ -60,7 +58,7 @@ pub unsafe trait ForeignOwnable: Sized {
     /// must not be passed to `from_foreign` more than once.
     ///
     /// [`into_foreign`]: Self::into_foreign
-    unsafe fn from_foreign(ptr: *mut Self::PointedTo) -> Self;
+    unsafe fn from_foreign(ptr: *mut c_void) -> Self;
 
     /// Tries to convert a foreign-owned object back to a Rust-owned one.
     ///
@@ -72,7 +70,7 @@ pub unsafe trait ForeignOwnable: Sized {
     /// `ptr` must either be null or satisfy the safety requirements for [`from_foreign`].
     ///
     /// [`from_foreign`]: Self::from_foreign
-    unsafe fn try_from_foreign(ptr: *mut Self::PointedTo) -> Option<Self> {
+    unsafe fn try_from_foreign(ptr: *mut c_void) -> Option<Self> {
         if ptr.is_null() {
             None
         } else {
@@ -95,7 +93,7 @@ unsafe fn try_from_foreign(ptr: *mut Self::PointedTo) -> Option<Self> {
     ///
     /// [`into_foreign`]: Self::into_foreign
     /// [`from_foreign`]: Self::from_foreign
-    unsafe fn borrow<'a>(ptr: *mut Self::PointedTo) -> Self::Borrowed<'a>;
+    unsafe fn borrow<'a>(ptr: *mut c_void) -> Self::Borrowed<'a>;
 
     /// Borrows a foreign-owned object mutably.
     ///
@@ -123,23 +121,24 @@ unsafe fn try_from_foreign(ptr: *mut Self::PointedTo) -> Option<Self> {
     /// [`from_foreign`]: Self::from_foreign
     /// [`borrow`]: Self::borrow
     /// [`Arc`]: crate::sync::Arc
-    unsafe fn borrow_mut<'a>(ptr: *mut Self::PointedTo) -> Self::BorrowedMut<'a>;
+    unsafe fn borrow_mut<'a>(ptr: *mut c_void) -> Self::BorrowedMut<'a>;
 }
 
-// SAFETY: The `into_foreign` function returns a pointer that is dangling, but well-aligned.
+// SAFETY: The pointer returned by `into_foreign` comes from a well aligned
+// pointer to `()`.
 unsafe impl ForeignOwnable for () {
-    type PointedTo = ();
+    const FOREIGN_ALIGN: usize = core::mem::align_of::<()>();
     type Borrowed<'a> = ();
     type BorrowedMut<'a> = ();
 
-    fn into_foreign(self) -> *mut Self::PointedTo {
+    fn into_foreign(self) -> *mut c_void {
         core::ptr::NonNull::dangling().as_ptr()
     }
 
-    unsafe fn from_foreign(_: *mut Self::PointedTo) -> Self {}
+    unsafe fn from_foreign(_: *mut c_void) -> Self {}
 
-    unsafe fn borrow<'a>(_: *mut Self::PointedTo) -> Self::Borrowed<'a> {}
-    unsafe fn borrow_mut<'a>(_: *mut Self::PointedTo) -> Self::BorrowedMut<'a> {}
+    unsafe fn borrow<'a>(_: *mut c_void) -> Self::Borrowed<'a> {}
+    unsafe fn borrow_mut<'a>(_: *mut c_void) -> Self::BorrowedMut<'a> {}
 }
 
 /// Runs a cleanup function/closure when dropped.
diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
index 75719e7bb491..a49d6db28845 100644
--- a/rust/kernel/xarray.rs
+++ b/rust/kernel/xarray.rs
@@ -7,9 +7,10 @@
 use crate::{
     alloc, bindings, build_assert,
     error::{Error, Result},
+    ffi::c_void,
     types::{ForeignOwnable, NotThreadSafe, Opaque},
 };
-use core::{iter, marker::PhantomData, mem, pin::Pin, ptr::NonNull};
+use core::{iter, marker::PhantomData, pin::Pin, ptr::NonNull};
 use pin_init::{pin_data, pin_init, pinned_drop, PinInit};
 
 /// An array which efficiently maps sparse integer indices to owned objects.
@@ -101,7 +102,7 @@ pub fn new(kind: AllocKind) -> impl PinInit<Self> {
         })
     }
 
-    fn iter(&self) -> impl Iterator<Item = NonNull<T::PointedTo>> + '_ {
+    fn iter(&self) -> impl Iterator<Item = NonNull<c_void>> + '_ {
         let mut index = 0;
 
         // SAFETY: `self.xa` is always valid by the type invariant.
@@ -179,7 +180,7 @@ fn from(value: StoreError<T>) -> Self {
 impl<'a, T: ForeignOwnable> Guard<'a, T> {
     fn load<F, U>(&self, index: usize, f: F) -> Option<U>
     where
-        F: FnOnce(NonNull<T::PointedTo>) -> U,
+        F: FnOnce(NonNull<c_void>) -> U,
     {
         // SAFETY: `self.xa.xa` is always valid by the type invariant.
         let ptr = unsafe { bindings::xa_load(self.xa.xa.get(), index) };
@@ -230,7 +231,7 @@ pub fn store(
         gfp: alloc::Flags,
     ) -> Result<Option<T>, StoreError<T>> {
         build_assert!(
-            mem::align_of::<T::PointedTo>() >= 4,
+            T::FOREIGN_ALIGN >= 4,
             "pointers stored in XArray must be 4-byte aligned"
         );
         let new = value.into_foreign();

-- 
2.47.2



