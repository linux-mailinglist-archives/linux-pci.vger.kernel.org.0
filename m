Return-Path: <linux-pci+bounces-35386-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37C14B422F1
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 16:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 069EF480783
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 14:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C32C310650;
	Wed,  3 Sep 2025 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o18GiFqt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6517A30EF77;
	Wed,  3 Sep 2025 14:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908080; cv=none; b=kpT2wq6DSJ837S2W6umIr14pjHV5RLKIKVW6ildVbkjaT6jcfCzhymEe1khXQoq2jo2Kv1MCS5jBgFYG5sGP42cHtvwWjJ87I1HlqcZUFx6zAzK9uQnNi1rc17Uuf/rg2QcrlE9tQA30by/KbZuE5fJojJMq4mpuC7JAdI1dh7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908080; c=relaxed/simple;
	bh=FJMDSqDO90aLIKIzXSm53PkCGpKkl5adjRT6pwHdadA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SGJZavCHps6Kk6130iHUfUjjGGRKEJ/o/YdZ/Xg5Qv9Io5dLebHN1e38U6ez67HYHegLsstZyyLg4oSMPrdkBWMApo4Dy0/FbSO4EsWB/q/JMQ6MUFAyo+Wh8CoAmW1k9nQxY84CKUVF6l4B2QjrAkEoqeaxowooBSGmZPqYPas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o18GiFqt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60995C4CEE7;
	Wed,  3 Sep 2025 14:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756908080;
	bh=FJMDSqDO90aLIKIzXSm53PkCGpKkl5adjRT6pwHdadA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o18GiFqtSeWmLFwd/cxl+YhcnawUyAxOTOzwIhtPdrbqk0JeezZw2d2movH9K48K4
	 okPOzMhPFeS9zjBwvb1MazkSnx7z9K/8fi13QiA8cklD6i2PuCLQP3/kbjxNdKfD01
	 rSbGdrTB4FFTE5QvB/e06ciiXp7qIvPbhj++iOKzrB8J5gBpnRkaLxvhaG+wSIHfIF
	 2SHxkcs4C5SFuXhvji1ZE2ZR+YHBlPnnfZAy+FARYP/mbuRqVRYr5k5pW4QYHoxQm1
	 G446Jt7eLfJNhgoJ/6mA5WfgOB+VQvN8OZg2NyUkhzm0SIGChxw9EVIucYIzPC0SqJ
	 sCmZDr3ptGiug==
Date: Wed, 3 Sep 2025 15:01:15 +0100
From: Lee Jones <lee@kernel.org>
To: Marcos Del Sol Vives <marcos@orca.pet>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Michael Walle <mwalle@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-gpio@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 3/3] mfd: vortex: implement new driver for Vortex
 southbridges
Message-ID: <20250903140115.GC2764654@google.com>
References: <20250822135816.739582-1-marcos@orca.pet>
 <20250822135816.739582-4-marcos@orca.pet>
 <20250902151828.GU2163762@google.com>
 <45b84c38-4046-4fb0-89af-6a2cc4de99cf@orca.pet>
 <20250903072117.GY2163762@google.com>
 <1d4352b6-c27e-4946-be36-87765f3fb7c3@orca.pet>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1d4352b6-c27e-4946-be36-87765f3fb7c3@orca.pet>

On Wed, 03 Sep 2025, Marcos Del Sol Vives wrote:

> El 03/09/2025 a las 9:21, Lee Jones escribió:
> >>>> +static const struct mfd_cell vortex_dx_sb_cells[] = {
> >>>> +	{
> >>>> +		.name		= "vortex-gpio",
> >>>> +		.resources	= vortex_dx_gpio_resources,
> >>>> +		.num_resources	= ARRAY_SIZE(vortex_dx_gpio_resources),
> >>>> +	},
> >>>> +};
> >>>
> >>> It's not an MFD until you have more than one device.
> >>
> >> Same as above.
> > 
> > It will not be accepted with only a single device (SFD?).
> > 
> 
> I've been working on making all the changes, except this one.
> 
> If you prefer, I can either implement the watchdog now, add it on this

Yes, please implement the WDT now.

> patch series and thus make it a proper MFD (at the cost of delaying
> even further the GPIO inclusion), or keep the struct mfd_cell array
> as a single-element array and implement the watchdog later on another
> merge request, using that very same array.
> 
> I am however not okay with wasting my time rewriting that to bypass
> the MFD API for this, so I can waste even more time later
> implementing again the MFD API, just because linguistically
> one (right now) is technically not "multi".

I don't get this.  If you implement the WDT now, you will be "multi", so
what are you protesting against?

> That seems very unreasonable, specially when it wouldn't be a first
> since at least these other devices are also using MFD with a single
> device:
> 
>   - 88pm80

% grep name drivers/mfd/88pm800.c
	.name = "88pm80x-rtc",
	.name = "88pm80x-onkey",
	.name = "88pm80x-regulator",
	.name = "88pm800",

>   - 88pm805

% grep name drivers/mfd/88pm805.c       
	.name = "88pm80x-codec",
	.name = "88pm805",

>   - at91-usart

% grep NAME drivers/mfd/at91-usart.c
	MFD_CELL_NAME("at91_usart_spi");
	MFD_CELL_NAME("atmel_usart_serial");

>   - stw481x

* Copyright (C) 2013 ST-Ericsson SA

>   - vx855

* Copyright (C) 2009 VIA Technologies, Inc.

>   - wm8400

* Copyright 2008 Wolfson Microelectronics PLC.

>   - zynqmp (last changed in 2024, so certainly not legacy!)

This should _not_ be using the MFD API at all!

> And probably others since I did not look too deep into it.
> 
> Greetings,
> Marcos
> 

-- 
Lee Jones [李琼斯]

