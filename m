Return-Path: <linux-pci+bounces-31806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26BB5AFF1E7
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 21:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79FA45A594B
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jul 2025 19:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560EA2571A9;
	Wed,  9 Jul 2025 19:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lum6fhPP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16197248896;
	Wed,  9 Jul 2025 19:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752089486; cv=none; b=Fkm5md/2XUapcpKdC5Uf7weRnzWIpL6MrNckcTKCwY5hetTic1cr6fvCealN6YSxrxAlmK6dewAHruBD/8XAJKDrNEVc0LVVAWZxAJse3f6sFAFWxhs6tANhMpaqxShzRfkwaB9pWbIhv+v3e2oE8hzlfz64B86YGkACUbi+hdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752089486; c=relaxed/simple;
	bh=5c0+Kp0dk2LV9AtGDQqctb3Y3HsxEO6S12AXZrnX7D0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dxXO6aN3JFmjqaymKlR5vqOeRJ21l2yvZK4Dh2MaEW3AnFeio+znBMqCX2QD53cAC7s6qKUjWlCTZBy2AYa9CaYmCKb5qWz+tP5xg9IJmqA5ErdxfuUsM5j1zSLswC8M8kjxSTEmfxgSc1+HKO3pXK8mgXl301E9MQUwmNuZlKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lum6fhPP; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7d0a0bcd3f3so34787385a.1;
        Wed, 09 Jul 2025 12:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752089483; x=1752694283; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lPvvUtMn6FMSojwzOoVnq0sNVnnhaypantewDXL1/Uo=;
        b=lum6fhPP1VLD0cXTJLAZS5UpypbUeNebEQ1GjF0bVixGwkf8Ta+aNV0XL4D0WhzbEW
         1XxlZ+uAMYY0NrCxWUq7bDla1KT87AkdBXonp7ka9JZtxkchccpX5vvKmgqjdV4/DWro
         cBjYgcA9yaw0i6zZ9TGGMHB+99EKmFtCw9K9uR5kdMMTFJokJIKwvZd6XTeNEjc8OWWy
         l/d/qZkeJPFOO0GpKI0AEKrzB/k3nVD/N+tntfutRgqaKnlBgriKo0UPIcDGfoj9voc7
         DMpQGOUwhgpkAfyPmdT90QRZuT2u4o9tU+Ml6kbdxI0D3RA+TwE535R+pIY9mWXdHXXC
         KXsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752089483; x=1752694283;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lPvvUtMn6FMSojwzOoVnq0sNVnnhaypantewDXL1/Uo=;
        b=AlBtqVHdukJhc35QzHy4rRpbscb0IMgnPdBzpG/u7bWWmIIYWD48+w1n+/cx89+bHO
         4bEvxfkDRwj/0HAJ38a2cSxrKwrfeZZw0HCYTpQcwMDTzIvqXgfTRT6c1cC1gIvcxLX+
         nVxLwMeZlFHjWC9rtZ0BiFTgTVPx34XIVxClkBmh+rX8sYPoi40iotusibqkxH5ye1tq
         wsovljhX8wWriAHvmOSrawXBCJcYzKFX+A2zYOyS8o1ZvtYhwg0/2KBcI+TbWxq7RipV
         Lrtg17OVK7KmydOfQOfAsagIso9Trs1odTV8nsdldTxe519OwTLNsnJ+ts2CtuSF6OuF
         w5tQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG08YJrvVlVFyJ1GyNyq8tVWa2LDIYVKTP359jbr6Vn706MOHxkofv8vxo8/3NQJAFUxTqIkcDmtPZSD8=@vger.kernel.org, AJvYcCXc3p16UH4BtaKIz0T0nUQoFJfCSq1bDCAppz+3zP5uHCY93TTS4IVUVoLAI6tA/aXAGP+AJ9UpaSaU@vger.kernel.org
X-Gm-Message-State: AOJu0YxsNtXyf6/tJfr6JZlzCukm84PO2FNn99eYBs5hZZqPJYwr9Rjr
	Uj9vZkDnZGEXMYE06nG9kzGPB4UPe300JkDj1qVqJK3Oo5v50GIMrPtg
