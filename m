Return-Path: <linux-pci+bounces-20957-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 285F7A2CE83
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 21:55:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F5F3188E865
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 20:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867DD1AB6D8;
	Fri,  7 Feb 2025 20:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bG0vnmjE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50511A8F97
	for <linux-pci@vger.kernel.org>; Fri,  7 Feb 2025 20:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738961732; cv=none; b=oy5tqlfPOe4kOhfsBtfmdTqqt9tx0MLR0w+ZBBOY012P4USsvOH1HA8xw2kV9h711krpZi2iKpLbAwV1NUdUrnjzZd0wQjAYavXgoE6n6ml734zYIOkGL5SrSAWQylWPJVz7Y35AoPuarAd54KmkJPIQCRVIXAjFiuvDgDC8BLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738961732; c=relaxed/simple;
	bh=C7bqweA12h38rcKsGaQED1Ruwl6dcgOcvq9QnHKfCj4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jZMvbHupH+KLAxEGTwnR8l/AZlUI/idzrRsss6IsbvPcXLKA7AMtsmsN6uB4yFpXo+/L5damkzEoJwXYVKsx1ToXSH6CsstZGHwlW6rE6af3d7+7eTxqsqhr/bLCKrt4OBlb7HOUQn+8LlJoSnFrQVBqWm1HmaFidv2jHOz5SNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bG0vnmjE; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f40deb941so45378175ad.2
        for <linux-pci@vger.kernel.org>; Fri, 07 Feb 2025 12:55:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1738961730; x=1739566530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YlWyHb1yBc5DBniS4DiHdUvL/zX6NTlfaoF7d9baRFQ=;
        b=bG0vnmjEtnwAIxDQwsAO4qPnky02tfSk9waK/EMrT5IclCWWIFfoaXSIbG6akXuXHr
         Jtk8lCd8+OgxuPCepJXb+dTzJVE2uMW/aMfVJIFXOhSCD0WfWe5V1jiJLhHhLCrj0qlA
         E7RG/o1IUioDMJSAnPhY7fG+yfCilwR15QzNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738961730; x=1739566530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YlWyHb1yBc5DBniS4DiHdUvL/zX6NTlfaoF7d9baRFQ=;
        b=YZ/RQEnvO5MB44H6eyXe0kznnlSWG8afw0q/U0aW8gEK6LfBNGUGoD7RElCE8m+M3O
         3Y3WwPDyPsSBo9+kZY7j9MsxkT8FhTI1ubjsNv7jUZ6RSOgFXeX4AzSOKv1IJlOcJ9LM
         J29NiOmzZNrwFVsALh98p4yjid5HWQMFFgwjO5ShE3fv6cUI596514vjm1ggsJr34IFJ
         TwKjCvK9ORnLb+XAd7mDOjOIIl39hggqSomBNuYUVl88h5DjtGf13EpGoscqP9Dgiijj
         lOR1ijJ1qLpioxXZ9APMTxwP85JZeYX9SBZ21yYg+nn2BxcqTvUDznRDLifRlwbQ3Qa9
         zsWg==
X-Forwarded-Encrypted: i=1; AJvYcCU68rv9s/v7IL5DjAvxRlv0px0gxbF0wxFzKD8LhNKKq5sIb/+vVnqp4gdZchTrpoPgfmCnWpkUmP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPspbxE3CkdOV5lrGFH2WJ7rK0ZQSzyboqCYR1WnmPhWVEMQgv
	mi2v5G7SetBfoir7jNT/+Q/UcR6xmrOdL814UzMIUDdgGlyfC24X/Q5SjFMAAg==
X-Gm-Gg: ASbGnctr9SBa1EK8dNA3k6H/6Te51aeiOSexIrqb4++eiLfqWBI1oFN7yjr71RPmdlm
	J6baG8vnFckKmOBiGn59HM9PrHkaBfv9FH4OtAll0AwU5sFa7uIc12ftmHPAK2008BdT8w7cQLb
	RIhpY35TH6/7ml7PmXkJ4DaGAqVmZS7e5GEm+9cTS7LE8CiF4vPNre5nBWO1/srm8Gdx7Syi34L
	SjAd92nAkf4UiBZZ+jAMKgUFAMrUgqT7mz6hMSRyiCTFFO445FBLseXyoF5DGxVF2y9HZgbE4Yd
	jcKfoXbuqjRD/dHyKq3sLFBODwVDRq40EZbLaFA1KkLlEnD8FdDRZg==
