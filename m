Return-Path: <linux-pci+bounces-30511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F967AE69BF
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 16:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7531A1C26B27
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 14:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAD02D131A;
	Tue, 24 Jun 2025 14:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bfLCv5z6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5A22D23AB;
	Tue, 24 Jun 2025 14:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750776130; cv=none; b=gjke3TGD4pCd2y3GL986Af2eKNW++2IDHGkGDhUa714Lfyy9yPvTM0/Bt/v7UvcH8FkRDiQgc+xVjt+b6opF+rKwtf1QoOjzsYX750b8CLddEB9m1MM0k9ZggbtdJjdRDQp8iP9dMLWCvQA4UEgtTf3pLn/BxC6iDaJQu4dJ+3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750776130; c=relaxed/simple;
	bh=V1M4ORKLJLIjG57LATbk5936tLU6u1xz5jO3Mt7+sNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dKHWagWPL1pccvyY25iAQ0OJyhdoyNtIPb6o6uuMe2FREIXDDP1KNPI20s+2pqR5p0Pj5irIj7a5zrSM60n2//Dl57HGs5KROIUnnY5sTkPKVml+lGngfU8imO3SmdnoSkH++d4RMZZOkSk5jMPvVSpEchSeLbJlEroeZZQ4kmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bfLCv5z6; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7d402c901cbso40839885a.3;
        Tue, 24 Jun 2025 07:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750776127; x=1751380927; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GtB/3XhJ46B/NpEKgpZNrT4UMCjsycvYug2oSPbfSqo=;
        b=bfLCv5z6p9h9cd4vlfyOSHf9Y7C5GbbuzRMnmn8AHq13lY8BnZTQtvBkKKIFcXWZSX
         IpybrLjVsQd/XT7VpEPThd4w3HQDygtLF5L1K9Z1I5pdRGzyxYlKvQu1UMRB7BYHtnjC
         SLRyBED0EJkNo+9x48OdkmDL+W8rmuVQOLNFTsrdWX87iaHH6IQzYAtm6CZF6I+jD6Cs
         Q4HL3WkqlAskorqTISUOmadnppOGH32LN56NRHiiGpJlA0menrXO2xyLzBkhok6dmHK+
         RvKNlShuC1pyf9J1LDCwdKrKo0n7O2a/Of6dImVdMelmn5EqslZQRzpFD8cxvDi1O3vq
         g1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750776127; x=1751380927;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GtB/3XhJ46B/NpEKgpZNrT4UMCjsycvYug2oSPbfSqo=;
        b=BT7WVBYjvI+zCRaraP1utQbih17HtwEXAYjYcdBnqw56zJgRkTe/DGCFyRNnOycsCt
         7eMFrCTJHLkeL4aBqpBPB8q/prMKWjcBWH6lmcqDCXjPIwKyrrZqpnMCDtrptGhHDv4K
         GeSbT1ntrjUeAik0msF6LiWeokMc9sDYOaGZmkRWC0ABfAEWBdWb8MuobyQCyUvyzedr
         L9qo1yuj6ZwWkD92JK5t7+d8b77iQj4aWkGC/A3mZ8Uq3rcUVG+20m18wF77VFoCzUKt
         Z26IfCFaqApInaj2DfLBV6YEICguJ5hTtFvKPrTaPBIiCk2vja6ZdOnmRzuqkrEn+u0B
         Vkew==
X-Forwarded-Encrypted: i=1; AJvYcCU/zwkWmVrTRSozgJcGNzPYEy82/nFu+ahRW00ojrUbxEG3qNGEYNWdzyiYp52chrDkXanSGpyIoBpYs50=@vger.kernel.org, AJvYcCXIegfOUCOXurngGxCkPqsJYgpLaYfRMhjjqRg2M0qfToKknym2vdCp4fXwqZA7Caj95ssarCsUe+91@vger.kernel.org, AJvYcCXmPG037OFEQTgT1fFqvAUqA0bqDD82xqmfmMHdsODqAMdPJ48NaRztWA6B/5t5FEfKpLvnWG+IaYOx4Zvipl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcY7opb3ZOqt4JyaSQg+WXG7jz8Eh3ngsS/Sr5Vvc6rI/VQ2rV
	TNZYY/sxyNaVHuRxCAcssRb16GfJzG/0ZD1eEDC4tgBkN5Pwjipt4X3a
