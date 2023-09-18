Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 529167A479D
	for <lists+linux-pci@lfdr.de>; Mon, 18 Sep 2023 12:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237382AbjIRKxa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Sep 2023 06:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239019AbjIRKxD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Sep 2023 06:53:03 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D4AA1
        for <linux-pci@vger.kernel.org>; Mon, 18 Sep 2023 03:52:54 -0700 (PDT)
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 29E303F67C
        for <linux-pci@vger.kernel.org>; Mon, 18 Sep 2023 10:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1695034373;
        bh=Y04C/vfVzqqW74cXS4nPPyPhcmnyg+o7rhVmr6xInAQ=;
        h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=R/V64dIbIiLCVPoP+0LByesiugnVBC7CWkEnDMi5VnAAzawBxSxwRJ+73Jnd8bqqu
         Xw9cKkwxrjLE+IRj2lZTWzEo0eHKYEtUSr6P1AOLZ2zgiNB6LCO05sxj46XGuQnduP
         lQqTHpyO3x3G3yDgvjJnmhYyJzEE/Q4wGTbTQADwTE1NVaZ50oJRzue7CoQXwFK7WE
         30a7Gco/a86CgpyMZG9C0Sxy4sDj0rXi42Ohxy8BYaf/wb+tyO+LTj/bsVImWFdmOy
         4sM2h3H5vi/HkffDrVqokW82GhIWvvcW5j2LFtdM/MNv5ID50AhsifhutdXGhj4N/g
         58KGlNrGLVvwA==
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-76efd8bf515so412391285a.1
        for <linux-pci@vger.kernel.org>; Mon, 18 Sep 2023 03:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695034370; x=1695639170;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y04C/vfVzqqW74cXS4nPPyPhcmnyg+o7rhVmr6xInAQ=;
        b=N8Z6e/2SKHfa4KEMd+DoNdDt92pJjSVVUV+i3RXS6y18W5EjZ17NhvaKr+QF8KbHsD
         eEdpNFpdfIyaAq3TD5ByaAero7YzQq9E0dp2FchTCYZc+LmwZMEbZonN049NPQi2o/bs
         idQiH6GQoEGMoHLSNg7p1hdmJGtyedU2F4ZGFWpVzva7OjwUnokOMRAnAToJilx1wpoF
         W4ljWpeO6OWf+jP8DqdeNp8aCoPWnc/bodzIfR0i2Gianopm8++pj0nrr15P5w1krRpo
         PcbAnwUl//aEwwAJMMjuJ+Ps5T4KPZPFaKyUOuhYBfO4uW9NMTFqi4FtK9+VLRFhXB7Q
         akTg==
X-Gm-Message-State: AOJu0YwrBkJngoh25RyWVmnuG5RzU4wCuzISxhJwH76/dgSC0BdDIp95
        riGRHbASXCTAlc0E0Ch/cWheZ59yp34LpjMvaKHA4F6xBm0FUbTF11p4Y/4YKvPGUvPJ78775s1
        YpzmdIbPP+CnAFRBNfhUHXhcFsIP4pETq+yIhoy4qwo4mkfU/e/SwZQ==
X-Received: by 2002:ac8:5d0c:0:b0:3f5:16af:17db with SMTP id f12-20020ac85d0c000000b003f516af17dbmr11956717qtx.0.1695034369953;
        Mon, 18 Sep 2023 03:52:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHF2cQNYyb+6JUEC+WKxCjGQhzJV80vy60+yMDZpqmDKIP/cDXIKHYUu7dT4NyqjV9tCTfBncSt420VOXqIrTs=
X-Received: by 2002:ac8:5d0c:0:b0:3f5:16af:17db with SMTP id
 f12-20020ac85d0c000000b003f516af17dbmr11956699qtx.0.1695034369516; Mon, 18
 Sep 2023 03:52:49 -0700 (PDT)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 18 Sep 2023 03:52:49 -0700
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <CAJM55Z_V7Zyni=hj8RLYb_Q0AbJ+8XNo6ABq2-=2_jD0KO1nFQ@mail.gmail.com>
References: <20230915102243.59775-1-minda.chen@starfivetech.com>
 <20230915102243.59775-19-minda.chen@starfivetech.com> <CAJM55Z_V7Zyni=hj8RLYb_Q0AbJ+8XNo6ABq2-=2_jD0KO1nFQ@mail.gmail.com>
Mime-Version: 1.0
Date:   Mon, 18 Sep 2023 03:52:49 -0700
Message-ID: <CAJM55Z8CByGWh+1jY8_kkcGhzupQCu4B5pmYFR+2me1tg1Etyg@mail.gmail.com>
Subject: Re: [PATCH v6 18/19] PCI: starfive: Add JH7110 PCIe controller
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>,
        Minda Chen <minda.chen@starfivetech.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Emil Renner Berthing wrote:
