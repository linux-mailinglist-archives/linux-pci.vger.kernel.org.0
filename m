Return-Path: <linux-pci+bounces-23890-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B2CA635B5
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 13:56:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34B4C3ADC1F
	for <lists+linux-pci@lfdr.de>; Sun, 16 Mar 2025 12:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 614BB1A3166;
	Sun, 16 Mar 2025 12:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="igbKnT9h"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB9B86348;
	Sun, 16 Mar 2025 12:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742129775; cv=none; b=mwhROgauEj3JC9MApI2EBsg2jy/FyqBVeUyfHtX6CUrzra8eG2uCKt2ikV4VzmCKn1Rj+2qCt8gQ1FPTO07+sM6AI7yb2yxkgFKEsQQr70RlsBLDSN6gGk1U2m5n4ZPjaYgiTud0BLZyMjEcZgmZj2j0inPAOP+v7Wo2Cqm/q3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742129775; c=relaxed/simple;
	bh=Ocn/uO+vY59KpMjH6hgrdCnzTaj9S3SKMOhRLOHNbcs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INnv3b4EzLknQ7fa8eWHEuPuuERtYKBqdAMrRcxlUOz7kOw66B0t/FJOeX39bAgwV1/gELgqHboMHeYmocQhUeG/ibKhIrbTt6KjMRfb2axVAO2sfIqIN6noWzuS1QBWw8li2aA45pPwtJ+iouakt2o1PgTYV2wd0QgAT25WBT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=igbKnT9h; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-30bf5d7d107so32007171fa.2;
        Sun, 16 Mar 2025 05:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742129772; x=1742734572; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GPg9r87IObi4Gw9NiE4FiHXsXbdtNEYE0P7vTB1dDPU=;
        b=igbKnT9hX2+U0dlwsIeMpHZla6GA1Gy32ZC8tlp+WYKZV/thSyxGo0hXqg5ap9B1hr
         JeG742r4Z2xCzyTnpByXR0WOYUhrqxeU1Wb8/MoqREOzWQSEVlfxpbLnWMInoNtcS6RR
         k5D2Zrg8cogaZya7y1bDfC1xj41UaoSsRBJ2/J1cymYmmYaqbRGgBfyOdgEu2TRCXWCP
         YtRoPSQzQD9oxVDaC7d5v5O45ojy/3WBPrWq1IwWYG1rDXXSHhkLnm/ATpHSPgNVFv8S
         JnABn4FF50MNwrLgLpMo7E+uSu6c0Z+cfo1wwNeyaP/8rPD7/W3VRfjxX0Az3kXaZamy
         eYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742129772; x=1742734572;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GPg9r87IObi4Gw9NiE4FiHXsXbdtNEYE0P7vTB1dDPU=;
        b=tUwk1fdGnv/dDfFeC9Vf8t2ZmnHPW9guYsk/VAgUw+nZVkoFvL9oddTA22Lfs9BP/G
         +h83mN5sVbCEPM2xmn3n8afrp4+P16Mdg5ctymSi0fZMN/bG69umJKeoqb+3gbb4B3oX
         wfZnCrx3ri9SwcH2BZS2G/WaX5Zz3Q+QIE9KYlio7UsuxRGMQf8lDCb/DsGmpxYYebdN
         VqszwHBb/shz5t2q8ITM6nprh2c7hYMvSQGmxS1JYWto2yqidjwhORrTTs3l6axYE6h8
         ahp0XJDkjKnqtY0hdDESYL0mwLOUbaMXPRNMgf9IRFJYlevl4J/BAASMxMu3DTgQ1tN1
         2C8w==
X-Forwarded-Encrypted: i=1; AJvYcCV95thpiEztVWblOBGQm/DKIB4PqYvZhnTbtHe9L36b7589kcubb0D4mnbOpnBjByu9FgL9dQGMYX5+2GuPLTk=@vger.kernel.org, AJvYcCVB/E8ZwUbgEJ1ul0L0gIJTQZRAXnC0xaYTpA9TEQ6BvDBuGd+HkWexmhlS+MpY3qCHHYZaQmY3u/sPUvs=@vger.kernel.org, AJvYcCXC/EZyM1FDAjtihw/bzlAxSR71JtB7ZNsBkfYfb9prIeluVVWJMU81tv5M0/yyo3XqkvP6G3cLPpPx@vger.kernel.org
X-Gm-Message-State: AOJu0YyLk+2mrqt51IEOZekltXxDbHStFNJmdgWbTNKw+T8awp+dYvET
	AOzyX7M7p70O9w3qdZu8F0nD+WozJ7aBHAaoXq5IQVdRykrTgCu0MtGQmS2oUaQ3y9iDBzrn/nA
	hcuWToEgcx8FQmzFUjpK0IVy3D+0=
