Return-Path: <linux-pci+bounces-30436-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84638AE4BED
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 19:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4875F3B9189
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 17:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5109B2C1594;
	Mon, 23 Jun 2025 17:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZamZ7Qm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9412BCF46;
	Mon, 23 Jun 2025 17:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750699882; cv=none; b=ZCbJUViuW8Q7yOyjaR9Xo+kvgifsADM2pXvI1rLp+7welOVb2T35GMfqGs820TRv7R9FbW6ks78Iyulqs1rnFjEHN4J4m8voNKNKIVACQkbY2sXEv6rXI2Arj2i+51AcRrYbmdsJCrS2xjHrz5nEE9Q86BtiE61Q8/K3Xr/JEMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750699882; c=relaxed/simple;
	bh=oCgEQgO3bcbZLJtDxpHb9KgnCYnRxnZxSy2tdQTsiA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzEXS2m/mrhQvwoTTS0cORDwqCYO3ptHsMUwm1fJGFIMHcgdTqnufEn6h2VvFx/ppoGU3horUfpeRjIlDtg15hZme47/eIxh7KMhVSp1rd9c7V0erbhxEm6+eKX594YyLaTwXnu/kGG/NyR3GcAkLU6SU9fvSCOypn1XTcMDwck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZamZ7Qm; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4a77ea7ed49so32065741cf.0;
        Mon, 23 Jun 2025 10:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750699879; x=1751304679; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yoo2dyRfXG2vuwVABy0HQ543T76Aj+MJWYYINciZNTg=;
        b=iZamZ7QmD7bupdG46DTD8tm79zBtZ3weq+VHFmcgzwLHAzkY1qtiDpPhTLuyL9Skbm
         clli4Yr1ajOzRAZyK8xzn1o1vXnv7j9+GzkBZQsIgd4QTWLnNTjlDYpJAUPQOfINAfV5
         FWBD2hTyT3qoqB/O6dMyk/KaKFcUQPHEfO9h7Pti8edtOU9nnKPxvGDVRVN2CQtkEkGb
         UAdVMqDVrcInZkUqxomcT0C0xyMn65gV/mHHPH5kqSrAenVFqmrPyL5FXVs1Ofe2yFH6
         2V7s+kPQwW0mrlHl0VoHljVV8haCEge3W3IX2Vl+i55JGAHkFwHxHGtAFuOUhiiWh6DZ
         2FrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750699879; x=1751304679;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yoo2dyRfXG2vuwVABy0HQ543T76Aj+MJWYYINciZNTg=;
        b=LkYcyDELv+QykgEFnGrRIqV+KwYFanB6+9Qqv3EAcOU5MrdeRZLMQrY15NpucOHXR0
         T7qqXu5H0eefSoMVwaoGX2Zi10ZVQDeew2dkz9Fm9UQTi/0rfRLSHXeNHtZutyT5WHbp
         f9om9031MtVMEX9FMhSrwHMHKQOhtRKE47NHtofNjugCCkYvfxVlqRcpp0Q0bkDMEfXB
         l0uzJEOYdVeGOZRisYhF+7wE+lahv0Mcx8HxBY/X+MY/FPeDnb5qt/7rrqgUQLK4ociF
         HU2Cn4r3c3XZGsn0HOVzjC/Sh2s3Shq0lVmFx9kt8iMEsPUPiMkGFEY7jsynkEc9f8B1
         9iZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO06gXAgZI+q5q1RtcA5tTHvfuXL/4iXb91u7/R4OsNJc/ZNeeuHougwpH9fBEM5kozmMA5J79CxWu@vger.kernel.org, AJvYcCWVQ6WLrSYO01V5Y0M+Kf1qvjwO+3LnY2CUNMCAokD6G1yWvB0FLYI110PdZUETYUZ/toE6kw9kRL98u3U=@vger.kernel.org, AJvYcCWaHc0Z45FSQ8q3v/sh3jtDYS2+wDfUb5tvx4XNoyL8YVbkYeG593NnnD/Z6F1ekTeKKzmM2Al3hvxkvLjoDYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5FKe+XoAU0UAUq1TJeXeU9fD0B1yxTDa0OEpM9U2aNf0KI8an
	Ni8YSH0u2hINLvJN4EwyhWKlkDzDlwDP4WyhMEQuCjxoDkMTK2I8qm8y