X-Gm-Gg: ASbGncvmgdDCfaSJdVNNphE5XYy8Tq+X1Jf/Nf6Wwz5x0Ga50+Dj8LOnqzSWKQBor/a
	+TRTu2dFs7JhG1FIHlDWDI1Z30tj3C5XRRDzVY25ZVYdbFMVTEliFMQiY97UG2umGt749lglr77
	PWRPRSSvvo5ihgfdy+qriHACFT1oQZW4/ld+CWlTmS7MzrmaXmLZX5vQvh0uTlkuft2TA6T3H9g
	pfIkGOBnegdARwGJh1VHIK4f0zrjFvpB+gnL/WFL8U1oDHMZZj86dtBbnUb3CzASy7vJvSEo5dJ
	OPEaoBECDq5f3B/r4GQzuLenDAKdkaDD4UsKOd21OGfJJ9Ewe0QpotChShZF0RXdWG2Ca/apYh7
	Jp6BlMd/Pyu9qfQr1guuCDgBsUQ9dVdhFHE+KC0pFz4HMLgKrYTZp
X-Google-Smtp-Source: AGHT+IGqn8QSrBn/+r07VLKEUP7DR9SwamJYuczpKcnyFMNqjHFRpwoNy5lg3m6iRp1rsXysqsgRKw==
X-Received: by 2002:a05:620a:1a06:b0:7d3:abd6:3cab with SMTP id af79cd13be357-7d3f9931d6fmr2391463585a.41.1750776127335;
        Tue, 24 Jun 2025 07:42:07 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f99a6415sm507451085a.40.2025.06.24.07.42.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 07:42:06 -0700 (PDT)
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfauth.phl.internal (Postfix) with ESMTP id 544901200043;
	Tue, 24 Jun 2025 10:42:06 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Tue, 24 Jun 2025 10:42:06 -0400
X-ME-Sender: <xms:PrlaaCzIITWtK_Q3M6kzh36u9740yD7yvqqNp93T66t5fqiKrwdMXA>
    <xme:PrlaaOTev_EvXTfTVyCzI15U6Atiaob66jAWkbbi7SxEuYU3HIvkJnGoLc54pvkEN
    QvoTsuJlKKjkQbdzg>
X-ME-Received: <xmr:PrlaaEUXg3rePXlcVz9jNfSmlCPw2o50kjuHWWV6Kc3DL14bCAy9xM6MpQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvtdduiecutefuodetggdotefrod
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
X-ME-Proxy: <xmx:PrlaaIhSOH_mFSFfZEHQ8ORjniKF0G9fEmWZwKEdB-_NARn2axiSoA>
    <xmx:PrlaaEAYxQYtyc8B3Vri87yY3MozaCdeJSIHYgJvKEZc5hWmNBi3sw>
    <xmx:PrlaaJJvm1Gj5SIChTJkgUqLJtFhQNYmWByR0i_Pq0BoTC-HrB35FA>
    <xmx:PrlaaLA-oU6WXLjDC_H821FX1lRpBomx05RME8wiRi_M1QAEXnbHRA>
    <xmx:PrlaaMyd6svD166k_DsZYMIgrxyW1L9F9G3k5Flnh9eryA8O97fDJgSb>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Jun 2025 10:42:05 -0400 (EDT)
Date: Tue, 24 Jun 2025 07:42:05 -0700
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
Message-ID: <aFq5PVhm3ybiw12I@Mac.home>
References: <aEbJt0YSc3-60OBY@pollux>
 <CAH5fLghDbrgO2PiKyKZ87UrtouG25xWhVP_YmcgO0fFcnvZRkQ@mail.gmail.com>
 <DAU0NHTHTDG4.2HNEABNAI8GHZ@kernel.org>
 <aFmPZMLGngAE_IHJ@tardis.local>
 <aFmodsQK6iatXKoZ@tardis.local>
 <DAU5TAFKJQOF.2DFO7YAHZA4V2@kernel.org>
 <DB7F39EC-5F7D-49DA-BF2B-6200998B45E2@collabora.com>
 <DAURVNHM7PKM.PLUFKFRVXR25@kernel.org>
 <CAH5fLggs=mUi0xAEuiLvZrua4qrMYjBDEmyK8xc-kkXVyUKRog@mail.gmail.com>
 <aFq3P_4XgP0dUrAS@Mac.home>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aFq3P_4XgP0dUrAS@Mac.home>

