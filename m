Return-Path: <linux-pci+bounces-29080-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3790ACFE31
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 10:23:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F72F189B2AC
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 08:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9B4284B50;
	Fri,  6 Jun 2025 08:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jU3UCF8h"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64C6283FE8;
	Fri,  6 Jun 2025 08:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749198207; cv=none; b=ToYeiA/GGkP8Bzkea8Qm7bw4R5Wuz9BCJ26H3everY5J1ZLFJLeF/WfSmGCcIv5sF+Ce4Wb79tRPZJ81dqo/799+F4vXBwaISaY2/8+ZFbZd7D7Y3oBIsT+tuUpcz10V/44+hMQjqhFUbAXTdz98qq0n8pXBUugBh195I9Z3x4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749198207; c=relaxed/simple;
	bh=bsYHtf5b4C44wDgODtFnGNiDjj3Z49qfjun+qgAfums=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ZY7ONeyXIPrewXRqMuSXVoMHrUiLPcLOwkiPF0G/50dreAPmn2e84c0h2kDFizBuUoi9dU69p4czKjhPv4evV7CpBCRwrhuLuni2Z3QWHa17DTMIte/hVJ6OV93On3QSffHk5Z/Rp0bDC+iQdXIWvIyDU8E9+5lB0hAXVm4Lmrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jU3UCF8h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA201C4CEEF;
	Fri,  6 Jun 2025 08:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749198207;
	bh=bsYHtf5b4C44wDgODtFnGNiDjj3Z49qfjun+qgAfums=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=jU3UCF8hjBtyswtbu2HXUSW0AhCKK32leobGmercq5FqMnU39mBQHkJk/kMJhpAox
	 jKyL8RxAc1x3E42ahOs1QHYBAabHwy4aPEFYB0rUmC9PTj7ATyrqcYnDvKN6t4qaD3
	 SbprgECYDzgh8O/AykSOm6FnJtXt8F7E90YD2XTQz4qb4s/PztIG1+mv4hHCwyMslu
	 IHWzHrOJMfBe7DSLJ58iNIEwQ/KwQRRcZtlMzxxCTcr7HToxVulXQkKl9nxQImIVdv
	 ldy9N0oSU/D11oM/rWn/IAraTjsnNkNOdQPn237M23gx/W2WfmoYPd2MdFcVQTRRcJ
	 t3awzc5x4fq3w==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 06 Jun 2025 10:23:21 +0200
Message-Id: <DAFB0GKSGPSF.24BE695LGC28Z@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>, =?utf-8?q?Ma=C3=ADra_Canal?=
 <mcanal@igalia.com>
Subject: Re: [PATCH] rust: types: add FOREIGN_ALIGN to ForeignOwnable
From: "Benno Lossin" <lossin@kernel.org>
To: "Andreas Hindborg" <a.hindborg@kernel.org>, "Danilo Krummrich"
 <dakr@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Alice Ryhl" <aliceryhl@google.com>, "Trevor
 Gross" <tmgross@umich.edu>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Tamir Duberstein" <tamird@gmail.com>, "Viresh Kumar"
 <viresh.kumar@linaro.org>
X-Mailer: aerc 0.20.1
References: <20250605-pointed-to-v1-1-ee1e262912cc@kernel.org>
In-Reply-To: <20250605-pointed-to-v1-1-ee1e262912cc@kernel.org>

The title should probably also mention that it removes `PointedTo`.=20

On Thu Jun 5, 2025 at 9:55 PM CEST, Andreas Hindborg wrote:
> The current implementation of `ForeignOwnable` is leaking the type of the
> opaque pointer to consumers of the API. This allows consumers of the opaq=
ue
> pointer to rely on the information that can be extracted from the pointer
> type.
>
> To prevent this, change the API to the version suggested by Maira
> Canal (link below): Remove `ForeignOwnable::PointedTo` in favor of a
> constant, which specifies the alignment of the pointers returned by
> `into_foreign`.
>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Suggested-by: Ma=C3=ADra Canal <mcanal@igalia.com>
> Link: https://lore.kernel.org/r/20240309235927.168915-3-mcanal@igalia.com
> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>

A couple nits and documentation review below, with those fixed:

Reviewed-by: Benno Lossin <lossin@kernel.org>

> ---
>  rust/kernel/alloc/kbox.rs | 40 ++++++++++++++++++++++------------------
>  rust/kernel/miscdevice.rs | 10 +++++-----
>  rust/kernel/pci.rs        |  2 +-
>  rust/kernel/platform.rs   |  2 +-
>  rust/kernel/sync/arc.rs   | 23 ++++++++++++-----------
>  rust/kernel/types.rs      | 46 +++++++++++++++++++++--------------------=
-----
>  rust/kernel/xarray.rs     |  8 ++++----
>  7 files changed, 66 insertions(+), 65 deletions(-)
>
> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
> index c386ff771d50..97f45bc4d74f 100644
> --- a/rust/kernel/alloc/kbox.rs
> +++ b/rust/kernel/alloc/kbox.rs
> @@ -398,70 +398,74 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags)=
 -> Result<Self, E>
