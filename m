Return-Path: <linux-pci+bounces-19607-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70BD2A079B8
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 15:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C50B1882E96
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 14:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3596921B1AB;
	Thu,  9 Jan 2025 14:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="VqJhCfXk"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4A08F4A;
	Thu,  9 Jan 2025 14:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736434255; cv=none; b=IvnB8//U80raTANslAvHTrG20kW4mip4fNV1EDLQ+TRXBYPpR01NuVisI/bzuACcdJqRUFMk2tsgfdGfhtjwSHVvNa4WrF1pyGAsd1BvhbFhtJux+DrJAd26ntjYUrgAMMdpOjF4okIem8jfED73QdDpizxtC3ziiQSSXkT5Q+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736434255; c=relaxed/simple;
	bh=3LgF0zv4c4dacowD9+6H06zwOq7Mhc/SP+Mk3BKPuxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Av3f/Z151zP/NBLRan06XJr1e7qE5Clt6nMyfHP7idhRTuB+9xWtsWt/xv6coww0KBE+GpMDzn+en2MA+tIyPIW0RiNgKJhHoJgpVE99aWZDMXG1ZNKKhUIwN61LN8TZ+kCVGvcb5AFz5ZQUOrwkUIChgnDdh7rQ/629H5vXbSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VqJhCfXk; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 56A2120004;
	Thu,  9 Jan 2025 14:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736434244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LtaQCAfVpC5phcNBcjS77EwWPeSgl2U8pwTLOU1Od44=;
	b=VqJhCfXkn2snSlj5/z0nn2AcrHXgyZX4rNHvQiWrN4h9FcGTraRiBwMOoW4O8dpw5kU7SC
	xbYftV1xMf2mjqaS6RboHuuvDzbNnJI8cCz/VA7pRB9mKgdTGI1uyv2H9FOFvMmLwHe/jd
	6gcEZ4JzMnzrqH2ZuK30m14KUPVjtjbjBAxdbWulUYa0vj4/TFwBDCAbY3aTQYxyOKQKxA
	yvQeHf3+zdTxGDFPG63dJ0S2oedHvZAb4UHoDg2LxEF87M41iYEfn53RyYG59hOxNjyDSg
	/XXgCua/sEe4IGTVRoLDO6rHPcXxasd0m+dT9nZDlq2nGODc/yi2hbZVdoxN6Q==
Date: Thu, 9 Jan 2025 15:50:36 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Rob Herring <robh@kernel.org>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Florian
 Fainelli <florian.fainelli@broadcom.com>, Broadcom internal kernel review
 list <bcm-kernel-feedback-list@broadcom.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Krzysztof Wilczynski <kw@linux.com>, Manivannan
 Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Linus Walleij <linus.walleij@linaro.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Derek Kiernan <derek.kiernan@amd.com>, Dragan
 Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Saravana Kannan
 <saravanak@google.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, Masahiro Yamada
 <masahiroy@kernel.org>, Stefan Wahren <wahrenst@gmx.net>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v5 08/10] misc: rp1: RaspberryPi RP1 misc driver
Message-ID: <20250109155036.27b82b7e@bootlin.com>
In-Reply-To: <Z3_ZlvbszezcanA4@apocalypse>
References: <cover.1733136811.git.andrea.porta@suse.com>
	<28fe72eec1c08781770cee65032bb10a6d5994a9.1733136811.git.andrea.porta@suse.com>
	<20241210224837.GA702616-robh@kernel.org>
	<Z2A0aAPotT0NvoCl@apocalypse>
	<Z3_ZlvbszezcanA4@apocalypse>
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

On Thu, 9 Jan 2025 15:13:42 +0100
Andrea della Porta <andrea.porta@suse.com> wrote:

> Hi Rob,
> 
> On 15:08 Mon 16 Dec     , Andrea della Porta wrote:
> > Hi Rob,
> > 
> > On 16:48 Tue 10 Dec     , Rob Herring wrote:  
> > > On Mon, Dec 02, 2024 at 12:19:32PM +0100, Andrea della Porta wrote:  
> > > > The RaspberryPi RP1 is a PCI multi function device containing
> > > > peripherals ranging from Ethernet to USB controller, I2C, SPI
> > > > and others.  
> 
> ...
> 
> > > > +#define RP1_INT_ADC_FIFO	52
> > > > +#define RP1_INT_PCIE_OUT	53
> > > > +#define RP1_INT_SPI6		54
> > > > +#define RP1_INT_SPI7		55
> > > > +#define RP1_INT_SPI8		56
> > > > +#define RP1_INT_SYSCFG		58
> > > > +#define RP1_INT_CLOCKS_DEFAULT	59
> > > > +#define RP1_INT_VBUSCTRL	60
> > > > +#define RP1_INT_PROC_MISC	57  
> > > 
> > > Why all these defines which will never be used because they come from 
> > > DT?
> > >  
> > 
> > Right, those defines where originally designed to be included from dts, but
> > previous discussion deemed interrupt numbers to be hardcoded instead of being
> > specified as mnemonics. In the driver source code I just use RP1_INT_END as the
> > number of interrupts but I thought that the specific interrupt numbers should
> > be documented in some way or another. Since no one is currently referencing
> > those defines, would it be better to just turn those in a multiline comment
> > just to describe them in a more compact form?  
> 
> So, here's a couple of proposals about the interrupt defines:
> 
> - since they were banned from devicetree, and are not used anywhere in the code,
>   turn them into a (admittedly long) multiline comment, so they are still at
>   least documented
> 
> - since they were banned from devicetree, and are not use anywhere in the code,
>   just drop them, we don't currently need them after all
> 
> Not sure what's the best way here, anyone can advise?

Maybe in the #interrupt-cells description in the device-tree binding?

In your patch 4, you describe this interrupt controller and you have:
  '#interrupt-cells':
    const: 2
    description:
      Specifies respectively the interrupt number and flags as defined
      in include/dt-bindings/interrupt-controller/irq.h.

In this description, why not add the supported interrupt number values?
    description: |
      Specifies respectively the interrupt number and flags as defined
      in include/dt-bindings/interrupt-controller/irq.h.
      The supported values for the interrupt number are:
        - IO BANK0: 0
        - IO BANK1: 1
...

Or something similar.

This kind of description is already available. For instance:
  https://elixir.bootlin.com/linux/v6.13-rc1/source/Documentation/devicetree/bindings/dma/fsl,imx-sdma.yaml#L64

Does it make sense?

Best regards,
Hervé

