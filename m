Return-Path: <linux-pci+bounces-23816-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB69A62A1D
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 10:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9D117D1EC
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 09:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CFC1F4625;
	Sat, 15 Mar 2025 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="A0CgfKPH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C311DDC37;
	Sat, 15 Mar 2025 09:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742031033; cv=none; b=l2k1rNGLMCOkcZSDXsBOkv4xa/N4iuqQtnmlqheNMu6sdfKSS3A6M3zP6+LpfzZKDjB8p03RRAzB1gLwFBJn/ZeSAIKcGoJkzzj61zPGkXC9oQCh7gNSLG1suojsY6xT6cAwbS8umu7k1XsTVMv3dxiLgeOhXMv2czwK60l90fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742031033; c=relaxed/simple;
	bh=97kGKNN5hQbr04or/PK2XNq/0J/Oc6yIvn3Fz2Ytif0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kcJSKJu8rThp3HbBpxzT7h2hYL1OYbiAdxHrFFpfmDfQ+Ka5GfQqx0L4Lcog4fb9iPwKlpRswRoF39uyzWSVOUT94qyNNspLuWQJVex4McGTWS7wpexNoz4w9FQx6wdvC7303b7FOYItbKdOidZPw9U90GVJMhX7ImwM3+Osubk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=A0CgfKPH; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742031021; x=1742290221;
	bh=9N+3i6PB6m15+3SqKPg5OJJzxL52G/8lBjymGMBlRHE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=A0CgfKPHxzKRVkLYzcYywyC7IC/PMmsiRHRDd8W/Wi6RMGXP34ILn/wHmsVjvIDGy
	 BoZLtAo4x4DTxd/L/Xi+8bwEMCLwITVL9i2NuAcfh44GspvnEInonm1XckH2MEVmuY
	 0j9EiqLhRRJGOZVfIx60PcMLG4cnamNHWb7sADlgp9EWeINpS4xR5GgINXB45Gxv5P
	 3wg/C4WkOpdxtNoagJRbMM8HhOe3kFrtK7hwQ9bKbI0Ppt71dRl7ZlNcigXqs/djwZ
	 8eATJ3VGyaOstsYIZfZ2emqulBgBXjPhEDEKeiJWzkaB8Zm+MQeD8PoAOn25+X8HYk
	 U/pk4+WaxuOPQ==