>      }
>  }
> =20
> -// SAFETY: The `into_foreign` function returns a pointer that is well-al=
igned.
> +// SAFETY: The pointer returned by `into_foreign` comes from a well alig=
ned
> +// pointer to `T`.
>  unsafe impl<T: 'static, A> ForeignOwnable for Box<T, A>
>  where
>      A: Allocator,
>  {
> -    type PointedTo =3D T;
> +    const FOREIGN_ALIGN: usize =3D core::mem::align_of::<T>();
>      type Borrowed<'a> =3D &'a T;
>      type BorrowedMut<'a> =3D &'a mut T;
> =20
> -    fn into_foreign(self) -> *mut Self::PointedTo {
> -        Box::into_raw(self)
> +    fn into_foreign(self) -> *mut crate::ffi::c_void {

How about we import the prelude, then you can just write `*mut c_void`
everywhere instead of having to write `crate::ffi` all the time.

> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
> index c7af0aa48a0a..6603079b05af 100644
> --- a/rust/kernel/sync/arc.rs
> +++ b/rust/kernel/sync/arc.rs
> @@ -140,10 +140,9 @@ pub struct Arc<T: ?Sized> {
>      _p: PhantomData<ArcInner<T>>,
>  }
> =20
> -#[doc(hidden)]
>  #[pin_data]
>  #[repr(C)]
> -pub struct ArcInner<T: ?Sized> {
> +struct ArcInner<T: ?Sized> {

I agree with this change, but let's mention it in the commit message.

>      refcount: Opaque<bindings::refcount_t>,
>      data: T,
>  }

> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
> index 22985b6f6982..025c619a2195 100644
> --- a/rust/kernel/types.rs
> +++ b/rust/kernel/types.rs
> @@ -21,15 +21,11 @@
>  ///
>  /// # Safety
>  ///
> -/// Implementers must ensure that [`into_foreign`] returns a pointer whi=
ch meets the alignment
> -/// requirements of [`PointedTo`].
> -///
> -/// [`into_foreign`]: Self::into_foreign
> -/// [`PointedTo`]: Self::PointedTo
> +/// Implementers must ensure that [`Self::into_foreign`] return pointers=
 with alignment that is an

s/return/returns/

> +/// integer multiple of [`Self::FOREIGN_ALIGN`].

I would just write "returns pointers aligned to [`Self::FOREIGN_ALIGN`]".

>  pub unsafe trait ForeignOwnable: Sized {
> -    /// Type used when the value is foreign-owned. In practical terms on=
ly defines the alignment of
> -    /// the pointer.
> -    type PointedTo;
> +    /// The alignment of pointers returned by `into_foreign`.
> +    const FOREIGN_ALIGN: usize;
> =20
>      /// Type used to immutably borrow a value that is currently foreign-=
owned.
>      type Borrowed<'a>;
> @@ -39,18 +35,17 @@ pub unsafe trait ForeignOwnable: Sized {
> =20
>      /// Converts a Rust-owned object to a foreign-owned one.
>      ///
> -    /// # Guarantees

Why remove this section? I think we should streamline it, (make it use
bullet points, shorten the sentences etc). We can keep the paragraph you
wrote below as normal docs.

> -    ///
> -    /// The return value is guaranteed to be well-aligned, but there are=
 no other guarantees for
> -    /// this pointer. For example, it might be null, dangling, or point =
to uninitialized memory.
> -    /// Using it in any way except for [`ForeignOwnable::from_foreign`],=
 [`ForeignOwnable::borrow`],
> -    /// [`ForeignOwnable::try_from_foreign`] can result in undefined beh=
avior.
> +    /// The foreign representation is a pointer to void. The minimum ali=
gnment of the returned
> +    /// pointer is [`Self::FOREIGN_ALIGN`]. There are no other guarantee=
s for this pointer. For
> +    /// example, it might be invalid, dangling or pointing to uninitiali=
zed memory. Using it in any
> +    /// way except for [`from_foreign`], [`try_from_foreign`], [`borrow`=
], or [`borrow_mut`] can
> +    /// result in undefined behavior.
>      ///
>      /// [`from_foreign`]: Self::from_foreign
>      /// [`try_from_foreign`]: Self::try_from_foreign
>      /// [`borrow`]: Self::borrow
>      /// [`borrow_mut`]: Self::borrow_mut
> -    fn into_foreign(self) -> *mut Self::PointedTo;
> +    fn into_foreign(self) -> *mut crate::ffi::c_void;

