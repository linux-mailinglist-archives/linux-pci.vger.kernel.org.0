Return-Path: <linux-pci+bounces-23838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B99A62F4D
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 16:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9153B8C1A
	for <lists+linux-pci@lfdr.de>; Sat, 15 Mar 2025 15:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34ABD2046A3;
	Sat, 15 Mar 2025 15:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoGKpN2p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D49194147;
	Sat, 15 Mar 2025 15:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742053102; cv=none; b=gRgP+MaApothn4nOCKnDbqgmTl95JHpDZuyYigrf0Vpg9ujUC2nKhP3nHYi3kXNoA1VIAa/+skyPXnYp1zzyy+AvcDbky6Z+CX8Y2OZo8r4tGh9QxUcIOBvozMuhk5uTn99epA/xpezP0rcgqB73HHLQOFVFU3MdwomAGrL1oMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742053102; c=relaxed/simple;
	bh=kGSZJzOU4L7eQChHE8a6LnzTo1ZANahs53GQARXJf6M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L6IOj5i4yX20sH91mZot7KYkmLPjvs3jmzGDJYjwSzobi54dIRfRx6D7veoSk+zHo2HEZUJyug/Yboz8i+K8AD9/x0Y11aJGX0WuiMqGt6is7vFEufTK5kZ7h8yhCg+RgIRDXNyeWOabT6hRYBL/DjH74kCC+aqhXJrBSUAY+eY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoGKpN2p; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-307bc125e2eso34197911fa.3;
        Sat, 15 Mar 2025 08:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742053097; x=1742657897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F0iLcydiID1sxBrL5CCTf4juC5fTbfBGnl59PwFybRE=;
        b=VoGKpN2pa/ohdv8mNXd3kCyDl3sExS/yxdTx/XmFG9rNl9fGEKFC7lVqp0ZNiwZ3CV
         0SZLIceRDysXn8KAtNneqM9co8/Rl8jponnMgWUty5FPztKK1GKfgkiDEB+YC1wI93uu
         XMJS9APp3EoS96xU3eePOjkrQ4gTUVnmdpJTcuV33zRBpvKoHwCw/l6ErnceEMK4TojB
         rB/vvifwPDrKByIaotNC6iGfdw/ASWoMJA0jv/7lLaoAO4pwa5WwtUIvJdO8LMJ/5xoA
         i9wSj4iO7TW1E30oTrokx4EbnkGD6uH/Fcv0g0U5CM29kkRUDHzzSb03ghf/WrPDMcmX
         dAug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742053097; x=1742657897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F0iLcydiID1sxBrL5CCTf4juC5fTbfBGnl59PwFybRE=;
        b=pPNeJyqKNUgEG+GpJWjQM+Bk6mx0sEJhaqRBo/fiuY6DBGhS6eIqrUj5WI6bP08nue
         nLzqTzVeeNsKqUgZsieGUMjek0girQnD+G+fOSBjCJ8f9iRQRGawf4485XT9/peGlsC/
         9xpYbgmhQ34otapUXqzDfKcKum5iNDVbneND0ar90DaHXYkojfOx1xzPps7s/ceSqbxj
         Q9rMd0fez7VxWwzo38RrCXETL7ROhxiBThfdrjhIEe5lSRHbHqWvCL1oqu6ES0fLvDxz
         /ryxBTmqH3XniR5YH03epvb86wNRJm9OSkEL888olS4BLDbZbtkFtJrGxaEdSZaAzHRp
         VLwg==
X-Forwarded-Encrypted: i=1; AJvYcCVSWWhrST9Uu/pi8Py+7+BsqwddgwS5baTc7YsStWmYcmvKCeOXPcMcQnc/3M91Oxgxy8h7jYpTJoxl@vger.kernel.org, AJvYcCVU+vN8NRnMCEVRE/RJ4+xYJCJ4jgmUsTINbRAk562okvW5V+SIHL2u/nl+Xd0hWxelRpgdMkHlqKF9yMs=@vger.kernel.org, AJvYcCXSuXifsj8nSLUWk/h9uTt/Ko6ufr+WBWnUUwaVrVM889wl2aOtDwUCmdZwxJCtG6yMhDL0K8+pql9x5Nzejfk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuNtp+d/GgL8OX02NjUgPx8QZPGBxISNV8wqAVMdH7QVnqnhIl
	dczq0fwLlEqRB16kt6/qUnZUbKHZTxw7HeO6OkCSV1x8IWVrgepxTW4eNZA5HS/E+GvMVgJR9JT
	OTjGF92rPSDkPVdFPGooQZorU9cKexuxGD4usCegc
X-Gm-Gg: ASbGncskr2y3EeBtcjFvTRepvtOTBFTAJKoVVUiuYGKRplnvzhid+PLY4nESQ9sXUU7
	O7wvebQDNi16A5T+I35fRkq4R/Xtu7pdC9mAOMAz2L2GEiytOusKIqxuXNerJelCQPWaWr1/Byu
	OxA1mWjayczo7Yn5oONwQrOmCqJlhJ2RwbR8607UOHmgxcYqQE82XYVD0Y4vBd
