Return-Path: <linux-pci+bounces-30512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1DAAE6A0B
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 17:05:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0CEF188FE0B
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 14:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2951F291C1A;
	Tue, 24 Jun 2025 14:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZW58Sxw"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEFF624A061;
	Tue, 24 Jun 2025 14:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750777021; cv=none; b=ki9ojwgJb7zbtFil7JATVQfIMCl1xGOuh9iX99TBs0SI7SJt+4Qrqac1pyou0rIgClKeR3PTxxo51Hl3HGf6r0h7iBs2I16sjKYPPhP1qz53HaqW6aSEMRBKBT6C1PIMadtc1tjhTIMXwJAP9E+0yoEqg5iYK+asvfeUPyhqhVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750777021; c=relaxed/simple;
	bh=qC2AQ1Lw6HN7N4g1YhVAubrvXg5LAd5u7Gh1vWIUfrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l/aLR0ZVEo1H9jWpsyxma+sUOExPvPVAweYV6dmcb0tVwJmDRGPPcU7ukhCPfQZs2y2vncsJSdNktkRwsCYNp+X5RkjNtQ9q896C8c6OEogUm/JzWPWjHrZCuKTFxm2FU8SsDpjR3n3JSLo0kTtL89NFDgcaqfxV6QNFFEC8Eaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZW58Sxw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01464C4CEE3;
	Tue, 24 Jun 2025 14:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750777020;
	bh=qC2AQ1Lw6HN7N4g1YhVAubrvXg5LAd5u7Gh1vWIUfrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nZW58SxwTBlqqKNnohjDEkSoza6dXOupBV8Da96J7Bvrs3nWMqKEs2XqsN0k+qQFr
	 1wxD230VQkqc3m8CTirl6HxacphKkDbR7LOZna1klvrRwnkqCZGjyBS86pI4tjttiA
	 gXpRfQmxux57wzT52SOuhfBMv4rsZLjJhqOzfXRanqZwLoQm0F0RJCB+RAgCZqiDm0
	 vhSqXiNT3A8UWJxFHK4v5RCiTYLExtm4tLAC7XyYDnxwGPp6iMSM8bn+c8H3sYD3Yd
	 YUpZykmhAVvUbJIE2zKA3NVoufSx9xwXd7zitfVh3hP2F+B/pJxDtmaL1AXpVfdGHS
	 pbPxnJ6X9Rleg==
Date: Tue, 24 Jun 2025 16:56:54 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Alice Ryhl <aliceryhl@google.com>, Benno Lossin <lossin@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kwilczynski@kernel.org>,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
Message-ID: <aFq8tiJfU-KshBIN@cassiopeiae>
References: <CAH5fLghDbrgO2PiKyKZ87UrtouG25xWhVP_YmcgO0fFcnvZRkQ@mail.gmail.com>
 <DAU0NHTHTDG4.2HNEABNAI8GHZ@kernel.org>
 <aFmPZMLGngAE_IHJ@tardis.local>
 <aFmodsQK6iatXKoZ@tardis.local>
 <DAU5TAFKJQOF.2DFO7YAHZA4V2@kernel.org>
 <DB7F39EC-5F7D-49DA-BF2B-6200998B45E2@collabora.com>
 <DAURVNHM7PKM.PLUFKFRVXR25@kernel.org>
 <CAH5fLggs=mUi0xAEuiLvZrua4qrMYjBDEmyK8xc-kkXVyUKRog@mail.gmail.com>
 <aFq3P_4XgP0dUrAS@Mac.home>
 <aFq5PVhm3ybiw12I@Mac.home>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFq5PVhm3ybiw12I@Mac.home>

On Tue, Jun 24, 2025 at 07:42:05AM -0700, Boqun Feng wrote:
> On Tue, Jun 24, 2025 at 07:33:35AM -0700, Boqun Feng wrote:
> > On Tue, Jun 24, 2025 at 02:50:23PM +0100, Alice Ryhl wrote:
> > > On Tue, Jun 24, 2025 at 1:46 PM Benno Lossin <lossin@kernel.org> wrote:
> > > >
> > > > On Tue Jun 24, 2025 at 2:31 PM CEST, Daniel Almeida wrote:
> > > > > On 23 Jun 2025, at 16:28, Benno Lossin <lossin@kernel.org> wrote:
> > > > >> On Mon Jun 23, 2025 at 9:18 PM CEST, Boqun Feng wrote:
> > > > >>>    try_pin_init!(&this in Self {
> > > > >>>        handler,
> > > > >>>        inner: Devres::new(
> > > > >>>            dev,
> > > > >>>            RegistrationInner {
> > > > >>>                // Needs to use `handler` address as cookie, same for
> > > > >>>                // request_irq().
> > > > >>>                cookie: &raw (*(this.as_ptr().cast()).handler),
> > > > >>>                irq: {
> > > > >>>                     to_result(unsafe { bindings::request_irq(...) })?;
> > > > >>>  irq
> > > > >>> }
> > > > >>>             },
> > > > >>>             GFP_KERNEL,
> > > > >>>        )?,
> > > > >>>        _pin: PhantomPinned
> > > > >>>    })
> > > > >>
> > > > >> Well yes and no, with the Devres changes, the `cookie` can just be the
> > > > >> address of the `RegistrationInner` & we can do it this way :)
> > > > >>
> > > > >> ---
> > > > >> Cheers,
> > > > >> Benno
> > > > >
> > > > >
> > > > > No, we need this to be the address of the the whole thing (i.e.
> > > > > Registration<T>), otherwise you can’t access the handler in the irq
> > > > > callback.
> > 
> > You only need the access of `handler` in the irq callback, right? I.e.
> > passing the address of `handler` would suffice (of course you need
> > to change the irq callback as well).
> > 
> > > >
> > > > Gotcha, so you keep the cookie field, but you should still be able to
> > > > use `try_pin_init` & the devres improvements to avoid the use of
> > > > `pin_init_from_closure`.
> > > 
> > > It sounds like this is getting too complicated and that
> > > `pin_init_from_closure` is the simpler way to go.
> > 
> > Even if we use `pin_init_from_closure`, we still need the other
> > `try_pin_init` anyway for `Devres::new()` (or alternatively we can
> > implement a `RegistrationInner::new()`).
> > 
> > Below is what would look like with the Devres changes in mind:
> > 
> > 
> >     try_pin_init!(&this in Self {
> >         handler,
> >         inner: <- Devres::new(
> >             dev,
> >             try_pin_init!( RegistrationInner {
> >                 // Needs to use `handler` address as cookie, same for
> >                 // request_irq().
> >                 cookie: &raw (*(this.as_ptr().cast()).handler),
> > 		// @Benno, would this "this" work here?
> >                 irq: {
> >                      to_result(unsafe { bindings::request_irq(...) })?;
> >                      irq
> > 		}
> >              }),
> >         )?,
> >         _pin: PhantomPinned
> >     })
> > 
> > 
> 
> Never mind, `dev` is a `Device<Bound>` so it cannot be unbounded during
> the call ;-)

We even know that `dev` won't be unbound as long as the returned
`impl PinInit<Self, Error> + 'a` lives. :)

