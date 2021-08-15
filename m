Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 233153ECA4E
	for <lists+linux-pci@lfdr.de>; Sun, 15 Aug 2021 18:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230501AbhHOQuR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Aug 2021 12:50:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:37468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229493AbhHOQuQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 15 Aug 2021 12:50:16 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B0585611BF;
        Sun, 15 Aug 2021 16:49:46 +0000 (UTC)
Received: from 109-170-232-56.xdsl.murphx.net ([109.170.232.56] helo=wait-a-minute.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1mFJKS-0058Py-Mj; Sun, 15 Aug 2021 17:49:44 +0100
Date:   Sun, 15 Aug 2021 17:49:44 +0100
Message-ID: <871r6u1wlz.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     "Sven Peter" <sven@svenpeter.dev>
Cc:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        linux-pci@vger.kernel.org, "Bjorn Helgaas" <bhelgaas@google.com>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Lorenzo Pieralisi" <lorenzo.pieralisi@arm.com>,
        Krzysztof =?UTF-8?B?V2ls?= =?UTF-8?B?Y3p5xYRza2k=?= 
        <kw@linux.com>, "Stan Skowronek" <stan@corellium.com>,
        "Mark Kettenis" <kettenis@openbsd.org>,
        "Hector Martin" <marcan@marcan.st>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] PCI: apple: Add driver for the Apple M1
In-Reply-To: <8650c850-2642-4582-ae97-a95134bda3e2@www.fastmail.com>
References: <20210815042525.36878-1-alyssa@rosenzweig.io>
        <20210815042525.36878-3-alyssa@rosenzweig.io>
        <87a6lj17d1.wl-maz@kernel.org>
        <8650c850-2642-4582-ae97-a95134bda3e2@www.fastmail.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 109.170.232.56
X-SA-Exim-Rcpt-To: sven@svenpeter.dev, alyssa@rosenzweig.io, linux-pci@vger.kernel.org, bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com, kw@linux.com, stan@corellium.com, kettenis@openbsd.org, marcan@marcan.st, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 15 Aug 2021 13:33:14 +0100,
"Sven Peter" <sven@svenpeter.dev> wrote:
> 
> 
> 
> On Sun, Aug 15, 2021, at 09:42, Marc Zyngier wrote:
> > On Sun, 15 Aug 2021 05:25:25 +0100,
> > Alyssa Rosenzweig <alyssa@rosenzweig.io> wrote:
> [...]
> > > +
> > > +static int apple_pcie_setup_port(struct apple_pcie *pcie, unsigned int i)
> > > +{
> > > +	struct fwnode_handle *fwnode = dev_fwnode(pcie->dev);
> > > +	void __iomem *port;
> > > +	struct gpio_desc *reset;
> > > +	uint32_t stat;
> > > +	int ret;
> > > +
> > > +	port = devm_of_iomap(pcie->dev, to_of_node(fwnode), i + 3, NULL);
> > > +
> > > +	if (IS_ERR(port))
> > > +		return -ENODEV;
> > > +
> > > +	reset = devm_gpiod_get_index(pcie->dev, "reset", i, 0);
> > > +	if (IS_ERR(reset))
> > > +		return PTR_ERR(reset);
> > > +
> > > +	gpiod_direction_output(reset, 0);
> > > +
> > > +	rmwl(0, PORT_APPCLK_EN, port + PORT_APPCLK);
> > > +
> > > +	ret = apple_pcie_setup_refclk(pcie->rc, port, i);
> > > +	if (ret < 0)
> > > +		return ret;
> > > +
> > > +	rmwl(0, PORT_PERST_OFF, port + PORT_PERST);
> > > +	gpiod_set_value(reset, 1);
> > > +
> > > +	ret = readl_poll_timeout(port + PORT_STATUS, stat,
> > > +				 stat & PORT_STATUS_READY, 100, 250000);
> > > +	if (ret < 0) {
> > > +		dev_err(pcie->dev, "port %u ready wait timeout\n", i);
> > > +		return ret;
> > > +	}
> > > +
> > > +	rmwl(PORT_REFCLK_CGDIS, 0, port + PORT_REFCLK);
> > > +	rmwl(PORT_APPCLK_CGDIS, 0, port + PORT_APPCLK);
> > > +
> > > +	ret = readl_poll_timeout(port + PORT_LINKSTS, stat,
> > > +				 !(stat & PORT_LINKSTS_BUSY), 100, 250000);
> > > +	if (ret < 0) {
> > > +		dev_err(pcie->dev, "port %u link not busy timeout\n", i);
> > > +		return ret;
> > > +	}
> > > +
> > > +	writel(0xfb512fff, port + PORT_INTMSKSET);
> > 
> > Magic. What is this for?
> 
> The magic comes from the original Corellium driver. It first masks everything
> except for the interrupts in the next line, then acks the interrupts it keeps
> enabled and then probably wants to wait for PORT_INT_LINK_UP (or any of the
> other interrupts which seem to indicate various error conditions) to fire but
> instead polls for PORT_LINKSTS_UP.
> 
> > 
> > > +
> > > +	writel(PORT_INT_LINK_UP | PORT_INT_LINK_DOWN | PORT_INT_AF_TIMEOUT |
> > > +	       PORT_INT_REQADDR_GT32 | PORT_INT_MSI_ERR |
> > > +	       PORT_INT_MSI_BAD_DATA | PORT_INT_CPL_ABORT |
> > > +	       PORT_INT_CPL_TIMEOUT | (1 << 26), port + PORT_INTSTAT);
> > > +
> > > +	usleep_range(5000, 10000);
> > > +
> > > +	rmwl(0, PORT_LTSSMCTL_START, port + PORT_LTSSMCTL);
> > > +
> > > +	ret = readl_poll_timeout(port + PORT_LINKSTS, stat,
> > > +				 stat & PORT_LINKSTS_UP, 100, 500000);
> > > +	if (ret < 0) {
> > > +		dev_err(pcie->dev, "port %u link up wait timeout\n", i);
> > > +		return ret;
> > > +	}
> > 
> > I have the strong feeling that a lot of things in the above is to get
> > an interrupt when the port reports an event. Why the polling then?
> 
> 
> I'm pretty sure this is true. The same registers are also used to setup
> and handle legacy interrupts.
>
> My current understanding is that PORT_INTSTAT is used to retrieve the fired
> interrupts and ack them, and PORT_INTMSK are the masked interrupts.
> And then PORT_INTMSKSET and PORT_INTMSKCLR can be used to manipulate
> individual bits of PORT_INTMSK with a single store.

So this really should be modelled as an interrupt controller. If
someone comes up with a bit of a spec (though the bit assignment is
relatively clear), I can update the interrupt code to handle
that. After all, I moan enough at people writing horrible PCI driver
code, I might as well write an example myself and point them to it.

Thanks,

	M.

-- 
Without deviation from the norm, progress is not possible.
