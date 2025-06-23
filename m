Return-Path: <linux-pci+bounces-30454-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EFA2AE4D7B
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 21:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B97D3B80A2
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 19:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EF82D542C;
	Mon, 23 Jun 2025 19:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XWyxxhT+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBE91E1DFE;
	Mon, 23 Jun 2025 19:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750706300; cv=none; b=XanOP3sCpEjVz3vTdEoBsFL09+vKAp4LqjGtslxaUCMeUgYuGvUNzFwLEK/NtDlJIPlzmNEDH+6/EaWpuM5QklOhZ16MLGoYGUiiSoXF0B2jqSS1WbTFtGV30KlokWXJiCAD/EGjsV/zjxh/PesYxrkHH7aveCY7eEKmtq5xuIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750706300; c=relaxed/simple;
	bh=CCa+qFwoB/4SE/mJsQWrLXlV9mWW5ISzIjMEdBOmqMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S2aBzLotOe194UGtEfVvoIS224bvEA6G1X+P9afQ4VhbtDq/UQbzbaZqU5qBYst/1ji0AGgdqmajlDI6APY1kC+E0hm8m394Gk4YKYVjJbM575I7qvl1MxDorJgYHn2BEnlU+b3s1h8oEK0PDA1JER/tNRFuz6EjCz/Z1XvsL6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XWyxxhT+; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a440a72584so50865911cf.2;
        Mon, 23 Jun 2025 12:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750706297; x=1751311097; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jpuQIftcNsqHfftfV777iY5f4fxqvsRYD0zJxsdnOrY=;
        b=XWyxxhT+AySUgbO6ukKov3HjUilYgiM5ACML45d7/JGyTwsjB2EuLLCX/90Qg11qjg
         pnQ6kk7lqk03hkp5uOgLbZyOqpVC3OSQfZXXnEvgIfhR9yWIIfp4DHlYSYPNZHSxjSr6
         m7ufwD8I2vvbbdQjnITivRr+J5OZ09b+xK5aUTmak7CjhvdfMsflUDCehjxL9yL8AF9C
         GGgBRvR3bGMN28ol63MNxoVm6hk5YYLTZjdYYg2jr41fxmWIN1Be2NImt88ooGUDHLCB
         covyFBbAxcSR0cvfEU1FvgUeDPEw+kveb6++sSn4t2uierLs6dIuOi/rGRwg3MlYX3jy
         ssbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750706297; x=1751311097;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jpuQIftcNsqHfftfV777iY5f4fxqvsRYD0zJxsdnOrY=;
        b=IgYj0v+1hwH02FcN0fQiNdZTiQ9/MEqRxv209xlC9+/vgyTGFRHGUgw/awyFCd+unK
         dcDuDD8C9bj9cO4A3ezS/flejQosapnRqZLXEEFtpo6cmvRjJpP1YhTxKDqDSRDEQF7c
         qyQGy39o32ZMYK0WNnWADJJg/1exTA+rpSYcWtfF+hEEA4Ncubi5TQhvLA6FArAO2Tfa
         sCmnxrwQgYv9KRb9p+nK3mFgN898fUNYQucqRhCZ1dftsJZqExBXHo2e9TfeZK1eREaE
         PIQKEfjusGN3D1MAv3QH7uDYcld0h9HTmX9ChUjeR6DoF1ZpgciolUBVQfisZkHfuo8S
         e/xA==
X-Forwarded-Encrypted: i=1; AJvYcCU9SqWuo3bpdBlPoaGoYC8kgPuRsFM4f69WA02kiuK2DLORH3Fx5Ns9eJeAZpbt50fSQoRfjoYnMvHmzGdPefE=@vger.kernel.org, AJvYcCVmfSaE2Vdj1mJmwaKPvj+4sAVRX/sjnos4wUeZgHrBkghRKDcAQo7q2+Y9RFwNrUI3kxNeE1Damft3xeM=@vger.kernel.org, AJvYcCX0E/V9Abv5jF0PeriF9DtxufL9hiEgUtCJ3iBmhlk10EqCV+Muc3tRDSmrl03Pkvo0xSHzGabMunk3@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrj6X0djS9DpC6yd7BScQRiFzfv6iGabxKjHCF8kHsCN0V3YuA
	g8iaIPUmH5kct+BFny/iHFcIK8q6AEQDGAuWVEZncW5cmpz6nDd0Rhhc
