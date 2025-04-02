Return-Path: <linux-pci+bounces-25102-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 373BDA7856B
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 02:06:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44D1E3ACE6D
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 00:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AECE436D;
	Wed,  2 Apr 2025 00:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="TDpZp3n0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7B5184;
	Wed,  2 Apr 2025 00:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743552371; cv=none; b=QcDahxYwj6GRE7Qr1f8grB2LXzBO+fMJVlelvZWbOT2czpbLBs075kcUpSJLHEZPv/uiBTLX4EbOqCWWbc8G2taKMP9MXUwgf2abOcmGkQXFl0OOddvztoc8jVLAX7BNmi5DB4ff988ldmFA0QRKNgqwXiUtk1hHseTu4hi4Ntk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743552371; c=relaxed/simple;
	bh=SKvTKbz6ni8FnmJ1GP4IVeexdsrRnOKxcqNOXAHpVHk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bp3C+5Qvends5+zSb/IUUNONQsSCW+NPVjUVLycHNqYLlAECeYRU8GEhugKW5aLRLlfx23H1WtI9eB2ErER3LvQw8+d3FTdXmkFDkxyCkYWUQHbWB9NYFvpPqb0PHA2+Z4uTBUmLfj8l5fdftWeOIFx5X+6de1QVP4IhJFgT0+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=TDpZp3n0; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=36zyj7lnbbclrifsrasst7ba2i.protonmail; t=1743552360; x=1743811560;
	bh=GG1TKNw1ad56XFapM4VnVdkZu9HjKmQ/qsMjqEKVOoA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=TDpZp3n0Ds4RNhIfHGagrDTveMMpe6uFvDjgRfJW4QFU2AFnVNvahozjVSxIgaVCj
	 lZKY2rApK5LUIHTR8OJaZVDUIhMi3MC3DOLvT+fFmEkzDdLAGyQnuX004HiW7mJrmt
	 CF9Rk8hYubo4zj9vMn7NwiiLGInLknCqMiUWsBT7ruznXUAudQ4YZ80aA6J64V8M8B
	 EPbLuHUJt/pXPreRUg+zb4nBqbydtQfbertYomZltWa1YNHjAfXAama51ey5UZ6tjZ
	 8BmTdHfeTEzWQyp72D1Wx+TVP+W2gmU9W7OVO4OhrGRcdngCh1Y1hWw9AmmfP0EAhr
	 24A0eUfyPf8wg==
Date: Wed, 02 Apr 2025 00:05:56 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: Greg KH <gregkh@linuxfoundation.org>, bhelgaas@google.com, rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] rust: pci: impl TryFrom<&Device> for &pci::Device
Message-ID: <D8VPQ5XL5NJZ.26OGZ3YML4QN3@proton.me>
In-Reply-To: <Z-vvcPfgyaRdd0xQ@pollux>
References: <20250321214826.140946-1-dakr@kernel.org> <Z96MrGQvpVrFqWYJ@pollux> <Z-CG01QzSJjp46ad@pollux> <D8ON7WC8WMFG.2S2JRK6G9TOSL@proton.me> <Z-GNDE68vwhk0gaV@cassiopeiae> <D8OOFRRSLHP4.1B2FHQRGH3LKW@proton.me> <Z-Ggu_YZBPM2Kf8J@cassiopeiae> <D8OPMRYE0SO5.2JQD6ZIYXHP68@proton.me> <Z-vvcPfgyaRdd0xQ@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: eaab470bc2e61cf080048f1271cbbfb5ec48b355
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue Apr 1, 2025 at 3:51 PM CEST, Danilo Krummrich wrote:
> On Mon, Mar 24, 2025 at 06:32:53PM +0000, Benno Lossin wrote:
>> On Mon Mar 24, 2025 at 7:13 PM CET, Danilo Krummrich wrote:
>> > On Mon, Mar 24, 2025 at 05:36:45PM +0000, Benno Lossin wrote:
>> >> On Mon Mar 24, 2025 at 5:49 PM CET, Danilo Krummrich wrote:
>> >> > On Mon, Mar 24, 2025 at 04:39:25PM +0000, Benno Lossin wrote:
>> >> >> On Sun Mar 23, 2025 at 11:10 PM CET, Danilo Krummrich wrote:
>> >> >> > On Sat, Mar 22, 2025 at 11:10:57AM +0100, Danilo Krummrich wrote=
:
>> >> >> >> On Fri, Mar 21, 2025 at 08:25:07PM -0700, Greg KH wrote:
>> >> >> >> > Along these lines, if you can convince me that this is someth=
ing that we
>> >> >> >> > really should be doing, in that we should always be checking =
every time
>> >> >> >> > someone would want to call to_pci_dev(), that the return valu=
e is
>> >> >> >> > checked, then why don't we also do this in C if it's going to=
 be
