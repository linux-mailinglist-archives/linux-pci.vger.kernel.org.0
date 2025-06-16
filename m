Return-Path: <linux-pci+bounces-29870-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9422CADB260
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 15:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5E3E1882D9D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Jun 2025 13:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D192877CF;
	Mon, 16 Jun 2025 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPjbSuU1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56022877C2;
	Mon, 16 Jun 2025 13:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750081421; cv=none; b=TvXZvReWzKHBUz1P5n7IgPOrs2Kl8Zwfy3POLr/M8O2FRZHrk3sDojfsaHxwLkinwEqecWb6X2HetTXuTx11W0OFcOGmzJ6LkqYv7elBkgoyQCnCrqp4g5Y2JYiOIo8G1JyDS2Yv15Nnjdrk7NasUrVDhRfmulrTcdl3lqV0jUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750081421; c=relaxed/simple;
	bh=fZ1eh8wNphknetjgbS9kIkHdBLVSvB3bGOQQSPb1rYA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VMRvwttBbyJp5N/XOrNXj4YbsoyiCrnTVWgxa5rSGQCwE0CpI0NrCe3wSNmEOyExjhAElzQr5E6LsDFgoj/lDN9Ijm0D9buslIW97jJkXW7C3uE0PyK8ZauUhGXVkOiU8HU+aL8mAw61mvZxwau3v+VWw3wmOmDWqwiw592h9Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPjbSuU1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C1CC4CEEA;
	Mon, 16 Jun 2025 13:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750081420;
	bh=fZ1eh8wNphknetjgbS9kIkHdBLVSvB3bGOQQSPb1rYA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XPjbSuU14xto+sqSHH8NF5VTqrn/1Hrl2/q2aaOd1A4le6Pmsc7Qy9VEscsuVvlKN
	 JUIs9Lgnx3MZGHDE3tG4ifPa4tu05TVF3UvFIWn7UxYW6io3auQC+19viueCxaK6Gy
	 Ox5BltIC9g9iPtzYHOS93/2CiGBd8tMK/jt7OFpzlqY8NtpQKO3V23SY3Oe/acp0d0
	 XQP4iYjJYlNchS836OOYXQQ3czqwDCv0jsWKQ/+f6jeur5QB0BDWVI50bTEhnc9P/M
	 Qf61+LfnWAjxqQQ+ikJk1Ln082Gze9KtwU7cnsfVoFMHKT8zVVlADHmpAOMlWRmKG+
	 Cf6p5OBhDbceg==
Date: Mon, 16 Jun 2025 15:43:34 +0200
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
Subject: Re: [PATCH v4 4/6] rust: irq: add support for threaded IRQs and
 handlers
Message-ID: <aFAfhsuvEQFOd4MJ@pollux>
References: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com>
 <20250608-topics-tyr-request_irq-v4-4-81cb81fb8073@collabora.com>
 <aEbTOhdfmYmhPiiS@pollux>
 <5B3865E5-E343-4B5D-9BF7-7B9086AA9857@collabora.com>
 <aEckTQ2F-s1YfUdu@pollux.localdomain>
 <CAH5fLgj+za85ajgNwJepoa7PSFkMm+3J2wJJVJ24m6YZoFVmVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgj+za85ajgNwJepoa7PSFkMm+3J2wJJVJ24m6YZoFVmVw@mail.gmail.com>

On Mon, Jun 16, 2025 at 03:33:06PM +0200, Alice Ryhl wrote:
> On Mon, Jun 9, 2025 at 8:13 PM Danilo Krummrich <dakr@kernel.org> wrote:
> > I think with specialization it'd be trivial to generalize, but this isn't
> > stable yet. The enum approach is probably unnecessarily complicated, so I agree
> > to leave it as it is.
> >
> > Maybe a comment that this can be generalized once we get specialization would be
> > good?
> 
> Specialization is really far out. I don't think we should try to take
> it into account when designing things today. I think that the
> duplication in this case is perfectly acceptable and trying to
> deduplicate makes things too hard to read.

As mentioned above, I agree with the latter. But I think leaving a note that
this could be deduplicated rather easily with specialization probably doesn't
hurt?

> > I'm thinking of something like
> >
> >         /// # Invariant
> >         ///
> >         /// `ěrq` is the number of an interrupt source of `dev`.
> >         struct IrqRequest<'a> {
> >            dev: &'a Device<Bound>,
> >            irq: u32,
> >         }
> >
> > and from the caller you could create an instance like this:
> >
> >         // INVARIANT: [...]
> >         let req = IrqRequest { dev, irq };
> >
> > I'm not sure whether this needs an unsafe constructor though.
> 
> The API you shared would definitely work. It pairs the irq number with
> the device it matches. Yes, I would probably give it an unsafe
> constructor, but I imagine that most methods that return an irq number
> could be changed to just return this type so that drivers do not need
> to use said unsafe.

Driver don't need to use unsafe already. It's only the IRQ accessors in this
patch series (in platform.rs and pci.rs) that are affected.

Let's also keep those accessors, from a driver perspective it's much nicer to
have an API like this, i.e.

	// `irq` is an `irq::Registration`
	let irq = pdev.threaded_irq_by_name()?

vs.

	// `req` is an `IrqRequest`.
	let req = pdev.irq_by_name()?;

	// `irq` is an `irq::Registration`
	let irq = irq::ThreadedRegistration::new(req)?;

