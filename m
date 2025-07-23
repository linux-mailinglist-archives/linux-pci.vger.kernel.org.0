Return-Path: <linux-pci+bounces-32813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C68B0F48C
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 15:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 921A93A1099
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 13:51:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFB82E8895;
	Wed, 23 Jul 2025 13:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYbuhc12"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8925B1957FC;
	Wed, 23 Jul 2025 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278707; cv=none; b=izPEfXUZawXDzztVEADLGMF7KVur46TTPyKaG4RFTjd1FWXyUPHOxUq7dCHEvbyyhEsU5s/hiVwee3kqKY6HuxOaKBEjuIlpKnrdHBbJDtTnFoeLAwB4m8SC644YNdImTjubfbG7DV934VE37yLmi39O2Rd2MLmXByHR1+pHxu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278707; c=relaxed/simple;
	bh=+CUkgIqlXm37cQn4uw0m+wfSExX1ej4HwaxwpAyMUrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u2oaHWPNCC8H13urKBbm0BA889D5IItvs3woCKH5f4vLapqCgqntZxnu+p1FyvsvR340KyNfAs6iC7MhrLYDI8Iq+3n19aKh+xG/PRBcwkzg2F1HNi7JUHrNFPJqM0sU6rsLL3Hg/QQIrJlIhKcd1b+8oG1boJ/WVSesem9mxW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYbuhc12; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-6fad4a1dc33so60081506d6.1;
        Wed, 23 Jul 2025 06:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753278703; x=1753883503; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=h+tDGNKrq8C0RgHBmdZ2huLR3bEGVTqDHewscGCcyP8=;
        b=bYbuhc125LJc6yJRXfxJ2F9XK5ZABUPpFdJxfz52DbTJR1EvSx/qeRoGM8hJiytcf+
         bJ6eyBpYAsDpcHeKbqgGispzTiMPrj6C8QsBYaFP65B9P/872a6/m1hTdTWD7YCiKSAo
         VQylkB+IX0aXqrlZY2+DXiQduRXvKSxUMBxtXTX2BLW4ltMsU2tnVc0cI/VL9GkCEQPX
         scw8AwFqVA5ulaHBWh0sB4SkoR9tMA9MSMY0Q+SGJVNAOIHoopMUGH8grnan/ljtbLtb
         UntmByp4cND9cyPCg9Tr4gHY8i/j33PHUq8N1bLyDRqpLmrgg/n1AkjIA2vfACVEOhXO
         B/Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753278703; x=1753883503;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h+tDGNKrq8C0RgHBmdZ2huLR3bEGVTqDHewscGCcyP8=;
        b=Vc60z3K8uRErStUg3ZLWK3RssiUEGOPoUAsbMK3GrfdhyK8Bnu2aaGDVxR6vICv2N7
         TXhPqpmjhsaAzFXN1+rDoW6UrVzkjhlE4ktaRV11NNnJAX4I4OboZh0FMa/ZLZCbiDUT
         NyAByQ5p2tvLO5OpCAIwQRCGbqyaoloeSlRRN6Irv7bBMHAZbDchnAr9N+3S98aDQlPG
         e7XR0WeH2PpJmqzPsQRNpszgb0/JCogvSM6pIop4K9uk3Nx3ehV+80hkaYflW1rfx4TO
         NLow/JDXIzwJIPbFDZydPsYtCVhvczCd7ElS99bbGfWPX/r9cUvNUK1d7ldFAKjy6mg+
         spzA==
X-Forwarded-Encrypted: i=1; AJvYcCWFsH8ZaHRSifiUNbguLF5ur0rRF3H6DhEy116Bvu+gpBUQT8bjfhQhHkOh0qAlmCy9hPm1N4C+N7Vs@vger.kernel.org, AJvYcCWhnZZNRpGCRH+a+pgzUW5yovIPLfZhx6VNCejOy0EhthsgVJdV8c2tL4BGXpyzsQ1mZrq5fkiM0C7iu/OPs/Q=@vger.kernel.org, AJvYcCXX+Gp3Rj5OKDg2LjREGP27ZuU1OcDzLDtqY3iBfbkbqs5OoWchVLs81+EB30JCIjzDX7g0NQ0ZCSpY3vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB9Yv2jFYGUwV0qVX3Wlh6+Si+KBUUt+N+UVN+eaRj6NggdCD1
	vysQZx6FhieFCF0zRSVGDRnXZoJWIME99ZngJC8l7E0lVL5TZHCCklYp
X-Gm-Gg: ASbGnctj+rsdk5sIYtPRgE4748VXC2FS2scWeLoF7ikhB2JUb5yooecqG4IkfT0i0S3
	zeNiJIB9w39lMpARBlmelEeX7lOyeQkaKDUhMoRfaIOIHHgNEXCh6mAeTULarnmsc45s8zMbe9o
	iG5biUAtCUM6HEVZ4JE8tpo9DPy9l/clwL5uFvvzoNw+MkcancUSmHg+5K6BmP1qU/D3Nn6dq7x
	Z82S4G2o+iJwiZip0/7O3pVnWqDQoggW+HV43bHBMc6HsXwSbWUxNf7CEeiEHOXhgyCqsR7a50j
	8d6/a2tTlG4nZnFHUVe0/PWOQtfW3osaOMCCZcDT1fq8qlRJiPtT64aPCazuDTkG7tvvReRnP5f
	lkP1G2BWvgT96aOJ1K8K769l03vZGjeB5CFs8IwhL/Uizqnx1vJ3KH67bzd/0DiVkMW5bA6EB7h
	LsIS+LYle9qvuzd2IQL8b6IeQPl2wew32XgQ==
