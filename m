Return-Path: <linux-pci+bounces-29056-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D759EACF880
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 22:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 938CB16EAA1
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 20:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034A31F8724;
	Thu,  5 Jun 2025 20:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DArGvIau"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E7454769;
	Thu,  5 Jun 2025 20:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749153622; cv=none; b=exY3LVrxMBrMkEajUVQMSt/f4HHCqacibt0wX5Tofo5grLePHu7Z8fCsA8rgAmwndgw92/yCdIegXBz5WQ8pE8/aRoM15HfhCoMEBAUyUItdFQgIb7fRl4oRaRjlokNALHc8f8Yd+UYFs30vOqjY6U586umnjJE4DpqbhcSUjKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749153622; c=relaxed/simple;
	bh=g3kh+SpEkrag2peJw12xtP1kXBWob5ZDP0Jj/nDn5AU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lA8hg8Jrv7oWbJzPw1JyQEQI+q82FpoyPGD+65AyZwGo+egP5/+fHQ3HqVSBdHo93lmaXF48wznuZcWGng4FTv39AxbcqKVfwN84euRxjHFS7yEeKSfnC7LPmE8iYNPprbUDGTrlXTsSLb8Tdz73ywj0n/sRCTy+kQxV8Rayo8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DArGvIau; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2383C4CEE7;
	Thu,  5 Jun 2025 20:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749153622;
	bh=g3kh+SpEkrag2peJw12xtP1kXBWob5ZDP0Jj/nDn5AU=;
	h=From:Date:Subject:To:Cc:From;
	b=DArGvIauaH0LhzQU9ZidspB3N/7bgWwnJGUqcbmJtOW1y1gBuf3eanfWpnKw4MEXf
	 8fgoLym9yqD+dWliHPGNwbPTKlDVhlMg75nc+h82Yk5WeC1NngUUX0BhKW+PIkreiL
	 kmDi0ic2xUWdvH93x6UTGQn3t+bI10dKZQnTIglr0wWJPxaur7kwzG4Cpnq15IF9B5
	 XB5ZyxItHozugNRWuaI0gvATOxkZD1MHSzYZpJBf20ET5o5C4qBdomrGnSI8XYHFu2
	 D6KLP4Jg11W7TXouDtnd77uDOeICZdxMEunj35F8zas5tubEtw2zd44zC+YhPB+m5i
	 BYgJHVmHhpqIg==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 05 Jun 2025 21:55:25 +0200
Subject: [PATCH] rust: types: add FOREIGN_ALIGN to ForeignOwnable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250605-pointed-to-v1-1-ee1e262912cc@kernel.org>
X-B4-Tracking: v=1; b=H4sIACz2QWgC/x3MQQqAIBBA0avIrBNGQYOuEi0kx5qNikoE4t2Tl
 m/xf4dKhanCJjoUerhyihNqEXDeLl4k2U+DRm3QopE5cWzkZUvSqhUdoTIaA8wgFwr8/rP9GOM
 DxEfvIFwAAAA=
X-Change-ID: 20250605-pointed-to-6170ae01520f
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
 linux-pci@vger.kernel.org, =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Andreas Hindborg <a.hindborg@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=19582;
 i=a.hindborg@kernel.org; h=from:subject:message-id;
 bh=g3kh+SpEkrag2peJw12xtP1kXBWob5ZDP0Jj/nDn5AU=;
 b=owEBbQKS/ZANAwAIAeG4Gj55KGN3AcsmYgBoQfY7EaiQVjNpu6WNw4euIykk5879lqRrEeBEG
 Xsc794bkyOJAjMEAAEIAB0WIQQSwflHVr98KhXWwBLhuBo+eShjdwUCaEH2OwAKCRDhuBo+eShj
 d8AYEAC0PMl4gduh9ykTiUva8Wc1IxBM7ECx7Zp7+o4Hpqg7gD4Kzz0sLcr3X9UwwjR5I2kfvu4
 +Pzbd+ULmHNkNJ5ZNdbedqlxqd88fCKRZWEtFYi3GsYgAFcZBVNQdLb51UjqXZSE+YmVlMovbK4
 E/QexZCeLdubcYukFgH7cyE2Z/Il/J8O33KzWbd7m5f+fgi3fN16sVt4XqjpdClphPWBg9ByoFQ
 50Tss2FzBXEpBW6beQ9nnTiku1Xk9jq1inNrgKQS+AveqH6TYP/QxFKE+DuKHR+woD1aXmub/EJ
 oD7JjF9Yz7VhqVLvmoq29lHCpwXY4/z1USbeZ55pKAYMi17VEVg6JDgfqcuWtS7ZmjistNRiF24
 o7Qwl09As2crNTXvvLYdk/+kZ73U6WW/PqtlOQL9ZLbwFm5PxHyTkHh8ezh/RaHflzqH0ThwKlt
 u6I/rqHneGwFhdn+JiN1ARoWp+vgDzMJM1ZABfKce9Zdm3+/ZSyBbIaEo5XLn7WW5KBvKAoS397
 EcTqHsCFPDUjZVPxSejY4xoi1a7tF4r+5eVMLL2gAqvm99Tzpq1yVh3IcFjmznNQR0en+BFsVQ1
 Md6qU96biboEWXme4+sn9X8reb5j3kxf1eP+SOUa1sEuu8wQaI7oBPJ/1A80MI1e+9HahzSJVX7
 72w8klsL2Gi03sA==
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

