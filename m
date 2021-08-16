Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09D63ECD25
	for <lists+linux-pci@lfdr.de>; Mon, 16 Aug 2021 05:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbhHPDSp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Aug 2021 23:18:45 -0400
Received: from [138.197.143.207] ([138.197.143.207]:45316 "EHLO rosenzweig.io"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S232147AbhHPDSp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 15 Aug 2021 23:18:45 -0400
Date:   Sun, 15 Aug 2021 21:31:40 -0400
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Stan Skowronek <stan@corellium.com>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] PCI: apple: Add driver for the Apple M1
Message-ID: <YRm//JU0otojw+rV@sunset>
References: <20210815042525.36878-1-alyssa@rosenzweig.io>
 <20210815042525.36878-3-alyssa@rosenzweig.io>
 <87a6lj17d1.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a6lj17d1.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Marc,

Thank you for the review.

> This really needs to be split into multiple patches:
> 
> - PCI probing
> - Clock management
> - MSI implementation

Split up in v2.

> > +enum apple_pcie_port {
> > +	APPLE_PCIE_PORT_RADIO    = 0,
> > +	APPLE_PCIE_PORT_USB      = 1,
> > +	APPLE_PCIE_PORT_ETHERNET = 2,
> 
> This really doesn't belong in a low-level PCIe controller driver. The
> ports should be purely generic.

Fixed in v2.

> Please use relaxed accessors. If the barriers are actually needed,
> please document what you are ordering against. This applies throughout
> the patch.

Relaxed accessors are used throughout in v2... it Works For Me™ but no
guarantees I didn't introduce a race...

> This also begs the question: can this be called concurrently?

I'm not sure. Sven, any idea how Apple devices are usually structured here?

> > +static void apple_msi_top_irq_eoi(struct irq_data *d)
> > +{
> > +	irq_chip_eoi_parent(d);
> > +}
> 
> Drop this and use the irq_chip_eoi_parent() directly in the
> irqchip. This was only here for debug.

Done in v2.

> In any case, please use the lower_32bit/upper_32bit helpers, just in
> case we can move the address somewhere else.

Done in v2.

> > +	writel(0xfb512fff, port + PORT_INTMSKSET);
> 
> Magic. What is this for?

Sven's explanation is the most likely. This magic value comes from
Corellium via Mark; I assume it's written by macOS.

> > +	writel(PORT_INT_LINK_UP | PORT_INT_LINK_DOWN | PORT_INT_AF_TIMEOUT |
> > +	       PORT_INT_REQADDR_GT32 | PORT_INT_MSI_ERR |
> > +	       PORT_INT_MSI_BAD_DATA | PORT_INT_CPL_ABORT |
> > +	       PORT_INT_CPL_TIMEOUT | (1 << 26), port + PORT_INTSTAT);
> > +
> > +	usleep_range(5000, 10000);
> > +
> > +	rmwl(0, PORT_LTSSMCTL_START, port + PORT_LTSSMCTL);
> > +
> > +	ret = readl_poll_timeout(port + PORT_LINKSTS, stat,
> > +				 stat & PORT_LINKSTS_UP, 100, 500000);
> > +	if (ret < 0) {
> > +		dev_err(pcie->dev, "port %u link up wait timeout\n", i);
> > +		return ret;
> > +	}
> 
> I have the strong feeling that a lot of things in the above is to get
> an interrupt when the port reports an event. Why the polling then?

I reordered the code to have the configuration after this happen before the START command as suggested (this works), and then removed the poll entirely (this also works?). It's possible the poll here was just a debug leftover in the original code. It's possible it's needed in the original but not needed in the interrupt-driven common code (if the link doesn't come up yet, nothing happens, so we don't have to block on it ourselves..)

It's also possible I've introduced a race that we happen to win every time.

Without specs, it's exceedingly hard to know which it is...

The poll isn't what we want at any rate, so I've removed the poll in v2. But we
may want extra interrupt handling code for v3.

> > +
> > +	writel(DOORBELL_ADDR, port + PORT_MSIADDR);
> > +	writel(0, port + PORT_MSIBASE);
> 
> So here you go, the MSI doorbell *is* configurable. Should it be
> placed somewhere else? Shouldn't it be configured before the link is
> up?

Fixed in v2.

> > +		/* Bringing up the radios requires SMC. Skip for now. */
> > +		if (i == APPLE_PCIE_PORT_RADIO)
> > +			continue;
> 
> Why? Shouldn't this be moved into the driver for the endpoint, rather
> than hardcoding something here which is likely to change from one
> system to another? If establishing the link actually requires talking
> to another part of the system, then it should be described in DT.

Fixed in v2.

Thanks,

Alyssa
