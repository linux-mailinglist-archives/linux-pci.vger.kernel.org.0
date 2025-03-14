Return-Path: <linux-pci+bounces-23782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FF8A61CFC
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 21:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 144883BCA1C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 20:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DDF204F7D;
	Fri, 14 Mar 2025 20:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afjIK5bM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2241632D3;
	Fri, 14 Mar 2025 20:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741985089; cv=none; b=djwnzpswAwu/vx4TkRIL3Q4Quc14okRUnZEMHwmCqZ1XCFYaNGglBoEhYXPb0bb3CQXmqUr19qOwB67R8qdPjJmju+FjKFhR6JH7TU2jHhBL/vH2SmLkJm87f2C5gCpp0FFSyUjtnzW4K2hmiid8tJz3M5wjKN+5aqE3+FFl+FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741985089; c=relaxed/simple;
	bh=K38rtCg0kuf5BLUm4oFEtAJew5kJ4vmq8l+3NjU1z5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XQoh6LkHDybsIrldsTBZzpExkmwnHFBLo3k+LH8otG3WYDyXkFKJ7Xoqa/bETMgEgqP50nGmCGfr9Sz5Ru6P76wbYrWdAmyFYJrEE2oDxVoijTcfp+5dkzVoYFqwAmHNk1fE/Rop7Bbb9OXjLhJ2Mb7/GqUyss/6k9uFOp+DNXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afjIK5bM; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-30bf8f5dde5so22616831fa.2;
        Fri, 14 Mar 2025 13:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741985085; x=1742589885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbuICH0xY+23m7hRrkhkpy/RJHHQ5P9b5jI+i1zRw3Q=;
        b=afjIK5bMN1uPHMEjkGieYEiIlmVyPS+KKv4Ui5l33sE8VgVgTumN2zt0k/R1OZ1Ugf
         iJW4NceEayc3gvUNELbnSrLq3+6TsMckKNP0+rWzs7ZfCU4/qs1eOOa+3MXEFx3PSYnV
         bGHl03eJZBZBXhIbV4FmxI6uskpR0ovzfsXukLxpD+4ozst5o8JX2NMrRGCEE2TtJF8G
         nAfT9V9QyyGCWkVxxNwh2pM/9aDzQJkSjEfE0ot/EAa9m5Vy/LkWpkmLO5UAgS18sMBi
         6eRZUjJQh4tOwNnMDLtTuUHHCK21ylpJeLf5krWwsNXovLSMkZeOTSqQvmdqcD+OLscu
         YJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741985085; x=1742589885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbuICH0xY+23m7hRrkhkpy/RJHHQ5P9b5jI+i1zRw3Q=;
        b=T2a2mJWvTo7kCDZtYCP+aWfP0qiiWxKHrCuxj54IoFUT1a1bcWFGlIevGknfhp2gQF
         dcQ1b0P0MT6Ouw4w3Gyctj5VEYlSTp0qKgGy9YcRxLEIBbDJ9Sy0PwFfe+GnyWxNzxWG
         YxkE1CdhZCK33L0f+xbgSoYf0aPgHxiIV7j9LvdtGu2LGUlHM761HdsqKVrSafrwXTki
         CvadUsiVLeh9Gj5VnZO5Gd8oLRuq5vP8SelT/wOmO8pqcqEWwt8yoC4pVUWW5XVyrKNS
         Hbc57+eNJShB9igRfslEQ4cLBHUNAxiEz/dDy3VZ9RQ7PmEV0dIAlsYJb+sCjMVcDZUr
         PGAQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/VP1StKsL0+OlysiGg+soldO6xMRqDwS+R7d7R7+HpM/gqP97UNFnOLyzF5mF3e337V1J3P1tf0yeTGrHSPo=@vger.kernel.org, AJvYcCUF2uqqdygaETdklYblOMUwhgeUUx0dcBSe7ChagO/e7LP9zoYmu32xWbqSDkBpNbcQutHbnC8dxuoQJI0=@vger.kernel.org, AJvYcCXezX4bscy4YWF6/bICk+IpvkQ3uEQ6QJwUVT63EwH86c6QA8MvuikBLd2L6vwd69ynHl0vZN965xBI@vger.kernel.org
X-Gm-Message-State: AOJu0YyUHeDt0GmIMv0f3uj52jq1zaZeI4jSpOMcwmOTL0KG/1SDMhKC
	jHv7l/Kc2/Tau12YJb3klUnM5g/Cbk4HK9S2oQWC8k3yrw7sAoE69jA9U0Lxum7mqA389SeRfZ0
	jsJzETaN/SdHum/pYyx3YZHOv2TU=
X-Gm-Gg: ASbGncvNEpZF/rVWA2vrGGA+MuuyfWN4lCSY/h45izdbxyf3EqRCnme1fD6YieKBpqV
	ZRpmBEu4ngtWhkSrUhHwGto2DAcp3bcKN9bOoqRelrQ79eBrFibWM42nhmiQRRl5RdlJUFkC76k
	s2INl1EmNEyynTIwFrX1VnRPxwl1zR2hGf2kHcozibWZbHjQm3tip/7DTHVJEgM+1Pf0gN+A==
