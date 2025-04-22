Return-Path: <linux-pci+bounces-26401-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BFCA96DF0
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 16:08:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 844CA18826AB
	for <lists+linux-pci@lfdr.de>; Tue, 22 Apr 2025 14:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739AF284699;
	Tue, 22 Apr 2025 14:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GaAcWWVU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BD4280CD2
	for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 14:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745330886; cv=none; b=XXfNg0MFRb1nbvnog25pj3JNz9OtYm+atKsLhkDW2XZMjWdf7ioFpmrTWMM7lzyp2NSaNhIorCvvo0UUN/KrJJ3lpjp8XN0ZL/+FRrWN8lyZ9nDihGSao6h88XjDsU1IsLhI5hkWchJ1KO1RUNBffQKNMzZr7iuMVivXVwzVpVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745330886; c=relaxed/simple;
	bh=MnhkHQmJvsmVgFvYaPYNciLeUrxdKNlcCbhqYEL83cY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Lhkj2JZfZTAnvhqjKVhNKu422YgSmqW/UmG4GNBdMNoZHyE0Sh791u00xoY9qBobLq+NUKLyQFwyyuV5XJ3I+NPfO0Deg7Iqu8TewXx18w3RlD/vZuBtoHZ7j/ae7zWk07Mo0Y1u/4PsTjzBR3PWlPE8kREJEOXsDxzxdc00MXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GaAcWWVU; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43cf3168b87so24784495e9.2
        for <linux-pci@vger.kernel.org>; Tue, 22 Apr 2025 07:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745330881; x=1745935681; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5F6zoPHO0Vf2l1Fq062YutUIptN7EZL0klrG+bfSeIk=;
        b=GaAcWWVU/y6/Olyb40TKcMn1qDtxycffKAgv3bGtIxlH1Isv6Amf02gFPn7pZ+bGGC
         w9zjhyaaXpBn3s5CD6JeTXj47KWCfx/Qmd4xuvuV3Rzc+AfXOwez8QR5KnW65Tv50kFr
         wkjmrvgUZpgnJQyA3Nf73kal1X+KLbsc9DrQ6ltMntwzU5brufa/ga8S20a1wa6LNB5M
         P4Z3Gx+hYxszn+F0/BRwaSj928PjTMrqZ2YCsWT243lDTxYGlCcpHQdu9Lsiy6kJ5uzz
         +8ciQzirpKf9+51DheYsM/ML0VVMbjN7FE3C8i/DQAcSI64gVlAjUckXeixEQJ9Ura3Q
         o6xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745330881; x=1745935681;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5F6zoPHO0Vf2l1Fq062YutUIptN7EZL0klrG+bfSeIk=;
        b=csbq+Vnjg3q/hV2ZimFWCBiDomdTe50hrgTOJGtYn/qdrKwTU9KxcJYOkVRnY2jZmw
         ZygCUlFc0+60mEoMs9PYcoE/zXlOTigu4Jnk7VJDNxFlpQCNayqbbenVZMKd1W29sdsE
         /NnXjOmclyaOlSbuoXgvNRFUMbjRZr66Az0Vx/b+HnSohIJ+NIiEEJI9A3SyGlvLifBj
         vDJtBeN1FTIl7MdWmPq8FDtslJIh2aH+lMcT0ZS7sQAn0X7uuJgMIoqUib13sxBt5nEU
         XQxoNNFA5/Xrga3VunD+P+YA7Zn77ozumS0gkFwHENPnR9yoJ0AeNZ/m/4Hhzar07Di7
         Pr3A==
X-Forwarded-Encrypted: i=1; AJvYcCUY615wlmHdcVlwblkZGjWywF4EDWiphGgGF2LMX+mKJ07Yd268V0fqEzvZbt7V9GwkMBh4dbjQ1bc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa97FBPFDs1wJSPWztytvuc7RxMgdHDwZaSi3Z7NfwRB2VFGof
	C+H4WsyerSbW9b7qa0nqaSmgK7QQy0HmdCt/w4MkRVDwqdw0NoxGZpFffPNU06z27B2NfkmdXzl
	+Umr9D05NsQvQ6Q==