Suggested-by: Alice Ryhl <aliceryhl@google.com>
Suggested-by: Maíra Canal <mcanal@igalia.com>
Link: https://lore.kernel.org/r/20240309235927.168915-3-mcanal@igalia.com
Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
---
 rust/kernel/alloc/kbox.rs | 40 ++++++++++++++++++++++------------------
 rust/kernel/miscdevice.rs | 10 +++++-----
 rust/kernel/pci.rs        |  2 +-
 rust/kernel/platform.rs   |  2 +-
 rust/kernel/sync/arc.rs   | 23 ++++++++++++-----------
 rust/kernel/types.rs      | 46 +++++++++++++++++++++-------------------------
 rust/kernel/xarray.rs     |  8 ++++----
 7 files changed, 66 insertions(+), 65 deletions(-)

diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
index c386ff771d50..97f45bc4d74f 100644
--- a/rust/kernel/alloc/kbox.rs
+++ b/rust/kernel/alloc/kbox.rs
@@ -398,70 +398,74 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags) -> Result<Self, E>
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
+    fn into_foreign(self) -> *mut crate::ffi::c_void {
+        Box::into_raw(self).cast()
     }
 
-    unsafe fn from_foreign(ptr: *mut Self::PointedTo) -> Self {
+    unsafe fn from_foreign(ptr: *mut crate::ffi::c_void) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        unsafe { Box::from_raw(ptr) }
+        unsafe { Box::from_raw(ptr.cast()) }
     }
 