X-Gm-Gg: ASbGnctV0xJ2QIEExhC+6tKNXO8speeg2SSDNPrvp7pa5x63rkDY39eVES2kPsJky1t
	AO2QDwXUXMYCZXUEt6zaT6bWQi11dRHQeK6sIkaSYYZvBzdFlMxqXmT0R+SbOuCqP14/S3mcSxz
	JcDOwQ8mGHTbT55n0V3HqUEx56xp9yWel19hRtynn0iKfx3XXJI+fwo1UMmoT1sLxTprpOKxHtM
	6ivIyCZGm7Wf7Tba8bd12Yzodr3HPcknkkwd5tYE0TjakpTTiVTlKIV9dLPgf3vJp+MmiiSNGNq
	DgsOF16oBIQJwOAaQo9B7qaLHYq4LuCYAyQI5eDp6i6edqN3haYjhv+N5i1wWNhlvscJNUV8z1b
	QYhARGeCorw7GXkJgDD76QPCN2udJKSyfGS0gAsLIpne8kiIlv/QavyBANw==
X-Google-Smtp-Source: AGHT+IGuRaNDw30blY6z1T2xdHvb4jUkDGnjxBAjU3HaQ0bg5z/+uWL+1mHHJ2BvPgtOf6L2GtD7hQ==
X-Received: by 2002:a05:620a:2a07:b0:7ce:b799:8eaf with SMTP id af79cd13be357-7dc990fb7ccmr120568785a.3.1752089482675;
        Wed, 09 Jul 2025 12:31:22 -0700 (PDT)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([148.76.185.197])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d5dbd94242sm991741285a.9.2025.07.09.12.31.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 12:31:22 -0700 (PDT)
From: Tamir Duberstein <tamird@gmail.com>
Date: Wed, 09 Jul 2025 15:31:16 -0400
Subject: [PATCH v4 6/6] rust: list: remove OFFSET constants
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-list-no-offset-v4-6-a429e75840a9@gmail.com>
References: <20250709-list-no-offset-v4-0-a429e75840a9@gmail.com>
In-Reply-To: <20250709-list-no-offset-v4-0-a429e75840a9@gmail.com>
To: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, Tamir Duberstein <tamird@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openssh-sha256; t=1752089474; l=18659;
 i=tamird@gmail.com; h=from:subject:message-id;
 bh=5c0+Kp0dk2LV9AtGDQqctb3Y3HsxEO6S12AXZrnX7D0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgtYz36g7iDMSkY5K7Ab51ksGX7hJgs
 MRt+XVZTrIzMVIAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QK7RD2dEgJ+ubwbB/JeabE5GZ9ejahfntwf94x7Vhx+MdhnsicjZDzJI/YbPxd/fgDNktlV3+Pk
 nhzC8KXUaoQw=
X-Developer-Key: i=tamird@gmail.com; a=openssh;
 fpr=SHA256:264rPmnnrb+ERkS7DDS3tuwqcJss/zevJRzoylqMsbc

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
Tested-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Signed-off-by: Tamir Duberstein <tamird@gmail.com>
---
 rust/kernel/list.rs                    |  23 +++---
 rust/kernel/list/impl_list_item_mod.rs | 143 +++++++++++++++------------------
 2 files changed, 79 insertions(+), 87 deletions(-)

diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
index fe58a3920e70..d976b31d1639 100644
--- a/rust/kernel/list.rs
+++ b/rust/kernel/list.rs
@@ -57,14 +57,11 @@
 ///     }
 /// }
 ///
-/// impl_has_list_links! {
-///     impl HasListLinks<0> for BasicItem { self.links }
-/// }
 /// impl_list_arc_safe! {
 ///     impl ListArcSafe<0> for BasicItem { untracked; }
 /// }
 /// impl_list_item! {
-///     impl ListItem<0> for BasicItem { using ListLinks; }
+///     impl ListItem<0> for BasicItem { using ListLinks { self.links }; }
 /// }
 ///
 /// // Create a new empty list.
