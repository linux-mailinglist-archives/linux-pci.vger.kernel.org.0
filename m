Return-Path: <linux-pci+bounces-24583-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5338A6E5C5
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 22:37:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96B211898FC7
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 21:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CF41F09AF;
	Mon, 24 Mar 2025 21:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKLY8cA2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57291EF096;
	Mon, 24 Mar 2025 21:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742852046; cv=none; b=KzT8I7eWBCXleSWFb5EV0R7uJYRoInQq8RGdQZ2z3TNeHMhpzEksDdR3PrvidZcmkbMbbRyyoaJVLgFiZCLDa/XaF/3gBAFyu+Yy/X4a34iPtG7jde/KZJtRytkWFu413hdFrOJ8gJ48m2YL7soJXs5k03w5nl3u6mxNy8vpkNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742852046; c=relaxed/simple;
	bh=C1obtIULhiW+CO4ZwbunBr4ZlG7pPqY0H1JxizgfcUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OZh94keSCufpciQ2V4axQN21RfgSHXcEQ5sieCw4iEInYFu2xEwWToZxjSfLp/mklmMBbvf+w4W3fRuAaBg13epUL4ZL9HmUehyQvqpUCJ/X1PfkI1+7G9b0fZwPBKU9b6wZg278sempebEiSWBmyB+S22ehW1qjSJQ9NAbpJBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UKLY8cA2; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7c54c52d8easo642990785a.0;
        Mon, 24 Mar 2025 14:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742852043; x=1743456843; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TC2xz/s8H2Dsg/rSNArWhY5/RoG6DRauQh0fZ8Dj8/k=;
        b=UKLY8cA2BqpCWlDW9U6TfNVmWfjJUNY49q3yIA51AOCYBipqiNoErRTSl3mx1kH+ny
         sJv+oXIHs970VzvPXRSGkvUpJPuPVxQDXafK6IqquDLxYswB1hhDVxHVsQDRSL/q0+G9
         BYNPGUl/46kJ7AuSHsKBuA0fvUYMjhoZch1OsPGF/tM1JIm+YKgWpQHm5IbjeOsr294B
         l/18m8CUffSrKdcTsnAkw1/31i03NqLRBuZhi+vVX7GwMxOvAk4FDj3Q345eEAskS9IZ
         ajoemaLtoHrdPsq8MWh3rBnNRZ662P8h4oSTNaCzpMuuTE24Y9OSM4qZkI7jWKknbbzo
         9JYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742852043; x=1743456843;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TC2xz/s8H2Dsg/rSNArWhY5/RoG6DRauQh0fZ8Dj8/k=;
        b=ZaRyuH9rnsAYfjmqrypdiTw/4VhOThytAsoQlACaeWciZiC8RdLIiIM0p2mAqH6Sn6
         e7OGCSB8gTNvOxwomezShm/AsUnnIwnuYNJ4rTxaRvUjIGvJf5V7y73b4mOZArTSuvHj
         ppbKGfDpCo/sMNnhQRttOp8XQKmc9NuZ3aGx6FgvOH0cwx8DVDufrXF1nEOOK6d//79b
         Cxl5BcWJQXDrOXCrRHoHcdaNVPFjYeOGy324Ut6im0RR0Ff4Rwx8kJyHM+t3cw10bGgp
         d90cr+aL5NycrcNSY/GJTVVTSSbTJOZpKQS8cOoBU1ONK1P+vxW7dtOHragyBYC9rLAb
         cSeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU212EvgQsJ3oEVX3dZ28vdKkAl+0jbwArajoWJGA3DViiIATqbs+G0dcjEL9rimiGbhq431qSkUfI6@vger.kernel.org, AJvYcCXgUDpIgkv4duhdyMnk9z5319K8qts7xXTR/BzDZInA75pIIXdlffhtPsaHX3+6sP05XLLXh0NoRe4Gs1c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwFOu6dnnlaP1nu0i9HRA0C5mjYzdHtWWuJzHqS2bJTcrXoV/aF
	NDEvkG4dBJEC9BIJPNugkFBRRNX9r8Agj0TzqP55cjAej1BIzwop
