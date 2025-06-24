Return-Path: <linux-pci+bounces-30510-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC7AAE6924
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 16:41:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0CB1172890
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 14:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124B92DCC14;
	Tue, 24 Jun 2025 14:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FUvrG8qO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 462312D9EFA;
	Tue, 24 Jun 2025 14:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775621; cv=none; b=eCcb9Ep17fTMgtB3/szP9yfno7LoUh8mce0rEr8FlMoTAHo5sHUTLkIl59iWq0jFfChhcGI3vjlnTRYW/OntwvG1M+UGkW6xc2Nkw3qrBNYnojXUmNkoFa7yBzjv2AlB1YVedC7CPogkhJ7KaS+ILcPH61ozqoPcF95RTKAgZXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775621; c=relaxed/simple;
	bh=IyJssq8KQZESml2syoX57O55DaGL7ZmRxkjyIytJPlc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s/5qO3o8trE8JSqma2v31T4150SNOjPjkWDGiFpLrwNuAvdkqT+5e7mVl6v93PCEuG0BkLIpZjn4GPF1ufAPLzi1OVy1x3y9yeVVVt6tI74/Pt3eZR2glk4bq3EKQWqzrk+8paD68kPWWCHzviL1LLxkoW6hCW5QXVoK4pAK+Y0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FUvrG8qO; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4a44b0ed780so70675991cf.3;
        Tue, 24 Jun 2025 07:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750775618; x=1751380418; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3BImKye52YH8WQTNtrdrUxGtt4q9A40a/QP8jv/xO/M=;
        b=FUvrG8qOo1n9U57nO6vAzgcAZeNfP6ZpLf8TU91ZnEn2cpXRDOx5uAL6h3/DKXV9eV
         CmHNJyJxnFXi5JpvbfxAXAVaWi5ztWvZAKf9rrYmv0HH/6g7a9W7/60XdPqWAXidM3IW
         2rkyDRHrT/6z4naeBSk4Eez3xYP8m/2wshxLW5wQK5oqxbwiZ81+1f9CXpC7vyw18lIA
         3OcsaPVxFqh1Ygi/7yZysm3dNSnSAum61ros3utCPs7m4+AdcS6ojjQIVi5MV9gIezFw
         /xFY9xByTxRF3K29esc+FvznPhGy5HGSuTt+YpehvbqRNL8k+s1uxYJ7dimXyGwE7jkw
         7qBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750775618; x=1751380418;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3BImKye52YH8WQTNtrdrUxGtt4q9A40a/QP8jv/xO/M=;
        b=uthaHOrFMpMRwiNfzC6D5fs9ZNZZtdf/qcaI8i5ruW1UtVMhWEVvfvfiTPrOsY+az9
         c9z82fdaz9jnqSzPHvNcQUuRvU56F/xmj3BWpdcn9e3W28R7ZThApm2I0864cB0H4T+D
         SPQM3MehtLPtpW7dbR+1brNZ2kkayobYk3ijqTTumXcCEKZ91t/6FFMznqWcjKzlgt6u
         3rmYAGf+HfgrZtr0JmFdgn4mvaQ5L2ynuUG3/XbqStBHhE/1hKtcEM1WfKMl4xuw8jZ9
         SyrGkPumcBAOXvWhu7aJFhzf7kdpYCKh5KTc8y1x4fWAUsI/FZWnIV+vQ86RYoD6y0fv
         Dyfg==
X-Forwarded-Encrypted: i=1; AJvYcCURM0zAo0LhjDrZlmsf4jIddhnkPYXgEMHClF0GuOcr1Jgc8T6TZKCadMIjDG7gnlNa3hGKNSAI1s0u7xeil7o=@vger.kernel.org, AJvYcCUll1beASdf0amW51M4owbqH9sb9epndWLa9TrFfs40kckI/RoHz7I3Qst6Ib12Yophj+KXJGotOO206Ao=@vger.kernel.org, AJvYcCVGFJVvPYmJw0AnfnYI/xw/P6BxDmX+0mZtQK1ayo4i0wZMXCIleHnvhOnNtcKHi0wfr0TH9Y1pG8Ti@vger.kernel.org
X-Gm-Message-State: AOJu0YyGqnvLQFFvFywKEh3VIHmNt/Lv93dtLaoTeyCSQzeac/km3bUC
	V86rNz74Z44Rpkqh0lxHBkPKfuOjG050yt1Tn+P54F9/ieOhLrkzQKKv