On Tue, Jun 24, 2025 at 07:33:35AM -0700, Boqun Feng wrote:
> On Tue, Jun 24, 2025 at 02:50:23PM +0100, Alice Ryhl wrote:
> > On Tue, Jun 24, 2025 at 1:46 PM Benno Lossin <lossin@kernel.org> wrote:
> > >
> > > On Tue Jun 24, 2025 at 2:31 PM CEST, Daniel Almeida wrote:
> > > > On 23 Jun 2025, at 16:28, Benno Lossin <lossin@kernel.org> wrote:
> > > >> On Mon Jun 23, 2025 at 9:18 PM CEST, Boqun Feng wrote:
> > > >>>    try_pin_init!(&this in Self {
> > > >>>        handler,
> > > >>>        inner: Devres::new(
> > > >>>            dev,
> > > >>>            RegistrationInner {
> > > >>>                // Needs to use `handler` address as cookie, same for
> > > >>>                // request_irq().
> > > >>>                cookie: &raw (*(this.as_ptr().cast()).handler),
> > > >>>                irq: {
> > > >>>                     to_result(unsafe { bindings::request_irq(...) })?;
> > > >>>  irq
> > > >>> }
> > > >>>             },
> > > >>>             GFP_KERNEL,
> > > >>>        )?,
> > > >>>        _pin: PhantomPinned
> > > >>>    })
> > > >>
> > > >> Well yes and no, with the Devres changes, the `cookie` can just be the
> > > >> address of the `RegistrationInner` & we can do it this way :)
> > > >>
> > > >> ---
> > > >> Cheers,
> > > >> Benno
> > > >
> > > >
> > > > No, we need this to be the address of the the whole thing (i.e.
> > > > Registration<T>), otherwise you can’t access the handler in the irq
> > > > callback.
> 
> You only need the access of `handler` in the irq callback, right? I.e.
> passing the address of `handler` would suffice (of course you need
> to change the irq callback as well).
> 
> > >
> > > Gotcha, so you keep the cookie field, but you should still be able to
> > > use `try_pin_init` & the devres improvements to avoid the use of
> > > `pin_init_from_closure`.
> > 
> > It sounds like this is getting too complicated and that
> > `pin_init_from_closure` is the simpler way to go.
> 
> Even if we use `pin_init_from_closure`, we still need the other
> `try_pin_init` anyway for `Devres::new()` (or alternatively we can
> implement a `RegistrationInner::new()`).
> 
> Below is what would look like with the Devres changes in mind:
> 
> 
>     try_pin_init!(&this in Self {
>         handler,
>         inner: <- Devres::new(
>             dev,
>             try_pin_init!( RegistrationInner {
>                 // Needs to use `handler` address as cookie, same for
>                 // request_irq().
>                 cookie: &raw (*(this.as_ptr().cast()).handler),
> 		// @Benno, would this "this" work here?
>                 irq: {
>                      to_result(unsafe { bindings::request_irq(...) })?;
>                      irq
> 		}
>              }),
>         )?,
>         _pin: PhantomPinned
>     })
> 
> 

Never mind, `dev` is a `Device<Bound>` so it cannot be unbounded during
the call ;-)

Regards,
Boqun

> Besides, working on this made me realize that we have to request_irq()
> before `Devres::new()`, otherwise we may leak the irq resource,
> considering the follow code from the current `pin_init_from_closure`
> approach:
> 
>         let closure = move |slot: *mut Self| {
>             // SAFETY: The slot passed to pin initializer is valid for writing.
>             unsafe {
>                 slot.write(Self {
>                     inner: Devres::new(
>                         dev,
>                         RegistrationInner {
>                             irq,
>                             cookie: slot.cast(),
>                         },
>                         GFP_KERNEL,
>                     )?,
>                     handler,
>                     _pin: PhantomPinned,
>                 })
>             };
> 
> `dev` can be unbound at here, right? If so, the devm callback will
> revoke the `RegistrationInner`, `RegistrationInner::drop()` will then
> call `free_irq()` before `request_irq()`, the best case is that we would
> request_irq() with no one going to free it.
> 
>             // SAFETY:
>             // - The callbacks are valid for use with request_irq.
>             // - If this succeeds, the slot is guaranteed to be valid until the
>             // destructor of Self runs, which will deregister the callbacks
>             // before the memory location becomes invalid.
>             let res = to_result(unsafe {
>                 bindings::request_irq(
>                     irq,
>                     Some(handle_irq_callback::<T>),
>                     flags.into_inner() as usize,
>                     name.as_char_ptr(),
>                     slot.cast(),
>                 )
>             });
>             ...
>         }
> 
> So seems to me the order of initialization has to be:
> 
> 1. Initialize the `handler`.
> 2. `request_irq()`, i.e initialize the `RegistrationInner`.
> 3. `Devres::new()`, i.e initialize the `Devres`.
> 
> Regards,
> Boqun

