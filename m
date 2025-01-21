Return-Path: <linux-pci+bounces-20174-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC66A1797F
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 09:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C76B3AB356
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 08:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302D21BD519;
	Tue, 21 Jan 2025 08:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="M5Xa5p4k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D89551B4245;
	Tue, 21 Jan 2025 08:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737449284; cv=none; b=CniEE/RLlFQenH+0O0/ooIlaF53vZM2D0KDBVDIXAoo3JZYxTlROVQp27XC2B3jrHmdYSsM3lC/hDrc5Djvfb1LX7/gqafdjn0/bQ+UP3lHrxhIto7szuxm8kmgyFMkMkk89Tkim2MQktAPsHxnMMEwKxxBAKtRUcAMgbCOL8iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737449284; c=relaxed/simple;
	bh=PsH0RbnSJR1t5DhFUKCC+uHt3DiuAQqDmYt2pnrP8AI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U6Z5u+bHrrGhqpLINUvTvQNvCU3aXpSCl72E/h0fdPbwttw4y8C+t91osPDBF62t6ato6WKm5FHf+w0GzOPfX0ut+4hwndQ7vOTAnvJiIb2N32D7bS8MPTogNjvlDRAscNqHAzE5vWDPeodR5RQGHebMphOrCGkyxnPuuYaKoN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=M5Xa5p4k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B97C5C4CEDF;
	Tue, 21 Jan 2025 08:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737449283;
	bh=PsH0RbnSJR1t5DhFUKCC+uHt3DiuAQqDmYt2pnrP8AI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M5Xa5p4kghr5it6pXe4nWwurjJYNja7mNvUgyNBEbchbR4Vp2YpVDbUsgDtf8T8tb
	 QLTkPCHaWdAB34g2a21A0rLEtfU4cPHP95aZjS65bQaQOpjPUlKZYFqy53P6djLtpt
	 DiZp+HlPJhKh61ys32dZgj+uMvN7cL/2xJ8heF/c=
Date: Tue, 21 Jan 2025 09:48:00 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v6 08/10] misc: rp1: RaspberryPi RP1 misc driver
Message-ID: <2025012143-rippling-rehydrate-581b@gregkh>
References: <cover.1736776658.git.andrea.porta@suse.com>
 <550590a5a0b80dd8a0c655921ec0aa41a67c8148.1736776658.git.andrea.porta@suse.com>
 <2025011722-motocross-finally-e664@gregkh>
 <Z49eOdVvwknOoD3E@apocalypse>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z49eOdVvwknOoD3E@apocalypse>

On Tue, Jan 21, 2025 at 09:43:37AM +0100, Andrea della Porta wrote:
> Hi Greg,
> 
> On 12:47 Fri 17 Jan     , Greg Kroah-Hartman wrote:
> > On Mon, Jan 13, 2025 at 03:58:07PM +0100, Andrea della Porta wrote:
> > > The RaspberryPi RP1 is a PCI multi function device containing
> > > peripherals ranging from Ethernet to USB controller, I2C, SPI
> > > and others.
> > > 
> > > Implement a bare minimum driver to operate the RP1, leveraging
> > > actual OF based driver implementations for the on-board peripherals
> > > by loading a devicetree overlay during driver probe.
> > > 
> > > The peripherals are accessed by mapping MMIO registers starting
> > > from PCI BAR1 region.
> > > 
> > > With the overlay approach we can achieve more generic and agnostic
> > > approach to managing this chipset, being that it is a PCI endpoint
> > > and could possibly be reused in other hw implementations. The
> > > presented approach is also used by Bootlin's Microchip LAN966x
> > > patchset (see link) as well, for a similar chipset.
> > > 
> > > For reasons why this driver is contained in drivers/misc, please
> > > check the links.
> > 
> > Links aren't always around all the time, please document it here why
> > this is needed, and then links can "add to" that summary.
> 
> Ack.
> 
> > 
> > > This driver is heavily based on downstream code from RaspberryPi
> > > Foundation, and the original author is Phil Elwell.
> > > 
> > > Link: https://datasheets.raspberrypi.com/rp1/rp1-peripherals.pdf
> 
> ...
> 
> > > diff --git a/drivers/misc/rp1/rp1_pci.c b/drivers/misc/rp1/rp1_pci.c
> > > new file mode 100644
> > > index 000000000000..3e8ba3fa7fd5
> > > --- /dev/null
> > > +++ b/drivers/misc/rp1/rp1_pci.c
> > > @@ -0,0 +1,305 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * Copyright (c) 2018-24 Raspberry Pi Ltd.
> > > + * All rights reserved.
> > > + */
> > > +
> > > +#include <linux/err.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/irq.h>
> > > +#include <linux/irqchip/chained_irq.h>
> > > +#include <linux/irqdomain.h>
> > > +#include <linux/module.h>
> > > +#include <linux/msi.h>
> > > +#include <linux/of_platform.h>
> > > +#include <linux/pci.h>
> > > +#include <linux/platform_device.h>
> > > +
> > > +#include "rp1_pci.h"
> > 
> > Why does a self-contained .c file need a .h file?  Please put it all in
> > here.
> 
> I agree with you. Indeed, the very first version of this patch had the header
> file placed inside the .c, but I received concerns about it and some advice to
> do it differently, as you can see here:
> https://lore.kernel.org/all/ZtWDpaqUG9d9yPPf@apocalypse/
> so I've changed it accordingly in V2. So right now I'm not sure what the
> acceptable behaviour should be ...

It's a pretty simple rule:
	Only use a .h file if multiple .c files need to see the symbol.

So no .h file is needed here.

> > > +struct rp1_dev {
> > > +	struct pci_dev *pdev;
> > > +	struct irq_domain *domain;
> > > +	struct irq_data *pcie_irqds[64];
> > > +	void __iomem *bar1;
> > > +	int ovcs_id;	/* overlay changeset id */
> > > +	bool level_triggered_irq[RP1_INT_END];
> > > +};
> > > +
> > > +static void msix_cfg_set(struct rp1_dev *rp1, unsigned int hwirq, u32 value)
> > > +{
> > > +	iowrite32(value, rp1->bar1 + RP1_PCIE_APBS_BASE + REG_SET + MSIX_CFG(hwirq));
> > 
> > Do your writes need a read to flush them properly?  Or can they handle
> > this automatically?
> >
> 
> I had some thoughts with RaspberryPi foundation folks to double check it, and it
> seems that there should be no need to readback the value (unless we want to go
> really paranoid), so I would avoid that since in case of level handled interrupt
> we would end up reading the register on every triggering interrupts.

Ok, if it passes testing, that's fine, hopefully it works properly, but
if not, you now have a trail to go and fix it in the future :)

thanks,

greg k-h