X-Gm-Gg: ASbGnct3EQcmEcdNtEk0bG+JfYvve5F/ND6jidi1aVMcd+22+tyfPlHj1x1bemjsKvj
	WArSIRJ8q54dVOJl7hMmROjl3sGlXCZKEm9eaQeuKbgz4Wah36oU3zzO+RDxMC9l8lkiXODCt+O
	gDSTuUnEu+hU5Bc7w16LIJOJT058LosA9lHnmmU3irHohHd/iRCgQa6aiMb2pzRYTAPgQPP6XwS
	lenrwPH05/3wVTZp5ak2w5iBaC/TVKoNLzOCLVngfVsxMGa+WRFToPHDEll8CUr8+QAi7v/mn+e
	nD0kyLMVc5b7rwDHtBbfN8k2zayj+jCpWBve47HOon+jIwJfk3/24LdsAgwL88/yI/uk10sVGRp
	JnP5qoakpc7Ms4L1xjrULe/Pz4KG1Ewt8B7QAOP0B/KCj97EItcx7FuaXX74QxNc=
X-Google-Smtp-Source: AGHT+IFUjTTy2TCvd3mgkVOQjlWnYSqYIp/ggecJXWpuWRBjOnpyDp3AFU5AHYeI/Wjlk+lGMWojUw==
X-Received: by 2002:a05:622a:5c8:b0:4a6:f0da:82ab with SMTP id d75a77b69052e-4a77a2eac80mr275367361cf.52.1750775618019;
        Tue, 24 Jun 2025 07:33:38 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a779d4e5bbsm49840491cf.11.2025.06.24.07.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 07:33:37 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 03BBB1200068;
	Tue, 24 Jun 2025 10:33:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 24 Jun 2025 10:33:37 -0400
X-ME-Sender: <xms:QLdaaINHcRQvUXLpsNFAEAEhaVjTFTa0pDX1Be7xP8rB5OtwImaGNA>
    <xme:QLdaaO9ANUnG2oBJZldVTJC75RMos8DXVAS3kZ4PxHt_ZA_iNwTP7cSkatqcYLusY
    dcUpRvK18vDVGx3Iw>
X-ME-Received: <xmr:QLdaaPS3txnroSvr1aA0qFR2tRmWHcTtgAXhYOcAipLiORVWMIFWon3FUg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvtddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeevgffhueevkedutefgveduuedujeefledthffgheegkeekiefgudekhffggeel
    feenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepudelpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopehloh
    hsshhinheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrnhhivghlrdgrlhhmvghi
    uggrsegtohhllhgrsghorhgrrdgtohhmpdhrtghpthhtohepuggrkhhrsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihse
    hgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhn
    mhgrihhlrdgtohhmpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:QLdaaAv3UXSIiuVM7Ysf2-vSE6_s-qG5QW1iHEHMshv3xMyifMwXWw>
    <xmx:QLdaaAfWQa-6Y5ZHaYBd5ezgLWVfQkWOY_6ErfGmSSWjUqD_A6_ozg>
    <xmx:QLdaaE0HraYx6gp3rD9baTGF-ismI1oEpqIuSDAOZxrgWffsPETg5g>
    <xmx:QLdaaE_b1F9zyZSkHowwP9FlujG64iJw6XeL2mI9xwJcpeMJHIrfyw>
    <xmx:QLdaaH8nL8KHtWEmdmNtwDIms5aBfi3O9xaNbTaEDLuuPxLUnBMNcgIb>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 10:33:36 -0400 (EDT)
Date: Tue, 24 Jun 2025 07:33:35 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Benno Lossin <lossin@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
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
Message-ID: <aFq3P_4XgP0dUrAS@Mac.home>
References: <20250608-topics-tyr-request_irq-v4-3-81cb81fb8073@collabora.com>
 <aEbJt0YSc3-60OBY@pollux>
 <CAH5fLghDbrgO2PiKyKZ87UrtouG25xWhVP_YmcgO0fFcnvZRkQ@mail.gmail.com>
 <DAU0NHTHTDG4.2HNEABNAI8GHZ@kernel.org>
 <aFmPZMLGngAE_IHJ@tardis.local>
 <aFmodsQK6iatXKoZ@tardis.local>
 <DAU5TAFKJQOF.2DFO7YAHZA4V2@kernel.org>
 <DB7F39EC-5F7D-49DA-BF2B-6200998B45E2@collabora.com>
 <DAURVNHM7PKM.PLUFKFRVXR25@kernel.org>
 <CAH5fLggs=mUi0xAEuiLvZrua4qrMYjBDEmyK8xc-kkXVyUKRog@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLggs=mUi0xAEuiLvZrua4qrMYjBDEmyK8xc-kkXVyUKRog@mail.gmail.com>

