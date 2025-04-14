Return-Path: <linux-pci+bounces-25819-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D77A87E90
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 13:11:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E4B53B408E
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 11:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FA33290BD4;
	Mon, 14 Apr 2025 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="Um6HdJmM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D609928FFF8;
	Mon, 14 Apr 2025 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744629062; cv=none; b=Mgj/wcjnEJEB4Jw7FavB6erMDQek9uZUQ3hCh0S4vlnuDgp4hIIyfu6F9CTGENxEKi9WAMTgMfX2zDUsA1kjbL8vh6OcZZ/SI+/OCYeoZrx1FPQk3rDpTl9CF6zFgzB2wseza2lGJWzh6mj1bSFDXwvTJhDyC7OIEMoVW57flaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744629062; c=relaxed/simple;
	bh=9Vep7/5YPgD9bMair/kXqnEQVoJBlizsE2UGtAaNckE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M1Q0Sz/eLz3SO1qDEcW46HtJpA/psPOnqYjpGyt4LxNpF5OgWpDUiLVebgGekN3ImrpDTSghh1VBAtMDHQ/riO+fvZLkHhYZ5gKLALIu4IH/IFUbC7dr4K/QzbMjwyntf+Szi97j2E6CN0w0Vl9GzBuq5/GaRIpHxjvIyeVSPoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=Um6HdJmM; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=6ugw3erzbffzvieb4nbfwa2try.protonmail; t=1744629057; x=1744888257;
	bh=YB3aL+anaTQ18vPfGLTzxQTLMQsbFelLoVESPaQBWz4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=Um6HdJmM+BE2UxoijTgbn1ejCIVGeWK5jbj8AfSl4CUhCM0ZUcfV/OuBU2L5jDIM0
	 mK2hDWav5eMG3qtGwzdEIDFMkJTFMjJtVhmvfJu3QjeXEeygWjNEz5BuRS1p5wB3+q
	 Al/kiQkRfw18moCHU8XDupYUdKbnNZLZO7U389guNFy/J4NfciWHzHY/JPQy1IX3+1
	 Xdr9RBnONNIn8it1qJjMA6ByftYpOi0jQvS6Tn4zUgVgbEoWvAYj5Eco7zflM3TGjd
	 bX2tCuCuI3m+486uz/94/aToTysf1pkvFssj/kKjc9i7dzYpc/FeVKQ2KwLbbHHLBf
	 OnIl3jT7OlT8A==
Date: Mon, 14 Apr 2025 11:10:50 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: bhelgaas@google.com, kwilczynski@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, abdiel.janulgue@gmail.com, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, daniel.almeida@collabora.com, robin.murphy@arm.com, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] rust: device: implement Bound device context
Message-ID: <D96BDR2E04KF.1CSIS0TVB0YI6@proton.me>
In-Reply-To: <Z_zp-AvQ6FMv0ZRK@pollux>
References: <20250413173758.12068-1-dakr@kernel.org> <20250413173758.12068-7-dakr@kernel.org> <D96AXNJRUAA0.3E5KYNM5PZZPG@proton.me> <Z_zp-AvQ6FMv0ZRK@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 14a5d6a4b0252adb2c75c6db8f812e331aacf4c9
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon Apr 14, 2025 at 12:56 PM CEST, Danilo Krummrich wrote:
> On Mon, Apr 14, 2025 at 10:49:49AM +0000, Benno Lossin wrote:
>> On Sun Apr 13, 2025 at 7:37 PM CEST, Danilo Krummrich wrote:
>> > The Bound device context indicates that a device is bound to a driver.
>> > It must be used for APIs that require the device to be bound, such as
>> > Devres or dma::CoherentAllocation.
>> >
>> > Implement Bound and add the corresponding Deref hierarchy, as well as =
the
>> > corresponding ARef conversion for this device context.
>> >
>> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> > ---
>> >  rust/kernel/device.rs | 16 +++++++++++++++-
>> >  1 file changed, 15 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
>> > index 487211842f77..585a3fcfeea3 100644
>> > --- a/rust/kernel/device.rs
>> > +++ b/rust/kernel/device.rs
>> > @@ -232,13 +232,19 @@ pub trait DeviceContext: private::Sealed {}
>> >  /// any of the bus callbacks, such as `probe()`.
>> >  pub struct Core;
>> > =20
>> > +/// The [`Bound`] context is the context of a bus specific device ref=
erence when it is guranteed to
>> > +/// be bound for the duration of its lifetime.
>> > +pub struct Bound;
>>=20
>> One question about this: is it possible for me to
>> 1. have access to a `ARef<Device<Bound>>` (or `Core`) via some callback,
>> 2. store a clone of the `ARef` in some datastructure,
>> 3. wait for the device to become unbound,
>> 4. use a `Bound`-only context function and blow something up?
>
> You can never get an ARef<Device> that has a different device context tha=
n
> Normal.
>
> A device must only ever implement AlwaysRefCounted for Device (i.e.
> Device<Normal>).

Ah yes, I thought there was something there, that's perfect. Might also
be a good idea to write this down before it becomes tribal knowledge :)

---
Cheers,
Benno


