Return-Path: <linux-pci+bounces-30508-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CCBAE6709
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 15:50:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C3B03A4109
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 13:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E6C2C1582;
	Tue, 24 Jun 2025 13:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I5r9o4Gg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7933528314C
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750773041; cv=none; b=DvOANBQZUuusYJlvp1CtCETnim+mBNaTCaPrN192dTU1xPj2MekME33cZvanmZOdDAYypinymeMVRQbXhU8XgXXCKn3pN0xuI6ZTNQgfVshgjr9r1+QWYfbASBzW/r0nCKEGZfrIvxOmcVOilwgvX42tdZknX1PEWc4WwuTLaus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750773041; c=relaxed/simple;
	bh=x869jf+HcyzdISYV8dZz/gWjbV7ixtQEFmQ5vF/GuAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LpnkJMFByE7/k8YQxy3N3+5C6VKpDH8csD/2pvEau2lduifwAcsl7xDNoB8pF2oCaLWMpDStAsaw9r5A8ymxnQc2cWNxFfG/tfPPYp/YDdWCcIURdPrnusbMNx5TodXF56m0Gu9XWho1Ii1K1/KzfYf3cEmsSEc6xVENUQ61+98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I5r9o4Gg; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a4f379662cso4416013f8f.0
        for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 06:50:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750773037; x=1751377837; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuSC/X9PgRtXfhqHGEt/bUX/whB0bmpCwcmqOcOnono=;
        b=I5r9o4GgFQqOT2VKpPuuA08Pox05fWwiGLcfPgMr1HF7tBq4EekoNHX6VICtq2yfI7
         1VxW+kd76dgIfs80w6WqvlC9hcZUT0xV+Pi7oeRvMrK9js1r8fRFjxrvNLK5o0QsYIOo
         9AsAAuhAgvhPwkJStJfxdmTWvQ3OfiKzM54RT1o5OWNgXRzuv+/hzmqWm58QtUWFqUoW
         1ZGlae8NoSkLYsGHBhvTGdWBCGLRZG/zbkqiITTWqmQfAWK6bgs/s3zU+g4VBz6uUf+S
         RIzxL6sSRrcZtMtHYyvBwmYn1vQG5svcfWHH9/EBOHFXl9HA2lWh2vzk/tbxkeVunFVR
         qeWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750773037; x=1751377837;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FuSC/X9PgRtXfhqHGEt/bUX/whB0bmpCwcmqOcOnono=;
        b=W5apav/nr9UfFGxcbdRm+eMihXTj7ee+3xKa9OnaWUM2lci89nqDTRLd9ysE2Laxus
         SBUfRoSTKQnGnLO4ruLdoU8tdUV9v2azYKUzFGPb0OkGH8dbIvnC6hskwhm4Uoaajjs3
         Bamth5xwQ3+YFNWaixDnPFgWGGv6qRu/7oBaCszPxJfQW/wRASHhxa8wHF0OfA6KvtuY
         RaNukMkxTkAsUGeDO/O6tqwipCjw0g9HnyImKJh0Ikit4qmzsb+LDuL9ibEMoimEMeIO
         cm53UBpbeL4dVktuFITgFol173guJAkXKZnxAoKdyzZqLAhGuJZKhc9uPCFnhc2kzmWf
         pp3g==
X-Forwarded-Encrypted: i=1; AJvYcCWR/ME5RLpOQVoI2nlX0rZcic7fBEOdy0HKTEEvUbgRSqv6Kf1WEgzMNVv7VQK+ZLDoEN7aK2tEQZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwndwzA46CRCmfzWOy50DoHizPNYyYStJuttWo80oMFcz1mrfX4
	jgy2QMW8dNeyrLuu3jN4NR+qsLU4aeNlLD4Y8+047Of4QPSk0pTU419fr/g4PDqVFTO4r5I12jn
	v3MRRs4O1xDjaO8s7tkmF/TcwkqzVyL2ApRrsr+BR
