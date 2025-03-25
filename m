Return-Path: <linux-pci+bounces-24669-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF3FA70272
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 14:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB9517F394
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 13:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91529502BE;
	Tue, 25 Mar 2025 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZqTxAPOX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52D61C27;
	Tue, 25 Mar 2025 13:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909989; cv=none; b=ZfhCgBGwhxCWoaS2Mr7ScNJG55F9mdjbU1XWobz5NNXy5tO2bPUO6vAX2UlwePkGtqsBMwTMkQeotk3Z2cqvmkjiBJ5rgEQp2KEsRl+PC3JsMn/FZUh5pEr+ybv4blOjmR5npoQ4+BrmNX1HoXpaN82CZqOmHT0QsXEZY/0C0oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909989; c=relaxed/simple;
	bh=dVSxouOXZHtGWTtiyOJabZwsvfWCpDzgJrprCLF6xus=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=teaBykX4PYKWUEX2m3OG4MiNSxCgmJNhsn4ov2kMpg7M0i3/4GNb51r+YH8EQ9dG09O+h10la6yhj4mOXpa7OY3kFiA6H/ZQwOE3Fm0gw73BFwCaSd/BsqwgJM6CDO4sibYhoigX2BlSnOWGtuK9ZpodunaZ0UKko0K4/Ir/wL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZqTxAPOX; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-30b83290b7bso56363651fa.1;
        Tue, 25 Mar 2025 06:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742909985; x=1743514785; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myPV0T66Hh2V3wozAvJIfoZDXZ6qFR3qJHf4P3jl/Gc=;
        b=ZqTxAPOXkPjJDfKTjJtckTFtNz6qxzOHwlbtmu00BQJoeS7vIIyb8Rv8AXI7g793Dg
         32HsXVoga2SQLAyiOxEoGeSlXpOoQW0pqINSrU+G4JtgX0xAjegc3tIdaYKbqw92bvzi
         t5fcGc0XGifEYxhewue3/M8puO12oz3+qlWhnQLF37XmetBXVod9JKzPSqylcVJuIqMl
         4wfVZh7D80JFXTqLqpYUWt8E3TR/0fW3pAytnGkD8lSQRJ0U/+cWkkulXwDuDpzrDA8J
         757yVAB4i6xEoP4NdzUqPSI1Er0KjPFkKu0POyFMR5R2v8moXjuzkX1yQMWvU5TxCtca
         4PRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742909985; x=1743514785;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=myPV0T66Hh2V3wozAvJIfoZDXZ6qFR3qJHf4P3jl/Gc=;
        b=aFo5EEh8Ax67mHles3Chb8YlbSJF5yLyvLLMsLMbmEtM/1qWDs8okANWB2+LvFtWxg
         kQyfTWP4VajUTff0h4PKau1z5V+sW4sDDp8vrD02HhgOpTDgwiPuoqVew0TuI24+ktKc
         dsANLckkhFIS/ZL728STOcdEw4YJhSetewu/BWv3SelcCtr8tfoiPTsTBEkZwsJ+ZTIb
         l5+B17mJd0VKoj/JZ/DT0kdXcycJKvQSGVCIpBGpvlmBJJ+4jD7fdncHZDgxxxfqL7cj
         GSGbyDhuzFVWBvqxkAvzkktoYQ9vdXTR5IxQt8+gun+Ie25uAIVUCZ+Ixhgs1NKKqVUR
         aE9A==
X-Forwarded-Encrypted: i=1; AJvYcCU5YkGxVqMNFwxEAeUkl/gvPttVxFWjkFMFk6MXo5i1vo5eMw0L4v1Q7K3xZpCfz8jwqIGu+DlshODERI8=@vger.kernel.org, AJvYcCVVhf3gVWtRD9dIXkaR9MFjSVmuwIuXzdioA9AbhHew7fYqa+BeYaPO9WKXX6qb4cvj3cOwz3GMtiXG@vger.kernel.org, AJvYcCWqgzPvdS+mnye5tVd1aaUdJ01Enwa9LfMCdbLX9re/P99AaXedqxPo7WF+gS5cPiOO4bp5BW447nLs+QDBJXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YweOacOdddgMT18pyPC0+mLnpAMdCbyNAdWdR1bbqHFC3IELK58
	bwArZvGdvVphBYVsTYr7ir0vyPAUwbL1tgq6YiUi9iX/3cePyTS4w60vb7YHnsKs8BwOngjuXOf
	/M2DO3woWqJu+/yqIyps1EJswUeo=
X-Gm-Gg: ASbGncvCEzxtiEUXQliqv4XPHdnFVcvNf9TN3ptBY1zzQJTDIJumL2UbU0/mYiI3wEI
	tm0/Un7jbaEF0xu9671ao8EdMiio9PlgP4dJSAAAaxu/oh+SGHM3IBmuAUDvkEh67BVp1epKgGw
	KEdzAqGWhK18o4oY4i285LFBya06J19wWJxyID+/X0Vg==
X-Google-Smtp-Source: AGHT+IGQKAXzEbYQwBhfNVo++jVfEu/zBZKZscu6KAG+LuY8INULRXFdRoAY3KbwyRZznozPQ8msRy9zM8JTWfjea6o=
X-Received: by 2002:a2e:a78a:0:b0:30c:7a7:e87c with SMTP id
 38308e7fff4ca-30d7e32e8eemr72008461fa.35.1742909985355; Tue, 25 Mar 2025
 06:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324-list-no-offset-v1-0-afd2b7fc442a@gmail.com>
 <20250324-list-no-offset-v1-3-afd2b7fc442a@gmail.com> <67e1d1b3.050a0220.4c4ff.6e89@mx.google.com>
 <CAJ-ks9moCO83cGkKuONR-2JMN61x18T2UVO98jhspDR=uyaVqw@mail.gmail.com>
 <CAJ-ks9kPhb00-Dv8KucYGOVjLFMVYvfpBnqrV87M+eJmODAmyw@mail.gmail.com>
 <Z-Iq6Okk1j3ImH1u@Mac.home> <CAJ-ks9n66_vVg3ww58VqfXV6+phng8Bhq9C=NNn854gXK0KAHg@mail.gmail.com>
 <D8PA5CKNMCGA.UODS331S36EG@proton.me> <CAJ-ks9kOFk2GGwjX_Eo7Kuxoh5eziGSKRpLE8oVjEs7pRnWyRw@mail.gmail.com>
 <D8PB0LN62GOX.3P4K4V96OLVQ9@proton.me>
In-Reply-To: <D8PB0LN62GOX.3P4K4V96OLVQ9@proton.me>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 25 Mar 2025 09:39:09 -0400
X-Gm-Features: AQ5f1JpqoNfVeezWzd4_2GOPTgYYN2XUtv5DasiBOJhEEhrX8nf_xe86DllRAjI
Message-ID: <CAJ-ks9mEWshCkpq8=7=MKVDz8N-aUVSj0w-YdCsEvEhH3U7h_g@mail.gmail.com>
Subject: Re: [PATCH 3/5] rust: list: use consistent type parameter names
To: Benno Lossin <benno.lossin@proton.me>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 7:18=E2=80=AFAM Benno Lossin <benno.lossin@proton.m=
e> wrote:
>
> On Tue Mar 25, 2025 at 11:42 AM CET, Tamir Duberstein wrote:
> > On Tue, Mar 25, 2025 at 6:37=E2=80=AFAM Benno Lossin <benno.lossin@prot=
on.me> wrote:
> >> On Tue Mar 25, 2025 at 10:52 AM CET, Tamir Duberstein wrote:
> >> > On Tue, Mar 25, 2025 at 12:02=E2=80=AFAM Boqun Feng <boqun.feng@gmai=
l.com> wrote:
> >> >> On Mon, Mar 24, 2025 at 05:56:57PM -0400, Tamir Duberstein wrote:
> >> >> > On Mon, Mar 24, 2025 at 5:51=E2=80=AFPM Tamir Duberstein <tamird@=
gmail.com> wrote:
> >> >> > > On Mon, Mar 24, 2025 at 5:42=E2=80=AFPM Boqun Feng <boqun.feng@=
gmail.com> wrote:
> >> >> > > > On Mon, Mar 24, 2025 at 05:33:45PM -0400, Tamir Duberstein wr=
ote:
> >> >> > > > >              #[inline]
> >> >> > > > > @@ -81,16 +81,16 @@ pub unsafe trait HasSelfPtr<T: ?Sized, =
const ID: u64 =3D 0>
> >> >> > > > >  /// Implements the [`HasListLinks`] and [`HasSelfPtr`] tra=
its for the given type.
> >> >> > > > >  #[macro_export]
> >> >> > > > >  macro_rules! impl_has_list_links_self_ptr {
> >> >> > > > > -    ($(impl$({$($implarg:tt)*})?
> >> >> > > > > +    ($(impl$({$($generics:tt)*})?
> >> >> > > >
> >> >> > > > While you're at it, can you also change this to be
> >> >> > > >
> >> >> > > >         ($(impl$(<$($generics:tt)*>)?
> >> >> > > >
> >> >> > > > ?
> >> >> > > >
> >> >> > > > I don't know why we chose <> for impl_has_list_links, but {} =
for
> >> >> > > > impl_has_list_links_self_ptr ;-)
> >> >> > >
> >> >> > > This doesn't work in all cases:
> >> >> > >
> >> >> > > error: local ambiguity when calling macro `impl_has_work`: mult=
iple
> >> >> > > parsing options: built-in NTs tt ('generics') or 1 other option=
.
> >> >> > >    --> ../rust/kernel/workqueue.rs:522:11
> >> >> > >     |
> >> >> > > 522 |     impl<T> HasWork<Self> for ClosureWork<T> { self.work =
}
> >> >> > >
> >> >> > > The reason that `impl_has_list_links` uses <> and all others us=
e {} is
> >> >> > > that `impl_has_list_links` is the only one that captures the ge=
neric
> >> >> > > parameter as an `ident`, the rest use `tt`. So we could change
> >> >>
> >> >> Why impl_has_list_links uses generics at `ident` but rest use `tt`?=
 I'm
> >> >> a bit curious.
> >> >
> >> > I think it's because `ident` cannot deal with lifetimes or const
> >> > generics - or at least I was not able to make it work with them.
> >>
> >> If you use `ident`, you can use the normal `<>` as the delimiters of
> >> generics. For `tt`, you have to use `{}` (or `()`/`[]`).
> >
> > Yes I know. But with `ident` you cannot capture lifetimes or const gene=
rics.
>
> Why is that required for this macro? I think we could use `tt`.

We're in violent agreement. The change I've made is to use `tt`
everywhere, including where `ident` is currently used with `<>`.