Date: Sat, 15 Mar 2025 09:30:14 +0000
To: Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: workqueue: remove HasWork::OFFSET
Message-ID: <D8GQGCVTK0IL.16YO67C0IKLHA@proton.me>
In-Reply-To: <CAJ-ks9m2ZHguB9N9-WM0EsO5MjaZ9yRamo_9NytAdzaDdb9aWQ@mail.gmail.com>
References: <20250307-no-offset-v1-0-0c728f63b69c@gmail.com> <20250307-no-offset-v1-2-0c728f63b69c@gmail.com> <D8G8DV3PX8VX.2WHSM0TWH8JWV@proton.me> <CAJ-ks9m2ZHguB9N9-WM0EsO5MjaZ9yRamo_9NytAdzaDdb9aWQ@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 9f88381a8e82266ee6b415dd7cb86d51df4e7f89
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 14, 2025 at 9:44 PM CET, Tamir Duberstein wrote:
> On Fri, Mar 14, 2025 at 3:20=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
>>
>> On Fri Mar 7, 2025 at 10:58 PM CET, Tamir Duberstein wrote:
>> > Implement `HasWork::work_container_of` in `impl_has_work!`, narrowing
>> > the interface of `HasWork` and replacing pointer arithmetic with
>> > `container_of!`. Remove the provided implementation of
>> > `HasWork::get_work_offset` without replacement; an implementation is
>> > already generated in `impl_has_work!`. Remove the `Self: Sized` bound =
on
>> > `HasWork::work_container_of` which was apparently necessary to access
>> > `OFFSET` as `OFFSET` no longer exists.
>> >
>> > A similar API change was discussed on the hrtimer series[1].
>> >
>> > Link: https://lore.kernel.org/all/20250224-hrtimer-v3-v6-12-rc2-v9-1-5=
bd3bf0ce6cc@kernel.org/ [1]
>> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>> > ---
>> >  rust/kernel/workqueue.rs | 45 ++++++++++++---------------------------=
------
>> >  1 file changed, 12 insertions(+), 33 deletions(-)
>>
>> What is the motivation of this change? I didn't follow the discussion,
>> so if you explained it there, it would be nice if you could also add it
>> to this commit message.
>
> The motivation is right at the top: it narrows the interface and
> replaces pointer arithmetic with an existing macro, and then deletes
> unnecessary code.
>
>> > diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
>> > index 0cd100d2aefb..0e2e0ecc58a6 100644
>> > --- a/rust/kernel/workqueue.rs
>> > +++ b/rust/kernel/workqueue.rs
>> > @@ -429,51 +429,23 @@ pub unsafe fn raw_get(ptr: *const Self) -> *mut =
bindings::work_struct {
>> >  ///
>> >  /// # Safety
>> >  ///
>> > -/// The [`OFFSET`] constant must be the offset of a field in `Self` o=
f type [`Work<T, ID>`]. The
>> > -/// methods on this trait must have exactly the behavior that the def=
initions given below have.
>> > +/// The methods on this trait must have exactly the behavior that the=
 definitions given below have.
>> >  ///
>> >  /// [`impl_has_work!`]: crate::impl_has_work
>> > -/// [`OFFSET`]: HasWork::OFFSET
>> >  pub unsafe trait HasWork<T, const ID: u64 =3D 0> {
>> > -    /// The offset of the [`Work<T, ID>`] field.
>> > -    const OFFSET: usize;
>> > -
>> > -    /// Returns the offset of the [`Work<T, ID>`] field.
>> > -    ///
>> > -    /// This method exists because the [`OFFSET`] constant cannot be =
accessed if the type is not
>> > -    /// [`Sized`].
>> > -    ///
>> > -    /// [`OFFSET`]: HasWork::OFFSET
>> > -    #[inline]
>> > -    fn get_work_offset(&self) -> usize {
>> > -        Self::OFFSET
>> > -    }
>> > -
>> >      /// Returns a pointer to the [`Work<T, ID>`] field.
>> >      ///
>> >      /// # Safety
>> >      ///
>> >      /// The provided pointer must point at a valid struct of type `Se=
lf`.
>> > -    #[inline]
>> > -    unsafe fn raw_get_work(ptr: *mut Self) -> *mut Work<T, ID> {
>> > -        // SAFETY: The caller promises that the pointer is valid.
>> > -        unsafe { (ptr as *mut u8).add(Self::OFFSET) as *mut Work<T, I=
D> }
>> > -    }
>> > +    unsafe fn raw_get_work(ptr: *mut Self) -> *mut Work<T, ID>;
>> >
>> >      /// Returns a pointer to the struct containing the [`Work<T, ID>`=
] field.
>> >      ///
>> >      /// # Safety
>> >      ///
>> >      /// The pointer must point at a [`Work<T, ID>`] field in a struct=
 of type `Self`.
>> > -    #[inline]
>> > -    unsafe fn work_container_of(ptr: *mut Work<T, ID>) -> *mut Self
>> > -    where
>> > -        Self: Sized,
>>
>> This bound is required in order to allow the usage of `dyn HasWork` (ie
>> object safety), so it should stay.
>>
>> Maybe add a comment explaining why it's there.
>
> I guess a doctest would be better, but I still don't understand why
> the bound is needed. Sorry, can you cite something or explain in more
> detail please?

Here is a link: https://doc.rust-lang.org/reference/items/traits.html#dyn-c=
ompatibility

But I realized that the trait wasn't object safe to begin with due to
the `OFFSET` associated constant. So I'm not sure we need this. Alice,
do you need `dyn HasWork`?

---
Cheers,
Benno