X-Gm-Gg: ASbGnctW2/dkg1XGSYT71yrsizzCd2Bx35cE900XyzBnCFhfEpuVuplbjMZ49DFFfqm
	3gCVOgEeDCRUE0g+sb+3GDtx7IY0kfJqcOiaZbneVT/7rfT7Yzsod7ln3860kgaLqMsBcsgZpKC
	ubm3qXUyYI9MC2N5VEw8iSa7m8ZIwpdtzQZxv+8j1pHX5Edju7D6cB+Vk1mjj1tIRQyzxY7+NTZ
	JfXfXxKHHv8DFlDBaOazJkmfgOrdUM2CDgiTR/5vQCpqKC6vuzKlVcUkn3TSWD+MyGZODtvl56f
	WOhfMZaueNGU02ZcpkF+uEZZ1HaAjwtN2ySWeD3pm0Qs1CXOMf/3n7bW70z/G6ogaUddbnu2HKl
	0hwxIXBNsOHWDce9DBAq4iXMCZzed86DnaW+0BfMwvIS5k5eqSWptXQ==
X-Google-Smtp-Source: AGHT+IFJ+ZxG3avXosr8A+XuicnrVvTCI/jfhyjrVPYL/SG0M2+rugRoy6ZsmsBkluJRpCpKk0P50Q==
X-Received: by 2002:a05:620a:4806:b0:7c5:b03d:4f4b with SMTP id af79cd13be357-7c5b9add52bmr2341131685a.10.1742852043080;
        Mon, 24 Mar 2025 14:34:03 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:43c7])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5d7eb96fesm63232185a.90.2025.03.24.14.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 14:34:02 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 24 Mar 2025 17:33:47 -0400
Subject: [PATCH 5/5] rust: list: remove OFFSET constants
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250324-list-no-offset-v1-5-afd2b7fc442a@gmail.com>
References: <20250324-list-no-offset-v1-0-afd2b7fc442a@gmail.com>
In-Reply-To: <20250324-list-no-offset-v1-0-afd2b7fc442a@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <benno.lossin@proton.me>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev

Replace `ListLinksSelfPtr::LIST_LINKS_SELF_PTR_OFFSET` with `unsafe fn
raw_get_self_ptr` which returns a pointer to the field rather than
requiring the caller to do pointer arithmetic.

Implement `HasListLinks::raw_get_list_links` in `impl_has_list_links!`,
narrowing the interface of `HasListLinks` and replacing pointer
arithmetic with `container_of!`.

Modify `impl_list_item` to also invoke `impl_has_list_links!` or
`impl_has_list_links_self_ptr!`. This is necessary to allow
`impl_list_item` to see more of the tokens used by
`impl_has_list_links{,_self_ptr}!`.

A similar API change was discussed on the hrtimer series[1].

