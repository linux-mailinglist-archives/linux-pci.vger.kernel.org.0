Return-Path: <linux-pci+bounces-29301-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 712B2AD31F2
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 11:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F138F188304F
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 09:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9CF280A5A;
	Tue, 10 Jun 2025 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyRXYHiW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2AD22172F;
	Tue, 10 Jun 2025 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749547659; cv=none; b=Sz0WhbDEeWLop5rKMAgPQ9OoourymyeW4b90plTsg+Q3VFAM+SyoIJdgiglDfgq29AsJXyZmbT7eMGbZw8rcZbCOf7rap/GSQf8Oz4zXhyp+NJUDIslrKz7mfBqUmb1xbUwtFSnie4DqEC4GRWibmGLH5IuGYCxBqVV0qf7FSrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749547659; c=relaxed/simple;
	bh=ZqzZXwBienY7zE2X7UrzBwvmMt1YWhqjZH4WMRWX/Zo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S646/lJgC+sURd8Lm+6OvVwm4n3MzCf1LvM8FAWLnumnhDZkYCUnt0235Gh9of4Kr73fPkZVo5ZMa2NyyKKdONfOth2tbQ+FoFnQPcTmynr+o+oRCNKYWhu8st7sZwKLFcPjDxeARaLLueGZ85tstsshWEd3D0QrIX7AyTB4o/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyRXYHiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 630E1C4CEED;
	Tue, 10 Jun 2025 09:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749547659;
	bh=ZqzZXwBienY7zE2X7UrzBwvmMt1YWhqjZH4WMRWX/Zo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=AyRXYHiWAEcp+X0pY5kz+1POSUUq2ems/XitGiLQs2i7z1GICUOyZzcPKeEYJOFfi
	 XPYiIQXtSWVXOBNHDRewq1DowMlebBIJCeOYo8RJf2yHWhCtS4lxvPVst6jqxQ4X+n
	 qJEyfIDVygKPARuYxlqqOsKOA5Fnu6dn1gGposASs03Yw1yLvXmdwhTCz01qoGVnm5
	 e+eA26om9KAtz8ez/ultTGmP+z/F+gX0ta8mAqwOQKbU06bfjBc2o1Di/F3bd1rZtc
	 qIUqSuJ3EmEQyJWlk5q/Gen4EDNepQplZZfF+fjlmp+5Q3rFQ011FW2hmtsTNsCY9d
	 6eUZtWUUzJeUA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Benno Lossin" <lossin@kernel.org>
Cc: "Danilo Krummrich" <dakr@kernel.org>,  "Miguel Ojeda"
 <ojeda@kernel.org>,  "Alex Gaynor" <alex.gaynor@gmail.com>,  "Boqun Feng"
 <boqun.feng@gmail.com>,  "Gary Guo" <gary@garyguo.net>,  =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Alice Ryhl" <aliceryhl@google.com>,  "Trevor
 Gross" <tmgross@umich.edu>,  "Bjorn Helgaas" <bhelgaas@google.com>,
  Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,  "Greg
 Kroah-Hartman"
 <gregkh@linuxfoundation.org>,  "Rafael J. Wysocki" <rafael@kernel.org>,
  "Tamir Duberstein" <tamird@gmail.com>,  "Viresh Kumar"
 <viresh.kumar@linaro.org>,  <rust-for-linux@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  <linux-pci@vger.kernel.org>,
  =?utf-8?Q?Ma=C3=ADra?=
 Canal <mcanal@igalia.com>
Subject: Re: [PATCH] rust: types: add FOREIGN_ALIGN to ForeignOwnable
In-Reply-To: <DAFB0GKSGPSF.24BE695LGC28Z@kernel.org> (Benno Lossin's message
	of "Fri, 06 Jun 2025 10:23:21 +0200")
References: <20250605-pointed-to-v1-1-ee1e262912cc@kernel.org>
	<WubHJPtx9Uu0qugeELZ2ooYWKq4KDj7r8P7k4i_QhgOP53MWk1V3XHH4Ztmzp42zMwHSntslAbfpLFY9AhjfxQ==@protonmail.internalid>
	<DAFB0GKSGPSF.24BE695LGC28Z@kernel.org>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 10 Jun 2025 11:27:28 +0200
Message-ID: <87sek82bgf.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Benno,

"Benno Lossin" <lossin@kernel.org> writes:

