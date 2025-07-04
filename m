Return-Path: <linux-pci+bounces-31506-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48F22AF89C7
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 09:43:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDEE64A1233
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jul 2025 07:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4ED283FC2;
	Fri,  4 Jul 2025 07:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yh0OHdj2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513EA27FD4B
	for <linux-pci@vger.kernel.org>; Fri,  4 Jul 2025 07:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751614979; cv=none; b=amiV48btSoME2M0EwHfDft+q2FUa9HFt4w2TBb5/Q8ulrEMJb/RJc5gE10MkWdelTLL/s8q8WBtD5GYYR0Km4dYbNjKQu5rtu+8O27Fhw3+Fix1PMYTpcT58sbdou/Lf0XcPI6+j+NXzRiVpSOzBl6G8gdlrXw2e3Ej4TPewr6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751614979; c=relaxed/simple;
	bh=EyQLopdaeuTERfCjyDX1RB58tHyhweNO8CjnstLUYcY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=T/94CEJwrDrckwrd3OppoUDxRHayvLGYA3uqbN166Wy7+vOzxPAoDFX16gqSyGo8GOOcy6eqe37PRczOy3dvKZGk+jmc5YnbLU0h0dzYNJ8P9aKqU1NBxR4QMK8YNwOveoypqk+IeCafMb2pxEciP6R/l/pSUA9k+wVqqbdRFfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Yh0OHdj2; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-450d290d542so3545545e9.1
        for <linux-pci@vger.kernel.org>; Fri, 04 Jul 2025 00:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751614975; x=1752219775; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=camNvxFIEl2ZnilHFyd5vJLomyvuXbAyAAA9+dCBwRk=;
        b=Yh0OHdj2x/5dobS3e0IYb/wzFPkD/Q/j+gomI/PCukTIfTUxk0NxPqmst+J/zFYtDi
         rbjo6S/jAgyjH5zmTL53J36J9Nzru1a8TcfZDIR4U4JcdothxycXX28ntOc14wvSxlMT
         Yj8t7j/4yIvkzqeYV/NAoNrdUJLDjX3TX40cAYE0YRa3mW/QzADjMvcn9Ul+QBtOUUWi
         fOazyaV2UiCprvYVhUQtIdXPUfP7fz88YRZi+9Lzd+zYz7GO0Kx5fWg8Ukgd197khViV
         YjrCnfMAStcbQNMk14kq7/KvNGMS7yDLj6Q6KyDfqQQxI/DYlNiFGfSI3ExzWwr83Leo
         k8IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751614975; x=1752219775;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=camNvxFIEl2ZnilHFyd5vJLomyvuXbAyAAA9+dCBwRk=;
        b=NIGT2lTyO+lFLGY18Zwr+4o5WFeRX6G/sMSB+v8iFlWdU6C/EZVvSlK0PwNMn7mzBT
         Vpx01Jd01LhisIqIYF0ciR9GDKHoSBO7TngQ3I7agb5Q5DKeq9Ea8+I7sp4tH0SPMkTl
         Ifl1QWV+bpC4zdq1BYtiUAgPmmmOfdLpopDE/FsFYrxU1emzngHN9G87yTWUkrau3Gb0
         9k4rQ+qu+btNgJF8mJol1XU0G7gMdo9LZ3OpUemtq9iEtlU/rqpSYOv2MWLwojLPkTjR
         LjxJns4GR//JaUTOSqyPObBI8IFKEsHTgJez9qhZ1XKtg2K+LDL6tBiF1d01T5w0Oq5/
         F1Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUyiGK/VRI9EXWZjAvfutO/2oo24W0udGueQ4NgW/0vT1tuQZtNcw7BB7t4fdmh5BQrYtAAOI/gids=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjG/EhIgbMkzA0f/GQ8bVwi8nO77ijCtzhmt6HtX0uIm6EVRoC
	MjMYdbyFA/N51HN6MJu27T/TDgPt/jugsoGf6Iu+g3Foe6KOsEep8CsosEe4VHCqLd6RI69l7FG
	QaiuH70unjuEcVC8rJw==
X-Google-Smtp-Source: AGHT+IEaYSraVJ6sZtkAl+0ugpmkdJfooBiBpMK4mkQLrv/OlSZBW7BofC2dgtjJxBr8tWhlM0xayMRReusEiag=
X-Received: from wmbfp26.prod.google.com ([2002:a05:600c:699a:b0:450:d398:f3ff])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8218:b0:450:d3b9:a5fc with SMTP id 5b1f17b1804b1-454b31134d2mr15309935e9.27.1751614974821;
 Fri, 04 Jul 2025 00:42:54 -0700 (PDT)
Date: Fri, 4 Jul 2025 07:42:53 +0000
In-Reply-To: <fcdae3ca-104d-4e8b-8588-2452783ed09a@sedlak.dev>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
 <20250703-topics-tyr-request_irq-v6-2-74103bdc7c52@collabora.com> <fcdae3ca-104d-4e8b-8588-2452783ed09a@sedlak.dev>
Message-ID: <aGeF_W74OfhRbkoR@google.com>
Subject: Re: [PATCH v6 2/6] rust: irq: add flags module
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Sedlak <daniel@sedlak.dev>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Benno Lossin <lossin@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Jul 04, 2025 at 08:14:11AM +0200, Daniel Sedlak wrote:
> Hi Daniel,
> 
> On 7/3/25 9:30 PM, Daniel Almeida wrote:
> > +/// Flags to be used when registering IRQ handlers.
> > +///
> > +/// They can be combined with the operators `|`, `&`, and `!`.
> > +#[derive(Clone, Copy, PartialEq, Eq)]
> > +pub struct Flags(u64);
> 
> Why not Flags(u32)? You may get rid of all unnecessary casts later, plus
> save some extra bytes.

It looks like the C methods take an `unsigned long`. In that case, I'd
probably write the code to match that.

	pub struct Flags(c_ulong);

and git rid of the cast when calling bindings::request_irq.

As for all the constants in this file, maybe it would be nice with a
private constructor that uses the same type as bindings to avoid the
casts?

	impl Flags {
	    const fn new(value: u32) -> Flags {
	    	...
	    }
	}
	
	/// Use the interrupt line as already configured.
	pub const TRIGGER_NONE: Flags = Flags::new(bindings::IRQF_TRIGGER_NONE);

Not a big deal, but avoiding the cast when calling bindings::request_irq
is a good idea I think.

With that:
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice

