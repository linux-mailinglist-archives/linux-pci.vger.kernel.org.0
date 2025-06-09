Return-Path: <linux-pci+bounces-29254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D5DAD255A
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 20:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5080418911C5
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 18:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDBA218EA1;
	Mon,  9 Jun 2025 18:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YtGcmuDZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB0118DB34;
	Mon,  9 Jun 2025 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749492820; cv=none; b=OMNvwqI10GMxNZA9WaZ1ZL5UWqsP+ucN6UVkqN8ddP2BpiNzS0mqS/FELLVbELotJCkR33RNqjmvWLu8DPen9h25b9sh3SmCjSoXyHEVIDBe7evs0og5SP9cFB22JKNG+o8h+VS8/CSdem2k71ZTmcfvwy5+bDSyjObN7n1ckcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749492820; c=relaxed/simple;
	bh=fPAq5fhqMsM3I+RFFHnBatxDu/Dm68BwDmcqiGwulEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ufD+XWuByUjiWBhYmmfxhvmPTqroc64qwQZsQjiHHDQTJnljNIzUWdyR43KThqPZXcMyo5YGHUowXCbO2Uq7f2m6WDFpyeNtGx2thcnibbyYJqBjZdfnBTHjt7CzvTdlfmXGwmORgYN5tu8+tO72MY/lIInch7xs1zPIQSvvAgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YtGcmuDZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B3C6C4CEEB;
	Mon,  9 Jun 2025 18:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749492819;
	bh=fPAq5fhqMsM3I+RFFHnBatxDu/Dm68BwDmcqiGwulEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YtGcmuDZGmGOZU+sMWtbTNSeILk2Atjn7n92775i1x94lBZqoq5U+FCpzUSEFLCol
	 yq5JAOgSms+6yX8jaAVKsndi5XvFnKJKadjMrIgJmhnpY7aWwCf2HwyILPNgVfMfRj
	 l97kO9j2HUXUfvi7BcVYVbs2BThBEmdJdnUvsLZIJLwSpepimHQBCg57PGI5Y4CWGj
	 LraoY/8ZhjLeHQ5PudLczl+zXWdqAp6kHKrhDaijETyJ11TSikrOlO9L9c5ur8kFhs
	 flbTLSZeN3dPN+W1tXGJUTg9UCR+HGx7h94TXdcz63ak/ZDlyMBLZ6djPdJvWzKD5o
	 TAfRMQoDqFuQg==
Date: Mon, 9 Jun 2025 20:13:33 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Benno Lossin <lossin@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 4/6] rust: irq: add support for threaded IRQs and
 handlers
Message-ID: <aEckTQ2F-s1YfUdu@pollux.localdomain>
References: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com>
 <20250608-topics-tyr-request_irq-v4-4-81cb81fb8073@collabora.com>
 <aEbTOhdfmYmhPiiS@pollux>
 <5B3865E5-E343-4B5D-9BF7-7B9086AA9857@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5B3865E5-E343-4B5D-9BF7-7B9086AA9857@collabora.com>

On Mon, Jun 09, 2025 at 01:24:40PM -0300, Daniel Almeida wrote:
> > On 9 Jun 2025, at 09:27, Danilo Krummrich <dakr@kernel.org> wrote:
> >> +#[pin_data]
> >> +pub struct ThreadedRegistration<T: ThreadedHandler + 'static> {
> >> +    inner: Devres<RegistrationInner>,
> >> +
> >> +    #[pin]
> >> +    handler: T,
> >> +
> >> +    /// Pinned because we need address stability so that we can pass a pointer
> >> +    /// to the callback.
> >> +    #[pin]
> >> +    _pin: PhantomPinned,
> >> +}
> > 
> > Most of the code in this file is a duplicate of the non-threaded registration.
> > 
> > I think this would greatly generalize with specialization and an HandlerInternal
> > trait.
> > 
> > Without specialization I think we could use enums to generalize.
> > 
> > The most trivial solution would be to define the Handler trait as
> > 
> > trait Handler {
> >   fn handle(&self);
> >   fn handle_threaded(&self) {};
> > }
> > 
> > but that's pretty dodgy.
> 
> A lot of the comments up until now have touched on somehow having threaded and
> non-threaded versions implemented together. I personally see no problem in
> having things duplicated here, because I think it's easier to reason about what
> is going on this way. Alice has expressed a similar view in a previous iteration.
> 
> Can you expand a bit more on your suggestion? Perhaps there's a clean way to do
> it (without macros and etc), but so far I don't see it.

I think with specialization it'd be trivial to generalize, but this isn't
stable yet. The enum approach is probably unnecessarily complicated, so I agree
to leave it as it is.

Maybe a comment that this can be generalized once we get specialization would be
good?

> >> +impl<T: ThreadedHandler + 'static> ThreadedRegistration<T> {
> >> +    /// Registers the IRQ handler with the system for the given IRQ number.
> >> +    pub(crate) fn register<'a>(
> >> +        dev: &'a Device<Bound>,
> >> +        irq: u32,
> >> +        flags: Flags,
> >> +        name: &'static CStr,
> >> +        handler: T,
> >> +    ) -> impl PinInit<Self, Error> + 'a {
> > 
> > What happens if `dev`  does not match `irq`? The caller is responsible to only
> > provide an IRQ number that was obtained from this device.
> > 
> > This should be a safety requirement and a type invariant.
> 
> This iteration converted register() from pub to pub(crate). The idea was to
> force drivers to use the accessors. I assumed this was enough to make the API
> safe, as the few users in the kernel crate (i.e.: so far platform and pci)
> could be manually checked for correctness.
> 
> To summarize my point, there is still the possibility of misusing this from the
> kernel crate itself, but that is no longer possible from a driver's
> perspective.

Correct, you made Registration::new() crate private, such that drivers can't
access it anymore. But that doesn't make the function safe by itself. It's still
unsafe to be used from platform::Device and pci::Device.

While that's fine, we can't ignore it and still have to add the corresponding
safety requirements to Registration::new().

I think there is a way to make this interface safe as well -- this is also
something that Benno would be great to have a look at.

I'm thinking of something like

	/// # Invariant
	///
	/// `ìrq` is the number of an interrupt source of `dev`.
	struct IrqRequest<'a> {
	   dev: &'a Device<Bound>,
	   irq: u32,
	}

and from the caller you could create an instance like this:

	// INVARIANT: [...]
	let req = IrqRequest { dev, irq };

I'm not sure whether this needs an unsafe constructor though.

