Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D01023A8C5
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 16:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgHCOqh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 10:46:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:40898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbgHCOqh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 Aug 2020 10:46:37 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C64C206D7;
        Mon,  3 Aug 2020 14:46:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596465995;
        bh=EedRPINOKfpkKJFcMma8Y9eMI4MC2bcF2mDpZ3GPHJM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IwaBT7lWkehhcjmXNFPkyfd+oAlG8VzGlsuplyxppCBzmutiVjnidPYNCq0FwwcGA
         0+H7xupjlZJbFD/S2T3/qPDPRMcDRvL8Cu9k4Rzhg1LmOtP98HsWXuqB/1sYv6GNGW
         xnIRLYEwT+XHNZs83VMSK8uzKa+ujtwxt3IwTer8=
Received: by pali.im (Postfix)
        id C0A3A121D; Mon,  3 Aug 2020 16:46:34 +0200 (CEST)
Date:   Mon, 3 Aug 2020 16:46:34 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        linux-pci@vger.kernel.org, Tomasz Maciej Nowak <tmn505@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Xogium <contact@xogium.me>
Subject: Re: [PATCH 4/5] PCI: aardvark: Implement driver 'remove' function
 and allow to build it as module
Message-ID: <20200803144634.nr5cjddyvdnv3lxo@pali>
References: <20200715142557.17115-1-marek.behun@nic.cz>
 <20200715142557.17115-5-marek.behun@nic.cz>
 <20200729184809.GA569408@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200729184809.GA569408@bogus>
User-Agent: NeoMutt/20180716
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday 29 July 2020 12:48:09 Rob Herring wrote:
> On Wed, Jul 15, 2020 at 04:25:56PM +0200, Marek Behún wrote:
> > From: Pali Rohár <pali@kernel.org>
> > 
> > Providing driver's 'remove' function allows kernel to bind and unbind devices
> > from aardvark driver. It also allows to build aardvark driver as a module.
> > 
> > Compiling aardvark as a module simplifies development and debugging of
> > this driver as it can be reloaded at runtime without the need to reboot
> > to new kernel.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Reviewed-by: Marek Behún <marek.behun@nic.cz>
> > ---
> >  drivers/pci/controller/Kconfig        |  2 +-
> >  drivers/pci/controller/pci-aardvark.c | 25 ++++++++++++++++++++++---
> >  2 files changed, 23 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> > index adddf21fa381..f9da5ff2c517 100644
> > --- a/drivers/pci/controller/Kconfig
> > +++ b/drivers/pci/controller/Kconfig
> > @@ -12,7 +12,7 @@ config PCI_MVEBU
> >  	select PCI_BRIDGE_EMUL
> >  
> >  config PCI_AARDVARK
> > -	bool "Aardvark PCIe controller"
> > +	tristate "Aardvark PCIe controller"
> >  	depends on (ARCH_MVEBU && ARM64) || COMPILE_TEST
> >  	depends on OF
> >  	depends on PCI_MSI_IRQ_DOMAIN
> > diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
> > index d5f58684d962..0a5aa6d77f5d 100644
> > --- a/drivers/pci/controller/pci-aardvark.c
> > +++ b/drivers/pci/controller/pci-aardvark.c
> > @@ -14,6 +14,7 @@
> >  #include <linux/irq.h>
> >  #include <linux/irqdomain.h>
> >  #include <linux/kernel.h>
> > +#include <linux/module.h>
> >  #include <linux/pci.h>
> >  #include <linux/init.h>
> >  #include <linux/phy/phy.h>
> > @@ -1114,6 +1115,7 @@ static int advk_pcie_probe(struct platform_device *pdev)
> >  
> >  	pcie = pci_host_bridge_priv(bridge);
> >  	pcie->pdev = pdev;
> > +	platform_set_drvdata(pdev, pcie);
> >  
> >  	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> >  	pcie->base = devm_ioremap_resource(dev, res);
> > @@ -1204,18 +1206,35 @@ static int advk_pcie_probe(struct platform_device *pdev)
> >  	return 0;
> >  }
> >  
> > +static int advk_pcie_remove(struct platform_device *pdev)
> > +{
> > +	struct advk_pcie *pcie = platform_get_drvdata(pdev);
> > +	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(pcie);
> > +
> > +	pci_stop_root_bus(bridge->bus);
> > +	pci_remove_root_bus(bridge->bus);
> 
> Based on pci_host_common_remove() implementation, doesn't this need a 
> lock around it (pci_lock_rescan_remove)?

Well, I'm not sure. I looked into other pci drivers and none of
following drivers pci-tegra.c, pcie-altera.c, pcie-brcmstb.c,
pcie-iproc.c, pcie-mediatek.c, pcie-rockchip-host.c calls
pci_lock_rescan_remove() and pci_unlock_rescan_remove().

Only pci-host-common.c and pci-hyperv.c protect pci_stop_root_bus() and
pci_remove_root_bus() by locks.

> We should probably have a common function (say pci_bridge_remove) to 
> implement this. You could use pci_host_common_remove(), but you'd have 
> to adjust drvdata.

Ok, I agree that some common function could be useful as the same code
(pci_stop_root_bus(); pci_remove_root_bus();) is called in more pci
drivers.

But first we need to know if locks are required or not.

> > +
> > +	advk_pcie_remove_msi_irq_domain(pcie);
> > +	advk_pcie_remove_irq_domain(pcie);
> > +
> > +	return 0;
> > +}
> > +
> >  static const struct of_device_id advk_pcie_of_match_table[] = {
> >  	{ .compatible = "marvell,armada-3700-pcie", },
> >  	{},
> >  };
> > +MODULE_DEVICE_TABLE(of, advk_pcie_of_match_table);
> >  
> >  static struct platform_driver advk_pcie_driver = {
> >  	.driver = {
> >  		.name = "advk-pcie",
> >  		.of_match_table = advk_pcie_of_match_table,
> > -		/* Driver unloading/unbinding currently not supported */
> > -		.suppress_bind_attrs = true,
> >  	},
> >  	.probe = advk_pcie_probe,
> > +	.remove = advk_pcie_remove,
> >  };
> > -builtin_platform_driver(advk_pcie_driver);
> > +module_platform_driver(advk_pcie_driver);
> > +
> > +MODULE_DESCRIPTION("Aardvark PCIe controller");
> > +MODULE_LICENSE("GPL v2");
> > -- 
> > 2.26.2
> > 