@@ -320,9 +317,6 @@ unsafe impl<T: ?Sized + Send, const ID: u64> Send for ListLinksSelfPtr<T, ID> {}
 unsafe impl<T: ?Sized + Sync, const ID: u64> Sync for ListLinksSelfPtr<T, ID> {}
 
 impl<T: ?Sized, const ID: u64> ListLinksSelfPtr<T, ID> {
-    /// The offset from the [`ListLinks`] to the self pointer field.
-    pub const LIST_LINKS_SELF_PTR_OFFSET: usize = core::mem::offset_of!(Self, self_ptr);
-
     /// Creates a new initializer for this type.
     pub fn new() -> impl PinInit<Self> {
         // INVARIANT: Pin-init initializers can't be used on an existing `Arc`, so this value will
@@ -337,6 +331,16 @@ pub fn new() -> impl PinInit<Self> {
             self_ptr: Opaque::uninit(),
         }
     }
+
+    /// Returns a pointer to the self pointer.
+    ///
+    /// # Safety
+    ///
+    /// The provided pointer must point at a valid struct of type `Self`.
+    pub unsafe fn raw_get_self_ptr(me: *const Self) -> *const Opaque<*const T> {
+        // SAFETY: The caller promises that the pointer is valid.
+        unsafe { ptr::addr_of!((*me).self_ptr) }
+    }
 }
 
 impl<T: ?Sized + ListItem<ID>, const ID: u64> List<T, ID> {
@@ -711,14 +715,11 @@ fn next(&mut self) -> Option<ArcBorrow<'a, T>> {
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
index 6b67c0ecc57b..289101e0ab5e 100644
--- a/rust/kernel/list/impl_list_item_mod.rs
+++ b/rust/kernel/list/impl_list_item_mod.rs
@@ -4,21 +4,18 @@
 
 //! Helpers for implementing list traits safely.
 
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
@@ -26,14 +23,7 @@ pub unsafe trait HasListLinks<const ID: u64 = 0> {
     /// The provided pointer must point at a valid struct of type `Self`.
     ///
     /// [`ListLinks<T, ID>`]: crate::list::ListLinks
-    // We don't really need this method, but it's necessary for the implementation of
-    // `impl_has_list_links!` to be correct.
-    #[inline]
-    unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut crate::list::ListLinks<ID> {
-        // SAFETY: The caller promises that the pointer is valid. The implementer promises that the
-        // `OFFSET` constant is correct.
-        unsafe { ptr.cast::<u8>().add(Self::OFFSET).cast() }
-    }
+    unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut crate::list::ListLinks<ID>;
 }
 
 /// Implements the [`HasListLinks`] trait for the given type.
@@ -46,14 +36,15 @@ macro_rules! impl_has_list_links {
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
+                // Statically ensure that `$(.field)*` doesn't follow any pointers.
+                //
+                // Cannot be `const` because `$self` may contain generics and E0401 says constants
+                // "can't use {`Self`,generic parameters} from outer item".
+                if false { let _: usize = ::core::mem::offset_of!(Self, $($field).*); }
+
                 // SAFETY: The caller promises that the pointer is not dangling. We know that this
                 // expression doesn't follow any pointers, as the `offset_of!` invocation above
                 // would otherwise not compile.
@@ -64,12 +55,15 @@ unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$
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
@@ -89,8 +83,6 @@ macro_rules! impl_has_list_links_self_ptr {
         unsafe impl$(<$($generics)*>)? $crate::list::HasSelfPtr<$item_type $(, $id)?> for $self {}
 
         unsafe impl$(<$($generics)*>)? $crate::list::HasListLinks$(<$id>)? for $self {
-            const OFFSET: usize = ::core::mem::offset_of!(Self, $($field).*) as usize;
-
             #[inline]
             unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$id>)? {
                 // SAFETY: The caller promises that the pointer is not dangling.
@@ -120,16 +112,12 @@ unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$
 ///     links: kernel::list::ListLinks,
 /// }
 ///
-/// kernel::list::impl_has_list_links! {
-///     impl HasListLinks<0> for SimpleListItem { self.links }
-/// }
-///
 /// kernel::list::impl_list_arc_safe! {
 ///     impl ListArcSafe<0> for SimpleListItem { untracked; }
 /// }
 ///
 /// kernel::list::impl_list_item! {
-///     impl ListItem<0> for SimpleListItem { using ListLinks; }
+///     impl ListItem<0> for SimpleListItem { using ListLinks { self.links }; }
 /// }
 ///
 /// struct ListLinksHolder {
@@ -143,16 +131,12 @@ unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$
 ///     links: ListLinksHolder,
 /// }
 ///
-/// kernel::list::impl_has_list_links! {
-///     impl{T, U} HasListLinks<0> for ComplexListItem<T, U> { self.links.inner }
-/// }
-///
 /// kernel::list::impl_list_arc_safe! {
 ///     impl{T, U} ListArcSafe<0> for ComplexListItem<T, U> { untracked; }
 /// }
 ///
 /// kernel::list::impl_list_item! {
-///     impl{T, U} ListItem<0> for ComplexListItem<T, U> { using ListLinks; }
+///     impl{T, U} ListItem<0> for ComplexListItem<T, U> { using ListLinks { self.links.inner }; }
 /// }
 /// ```
 ///
@@ -168,12 +152,8 @@ unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$
 ///     impl ListArcSafe<0> for SimpleListItem { untracked; }
 /// }
 ///
-/// kernel::list::impl_has_list_links_self_ptr! {
-///     impl HasSelfPtr<SimpleListItem> for SimpleListItem { self.links }
-/// }
-///
 /// kernel::list::impl_list_item! {
-///     impl ListItem<0> for SimpleListItem { using ListLinksSelfPtr; }
+///     impl ListItem<0> for SimpleListItem { using ListLinksSelfPtr { self.links }; }
 /// }
 ///
 /// struct ListLinksSelfPtrHolder<T, U> {
@@ -191,21 +171,23 @@ unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$
 ///     impl{T, U} ListArcSafe<0> for ComplexListItem<T, U> { untracked; }
 /// }
 ///
-/// kernel::list::impl_has_list_links_self_ptr! {
-///     impl{T, U} HasSelfPtr<ComplexListItem<T, U>> for ComplexListItem<T, U> { self.links.inner }
-/// }
-///
 /// kernel::list::impl_list_item! {
-///     impl{T, U} ListItem<0> for ComplexListItem<T, U> { using ListLinksSelfPtr; }
+///     impl{T, U} ListItem<0> for ComplexListItem<T, U> {
+///         using ListLinksSelfPtr { self.links.inner };
+///     }
 /// }
 /// ```
 #[macro_export]
 macro_rules! impl_list_item {
     (
         $(impl$({$($generics:tt)*})? ListItem<$num:tt> for $self:ty {
-            using ListLinks;
+            using ListLinks { self$(.$field:ident)* };
         })*
     ) => {$(
+        $crate::list::impl_has_list_links! {
+            impl$({$($generics)*})? HasListLinks<$num> for $self { self$(.$field)* }
+        }
+
         // SAFETY: See GUARANTEES comment on each method.
         unsafe impl$(<$($generics)*>)? $crate::list::ListItem<$num> for $self {
             // GUARANTEES:
@@ -221,20 +203,19 @@ unsafe fn view_links(me: *const Self) -> *mut $crate::list::ListLinks<$num> {
             }
 
             // GUARANTEES:
-            // * `me` originates from the most recent call to `prepare_to_insert`, which just added
-            //   `offset` to the pointer passed to `prepare_to_insert`. This method subtracts
-            //   `offset` from `me` so it returns the pointer originally passed to
-            //   `prepare_to_insert`.
+            // * `me` originates from the most recent call to `prepare_to_insert`, which calls
+            //   `raw_get_list_link`, which is implemented using `addr_of_mut!((*self)$(.$field)*)`.
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
+                $crate::container_of!(me, Self, $($field).*)
             }
 
             // GUARANTEES:
@@ -251,25 +232,28 @@ unsafe fn prepare_to_insert(me: *const Self) -> *mut $crate::list::ListLinks<$nu
             }
 
             // GUARANTEES:
-            // * `me` originates from the most recent call to `prepare_to_insert`, which just added
-            //   `offset` to the pointer passed to `prepare_to_insert`. This method subtracts
-            //   `offset` from `me` so it returns the pointer originally passed to
-            //   `prepare_to_insert`.
+            // * `me` originates from the most recent call to `prepare_to_insert`, which calls
+            //   `raw_get_list_link`, which is implemented using `addr_of_mut!((*self)$(.$field)*)`.
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
+                $crate::container_of!(me, Self, $($field).*)
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
+            impl$({$($generics)*})? HasSelfPtr<$self> for $self { self$(.$field)* }
+        }
+
         // SAFETY: See GUARANTEES comment on each method.
         unsafe impl$(<$($generics)*>)? $crate::list::ListItem<$num> for $self {
             // GUARANTEES:
@@ -284,13 +268,15 @@ unsafe fn prepare_to_insert(me: *const Self) -> *mut $crate::list::ListLinks<$nu
                 // SAFETY: The caller promises that `me` points at a valid value of type `Self`.
                 let links_field = unsafe { <Self as $crate::list::ListItem<$num>>::view_links(me) };
 
-                let spoff = $crate::list::ListLinksSelfPtr::<Self, $num>::LIST_LINKS_SELF_PTR_OFFSET;
-                // Goes via the offset as the field is private.
-                //
-                // SAFETY: The constant is equal to `offset_of!(ListLinksSelfPtr, self_ptr)`, so
-                // the pointer stays in bounds of the allocation.
-                let self_ptr = unsafe { (links_field as *const u8).add(spoff) }
-                    as *const $crate::types::Opaque<*const Self>;
+                let container = $crate::container_of!(
+                    links_field, $crate::list::ListLinksSelfPtr<Self, $num>, inner
+                );
+
+                // SAFETY: By the same reasoning above, `links_field` is a valid pointer.
+                let self_ptr = unsafe {
+                    $crate::list::ListLinksSelfPtr::raw_get_self_ptr(container)
+                };
+
                 let cell_inner = $crate::types::Opaque::raw_get(self_ptr);
 
                 // SAFETY: This value is not accessed in any other places than `prepare_to_insert`,
@@ -331,12 +317,17 @@ unsafe fn view_links(me: *const Self) -> *mut $crate::list::ListLinks<$num> {
             //   `ListArc` containing `Self` until the next call to `post_remove`. The value cannot
             //   be destroyed while a `ListArc` reference exists.
             unsafe fn view_value(links_field: *mut $crate::list::ListLinks<$num>) -> *const Self {
-                let spoff = $crate::list::ListLinksSelfPtr::<Self, $num>::LIST_LINKS_SELF_PTR_OFFSET;
-                // SAFETY: The constant is equal to `offset_of!(ListLinksSelfPtr, self_ptr)`, so
-                // the pointer stays in bounds of the allocation.
-                let self_ptr = unsafe { (links_field as *const u8).add(spoff) }
-                    as *const ::core::cell::UnsafeCell<*const Self>;
-                let cell_inner = ::core::cell::UnsafeCell::raw_get(self_ptr);
+                let container = $crate::container_of!(
+                    links_field, $crate::list::ListLinksSelfPtr<Self, $num>, inner
+                );
+
+                // SAFETY: By the same reasoning above, `links_field` is a valid pointer.
+                let self_ptr = unsafe {
+                    $crate::list::ListLinksSelfPtr::raw_get_self_ptr(container)
+                };
+
+                let cell_inner = $crate::types::Opaque::raw_get(self_ptr);
+
                 // SAFETY: This is not a data race, because the only function that writes to this
                 // value is `prepare_to_insert`, but by the safety requirements the
                 // `prepare_to_insert` method may not be called in parallel with `view_value` or

-- 
2.50.0