X-Gm-Gg: ASbGncsaO8M+KHFXlR/OBDPq7W7wmsdCxeFuSLaJwsQejnzl4WsxRwLaN7p+aXH7D4h
	4dm3fYHeMxIiwjGb7aWvC207xZyqHtpfSDTWMoJ6elUmcr2WcM3+QTW5QLe5FtP6tqwNRWvj/NB
	J0jp4f5OjdLbcstSNIxlvpk9OKCJ4tXKYE48uQddmoVns8h90UghXH1WrSmEai/fl98L8ER33gw
	kBBSN7IQ7XrP/K94mf11FPJ5C959XGlEGVxb5eVfuzjKULdDCd1qedgm3ryeUJo2K32SL5zmkZ1
	CTBY3Q4G7v6nTtGu3BPdG1cFwIwAS2ngCEAEg43h38sZ4NJtQfavnfisaQQ1uWxMzghhIPiyTFZ
	3W6x95xt8r0Lf0e+1gWKtiTwKGPna6AYzTdGLjgIi5i5BFFnIN+9A
X-Google-Smtp-Source: AGHT+IFNGT1xrNrkdgAtBSao8CyCqQGzeTIxfGZcm+xmxRXTFInftj/9LxTUs3taku8jh9SVdAnkDA==
X-Received: by 2002:ac8:5850:0:b0:4a7:896:f2d3 with SMTP id d75a77b69052e-4a7ae744471mr7151941cf.0.1750699878841;
        Mon, 23 Jun 2025 10:31:18 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a779e8ab3esm40308741cf.63.2025.06.23.10.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 10:31:18 -0700 (PDT)
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id C9E81120006A;
	Mon, 23 Jun 2025 13:31:17 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Mon, 23 Jun 2025 13:31:17 -0400
X-ME-Sender: <xms:ZY9ZaFqOhEUDHMi17v6EIcStmyx7ECJCP1yPSX-xFz17NtV9cIklZw>
    <xme:ZY9ZaHqUQ0APeVdQd8zi8TzPFFus05vpZBaoNlVbOPB0CClA1SMz1tFE-rnofKKmc
    LpPm7wJhCMiIwDR4w>
X-ME-Received: <xmr:ZY9ZaCMsBLiBXPKF5NRXkM11CNHCQr9-lWn0NHl58VsslafUGDATj4osbg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddujeeifecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:ZY9ZaA6plWh-K0yA4iFJsMxg-qznpM8Yhb_m_c5tEOAK3CGu7-K2sQ>
    <xmx:ZY9ZaE5TxzYpOyn_6AU1p5EwK6MULMpi7F972Z8lGwnW4Z8tkvwgfw>
    <xmx:ZY9ZaIgohVh7fbAwpcjnHR_s3KYUwEKmreXuXv4vObIMQhxCNuFlIQ>
    <xmx:ZY9ZaG4DGhPYeTF-ZDD4YcLekqlZpeql1V1xAwBjwuaOI7HxmuC3OQ>
    <xmx:ZY9ZaLIWQRdZ8QuT1xaxYLRzqIoGmnCCmp4bYe5qahSyKfbqGGMVTLvN>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Jun 2025 13:31:17 -0400 (EDT)
Date: Mon, 23 Jun 2025 10:31:16 -0700
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
Message-ID: <aFmPZMLGngAE_IHJ@tardis.local>
References: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com>
 <20250608-topics-tyr-request_irq-v4-3-81cb81fb8073@collabora.com>
 <aEbJt0YSc3-60OBY@pollux>
 <CAH5fLghDbrgO2PiKyKZ87UrtouG25xWhVP_YmcgO0fFcnvZRkQ@mail.gmail.com>
 <DAU0NHTHTDG4.2HNEABNAI8GHZ@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DAU0NHTHTDG4.2HNEABNAI8GHZ@kernel.org>

