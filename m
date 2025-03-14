Return-Path: <linux-pci+bounces-23775-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5936AA61A48
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 20:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3EF97A4505
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 19:20:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4590C204F71;
	Fri, 14 Mar 2025 19:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Fjs+NSzF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575C51FDA9C
	for <linux-pci@vger.kernel.org>; Fri, 14 Mar 2025 19:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741980057; cv=none; b=sDn3coeTzwary3JAV5rkiL+KzI9VNh9rUj7HsxcIPFtMwiWhXYHPYb/VVEqVxsHw1CH755WRUq5EZd8nZjhH4b7GzT+VaIol/q2fp8JGsilcL7p437V2tAeQsiubxGQV6YTFRdbsOsnL9BmQFYqa+GkkoS3WDctbjpGVn8zoYcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741980057; c=relaxed/simple;
	bh=wNQHuLdZvgcCKvlScN1lrTfyQ0hrUuljvEDBKsMOy6w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BC0S/EZ+pBf12ZYCJO+jjhvSuG8C15jGpU4LJwVlNLZOXvULV8vRp5ALqGSEVIdiT2RmKLLy8SOx31n/6fU9FXU+YiSaKEaa6B3oEMwIh6bjAJr3kPcbnTSkRNp3e+427GeVe2UQivoNM0v1ySn+xPVI6fGCWPUurWbJcmeOAuU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Fjs+NSzF; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741980046; x=1742239246;
	bh=9dJbCsG+3iacLH4tb4fmUoDsa/aO1aDzdfXxttzDOrY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Fjs+NSzFawSLNsa09TFnRz6biEqh10Ncv0mh+buk3EHwrZqdxqi8/wiragXH46+tA
	 9Cqki42WkDSHpNksr6hBbaeNCimtpIfUk77+5bFIwplsBTWRCrSD5pyXAUgc6ha/i/
	 F/AbXBhgVOheRGaQpCgNOJ1WeX0VMSBb//HLGSk0qlyIaAhYMF50PzCAQi0M3Or2oy
	 OFlo7aXbxTagMLVm9NAcvmcaFEAvLBm4dlaKjRB4RLWOwN1hyQJ0hHh/otSU1UaaAM
	 7jgt3qJkyGtcgZITwoPDGvyz7CJ7o1Hkj/k/FGaoCehgKXDM58Gr8vebZK412X1hTN
	 VQyW65skxgrjw==
Date: Fri, 14 Mar 2025 19:20:39 +0000
To: Tamir Duberstein <tamird@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: workqueue: remove HasWork::OFFSET
Message-ID: <D8G8DV3PX8VX.2WHSM0TWH8JWV@proton.me>
In-Reply-To: <20250307-no-offset-v1-2-0c728f63b69c@gmail.com>
References: <20250307-no-offset-v1-0-0c728f63b69c@gmail.com> <20250307-no-offset-v1-2-0c728f63b69c@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 62e23f231bb6f0fe7703572b1bd93319989c4b3a
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 7, 2025 at 10:58 PM CET, Tamir Duberstein wrote:
> Implement `HasWork::work_container_of` in `impl_has_work!`, narrowing
> the interface of `HasWork` and replacing pointer arithmetic with
> `container_of!`. Remove the provided implementation of
> `HasWork::get_work_offset` without replacement; an implementation is
> already generated in `impl_has_work!`. Remove the `Self: Sized` bound on
> `HasWork::work_container_of` which was apparently necessary to access
> `OFFSET` as `OFFSET` no longer exists.
>
> A similar API change was discussed on the hrtimer series[1].
>
> Link: https://lore.kernel.org/all/20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3=
bf0ce6cc@kernel.org/ [1]
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> ---
>  rust/kernel/workqueue.rs | 45 ++++++++++++------------------------------=
---
>  1 file changed, 12 insertions(+), 33 deletions(-)

What is the motivation of this change? I didn't follow the discussion,
so if you explained it there, it would be nice if you could also add it
to this commit message.

> diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> index 0cd100d2aefb..0e2e0ecc58a6 100644
> --- a/rust/kernel/workqueue.rs
> +++ b/rust/kernel/workqueue.rs
> @@ -429,51 +429,23 @@ pub unsafe fn raw_get(ptr: *const Self) -> *mut bin=
dings::work_struct {
>  ///
>  /// # Safety
>  ///
> -/// The [`OFFSET`] constant must be the offset of a field in `Self` of t=
ype [`Work<T, ID>`]. The
> -/// methods on this trait must have exactly the behavior that the defini=
tions given below have.
> +/// The methods on this trait must have exactly the behavior that the de=
finitions given below have.
>  ///
>  /// [`impl_has_work!`]: crate::impl_has_work
> -/// [`OFFSET`]: HasWork::OFFSET
>  pub unsafe trait HasWork<T, const ID: u64 =3D 0> {
> -    /// The offset of the [`Work<T, ID>`] field.
> -    const OFFSET: usize;
> -
> -    /// Returns the offset of the [`Work<T, ID>`] field.
> -    ///
> -    /// This method exists because the [`OFFSET`] constant cannot be acc=
essed if the type is not
> -    /// [`Sized`].
> -    ///
> -    /// [`OFFSET`]: HasWork::OFFSET
> -    #[inline]
> -    fn get_work_offset(&self) -> usize {
> -        Self::OFFSET
> -    }
> -
>      /// Returns a pointer to the [`Work<T, ID>`] field.
>      ///
>      /// # Safety
>      ///
>      /// The provided pointer must point at a valid struct of type `Self`=
.
> -    #[inline]
> -    unsafe fn raw_get_work(ptr: *mut Self) -> *mut Work<T, ID> {
> -        // SAFETY: The caller promises that the pointer is valid.
> -        unsafe { (ptr as *mut u8).add(Self::OFFSET) as *mut Work<T, ID> =
}
> -    }
> +    unsafe fn raw_get_work(ptr: *mut Self) -> *mut Work<T, ID>;
> =20
>      /// Returns a pointer to the struct containing the [`Work<T, ID>`] f=
ield.
>      ///
>      /// # Safety
>      ///
>      /// The pointer must point at a [`Work<T, ID>`] field in a struct of=
 type `Self`.
> -    #[inline]
> -    unsafe fn work_container_of(ptr: *mut Work<T, ID>) -> *mut Self
> -    where
> -        Self: Sized,

This bound is required in order to allow the usage of `dyn HasWork` (ie
object safety), so it should stay.

Maybe add a comment explaining why it's there.

---
Cheers,
Benno

> -    {
> -        // SAFETY: The caller promises that the pointer points at a fiel=
d of the right type in the
> -        // right kind of struct.
> -        unsafe { (ptr as *mut u8).sub(Self::OFFSET) as *mut Self }
> -    }
> +    unsafe fn work_container_of(ptr: *mut Work<T, ID>) -> *mut Self;
>  }
> =20
>  /// Used to safely implement the [`HasWork<T, ID>`] trait.
> @@ -504,8 +476,6 @@ macro_rules! impl_has_work {
>          // SAFETY: The implementation of `raw_get_work` only compiles if=
 the field has the right
>          // type.
>          unsafe impl$(<$($generics)+>)? $crate::workqueue::HasWork<$work_=
type $(, $id)?> for $self {
> -            const OFFSET: usize =3D ::core::mem::offset_of!(Self, $field=
) as usize;
> -
>              #[inline]
>              unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crate::workq=
ueue::Work<$work_type $(, $id)?> {
>                  // SAFETY: The caller promises that the pointer is not d=
angling.
> @@ -513,6 +483,15 @@ unsafe fn raw_get_work(ptr: *mut Self) -> *mut $crat=
e::workqueue::Work<$work_typ
>                      ::core::ptr::addr_of_mut!((*ptr).$field)
>                  }
>              }
> +
> +            #[inline]
> +            unsafe fn work_container_of(
> +                ptr: *mut $crate::workqueue::Work<$work_type $(, $id)?>,
> +            ) -> *mut Self {
> +                // SAFETY: The caller promises that the pointer points a=
t a field of the right type
> +                // in the right kind of struct.
> +                unsafe { $crate::container_of!(ptr, Self, $field) }
> +            }
>          }
>      )*};
>  }



