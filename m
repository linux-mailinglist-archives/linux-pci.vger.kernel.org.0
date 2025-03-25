Return-Path: <linux-pci+bounces-24662-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA95A6F1A1
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 12:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35877188D2F5
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 11:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D3B198A29;
	Tue, 25 Mar 2025 11:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="NpEMeVyE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D09D2E337C;
	Tue, 25 Mar 2025 11:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742901507; cv=none; b=EPwNCEDtkjU6L+UjFXYxg56uNAePj5F0gPhcDAdZO+40Lg5l1v207EdGOwYM0v8h5cK1FVhzU5YQSp+Bi8ueatUlwYqSauyGocfzWFMB99sbjf4kaLE52DuM9tk06CFKc1uYKCwZffJ0M5UqXCPGdAgtFC4zUNgWqctgzRePKGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742901507; c=relaxed/simple;
	bh=/A4Re9ZnXk9dFMPy8kLJyTDBCliwhE9DawViBWNrdTY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CBYmcnb348p2MMVTE85NpIOqjxNlKAFDX2iJGbK6DL+IG7tFO1TZArMqQ1vN5OVr9zcBEim22/LHVX+u4fxG1Weq8A88G85X/6eMYVRInZV03QzBqri4pY5kIS8Y7Bs6RTEeWYrO7Y59m0BUOIE0bFNAUHmjZ5wBjEDM5Sf8iGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=NpEMeVyE; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=j3jqpzi7fbao5nhxypqetcbjbi.protonmail; t=1742901501; x=1743160701;
	bh=PRIAuT+urW+Uxb9HvRuGGsdWcowDVCzwb9vcglusjuc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=NpEMeVyE9u+h5Gj12RsbKxkQT+GjekJu1zM6uwwaQxjNnelrHRtav897efjjRl2YV
	 IuMRX1CgLBIKtopQ317TtoiRTgrlPKT2S/1VIS1u5So6kpyWVWFaaSc/lgzuMiFtV1
	 UO764HId23CR+0WVRoZVjKlY4ydXzv9XxCbkEs3i5PmCCzrbk8zzSpdLy457LPYd8J
	 gbLQxKoYPpEI69NA7Pdz6rsWftpNs8osKjAcscSL6/loYj1S2X4UNuznYO2MxeSsBr
	 90nT8KHJGILTjcrbfKk5+36vezA7wF4fSldi/Zr/rw1I8y9BN3TOE5XBkoZ/moUhsj
	 XzihJiduIIb3A==
Date: Tue, 25 Mar 2025 11:18:17 +0000
To: Tamir Duberstein <tamird@gmail.com>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Boqun Feng <boqun.feng@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/5] rust: list: use consistent type parameter names
Message-ID: <D8PB0LN62GOX.3P4K4V96OLVQ9@proton.me>
In-Reply-To: <CAJ-ks9kOFk2GGwjX_Eo7Kuxoh5eziGSKRpLE8oVjEs7pRnWyRw@mail.gmail.com>
References: <20250324-list-no-offset-v1-0-afd2b7fc442a@gmail.com> <20250324-list-no-offset-v1-3-afd2b7fc442a@gmail.com> <67e1d1b3.050a0220.4c4ff.6e89@mx.google.com> <CAJ-ks9moCO83cGkKuONR-2JMN61x18T2UVO98jhspDR=uyaVqw@mail.gmail.com> <CAJ-ks9kPhb00-Dv8KucYGOVjLFMVYvfpBnqrV87M+eJmODAmyw@mail.gmail.com> <Z-Iq6Okk1j3ImH1u@Mac.home> <CAJ-ks9n66_vVg3ww58VqfXV6+phng8Bhq9C=NNn854gXK0KAHg@mail.gmail.com> <D8PA5CKNMCGA.UODS331S36EG@proton.me> <CAJ-ks9kOFk2GGwjX_Eo7Kuxoh5eziGSKRpLE8oVjEs7pRnWyRw@mail.gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 8a508fb47a377576bf6cba327da34cc8bd8a0f3d
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Mar 25, 2025 at 11:42 AM CET, Tamir Duberstein wrote:
> On Tue, Mar 25, 2025 at 6:37=E2=80=AFAM Benno Lossin <benno.lossin@proton=
.me> wrote:
>> On Tue Mar 25, 2025 at 10:52 AM CET, Tamir Duberstein wrote:
>> > On Tue, Mar 25, 2025 at 12:02=E2=80=AFAM Boqun Feng <boqun.feng@gmail.=
com> wrote:
>> >> On Mon, Mar 24, 2025 at 05:56:57PM -0400, Tamir Duberstein wrote:
>> >> > On Mon, Mar 24, 2025 at 5:51=E2=80=AFPM Tamir Duberstein <tamird@gm=
ail.com> wrote:
>> >> > > On Mon, Mar 24, 2025 at 5:42=E2=80=AFPM Boqun Feng <boqun.feng@gm=
ail.com> wrote:
>> >> > > > On Mon, Mar 24, 2025 at 05:33:45PM -0400, Tamir Duberstein wrot=
e:
>> >> > > > >              #[inline]
>> >> > > > > @@ -81,16 +81,16 @@ pub unsafe trait HasSelfPtr<T: ?Sized, co=
nst ID: u64 =3D 0>
>> >> > > > >  /// Implements the [`HasListLinks`] and [`HasSelfPtr`] trait=
s for the given type.
>> >> > > > >  #[macro_export]
>> >> > > > >  macro_rules! impl_has_list_links_self_ptr {
>> >> > > > > -    ($(impl$({$($implarg:tt)*})?
>> >> > > > > +    ($(impl$({$($generics:tt)*})?
>> >> > > >
>> >> > > > While you're at it, can you also change this to be
>> >> > > >
>> >> > > >         ($(impl$(<$($generics:tt)*>)?
>> >> > > >
>> >> > > > ?
>> >> > > >
>> >> > > > I don't know why we chose <> for impl_has_list_links, but {} fo=
r
>> >> > > > impl_has_list_links_self_ptr ;-)
>> >> > >
>> >> > > This doesn't work in all cases:
>> >> > >
>> >> > > error: local ambiguity when calling macro `impl_has_work`: multip=
le
>> >> > > parsing options: built-in NTs tt ('generics') or 1 other option.
>> >> > >    --> ../rust/kernel/workqueue.rs:522:11
>> >> > >     |
>> >> > > 522 |     impl<T> HasWork<Self> for ClosureWork<T> { self.work }
>> >> > >
>> >> > > The reason that `impl_has_list_links` uses <> and all others use =
{} is
>> >> > > that `impl_has_list_links` is the only one that captures the gene=
ric
>> >> > > parameter as an `ident`, the rest use `tt`. So we could change
>> >>
>> >> Why impl_has_list_links uses generics at `ident` but rest use `tt`? I=
'm
>> >> a bit curious.
>> >
>> > I think it's because `ident` cannot deal with lifetimes or const
>> > generics - or at least I was not able to make it work with them.
>>
>> If you use `ident`, you can use the normal `<>` as the delimiters of
>> generics. For `tt`, you have to use `{}` (or `()`/`[]`).
>
> Yes I know. But with `ident` you cannot capture lifetimes or const generi=
cs.

Why is that required for this macro? I think we could use `tt`.

---
Cheers,
Benno


