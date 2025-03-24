Return-Path: <linux-pci+bounces-24589-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BB064A6E61D
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 23:02:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C67591896CEA
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 22:00:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EA91EF0AC;
	Mon, 24 Mar 2025 21:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YRj7Wer/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3BDF1EF099;
	Mon, 24 Mar 2025 21:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853458; cv=none; b=LGmPyr7y5nEbgHuJKUylnXleI5PgdywBYXKZdXqJ0A2Lf1c02aF5mPpBsIgJ4bO6GggptJ1mSTw0Eq+IEwJ7viH+trzEFr6UD+j5pSuTMRnTNFJ93IE/0Bh6ISodiz4Q3C/oXba354jmFk8dwcnALhRvFGoWu/5H/NQDzUlLV6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853458; c=relaxed/simple;
	bh=pKRb70dr43x9wPWwKTSSWo/UZRsGUzjiqqTtZVD4PFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GiWEZ8BnHMSCE+OVRthOc/rIRwBsj8Rn5fQkmgAmliR0m7NB+oNYDEm/Z9gXRKhblHyElqZGa26u24kZ80HoCaxIRZ/TVjNYlhLGI/IfaayZ0Q/cBQz++nOxHAVmvlV3VF3LpZAa0xc2R5LsuFmnB+xDj769/0zQ+g+YiWgWnRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YRj7Wer/; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-30613802a04so50109251fa.2;
        Mon, 24 Mar 2025 14:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742853455; x=1743458255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0SfNWyRv6wOtZRKj/VNT2EZedCYzOFj45hBDFnsaD4s=;
        b=YRj7Wer/Y2qjUFrJVsO/widD+QxedXOeHp8KFmWYEeQFcr4oEbyZQzIVrNePl0DBhF
         qlNYtR32wOHbMq9wedGxM0nmO6lL3LWGzKjEUwtSSwQen8OP2u/CFPyh/AxSzEENQLmO
         Dd8Qur0k/mCD2YNIBjy3vH8bAhKajcXkDIAFM2n9zXK6FtgAQ9+dXSQ4T0xTsp3buJM7
         K4z7qxz7aJ23Uujl6qdIUFAfAN8HoMLjPScLyKzdtDQMtvExj2wGPdMxi4Hc6SFMkZCT
         W8I7c3jPFv69Ccecwnrw2X/iEZpeOL7lF0IYvRikaS73Bm7LeJVQ1m0N5k901ykSPjDz
         ninw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742853455; x=1743458255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0SfNWyRv6wOtZRKj/VNT2EZedCYzOFj45hBDFnsaD4s=;
        b=hu4/34YVHsHJOGr3HeXhqbEH2yKnGix9hGcunUrUv0T3iCs6opHUm6oBuoJ/w3h9zg
         hdzasA7vYz4JnHZ5RJQ9L9t8UCvku+E85gBAG188PuzpsXVAawNTERJpddpnyIpKxpAR
         Au0/1HQgUuwuRsv2K4o6WQKdN94OAuE15pTn6T9nH5FElnq4nHMNh+ps0CoQgs6BBIXG
         O3fEpwA36aF9pzkqxN16H+IaeyhpbFsseMnhPMV/GSL/rjAhFLCb1xRVmKSorJ9UBxfw
         jZ26ZnMxJUo9RKk4+FAqh7qQmQ8fCdQVFOAWDZIhB4yk//HeUBPTPJqMXX9GrkN3vCYC
         jf1g==
X-Forwarded-Encrypted: i=1; AJvYcCUTjzv1zNWk3E8FyhSYdmxFM8iQk0ufXrA3q623Q0+/mWUYN4kh1J7EelFKkb/sNk+2urN+A/ityipuvFGO8kQ=@vger.kernel.org, AJvYcCWfhfw/YEETlXOLSDIL3njrnUFVgdRSJUSLggwwsNV3DBO27NVXltKMLKYpQpH0MI+vzOABoIjf/GGDugk=@vger.kernel.org, AJvYcCXbAm/6ICfLPt245MgiT8Mzrbc+tWpsOOmkZHkVZbAfOt6es/bXo4/7HTpUe8W6U4IskoN8fFzz6SjX@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ1OJF8EcI+pndoij5RK3N/8NVWxSmZop9oTVoA3Os3NNXqeOk
	mOw2il84qmcvJ1QH1NEOlGI0h6le7519CnCS4KnDJXE3NYFZOnsPi2FD86/2UlmC9smkQ4KxIU/
	wntytTHfQHR8WyXqh0FdsSilEQtw=
X-Gm-Gg: ASbGncuPkKyjHgqzYyT0fRNW/3cbZU/LK/w7ZWzxWB0fVFyPN8EaMT6VfH97Ir1D6FN
	ErRNmluRNc5DulgXMm7DJPEnfqIBeCg4L/gij/hilJEPssm2JYHzH6oUMRKp5btRvDP70XrF3vl
	zS7abmJcTbR/QKjPEggWNJvP7UEjXPrCjHw2dVGv61Xg==
