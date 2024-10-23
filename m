Return-Path: <linux-pci+bounces-15127-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919C19AD109
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 18:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0A051C2127C
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 16:33:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DD31CB301;
	Wed, 23 Oct 2024 16:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="iAf/g0I2"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A20DDAB;
	Wed, 23 Oct 2024 16:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729701174; cv=none; b=PIXOEAQ/y3jUWdRW4wHtywIRDpv1qdW1g77MPVmJTGtWUWCAEWBXiKqy0WFP0msfA5nNb7jBCSSRVrJ5FmQe1o6DpuFup1t+ms93oiBuVjvlNAkHPd5Lcltunl0rTVN585jN33NE2oJ4vImCY8f0mAaBXtgK08uwKa5tf8Nu27g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729701174; c=relaxed/simple;
	bh=TyywN/+wAMLWJRgELJOMExlGZYjMTxNyuaEfnm0ujeM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQlWGyHtQH3+OV6rwnvd+1ebRPjybpRVEswNcPrP418I3bKDKQbFy14ILGTPrgG4FDACiMMHk6VPl90X/Zf0k2uo44Xy7P9UMQkHK1xHwrAiMxTix7brtJ+BslvSm3vJFOq1Ho85HUcdNbFxK+/ZammV5T8XZOd8sPVV5r+zirI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=iAf/g0I2; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 60BC940002;
	Wed, 23 Oct 2024 16:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729701164;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2mo5TXq2lM94AOYob7sigSv7lm1UH6+vMtcH4MaKVCI=;
	b=iAf/g0I2OwQO00ReC6C88G//21aTCm8VlXqLUz0rDUOWS1CRki4N+V3xFVghUaJQNvn72n
	Qpk5JQCZK/Sbi2XAyf4zsqDNUyew8tVwAhxmYx+ezK0zr5DZgZK5VWfAyA5fzY2IEgyWV7
	DiH+k8QuSrgZsPY3p0v4k+Fws/eYodmishgCNQXEueUEzM3ZuN3oDY4gGT3ncZGbYTZzWP
	rFabYPUeE2ili/emKROsPngRGFeG1VimgOrtiIRQrsXqDtagozfdquWUHB5T4aARxllfNU
	6BsL05hnF4PrqEu0/dx/92y5hfmem7fy6oL2bPaBSJqrQEOsJjSzZonTu+JZGQ==
Date: Wed, 23 Oct 2024 18:32:40 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Stephen Boyd <sboyd@kernel.org>, Andrew Lunn <andrew@lunn.ch>, Arnd
 Bergmann <arnd@arndb.de>, Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn
 Helgaas <bhelgaas@google.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, Derek
 Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>, Linus Walleij
 <linus.walleij@linaro.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Luca
 Ceresoli <luca.ceresoli@bootlin.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, Masahiro Yamada <masahiroy@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@google.com>, St efan Wahren <wahrenst@gmx.net>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Will Deacon
 <will@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 phil@raspberrypi.com, jonathan@raspberrypi.com
Subject: Re: [PATCH v2 08/14] clk: rp1: Add support for clocks provided by
 RP1
Message-ID: <20241023183240.0dffae03@bootlin.com>
In-Reply-To: <ZxkX5gnDkWrTynRv@apocalypse>
References: <cover.1728300189.git.andrea.porta@suse.com>
	<022cf4920f8147cc720eaf02fd52c0fa56f565c5.1728300189.git.andrea.porta@suse.com>
	<611de50b5f083ea4c260f920ccc0e300.sboyd@kernel.org>
	<ZxkX5gnDkWrTynRv@apocalypse>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Andrea,


On Wed, 23 Oct 2024 17:36:06 +0200
Andrea della Porta <andrea.porta@suse.com> wrote:

> Hi Stephen,
> 
> On 15:08 Wed 09 Oct     , Stephen Boyd wrote:
> > Quoting Andrea della Porta (2024-10-07 05:39:51)  
> > > diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> > > index 299bc678ed1b..537019987f0c 100644
> > > --- a/drivers/clk/Kconfig
> > > +++ b/drivers/clk/Kconfig
> > > @@ -88,6 +88,15 @@ config COMMON_CLK_RK808
> > >           These multi-function devices have two fixed-rate oscillators, clocked at 32KHz each.
> > >           Clkout1 is always on, Clkout2 can off by control register.
> > >  
> > > +config COMMON_CLK_RP1
> > > +       tristate "Raspberry Pi RP1-based clock support"
> > > +       depends on PCI || COMPILE_TEST  
> > 
> > A better limit would be some ARCH_* config.  
> 
> I've avoided ARCH_BCM2835 since the original intention is for this driver
> to work (in the future) also for custom PCI cards with RP1 on-board, and not
> only for Rpi5.

Maybe depends on CONFIG_MISC_RP1 ?
CONFIG_MISC_RP1 enables the RP1 PCI driver

Best regards,
Hervé