X-Gm-Gg: ASbGncvRURwHJ9Jfayev8t3ZgkqjUAN+5QUt07NDOQSTAuUFLxfDQUFus/lPQ8Bsotl
	JQiYp5j40jtvLPbrOmkalSfVlAiobs7tEbitJOU0Ou6hu+bb3tI9XtMd6FEbI822LMyK4LHW/2g
	COJx3eg5QYk7w+GVaE+iaU3B6qpsf/5a+1xnmBL5jjm3wv5w9zoeM30jpD8Qg1
X-Google-Smtp-Source: AGHT+IEB3g08YBO1dOwWq8G46PScJgDK7E3EVe9dpwLMBuAuKq+vznF1myPizfVxPDKZPdBnPZmp0M/d2N+YxfF3wnY=
X-Received: by 2002:a05:651c:546:b0:30b:f0fd:fd19 with SMTP id
 38308e7fff4ca-30c4a861114mr39796821fa.16.1742129771448; Sun, 16 Mar 2025
 05:56:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-no-offset-v1-0-0c728f63b69c@gmail.com>
 <20250307-no-offset-v1-2-0c728f63b69c@gmail.com> <D8G8DV3PX8VX.2WHSM0TWH8JWV@proton.me>
 <CAJ-ks9m2ZHguB9N9-WM0EsO5MjaZ9yRamo_9NytAdzaDdb9aWQ@mail.gmail.com>
 <D8GQGCVTK0IL.16YO67C0IKLHA@proton.me> <CAJ-ks9mUPkP=QDGekbi1PRfpKKigXj87-_a25JBGHVRSiEe_AA@mail.gmail.com>
 <D8H1FFDMNLR3.STRVYQI7J496@proton.me> <CAJ-ks9m-ab9Y5RD01higxZxbowZi_0tsSmCCw2umJLxBLH4dEw@mail.gmail.com>
In-Reply-To: <CAJ-ks9m-ab9Y5RD01higxZxbowZi_0tsSmCCw2umJLxBLH4dEw@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Sun, 16 Mar 2025 08:55:34 -0400
X-Gm-Features: AQ5f1JoYTWUUcHlAnq9Hz70y1Kp2Aem-XOTMMmjvLaf6Tt2bXOviM7q7OFZq_ZM
Message-ID: <CAJ-ks9=AKR+LUMBjLNrC9NZst9+18Q3HTrWn4q+baz87BbG6Rw@mail.gmail.com>
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

On Sat, Mar 15, 2025 at 2:12=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> On Sat, Mar 15, 2025 at 2:06=E2=80=AFPM Benno Lossin <benno.lossin@proton=
.me> wrote:
> >
> > On Sat Mar 15, 2025 at 4:37 PM CET, Tamir Duberstein wrote:
> > > On Sat, Mar 15, 2025 at 5:30=E2=80=AFAM Benno Lossin <benno.lossin@pr=
oton.me> wrote:
> > >>
> > >> On Fri Mar 14, 2025 at 9:44 PM CET, Tamir Duberstein wrote:
> > >> > On Fri, Mar 14, 2025 at 3:20=E2=80=AFPM Benno Lossin <benno.lossin=
@proton.me> wrote:
> > >> >>
> > >> >> On Fri Mar 7, 2025 at 10:58 PM CET, Tamir Duberstein wrote:
> > >> >> >      /// Returns a pointer to the struct containing the [`Work<=
T, ID>`] field.
> > >> >> >      ///
> > >> >> >      /// # Safety
> > >> >> >      ///
> > >> >> >      /// The pointer must point at a [`Work<T, ID>`] field in a=
 struct of type `Self`.
> > >> >> > -    #[inline]
> > >> >> > -    unsafe fn work_container_of(ptr: *mut Work<T, ID>) -> *mut=
 Self
> > >> >> > -    where
> > >> >> > -        Self: Sized,
> > >> >>
> > >> >> This bound is required in order to allow the usage of `dyn HasWor=
k` (ie
> > >> >> object safety), so it should stay.
> > >> >>
> > >> >> Maybe add a comment explaining why it's there.
> > >> >
> > >> > I guess a doctest would be better, but I still don't understand wh=
y
> > >> > the bound is needed. Sorry, can you cite something or explain in m=
ore
> > >> > detail please?
> > >>
> > >> Here is a link: https://doc.rust-lang.org/reference/items/traits.htm=
l#dyn-compatibility
> > >>
> > >> But I realized that the trait wasn't object safe to begin with due t=
o
> > >> the `OFFSET` associated constant. So I'm not sure we need this. Alic=
e,
> > >> do you need `dyn HasWork`?
> > >
> > > I wrote a simple test:
> >
> > [...]
> >
> > > so I don't think adding the Sized bound makes sense - we'd end up
> > > adding it on every item in the trait.
> >
> > Yeah the `Sized` bound was probably to make the cast work, so let's
> > remove it.
>
> It's already removed, right?

Ping. Can you help me understand what change, if any, you think is required=
?