X-Google-Smtp-Source: AGHT+IHyjRUH5bP0g+Qn62uRuFdDAKIS1VuKzputx8lydYnmmk3AzYJzf9o4T+3pIf85TbzIVYTDR1jqyEevJPhekyg=
X-Received: by 2002:a2e:bc29:0:b0:30b:feb4:ed4 with SMTP id
 38308e7fff4ca-30c4a8f4854mr13405891fa.31.1741985085005; Fri, 14 Mar 2025
 13:44:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-no-offset-v1-0-0c728f63b69c@gmail.com>
 <20250307-no-offset-v1-2-0c728f63b69c@gmail.com> <D8G8DV3PX8VX.2WHSM0TWH8JWV@proton.me>
In-Reply-To: <D8G8DV3PX8VX.2WHSM0TWH8JWV@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Fri, 14 Mar 2025 16:44:08 -0400
X-Gm-Features: AQ5f1JqK-ZmY1G6R0T76WtY--7gK8sc6Jlrs7D3Ueck0gX06YyrRpp9KYLIz3RI
Message-ID: <CAJ-ks9m2ZHguB9N9-WM0EsO5MjaZ9yRamo_9NytAdzaDdb9aWQ@mail.gmail.com>
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

On Fri, Mar 14, 2025 at 3:20=E2=80=AFPM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Fri Mar 7, 2025 at 10:58 PM CET, Tamir Duberstein wrote:
> > Implement `HasWork::work_container_of` in `impl_has_work!`, narrowing
> > the interface of `HasWork` and replacing pointer arithmetic with
> > `container_of!`. Remove the provided implementation of
> > `HasWork::get_work_offset` without replacement; an implementation is
> > already generated in `impl_has_work!`. Remove the `Self: Sized` bound o=
n
> > `HasWork::work_container_of` which was apparently necessary to access
> > `OFFSET` as `OFFSET` no longer exists.
> >
> > A similar API change was discussed on the hrtimer series[1].
> >
> > Link: https://lore.kernel.org/all/20250224-hrtimer-v3-v6-12-rc2-v9-1-5b=
d3bf0ce6cc@kernel.org/ [1]
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  rust/kernel/workqueue.rs | 45 ++++++++++++----------------------------=
-----
> >  1 file changed, 12 insertions(+), 33 deletions(-)
>
> What is the motivation of this change? I didn't follow the discussion,
> so if you explained it there, it would be nice if you could also add it
> to this commit message.

The motivation is right at the top: it narrows the interface and
replaces pointer arithmetic with an existing macro, and then deletes
unnecessary code.

> > diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> > index 0cd100d2aefb..0e2e0ecc58a6 100644
> > --- a/rust/kernel/workqueue.rs
> > +++ b/rust/kernel/workqueue.rs
> > @@ -429,51 +429,23 @@ pub unsafe fn raw_get(ptr: *const Self) -> *mut b=
indings::work_struct {
> >  ///
> >  /// # Safety
> >  ///
> > -/// The [`OFFSET`] constant must be the offset of a field in `Self` of=
 type [`Work<T, ID>`]. The
> > -/// methods on this trait must have exactly the behavior that the defi=
nitions given below have.
> > +/// The methods on this trait must have exactly the behavior that the =
definitions given below have.
> >  ///
> >  /// [`impl_has_work!`]: crate::impl_has_work
> > -/// [`OFFSET`]: HasWork::OFFSET
> >  pub unsafe trait HasWork<T, const ID: u64 =3D 0> {
> > -    /// The offset of the [`Work<T, ID>`] field.
> > -    const OFFSET: usize;
> > -
> > -    /// Returns the offset of the [`Work<T, ID>`] field.
> > -    ///
> > -    /// This method exists because the [`OFFSET`] constant cannot be a=
ccessed if the type is not
> > -    /// [`Sized`].
> > -    ///
> > -    /// [`OFFSET`]: HasWork::OFFSET
> > -    #[inline]
> > -    fn get_work_offset(&self) -> usize {
> > -        Self::OFFSET
> > -    }
> > -
> >      /// Returns a pointer to the [`Work<T, ID>`] field.
> >      ///
> >      /// # Safety
> >      ///
> >      /// The provided pointer must point at a valid struct of type `Sel=
f`.
> > -    #[inline]
> > -    unsafe fn raw_get_work(ptr: *mut Self) -> *mut Work<T, ID> {
> > -        // SAFETY: The caller promises that the pointer is valid.
> > -        unsafe { (ptr as *mut u8).add(Self::OFFSET) as *mut Work<T, ID=
> }
> > -    }
> > +    unsafe fn raw_get_work(ptr: *mut Self) -> *mut Work<T, ID>;
> >
> >      /// Returns a pointer to the struct containing the [`Work<T, ID>`]=
 field.
> >      ///
> >      /// # Safety
> >      ///
> >      /// The pointer must point at a [`Work<T, ID>`] field in a struct =
of type `Self`.
> > -    #[inline]
> > -    unsafe fn work_container_of(ptr: *mut Work<T, ID>) -> *mut Self
> > -    where
> > -        Self: Sized,
>
> This bound is required in order to allow the usage of `dyn HasWork` (ie
> object safety), so it should stay.
>
> Maybe add a comment explaining why it's there.

I guess a doctest would be better, but I still don't understand why
the bound is needed. Sorry, can you cite something or explain in more
detail please?

