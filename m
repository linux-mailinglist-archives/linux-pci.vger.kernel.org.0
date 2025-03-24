Return-Path: <linux-pci+bounces-24587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B629BA6E5E4
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 22:52:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D861731A9
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 21:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D5E1E1020;
	Mon, 24 Mar 2025 21:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VV/Gzwop"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1233189520;
	Mon, 24 Mar 2025 21:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742853153; cv=none; b=OsvmtDXaudeGyGC3w+eLw8jpDYgzYkde5HVOba2Ur4h5d4ygh/P1gDjlgP4Wfx0viHJPTFk+kuCsu2FEeen+atMfVgi8jtx5W8p1XJt6MLj0JdLFQT5pGWlr11RTClbTrIN90yq0sI/t+Kq0BRJFlPSBbGuAvCeTB3of2yLD4lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742853153; c=relaxed/simple;
	bh=4G5cdSjvIDhKlsnubmBZRR0i/QMpEucOLCvWMn3XspI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WUD9P68g4QcUhcQ5X142Mo9WHy/eruEbK/5agR09xDQM7HjP7eD9/JgLgfGI2F145uSmSwVgcxdcJoz2jkFCe7YhAJaUgt1Jhw2VLzOnK7jt/YcJpbvRPvJueyH0lAH7NiJ4fh3n1Ovj01BfpSb5uRRnaIHVqfPoapzBWeYrbTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VV/Gzwop; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-54957f0c657so5341916e87.0;
        Mon, 24 Mar 2025 14:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742853149; x=1743457949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hi7oLbrzx0axjXLXNmZAcPdwQO4oEE0seNZDHsMRgsE=;
        b=VV/GzwopkZvceX64mG4xLKu8tZn3jdVH05x5LbvznZldl6VaQc6ECqeE1AgY8GWg53
         cGJLVlyef5Aj46+S/atoNc5apZ4aqlm1oKqAuDfG/LgKN+wAqMKWZsZeZ/GEkHEpsnSm
         hDuQOvNfLijK8NhwSanwNUMfqy/g/1PnOm9eYgVAsIP00sDpkvOnBs4EWX3Gb5VXorp3
         gt53BrelAPuKqrmF9fKT+gdPkWi1KZQW8LHl352ULuuY7yaM6u1Es/0kchm0H51PJrzT
         /4oNhE83fULOrHoAHtANGt+WpeBNOGBw1aiMNwEWIpo9AU4AIf2SKPdPh8EPODadd6yg
         lz0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742853149; x=1743457949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hi7oLbrzx0axjXLXNmZAcPdwQO4oEE0seNZDHsMRgsE=;
        b=IFdeKGC3Wc+tloUvudcD1Ug7WTcV1Q/a9pVhVT7zqjtQBZKPaewy8rO/7A4TzRK4zj
         wUoFoStzNAN1R7FktL0f86uS/3+9ASEUcM2Gc1mUEMOLNUj/BbWEyzvTSp1R0CIacifE
         v75JMS3eu2QJGdG6P8PEYhEZnyUGfwYAvAj52Z+2jthl+E+68qscgFRSuWPK8aBG20/w
         5hQ0kjZsac4xLgYo6lZnmALXIa4rOpEEtLgskrQyPPXXN8iVycY/9NTaJeGEEojOx8Jn
         vQnLPqC15Ir8uV6PzWE5Z58pWEQALoZUWYF9pXswfXvNiy//67QEI000jWpgP8pBg289
         fKnQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn1EDgB4/p+V25yWNKPl34T4enmbuQiZj/0p4Nyc+R5Vd0DT6kiR+va+5jyfviwJPSP44meZvH87451B4=@vger.kernel.org, AJvYcCXQjqbh3gGlNu89D72QQ4SVpS6arcnhUb1WYdaVRNKkwL7HUk22Xz+vHP+Y9XqR6xqXmfb4zwBK62np@vger.kernel.org, AJvYcCXuzwoZ115dsXpQKGREb0PwEBAhyuZ/Uly2zaMS1z0z6HaoNbbzMf4NvCEIptIMwix9W4gCledyH8VbQS1mDYc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw13LC7bHM8+ur9Y4dCTl+nBpau4vJWGRs/1YDMwpunBg0nAnAv
	3338VzzQaCiUYurG2EUdTQXr9lRBP7H1nJCXj+6rXQ5IwcUS9gVBqoQBFTaZGWxEKN48gkhmLX3
	hkiDfG6EvsnErHSscotqS34Givpc=