X-Google-Smtp-Source: AGHT+IHxVWGTJ8hkbVNiUmFo89nI3fRGDKAHNUiE/0JoLsfO45nS7VGDoTGDUnknnSjSpAmyGAAq5Q==
X-Received: by 2002:a05:6a21:151b:b0:1e1:adcd:eae5 with SMTP id adf61e73a8af0-1ee03b761a8mr9077244637.42.1738961730134;
        Fri, 07 Feb 2025 12:55:30 -0800 (PST)
Received: from localhost ([2a00:79e0:2e14:7:bdbd:e5f8:229c:716e])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-ad51af7b744sm3554318a12.77.2025.02.07.12.55.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Feb 2025 12:55:29 -0800 (PST)
Date: Fri, 7 Feb 2025 12:55:28 -0800
From: Brian Norris <briannorris@chromium.org>
To: Marc Zyngier <maz@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: dwc: Use level-triggered handler for MSI IRQs
Message-ID: <Z6ZzQKf1N4kBifok@google.com>
References: <20250205151635.v2.1.Id60295bee6aacf44aa3664e702012cb4710529c3@changeid>
 <87ed0btpfj.wl-maz@kernel.org>
 <Z6UWK6EvOLRrtRDH@google.com>
 <86mseyt8w3.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86mseyt8w3.wl-maz@kernel.org>

Hi Marc,

On Fri, Feb 07, 2025 at 09:13:32AM +0000, Marc Zyngier wrote:
> On Thu, 06 Feb 2025 20:06:03 +0000,
> Brian Norris <briannorris@chromium.org> wrote:
> > First off, thanks for reviewing. I'm a bit unsure about some of this
> > area, which is one reason I sent this patch. Maybe it could have been
> > "RFC".
> 
> RFC means nothing to me. Or rather, RFC is a sure indication that a
> patch can safely be ignored! ;-) My advise on this front is to either
> post patches as you have done, or not post it at all.

Haha, OK, I guess you're a Cunningham's Law proponent :)

> > (See also v1: https://lore.kernel.org/all/Z3ho7eJMWvAy3HHC@google.com/
> > 
> > I'm dealing with HW bugs that cause me to have to configure the output
> > signal -- msi_ctrl_int -- as EDGE-triggered on my GIC. This is adjacent
> > to that problem, but doesn't really solve it.)
> 
> Configuring a level-triggered signal as edge is another recipe for
> disaster (a sure way to miss interrupts),

I'm very well aware of that, but I'm not aware of great alternatives.

> but short of a description
> of your particular issue, I can't help on that.

Sure, I'm not really asking for that, at least not in this forum. I'm
just trying to color the background a bit, that I'm not trying to flip
level/edge settings just for fun.

> > On Thu, Feb 06, 2025 at 09:04:00AM +0000, Marc Zyngier wrote:
> > > It also breaks the semantics of
> > > interrupt being made pending while we were handling them (retrigger
> > > being one).
> > 
> > What do you mean here? Are you referring to SW state (a la
> > IRQS_PENDING), or HW state? For HW state, MSIs are accumulated in the
> > STATUS register even when we're masked, so they'll "retrigger" when
> > we're done handling. But I'm less clear about some of the IRQ framework
> > semantics here.
> 
> IRQS_PENDING is indeed what indicates the SW-driven retrigger state,
> by which any part of the kernel can decide to reinject an *edge*
> interrupt if, for any reason, it needs to.

Are you referring to check_irq_resend() and related code? Notably, the
current patch doesn't actually change the result of
irq_settings_is_level() -- the nested descriptor still retains its
"edge" status -- so the "We do not resend level type interrupts" comment
doesn't actually apply.

But anyway, that still suggests my patch is probably the wrong way to go
about things, as it further mixes up "edge" and "level" concepts.

> This is actually how lazy masking is implemented, by not masking the
> interrupt, taking it (which is a "consume" operation), realising we
> were logically masked, masking it for good and marking it as
> SW-pending for later processing. Hence the while{} loop in
> handle_edge_irq().

Sure, I've familiarized myself with lazy masking. I don't think it
causes any problem here; handle_level_irq simply non-lazily masks it,
and we'll pick up the latched result (if any) again when we eventually
unmask.

> Switching to level triggered removes most of that processing, since by
> definition, a level is not consumed when acking the interrupt. You
> need to talk to the end-point for the level to drop, so simply masking
> the interrupt is enough to get it back when unmasking it.

Ack, thanks.

Brian

