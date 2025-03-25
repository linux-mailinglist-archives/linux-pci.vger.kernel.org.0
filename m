Return-Path: <linux-pci+bounces-24635-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910F6A6ED16
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 10:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9077B3A7D03
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 09:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E13204686;
	Tue, 25 Mar 2025 09:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDVrOTBE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355DE19CC2E;
	Tue, 25 Mar 2025 09:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742896381; cv=none; b=HsXQTuI5hKa/i6Y2LyYFUeyP8doIPM2BWiAwhllCpmpGlQnbQEXrzZb7FgbefZFSLeBFzz20XYWiVXTWQ9NXOg4NTdnTG+5qjYTl1VSe2bJIhZcmp5+g1j/w8Jd6Po1qM+Dot3nzvAYNP7hJnjqYPAfzeEjYVdknp45ilQ17m4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742896381; c=relaxed/simple;
	bh=G7dq4opATscHa1GwAcwYDZ/9MxMZNOO+pOreXVSwxLo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q6GuVOxd2rsUQkpL79kyLxP8CEOiobYRBWol79LQetYylMaB46rMXB//gmuxEXovOBYKTAHWepJqhyQSpU5ZAyJUvrI42S9XlUej1iUOoWvfjyTQa9t+rLMX8u1TAwEhKJ1FXR5MRiPsqHOJnsxpGOV1dLK2Xft86DdY1o6aVOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDVrOTBE; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30bf7d0c15eso54205691fa.0;
        Tue, 25 Mar 2025 02:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742896377; x=1743501177; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SDAsr7EomDTz5Y8FEYcT8NLpoB17+E7CJw8BsOZA9s=;
        b=QDVrOTBEAyNdO3PmDFipWP/TyXte4Bl3DchugqbCaU0XKzgVjStMkeDcjzEr9wvMwg
         RE3Ses8SjkOCjIWJ9qsOf0sWD12RzvMeV2wYKirN4dFUU67KZHJOqJYsrH1hXbhPdPF4
         a9RHtbajvzRx0brTxf4XUipz++353Iks8sD4vsra/vbqtpa5uiM5s7BXc/DVpvK+/3t4
         GCOgj3xzBXiobJRiASbCIOiiCUd9SHA3FZm8t6hBQQ71pYNYc0ZsboM4b2KUQGACcoyo
         Glw5Hy3dYn9fS2IV4kI77YiT+KJHt317gJ7FlR00t4sl21rRpcXbkIEHLJ1ErRAFlq7h
         Htew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742896377; x=1743501177;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0SDAsr7EomDTz5Y8FEYcT8NLpoB17+E7CJw8BsOZA9s=;
        b=hJHUu5sHNTXEaUsk0XbjTRP5PlH8JhkKugkzaT4DXqBRiEkWzmuToaXBtZxACZg4Pa
         3qlBSG9dSWEP4Qxqz8NugfFJn285MaLQ6eEOC0yIitCvlKKoxjjFnVbf8rJ3CBRFo7U0
         VjLLYsf6AVV4AY2VwllKv2pHVch4huXkahbIo6vOVkC9eQJqk7xjVtdEFRgYJ4n0fh+G
         YULBoXYg1A7yJ5jj0nfUu2Cgu00GUpK6rZzPQZ9M36ITdfTopucwcTYY0UAvmEWFfjvl
         m/jcUWvJpOCHnRYu3HgOJhwTL/cysx0LjYd17Pgry5XNFkCXJkedf+c1hQM6E9cTz7R2
         wjuA==
X-Forwarded-Encrypted: i=1; AJvYcCVIj/BWiENi1lkCtE/K9RW9KfHupl/buZU3LNienMwPpfnoPa/+TBMKkQbtRIpbyWYZqcH54R/Al/OcyDE=@vger.kernel.org, AJvYcCWBISOpyWIIDnkj/vF/HuNjdYEIlla+T1aQcBtV7CeFgMmvaE2qZYZTXA872sTnRMVO+cl+NjWRuom4@vger.kernel.org, AJvYcCXj9R2NYkwZ+jH9hDD4Qwf5ntiEXqRs5BqEZ5pH0H2bGWR40Ho5Q2d1sjR5zLvfAWj+OxW4cbDf2FXlQ4B9YTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR7oI4pbWrOl0ZrSr1ff6lTrT5/9MoTuF4ARHa+0Ti5gPlfOD9
	PcFgF/NtkQCsekThPu0XYGGcABYv+eb32cD5QgD/+af/sShLp79pP15dBH8F6FUl6XQshoc33kh
	gVo5vq7F57djhF9QcJzk3Z90HMys=
X-Gm-Gg: ASbGncvlwTOmNJcJu3exmk/ELUU/Y2geoNzNSIfSqeOXgLtPSeRZPjvUpCi9DbH7nzk
	gEdoWhN3EruobKnzLXScC+qdXY85QOLOgw0kD4UzRgkLwtFuIEadgihOi7bxNejJ4/Adg17/LyU
	5eHthHFjKFb6RFjvFOwYQTRzs5Mc+JsaGYSwlvhDPKykxm7QkW0e0urUi0tYA=