On Tue, Jun 24, 2025 at 02:50:23PM +0100, Alice Ryhl wrote:
> On Tue, Jun 24, 2025 at 1:46 PM Benno Lossin <lossin@kernel.org> wrote:
> >
> > On Tue Jun 24, 2025 at 2:31 PM CEST, Daniel Almeida wrote:
> > > On 23 Jun 2025, at 16:28, Benno Lossin <lossin@kernel.org> wrote:
> > >> On Mon Jun 23, 2025 at 9:18 PM CEST, Boqun Feng wrote:
> > >>>    try_pin_init!(&this in Self {
> > >>>        handler,
> > >>>        inner: Devres::new(
> > >>>            dev,
> > >>>            RegistrationInner {
> > >>>                // Needs to use `handler` address as cookie, same for
> > >>>                // request_irq().
> > >>>                cookie: &raw (*(this.as_ptr().cast()).handler),
> > >>>                irq: {
> > >>>                     to_result(unsafe { bindings::request_irq(...) })?;
> > >>>  irq
> > >>> }
> > >>>             },
> > >>>             GFP_KERNEL,
> > >>>        )?,
> > >>>        _pin: PhantomPinned
> > >>>    })
> > >>
> > >> Well yes and no, with the Devres changes, the `cookie` can just be the
> > >> address of the `RegistrationInner` & we can do it this way :)
> > >>
> > >> ---
> > >> Cheers,
> > >> Benno
> > >
> > >
> > > No, we need this to be the address of the the whole thing (i.e.
> > > Registration<T>), otherwise you can’t access the handler in the irq
> > > callback.

You only need the access of `handler` in the irq callback, right? I.e.
passing the address of `handler` would suffice (of course you need
to change the irq callback as well).

> >
> > Gotcha, so you keep the cookie field, but you should still be able to
> > use `try_pin_init` & the devres improvements to avoid the use of
> > `pin_init_from_closure`.
> 
> It sounds like this is getting too complicated and that
> `pin_init_from_closure` is the simpler way to go.

Even if we use `pin_init_from_closure`, we still need the other
`try_pin_init` anyway for `Devres::new()` (or alternatively we can
implement a `RegistrationInner::new()`).

Below is what would look like with the Devres changes in mind:


    try_pin_init!(&this in Self {
        handler,
        inner: <- Devres::new(
            dev,
            try_pin_init!( RegistrationInner {
                // Needs to use `handler` address as cookie, same for
                // request_irq().
                cookie: &raw (*(this.as_ptr().cast()).handler),
		// @Benno, would this "this" work here?
                irq: {
                     to_result(unsafe { bindings::request_irq(...) })?;
                     irq
		}
             }),
        )?,
        _pin: PhantomPinned
    })


Besides, working on this made me realize that we have to request_irq()
before `Devres::new()`, otherwise we may leak the irq resource,
considering the follow code from the current `pin_init_from_closure`
approach:

        let closure = move |slot: *mut Self| {
            // SAFETY: The slot passed to pin initializer is valid for writing.
            unsafe {
                slot.write(Self {
                    inner: Devres::new(
                        dev,
                        RegistrationInner {
                            irq,
                            cookie: slot.cast(),
                        },
                        GFP_KERNEL,
                    )?,
                    handler,
                    _pin: PhantomPinned,
                })
            };

`dev` can be unbound at here, right? If so, the devm callback will
revoke the `RegistrationInner`, `RegistrationInner::drop()` will then
call `free_irq()` before `request_irq()`, the best case is that we would
request_irq() with no one going to free it.

            // SAFETY:
            // - The callbacks are valid for use with request_irq.
            // - If this succeeds, the slot is guaranteed to be valid until the
            // destructor of Self runs, which will deregister the callbacks
            // before the memory location becomes invalid.
            let res = to_result(unsafe {
                bindings::request_irq(
                    irq,
                    Some(handle_irq_callback::<T>),
                    flags.into_inner() as usize,
                    name.as_char_ptr(),
                    slot.cast(),
                )
            });
            ...
        }

So seems to me the order of initialization has to be:

1. Initialize the `handler`.
2. `request_irq()`, i.e initialize the `RegistrationInner`.
3. `Devres::new()`, i.e initialize the `Devres`.

Regards,
Boqun

