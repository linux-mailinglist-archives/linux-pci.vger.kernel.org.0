Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E55D23B58E
	for <lists+linux-pci@lfdr.de>; Tue,  4 Aug 2020 09:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbgHDHYh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Aug 2020 03:24:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:46654 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729814AbgHDHYf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Aug 2020 03:24:35 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D42DA2076E;
        Tue,  4 Aug 2020 07:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596525875;
        bh=iB6R7IBok3ueDFendbTSpkFcS7RL5r4SRINNMe8NET8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nt2MYSAxOYaKrjb6IUSebHGHE5UOKgAiKRZZUnyceUl5BqR6gN6496ejFkZVMAPTS
         y1Yv9JJ8Az5lfzXzgJ5LZTlAOA4CZsrMifcVK66TMM1l9OW+EoqfiJrUZz241eJVJe
         wZ6i0kKGZmWS2mzxhQ7t2pqgozPyPAC8/YuV7xjY=
Received: by pali.im (Postfix)
        id 67FB57FD; Tue,  4 Aug 2020 09:24:32 +0200 (CEST)
Date:   Tue, 4 Aug 2020 09:24:32 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        PCI <linux-pci@vger.kernel.org>,
        Tomasz Maciej Nowak <tmn505@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Xogium <contact@xogium.me>
Subject: Re: [PATCH 4/5] PCI: aardvark: Implement driver 'remove' function
 and allow to build it as module
Message-ID: <20200804072432.c27dmwzjyelgd4h4@pali>
References: <20200715142557.17115-1-marek.behun@nic.cz>
 <20200715142557.17115-5-marek.behun@nic.cz>
 <20200729184809.GA569408@bogus>
 <20200803144634.nr5cjddyvdnv3lxo@pali>
 <CAL_JsqLvqt9VneSm3Up9ib0AH7jWytA9fss_QMfJwd8xrVEp4A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLvqt9VneSm3Up9ib0AH7jWytA9fss_QMfJwd8xrVEp4A@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 03 August 2020 14:00:37 Rob Herring wrote:
> On Mon, Aug 3, 2020 at 8:46 AM Pali Rohár <pali@kernel.org> wrote:
> >
> > On Wednesday 29 July 2020 12:48:09 Rob Herring wrote:
> > > On Wed, Jul 15, 2020 at 04:25:56PM +0200, Marek Behún wrote:
> > > > From: Pali Rohár <pali@kernel.org>
> > > >
> > > > Providing driver's 'remove' function allows kernel to bind and unbind devices
> > > > from aardvark driver. It also allows to build aardvark driver as a module.
> > > >
> > > > Compiling aardvark as a module simplifies development and debugging of
> > > > this driver as it can be reloaded at runtime without the need to reboot
> > > > to new kernel.
> > > >
> > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > Reviewed-by: Marek Behún <marek.behun@nic.cz>
> > > > ---
> > > >  drivers/pci/controller/Kconfig        |  2 +-
> > > >  drivers/pci/controller/pci-aardvark.c | 25 ++++++++++++++++++++++---
> > > >  2 files changed, 23 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> > > > index adddf21fa381..f9da5ff2c517 100644
> > > > --- a/drivers/pci/controller/Kconfig
> > > > +++ b/drivers/pci/controller/Kconfig
> > > > @@ -12,7 +12,7 @@ config PCI_MVEBU
> > > >     select PCI_BRIDGE_EMUL
> > > >
> > > >  config PCI_AARDVARK
> > > > -   bool "Aardvark PCIe controller"
> > > > +   tristate "Aardvark PCIe controller"
> > > >     depends on (ARCH_MVEBU && ARM64) || COMPILE_TEST
> > > >     depends on OF
> > > >     depends on PCI_MSI_IRQ_DOMAIN
> > > > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > > > index d5f58684d962..0a5aa6d77f5d 100644
> > > > --- a/drivers/pci/controller/pci-aardvark.c
> > > > +++ b/drivers/pci/controller/pci-aardvark.c
> > > > @@ -14,6 +14,7 @@
> > > >  #include <linux/irq.h>
> > > >  #include <linux/irqdomain.h>
> > > >  #include <linux/kernel.h>
> > > > +#include <linux/module.h>
> > > >  #include <linux/pci.h>
> > > >  #include <linux/init.h>
> > > >  #include <linux/phy/phy.h>
> > > > @@ -1114,6 +1115,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
> > > >
> > > >     pcie = pci_host_bridge_priv(bridge);
> > > >     pcie->pdev = pdev;
> > > > +   platform_set_drvdata(pdev, pcie);
> > > >
> > > >     res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > > >     pcie->base = devm_ioremap_resource(dev, res);
> > > > @@ -1204,18 +1206,35 @@ static int advk_pcie_probe(struct platform_device *pdev)
> > > >     return 0;
> > > >  }
> > > >
> > > > +static int advk_pcie_remove(struct platform_device *pdev)
> > > > +{
> > > > +   struct advk_pcie *pcie = platform_get_drvdata(pdev);
> > > > +   struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> > > > +
> > > > +   pci_stop_root_bus(bridge->bus);
> > > > +   pci_remove_root_bus(bridge->bus);
> > >
> > > Based on pci_host_common_remove() implementation, doesn't this need a
> > > lock around it (pci_lock_rescan_remove)?
> >
> > Well, I'm not sure. I looked into other pci drivers and none of
> > following drivers pci-tegra.c, pcie-altera.c, pcie-brcmstb.c,
> > pcie-iproc.c, pcie-mediatek.c, pcie-rockchip-host.c calls
> > pci_lock_rescan_remove() and pci_unlock_rescan_remove().
> 
> The mutex protects the bus->devices list, so yes I believe it is needed.
> 
> Rob

Thank you Rob! It means that all above pci drivers should be fixed too.

I will prepare a new version of aardvark patches with protecting pci
stop/remove functions. And later I can look at some common bridge remove
function for fixing those other pci drivers.