X-Google-Smtp-Source: AGHT+IFBKY8tzkN0trR4LhlkefE+xkrgWW5z4428RzkRjJ2CcXjIflHdUNOy4iU/UeWbbTB75EqpETKK1rJvyigyWaw=
X-Received: by 2002:a2e:a78a:0:b0:30c:4610:9e9e with SMTP id
 38308e7fff4ca-30d7e2d9f69mr60140341fa.35.1742853454392; Mon, 24 Mar 2025
 14:57:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324-list-no-offset-v1-0-afd2b7fc442a@gmail.com>
 <20250324-list-no-offset-v1-3-afd2b7fc442a@gmail.com> <67e1d1b3.050a0220.4c4ff.6e89@mx.google.com>
 <CAJ-ks9moCO83cGkKuONR-2JMN61x18T2UVO98jhspDR=uyaVqw@mail.gmail.com>
In-Reply-To: <CAJ-ks9moCO83cGkKuONR-2JMN61x18T2UVO98jhspDR=uyaVqw@mail.gmail.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 24 Mar 2025 17:56:57 -0400
X-Gm-Features: AQ5f1Jol0Xfw-f6lpW_QXLW-4JiZKuAXdwLB6-zK4WZMf__T16uxykikyVaH1n0
Message-ID: <CAJ-ks9kPhb00-Dv8KucYGOVjLFMVYvfpBnqrV87M+eJmODAmyw@mail.gmail.com>
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

On Mon, Mar 24, 2025 at 5:51=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> On Mon, Mar 24, 2025 at 5:42=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com>=
 wrote:
> >
> > On Mon, Mar 24, 2025 at 05:33:45PM -0400, Tamir Duberstein wrote:
> > > Refer to the type parameters of `impl_has_list_links{,_self_ptr}!` by
> > > the same name used in `impl_list_item!`.
> > >
> > > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > > ---
> > >  rust/kernel/list/impl_list_item_mod.rs | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/lis=
t/impl_list_item_mod.rs
> > > index 5ed66fdce953..9d2102138c48 100644
> > > --- a/rust/kernel/list/impl_list_item_mod.rs
> > > +++ b/rust/kernel/list/impl_list_item_mod.rs
> > > @@ -41,7 +41,7 @@ unsafe fn raw_get_list_links(ptr: *mut Self) -> *mu=
t ListLinks<ID> {
> > >  /// Implements the [`HasListLinks`] trait for the given type.
> > >  #[macro_export]
> > >  macro_rules! impl_has_list_links {
> > > -    ($(impl$(<$($implarg:ident),*>)?
> > > +    ($(impl$(<$($generics:ident),*>)?
> > >         HasListLinks$(<$id:tt>)?
> > >         for $self:ty
> > >         { self$(.$field:ident)* }
> > > @@ -51,7 +51,7 @@ macro_rules! impl_has_list_links {
> > >          //
> > >          // The behavior of `raw_get_list_links` is not changed since=
 the `addr_of_mut!` macro is
> > >          // equivalent to the pointer offset operation in the trait d=
efinition.
> > > -        unsafe impl$(<$($implarg),*>)? $crate::list::HasListLinks$(<=
$id>)? for $self {
> > > +        unsafe impl$(<$($generics),*>)? $crate::list::HasListLinks$(=
<$id>)? for $self {
> > >              const OFFSET: usize =3D ::core::mem::offset_of!(Self, $(=
$field).*) as usize;
> > >
> > >              #[inline]
> > > @@ -81,16 +81,16 @@ pub unsafe trait HasSelfPtr<T: ?Sized, const ID: =
u64 =3D 0>
> > >  /// Implements the [`HasListLinks`] and [`HasSelfPtr`] traits for th=
e given type.
> > >  #[macro_export]
> > >  macro_rules! impl_has_list_links_self_ptr {
> > > -    ($(impl$({$($implarg:tt)*})?
> > > +    ($(impl$({$($generics:tt)*})?
> >
> > While you're at it, can you also change this to be
> >
> >         ($(impl$(<$($generics:tt)*>)?
> >
> > ?
> >
> > I don't know why we chose <> for impl_has_list_links, but {} for
> > impl_has_list_links_self_ptr ;-)
>
> This doesn't work in all cases:
>
> error: local ambiguity when calling macro `impl_has_work`: multiple
> parsing options: built-in NTs tt ('generics') or 1 other option.
>    --> ../rust/kernel/workqueue.rs:522:11
>     |
> 522 |     impl<T> HasWork<Self> for ClosureWork<T> { self.work }
>
> The reason that `impl_has_list_links` uses <> and all others use {} is
> that `impl_has_list_links` is the only one that captures the generic
> parameter as an `ident`, the rest use `tt`. So we could change
> `impl_has_list_links` to use {}, but not the other way around.

I've changed it to `{}` so it's consistent everywhere.