> The title should probably also mention that it removes `PointedTo`.
>
> On Thu Jun 5, 2025 at 9:55 PM CEST, Andreas Hindborg wrote:
>> The current implementation of `ForeignOwnable` is leaking the type of the
>> opaque pointer to consumers of the API. This allows consumers of the opa=
que
>> pointer to rely on the information that can be extracted from the pointer
>> type.
>>
>> To prevent this, change the API to the version suggested by Maira
>> Canal (link below): Remove `ForeignOwnable::PointedTo` in favor of a
>> constant, which specifies the alignment of the pointers returned by
>> `into_foreign`.
>>
>> Suggested-by: Alice Ryhl <aliceryhl@google.com>
>> Suggested-by: Ma=C3=ADra Canal <mcanal@igalia.com>
>> Link: https://lore.kernel.org/r/20240309235927.168915-3-mcanal@igalia.com
>> Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
>
> A couple nits and documentation review below, with those fixed:
>
> Reviewed-by: Benno Lossin <lossin@kernel.org>
>
>> ---
>>  rust/kernel/alloc/kbox.rs | 40 ++++++++++++++++++++++------------------
>>  rust/kernel/miscdevice.rs | 10 +++++-----
>>  rust/kernel/pci.rs        |  2 +-
>>  rust/kernel/platform.rs   |  2 +-
>>  rust/kernel/sync/arc.rs   | 23 ++++++++++++-----------
>>  rust/kernel/types.rs      | 46 +++++++++++++++++++++-------------------=
------
>>  rust/kernel/xarray.rs     |  8 ++++----
>>  7 files changed, 66 insertions(+), 65 deletions(-)
>>
>> diff --git a/rust/kernel/alloc/kbox.rs b/rust/kernel/alloc/kbox.rs
>> index c386ff771d50..97f45bc4d74f 100644
>> --- a/rust/kernel/alloc/kbox.rs
>> +++ b/rust/kernel/alloc/kbox.rs
>> @@ -398,70 +398,74 @@ fn try_init<E>(init: impl Init<T, E>, flags: Flags=
) -> Result<Self, E>
>>      }
>>  }
>>
>> -// SAFETY: The `into_foreign` function returns a pointer that is well-a=
ligned.
>> +// SAFETY: The pointer returned by `into_foreign` comes from a well ali=
gned
>> +// pointer to `T`.
>>  unsafe impl<T: 'static, A> ForeignOwnable for Box<T, A>
>>  where
>>      A: Allocator,
>>  {
>> -    type PointedTo =3D T;
>> +    const FOREIGN_ALIGN: usize =3D core::mem::align_of::<T>();
>>      type Borrowed<'a> =3D &'a T;
>>      type BorrowedMut<'a> =3D &'a mut T;
>>
>> -    fn into_foreign(self) -> *mut Self::PointedTo {
>> -        Box::into_raw(self)
>> +    fn into_foreign(self) -> *mut crate::ffi::c_void {
>
> How about we import the prelude, then you can just write `*mut c_void`
> everywhere instead of having to write `crate::ffi` all the time.

OK.

>
>> diff --git a/rust/kernel/sync/arc.rs b/rust/kernel/sync/arc.rs
>> index c7af0aa48a0a..6603079b05af 100644
>> --- a/rust/kernel/sync/arc.rs
>> +++ b/rust/kernel/sync/arc.rs
>> @@ -140,10 +140,9 @@ pub struct Arc<T: ?Sized> {
>>      _p: PhantomData<ArcInner<T>>,
>>  }
>>
>> -#[doc(hidden)]
>>  #[pin_data]
>>  #[repr(C)]
>> -pub struct ArcInner<T: ?Sized> {
>> +struct ArcInner<T: ?Sized> {
>
> I agree with this change, but let's mention it in the commit message.

Right.

>
>>      refcount: Opaque<bindings::refcount_t>,
>>      data: T,
>>  }
>
>> diff --git a/rust/kernel/types.rs b/rust/kernel/types.rs
>> index 22985b6f6982..025c619a2195 100644
>> --- a/rust/kernel/types.rs
>> +++ b/rust/kernel/types.rs
>> @@ -21,15 +21,11 @@
>>  ///
>>  /// # Safety
>>  ///
>> -/// Implementers must ensure that [`into_foreign`] returns a pointer wh=
ich meets the alignment
>> -/// requirements of [`PointedTo`].
>> -///
>> -/// [`into_foreign`]: Self::into_foreign
>> -/// [`PointedTo`]: Self::PointedTo
>> +/// Implementers must ensure that [`Self::into_foreign`] return pointer=
s with alignment that is an
>
> s/return/returns/

Thanks.

>
>> +/// integer multiple of [`Self::FOREIGN_ALIGN`].
>
> I would just write "returns pointers aligned to [`Self::FOREIGN_ALIGN`]".

OK.

>
>>  pub unsafe trait ForeignOwnable: Sized {
>> -    /// Type used when the value is foreign-owned. In practical terms o=
nly defines the alignment of
>> -    /// the pointer.
>> -    type PointedTo;
>> +    /// The alignment of pointers returned by `into_foreign`.
>> +    const FOREIGN_ALIGN: usize;
>>
>>      /// Type used to immutably borrow a value that is currently foreign=
-owned.
>>      type Borrowed<'a>;
>> @@ -39,18 +35,17 @@ pub unsafe trait ForeignOwnable: Sized {
>>
>>      /// Converts a Rust-owned object to a foreign-owned one.
>>      ///
>> -    /// # Guarantees
>
> Why remove this section? I think we should streamline it, (make it use
> bullet points, shorten the sentences etc). We can keep the paragraph you
> wrote below as normal docs.

Not sure exactly what you are going for here. How is this:


  Converts a Rust-owned object to a foreign-owned one.

  The foreign representation is a pointer to void.

  # Guarantees

  - Minimum alignment of returned pointer is [`Self::FOREIGN_ALIGN`].

  There are no other guarantees for this pointer. For example, it might be =
invalid, dangling
  or pointing to uninitialized memory. Using it in any way except for [`fro=
m_foreign`],
  [`try_from_foreign`], [`borrow`], or [`borrow_mut`] can result in undefin=
ed behavior.



Best regards,
Andreas Hindborg



