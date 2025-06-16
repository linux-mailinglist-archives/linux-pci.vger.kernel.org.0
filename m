Return-Path: <linux-pci+bounces-29877-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 29308ADB5D0
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 17:47:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3322F188FDA6
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 15:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82A26283FEC;
	Mon, 16 Jun 2025 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RsE/rIpQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581B71E22E9;
	Mon, 16 Jun 2025 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750088739; cv=none; b=Ph8Om0TZAdtnJ3VD2Cb2JW18J1Ils69XdPGigrLo0hUCbxAfkTQEHoN48rDtjxHbifXR16XbgS4qUkhVsoUvAXmAT/VleTZ35HEBxMQk9MqVRW9sjeoXGZ0T6KBJyNPreKZ33ll2lm1PuVw2zbYW6G/TII5q2sH1OORkbtswhGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750088739; c=relaxed/simple;
	bh=Phz8r6X/1/Hfio3qW3aeXo0QdX243igoFLB5Ql8EyIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKQRdCGlAmfV44XUUNT+ix4My3xFWrxtvmokhOmPlzkx7/UNm+rjgI5QYdeKe/Bef33TslqA2azznUAOhcuaIK91NDPD98OYf7VwwgecBq9jLp9e1z8YgIlEKGSs+BQ+ellByj8eSJ7BJdgtv6ldgBwUWfZGny9lH1FZn+stgGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RsE/rIpQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0BE0C4CEEA;
	Mon, 16 Jun 2025 15:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750088739;
	bh=Phz8r6X/1/Hfio3qW3aeXo0QdX243igoFLB5Ql8EyIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RsE/rIpQgQubD9FD467llyTDjelw55TPUcdwrb3S1TXpCpXXNI43yrGPqDiR5nlqa
	 5TaebA2IEx6SuLpxCLrzK+vChFuXE6GGqpTKbGmHVpDela40oSWhU99OzwUu1A8U2p
	 ptnhDotPAzF1Irh4PN/v4rJURVqJYGkmrRRKP13lds41ykDKZgf4r7gi5Do6PdPXbD
	 rfZacp+1dtK5Uq27l+OehTp3KZCDFi28e/6Zpha8lBtamt2+AJrZaCD4bHD0MrHjNc
	 TNeuHUOHVTlHxeZz+OPK3UblpI1OCqbhTFAGFfeO+J7ndKOXZ1MeId9BrdXbWcoK4j
	 DiE9RKF5pKoEg==
Date: Mon, 16 Jun 2025 17:45:32 +0200
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
Message-ID: <aFA8HLREfMtZSh_u@pollux>
References: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com>
 <20250608-topics-tyr-request_irq-v4-4-81cb81fb8073@collabora.com>
 <aEbTOhdfmYmhPiiS@pollux>
 <5B3865E5-E343-4B5D-9BF7-7B9086AA9857@collabora.com>
 <B4E43744-D3F5-4720-BC75-29C092BAF7A6@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B4E43744-D3F5-4720-BC75-29C092BAF7A6@collabora.com>

On Mon, Jun 16, 2025 at 10:48:37AM -0300, Daniel Almeida wrote:
> Hi Danilo,
> 
> > On 9 Jun 2025, at 13:24, Daniel Almeida <daniel.almeida@collabora.com> wrote:
> > 
> > Hi Danilo,
> > 
> >> On 9 Jun 2025, at 09:27, Danilo Krummrich <dakr@kernel.org> wrote:
> >> 
> >> On Sun, Jun 08, 2025 at 07:51:09PM -0300, Daniel Almeida wrote:
> >>> +/// Callbacks for a threaded IRQ handler.
> >>> +pub trait ThreadedHandler: Sync {
> >>> +    /// The actual handler function. As usual, sleeps are not allowed in IRQ
> >>> +    /// context.
> >>> +    fn handle_irq(&self) -> ThreadedIrqReturn;
> >>> +
> >>> +    /// The threaded handler function. This function is called from the irq
> >>> +    /// handler thread, which is automatically created by the system.
> >>> +    fn thread_fn(&self) -> IrqReturn;
> >>> +}
> >>> +
> >>> +impl<T: ?Sized + ThreadedHandler + Send> ThreadedHandler for Arc<T> {
> >>> +    fn handle_irq(&self) -> ThreadedIrqReturn {
> >>> +        T::handle_irq(self)
> >>> +    }
> >>> +
> >>> +    fn thread_fn(&self) -> IrqReturn {
> >>> +        T::thread_fn(self)
> >>> +    }
> >>> +}
> >> 
> >> In case you intend to be consistent with the function pointer names in
> >> request_threaded_irq(), it'd need to be handler() and thread_fn(). But I don't
> >> think there's a need for that, both aren't really nice for names of trait
> >> methods.
> >> 
> >> What about irq::Handler::handle() and irq::Handler::handle_threaded() for
> >> instance?
> >> 
> >> Alternatively, why not just
> >> 
> >> trait Handler {
> >>  fn handle(&self);
> >> }
> >> 
> >> trait ThreadedHandler {
> >>  fn handle(&self);
> >> }
> >> 
> >> and then we ask for `T: Handler + ThreadedHandler`.
> > 
> > Sure, I am totally OK with renaming things, but IIRC I've tried  Handler +
> > ThreadedHandler in the past and found it to be problematic. I don't recall why,
> > though, so maybe it's worth another attempt.
> 
> Handler::handle() returns IrqReturn and ThreadedHandler::handle() returns
> ThreadedIrqReturn, which includes WakeThread, so these had to be separate
> traits.

Ok, that fine then. But I'd still prefer the better naming as mentioned above.

