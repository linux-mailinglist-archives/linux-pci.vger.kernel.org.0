Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEB63ECD1F
	for <lists+linux-pci@lfdr.de>; Mon, 16 Aug 2021 05:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbhHPDSf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Aug 2021 23:18:35 -0400
Received: from [138.197.143.207] ([138.197.143.207]:45272 "EHLO rosenzweig.io"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S233081AbhHPDSc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 15 Aug 2021 23:18:32 -0400
Date:   Sun, 15 Aug 2021 17:33:48 -0400
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Stan Skowronek <stan@corellium.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Kettenis <kettenis@openbsd.org>,
        Sven Peter <sven@svenpeter.dev>,
        Hector Martin <marcan@marcan.st>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 2/2] PCI: apple: Add driver for the Apple M1
Message-ID: <YRmIPL3NA4zHkReL@sunset>
References: <20210815042525.36878-1-alyssa@rosenzweig.io>
 <20210815042525.36878-3-alyssa@rosenzweig.io>
 <CAL_JsqJfhQr7fa4dD2cOQmo8bdj2fQ+2Hjrh_4Xie-zbr1g7KQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJfhQr7fa4dD2cOQmo8bdj2fQ+2Hjrh_4Xie-zbr1g7KQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

Thanks for the review.

> > +#define CORE_RC_PHYIF_CTL              0x00024
> > +#define   CORE_RC_PHYIF_CTL_RUN                BIT(0)
> > +#define CORE_RC_PHYIF_STAT             0x00028
> > +#define   CORE_RC_PHYIF_STAT_REFCLK    BIT(4)
> > +#define CORE_RC_CTL                    0x00050
> > +#define   CORE_RC_CTL_RUN              BIT(0)
> > +#define CORE_RC_STAT                   0x00058
> > +#define   CORE_RC_STAT_READY           BIT(0)
> > +#define CORE_FABRIC_STAT               0x04000
> > +#define   CORE_FABRIC_STAT_MASK                0x001F001F
> > +#define CORE_PHY_CTL                   0x80000
> > +#define   CORE_PHY_CTL_CLK0REQ         BIT(0)
> > +#define   CORE_PHY_CTL_CLK1REQ         BIT(1)
> > +#define   CORE_PHY_CTL_CLK0ACK         BIT(2)
> > +#define   CORE_PHY_CTL_CLK1ACK         BIT(3)
> > +#define   CORE_PHY_CTL_RESET           BIT(7)
> 
> I was going to say these should be a phy driver perhaps, but they are
> unused. So for now, just drop them.

Removed in v2.

CORE_PHY_CTRL is used in the asahi linux bootloader (m1n1, shared between
linux+uboot+bsd) to do early pcie bringup. They are indeed not used
here, nor are they used in the uboot/bsd drivers.

> > +static int apple_pcie_setup_port(struct apple_pcie *pcie, unsigned int i)
> > +{
> > +       struct fwnode_handle *fwnode = dev_fwnode(pcie->dev);
> 
> Doesn't look like you ever use the fwnode, just get the DT node
> pointer. Unless this driver is going to use ACPI someday (and ACPI
> changes how PCI is done), there's no point in using fwnode.

Dropped in v2.

That was a copypaste fail splitting off apple_pcie_setup_port from
apple_msi_init in an early revision.

> It's preferred to use platform resource api and ioremap over DT functions.
> ...
> Use devm_platform_ioremap_resource instead.

Done in v2.

Thanks,

Alyssa
