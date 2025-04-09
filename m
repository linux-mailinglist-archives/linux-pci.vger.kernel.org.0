Return-Path: <linux-pci+bounces-25580-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0634CA8294C
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 17:06:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 455B61892E9C
	for <lists+linux-pci@lfdr.de>; Wed,  9 Apr 2025 14:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9BD02777FC;
	Wed,  9 Apr 2025 14:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGvoNRIz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C702D27702E;
	Wed,  9 Apr 2025 14:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744210292; cv=none; b=BTRXXzw3Mo3UA8WJOXDrMRM2eiy5mzVwvCvHbPO52PUfwgj64YUKUaQ1Wfl/HoH/a3OPSOMDBYpjbCHrcdGKF+vBSm4jcW9RUaUZXysEmBXq4QTbbmM2uWh++61BWodkbkPesgLxrrnR3kOrLS7VBIPJhJNmK4BazHcBIy0pixc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744210292; c=relaxed/simple;
	bh=QAraSClmc7xPwjtsN9qdACIwGCQfVwxdg6lXrbuDb0c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KrbMQEISn3ZXUWHAz+w3DLYdcOmdi3SosGDDEWxcDmxI7MQZxxKyPq8IbanjsotRR6GqEZcALLQM639SjOtTpy54ueAcnWlnTQgJ1shcLTY5JD5rHZW93D6wP5Fv3jT3TkbPmXvw6iqQ+mNB5s6QaM6z6oSYqdz1j7BKH9nyxxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGvoNRIz; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6eaf1b6ce9aso75505406d6.2;
        Wed, 09 Apr 2025 07:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744210289; x=1744815089; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mX/zVGLacBNtzH1Co9YrakQoJNZpEVypxiF7+Yiskio=;
        b=iGvoNRIzLA22yzh3pnz2Jb1ZN/cElLBRZHKpwCUjlh+LqjvtphXg0zyZQvYzJfa1tE
         LuOq0Bs0SotKw+TMFUpYDICoHq1n8Lv5ZRj7xevzLOR6t7s15uzWEI8LnR0BEodsUpdx
         6EWLXnX+zYyQ1TcwPf61mXLeALkwlrGUTjwkBe/KyanBCjeSzpkTl8JhSVCsIasSYnaY
         WEDhs2U4pOeXW0Zn6mIaAtzM5HxBgAZD3STDuAy/DgeBZC3ObRYuLnmdV/5qxkX5/w1h
         L2zQeS65KwkLwiphEU2hihqwYq+ZLg7eo/LtdXYL0BmchQCwlDQqCSZ5xIBLjTMG/bD4
         UxAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744210289; x=1744815089;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mX/zVGLacBNtzH1Co9YrakQoJNZpEVypxiF7+Yiskio=;
        b=F3Rv4LchS+ui7AmPXrMIf65vyBUYYSSgq54i01LETie/pzRQ1fBdSnjGhDMqMo43sE
         s4fHHJXli3rro6bbp5wK/wlOTlDmKIVSxucj7dIciIq80Ypn7q8tvx/c24Lnxxuu/oUc
         wUVaJhQve1gjo++OrwCXwEoORfttk7m4mH7w9f7SxPqxSZWCn7SSERMKtwnfwo/kVWNU
         XBsEktPfPysYpilC7oOh7Idhbvq8VmtT6Y33RpKirsr7ekfbpSt+enFGPz6F8GKLbWpN
         9Mk72orhNrB9f8QSwEq9RD2mT8e4LqXeTSEbC7Ox+QyJ1e4pp2vzsFdUBavPGsf5ifT2
         x5YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUoOjPpq/lvwCy2YQYzejXUTHEFerT6tWayRKBQHeYDmXHszJ5Ggkr/4YClp8BUe6JUsuzqhM4yRMeS1oQ=@vger.kernel.org, AJvYcCXx+TPkqq81a/S4B2EYjMKQSupamXVelNuSE9iS9wYUgaGD1nbgQNqi2hzXm8ZhGtnmy3slGGZ5vPva@vger.kernel.org
X-Gm-Message-State: AOJu0Ywmkk8NZLEVFTaO6EorGOnjI4MuLEdfa3+VGGsCn1nBrC5XBn3W
	6FxdBLo22udGfvCgzanvt9x3lB3ucgtMcoLQicmPr6gj/pB+rqmu
X-Gm-Gg: ASbGncvIh8/rN0FF23RvC/z6UZMKlMlYaD4W4ivgBbd0nfeayqpOQyGpMidDOHVaOtJ
	XyFL3h2huSguo+We5JduNdF4MWuJwBawURef6ec+jUIE94spmraPSfjxQXcrxjNieVbhJv8jOy6
	4ndSBPiXSnys55iiE8dQnfRsTlCZ6DKIjQjCvwLB/Cq/BCeQe8BXmWha5QJGTYRkcsq5tKI9xlY
	QSSbAuFCVFaHvctebnC6dXhX7+Py1YVh+4m/eY7vQIoZI1f9dl+jldeYMXlTnUEL2KujuZ5g2RB
	BilSshPsnwiLpxybm/GM1gkiW9yY9Q0/IUnQKHtAxmyeRhysxqqkLLpOnkprwYq+BVIihBLfMw9
	T/I0QUkPg8hAb3ssWT/Mn789xKOhtlUwP49FRT0K4eLxFUnSA78WW12M=
X-Google-Smtp-Source: AGHT+IH2vXb0WkovZiy7D9/YH7RRtFDAXGJMU4MkwyF8t1LWoxRX7ev+T3Umg5SjxUjsTmpbsIFvIg==
X-Received: by 2002:a05:6214:19eb:b0:6e6:6599:edf6 with SMTP id 6a1803df08f44-6f0dbc6b8acmr52819376d6.34.1744210289334;
        Wed, 09 Apr 2025 07:51:29 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([2620:10d:c091:600::1:3298])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f0de95fa89sm8229876d6.6.2025.04.09.07.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 07:51:28 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Apr 2025 10:51:21 -0400
Subject: [PATCH v2 4/4] rust: list: remove OFFSET constants
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250409-list-no-offset-v2-4-0bab7e3c9fd8@gmail.com>
References: <20250409-list-no-offset-v2-0-0bab7e3c9fd8@gmail.com>
In-Reply-To: <20250409-list-no-offset-v2-0-0bab7e3c9fd8@gmail.com>
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
index d79bebb363ce..24489996d11b 100644
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
         unsafe impl$(<$($generics)*>)? $crate::list::HasListLinks$(<$id>)? for $self {
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
2.49.0


