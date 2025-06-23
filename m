Return-Path: <linux-pci+bounces-30408-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3434AE485E
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 17:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DE4416624B
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 15:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E77127A13D;
	Mon, 23 Jun 2025 15:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pgrbm2xS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA0027A12D;
	Mon, 23 Jun 2025 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692189; cv=none; b=C+TS1/gKYKSRLCP/5AuqxG9XLvtLmU4ThZFn9YPQRnJu50uP3KUCBy2AsPkQECuaHkfjLuOMkf/7j6NWVUHoI4KT9+SCqD54cviWtjvPr1cf0JwDEDEcHlyeL7tN0dCtXa+zV1ENNDIPpS9KUis77exHb1B7Vkqn6d9v3vHDXLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692189; c=relaxed/simple;
	bh=l/nreA1qmrI94d8PlmJE//wV3+gjYJXlzkDbcbsd5WI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=feC3uOkG8s3iO26FUBcCATOh6OEDj7kxIBraQ3WqHv5dN+c5Mko7dIu/eZsyoKcwdpaVNBmBeTxLW6Ri53ZdntIsr1K6JgMFYXkR+ev9kxg9HhHin1f9bMsEAjggQxYqj2K4A/A8w4NxvlziXO65lnmnN6vVxLNRnV1X0S6vud8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pgrbm2xS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E69C4CEEA;
	Mon, 23 Jun 2025 15:23:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750692188;
	bh=l/nreA1qmrI94d8PlmJE//wV3+gjYJXlzkDbcbsd5WI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pgrbm2xS8dD+gdj2rmph8p4mX3TV01mECl4fD/K42oaq2ikHZ9xwBtse0n9ei9L4T
	 e7asqtlEW4URcGr0gh63Ds1c923CfX1mozYe4PSyeaxDMr1Qv2h3PDbS30VDB6kM2F
	 jv907Wo42XyKRkDnWm2PPSqaHvteMYyuSOx/pPPVGhJO4rRC64jfmth4QRO/gqOlVY
	 n5bRQZO7zb1K4g6Uuv42EuzrAShsEy4j1YIuQ/fMHueERbEuHrfQQk3eyYBE0rWpFK
	 qK1Rqa4aNT2QwnGxr9PgAvfRETxb975ByillO6pHhZ/rzjyAUc6UkDo2gFj/r8zA6M
	 1+BzFN92DUmqQ==
Date: Mon, 23 Jun 2025 17:23:02 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Benno Lossin <lossin@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
Message-ID: <aFlxVlMYWig1N2Hy@cassiopeiae>
References: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com>
 <20250608-topics-tyr-request_irq-v4-3-81cb81fb8073@collabora.com>
 <aEbJt0YSc3-60OBY@pollux>
 <CAH5fLghDbrgO2PiKyKZ87UrtouG25xWhVP_YmcgO0fFcnvZRkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLghDbrgO2PiKyKZ87UrtouG25xWhVP_YmcgO0fFcnvZRkQ@mail.gmail.com>

On Mon, Jun 23, 2025 at 04:10:50PM +0100, Alice Ryhl wrote:
> On Mon, Jun 9, 2025 at 12:47 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >
> > On Sun, Jun 08, 2025 at 07:51:08PM -0300, Daniel Almeida wrote:
> > > +        dev: &'a Device<Bound>,
> > > +        irq: u32,
> > > +        flags: Flags,
> > > +        name: &'static CStr,
> > > +        handler: T,
> > > +    ) -> impl PinInit<Self, Error> + 'a {
> > > +        let closure = move |slot: *mut Self| {
> > > +            // SAFETY: The slot passed to pin initializer is valid for writing.
> > > +            unsafe {
> > > +                slot.write(Self {
> > > +                    inner: Devres::new(
> > > +                        dev,
> > > +                        RegistrationInner {
> > > +                            irq,
> > > +                            cookie: slot.cast(),
> > > +                        },
> > > +                        GFP_KERNEL,
> > > +                    )?,
> > > +                    handler,
> > > +                    _pin: PhantomPinned,
> > > +                })
> > > +            };
> > > +
> > > +            // SAFETY:
> > > +            // - The callbacks are valid for use with request_irq.
> > > +            // - If this succeeds, the slot is guaranteed to be valid until the
> > > +            // destructor of Self runs, which will deregister the callbacks
> > > +            // before the memory location becomes invalid.
> > > +            let res = to_result(unsafe {
> > > +                bindings::request_irq(
> > > +                    irq,
> > > +                    Some(handle_irq_callback::<T>),
> > > +                    flags.into_inner() as usize,
> > > +                    name.as_char_ptr(),
> > > +                    slot.cast(),
> > > +                )
> > > +            });
> > > +
> > > +            if res.is_err() {
> > > +                // SAFETY: We are returning an error, so we can destroy the slot.
> > > +                unsafe { core::ptr::drop_in_place(&raw mut (*slot).handler) };
> > > +            }
> > > +
> > > +            res
> > > +        };
> > > +
> > > +        // SAFETY:
> > > +        // - if this returns Ok, then every field of `slot` is fully
> > > +        // initialized.
> > > +        // - if this returns an error, then the slot does not need to remain
> > > +        // valid.
> > > +        unsafe { pin_init_from_closure(closure) }
> >
> > Can't we use try_pin_init!() instead, move request_irq() into the initializer of
> > RegistrationInner and initialize inner last?
> 
> We need a pointer to the entire struct when calling
> bindings::request_irq. I'm not sure this allows you to easily get one?
> I don't think using container_of! here is worth it.

Would `try_pin_init!(&this in Self { ...` work?