X-Gm-Gg: ASbGncsi8PAsd5c9O6r8ldbCGjXvcdVNQafMzn04xtou8ePn/5sL0yuXqswMUeLtOZX
	a2BdcU9cUGWmIAi2EHuDgSes/DlixzJByMlY4c0uHDH3vVm/SDmdcPTca8EmnIkH47l24HoZDxD
	qpO1BA6+YYseehTMID3/p/umudrnZQeBfVNFzrCzSH17d2HkWlpDPt
X-Google-Smtp-Source: AGHT+IFfbzffhAYw6XgIVFxmv97+3+pe7ZzJmLOgvEDoEWD10xg/q3188/CXjZdfuO4sx8p7WVXe+43fO2uoRXzKAvU=
X-Received: by 2002:a05:6512:3da2:b0:549:8d2f:86dd with SMTP id
 2adb3069b0e04-54acfadce20mr7020416e87.20.1742853148610; Mon, 24 Mar 2025
 14:52:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324-list-no-offset-v1-0-afd2b7fc442a@gmail.com>
 <20250324-list-no-offset-v1-3-afd2b7fc442a@gmail.com> <67e1d1b3.050a0220.4c4ff.6e89@mx.google.com>
In-Reply-To: <67e1d1b3.050a0220.4c4ff.6e89@mx.google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 24 Mar 2025 17:51:52 -0400
X-Gm-Features: AQ5f1Jrt4TQ_aGI0lZVlK-RtEYp_A7xq6Dy0p9NZxCKDZ_-J32dAk9oGNHKtBK4
Message-ID: <CAJ-ks9moCO83cGkKuONR-2JMN61x18T2UVO98jhspDR=uyaVqw@mail.gmail.com>
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

On Mon, Mar 24, 2025 at 5:42=E2=80=AFPM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Mon, Mar 24, 2025 at 05:33:45PM -0400, Tamir Duberstein wrote:
> > Refer to the type parameters of `impl_has_list_links{,_self_ptr}!` by
> > the same name used in `impl_list_item!`.
> >
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  rust/kernel/list/impl_list_item_mod.rs | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/rust/kernel/list/impl_list_item_mod.rs b/rust/kernel/list/=
impl_list_item_mod.rs
> > index 5ed66fdce953..9d2102138c48 100644
> > --- a/rust/kernel/list/impl_list_item_mod.rs
> > +++ b/rust/kernel/list/impl_list_item_mod.rs
> > @@ -41,7 +41,7 @@ unsafe fn raw_get_list_links(ptr: *mut Self) -> *mut =
ListLinks<ID> {
> >  /// Implements the [`HasListLinks`] trait for the given type.
> >  #[macro_export]
> >  macro_rules! impl_has_list_links {
> > -    ($(impl$(<$($implarg:ident),*>)?
> > +    ($(impl$(<$($generics:ident),*>)?
> >         HasListLinks$(<$id:tt>)?
> >         for $self:ty
> >         { self$(.$field:ident)* }
> > @@ -51,7 +51,7 @@ macro_rules! impl_has_list_links {
> >          //
> >          // The behavior of `raw_get_list_links` is not changed since t=
he `addr_of_mut!` macro is
> >          // equivalent to the pointer offset operation in the trait def=
inition.
> > -        unsafe impl$(<$($implarg),*>)? $crate::list::HasListLinks$(<$i=
d>)? for $self {
> > +        unsafe impl$(<$($generics),*>)? $crate::list::HasListLinks$(<$=
id>)? for $self {
> >              const OFFSET: usize =3D ::core::mem::offset_of!(Self, $($f=
ield).*) as usize;
> >
> >              #[inline]
> > @@ -81,16 +81,16 @@ pub unsafe trait HasSelfPtr<T: ?Sized, const ID: u6=
4 =3D 0>
> >  /// Implements the [`HasListLinks`] and [`HasSelfPtr`] traits for the =
given type.
> >  #[macro_export]
> >  macro_rules! impl_has_list_links_self_ptr {
> > -    ($(impl$({$($implarg:tt)*})?
> > +    ($(impl$({$($generics:tt)*})?
>
> While you're at it, can you also change this to be
>
>         ($(impl$(<$($generics:tt)*>)?
>
> ?
>
> I don't know why we chose <> for impl_has_list_links, but {} for
> impl_has_list_links_self_ptr ;-)

This doesn't work in all cases:

error: local ambiguity when calling macro `impl_has_work`: multiple
parsing options: built-in NTs tt ('generics') or 1 other option.
   --> ../rust/kernel/workqueue.rs:522:11
    |
522 |     impl<T> HasWork<Self> for ClosureWork<T> { self.work }

The reason that `impl_has_list_links` uses <> and all others use {} is
that `impl_has_list_links` is the only one that captures the generic
parameter as an `ident`, the rest use `tt`. So we could change
`impl_has_list_links` to use {}, but not the other way around.

