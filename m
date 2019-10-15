Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1AFDD71D2
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 11:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728854AbfJOJIS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 05:08:18 -0400
Received: from pandora.armlinux.org.uk ([78.32.30.218]:37150 "EHLO
        pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfJOJIS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Oct 2019 05:08:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=PE8+nIoxzD1zQdezsHIaVtBqecbIPWzv31qj99+GMFI=; b=rHXUMkGeY1/C+REceyjWg+4Rm
        01qjEdQ6LSV1hNiGadSYIGoQaUN97i2TAxt77SO9nWKaaBDGqACYgzfg6kiZjoOfvDWHvfW5yh1aY
        KyV9+zesdK06b1T11yiw+ZF81rVkFrdjOfPZvHvwd0E4nEU2l9/M9Paq2TFNVojY4Q5osIbiipDKg
        C3reJlQ+75m6pOM9628sIktXXyQ0osAu8zYoVXCqAMPh8wkWAeNjueaE0aZLD6rBfiWQeCIBm9EFW
        OoTv9Gvz2PNSeTmiyuvOIpKzXV3yiPEFR1Hr4a6hsnvTB5AJ5c4w1JjHh6QDxGQYDHfmJwnmvDQMd
        E4DF8O0lA==;
Received: from shell.armlinux.org.uk ([2001:4d48:ad52:3201:5054:ff:fe00:4ec]:43732)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1iKIoB-0003R7-Is; Tue, 15 Oct 2019 10:07:59 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1iKIo8-0005B3-As; Tue, 15 Oct 2019 10:07:56 +0100
Date:   Tue, 15 Oct 2019 10:07:56 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>, "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] PCI: mobiveil: Add PCIe Gen4 EP driver for NXP
 Layerscape SoCs
Message-ID: <20191015090756.GS25745@shell.armlinux.org.uk>
References: <20190916021742.22844-1-xiaowei.bao@nxp.com>
 <20190916021742.22844-4-xiaowei.bao@nxp.com>
 <20190924163850.GY25745@shell.armlinux.org.uk>
 <AM5PR04MB32991D0D69769CE29E0F8DAEF5930@AM5PR04MB3299.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM5PR04MB32991D0D69769CE29E0F8DAEF5930@AM5PR04MB3299.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 15, 2019 at 07:46:12AM +0000, Xiaowei Bao wrote:
> 
> 
> > -----Original Message-----
> > From: Russell King - ARM Linux admin <linux@armlinux.org.uk>
> > Sent: 2019年9月25日 0:39
> > To: Xiaowei Bao <xiaowei.bao@nxp.com>
> > Cc: Z.q. Hou <zhiqiang.hou@nxp.com>; bhelgaas@google.com;
> > robh+dt@kernel.org; mark.rutland@arm.com; shawnguo@kernel.org; Leo Li
> > <leoyang.li@nxp.com>; kishon@ti.com; lorenzo.pieralisi@arm.com; M.h. Lian
> > <minghuan.lian@nxp.com>; andrew.murray@arm.com; Mingkai Hu
> > <mingkai.hu@nxp.com>; linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; devicetree@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Subject: Re: [PATCH 3/6] PCI: mobiveil: Add PCIe Gen4 EP driver for NXP
> > Layerscape SoCs
> > 
> > On Mon, Sep 16, 2019 at 10:17:39AM +0800, Xiaowei Bao wrote:
> > > This PCIe controller is based on the Mobiveil GPEX IP, it work in EP
> > > mode if select this config opteration.
> > >
> > > Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> > > ---
> > >  MAINTAINERS                                        |   2 +
> > >  drivers/pci/controller/mobiveil/Kconfig            |  17 ++-
> > >  drivers/pci/controller/mobiveil/Makefile           |   1 +
> > >  .../controller/mobiveil/pcie-layerscape-gen4-ep.c  | 156
> > > +++++++++++++++++++++
> > >  4 files changed, 173 insertions(+), 3 deletions(-)  create mode
> > > 100644 drivers/pci/controller/mobiveil/pcie-layerscape-gen4-ep.c
> > >
> > > diff --git a/MAINTAINERS b/MAINTAINERS index b997056..0858b54 100644
> > > --- a/MAINTAINERS
> > > +++ b/MAINTAINERS
> > > @@ -12363,11 +12363,13 @@ F:
> > 	drivers/pci/controller/dwc/*layerscape*
> > >
> > >  PCI DRIVER FOR NXP LAYERSCAPE GEN4 CONTROLLER
> > >  M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > > +M:	Xiaowei Bao <xiaowei.bao@nxp.com>
> > >  L:	linux-pci@vger.kernel.org
> > >  L:	linux-arm-kernel@lists.infradead.org
> > >  S:	Maintained
> > >  F:	Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
> > >  F:	drivers/pci/controller/mobibeil/pcie-layerscape-gen4.c
> > > +F:	drivers/pci/controller/mobiveil/pcie-layerscape-gen4-ep.c
> > >
> > >  PCI DRIVER FOR GENERIC OF HOSTS
> > >  M:	Will Deacon <will@kernel.org>
> > > diff --git a/drivers/pci/controller/mobiveil/Kconfig
> > > b/drivers/pci/controller/mobiveil/Kconfig
> > > index 2054950..0696b6e 100644
> > > --- a/drivers/pci/controller/mobiveil/Kconfig
> > > +++ b/drivers/pci/controller/mobiveil/Kconfig
> > > @@ -27,13 +27,24 @@ config PCIE_MOBIVEIL_PLAT
> > >  	  for address translation and it is a PCIe Gen4 IP.
> > >
> > >  config PCIE_LAYERSCAPE_GEN4
> > > -	bool "Freescale Layerscape PCIe Gen4 controller"
> > > +	bool "Freescale Layerscpe PCIe Gen4 controller in RC mode"
> > >  	depends on PCI
> > >  	depends on OF && (ARM64 || ARCH_LAYERSCAPE)
> > >  	depends on PCI_MSI_IRQ_DOMAIN
> > >  	select PCIE_MOBIVEIL_HOST
> > >  	help
> > >  	  Say Y here if you want PCIe Gen4 controller support on
> > > -	  Layerscape SoCs. The PCIe controller can work in RC or
> > > -	  EP mode according to RCW[HOST_AGT_PEX] setting.
> > > +	  Layerscape SoCs. And the PCIe controller work in RC mode
> > > +	  by setting the RCW[HOST_AGT_PEX] to 0.
> > > +
> > > +config PCIE_LAYERSCAPE_GEN4_EP
> > > +	bool "Freescale Layerscpe PCIe Gen4 controller in EP mode"
> > > +	depends on PCI
> > > +	depends on OF && (ARM64 || ARCH_LAYERSCAPE)
> > > +	depends on PCI_ENDPOINT
> > > +	select PCIE_MOBIVEIL_EP
> > > +	help
> > > +	  Say Y here if you want PCIe Gen4 controller support on
> > > +	  Layerscape SoCs. And the PCIe controller work in EP mode
> > > +	  by setting the RCW[HOST_AGT_PEX] to 1.
> > >  endmenu
> > > diff --git a/drivers/pci/controller/mobiveil/Makefile
> > > b/drivers/pci/controller/mobiveil/Makefile
> > > index 686d41f..6f54856 100644
> > > --- a/drivers/pci/controller/mobiveil/Makefile
> > > +++ b/drivers/pci/controller/mobiveil/Makefile
> > > @@ -4,3 +4,4 @@ obj-$(CONFIG_PCIE_MOBIVEIL_HOST) +=
> > > pcie-mobiveil-host.o
> > >  obj-$(CONFIG_PCIE_MOBIVEIL_EP) += pcie-mobiveil-ep.o
> > >  obj-$(CONFIG_PCIE_MOBIVEIL_PLAT) += pcie-mobiveil-plat.o
> > >  obj-$(CONFIG_PCIE_LAYERSCAPE_GEN4) += pcie-layerscape-gen4.o
> > > +obj-$(CONFIG_PCIE_LAYERSCAPE_GEN4_EP) +=
> > pcie-layerscape-gen4-ep.o
> > > diff --git a/drivers/pci/controller/mobiveil/pcie-layerscape-gen4-ep.c
> > > b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4-ep.c
> > > new file mode 100644
> > > index 0000000..7bfec51
> > > --- /dev/null
> > > +++ b/drivers/pci/controller/mobiveil/pcie-layerscape-gen4-ep.c
> > > @@ -0,0 +1,156 @@
> > > +// SPDX-License-Identifier: GPL-2.0
> > > +/*
> > > + * PCIe controller EP driver for Freescale Layerscape SoCs
> > > + *
> > > + * Copyright (C) 2019 NXP Semiconductor.
> > > + *
> > > + * Author: Xiaowei Bao <xiaowei.bao@nxp.com>  */
> > > +
> > > +#include <linux/kernel.h>
> > > +#include <linux/init.h>
> > > +#include <linux/of_pci.h>
> > > +#include <linux/of_platform.h>
> > > +#include <linux/of_address.h>
> > > +#include <linux/pci.h>
> > > +#include <linux/platform_device.h>
> > > +#include <linux/resource.h>
> > > +
> > > +#include "pcie-mobiveil.h"
> > > +
> > > +#define PCIE_LX2_BAR_NUM	4
> > > +
> > > +#define to_ls_pcie_g4_ep(x)	dev_get_drvdata((x)->dev)
> > > +
> > > +struct ls_pcie_g4_ep {
> > > +	struct mobiveil_pcie		*mv_pci;
> > > +};
> > > +
> > > +static const struct of_device_id ls_pcie_g4_ep_of_match[] = {
> > > +	{ .compatible = "fsl,lx2160a-pcie-ep",},
> > > +	{ },
> > > +};
> > > +
> > > +static const struct pci_epc_features ls_pcie_g4_epc_features = {
> > > +	.linkup_notifier = false,
> > > +	.msi_capable = true,
> > > +	.msix_capable = true,
> > > +	.reserved_bar = (1 << BAR_4) | (1 << BAR_5),
> > 
> > 			BIT(BAR_4) | BIT(BAR_5) ?
> 
> I think use .reserved_bar = (1 << BAR_4) | (1 << BAR_5), is better, because BAR_4 
> is not a bit of register.

Why is whether it's a register or not relevent?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