X-Gm-Gg: ASbGncv724MM/5yLVv17LqeD0o7597ycITp2bq6CnQ4VFyBmpTd+G4sA/XorIvC3SDS
	u1IWMt4lXsVKRY1jAzb/4rdX3NSyfTSERz9ydlrAIonu/jHcApy2R3EUi+ta3y2M9ezwRU0b/Xm
	RvGajtIIGuGzLqFutAYOA4BALlgGeZPolGNN9lhRTyVgh715IAzdjL3tg=
X-Google-Smtp-Source: AGHT+IGnrnePw+dcT7/yyqAE5xLybA6KvH5/W9NCQoo7oBZLRLyIwlJ7wVikWfPRtL8Ejq0gVIGBHa1DhIpdduVksJE=
X-Received: by 2002:a05:6000:4021:b0:3a4:ef36:1f4d with SMTP id
 ffacd0b85a97d-3a6d12e419bmr12601998f8f.38.1750773036600; Tue, 24 Jun 2025
 06:50:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com>
 <20250608-topics-tyr-request_irq-v4-3-81cb81fb8073@collabora.com>
 <aEbJt0YSc3-60OBY@pollux> <CAH5fLghDbrgO2PiKyKZ87UrtouG25xWhVP_YmcgO0fFcnvZRkQ@mail.gmail.com>
 <DAU0NHTHTDG4.2HNEABNAI8GHZ@kernel.org> <aFmPZMLGngAE_IHJ@tardis.local>
 <aFmodsQK6iatXKoZ@tardis.local> <DAU5TAFKJQOF.2DFO7YAHZA4V2@kernel.org>
 <DB7F39EC-5F7D-49DA-BF2B-6200998B45E2@collabora.com> <DAURVNHM7PKM.PLUFKFRVXR25@kernel.org>
In-Reply-To: <DAURVNHM7PKM.PLUFKFRVXR25@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 24 Jun 2025 14:50:23 +0100
X-Gm-Features: Ac12FXxhBUp0laB6o-uk241zbrLxNt97_Zs06jxl60wtCBp8pHCACUlpYJSNp-I
Message-ID: <CAH5fLggs=mUi0xAEuiLvZrua4qrMYjBDEmyK8xc-kkXVyUKRog@mail.gmail.com>
Subject: Re: [PATCH v4 3/6] rust: irq: add support for non-threaded IRQs and handlers
To: Benno Lossin <lossin@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C2=B4nski?= <kwilczynski@kernel.org>, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 24, 2025 at 1:46=E2=80=AFPM Benno Lossin <lossin@kernel.org> wr=
ote:
>
> On Tue Jun 24, 2025 at 2:31 PM CEST, Daniel Almeida wrote:
> > On 23 Jun 2025, at 16:28, Benno Lossin <lossin@kernel.org> wrote:
> >> On Mon Jun 23, 2025 at 9:18 PM CEST, Boqun Feng wrote:
> >>>    try_pin_init!(&this in Self {
> >>>        handler,
> >>>        inner: Devres::new(
> >>>            dev,
> >>>            RegistrationInner {
> >>>                // Needs to use `handler` address as cookie, same for
> >>>                // request_irq().
> >>>                cookie: &raw (*(this.as_ptr().cast()).handler),
> >>>                irq: {
> >>>                     to_result(unsafe { bindings::request_irq(...) })?=
;
> >>>  irq
> >>> }
> >>>             },
> >>>             GFP_KERNEL,
> >>>        )?,
> >>>        _pin: PhantomPinned
> >>>    })
> >>
> >> Well yes and no, with the Devres changes, the `cookie` can just be the
> >> address of the `RegistrationInner` & we can do it this way :)
> >>
> >> ---
> >> Cheers,
> >> Benno
> >
> >
> > No, we need this to be the address of the the whole thing (i.e.
> > Registration<T>), otherwise you can=E2=80=99t access the handler in the=
 irq
> > callback.
>
> Gotcha, so you keep the cookie field, but you should still be able to
> use `try_pin_init` & the devres improvements to avoid the use of
> `pin_init_from_closure`.

It sounds like this is getting too complicated and that
`pin_init_from_closure` is the simpler way to go.

Alice