>> >> >> >> > something to assure people it is going to be correct?  I don'=
t want to
>> >> >> >> > see the rust and C sides get "out of sync" here for things th=
at can be
>> >> >> >> > kept in sync, as that reduces the mental load of all of us as=
 we travers
>> >> >> >> > across the boundry for the next 20+ years.
>> >> >> >>=20
>> >> >> >> I think in this case it is good when the C and Rust side get a =
bit
>> >> >> >> "out of sync":
>> >> >> >
>> >> >> > A bit more clarification on this:
>> >> >> >
>> >> >> > What I want to say with this is, since we can cover a lot of the=
 common cases
>> >> >> > through abstractions and the type system, we're left with the no=
t so common
>> >> >> > ones, where the "upcasts" are not made in the context of common =
and well
>> >> >> > established patterns, but, for instance, depend on the semantics=
 of the driver;
>> >> >> > those should not be unsafe IMHO.
>> >> >>=20
>> >> >> I don't think that we should use `TryFrom` for stuff that should o=
nly be
>> >> >> used seldomly. A function that we can document properly is a much =
better
>> >> >> fit, since we can point users to the "correct" API.
>> >> >
>> >> > Most of the cases where drivers would do this conversion should be =
covered by
>> >> > the abstraction to already provide that actual bus specific device,=
 rather than
>> >> > a generic one or some priv pointer, etc.
>> >> >
>> >> > So, the point is that the APIs we design won't leave drivers with a=
 reason to
>> >> > make this conversion in the first place. For the cases where they h=
ave to
>> >> > (which should be rare), it's the right thing to do. There is not an=
 alternative
>> >> > API to point to.
>> >>=20
>> >> Yes, but for such a case, I wouldn't want to use `TryFrom`, since tha=
t
>> >> trait to me is a sign of a canonical way to convert a value.
>> >
>> > Well, it is the canonical way to convert, it's just that by the design=
 of other
>> > abstractions drivers should very rarely get in the situation of needin=
g it in
>> > the first place.
>>=20
>> I'd still prefer it though, since one can spot a
>>=20
>>     let dev =3D CustomDevice::checked_from(dev)?
>>=20
>> much better in review than the `try_from` conversion. It also prevents
>> one from giving it to a generic interface expecting the `TryFrom` trait.
>
> (I plan to rebase this on my series introducing the Bound device context =
[1].)
>
> I thought about this for a while and I still think TryFrom is fine here.

What reasoning do you have?

> At some point I want to replace this implementation with a macro, since t=
he code
> is pretty similar for bus specific devices. I think that's a bit cleaner =
with
> TryFrom compared to with a custom method, since we'd need the bus specifi=
c
> device to call the macro from the generic impl, i.e.
>
> =09impl<Ctx: DeviceContext> Device<Ctx>
>
> rather than a specific one, which we can't control. We can control it for
> TryFrom though.

We could have our own trait for that. Also it's not as controllable as
you think: anyone can implement `TryFrom<&device::Device> for &MyType`.

> However, I also do not really object to your proposal, hence I'm willing =
to make
> the change.
>
> Do you want to make a proposal for the corresponding doc comment switchin=
g to a
> custom method?

I think have too little context what `device::Device` and `pci::Device`
are. But I can give it a try:

    /// Tries to converts a generic [`Device`](device::Device) into a [`pci=
::Device`].
    ///
    /// Normally, one wouldn't need to call this function, because APIs sho=
uld directly expose the
    /// concrete device type.

Then I think another sentence about a valid use-case of this function
would make a lot of sense, but I don't know any.

---
Cheers,
Benno