> Minda Chen wrote:
> > Add StarFive JH7110 SoC PCIe controller platform
> > driver codes, and add host init/deinit to pcie-plda-host.c
> >
> > Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> > Co-developed-by: Kevin Xie <kevin.xie@starfivetech.com>
> > Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
> > ---
> >  MAINTAINERS                                  |   7 +
> >  drivers/pci/controller/plda/Kconfig          |  12 +
> >  drivers/pci/controller/plda/Makefile         |   1 +
> >  drivers/pci/controller/plda/pcie-plda-host.c | 121 ++++-
> >  drivers/pci/controller/plda/pcie-plda.h      |  91 +++-
> >  drivers/pci/controller/plda/pcie-starfive.c  | 461 +++++++++++++++++++
> >  6 files changed, 688 insertions(+), 5 deletions(-)
> >  create mode 100644 drivers/pci/controller/plda/pcie-starfive.c
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index ebdb65e195ee..4632cd411a3d 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -16679,6 +16679,13 @@ S:	Maintained
> >  F:	Documentation/devicetree/bindings/pci/socionext,uniphier-pcie*
> >  F:	drivers/pci/controller/dwc/pcie-uniphier*
> >
> > +PCIE DRIVER FOR STARFIVE JH71x0
> > +M:	Kevin Xie <kevin.xie@starfivetech.com>
> > +L:	linux-pci@vger.kernel.org
> > +S:	Maintained
> > +F:	Documentation/devicetree/bindings/pci/starfive*
> > +F:	drivers/pci/controller/plda/pcie-starfive.c
> > +
> >  PCIE DRIVER FOR ST SPEAR13XX
> >  M:	Pratyush Anand <pratyush.anand@gmail.com>
> >  L:	linux-pci@vger.kernel.org
> > diff --git a/drivers/pci/controller/plda/Kconfig b/drivers/pci/controller/plda/Kconfig
> > index e54a82ee94f5..8de661730aa5 100644
> > --- a/drivers/pci/controller/plda/Kconfig
> > +++ b/drivers/pci/controller/plda/Kconfig
> > @@ -15,4 +15,16 @@ config PCIE_MICROCHIP_HOST
> >  	  Say Y here if you want kernel to support the Microchip AXI PCIe
> >  	  Host Bridge driver.
> >
> > +config PCIE_STARFIVE_HOST
> > +	tristate "StarFive PCIe host controller"
> > +	depends on OF && PCI_MSI
> > +	select PCIE_PLDA_HOST
> > +	help
> > +	  Say Y here if you want to support the StarFive PCIe controller
> > +	  in host mode. StarFive PCIe controller uses PLDA PCIe
> > +	  core.
> > +	  If you choose to build this driver as module it will
> > +	  be dynamically linked and module will be called
> > +	  pcie-starfive.ko
> > +
> >  endmenu
> > diff --git a/drivers/pci/controller/plda/Makefile b/drivers/pci/controller/plda/Makefile
> > index 4340ab007f44..0ac6851bed48 100644
> > --- a/drivers/pci/controller/plda/Makefile
> > +++ b/drivers/pci/controller/plda/Makefile
> > @@ -1,3 +1,4 @@
> >  # SPDX-License-Identifier: GPL-2.0
> >  obj-$(CONFIG_PCIE_PLDA_HOST) += pcie-plda-host.o
> >  obj-$(CONFIG_PCIE_MICROCHIP_HOST) += pcie-microchip-host.o
> > +obj-$(CONFIG_PCIE_STARFIVE_HOST) += pcie-starfive.o
> > diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
> > index 26e6cfd2eaba..8b32df477ad8 100644
> > --- a/drivers/pci/controller/plda/pcie-plda-host.c
> > +++ b/drivers/pci/controller/plda/pcie-plda-host.c
> > @@ -20,6 +20,15 @@
> >
> >  #include "pcie-plda.h"
> >
> > +void __iomem *plda_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
> > +				int where)
> > +{
> > +	struct plda_pcie_rp *pcie = bus->sysdata;
> > +
> > +	return pcie->config_base + PCIE_ECAM_OFFSET(bus->number, devfn, where);
> > +}
> > +EXPORT_SYMBOL_GPL(plda_pcie_map_bus);
> > +
> >  static void plda_handle_msi(struct irq_desc *desc)
> >  {
> >  	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
> > @@ -370,6 +379,12 @@ static const struct plda_event_ops plda_event_ops = {
> >  	.get_events = plda_get_events,
> >  };
> >
> > +static const struct plda_event plda_default_event = {
> > +	.event_ops		= &plda_event_ops,
> > +	.intx_event		= EVENT_PM_MSI_INT_INTX,
> > +	.msi_event		= EVENT_PM_MSI_INT_MSI
> > +};
> > +
> >  static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port,
> >  				      const struct irq_domain_ops *ops)
> >  {
> > @@ -416,7 +431,6 @@ int plda_init_interrupts(struct platform_device *pdev,
> >  			 const struct plda_event *event)
> >  {
> >  	struct device *dev = &pdev->dev;
> > -	int irq;
> >  	int i, intx_irq, msi_irq, event_irq;
> >  	int ret;
> >  	const struct irq_domain_ops *irq_dom_ops;
> > @@ -434,8 +448,8 @@ int plda_init_interrupts(struct platform_device *pdev,
> >  		return ret;
> >  	}
> >
> > -	irq = platform_get_irq(pdev, 0);
> > -	if (irq < 0)
> > +	port->irq = platform_get_irq(pdev, 0);
> > +	if (port->irq < 0)
> >  		return -ENODEV;
>
> Here you're dropping the local variable irq and just use port->irq directly..
>
> >
> >  	port->event_ops = event->event_ops;
> > @@ -465,6 +479,7 @@ int plda_init_interrupts(struct platform_device *pdev,
> >  		dev_err(dev, "failed to map INTx interrupt\n");
> >  		return -ENXIO;
> >  	}
> > +	port->intx_irq = intx_irq;
>
> ..but for intx_irq..
>
> >
> >  	/* Plug the INTx chained handler */
> >  	irq_set_chained_handler_and_data(intx_irq, plda_handle_intx, port);
> > @@ -473,12 +488,13 @@ int plda_init_interrupts(struct platform_device *pdev,
> >  				     event->msi_event);
> >  	if (!msi_irq)
> >  		return -ENXIO;
> > +	port->msi_irq = msi_irq;
>
> ..and msi_irq you're keeping the local variable. I think you should drop
> the local variables here too, or at least do the same for all of them.
>
> >
> >  	/* Plug the MSI chained handler */
> >  	irq_set_chained_handler_and_data(msi_irq, plda_handle_msi, port);
> >
> >  	/* Plug the main event chained handler */
> > -	irq_set_chained_handler_and_data(irq, plda_handle_event, port);
> > +	irq_set_chained_handler_and_data(port->irq, plda_handle_event, port);
> >
> >  	return 0;
> >  }
> > @@ -544,3 +560,100 @@ int plda_pcie_setup_iomems(struct pci_host_bridge *bridge,
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_GPL(plda_pcie_setup_iomems);
> > +
> > +static void plda_pcie_irq_domain_deinit(struct plda_pcie_rp *pcie)
> > +{
> > +	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
> > +	irq_set_chained_handler_and_data(pcie->msi_irq, NULL, NULL);
> > +	irq_set_chained_handler_and_data(pcie->intx_irq, NULL, NULL);
> > +
> > +	irq_domain_remove(pcie->msi.msi_domain);
> > +	irq_domain_remove(pcie->msi.dev_domain);
> > +
> > +	irq_domain_remove(pcie->intx_domain);
> > +	irq_domain_remove(pcie->event_domain);
> > +}
> > +
> > +int plda_pcie_host_init(struct plda_pcie_rp *port, struct pci_ops *ops)
> > +{
> > +	struct resource *cfg_res;
> > +	struct device *dev = port->dev;
> > +	int ret;
> > +	struct pci_host_bridge *bridge;
> > +	struct platform_device *pdev = to_platform_device(dev);
>
> This looks weird. Please order initialized variables first and maybe even do
> reverse christmas tree order. Eg. longeist lines first.
>
> > +
> > +	port->bridge_addr =
> > +		devm_platform_ioremap_resource_byname(pdev, "apb");
> > +
> > +	if (IS_ERR(port->bridge_addr))
> > +		return dev_err_probe(dev, PTR_ERR(port->bridge_addr),
> > +				     "failed to map reg memory\n");
> > +
> > +	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> > +	if (!cfg_res)
> > +		return dev_err_probe(dev, -ENODEV,
> > +				     "failed to get config memory\n");
> > +
> > +	port->config_base = devm_ioremap_resource(dev, cfg_res);
> > +	if (IS_ERR(port->config_base))
> > +		return dev_err_probe(dev, PTR_ERR(port->config_base),
> > +				     "failed to map config memory\n");
> > +
> > +	port->phy = devm_phy_optional_get(dev, NULL);
> > +	if (IS_ERR(port->phy))
> > +		return dev_err_probe(dev, PTR_ERR(port->phy),
> > +				     "failed to get pcie phy\n");
> > +
> > +	bridge = devm_pci_alloc_host_bridge(dev, 0);
> > +	if (!bridge)
> > +		return dev_err_probe(dev, -ENOMEM,
> > +				     "failed to alloc bridge\n");
> > +
> > +	if (port->host_ops && port->host_ops->host_init) {
> > +		ret = port->host_ops->host_init(port);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	port->bridge = bridge;
> > +	plda_pcie_setup_window(port->bridge_addr, 0, cfg_res->start, 0,
> > +			       resource_size(cfg_res));
> > +	plda_pcie_setup_iomems(bridge, port);
> > +	plda_set_default_msi(&port->msi);
> > +	ret = plda_init_interrupts(pdev, port, &plda_default_event);
> > +	if (ret)
> > +		goto err_host;
> > +
> > +	/* Set default bus ops */
> > +	bridge->ops = ops;
> > +	bridge->sysdata = port;
> > +
> > +	ret = pci_host_probe(bridge);
> > +	if (ret < 0) {
> > +		dev_err(dev, "failed to pci host probe: %d\n", ret);
>
> I think you mean:
>
> dev_err_probe(dev, ret, "failed to probe pci host\n");
>
> > +		goto err_probe;
> > +	}
> > +
> > +	return ret;
> > +
> > +err_probe:
> > +	plda_pcie_irq_domain_deinit(port);
> > +err_host:
> > +	if (port->host_ops && port->host_ops->host_deinit)
> > +		port->host_ops->host_deinit(port);
> > +
> > +	return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(plda_pcie_host_init);
> > +
> > +void plda_pcie_host_deinit(struct plda_pcie_rp *port)
> > +{
> > +	pci_stop_root_bus(port->bridge->bus);
> > +	pci_remove_root_bus(port->bridge->bus);
> > +
> > +	plda_pcie_irq_domain_deinit(port);
> > +
> > +	if (port->host_ops && port->host_ops->host_deinit)
> > +		port->host_ops->host_deinit(port);
> > +}
> > +EXPORT_SYMBOL_GPL(plda_pcie_host_deinit);
> > diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
> > index b7420598a326..e571047d7944 100644
> > --- a/drivers/pci/controller/plda/pcie-plda.h
> > +++ b/drivers/pci/controller/plda/pcie-plda.h
> > @@ -6,14 +6,24 @@
> >  #ifndef _PCIE_PLDA_H
> >  #define _PCIE_PLDA_H
> >
> > +#include <linux/phy/phy.h>
> > +
> >  /* Number of MSI IRQs */
> >  #define PLDA_MAX_NUM_MSI_IRQS			32
> >
> >  /* PCIe Bridge Phy Regs */
> > +#define GEN_SETTINGS				0x80
> > +#define  RP_ENABLE				1
> > +#define PCIE_PCI_IDS_DW1			0x9c
> > +#define  IDS_CLASS_CODE_SHIFT			16
> >  #define PCIE_PCI_IRQ_DW0			0xa8
> >  #define  MSIX_CAP_MASK				BIT(31)
> >  #define  NUM_MSI_MSGS_MASK			GENMASK(6, 4)
> >  #define  NUM_MSI_MSGS_SHIFT			4
> > +#define PCI_MISC				0xb4
> > +#define  PHY_FUNCTION_DIS			BIT(15)
> > +#define PCIE_WINROM				0xfc
> > +#define  PREF_MEM_WIN_64_SUPPORT		BIT(3)
> >
> >  #define IMASK_LOCAL				0x180
> >  #define  DMA_END_ENGINE_0_MASK			0x00000000u
> > @@ -64,6 +74,8 @@
> >  #define ISTATUS_HOST				0x18c
> >  #define IMSI_ADDR				0x190
> >  #define ISTATUS_MSI				0x194
> > +#define PMSG_SUPPORT_RX				0x3f0
> > +#define  PMSG_LTR_SUPPORT			BIT(2)
> >
> >  /* PCIe Master table init defines */
> >  #define ATR0_PCIE_WIN0_SRCADDR_PARAM		0x600u
> > @@ -85,6 +97,8 @@
> >  #define  PCIE_TX_RX_INTERFACE			0x00000000u
> >  #define  PCIE_CONFIG_INTERFACE			0x00000001u
> >
> > +#define CONFIG_SPACE_ADDR			0x1000u
> > +
> >  #define ATR_ENTRY_SIZE				32
> >
> >  #define EVENT_A_ATR_EVT_POST_ERR		0
> > @@ -134,6 +148,11 @@ struct plda_event_ops {
> >  	u32 (*get_events)(struct plda_pcie_rp *pcie);
> >  };
> >
> > +struct plda_pcie_host_ops {
> > +	int (*host_init)(struct plda_pcie_rp *pcie);
> > +	void (*host_deinit)(struct plda_pcie_rp *pcie);
> > +};
> > +
> >  struct plda_msi {
> >  	struct mutex lock;		/* Protect used bitmap */
> >  	struct irq_domain *msi_domain;
> > @@ -145,12 +164,19 @@ struct plda_msi {
> >
> >  struct plda_pcie_rp {
> >  	struct device *dev;
> > +	struct pci_host_bridge *bridge;
> >  	struct irq_domain *intx_domain;
> >  	struct irq_domain *event_domain;
> >  	raw_spinlock_t lock;
> >  	struct plda_msi msi;
> >  	const struct plda_event_ops *event_ops;
> > +	const struct plda_pcie_host_ops *host_ops;
> > +	struct phy *phy;
> >  	void __iomem *bridge_addr;
> > +	void __iomem *config_base;
> > +	int irq;
> > +	int msi_irq;
> > +	int intx_irq;
> >  	int num_events;
> >  };
> >
> > @@ -163,6 +189,7 @@ struct plda_event {
> >  	int msi_event;
> >  };
> >
> > +void __iomem *plda_pcie_map_bus(struct pci_bus *bus, unsigned int devfn, int where);
> >  int plda_init_interrupts(struct platform_device *pdev,
> >  			 struct plda_pcie_rp *port,
> >  			 const struct plda_event *event);
> > @@ -171,4 +198,66 @@ void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
> >  			    size_t size);
> >  int plda_pcie_setup_iomems(struct pci_host_bridge *bridge,
> >  			   struct plda_pcie_rp *port);
> > -#endif
> > +int plda_pcie_host_init(struct plda_pcie_rp *pcie, struct pci_ops *ops);
> > +void plda_pcie_host_deinit(struct plda_pcie_rp *pcie);
> > +
> > +static inline void plda_set_default_msi(struct plda_msi *msi)
> > +{
> > +	msi->vector_phy = IMSI_ADDR;
> > +	msi->num_vectors = PLDA_MAX_NUM_MSI_IRQS;
> > +}
> > +
> > +static inline void plda_pcie_enable_root_port(struct plda_pcie_rp *plda)
> > +{
> > +	u32 value;
> > +
> > +	value = readl_relaxed(plda->bridge_addr + GEN_SETTINGS);
> > +	value |= RP_ENABLE;
> > +	writel_relaxed(value, plda->bridge_addr + GEN_SETTINGS);
> > +}
> > +
> > +static inline void plda_pcie_set_standard_class(struct plda_pcie_rp *plda)
> > +{
> > +	u32 value;
> > +
> > +	value = readl_relaxed(plda->bridge_addr + PCIE_PCI_IDS_DW1);
> > +	value &= 0xff;
> > +	value |= (PCI_CLASS_BRIDGE_PCI << IDS_CLASS_CODE_SHIFT);
>
> This looks suspicious. You're clearing the lower 8 bits, but setting
> bits 16 and up. Also the parentheses are not strictly necessary.

Sorry, I just noticed I read this wrong. You're clearing *everything but* the
lower 8 bits. This may be the right thing to do, but then please add a comment
explaining why and define a mask with a name showing what those lower 8 bits
mean.

> > +	writel_relaxed(value, plda->bridge_addr + PCIE_PCI_IDS_DW1);
> > +}
> > +
> > +static inline void plda_pcie_set_pref_win_64bit(struct plda_pcie_rp *plda)
> > +{
> > +	u32 value;
> > +
> > +	value = readl_relaxed(plda->bridge_addr + PCIE_WINROM);
> > +	value |= PREF_MEM_WIN_64_SUPPORT;
> > +	writel_relaxed(value, plda->bridge_addr + PCIE_WINROM);
> > +}
> > +
> > +static inline void plda_pcie_disable_ltr(struct plda_pcie_rp *plda)
> > +{
> > +	u32 value;
> > +
> > +	value = readl_relaxed(plda->bridge_addr + PMSG_SUPPORT_RX);
> > +	value &= ~PMSG_LTR_SUPPORT;
> > +	writel_relaxed(value, plda->bridge_addr + PMSG_SUPPORT_RX);
> > +}
> > +
> > +static inline void plda_pcie_disable_func(struct plda_pcie_rp *plda)
> > +{
> > +	u32 value;
> > +
> > +	value = readl_relaxed(plda->bridge_addr + PCI_MISC);
> > +	value |= PHY_FUNCTION_DIS;
> > +	writel_relaxed(value, plda->bridge_addr + PCI_MISC);
> > +}
> > +
> > +static inline void plda_pcie_write_rc_bar(struct plda_pcie_rp *plda, u64 val)
> > +{
> > +	void __iomem *addr = plda->bridge_addr + CONFIG_SPACE_ADDR;
> > +
> > +	writel_relaxed(val & 0xffffffff, addr + PCI_BASE_ADDRESS_0);
> > +	writel_relaxed(val >> 32, addr + PCI_BASE_ADDRESS_1);
>
> Consider using lower_32_bits(val) and upper_32_bits(val) here.
>
> > +}
> > +#endif /* _PCIE_PLDA_H */
> > diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
> > new file mode 100644
> > index 000000000000..42099fef0d7d
> > --- /dev/null
> > +++ b/drivers/pci/controller/plda/pcie-starfive.c
> > @@ -0,0 +1,461 @@
> > +// SPDX-License-Identifier: GPL-2.0+
> > +/*
> > + * PCIe host controller driver for StarFive JH7110 Soc.
> > + *
> > + * Copyright (C) 2023 StarFive Technology Co., Ltd.
> > + */
> > +
> > +#include <linux/bitfield.h>
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/gpio/consumer.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/kernel.h>
> > +#include <linux/mfd/syscon.h>
> > +#include <linux/module.h>
> > +#include <linux/of_address.h>
> > +#include <linux/of_irq.h>
> > +#include <linux/of_pci.h>
> > +#include <linux/pci.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/pm_runtime.h>
> > +#include <linux/regmap.h>
> > +#include <linux/reset.h>
> > +#include "../../pci.h"
> > +
> > +#include "pcie-plda.h"
> > +
> > +#define PCIE_FUNC_NUM			4
> > +
> > +/* system control */
> > +#define STG_SYSCON_PCIE0_BASE			0x48
> > +#define STG_SYSCON_PCIE1_BASE			0x1f8
> > +
> > +#define STG_SYSCON_ARFUNC_OFFSET		0x78
> > +#define STG_SYSCON_AXI4_SLVL_ARFUNC_MASK	 GENMASK(22, 8)
> > +#define STG_SYSCON_AXI4_SLVL_PHY_ARFUNC(x)	 FIELD_PREP(GENMASK(20, 17), x)
> > +#define STG_SYSCON_AWFUNC_OFFSET		0x7c
> > +#define STG_SYSCON_AXI4_SLVL_AWFUNC_MASK	 GENMASK(14, 0)
> > +#define STG_SYSCON_AXI4_SLVL_PHY_AWFUNC(x)	 FIELD_PREP(GENMASK(12, 9), x)
> > +#define STG_SYSCON_CLKREQ			 BIT(22)
> > +#define STG_SYSCON_CKREF_SRC_MASK		 GENMASK(19, 18)
> > +#define STG_SYSCON_RP_NEP_OFFSET		0xe8
> > +#define STG_SYSCON_K_RP_NEP			 BIT(8)
> > +#define STG_SYSCON_LNKSTA_OFFSET		0x170
> > +#define DATA_LINK_ACTIVE			 BIT(5)
> > +
> > +/* Parameters for the waiting for link up routine */
> > +#define LINK_WAIT_MAX_RETRIES	10
> > +#define LINK_WAIT_USLEEP_MIN	90000
> > +#define LINK_WAIT_USLEEP_MAX	100000
> > +
> > +struct starfive_jh7110_pcie {
> > +	struct plda_pcie_rp plda;
> > +	struct reset_control *resets;
> > +	struct clk_bulk_data *clks;
> > +	struct regmap *reg_syscon;
> > +	struct gpio_desc *power_gpio;
> > +	struct gpio_desc *reset_gpio;
> > +
> > +	u32 stg_arfun;
> > +	u32 stg_awfun;
> > +	u32 stg_rp_nep;
> > +	u32 stg_lnksta;
> > +
> > +	int num_clks;
> > +};
> > +
> > +/*
> > + * The BAR0/1 of bridge should be hidden during enumeration to
> > + * avoid the sizing and resource allocation by PCIe core.
> > + */
> > +static bool starfive_pcie_hide_rc_bar(struct pci_bus *bus, unsigned int  devfn,
> > +				      int offset)
> > +{
> > +	if (pci_is_root_bus(bus) && !devfn &&
> > +	    (offset == PCI_BASE_ADDRESS_0 || offset == PCI_BASE_ADDRESS_1))
> > +		return true;
> > +
> > +	return false;
> > +}
> > +
> > +static int starfive_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
> > +				      int where, int size, u32 value)
> > +{
> > +	if (starfive_pcie_hide_rc_bar(bus, devfn, where))
> > +		return PCIBIOS_BAD_REGISTER_NUMBER;
> > +
> > +	return pci_generic_config_write(bus, devfn, where, size, value);
> > +}
> > +
> > +static int starfive_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
> > +				     int where, int size, u32 *value)
> > +{
> > +	if (starfive_pcie_hide_rc_bar(bus, devfn, where))
> > +		return PCIBIOS_BAD_REGISTER_NUMBER;
> > +
> > +	return pci_generic_config_read(bus, devfn, where, size, value);
> > +}
> > +
> > +static int starfive_pcie_parse_dt(struct starfive_jh7110_pcie *pcie, struct device *dev)
> > +{
> > +	int domain_nr, stg_pcie_base;
> > +
> > +	pcie->num_clks = devm_clk_bulk_get_all(dev, &pcie->clks);
> > +	if (pcie->num_clks < 0)
> > +		return dev_err_probe(dev, -ENODEV,
> > +			"failed to get pcie clocks\n");
> > +
> > +	pcie->resets = devm_reset_control_array_get_exclusive(dev);
> > +	if (IS_ERR(pcie->resets))
> > +		return dev_err_probe(dev, PTR_ERR(pcie->resets),
> > +			"failed to get pcie resets");
> > +
> > +	pcie->reg_syscon =
> > +		syscon_regmap_lookup_by_phandle(dev->of_node,
> > +						"starfive,stg-syscon");
> > +
> > +	if (IS_ERR(pcie->reg_syscon))
> > +		return dev_err_probe(dev, PTR_ERR(pcie->reg_syscon),
> > +			"failed to parse starfive,stg-syscon\n");
> > +
> > +	domain_nr = of_get_pci_domain_nr(dev->of_node);
> > +
> > +	if (domain_nr < 0 || domain_nr > 1)
> > +		return dev_err_probe(dev, -ENODEV,
> > +			"failed to get valid pcie id\n");
> > +
> > +	if (domain_nr == 0)
> > +		stg_pcie_base = STG_SYSCON_PCIE0_BASE;
> > +	else
> > +		stg_pcie_base = STG_SYSCON_PCIE1_BASE;
>
> It seems you only need the domain_nr for the determining this offset into the
> stg_syscon. Since this is already specific to the JH7110 SoC, wouldn't it be
> safer to match on the 0x2b000000/0x2c000000 or 0x940000000/0x9c0000000
> address of the peripheral instead?
>
> > +
> > +	pcie->stg_arfun = stg_pcie_base + STG_SYSCON_ARFUNC_OFFSET;
> > +	pcie->stg_awfun = stg_pcie_base + STG_SYSCON_AWFUNC_OFFSET;
> > +	pcie->stg_rp_nep = stg_pcie_base + STG_SYSCON_RP_NEP_OFFSET;
> > +	pcie->stg_lnksta = stg_pcie_base + STG_SYSCON_LNKSTA_OFFSET;
>
> These offsets are all the same for both pcie0 and pcie1 so why do you need a
> variable for each? Eg. why not just
>
> if (domain_nr == 0)
> 	pcie->stg_base = STG_SYSCON_PCIE0_BASE;
> else
> 	pcie->stg_base = STG_SYSCON_PCIE1_BASE;
>
> ..and then add add those static offsets where needed?
>
> > +
> > +	pcie->reset_gpio = devm_gpiod_get_optional(dev, "perst", GPIOD_OUT_HIGH);
> > +	if (IS_ERR(pcie->reset_gpio)) {
> > +		dev_warn(dev, "failed to get perst-gpio\n");
>
> Why is this a warn when you actually error out? I think you mean
>
> return dev_err_probe(dev, PTR_ERR(pcie->reset_gpio, "failed to get
> reset GPIO\n");
>
> > +		return -EINVAL;
> > +	}
> > +
> > +	pcie->power_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
> > +	if (IS_ERR(pcie->power_gpio)) {
> > +		dev_warn(dev, "failed to get power-gpio\n");
> > +		return -EINVAL;
>
> return dev_err_probe(dev, PTR_ERR(pcie->power_gpio), "failed to get
> power GPIO\n");
>
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static struct pci_ops starfive_pcie_ops = {
> > +	.map_bus	= plda_pcie_map_bus,
> > +	.read           = starfive_pcie_config_read,
> > +	.write          = starfive_pcie_config_write,
> > +};
> > +
> > +static int starfive_pcie_clk_rst_init(struct starfive_jh7110_pcie *pcie)
> > +{
> > +	int ret;
> > +	struct device *dev = pcie->plda.dev;
>
> Again, please order initialized variables first.
>
> > +
> > +	ret = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
> > +	if (ret) {
> > +		dev_err(dev, "failed to enable clocks\n");
> > +		return ret;
>
> return dev_err_probe(dev, ret, "failed to enable clocks\n");
>
> > +	}
> > +
> > +	ret = reset_control_deassert(pcie->resets);
> > +	if (ret) {
> > +		clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
> > +		dev_err(dev, "failed to resets\n");
>
> I think you mean
> return dev_err_probe(dev, ret, "failed to deassert resets\n");
>
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static void starfive_pcie_clk_rst_deinit(struct starfive_jh7110_pcie *pcie)
> > +{
> > +	reset_control_assert(pcie->resets);
> > +	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
> > +}
> > +
> > +static bool starfive_pcie_link_up(struct plda_pcie_rp *plda)
> > +{
> > +	struct starfive_jh7110_pcie *pcie =
> > +		container_of(plda, struct starfive_jh7110_pcie, plda);
> > +	struct device *dev = pcie->plda.dev;
>
> This is only used once below, so just use pcie->plda.dev directly there.
>
> > +	int ret;
> > +	u32 stg_reg_val;
> > +
> > +	ret = regmap_read(pcie->reg_syscon, pcie->stg_lnksta, &stg_reg_val);
> > +	if (ret) {
> > +		dev_err(dev, "failed to read link status\n");
> > +		return false;
> > +	}
> > +
> > +	if (stg_reg_val & DATA_LINK_ACTIVE)
> > +		return true;
> > +
> > +	return false;
>
> These last 4 lines is just "return stg_reg_val & DATA_LINK_ACTIVE;" right?
>
> > +}
> > +
> > +static int starfive_pcie_host_wait_for_link(struct starfive_jh7110_pcie *pcie)
> > +{
> > +	struct device *dev = pcie->plda.dev;
>
> Only used once, just inline.
>
> > +	int retries;
> > +
> > +	/* Check if the link is up or not */
> > +	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
> > +		if (starfive_pcie_link_up(&pcie->plda)) {
> > +			dev_info(dev, "port link up\n");
> > +			return 0;
> > +		}
> > +		usleep_range(LINK_WAIT_USLEEP_MIN, LINK_WAIT_USLEEP_MAX);
> > +	}
> > +
> > +	return -ETIMEDOUT;
> > +}
> > +
> > +static int starfive_pcie_enable_phy(struct device *dev, struct plda_pcie_rp *pcie)
> > +{
> > +	int ret;
> > +
> > +	if (!pcie->phy)
> > +		return 0;
> > +
> > +	ret = phy_init(pcie->phy);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret,
> > +			"failed to initialize pcie phy\n");
> > +
> > +	ret = phy_set_mode(pcie->phy, PHY_MODE_PCIE);
> > +	if (ret) {
> > +		dev_err(dev, "failed to set pcie mode\n");
> > +		goto err_phy_on;
> > +	}
> > +
> > +	ret = phy_power_on(pcie->phy);
> > +	if (ret) {
> > +		dev_err(dev, "failed to power on pcie phy\n");
> > +		goto err_phy_on;
> > +	}
> > +
> > +	return 0;
> > +
> > +err_phy_on:
> > +	phy_exit(pcie->phy);
> > +	return ret;
> > +}
> > +
> > +static void starfive_pcie_disable_phy(struct plda_pcie_rp *pcie)
> > +{
> > +	phy_power_off(pcie->phy);
> > +	phy_exit(pcie->phy);
> > +}
> > +
> > +static void starfive_pcie_host_deinit(struct plda_pcie_rp *plda)
> > +{
> > +	struct starfive_jh7110_pcie *pcie =
> > +		container_of(plda, struct starfive_jh7110_pcie, plda);
> > +
> > +	starfive_pcie_clk_rst_deinit(pcie);
> > +	if (pcie->power_gpio)
> > +		gpiod_set_value_cansleep(pcie->power_gpio, 0);
> > +	starfive_pcie_disable_phy(plda);
> > +}
> > +
> > +static int starfive_pcie_host_init(struct plda_pcie_rp *plda)
> > +{
> > +	int i;
> > +	struct starfive_jh7110_pcie *pcie =
> > +		container_of(plda, struct starfive_jh7110_pcie, plda);
> > +	struct device *dev = plda->dev;
> > +	int ret;
>
> Weird ordering again.
>
> > +
> > +	ret = starfive_pcie_enable_phy(dev, plda);
> > +	if (ret)
> > +		return ret;
> > +
> > +	regmap_update_bits(pcie->reg_syscon, pcie->stg_rp_nep,
> > +			   STG_SYSCON_K_RP_NEP, STG_SYSCON_K_RP_NEP);
> > +
> > +	regmap_update_bits(pcie->reg_syscon, pcie->stg_awfun,
> > +			   STG_SYSCON_CKREF_SRC_MASK,
> > +			   FIELD_PREP(STG_SYSCON_CKREF_SRC_MASK, 2));
> > +
> > +	regmap_update_bits(pcie->reg_syscon, pcie->stg_awfun,
> > +			   STG_SYSCON_CLKREQ, STG_SYSCON_CLKREQ);
> > +
> > +	ret = starfive_pcie_clk_rst_init(pcie);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (pcie->power_gpio)
> > +		gpiod_set_value_cansleep(pcie->power_gpio, 1);
> > +
> > +	if (pcie->reset_gpio)
> > +		gpiod_set_value_cansleep(pcie->reset_gpio, 1);
> > +
> > +	/* Disable physical functions except #0 */
> > +	for (i = 1; i < PCIE_FUNC_NUM; i++) {
> > +		regmap_update_bits(pcie->reg_syscon,
> > +				   pcie->stg_arfun,
> > +				   STG_SYSCON_AXI4_SLVL_ARFUNC_MASK,
> > +				   STG_SYSCON_AXI4_SLVL_PHY_ARFUNC(i));
> > +
> > +		regmap_update_bits(pcie->reg_syscon,
> > +				   pcie->stg_awfun,
> > +				   STG_SYSCON_AXI4_SLVL_AWFUNC_MASK,
> > +				   STG_SYSCON_AXI4_SLVL_PHY_AWFUNC(i));
> > +
> > +		plda_pcie_disable_func(plda);
> > +	}
> > +
> > +	regmap_update_bits(pcie->reg_syscon, pcie->stg_arfun,
> > +			   STG_SYSCON_AXI4_SLVL_ARFUNC_MASK, 0);
> > +	regmap_update_bits(pcie->reg_syscon, pcie->stg_awfun,
> > +			   STG_SYSCON_AXI4_SLVL_AWFUNC_MASK, 0);
> > +
> > +	plda_pcie_enable_root_port(plda);
> > +	plda_pcie_write_rc_bar(plda, 0);
> > +
> > +	/* PCIe PCI Standard Configuration Identification Settings. */
> > +	plda_pcie_set_standard_class(plda);
> > +
> > +	/*
> > +	 * The LTR message forwarding of PCIe Message Reception was set by core
> > +	 * as default, but the forward id & addr are also need to be reset.
> > +	 * If we do not disable LTR message forwarding here, or set a legal
> > +	 * forwarding address, the kernel will get stuck after this driver probe.
> > +	 * To workaround, disable the LTR message forwarding support on
> > +	 * PCIe Message Reception.
> > +	 */
> > +	plda_pcie_disable_ltr(plda);
> > +
> > +	/* Prefetchable memory window 64-bit addressing support */
> > +	plda_pcie_set_pref_win_64bit(plda);
> > +
> > +	/* Ensure that PERST has been asserted for at least 100 ms,
> > +	 * the sleep value is T_PVPERL from PCIe CEM spec r2.0 (Table 2-4)
> > +	 */
> > +	msleep(100);
> > +	if (pcie->reset_gpio)
> > +		gpiod_set_value_cansleep(pcie->reset_gpio, 0);
> > +
> > +	/* As the requirement in PCIe base spec r6.0, system (<=5GT/s) must
> > +	 * wait a minimum of 100 ms following exit from a conventional reset
> > +	 * before sending a configuration request to the device.
> > +	 */
> > +	msleep(100);
> > +
> > +	if (starfive_pcie_host_wait_for_link(pcie))
> > +		dev_info(dev, "port link down\n");
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct plda_pcie_host_ops sf_host_ops = {
> > +	.host_init = starfive_pcie_host_init,
> > +	.host_deinit = starfive_pcie_host_deinit,
> > +};
> > +
> > +static int starfive_pcie_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct starfive_jh7110_pcie *pcie;
> > +	struct plda_pcie_rp *plda;
> > +	int ret;
> > +
> > +	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
> > +	if (!pcie)
> > +		return -ENOMEM;
> > +
> > +	plda = &pcie->plda;
> > +	plda->dev = dev;
> > +
> > +	ret = starfive_pcie_parse_dt(pcie, dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	plda->host_ops = &sf_host_ops;
> > +	plda->num_events = NUM_PLDA_EVENTS;
> > +	ret = plda_pcie_host_init(&pcie->plda, &starfive_pcie_ops);
> > +	if (ret)
> > +		return ret;
> > +
> > +	pm_runtime_enable(&pdev->dev);
> > +	pm_runtime_get_sync(&pdev->dev);
> > +	platform_set_drvdata(pdev, pcie);
> > +
> > +	return 0;
> > +}
> > +
> > +static void starfive_pcie_remove(struct platform_device *pdev)
> > +{
> > +	struct starfive_jh7110_pcie *pcie = platform_get_drvdata(pdev);
> > +
> > +	plda_pcie_host_deinit(&pcie->plda);
> > +	platform_set_drvdata(pdev, NULL);
> > +}
> > +
> > +static int starfive_pcie_suspend_noirq(struct device *dev)
> > +{
> > +	struct starfive_jh7110_pcie *pcie = dev_get_drvdata(dev);
> > +
> > +	if (!pcie)
> > +		return 0;
> > +
> > +	clk_bulk_disable_unprepare(pcie->num_clks, pcie->clks);
> > +	starfive_pcie_disable_phy(&pcie->plda);
> > +
> > +	return 0;
> > +}
> > +
> > +static int starfive_pcie_resume_noirq(struct device *dev)
> > +{
> > +	struct starfive_jh7110_pcie *pcie = dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	ret = starfive_pcie_enable_phy(dev, &pcie->plda);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
> > +	if (ret) {
> > +		dev_err(dev, "failed to enable clocks\n");
> > +		starfive_pcie_disable_phy(&pcie->plda);
> > +		return ret;
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static const struct dev_pm_ops starfive_pcie_pm_ops = {
> > +	NOIRQ_SYSTEM_SLEEP_PM_OPS(starfive_pcie_suspend_noirq,
> > +				  starfive_pcie_resume_noirq)
> > +};
> > +
> > +static const struct of_device_id starfive_pcie_of_match[] = {
> > +	{ .compatible = "starfive,jh7110-pcie"},
>
> Missing space before }
>
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, starfive_pcie_of_match);
> > +
> > +static struct platform_driver starfive_pcie_driver = {
> > +	.driver = {
> > +		.name = "pcie-starfive",
> > +		.of_match_table = of_match_ptr(starfive_pcie_of_match),
> > +#ifdef CONFIG_PM_SLEEP
> > +		.pm = &starfive_pcie_pm_ops,
> > +#endif
>
> This can be just .pm = pm_sleep_ptr(&starfive_pcie_pm_ops),
>
> > +	},
> > +	.probe = starfive_pcie_probe,
> > +	.remove_new = starfive_pcie_remove,
> > +};
> > +module_platform_driver(starfive_pcie_driver);
> > +
> > +MODULE_DESCRIPTION("StarFive JH7110 PCIe host driver");
> > +MODULE_LICENSE("GPL v2");
> > --
> > 2.17.1