X-Google-Smtp-Source: AGHT+IH5nlBBdOgrPIobi/RLqeR1UjUMNZ1p01f3edEfGLtmvSJW2VYBsZ3pKRPwdHB8RMcZ2c4igg==
X-Received: by 2002:a05:6214:d48:b0:6fb:6114:1034 with SMTP id 6a1803df08f44-70700845f98mr48358216d6.39.1753278703116;
        Wed, 23 Jul 2025 06:51:43 -0700 (PDT)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7051b90d3cbsm64264926d6.43.2025.07.23.06.51.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 06:51:42 -0700 (PDT)
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfauth.phl.internal (Postfix) with ESMTP id 30239F40068;
	Wed, 23 Jul 2025 09:51:42 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Wed, 23 Jul 2025 09:51:42 -0400
X-ME-Sender: <xms:7uiAaIwHsRuwp1phD17YMI2ONG8BLJSXhzrDeQCUsTV9FXqyWSLW9A>
    <xme:7uiAaC0I3kkO0CtQtoXXZkcSr7YkYlkvZdCJOLa3JJjWVV8LP4yIltFi9CohsPtgL
    rg6fGQrbxN7fhLZsQ>
X-ME-Received: <xmr:7uiAaMBGQZMHSJv7z62VvxCVgm-7gBLp6IbLkvZn9yg2N2xInrmoxkWu7b4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejjeelhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeevgffhueevkedutefgveduuedujeefledthffgheegkeekiefgudekhffggeel
    feenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsoh
    hquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedq
    udejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmh
    gvrdhnrghmvgdpnhgspghrtghpthhtohepudelpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhopegurg
    hnihgvlhdrrghlmhgvihgurgestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopeho
    jhgvuggrsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrlhgvgidrghgrhihnohhrse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghgrrhihsehgrghrhihguhhordhnvghtpdhr
    tghpthhtohepsghjohhrnhefpghghhesphhrohhtohhnmhgrihhlrdgtohhmpdhrtghpth
    htoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehtmhhg
    rhhoshhssehumhhitghhrdgvughupdhrtghpthhtohepuggrkhhrsehkvghrnhgvlhdroh
    hrgh
X-ME-Proxy: <xmx:7uiAaP_xSsM1oNZwcGzC8BcxgfdScD8rnbd_UOhSZ5NFOcjUw339WA>
    <xmx:7uiAaK9bHtowvqYoymBwoIPLEzExkfv-d3WsK3JB6lWcFfTwdDmpLg>
    <xmx:7uiAaP03_4aVjaOXaE7BQILPJxQEOOs2jrsowiSR_1GJS-MA2Hu2pQ>
    <xmx:7uiAaC_8BUf3FYyFmr6atQAmUhj4a80BjgTOmluJeP-0BsaxS75bDQ>
    <xmx:7uiAaIfivg5hIBgEhEuOW3xQuEiJgBuDCiFA96o-6xOQyZxdGBtNdkGy>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 09:51:41 -0400 (EDT)
Date: Wed, 23 Jul 2025 06:51:40 -0700
From: Boqun Feng <boqun.feng@gmail.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kwilczynski@kernel.org>,
	Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v7 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
Message-ID: <aIDo7I9QdIk-VvL7@tardis.local>
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
 <20250715-topics-tyr-request_irq2-v7-3-d469c0f37c07@collabora.com>
 <aIBl6JPh4MQq-0gu@tardis-2.local>
 <CAH5fLgjsRMuN8NDgXD_4R3Wk4PqcZhZnnruAC+0WRYkz=U7rJw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgjsRMuN8NDgXD_4R3Wk4PqcZhZnnruAC+0WRYkz=U7rJw@mail.gmail.com>

On Wed, Jul 23, 2025 at 07:35:26AM +0200, Alice Ryhl wrote:
> On Wed, Jul 23, 2025 at 6:32 AM Boqun Feng <boqun.feng@gmail.com> wrote:
> >
> > On Tue, Jul 15, 2025 at 12:16:40PM -0300, Daniel Almeida wrote:
> > > This patch adds support for non-threaded IRQs and handlers through
> > > irq::Registration and the irq::Handler trait.
> > >
> > > Registering an irq is dependent upon having a IrqRequest that was
> > > previously allocated by a given device. This will be introduced in
> > > subsequent patches.
> > >
> > > Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> > > ---
> > [...]
> > > diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
> > > index 9abd9a6dc36f3e3ecc1f92ad7b0040176b56a079..01bd08884b72c2a3a9460897bce751c732a19794 100644
> > > --- a/rust/kernel/irq.rs
> > > +++ b/rust/kernel/irq.rs
> > > @@ -12,3 +12,8 @@
> > >
> > >  /// Flags to be used when registering IRQ handlers.
> > >  pub mod flags;
> > > +
> > > +/// IRQ allocation and handling.
> > > +pub mod request;
> > > +
> > > +pub use request::{Handler, IrqRequest, IrqReturn, Registration};
> >
> > I woulde use #[doc(inline)] here for these re-export. It'll give a list
> > of struct/trait users can use in the `irq` module.
> 
> You get the same effect by making `mod request` a private module.
> 

Oh yes, that also works! I think we probably should do that.

Regards,
Boqun

> Alice

