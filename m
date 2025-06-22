Return-Path: <linux-pci+bounces-30326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 674A0AE321A
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jun 2025 22:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28C971890612
	for <lists+linux-pci@lfdr.de>; Sun, 22 Jun 2025 20:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5733C1F4725;
	Sun, 22 Jun 2025 20:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPCofERL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AED1E8356;
	Sun, 22 Jun 2025 20:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750625624; cv=none; b=V8W4FvpsDJ9Xr+M0uWjmLH9PmjDXOs94/RO+XXb+GkSDaswS85xazHEQ9GcNDCYZm0XN9aoJL/4SldegM9bFyaI4njiY+WVEIp0Stmtk2+IVx+67KYkB5PM9HE5WxtrJya6FkGGTAWrt6yxYc6S+pF2c1VIhjP7U0cEa545Ka9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750625624; c=relaxed/simple;
	bh=ETNTMcoDtb6Zz4KxYImd27LRIowUhqZRAL6C5iDjpvI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ImG51mziBapldBnlRzwl7uY+nNi3z/0cg2VpWUoEUm9uQsZtKnlaLPOe7N4ICZcJtgH4BZwFs54ahyrtDxgThvwGqFgD94udlMs/mNf34C1Xg6RuOvSAdl74fbON+rO8Aho9q1HX4gsMqXUKBQPEEEPdyv9ct5bJTaGh77Cy0Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPCofERL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF8AC4CEE3;
	Sun, 22 Jun 2025 20:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750625623;
	bh=ETNTMcoDtb6Zz4KxYImd27LRIowUhqZRAL6C5iDjpvI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=EPCofERLyS7eERNMKxP4WuVN8DKo9AGNz11NJl3+zmRyK88oSu3ABuLtMvJ+A0L7s
	 3SecOZvoKdcvbqKKKb8uCOirLGkklN3Xh4Eaba8c/djwHYjOJNvCvrFIOv5gdUMCDO
	 lAdjrwJz7LE5lg/CHrP679FVcqyf7PCI1Dq4CLhzvwra2C5xMWZwyIiuNdtjynqTUE
	 kyzxc9IHjLn5XiEnHDFOUQzM22Qcq9oVHuHNwjZGYF2gOPUyoZk4wDg46Jqz7tDDxv
	 74gaFXW3L2qbBtsMPg9axVYUark9zZW+mac1kVLb7orRd6XtAiKJ8JTeOq7JWSl7Vv
	 /AEr7AkHBqgjQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 22 Jun 2025 22:53:38 +0200
Message-Id: <DATCZMJJ1SQT.24OPC80MXN1E5@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 4/6] rust: irq: add support for threaded IRQs and
 handlers
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>
X-Mailer: aerc 0.20.1
References: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com> <20250608-topics-tyr-request_irq-v4-4-81cb81fb8073@collabora.com> <aEbTOhdfmYmhPiiS@pollux> <5B3865E5-E343-4B5D-9BF7-7B9086AA9857@collabora.com> <aEckTQ2F-s1YfUdu@pollux.localdomain>
In-Reply-To: <aEckTQ2F-s1YfUdu@pollux.localdomain>

On Mon Jun 9, 2025 at 8:13 PM CEST, Danilo Krummrich wrote:
> On Mon, Jun 09, 2025 at 01:24:40PM -0300, Daniel Almeida wrote:
>> > On 9 Jun 2025, at 09:27, Danilo Krummrich <dakr@kernel.org> wrote:
>> >> +#[pin_data]
>> >> +pub struct ThreadedRegistration<T: ThreadedHandler + 'static> {
>> >> +    inner: Devres<RegistrationInner>,
>> >> +
>> >> +    #[pin]
>> >> +    handler: T,
>> >> +
>> >> +    /// Pinned because we need address stability so that we can pass=
 a pointer
>> >> +    /// to the callback.
>> >> +    #[pin]
>> >> +    _pin: PhantomPinned,
>> >> +}
>> >=20
>> > Most of the code in this file is a duplicate of the non-threaded regis=
tration.
>> >=20
>> > I think this would greatly generalize with specialization and an Handl=
erInternal
>> > trait.
>> >=20
>> > Without specialization I think we could use enums to generalize.
>> >=20
>> > The most trivial solution would be to define the Handler trait as
>> >=20
>> > trait Handler {
>> >   fn handle(&self);
>> >   fn handle_threaded(&self) {};
>> > }
>> >=20
>> > but that's pretty dodgy.
>>=20
>> A lot of the comments up until now have touched on somehow having thread=
ed and
>> non-threaded versions implemented together. I personally see no problem =
in
>> having things duplicated here, because I think it's easier to reason abo=
ut what
>> is going on this way. Alice has expressed a similar view in a previous i=
teration.
>>=20
>> Can you expand a bit more on your suggestion? Perhaps there's a clean wa=
y to do
>> it (without macros and etc), but so far I don't see it.
>
> I think with specialization it'd be trivial to generalize, but this isn't
> stable yet. The enum approach is probably unnecessarily complicated, so I=
 agree
> to leave it as it is.
>
> Maybe a comment that this can be generalized once we get specialization w=
ould be
> good?
>
>> >> +impl<T: ThreadedHandler + 'static> ThreadedRegistration<T> {
>> >> +    /// Registers the IRQ handler with the system for the given IRQ =
number.
>> >> +    pub(crate) fn register<'a>(
>> >> +        dev: &'a Device<Bound>,
>> >> +        irq: u32,
>> >> +        flags: Flags,
>> >> +        name: &'static CStr,
>> >> +        handler: T,
>> >> +    ) -> impl PinInit<Self, Error> + 'a {
>> >=20
>> > What happens if `dev`  does not match `irq`? The caller is responsible=
 to only
>> > provide an IRQ number that was obtained from this device.
>> >=20
>> > This should be a safety requirement and a type invariant.
>>=20
>> This iteration converted register() from pub to pub(crate). The idea was=
 to
>> force drivers to use the accessors. I assumed this was enough to make th=
e API
>> safe, as the few users in the kernel crate (i.e.: so far platform and pc=
i)
>> could be manually checked for correctness.
>>=20
>> To summarize my point, there is still the possibility of misusing this f=
rom the
>> kernel crate itself, but that is no longer possible from a driver's
>> perspective.
>
> Correct, you made Registration::new() crate private, such that drivers ca=
n't
> access it anymore. But that doesn't make the function safe by itself. It'=
s still
> unsafe to be used from platform::Device and pci::Device.
>
> While that's fine, we can't ignore it and still have to add the correspon=
ding
> safety requirements to Registration::new().
>
> I think there is a way to make this interface safe as well -- this is als=
o
> something that Benno would be great to have a look at.

Finally had some time to look through this thread, thought I needed a
whole lot of context, but turns out the question is simple :)

Your idea looks sound :)

---
Cheers,
Benno

> I'm thinking of something like
>
> 	/// # Invariant
> 	///
> 	/// `=C3=ACrq` is the number of an interrupt source of `dev`.
> 	struct IrqRequest<'a> {
> 	   dev: &'a Device<Bound>,
> 	   irq: u32,
> 	}
>
> and from the caller you could create an instance like this:
>
> 	// INVARIANT: [...]
> 	let req =3D IrqRequest { dev, irq };
>
> I'm not sure whether this needs an unsafe constructor though.


