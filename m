Return-Path: <linux-pci+bounces-24652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D824A6EDDE
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 11:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FD72165274
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 10:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17221F12F9;
	Tue, 25 Mar 2025 10:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="PjDYQziX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5E8C1E521B;
	Tue, 25 Mar 2025 10:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899057; cv=none; b=tihXeODr7Mh6KSouxn8k2PVg6Q9OdpIr5Jm3PPqTUCi6X6R5o8C326FHhwXs8Ks8Iwq/8h5Eix/KYVigBAf/p4BGrOENlXeX0RrRk9P6AEBuFUEELwqoIgs4e/vS+f3SkJGmkXErq0K7lez0FAnygZj76eovxFsfya9xdSuloCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899057; c=relaxed/simple;
	bh=51wDfV9rDsVA0c+jNwRCdJu1AuaEG5qVqRbTTmH18OU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hmfPIOYZuh6wTb0EkRsFc7RaEduJ2r9Eveyu7t3x0UxMcQmGgdskisBnZauCQtIqqGjvDzq/X4z6rFU9KKrFNEi0r3CTiNaD1hu2oCkf9cJ5DrgcgGJ6+x2TiMiwt5UFIybLsQ2cQpHMF3zvgzrPLqfZDOQtzdaQXlKashPhDsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=PjDYQziX; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742899053; x=1743158253;
	bh=q3Yj+aHXsc3P6UT0cc2Zqww6E9FiFamGHLVciuWHLSo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=PjDYQziXHgAB5RkRLp8DjMsOahji8BgiTqvAq/BKeghOQUlHRgGirbuxSzGioVqQa
	 hh+kjixO0YWBQGs/BJ3wD/rCx+2CeYuvTuUZTWQnm5Opnp7VLuUlSNW5LmY6sLIqiT
	 4dDA2vRbOSgUkKCRb2GWBMU2EbFvBebAcU7cqhfXKFUDDG7yzxf9emswOC7fpYPxhO
	 2gnRkbmHqFF7BHOnje1/RKoG9jDQx7qxSZSMcrTUYRWpWguH4aSmv5Ri8JeXE8au6k
	 l17IViWmLrqIvBaw4+4+8ALW7MrfKB0TAeM42HHNOtxfn5ILJLNWjrGFgIs5LD9l5z
	 JI84zSWuCcSKA==
Date: Tue, 25 Mar 2025 10:37:29 +0000
To: Tamir Duberstein <tamird@gmail.com>, Boqun Feng <boqun.feng@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/5] rust: list: use consistent type parameter names
Message-ID: <D8PA5CKNMCGA.UODS331S36EG@proton.me>
In-Reply-To: <CAJ-ks9n66_vVg3ww58VqfXV6+phng8Bhq9C=NNn854gXK0KAHg@mail.gmail.com>
References: <20250324-list-no-offset-v1-0-afd2b7fc442a@gmail.com> <20250324-list-no-offset-v1-3-afd2b7fc442a@gmail.com> <67e1d1b3.050a0220.4c4ff.6e89@mx.google.com> <CAJ-ks9moCO83cGkKuONR-2JMN61x18T2UVO98jhspDR=uyaVqw@mail.gmail.com> <CAJ-ks9kPhb00-Dv8KucYGOVjLFMVYvfpBnqrV87M+eJmODAmyw@mail.gmail.com> <Z-Iq6Okk1j3ImH1u@Mac.home> <CAJ-ks9n66_vVg3ww58VqfXV6+phng8Bhq9C=NNn854gXK0KAHg@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 09793aba82e0e0bdeac439a271bab4ca7708c147
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Mar 25, 2025 at 10:52 AM CET, Tamir Duberstein wrote:
> On Tue, Mar 25, 2025 at 12:02=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com=
> wrote:
>> On Mon, Mar 24, 2025 at 05:56:57PM -0400, Tamir Duberstein wrote:
>> > On Mon, Mar 24, 2025 at 5:51=E2=80=AFPM Tamir Duberstein <tamird@gmail=
.com> wrote:
>> > > On Mon, Mar 24, 2025 at 5:42=E2=80=AFPM Boqun Feng <boqun.feng@gmail=
.com> wrote:
>> > > > On Mon, Mar 24, 2025 at 05:33:45PM -0400, Tamir Duberstein wrote:
>> > > > >              #[inline]
>> > > > > @@ -81,16 +81,16 @@ pub unsafe trait HasSelfPtr<T: ?Sized, const=
 ID: u64 =3D 0>
>> > > > >  /// Implements the [`HasListLinks`] and [`HasSelfPtr`] traits f=
or the given type.
>> > > > >  #[macro_export]
>> > > > >  macro_rules! impl_has_list_links_self_ptr {
>> > > > > -    ($(impl$({$($implarg:tt)*})?
>> > > > > +    ($(impl$({$($generics:tt)*})?
>> > > >
>> > > > While you're at it, can you also change this to be
>> > > >
>> > > >         ($(impl$(<$($generics:tt)*>)?
>> > > >
>> > > > ?
>> > > >
>> > > > I don't know why we chose <> for impl_has_list_links, but {} for
>> > > > impl_has_list_links_self_ptr ;-)
>> > >
>> > > This doesn't work in all cases:
>> > >
>> > > error: local ambiguity when calling macro `impl_has_work`: multiple
>> > > parsing options: built-in NTs tt ('generics') or 1 other option.
>> > >    --> ../rust/kernel/workqueue.rs:522:11
>> > >     |
>> > > 522 |     impl<T> HasWork<Self> for ClosureWork<T> { self.work }
>> > >
>> > > The reason that `impl_has_list_links` uses <> and all others use {} =
is
>> > > that `impl_has_list_links` is the only one that captures the generic
>> > > parameter as an `ident`, the rest use `tt`. So we could change
>>
>> Why impl_has_list_links uses generics at `ident` but rest use `tt`? I'm
>> a bit curious.
>
> I think it's because `ident` cannot deal with lifetimes or const
> generics - or at least I was not able to make it work with them.

If you use `ident`, you can use the normal `<>` as the delimiters of
generics. For `tt`, you have to use `{}` (or `()`/`[]`).=20

---
Cheers,
Benno