X-Google-Smtp-Source: AGHT+IFl+A+Ba20JPX9FmogbjoD7hGniVYN8d0KWTnxk/lLm/Lu/HBymNbtUAkDiT5NORHcz7MGSZqNNo3xaEtNJgzc=
X-Received: by 2002:a2e:7817:0:b0:30b:fca2:6ac1 with SMTP id
 38308e7fff4ca-30d7e23c2aemr55848501fa.22.1742896376916; Tue, 25 Mar 2025
 02:52:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324-list-no-offset-v1-0-afd2b7fc442a@gmail.com>
 <20250324-list-no-offset-v1-3-afd2b7fc442a@gmail.com> <67e1d1b3.050a0220.4c4ff.6e89@mx.google.com>
 <CAJ-ks9moCO83cGkKuONR-2JMN61x18T2UVO98jhspDR=uyaVqw@mail.gmail.com>
 <CAJ-ks9kPhb00-Dv8KucYGOVjLFMVYvfpBnqrV87M+eJmODAmyw@mail.gmail.com> <Z-Iq6Okk1j3ImH1u@Mac.home>
In-Reply-To: <Z-Iq6Okk1j3ImH1u@Mac.home>
From: Tamir Duberstein <tamird@gmail.com>
Date: Tue, 25 Mar 2025 05:52:20 -0400
X-Gm-Features: AQ5f1JrtiJucZ4hs_wMZ1sKyb5AnOZiV8hIMZ0BUk72C9G6LuNd267LkKeV2Nu0
Message-ID: <CAJ-ks9n66_vVg3ww58VqfXV6+phng8Bhq9C=NNn854gXK0KAHg@mail.gmail.com>
Subject: Re: [PATCH 3/5] rust: list: use consistent type parameter names
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 12:02=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> =
wrote:
>
> On Mon, Mar 24, 2025 at 05:56:57PM -0400, Tamir Duberstein wrote:
> > On Mon, Mar 24, 2025 at 5:51=E2=80=AFPM Tamir Duberstein <tamird@gmail.=
com> wrote:
> > >
> > > On Mon, Mar 24, 2025 at 5:42=E2=80=AFPM Boqun Feng <boqun.feng@gmail.=
com> wrote:
> > > >
> > > > On Mon, Mar 24, 2025 at 05:33:45PM -0400, Tamir Duberstein wrote:
> > > > > Refer to the type parameters of `impl_has_list_links{,_self_ptr}!=
` by
> > > > > the same name used in `impl_list_item!`.
> > > > >
> > > > > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > > > > ---
> > > > >  rust/kernel/list/impl_list_item_mod.rs | 10 +++++-----
> > > > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > > > >
> > > > > diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel=
/list/impl_list_item_mod.rs
> > > > > index 5ed66fdce953..9d2102138c48 100644
> > > > > --- a/rust/kernel/list/impl_list_item_mod.rs
> > > > > +++ b/rust/kernel/list/impl_list_item_mod.rs
> > > > > @@ -41,7 +41,7 @@ unsafe fn raw_get_list_links(ptr: *mut Self) ->=
 *mut ListLinks<ID> {
> > > > >  /// Implements the [`HasListLinks`] trait for the given type.
> > > > >  #[macro_export]
> > > > >  macro_rules! impl_has_list_links {
> > > > > -    ($(impl$(<$($implarg:ident),*>)?
> > > > > +    ($(impl$(<$($generics:ident),*>)?
> > > > >         HasListLinks$(<$id:tt>)?
> > > > >         for $self:ty
> > > > >         { self$(.$field:ident)* }
> > > > > @@ -51,7 +51,7 @@ macro_rules! impl_has_list_links {
> > > > >          //
> > > > >          // The behavior of `raw_get_list_links` is not changed s=
ince the `addr_of_mut!` macro is
> > > > >          // equivalent to the pointer offset operation in the tra=
it definition.
> > > > > -        unsafe impl$(<$($implarg),*>)? $crate::list::HasListLink=
s$(<$id>)? for $self {
> > > > > +        unsafe impl$(<$($generics),*>)? $crate::list::HasListLin=
ks$(<$id>)? for $self {
> > > > >              const OFFSET: usize =3D ::core::mem::offset_of!(Self=
, $($field).*) as usize;
> > > > >
> > > > >              #[inline]
> > > > > @@ -81,16 +81,16 @@ pub unsafe trait HasSelfPtr<T: ?Sized, const =
ID: u64 =3D 0>
> > > > >  /// Implements the [`HasListLinks`] and [`HasSelfPtr`] traits fo=
r the given type.
> > > > >  #[macro_export]
> > > > >  macro_rules! impl_has_list_links_self_ptr {
> > > > > -    ($(impl$({$($implarg:tt)*})?
> > > > > +    ($(impl$({$($generics:tt)*})?
> > > >
> > > > While you're at it, can you also change this to be
> > > >
> > > >         ($(impl$(<$($generics:tt)*>)?
> > > >
> > > > ?
> > > >
> > > > I don't know why we chose <> for impl_has_list_links, but {} for
> > > > impl_has_list_links_self_ptr ;-)
> > >
> > > This doesn't work in all cases:
> > >
> > > error: local ambiguity when calling macro `impl_has_work`: multiple
> > > parsing options: built-in NTs tt ('generics') or 1 other option.
> > >    --> ../rust/kernel/workqueue.rs:522:11
> > >     |
> > > 522 |     impl<T> HasWork<Self> for ClosureWork<T> { self.work }
> > >
> > > The reason that `impl_has_list_links` uses <> and all others use {} i=
s
> > > that `impl_has_list_links` is the only one that captures the generic
> > > parameter as an `ident`, the rest use `tt`. So we could change
>
> Why impl_has_list_links uses generics at `ident` but rest use `tt`? I'm
> a bit curious.

I think it's because `ident` cannot deal with lifetimes or const
generics - or at least I was not able to make it work with them.

