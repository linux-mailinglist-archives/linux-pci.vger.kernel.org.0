Return-Path: <linux-pci+bounces-31600-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 68B33AFACF0
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 09:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD4581764F5
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 07:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF67A286433;
	Mon,  7 Jul 2025 07:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XI/WP+1U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21EF028641E
	for <linux-pci@vger.kernel.org>; Mon,  7 Jul 2025 07:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751872817; cv=none; b=NWpPNPmRdSx1UWg4Di1qPhKvjnp+1NmnAUmwc1HE2XaMTW1aqIJaDRVYIomP8smMcCT+myLX2M8OsroiGu1gY4dxqObTshA74r5tCurXsB7RkL0JVK20B+DAwmAa2NwzHztwqLg1hq5zNAvu0aRedwoywqYXB4tcAfAGHVXqeEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751872817; c=relaxed/simple;
	bh=87Ke5nC7A24u7KtVf8kqJVSYbabKjGlRuRbxRJNwnno=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=U9zqX9vrthLH5ngudeqRgp4Ga8us2ILBu2n0P7kQCHPmMTVEZA4iHOuIVuD7KjMud9LHD8Zk1uIzfHnFIRdqfGmH003rLf8U8c+8+02LlgwHp61HJ0g/hongJOBcDQXdrLbqW/oSkdhooyrj1BhRLPAhbSQlF4SKo5k5dXl3swA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XI/WP+1U; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a4f8192e2cso1533865f8f.3
        for <linux-pci@vger.kernel.org>; Mon, 07 Jul 2025 00:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751872814; x=1752477614; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CPa/GNPaGoYDS7VJTJPTGS9zhlJrJsTcMsk83eU4tMI=;
        b=XI/WP+1UkgUgJQNXkAtnfoLImU/pkNWnfWbpDMdSDX7j/C3YsKu+zakYq7hXMpHPrv
         plbr79oP2v9o004Nl/DNaEMqirGgruRowsyRrT8DTYm8JKDN/U6zn0y4LoTKYl+qE7ar
         HHxviqGRLg+IfV65VLWBzJXs1OoW0/+f3+Oxum/p82REndjaZvg1oRwRvZUifGg5rijd
         u2ZYrCpvgxmphBfgUXrkWmpE8xvQchqtaTmUzN/3lmHyDM7PtaFG4fC3ShviCV2uXWsm
         tBSUkSAZkmXFW/xso6G3WvqCA4vAQc2YdK5MTrCahAgrXpIOaJRcahJBu6MzipB0Ysgd
         kOvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751872814; x=1752477614;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPa/GNPaGoYDS7VJTJPTGS9zhlJrJsTcMsk83eU4tMI=;
        b=L0PZsIjGLSQuEyacmhJ+q4BIH7oRvIFW41JY8AOBobfRST3W2pG2PuzqshhepmFT+P
         uqyeyI/3DgtJ4GOTP8V3vvpu9XKRaboFfC3ToOVA/1DAlrJHFcHSPJwGg/ClgB3YZbPi
         MKnHDBAjbMLn+rzm4dOLI8uh/bW5K0KL5lhGPmW753CVTF/mzE8HYzstaB9xxy3s1hWk
         qg4ydsER84tlX+CMIP+ogTerXSG7l/M7Il6pb95V4059MObk6RfmpRiElov2hQ712FAt
         Fwl9+b3mpTMzoPdEc6cHlY4miu4UDk5lxGu/S7ugHZ4xJyKBOkby8t1Gg9+T3V14hc/B
         FbMA==
X-Forwarded-Encrypted: i=1; AJvYcCXW4MZ/zBlLW6oOK0MWGV3ZlIU1zLF/qqn6QPh0PO+3q9ok+ngNeumE3riQjxzMTWlk7MkzIXVQ/vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwltonmJ6I+ET2s2wE1ZV29OJkRWx2+DuD3d6rLkc3oAoLdwVwq
	Wkw7r9JDRkrGBDejXlbOunlhZnNRHvNdPPJooJliecoyVpiv/V9eqjK4o5GOsLMdab9g13FuNpJ
	bC+QUNLxmrJCTi6NstA==
X-Google-Smtp-Source: AGHT+IFc7KjdNjSAMcYeehUHBQshvYidNFTTtOkCBEt+IJunO64ZHKge3ng0VY/1tFIuP98OJUwpkNE/tVUytCk=
X-Received: from wrbep8.prod.google.com ([2002:a05:6000:42c8:b0:3a4:f6c6:e37f])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:1a8b:b0:3a5:27ba:479c with SMTP id ffacd0b85a97d-3b49702e827mr8298792f8f.43.1751872814443;
 Mon, 07 Jul 2025 00:20:14 -0700 (PDT)
Date: Mon, 7 Jul 2025 07:20:12 +0000
In-Reply-To: <aGgETV_-MgEiZDHC@Mac.home>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
 <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com>
 <aGgDpWkU6xAn5IFN@Mac.home> <aGgETV_-MgEiZDHC@Mac.home>
Message-ID: <aGt1LLA8acAzDAGU@google.com>
Subject: Re: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and handlers
From: Alice Ryhl <aliceryhl@google.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Benno Lossin <lossin@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C2=B4nski?=" <kwilczynski@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Jul 04, 2025 at 09:41:49AM -0700, Boqun Feng wrote:
> On Fri, Jul 04, 2025 at 09:39:01AM -0700, Boqun Feng wrote:
> > On Thu, Jul 03, 2025 at 04:30:01PM -0300, Daniel Almeida wrote:
> > [...]
> > > +#[pin_data]
> > > +pub struct Registration<T: Handler + 'static> {
> > > +    #[pin]
> > > +    inner: Devres<RegistrationInner>,
> > > +
> > > +    #[pin]
> > > +    handler: T,
> > 
> > IIRC, as a certain point, we want this to be a `UnsafePinned<T>`, is
> > that requirement gone or we still need that but 1) `UnsafePinned` is not
> > available and 2) we can rely on the whole struct being !Unpin for the
> > address stability temporarily?
> > 
> > I think it was not a problem until we switched to `try_pin_init!()`
> > instead of `pin_init_from_closure()` because we then had to pass the
> > address of `handler` instead of the whole struct.
> > 
> > Since we certainly want to use `try_pin_init!()` and we certainly will
> > have `UnsafePinned`, I think we should just keep this as it is for now,
> 
> Of course the assumption is we want to it in before `UnsafePinned` ;-)
> Alternatively we can do what `Devres` did:
> 
> 	https://lore.kernel.org/rust-for-linux/20250626200054.243480-4-dakr@kernel.org/
> 
> using an `Opaque` and manually drop for now.

The struct uses PhantomPinned, so the code is correct as-is. Using a
common abstraction for UnsafePinned is of course nice, but I suggest
that we keep it like this if both patches land in the same cycle. We can
always have it use UnsafePinned in a follow-up.

Alice