X-Gm-Gg: ASbGncsVNZyCCKDV2uA9pEsMog0pyyCiPI0oRzlBrHHj/KvbJYQT+IiEVN0xs2JUfGy
	Bs2g6wZd14/485ZgkJlhNzZoj1WIhMRp9cF0Mz++ih0+18/vGwqejr+jsSYxL80wtQYVfbCdxJc
	Rbc3dGHuyUXYf++cHZACxWZ8BJ6Se/wZynL/T7HTMOKT82I1ATrYvx9F335VdjiGLWPO2f0w7by
	6F/I60S7oTI98dZvLcJhR69Ye90MRLOYVgRqIi/J2fOGQrNrNLDEqW8pt6C77Vckmg76COzNw6h
	RuUUgfQZPfged6WsAik5Qvq+G8sYGQGvqC8cyJ+iOMxiJiG95Hhl13jkjIANav1J2+J/oq0+Pdr
	5+3ZCnVQ4hBhMarBqwRH0U8GpoG8Eq0NDfo0992/FcQe1NGYO7B4Z24Nr3tO+ZMk=
X-Google-Smtp-Source: AGHT+IFDVtOnWaqm/7AYzXA/NCwVetvA+PYk1LTyOkW68YxjyQbu07rbo67Ap4gWE/PQS9AvQbcpCw==
X-Received: by 2002:a05:622a:246:b0:4a4:31a0:68d1 with SMTP id d75a77b69052e-4a77a24c1b1mr203720071cf.21.1750706296698;
        Mon, 23 Jun 2025 12:18:16 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a779d6635fsm42084201cf.20.2025.06.23.12.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 12:18:16 -0700 (PDT)
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id BBDE21200043;
	Mon, 23 Jun 2025 15:18:15 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Mon, 23 Jun 2025 15:18:15 -0400
X-ME-Sender: <xms:d6hZaGiSWPoZVr7-XJbCk1XCtZ4VZ8n1yiTBfrA3AfirFzoZU4YHGA>
    <xme:d6hZaHDiFZvDlziWg6p8aBa58EET3wLKe0wc78TY1UdAul8gPhVxQkEEhm8hg8aC6
    Ullijl00MUi5VUfxg>
X-ME-Received: <xmr:d6hZaOFhYog7ZHl08Z29HJCalwgxkfH9vcq3lQl3ZrMaKjSgnHWc_U4yHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddujeekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeevgffhueevkedutefgveduuedujeefledthffgheegkeekiefgudekhffggeel
    feenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepudelpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopehlohhsshhinheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprghlihgtvg
    hrhihhlhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopegurghnihgvlhdrrghlmhgvihgurgestgholhhlrggsohhrrg
    drtghomhdprhgtphhtthhopehojhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegrlhgvgidrghgrhihnohhrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihse
    hgrghrhihguhhordhnvghtpdhrtghpthhtohepsghjohhrnhefpghghhesphhrohhtohhn
    mhgrihhlrdgtohhmpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:d6hZaPQ-IxSUgUcyznCAW6LU4uVBu2pZ_2M40QgDZAKciR2el6VXOg>
    <xmx:d6hZaDzKxBoz_c3uzFW4spHml9otF4y_sRN8kmE8yL6VGvIsCkSjFA>
    <xmx:d6hZaN6fsitWCXaqkwl7hgXFgxZBavnYTKNRWk6ranoe4dU8HepI0w>
    <xmx:d6hZaAwX9W1ox7GznsMmTS08je1Bn7cTPkPsZqA9a9jeu1nZvAqmGA>
    <xmx:d6hZaPhk0LOdasJBJc2walhSSM6-Qa7z3mZaeUU0Lna3I3MHZypmGFtj>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Jun 2025 15:18:15 -0400 (EDT)
Date: Mon, 23 Jun 2025 12:18:14 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Danilo Krummrich <dakr@kernel.org>,
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
Message-ID: <aFmodsQK6iatXKoZ@tardis.local>
References: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com>
 <20250608-topics-tyr-request_irq-v4-3-81cb81fb8073@collabora.com>
 <aEbJt0YSc3-60OBY@pollux>
 <CAH5fLghDbrgO2PiKyKZ87UrtouG25xWhVP_YmcgO0fFcnvZRkQ@mail.gmail.com>
 <DAU0NHTHTDG4.2HNEABNAI8GHZ@kernel.org>
 <aFmPZMLGngAE_IHJ@tardis.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFmPZMLGngAE_IHJ@tardis.local>

On Mon, Jun 23, 2025 at 10:31:16AM -0700, Boqun Feng wrote:
> On Mon, Jun 23, 2025 at 05:26:14PM +0200, Benno Lossin wrote:
> > On Mon Jun 23, 2025 at 5:10 PM CEST, Alice Ryhl wrote:
> > > On Mon, Jun 9, 2025 at 12:47 PM Danilo Krummrich <dakr@kernel.org> wrote:
> > >> On Sun, Jun 08, 2025 at 07:51:08PM -0300, Daniel Almeida wrote:
> > >> > +        dev: &'a Device<Bound>,
> > >> > +        irq: u32,
> > >> > +        flags: Flags,
> > >> > +        name: &'static CStr,
> > >> > +        handler: T,
> > >> > +    ) -> impl PinInit<Self, Error> + 'a {
> > >> > +        let closure = move |slot: *mut Self| {
> > >> > +            // SAFETY: The slot passed to pin initializer is valid for writing.
> > >> > +            unsafe {
> > >> > +                slot.write(Self {
> > >> > +                    inner: Devres::new(
> > >> > +                        dev,
> > >> > +                        RegistrationInner {
> > >> > +                            irq,
> > >> > +                            cookie: slot.cast(),
> > >> > +                        },
> > >> > +                        GFP_KERNEL,
> > >> > +                    )?,
> > >> > +                    handler,
> > >> > +                    _pin: PhantomPinned,
> > >> > +                })
> > >> > +            };
> > >> > +
> > >> > +            // SAFETY:
> > >> > +            // - The callbacks are valid for use with request_irq.
> > >> > +            // - If this succeeds, the slot is guaranteed to be valid until the
> > >> > +            // destructor of Self runs, which will deregister the callbacks
> > >> > +            // before the memory location becomes invalid.
> > >> > +            let res = to_result(unsafe {
> > >> > +                bindings::request_irq(
> > >> > +                    irq,
> > >> > +                    Some(handle_irq_callback::<T>),
> > >> > +                    flags.into_inner() as usize,
> > >> > +                    name.as_char_ptr(),
> > >> > +                    slot.cast(),
> > >> > +                )
> > >> > +            });
> > >> > +
> > >> > +            if res.is_err() {
> > >> > +                // SAFETY: We are returning an error, so we can destroy the slot.
> > >> > +                unsafe { core::ptr::drop_in_place(&raw mut (*slot).handler) };
> > >> > +            }
> > >> > +
> > >> > +            res
> > >> > +        };
> > >> > +
> > >> > +        // SAFETY:
> > >> > +        // - if this returns Ok, then every field of `slot` is fully
> > >> > +        // initialized.
> > >> > +        // - if this returns an error, then the slot does not need to remain
> > >> > +        // valid.
> > >> > +        unsafe { pin_init_from_closure(closure) }
> > >>
> > >> Can't we use try_pin_init!() instead, move request_irq() into the initializer of
> > >> RegistrationInner and initialize inner last?
> > >
> > > We need a pointer to the entire struct when calling
> > > bindings::request_irq. I'm not sure this allows you to easily get one?
> > > I don't think using container_of! here is worth it.
> > 
> > There is the `&this in` syntax (`this` is of type `NonNull<Self>`):
> > 
> >     try_pin_init!(&this in Self {
> >         inner: Devres::new(
> >             dev,
> >             RegistrationInner {
> >                 irq,
> >                 cookie: this.as_ptr().cast(),
> >             },
> >             GFP_KERNEL,
> >         )?,
> >         handler,
> >         _pin: {
> >             to_result(unsafe {
> >                 bindings::request_irq(
> >                     irq,
> >                     Some(handle_irq_callback::<T>),
> >                     flags.into_inner() as usize,
> >                     name.as_char_ptr(),
> >                     slot.as_ptr().cast(),
> 
> this is "this" instead of "slot", right?
> 
> >                 )
> >             })?;
> >             PhantomPinned
> >         },
> >     })
> > 
> > Last time around, I also asked this question and you replied with that
> > we need to abort the initializer when `request_irq` returns false and
> > avoid running `Self::drop` (thus we can't do it using `pin_chain`).
> > 
> > I asked what we could do instead and you mentioned the `_: {}`
> > initializers and those would indeed solve it, but we can abuse the
> > `_pin` field for that :)
> > 
> 
> Hmm.. but if request_irq() fails, aren't we going to call `drop` on
> `inner`, which drops the `Devres` which will eventually call
> `RegistrationInner::drop()`? And that's a `free_irq()` without
> `request_irq()` succeeded.
> 

This may however work ;-) Because at `request_irq()` time, all it needs
is ready, and if it fails, `RegistrationInner` won't construct.

    try_pin_init!(&this in Self {
        handler,
        inner: Devres::new(
            dev,
            RegistrationInner {
                // Needs to use `handler` address as cookie, same for
                // request_irq().
                cookie: &raw (*(this.as_ptr().cast()).handler),
                irq: {
                     to_result(unsafe { bindings::request_irq(...) })?;
					 irq
				}
             },
             GFP_KERNEL,
        )?,
        _pin: PhantomPinned
    })

Regards,
Boqun

> Regards,
> Boqun
> 
> > ---
> > Cheers,
> > Benno