X-Google-Smtp-Source: AGHT+IGnpNuqTOD0WOfWVqEHOetlKhQwugDuc1X4RXDFqUUs6raziCsoA4yUjsu2aPXwne18UcSpIKPhmPlpWo8QTA0=
X-Received: by 2002:a05:651c:198c:b0:30b:b956:53e5 with SMTP id
 38308e7fff4ca-30c4a8631b9mr24179671fa.12.1742053096882; Sat, 15 Mar 2025
 08:38:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-no-offset-v1-0-0c728f63b69c@gmail.com>
 <20250307-no-offset-v1-2-0c728f63b69c@gmail.com> <D8G8DV3PX8VX.2WHSM0TWH8JWV@proton.me>
 <CAJ-ks9m2ZHguB9N9-WM0EsO5MjaZ9yRamo_9NytAdzaDdb9aWQ@mail.gmail.com> <D8GQGCVTK0IL.16YO67C0IKLHA@proton.me>
In-Reply-To: <D8GQGCVTK0IL.16YO67C0IKLHA@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sat, 15 Mar 2025 11:37:39 -0400
X-Gm-Features: AQ5f1JpQeNsYN5kJ-KLojJA7cOM6gMMJU0Qn4hqTtP5bdtluh6WNjEOjG5adcc0
Message-ID: <CAJ-ks9mUPkP=QDGekbi1PRfpKKigXj87-_a25JBGHVRSiEe_AA@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: workqueue: remove HasWork::OFFSET
To: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 5:30=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Fri Mar 14, 2025 at 9:44 PM CET, Tamir Duberstein wrote:
> > On Fri, Mar 14, 2025 at 3:20=E2=80=AFPM Benno Lossin <benno.lossin@prot=
on.me> wrote:
> >>
> >> On Fri Mar 7, 2025 at 10:58 PM CET, Tamir Duberstein wrote:
> >> > Implement `HasWork::work_container_of` in `impl_has_work!`, narrowin=
g
> >> > the interface of `HasWork` and replacing pointer arithmetic with
> >> > `container_of!`. Remove the provided implementation of
> >> > `HasWork::get_work_offset` without replacement; an implementation is
> >> > already generated in `impl_has_work!`. Remove the `Self: Sized` boun=
d on
> >> > `HasWork::work_container_of` which was apparently necessary to acces=
s
> >> > `OFFSET` as `OFFSET` no longer exists.
> >> >
> >> > A similar API change was discussed on the hrtimer series[1].
> >> >
> >> > Link: https://lore.kernel.org/all/20250224-hrtimer-v3-v6-12-rc2-v9-1=
-5bd3bf0ce6cc@kernel.org/ [1]
> >> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> >> > ---
> >> >  rust/kernel/workqueue.rs | 45 ++++++++++++-------------------------=
--------
> >> >  1 file changed, 12 insertions(+), 33 deletions(-)
> >>
> >> What is the motivation of this change? I didn't follow the discussion,
> >> so if you explained it there, it would be nice if you could also add i=
t
> >> to this commit message.
> >
> > The motivation is right at the top: it narrows the interface and
> > replaces pointer arithmetic with an existing macro, and then deletes
> > unnecessary code.
> >
> >> > diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> >> > index 0cd100d2aefb..0e2e0ecc58a6 100644
> >> > --- a/rust/kernel/workqueue.rs
> >> > +++ b/rust/kernel/workqueue.rs
> >> > @@ -429,51 +429,23 @@ pub unsafe fn raw_get(ptr: *const Self) -> *mu=
t bindings::work_struct {
> >> >  ///
> >> >  /// # Safety
> >> >  ///
> >> > -/// The [`OFFSET`] constant must be the offset of a field in `Self`=
 of type [`Work<T, ID>`]. The
> >> > -/// methods on this trait must have exactly the behavior that the d=
efinitions given below have.
> >> > +/// The methods on this trait must have exactly the behavior that t=
he definitions given below have.
> >> >  ///
> >> >  /// [`impl_has_work!`]: crate::impl_has_work
> >> > -/// [`OFFSET`]: HasWork::OFFSET
> >> >  pub unsafe trait HasWork<T, const ID: u64 =3D 0> {
> >> > -    /// The offset of the [`Work<T, ID>`] field.
> >> > -    const OFFSET: usize;
> >> > -
> >> > -    /// Returns the offset of the [`Work<T, ID>`] field.
> >> > -    ///
> >> > -    /// This method exists because the [`OFFSET`] constant cannot b=
e accessed if the type is not
> >> > -    /// [`Sized`].
> >> > -    ///
> >> > -    /// [`OFFSET`]: HasWork::OFFSET
> >> > -    #[inline]
> >> > -    fn get_work_offset(&self) -> usize {
> >> > -        Self::OFFSET
> >> > -    }
> >> > -
> >> >      /// Returns a pointer to the [`Work<T, ID>`] field.
> >> >      ///
> >> >      /// # Safety
> >> >      ///
> >> >      /// The provided pointer must point at a valid struct of type `=
Self`.
> >> > -    #[inline]
> >> > -    unsafe fn raw_get_work(ptr: *mut Self) -> *mut Work<T, ID> {
> >> > -        // SAFETY: The caller promises that the pointer is valid.
> >> > -        unsafe { (ptr as *mut u8).add(Self::OFFSET) as *mut Work<T,=
 ID> }
> >> > -    }
> >> > +    unsafe fn raw_get_work(ptr: *mut Self) -> *mut Work<T, ID>;
> >> >
> >> >      /// Returns a pointer to the struct containing the [`Work<T, ID=
>`] field.
> >> >      ///
> >> >      /// # Safety
> >> >      ///
> >> >      /// The pointer must point at a [`Work<T, ID>`] field in a stru=
ct of type `Self`.
> >> > -    #[inline]
> >> > -    unsafe fn work_container_of(ptr: *mut Work<T, ID>) -> *mut Self
> >> > -    where
> >> > -        Self: Sized,
> >>
> >> This bound is required in order to allow the usage of `dyn HasWork` (i=
e
> >> object safety), so it should stay.
> >>
> >> Maybe add a comment explaining why it's there.
> >
> > I guess a doctest would be better, but I still don't understand why
> > the bound is needed. Sorry, can you cite something or explain in more
> > detail please?
>
> Here is a link: https://doc.rust-lang.org/reference/items/traits.html#dyn=
-compatibility
>
> But I realized that the trait wasn't object safe to begin with due to
> the `OFFSET` associated constant. So I'm not sure we need this. Alice,
> do you need `dyn HasWork`?

I wrote a simple test:

diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
index 0e2e0ecc58a6..4f2dd2c1ebcb 100644
--- a/rust/kernel/workqueue.rs
+++ b/rust/kernel/workqueue.rs
@@ -448,6 +448,11 @@ pub unsafe trait HasWork<T, const ID: u64 =3D 0> {
     unsafe fn work_container_of(ptr: *mut Work<T, ID>) -> *mut Self;
 }

+fn has_work_object_safe<T: HasWork<T>>(has_work: T) {
+    fn _assert_object_safe(_: &dyn HasWork<()>) {}
+    _assert_object_safe(&has_work);
+}
+
 /// Used to safely implement the [`HasWork<T, ID>`] trait.
 ///
 /// # Examples

`HasWork` is not object-safe even before this patch:

> error[E0038]: the trait `workqueue::HasWork` cannot be made into an objec=
t
>    --> ../rust/kernel/workqueue.rs:481:25
>     |
> 481 |     _assert_object_safe(&has_work);
>     |                         ^^^^^^^^^ `workqueue::HasWork` cannot be ma=
de into an object
>     |
> note: for a trait to be "dyn-compatible" it needs to allow building a vta=
ble to allow the call to be resolvable dynamically; for more information vi=
sit <https://doc.rust-lang.org/reference/items/traits.html#object-safety>
>    --> ../rust/kernel/workqueue.rs:439:11
>     |
> 437 | pub unsafe trait HasWork<T, const ID: u64 =3D 0> {
>     |                  ------- this trait cannot be made into an object..=
.
> 438 |     /// The offset of the [`Work<T, ID>`] field.
> 439 |     const OFFSET: usize;
>     |           ^^^^^^ ...because it contains this associated `const`
> ...
> 458 |     unsafe fn raw_get_work(ptr: *mut Self) -> *mut Work<T, ID> {
>     |               ^^^^^^^^^^^^ ...because associated function `raw_get_=
work` has no `self` parameter
>     =3D help: consider moving `OFFSET` to another trait
>     =3D help: only type `workqueue::ClosureWork<T>` is seen to implement =
the trait in this crate, consider using it directly instead
>     =3D note: `workqueue::HasWork` can be implemented in other crates; if=
 you want to support your users passing their own types here, you can't ref=
er to a specific type
> help: consider turning `raw_get_work` into a method by giving it a `&self=
` argument
>     |
> 458 |     unsafe fn raw_get_work(&self, ptr: *mut Self) -> *mut Work<T, I=
D> {
>     |                            ++++++
> help: alternatively, consider constraining `raw_get_work` so it does not =
apply to trait objects
>     |
> 458 |     unsafe fn raw_get_work(ptr: *mut Self) -> *mut Work<T, ID> wher=
e Self: Sized {
>     |                                                                ++++=
+++++++++++++
>
> error: aborting due to 3 previous errors

so I don't think adding the Sized bound makes sense - we'd end up
adding it on every item in the trait.