-    unsafe fn borrow<'a>(ptr: *mut Self::PointedTo) -> &'a T {
+    unsafe fn borrow<'a>(ptr: *mut crate::ffi::c_void) -> &'a T {
         // SAFETY: The safety requirements of this method ensure that the object remains alive and
         // immutable for the duration of 'a.
-        unsafe { &*ptr }
+        unsafe { &*ptr.cast() }
     }
 
-    unsafe fn borrow_mut<'a>(ptr: *mut Self::PointedTo) -> &'a mut T {
+    unsafe fn borrow_mut<'a>(ptr: *mut crate::ffi::c_void) -> &'a mut T {
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
+    fn into_foreign(self) -> *mut crate::ffi::c_void {
         // SAFETY: We are still treating the box as pinned.
-        Box::into_raw(unsafe { Pin::into_inner_unchecked(self) })
+        Box::into_raw(unsafe { Pin::into_inner_unchecked(self) }).cast()
     }
 
-    unsafe fn from_foreign(ptr: *mut Self::PointedTo) -> Self {
+    unsafe fn from_foreign(ptr: *mut crate::ffi::c_void) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        unsafe { Pin::new_unchecked(Box::from_raw(ptr)) }
+        unsafe { Pin::new_unchecked(Box::from_raw(ptr.cast())) }
     }
 
-    unsafe fn borrow<'a>(ptr: *mut Self::PointedTo) -> Pin<&'a T> {
+    unsafe fn borrow<'a>(ptr: *mut crate::ffi::c_void) -> Pin<&'a T> {
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
+    unsafe fn borrow_mut<'a>(ptr: *mut crate::ffi::c_void) -> Pin<&'a mut T> {
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
index c7af0aa48a0a..6603079b05af 100644
--- a/rust/kernel/sync/arc.rs
+++ b/rust/kernel/sync/arc.rs
@@ -140,10 +140,9 @@ pub struct Arc<T: ?Sized> {
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
@@ -372,20 +371,22 @@ pub fn into_unique_or_drop(self) -> Option<Pin<UniqueArc<T>>> {
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
+    fn into_foreign(self) -> *mut crate::ffi::c_void {
+        ManuallyDrop::new(self).ptr.as_ptr().cast()
     }
 
-    unsafe fn from_foreign(ptr: *mut Self::PointedTo) -> Self {
+    unsafe fn from_foreign(ptr: *mut crate::ffi::c_void) -> Self {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        let inner = unsafe { NonNull::new_unchecked(ptr) };
+        let inner = unsafe { NonNull::new_unchecked(ptr.cast::<ArcInner<T>>()) };
 
         // SAFETY: By the safety requirement of this function, we know that `ptr` came from
         // a previous call to `Arc::into_foreign`, which guarantees that `ptr` is valid and
@@ -393,17 +394,17 @@ unsafe fn from_foreign(ptr: *mut Self::PointedTo) -> Self {
         unsafe { Self::from_inner(inner) }
     }
 
-    unsafe fn borrow<'a>(ptr: *mut Self::PointedTo) -> ArcBorrow<'a, T> {
+    unsafe fn borrow<'a>(ptr: *mut crate::ffi::c_void) -> ArcBorrow<'a, T> {
         // SAFETY: The safety requirements of this function ensure that `ptr` comes from a previous
         // call to `Self::into_foreign`.
-        let inner = unsafe { NonNull::new_unchecked(ptr) };
+        let inner = unsafe { NonNull::new_unchecked(ptr.cast::<ArcInner<T>>()) };
 
         // SAFETY: The safety requirements of `from_foreign` ensure that the object remains alive
         // for the lifetime of the returned value.
         unsafe { ArcBorrow::new(inner) }
     }
 
-    unsafe fn borrow_mut<'a>(ptr: *mut Self::PointedTo) -> ArcBorrow<'a, T> {
+    unsafe fn borrow_mut<'a>(ptr: *mut crate::ffi::c_void) -> ArcBorrow<'a, T> {
         // SAFETY: The safety requirements for `borrow_mut` are a superset of the safety
         // requirements for `borrow`.
         unsafe { Self::borrow(ptr) }
diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
index 22985b6f6982..025c619a2195 100644
--- a/rust/kernel/types.rs
+++ b/rust/kernel/types.rs
@@ -21,15 +21,11 @@
 ///
 /// # Safety
 ///
-/// Implementers must ensure that [`into_foreign`] returns a pointer which meets the alignment
-/// requirements of [`PointedTo`].
-///
-/// [`into_foreign`]: Self::into_foreign
-/// [`PointedTo`]: Self::PointedTo
+/// Implementers must ensure that [`Self::into_foreign`] return pointers with alignment that is an
+/// integer multiple of [`Self::FOREIGN_ALIGN`].
 pub unsafe trait ForeignOwnable: Sized {
-    /// Type used when the value is foreign-owned. In practical terms only defines the alignment of
-    /// the pointer.
-    type PointedTo;
+    /// The alignment of pointers returned by `into_foreign`.
+    const FOREIGN_ALIGN: usize;
 
     /// Type used to immutably borrow a value that is currently foreign-owned.
     type Borrowed<'a>;
@@ -39,18 +35,17 @@ pub unsafe trait ForeignOwnable: Sized {
 
     /// Converts a Rust-owned object to a foreign-owned one.
     ///
-    /// # Guarantees
-    ///
-    /// The return value is guaranteed to be well-aligned, but there are no other guarantees for
-    /// this pointer. For example, it might be null, dangling, or point to uninitialized memory.
-    /// Using it in any way except for [`ForeignOwnable::from_foreign`], [`ForeignOwnable::borrow`],
-    /// [`ForeignOwnable::try_from_foreign`] can result in undefined behavior.
+    /// The foreign representation is a pointer to void. The minimum alignment of the returned
+    /// pointer is [`Self::FOREIGN_ALIGN`]. There are no other guarantees for this pointer. For
+    /// example, it might be invalid, dangling or pointing to uninitialized memory. Using it in any
+    /// way except for [`from_foreign`], [`try_from_foreign`], [`borrow`], or [`borrow_mut`] can
+    /// result in undefined behavior.
     ///
     /// [`from_foreign`]: Self::from_foreign
     /// [`try_from_foreign`]: Self::try_from_foreign
     /// [`borrow`]: Self::borrow
     /// [`borrow_mut`]: Self::borrow_mut
-    fn into_foreign(self) -> *mut Self::PointedTo;
+    fn into_foreign(self) -> *mut crate::ffi::c_void;
 
     /// Converts a foreign-owned object back to a Rust-owned one.
     ///
@@ -60,7 +55,7 @@ pub unsafe trait ForeignOwnable: Sized {
     /// must not be passed to `from_foreign` more than once.
     ///
     /// [`into_foreign`]: Self::into_foreign
-    unsafe fn from_foreign(ptr: *mut Self::PointedTo) -> Self;
+    unsafe fn from_foreign(ptr: *mut crate::ffi::c_void) -> Self;
 
     /// Tries to convert a foreign-owned object back to a Rust-owned one.
     ///
@@ -72,7 +67,7 @@ pub unsafe trait ForeignOwnable: Sized {
     /// `ptr` must either be null or satisfy the safety requirements for [`from_foreign`].
     ///
     /// [`from_foreign`]: Self::from_foreign
-    unsafe fn try_from_foreign(ptr: *mut Self::PointedTo) -> Option<Self> {
+    unsafe fn try_from_foreign(ptr: *mut crate::ffi::c_void) -> Option<Self> {
         if ptr.is_null() {
             None
         } else {
@@ -95,7 +90,7 @@ unsafe fn try_from_foreign(ptr: *mut Self::PointedTo) -> Option<Self> {
     ///
     /// [`into_foreign`]: Self::into_foreign
     /// [`from_foreign`]: Self::from_foreign
-    unsafe fn borrow<'a>(ptr: *mut Self::PointedTo) -> Self::Borrowed<'a>;
+    unsafe fn borrow<'a>(ptr: *mut crate::ffi::c_void) -> Self::Borrowed<'a>;
 
     /// Borrows a foreign-owned object mutably.
     ///
@@ -123,23 +118,24 @@ unsafe fn try_from_foreign(ptr: *mut Self::PointedTo) -> Option<Self> {
     /// [`from_foreign`]: Self::from_foreign
     /// [`borrow`]: Self::borrow
     /// [`Arc`]: crate::sync::Arc
-    unsafe fn borrow_mut<'a>(ptr: *mut Self::PointedTo) -> Self::BorrowedMut<'a>;
+    unsafe fn borrow_mut<'a>(ptr: *mut crate::ffi::c_void) -> Self::BorrowedMut<'a>;
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
+    fn into_foreign(self) -> *mut crate::ffi::c_void {
         core::ptr::NonNull::dangling().as_ptr()
     }
 
-    unsafe fn from_foreign(_: *mut Self::PointedTo) -> Self {}
+    unsafe fn from_foreign(_: *mut crate::ffi::c_void) -> Self {}
 
-    unsafe fn borrow<'a>(_: *mut Self::PointedTo) -> Self::Borrowed<'a> {}
-    unsafe fn borrow_mut<'a>(_: *mut Self::PointedTo) -> Self::BorrowedMut<'a> {}
+    unsafe fn borrow<'a>(_: *mut crate::ffi::c_void) -> Self::Borrowed<'a> {}
+    unsafe fn borrow_mut<'a>(_: *mut crate::ffi::c_void) -> Self::BorrowedMut<'a> {}
 }
 
 /// Runs a cleanup function/closure when dropped.
diff --git a/rust/kernel/xarray.rs b/rust/kernel/xarray.rs
index 75719e7bb491..35f4357fc03a 100644
--- a/rust/kernel/xarray.rs
+++ b/rust/kernel/xarray.rs
@@ -9,7 +9,7 @@
     error::{Error, Result},
     types::{ForeignOwnable, NotThreadSafe, Opaque},
 };
-use core::{iter, marker::PhantomData, mem, pin::Pin, ptr::NonNull};
+use core::{iter, marker::PhantomData, pin::Pin, ptr::NonNull};
 use pin_init::{pin_data, pin_init, pinned_drop, PinInit};
 
 /// An array which efficiently maps sparse integer indices to owned objects.
@@ -101,7 +101,7 @@ pub fn new(kind: AllocKind) -> impl PinInit<Self> {
         })
     }
 
-    fn iter(&self) -> impl Iterator<Item = NonNull<T::PointedTo>> + '_ {
+    fn iter(&self) -> impl Iterator<Item = NonNull<crate::ffi::c_void>> + '_ {
         let mut index = 0;
 
         // SAFETY: `self.xa` is always valid by the type invariant.
@@ -179,7 +179,7 @@ fn from(value: StoreError<T>) -> Self {
 impl<'a, T: ForeignOwnable> Guard<'a, T> {
     fn load<F, U>(&self, index: usize, f: F) -> Option<U>
     where
-        F: FnOnce(NonNull<T::PointedTo>) -> U,
+        F: FnOnce(NonNull<crate::ffi::c_void>) -> U,
     {
         // SAFETY: `self.xa.xa` is always valid by the type invariant.
         let ptr = unsafe { bindings::xa_load(self.xa.xa.get(), index) };
@@ -230,7 +230,7 @@ pub fn store(
         gfp: alloc::Flags,
     ) -> Result<Option<T>, StoreError<T>> {
         build_assert!(
-            mem::align_of::<T::PointedTo>() >= 4,
+            T::FOREIGN_ALIGN >= 4,
             "pointers stored in XArray must be 4-byte aligned"
         );
         let new = value.into_foreign();

---
base-commit: ec7714e4947909190ffb3041a03311a975350fe0
change-id: 20250605-pointed-to-6170ae01520f

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>



