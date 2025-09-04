Return-Path: <linux-pci+bounces-35442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B47C3B4388F
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 12:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F64A7C7420
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 10:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE43A2FF659;
	Thu,  4 Sep 2025 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NbZV1EL9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38D12FC88C;
	Thu,  4 Sep 2025 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756981030; cv=none; b=QuYLj6rb/0OeAmhWEeIVPq7U6VAOSRGBdnXI1PbKSkZdgXQHgCxs2Wcefu5Ubk4M8ZmjknThX7bHBIYGkxayrVbX0RqAVV064viJ/gcUMns8Mwo2YudgDyEA1Pob5ZPWK3BhDKxo1Kxjx/ZVTNM37SJG4/2JoHi0J5NAf8DgPQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756981030; c=relaxed/simple;
	bh=duLXcxHxnqA9I6Kn+bFKpUPkSdYijVdBFHayt4D5GN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K9z5Ivaf9mBHwR1SS+B4RSFzEEMFIHJ4Polu6/kaPQ4nfP4qgT6D+hELL9os+2yzd4Puf94Z5uBVGDmlgkCBLcSVB9zX4XakLntnNMQThnph61VEskoR/MEzDDfuS1TJLUPhA6MtAeK+w+F6CiIqT9Gf4krS/NJnETQLexaaP6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NbZV1EL9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7785DC4CEF1;
	Thu,  4 Sep 2025 10:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756981030;
	bh=duLXcxHxnqA9I6Kn+bFKpUPkSdYijVdBFHayt4D5GN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NbZV1EL9biqhu+pH/c9KXyw0mkZ6P//zxZ4SeeqcfTNtHJrozOl/nQfjnBF55nlZ8
	 O+dll3UN/fXrLTIn6pxoSsdAjurfENPU8URzR4osQGFAc+HleTBJKahk0KgLMpedRF
	 4wQbC1wVUj01/3BSctg6FEYOWSHEzuCOsux7hWTXT+s6R1oXPIWvHP7hZcgtWcmsNH
	 nZ4qnYh/9iMk1JRAUlVH6MCNmhGoshJQgAqQoY1VV4XplYCfgaQr1y7n9A4SRY29/j
	 bynuvOI8eJlpB0UzKtzYvz+xwBjKidDkG/79XfNyvhvGYIp7xenvVysZkY6xrOjuQG
	 qfEjnAuVbE6EQ==
Date: Thu, 4 Sep 2025 11:17:05 +0100
From: Lee Jones <lee@kernel.org>
To: Marcos Del Sol Vives <marcos@orca.pet>
Cc: linux-kernel@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Michael Walle <mwalle@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-gpio@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v4 3/3] mfd: vortex: implement new driver for Vortex
 southbridges
Message-ID: <20250904101705.GH2764654@google.com>
References: <20250822135816.739582-1-marcos@orca.pet>
 <20250822135816.739582-4-marcos@orca.pet>
 <20250902151828.GU2163762@google.com>
 <45b84c38-4046-4fb0-89af-6a2cc4de99cf@orca.pet>
 <20250903072117.GY2163762@google.com>
 <1d4352b6-c27e-4946-be36-87765f3fb7c3@orca.pet>
 <20250903140115.GC2764654@google.com>
 <b11dcd50-a87e-47ff-b406-776e432f07bd@orca.pet>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b11dcd50-a87e-47ff-b406-776e432f07bd@orca.pet>

On Wed, 03 Sep 2025, Marcos Del Sol Vives wrote:

> El 03/09/2025 a las 16:01, Lee Jones escribió:
> >> patch series and thus make it a proper MFD (at the cost of delaying
> >> even further the GPIO inclusion), or keep the struct mfd_cell array
> >> as a single-element array and implement the watchdog later on another
> >> merge request, using that very same array.
> >>
> >> I am however not okay with wasting my time rewriting that to bypass
> >> the MFD API for this, so I can waste even more time later
> >> implementing again the MFD API, just because linguistically
> >> one (right now) is technically not "multi".
> > 
> > I don't get this.  If you implement the WDT now, you will be "multi", so
> > what are you protesting against?
> 
> That GPIO is something required to perform the poweroff sequence, a must
> for any machine, while WDT is just a "nice to have".
> 
> Implementing now the WDT just because of a linguistic preference means
> delaying something more important in favour of a "nice to have".

You use the word "delaying" here.  What's the rush?

If you only need a GPIO driver, then you don't need the MFD part.

> >> That seems very unreasonable, specially when it wouldn't be a first
> >> since at least these other devices are also using MFD with a single
> >> device:
> >>
> >>   - 88pm80
> > 
> > % grep name drivers/mfd/88pm800.c
> > 	.name = "88pm80x-rtc",
> > 	.name = "88pm80x-onkey",
> > 	.name = "88pm80x-regulator",
> > 	.name = "88pm800",
> 
> If you open the file, you'll see it uses five single-element arrays.

Which is fine.

> >>   - 88pm805
> > 
> > % grep name drivers/mfd/88pm805.c       
> > 	.name = "88pm80x-codec",
> > 	.name = "88pm805",
> > 
> 
> Same as above.
> 
> >>   - at91-usart
> > 
> > % grep NAME drivers/mfd/at91-usart.c
> > 	MFD_CELL_NAME("at91_usart_spi");
> > 	MFD_CELL_NAME("atmel_usart_serial");
> 
> Has two single-element arrays. It registers one or the other, never both
> (just like my patch does!)

Fair point.

I guess this is more of a selector than a true concurrent MFD.

> >>   - stw481x
> > 
> > * Copyright (C) 2013 ST-Ericsson SA
> > 
> >>   - vx855
> > 
> > * Copyright (C) 2009 VIA Technologies, Inc.
> > 
> >>   - wm8400
> > 
> > * Copyright 2008 Wolfson Microelectronics PLC.
> > 
> 
> To my knowledge the definition of "multi" has not been changed
> since any of those years.

If they were submitted during my tenure, it is likely that they would
not have been accepted.  Besides, past mistakes is no excuse for making
them in the present.

-- 
Lee Jones [李琼斯]