On Mon, Jun 23, 2025 at 05:26:14PM +0200, Benno Lossin wrote:
> On Mon Jun 23, 2025 at 5:10 PM CEST, Alice Ryhl wrote:
> > On Mon, Jun 9, 2025 at 12:47 PM Danilo Krummrich <dakr@kernel.org> wrote:
> >> On Sun, Jun 08, 2025 at 07:51:08PM -0300, Daniel Almeida wrote:
> >> > +        dev: &'a Device<Bound>,
> >> > +        irq: u32,
> >> > +        flags: Flags,
> >> > +        name: &'static CStr,
> >> > +        handler: T,
> >> > +    ) -> impl PinInit<Self, Error> + 'a {
> >> > +        let closure = move |slot: *mut Self| {
> >> > +            // SAFETY: The slot passed to pin initializer is valid for writing.
> >> > +            unsafe {
> >> > +                slot.write(Self {
> >> > +                    inner: Devres::new(
> >> > +                        dev,
> >> > +                        RegistrationInner {
> >> > +                            irq,
> >> > +                            cookie: slot.cast(),
> >> > +                        },
> >> > +                        GFP_KERNEL,
> >> > +                    )?,
> >> > +                    handler,
> >> > +                    _pin: PhantomPinned,
> >> > +                })
> >> > +            };
> >> > +
> >> > +            // SAFETY:
> >> > +            // - The callbacks are valid for use with request_irq.
> >> > +            // - If this succeeds, the slot is guaranteed to be valid until the
> >> > +            // destructor of Self runs, which will deregister the callbacks
> >> > +            // before the memory location becomes invalid.
> >> > +            let res = to_result(unsafe {
> >> > +                bindings::request_irq(
> >> > +                    irq,
> >> > +                    Some(handle_irq_callback::<T>),
> >> > +                    flags.into_inner() as usize,
> >> > +                    name.as_char_ptr(),
> >> > +                    slot.cast(),
> >> > +                )
> >> > +            });
> >> > +
> >> > +            if res.is_err() {
> >> > +                // SAFETY: We are returning an error, so we can destroy the slot.
> >> > +                unsafe { core::ptr::drop_in_place(&raw mut (*slot).handler) };
> >> > +            }
> >> > +
> >> > +            res
> >> > +        };
> >> > +
> >> > +        // SAFETY:
> >> > +        // - if this returns Ok, then every field of `slot` is fully
> >> > +        // initialized.
> >> > +        // - if this returns an error, then the slot does not need to remain
> >> > +        // valid.
> >> > +        unsafe { pin_init_from_closure(closure) }
> >>
> >> Can't we use try_pin_init!() instead, move request_irq() into the initializer of
> >> RegistrationInner and initialize inner last?
> >
> > We need a pointer to the entire struct when calling
> > bindings::request_irq. I'm not sure this allows you to easily get one?
> > I don't think using container_of! here is worth it.
> 
> There is the `&this in` syntax (`this` is of type `NonNull<Self>`):
> 
>     try_pin_init!(&this in Self {
>         inner: Devres::new(
>             dev,
>             RegistrationInner {
>                 irq,
>                 cookie: this.as_ptr().cast(),
>             },
>             GFP_KERNEL,
>         )?,
>         handler,
>         _pin: {
>             to_result(unsafe {
>                 bindings::request_irq(
>                     irq,
>                     Some(handle_irq_callback::<T>),
>                     flags.into_inner() as usize,
>                     name.as_char_ptr(),
>                     slot.as_ptr().cast(),

this is "this" instead of "slot", right?

>                 )
>             })?;
>             PhantomPinned
>         },
>     })
> 
> Last time around, I also asked this question and you replied with that
> we need to abort the initializer when `request_irq` returns false and
> avoid running `Self::drop` (thus we can't do it using `pin_chain`).
> 
> I asked what we could do instead and you mentioned the `_: {}`
> initializers and those would indeed solve it, but we can abuse the
> `_pin` field for that :)
> 

Hmm.. but if request_irq() fails, aren't we going to call `drop` on
`inner`, which drops the `Devres` which will eventually call
`RegistrationInner::drop()`? And that's a `free_irq()` without
`request_irq()` succeeded.

Regards,
Boqun

> ---
> Cheers,
> Benno