X-Google-Smtp-Source: AGHT+IFLX4DHr+/6tE1KLHYgawIPobjKGhOVsKXL6zG3Ab9H7Y3EWJMVI94rYDp55qKE6hSpaEWOyAkgUfcYthE=
X-Received: from wmqe6.prod.google.com ([2002:a05:600c:4e46:b0:43c:f5f7:f76a])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4706:b0:43c:e9f7:d6a3 with SMTP id 5b1f17b1804b1-4406ab97d53mr134849535e9.13.1745330881618;
 Tue, 22 Apr 2025 07:08:01 -0700 (PDT)
Date: Tue, 22 Apr 2025 14:07:59 +0000
In-Reply-To: <20250324-list-no-offset-v1-5-afd2b7fc442a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250324-list-no-offset-v1-0-afd2b7fc442a@gmail.com> <20250324-list-no-offset-v1-5-afd2b7fc442a@gmail.com>
Message-ID: <aAeiv_mfAT_6DwCt@google.com>
Subject: Re: [PATCH 5/5] rust: list: remove OFFSET constants
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Mar 24, 2025 at 05:33:47PM -0400, Tamir Duberstein wrote:
> Replace `ListLinksSelfPtr::LIST_LINKS_SELF_PTR_OFFSET` with `unsafe fn
> raw_get_self_ptr` which returns a pointer to the field rather than
> requiring the caller to do pointer arithmetic.
> 
> Implement `HasListLinks::raw_get_list_links` in `impl_has_list_links!`,
> narrowing the interface of `HasListLinks` and replacing pointer
> arithmetic with `container_of!`.
> 
> Modify `impl_list_item` to also invoke `impl_has_list_links!` or
> `impl_has_list_links_self_ptr!`. This is necessary to allow
> `impl_list_item` to see more of the tokens used by
> `impl_has_list_links{,_self_ptr}!`.
> 
> A similar API change was discussed on the hrtimer series[1].
> 
> Link: https://lore.kernel.org/all/20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org/ [1]
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/list.rs                    |  18 +++---
>  rust/kernel/list/impl_list_item_mod.rs | 100 +++++++++++++++------------------
>  2 files changed, 56 insertions(+), 62 deletions(-)
> 
> diff --git a/rust/kernel/list.rs b/rust/kernel/list.rs
> index a335c3b1ff5e..f370a8c1df98 100644
> --- a/rust/kernel/list.rs
> +++ b/rust/kernel/list.rs
> @@ -212,9 +212,6 @@ unsafe impl<T: ?Sized + Send, const ID: u64> Send for ListLinksSelfPtr<T, ID> {}
>  unsafe impl<T: ?Sized + Sync, const ID: u64> Sync for ListLinksSelfPtr<T, ID> {}
>  
>  impl<T: ?Sized, const ID: u64> ListLinksSelfPtr<T, ID> {
> -    /// The offset from the [`ListLinks`] to the self pointer field.
> -    pub const LIST_LINKS_SELF_PTR_OFFSET: usize = core::mem::offset_of!(Self, self_ptr);
> -
>      /// Creates a new initializer for this type.
>      pub fn new() -> impl PinInit<Self> {
>          // INVARIANT: Pin-init initializers can't be used on an existing `Arc`, so this value will
> @@ -229,6 +226,16 @@ pub fn new() -> impl PinInit<Self> {
>              self_ptr: Opaque::uninit(),
>          }
>      }
> +
> +    /// Returns a pointer to the self pointer.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The provided pointer must point at a valid struct of type `Self`.
> +    pub unsafe fn raw_get_self_ptr(me: *mut Self) -> *const Opaque<*const T> {
> +        // SAFETY: The caller promises that the pointer is valid.
> +        unsafe { ptr::addr_of!((*me).self_ptr) }
> +    }
>  }
>  
>  impl<T: ?Sized + ListItem<ID>, const ID: u64> List<T, ID> {
> @@ -603,14 +610,11 @@ fn next(&mut self) -> Option<ArcBorrow<'a, T>> {
>  ///     }
>  /// }
>  ///
> -/// kernel::list::impl_has_list_links! {
> -///     impl HasListLinks<0> for ListItem { self.links }
> -/// }
>  /// kernel::list::impl_list_arc_safe! {
>  ///     impl ListArcSafe<0> for ListItem { untracked; }
>  /// }
>  /// kernel::list::impl_list_item! {
> -///     impl ListItem<0> for ListItem { using ListLinks; }
> +///     impl ListItem<0> for ListItem { using ListLinks { self.links }; }
>  /// }
>  ///
>  /// // Use a cursor to remove the first element with the given value.
> diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/impl_list_item_mod.rs
> index 705b46150b97..4f9100aadbce 100644
> --- a/rust/kernel/list/impl_list_item_mod.rs
> +++ b/rust/kernel/list/impl_list_item_mod.rs
> @@ -6,21 +6,18 @@
>  
>  use crate::list::ListLinks;
>  
> -/// Declares that this type has a `ListLinks<ID>` field at a fixed offset.
> +/// Declares that this type has a [`ListLinks<ID>`] field.
>  ///
> -/// This trait is only used to help implement `ListItem` safely. If `ListItem` is implemented
> +/// This trait is only used to help implement [`ListItem`] safely. If [`ListItem`] is implemented
>  /// manually, then this trait is not needed. Use the [`impl_has_list_links!`] macro to implement
>  /// this trait.
>  ///
>  /// # Safety
>  ///
> -/// All values of this type must have a `ListLinks<ID>` field at the given offset.
> +/// The methods on this trait must have exactly the behavior that the definitions given below have.
>  ///
> -/// The behavior of `raw_get_list_links` must not be changed.
> +/// [`ListItem`]: crate::list::ListItem
>  pub unsafe trait HasListLinks<const ID: u64 = 0> {
> -    /// The offset of the `ListLinks` field.
> -    const OFFSET: usize;
> -
>      /// Returns a pointer to the [`ListLinks<T, ID>`] field.
>      ///
>      /// # Safety
> @@ -28,14 +25,7 @@ pub unsafe trait HasListLinks<const ID: u64 = 0> {
>      /// The provided pointer must point at a valid struct of type `Self`.
>      ///
>      /// [`ListLinks<T, ID>`]: ListLinks
> -    // We don't really need this method, but it's necessary for the implementation of
> -    // `impl_has_list_links!` to be correct.
> -    #[inline]
> -    unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut ListLinks<ID> {
> -        // SAFETY: The caller promises that the pointer is valid. The implementer promises that the
> -        // `OFFSET` constant is correct.
> -        unsafe { (ptr as *mut u8).add(Self::OFFSET) as *mut ListLinks<ID> }
> -    }
> +    unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut ListLinks<ID>;
>  }
>  
>  /// Implements the [`HasListLinks`] trait for the given type.
> @@ -48,14 +38,11 @@ macro_rules! impl_has_list_links {
>      )*) => {$(
>          // SAFETY: The implementation of `raw_get_list_links` only compiles if the field has the
>          // right type.
> -        //
> -        // The behavior of `raw_get_list_links` is not changed since the `addr_of_mut!` macro is
> -        // equivalent to the pointer offset operation in the trait definition.
>          unsafe impl$(<$($generics),*>)? $crate::list::HasListLinks$(<$id>)? for $self {
> -            const OFFSET: usize = ::core::mem::offset_of!(Self, $($field).*) as usize;
> -
>              #[inline]
>              unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$id>)? {
> +                const _: usize = ::core::mem::offset_of!($self, $($field).*);
> +
>                  // SAFETY: The caller promises that the pointer is not dangling. We know that this
>                  // expression doesn't follow any pointers, as the `offset_of!` invocation above
>                  // would otherwise not compile.
> @@ -66,12 +53,15 @@ unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$
>  }
>  pub use impl_has_list_links;
>  
> -/// Declares that the `ListLinks<ID>` field in this struct is inside a `ListLinksSelfPtr<T, ID>`.
> +/// Declares that the [`ListLinks<ID>`] field in this struct is inside a
> +/// [`ListLinksSelfPtr<T, ID>`].
>  ///
>  /// # Safety
>  ///
> -/// The `ListLinks<ID>` field of this struct at the offset `HasListLinks<ID>::OFFSET` must be
> -/// inside a `ListLinksSelfPtr<T, ID>`.
> +/// The [`ListLinks<ID>`] field of this struct at [`HasListLinks<ID>::raw_get_list_links`] must be
> +/// inside a [`ListLinksSelfPtr<T, ID>`].
> +///
> +/// [`ListLinksSelfPtr<T, ID>`]: crate::list::ListLinksSelfPtr
>  pub unsafe trait HasSelfPtr<T: ?Sized, const ID: u64 = 0>
>  where
>      Self: HasListLinks<ID>,
> @@ -91,8 +81,6 @@ macro_rules! impl_has_list_links_self_ptr {
>          unsafe impl$(<$($generics)*>)? $crate::list::HasSelfPtr<$item_type $(, $id)?> for $self {}
>  
>          unsafe impl$(<$($generics)*>)? $crate::list::HasListLinks$(<$id>)? for $self {
> -            const OFFSET: usize = ::core::mem::offset_of!(Self, $field) as usize;
> -
>              #[inline]
>              unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$id>)? {
>                  // SAFETY: The caller promises that the pointer is not dangling.
> @@ -115,9 +103,13 @@ unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut $crate::list::ListLinks$(<$
>  macro_rules! impl_list_item {
>      (
>          $(impl$({$($generics:tt)*})? ListItem<$num:tt> for $self:ty {
> -            using ListLinks;
> +            using ListLinks { self$(.$field:ident)* };
>          })*
>      ) => {$(
> +        $crate::list::impl_has_list_links! {
> +            impl$({$($generics:tt)*})? HasListLinks<$num> for $self { self$(.$field)* }
> +        }
> +
>          // SAFETY: See GUARANTEES comment on each method.
>          unsafe impl$(<$($generics)*>)? $crate::list::ListItem<$num> for $self {
>              // GUARANTEES:
> @@ -133,20 +125,19 @@ unsafe fn view_links(me: *const Self) -> *mut $crate::list::ListLinks<$num> {
>              }
>  
>              // GUARANTEES:
> -            // * `me` originates from the most recent call to `prepare_to_insert`, which just added
> -            //   `offset` to the pointer passed to `prepare_to_insert`. This method subtracts
> -            //   `offset` from `me` so it returns the pointer originally passed to
> -            //   `prepare_to_insert`.
> +            // * `me` originates from the most recent call to `prepare_to_insert`, which calls
> +            //   `raw_get_list_link`, which is implemented using `addr_of_mut!((*self).$field)`.
> +            //   This method uses `container_of` to perform the inverse operation, so it returns the
> +            //   pointer originally passed to `prepare_to_insert`.
>              // * The pointer remains valid until the next call to `post_remove` because the caller
>              //   of the most recent call to `prepare_to_insert` promised to retain ownership of the
>              //   `ListArc` containing `Self` until the next call to `post_remove`. The value cannot
>              //   be destroyed while a `ListArc` reference exists.
>              unsafe fn view_value(me: *mut $crate::list::ListLinks<$num>) -> *const Self {
> -                let offset = <Self as $crate::list::HasListLinks<$num>>::OFFSET;
>                  // SAFETY: `me` originates from the most recent call to `prepare_to_insert`, so it
> -                // points at the field at offset `offset` in a value of type `Self`. Thus,
> -                // subtracting `offset` from `me` is still in-bounds of the allocation.
> -                unsafe { (me as *const u8).sub(offset) as *const Self }
> +                // points at the field `$field` in a value of type `Self`. Thus, reversing that
> +                // operation is still in-bounds of the allocation.
> +                $crate::container_of!(me, Self, $($field)*)
>              }
>  
>              // GUARANTEES:
> @@ -163,25 +154,28 @@ unsafe fn prepare_to_insert(me: *const Self) -> *mut $crate::list::ListLinks<$nu
>              }
>  
>              // GUARANTEES:
> -            // * `me` originates from the most recent call to `prepare_to_insert`, which just added
> -            //   `offset` to the pointer passed to `prepare_to_insert`. This method subtracts
> -            //   `offset` from `me` so it returns the pointer originally passed to
> -            //   `prepare_to_insert`.
> +            // * `me` originates from the most recent call to `prepare_to_insert`, which calls
> +            //   `raw_get_list_link`, which is implemented using `addr_of_mut!((*self).$field)`.
> +            //   This method uses `container_of` to perform the inverse operation, so it returns the
> +            //   pointer originally passed to `prepare_to_insert`.
>              unsafe fn post_remove(me: *mut $crate::list::ListLinks<$num>) -> *const Self {
> -                let offset = <Self as $crate::list::HasListLinks<$num>>::OFFSET;
>                  // SAFETY: `me` originates from the most recent call to `prepare_to_insert`, so it
> -                // points at the field at offset `offset` in a value of type `Self`. Thus,
> -                // subtracting `offset` from `me` is still in-bounds of the allocation.
> -                unsafe { (me as *const u8).sub(offset) as *const Self }
> +                // points at the field `$field` in a value of type `Self`. Thus, reversing that
> +                // operation is still in-bounds of the allocation.
> +                $crate::container_of!(me, Self, $($field)*)
>              }
>          }
>      )*};
>  
>      (
>          $(impl$({$($generics:tt)*})? ListItem<$num:tt> for $self:ty {
> -            using ListLinksSelfPtr;
> +            using ListLinksSelfPtr { self$(.$field:ident)* };
>          })*
>      ) => {$(
> +        $crate::list::impl_has_list_links_self_ptr! {
> +            impl$({$($generics:tt)*})? HasListLinks<$num> for $self { self$(.$field)* }
> +        }
> +
>          // SAFETY: See GUARANTEES comment on each method.
>          unsafe impl$(<$($generics)*>)? $crate::list::ListItem<$num> for $self {
>              // GUARANTEES:
> @@ -196,13 +190,10 @@ unsafe fn prepare_to_insert(me: *const Self) -> *mut $crate::list::ListLinks<$nu
>                  // SAFETY: The caller promises that `me` points at a valid value of type `Self`.
>                  let links_field = unsafe { <Self as $crate::list::ListItem<$num>>::view_links(me) };
>  
> -                let spoff = $crate::list::ListLinksSelfPtr::<Self, $num>::LIST_LINKS_SELF_PTR_OFFSET;
> -                // Goes via the offset as the field is private.
> -                //
> -                // SAFETY: The constant is equal to `offset_of!(ListLinksSelfPtr, self_ptr)`, so
> -                // the pointer stays in bounds of the allocation.
> -                let self_ptr = unsafe { (links_field as *const u8).add(spoff) }
> -                    as *const $crate::types::Opaque<*const Self>;
> +                // SAFETY: By the same reasoning above, `links_field` is a valid pointer.
> +                let self_ptr = unsafe {
> +                    $crate::list::ListLinksSelfPtr::<Self, $num>::raw_get_self_ptr(links_field)
> +                };
>                  let cell_inner = $crate::types::Opaque::raw_get(self_ptr);
>  
>                  // SAFETY: This value is not accessed in any other places than `prepare_to_insert`,
> @@ -241,11 +232,10 @@ unsafe fn view_links(me: *const Self) -> *mut $crate::list::ListLinks<$num> {
>              //   `ListArc` containing `Self` until the next call to `post_remove`. The value cannot
>              //   be destroyed while a `ListArc` reference exists.
>              unsafe fn view_value(links_field: *mut $crate::list::ListLinks<$num>) -> *const Self {
> -                let spoff = $crate::list::ListLinksSelfPtr::<Self, $num>::LIST_LINKS_SELF_PTR_OFFSET;
> -                // SAFETY: The constant is equal to `offset_of!(ListLinksSelfPtr, self_ptr)`, so
> -                // the pointer stays in bounds of the allocation.
> -                let self_ptr = unsafe { (links_field as *const u8).add(spoff) }
> -                    as *const ::core::cell::UnsafeCell<*const Self>;
> +                // SAFETY: By the same reasoning above, `links_field` is a valid pointer.
> +                let self_ptr = unsafe {
> +                    $crate::list::ListLinksSelfPtr::<Self, $num>::raw_get_self_ptr(links_field)
> +                };
>                  let cell_inner = ::core::cell::UnsafeCell::raw_get(self_ptr);

I ran this with Rust Binder. After adjusting the macro invocations, I
got this error:

error[E0308]: mismatched types
   --> /proc/self/cwd/common/drivers/android/binder/rust_binder.rs:178:1
    |
178 | / kernel::list::impl_list_item! {
179 | |     impl ListItem<0> for DTRWrap<dyn DeliverToRead> {
180 | |         using ListLinksSelfPtr { self.links };
181 | |     }
182 | | }
    | | ^
    | | |
    | |_expected `*mut ListLinksSelfPtr<DTRWrap<...>>`, found `*mut ListLinks`
    |   arguments to this function are incorrect
    |
    = note: expected raw pointer `*mut ListLinksSelfPtr<DTRWrap<(dyn DeliverToRead + 'static)>>`
               found raw pointer `*mut ListLinks`
note: associated function defined here
   --> /proc/self/cwd/common/rust/kernel/list.rs:235:19
    = note: this error originates in the macro `kernel::list::impl_list_item` (in Nightly builds, run with -Z macro-backtrace for more info)

error[E0308]: mismatched types
   --> /proc/self/cwd/common/drivers/android/binder/rust_binder.rs:178:1
    |
178 | / kernel::list::impl_list_item! {
179 | |     impl ListItem<0> for DTRWrap<dyn DeliverToRead> {
180 | |         using ListLinksSelfPtr { self.links };
181 | |     }
182 | | }
    | | ^
    | | |
    | |_expected `*const UnsafeCell<_>`, found `*const Opaque<*const DTRWrap<...>>`
    |   arguments to this function are incorrect
    |
    = note: expected raw pointer `*const UnsafeCell<_>`
               found raw pointer `*const Opaque<*const DTRWrap<(dyn DeliverToRead + 'static)>>`
note: associated function defined here
   --> /proc/self/cwd/prebuilts/rust/linux-x86/1.82.0/lib/rustlib/src/rust/library/core/src/cell.rs:2210:18
    = note: this error originates in the macro `kernel::list::impl_list_item` (in Nightly builds, run with -Z macro-backtrace for more info)


The relevant code is:

    #[pin_data]
    struct DTRWrap<T: ?Sized> {
        #[pin]
        links: ListLinksSelfPtr<DTRWrap<dyn DeliverToRead>>,
        #[pin]
        wrapped: T,
    }
    kernel::list::impl_list_arc_safe! {
        impl{T: ListArcSafe + ?Sized} ListArcSafe<0> for DTRWrap<T> {
            tracked_by wrapped: T;
        }
    }
    kernel::list::impl_list_item! {
        impl ListItem<0> for DTRWrap<dyn DeliverToRead> {
            using ListLinksSelfPtr { self.links };
        }
    }

Alice