Link: https://lore.kernel.org/all/20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org/ [1]
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/list.rs                    |  18 +++---
 rust/kernel/list/impl_list_item_mod.rs | 100 +++++++++++++++------------------
 2 files changed, 56 insertions(+), 62 deletions(-)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index a335c3b1ff5e..f370a8c1df98 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -212,9 +212,6 @@ unsafe impl<T: ?Sized + Send, const ID: u64> Send for ListLinksSelfPtr<T, ID> {}
 unsafe impl<T: ?Sized + Sync, const ID: u64> Sync for ListLinksSelfPtr<T, ID> {}
 
 impl<T: ?Sized, const ID: u64> ListLinksSelfPtr<T, ID> {
-    /// The offset from the [`ListLinks`] to the self pointer field.
-    pub const LIST_LINKS_SELF_PTR_OFFSET: usize = core::mem::offset_of!(Self, self_ptr);
-
     /// Creates a new initializer for this type.
     pub fn new() -> impl PinInit<Self> {
         // INVARIANT: Pin-init initializers can't be used on an existing `Arc`, so this value will
@@ -229,6 +226,16 @@ pub fn new() -> impl PinInit<Self> {
             self_ptr: Opaque::uninit(),
         }
     }
+
+    /// Returns a pointer to the self pointer.
+    ///
+    /// # Safety
+    ///
+    /// The provided pointer must point at a valid struct of type `Self`.
+    pub unsafe fn raw_get_self_ptr(me: *mut Self) -> *const Opaque<*const T> {
+        // SAFETY: The caller promises that the pointer is valid.
+        unsafe { ptr::addr_of!((*me).self_ptr) }
+    }
 }
 
 impl<T: ?Sized + ListItem<ID>, const ID: u64> List<T, ID> {
@@ -603,14 +610,11 @@ fn next(&mut self) -> Option<ArcBorrow<'a, T>> {
 ///     }
 /// }
 ///
-/// kernel::list::impl_has_list_links! {
-///     impl HasListLinks<0> for ListItem { self.links }
-/// }
 /// kernel::list::impl_list_arc_safe! {
 ///     impl ListArcSafe<0> for ListItem { untracked; }
 /// }
 /// kernel::list::impl_list_item! {
-///     impl ListItem<0> for ListItem { using ListLinks; }
+///     impl ListItem<0> for ListItem { using ListLinks { self.links }; }
 /// }
 ///
 /// // Use a cursor to remove the first element with the given value.
diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/impl_list_item_mod.rs
index 705b46150b97..4f9100aadbce 100644
--- a/rust/kernel/list/impl_list_item_mod.rs
+++ b/rust/kernel/list/impl_list_item_mod.rs
@@ -6,21 +6,18 @@
 
 use crate::list::ListLinks;
 
-/// Declares that this type has a `ListLinks<ID>` field at a fixed offset.
+/// Declares that this type has a [`ListLinks<ID>`] field.
 ///
-/// This trait is only used to help implement `ListItem` safely. If `ListItem` is implemented
+/// This trait is only used to help implement [`ListItem`] safely. If [`ListItem`] is implemented
 /// manually, then this trait is not needed. Use the [`impl_has_list_links!`] macro to implement
 /// this trait.
 ///
 /// # Safety
 ///
-/// All values of this type must have a `ListLinks<ID>` field at the given offset.
+/// The methods on this trait must have exactly the behavior that the definitions given below have.
 ///
-/// The behavior of `raw_get_list_links` must not be changed.
+/// [`ListItem`]: crate::list::ListItem
 pub unsafe trait HasListLinks<const ID: u64 = 0> {
-    /// The offset of the `ListLinks` field.
-    const OFFSET: usize;
-
     /// Returns a pointer to the [`ListLinks<T, ID>`] field.
     ///
     /// # Safety
@@ -28,14 +25,7 @@ pub unsafe trait HasListLinks<const ID: u64 = 0> {
     /// The provided pointer must point at a valid struct of type `Self`.
     ///
     /// [`ListLinks<T, ID>`]: ListLinks
-    // We don't really need this method, but it's necessary for the implementation of
-    // `impl_has_list_links!` to be correct.
-    #[inline]
-    unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut ListLinks<ID> {
-        // SAFETY: The caller promises that the pointer is valid. The implementer promises that the
-        // `OFFSET` constant is correct.
-        unsafe { (ptr as *mut u8).add(Self::OFFSET) as *mut ListLinks<ID> }
-    }
+    unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut ListLinks<ID>;
 }
 
 /// Implements the [`HasListLinks`] trait for the given type.
@@ -48,14 +38,11 @@ macro_rules! impl_has_list_links {
     )*) => {$(
         // SAFETY: The implementation of `raw_get_list_links` only compiles if the field has the
         // right type.
-        //
-        // The behavior of `raw_get_list_links` is not changed since the `addr_of_mut!` macro is
-        // equivalent to the pointer offset operation in the trait definition.
         unsafe impl$(<$($generics),*>)? $crate::list::HasListLinks$(<$id>)? for $self {
-            const OFFSET: usize = ::core::mem::offset_of!(Self, $($field).*) as usize;
-
             #[inline]
             unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$id>)? {
+                const _: usize = ::core::mem::offset_of!($self, $($field).*);
+
                 // SAFETY: The caller promises that the pointer is not dangling. We know that this
                 // expression doesn't follow any pointers, as the `offset_of!` invocation above
                 // would otherwise not compile.
@@ -66,12 +53,15 @@ unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$
 }
 pub use impl_has_list_links;
 
-/// Declares that the `ListLinks<ID>` field in this struct is inside a `ListLinksSelfPtr<T, ID>`.
+/// Declares that the [`ListLinks<ID>`] field in this struct is inside a
+/// [`ListLinksSelfPtr<T, ID>`].
 ///
 /// # Safety
 ///
-/// The `ListLinks<ID>` field of this struct at the offset `HasListLinks<ID>::OFFSET` must be
-/// inside a `ListLinksSelfPtr<T, ID>`.
+/// The [`ListLinks<ID>`] field of this struct at [`HasListLinks<ID>::raw_get_list_links`] must be
+/// inside a [`ListLinksSelfPtr<T, ID>`].
+///
+/// [`ListLinksSelfPtr<T, ID>`]: crate::list::ListLinksSelfPtr
 pub unsafe trait HasSelfPtr<T: ?Sized, const ID: u64 = 0>
 where
     Self: HasListLinks<ID>,
@@ -91,8 +81,6 @@ macro_rules! impl_has_list_links_self_ptr {
         unsafe impl$(<$($generics)*>)? $crate::list::HasSelfPtr<$item_type $(, $id)?> for $self {}
 
         unsafe impl$(<$($generics)*>)? $crate::list::HasListLinks$(<$id>)? for $self {
-            const OFFSET: usize = ::core::mem::offset_of!(Self, $field) as usize;
-
             #[inline]
             unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$id>)? {
                 // SAFETY: The caller promises that the pointer is not dangling.
@@ -115,9 +103,13 @@ unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$
 macro_rules! impl_list_item {
     (
         $(impl$({$($generics:tt)*})? ListItem<$num:tt> for $self:ty {
-            using ListLinks;
+            using ListLinks { self$(.$field:ident)* };
         })*
     ) => {$(
+        $crate::list::impl_has_list_links! {
+            impl$({$($generics:tt)*})? HasListLinks<$num> for $self { self$(.$field)* }
+        }
+
         // SAFETY: See GUARANTEES comment on each method.
         unsafe impl$(<$($generics)*>)? $crate::list::ListItem<$num> for $self {
             // GUARANTEES:
@@ -133,20 +125,19 @@ unsafe fn view_links(me: *const Self) -> *mut $crate::list::ListLinks<$num> {
             }
 
             // GUARANTEES:
-            // * `me` originates from the most recent call to `prepare_to_insert`, which just added
-            //   `offset` to the pointer passed to `prepare_to_insert`. This method subtracts
-            //   `offset` from `me` so it returns the pointer originally passed to
-            //   `prepare_to_insert`.
+            // * `me` originates from the most recent call to `prepare_to_insert`, which calls
+            //   `raw_get_list_link`, which is implemented using `addr_of_mut!((*self).$field)`.
+            //   This method uses `container_of` to perform the inverse operation, so it returns the
+            //   pointer originally passed to `prepare_to_insert`.
             // * The pointer remains valid until the next call to `post_remove` because the caller
             //   of the most recent call to `prepare_to_insert` promised to retain ownership of the
             //   `ListArc` containing `Self` until the next call to `post_remove`. The value cannot
             //   be destroyed while a `ListArc` reference exists.
             unsafe fn view_value(me: *mut $crate::list::ListLinks<$num>) -> *const Self {
-                let offset = <Self as $crate::list::HasListLinks<$num>>::OFFSET;
                 // SAFETY: `me` originates from the most recent call to `prepare_to_insert`, so it
-                // points at the field at offset `offset` in a value of type `Self`. Thus,
-                // subtracting `offset` from `me` is still in-bounds of the allocation.
-                unsafe { (me as *const u8).sub(offset) as *const Self }
+                // points at the field `$field` in a value of type `Self`. Thus, reversing that
+                // operation is still in-bounds of the allocation.
+                $crate::container_of!(me, Self, $($field)*)
             }
 
             // GUARANTEES:
@@ -163,25 +154,28 @@ unsafe fn prepare_to_insert(me: *const Self) -> *mut $crate::list::ListLinks<$nu
             }
 
             // GUARANTEES:
-            // * `me` originates from the most recent call to `prepare_to_insert`, which just added
-            //   `offset` to the pointer passed to `prepare_to_insert`. This method subtracts
-            //   `offset` from `me` so it returns the pointer originally passed to
-            //   `prepare_to_insert`.
+            // * `me` originates from the most recent call to `prepare_to_insert`, which calls
+            //   `raw_get_list_link`, which is implemented using `addr_of_mut!((*self).$field)`.
+            //   This method uses `container_of` to perform the inverse operation, so it returns the
+            //   pointer originally passed to `prepare_to_insert`.
             unsafe fn post_remove(me: *mut $crate::list::ListLinks<$num>) -> *const Self {
-                let offset = <Self as $crate::list::HasListLinks<$num>>::OFFSET;
                 // SAFETY: `me` originates from the most recent call to `prepare_to_insert`, so it
-                // points at the field at offset `offset` in a value of type `Self`. Thus,
-                // subtracting `offset` from `me` is still in-bounds of the allocation.
-                unsafe { (me as *const u8).sub(offset) as *const Self }
+                // points at the field `$field` in a value of type `Self`. Thus, reversing that
+                // operation is still in-bounds of the allocation.
+                $crate::container_of!(me, Self, $($field)*)
             }
         }
     )*};
 
     (
         $(impl$({$($generics:tt)*})? ListItem<$num:tt> for $self:ty {
-            using ListLinksSelfPtr;
+            using ListLinksSelfPtr { self$(.$field:ident)* };
         })*
     ) => {$(
+        $crate::list::impl_has_list_links_self_ptr! {
+            impl$({$($generics:tt)*})? HasListLinks<$num> for $self { self$(.$field)* }
+        }
+
         // SAFETY: See GUARANTEES comment on each method.
         unsafe impl$(<$($generics)*>)? $crate::list::ListItem<$num> for $self {
             // GUARANTEES:
@@ -196,13 +190,10 @@ unsafe fn prepare_to_insert(me: *const Self) -> *mut $crate::list::ListLinks<$nu
                 // SAFETY: The caller promises that `me` points at a valid value of type `Self`.
                 let links_field = unsafe { <Self as $crate::list::ListItem<$num>>::view_links(me) };
 
-                let spoff = $crate::list::ListLinksSelfPtr::<Self, $num>::LIST_LINKS_SELF_PTR_OFFSET;
-                // Goes via the offset as the field is private.
-                //
-                // SAFETY: The constant is equal to `offset_of!(ListLinksSelfPtr, self_ptr)`, so
-                // the pointer stays in bounds of the allocation.
-                let self_ptr = unsafe { (links_field as *const u8).add(spoff) }
-                    as *const $crate::types::Opaque<*const Self>;
+                // SAFETY: By the same reasoning above, `links_field` is a valid pointer.
+                let self_ptr = unsafe {
+                    $crate::list::ListLinksSelfPtr::<Self, $num>::raw_get_self_ptr(links_field)
+                };
                 let cell_inner = $crate::types::Opaque::raw_get(self_ptr);
 
                 // SAFETY: This value is not accessed in any other places than `prepare_to_insert`,
@@ -241,11 +232,10 @@ unsafe fn view_links(me: *const Self) -> *mut $crate::list::ListLinks<$num> {
             //   `ListArc` containing `Self` until the next call to `post_remove`. The value cannot
             //   be destroyed while a `ListArc` reference exists.
             unsafe fn view_value(links_field: *mut $crate::list::ListLinks<$num>) -> *const Self {
-                let spoff = $crate::list::ListLinksSelfPtr::<Self, $num>::LIST_LINKS_SELF_PTR_OFFSET;
-                // SAFETY: The constant is equal to `offset_of!(ListLinksSelfPtr, self_ptr)`, so
-                // the pointer stays in bounds of the allocation.
-                let self_ptr = unsafe { (links_field as *const u8).add(spoff) }
-                    as *const ::core::cell::UnsafeCell<*const Self>;
+                // SAFETY: By the same reasoning above, `links_field` is a valid pointer.
+                let self_ptr = unsafe {
+                    $crate::list::ListLinksSelfPtr::<Self, $num>::raw_get_self_ptr(links_field)
+                };
                 let cell_inner = ::core::cell::UnsafeCell::raw_get(self_ptr);
                 // SAFETY: This is not a data race, because the only function that writes to this
                 // value is `prepare_to_insert`, but by the safety requirements the

-- 
2.48.1


