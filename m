Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D773ECD2C
	for <lists+linux-pci@lfdr.de>; Mon, 16 Aug 2021 05:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbhHPDTH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Aug 2021 23:19:07 -0400
Received: from [138.197.143.207] ([138.197.143.207]:45352 "EHLO rosenzweig.io"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S232421AbhHPDTH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 15 Aug 2021 23:19:07 -0400
Date:   Sun, 15 Aug 2021 21:45:37 -0400
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
Message-ID: <YRnDQdKN8bfHdwMS@sunset>
References: <20210815042525.36878-1-alyssa@rosenzweig.io>
 <20210815042525.36878-3-alyssa@rosenzweig.io>
 <87a6lj17d1.wl-maz@kernel.org>
 <877dgn12v4.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dgn12v4.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> > > +static int apple_pcie_setup_refclk(void __iomem *rc,
> > > +				   void __iomem *port,
> > > +				   unsigned int idx)
> > > +{
> > > +	u32 stat;
> > > +	int res;
> > > +
> > > +	res = readl_poll_timeout(rc + CORE_RC_PHYIF_STAT, stat,
> > > +				 stat & CORE_RC_PHYIF_STAT_REFCLK, 100, 50000);
> > > +	if (res < 0)
> > > +		return res;
> > > +
> > > +	rmwl(0, CORE_LANE_CTL_CFGACC, rc + CORE_LANE_CTL(idx));
> > > +	rmwl(0, CORE_LANE_CFG_REFCLK0REQ, rc + CORE_LANE_CFG(idx));
> > > +
> > > +	res = readl_poll_timeout(rc + CORE_LANE_CFG(idx), stat,
> > > +				 stat & CORE_LANE_CFG_REFCLK0ACK, 100, 50000);
> > > +	if (res < 0)
> > > +		return res;
> > > +
> > > +	rmwl(0, CORE_LANE_CFG_REFCLK1, rc + CORE_LANE_CFG(idx));
> > > +	res = readl_poll_timeout(rc + CORE_LANE_CFG(idx), stat,
> > > +				 stat & CORE_LANE_CFG_REFCLK1, 100, 50000);
> > > +
> > > +	if (res < 0)
> > > +		return res;
> > > +
> > > +	rmwl(CORE_LANE_CTL_CFGACC, 0, rc + CORE_LANE_CTL(idx));
> > > +	udelay(1);
> > > +	rmwl(0, CORE_LANE_CFG_REFCLKEN, rc + CORE_LANE_CFG(idx));
> > > +
> > > +	rmwl(0, PORT_REFCLK_EN, port + PORT_REFCLK);
> > > +
> > > +	return 0;
> > > +}
> 
> This really wants to be moved to its own clock driver, unless there is
> a strong guarantee that the clock tree isn't shared with anything
> else. I expect that parts of that clock tree will need to be
> refcounted, and that's where having a real clock driver will help.
> 
> I also have the strong feeling that the clock hierarchy will need to
> be described in DT one way or another, if only to be able to cope with
> future revisions of this block.

Could be, but this is the most magical part of the driver (no docs...)
and that means it's prohibitively difficult to design useful DT
bindings...

For whatever it's worth the Corellium code doesn't expose any DT
bindings here, so maybe this hasn't changed since older Apple SoCs.

Orthogonal to this magic code, we /do/ need DT bindings for the
clock/power gates. At the moment, m1n1 enables the PCIe clock and leaves
it on, so it's not urgent for this series. But in the future when we
want fine grained power management, we'll need it modeled. Sven has a
WIP clock gate driver and proposed bindings, which can be added to the
PCIe DT later nonintrusively. That shouldn't block this series, however.
