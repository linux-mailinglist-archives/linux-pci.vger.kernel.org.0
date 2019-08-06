Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39A7F8370B
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2019 18:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387572AbfHFQdg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Aug 2019 12:33:36 -0400
Received: from foss.arm.com ([217.140.110.172]:36620 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732809AbfHFQdg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Aug 2019 12:33:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02A1E344;
        Tue,  6 Aug 2019 09:33:35 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 71DA23F575;
        Tue,  6 Aug 2019 09:33:34 -0700 (PDT)
Date:   Tue, 6 Aug 2019 17:33:32 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Jianjun Wang <jianjun.wang@mediatek.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        youlin.pei@mediatek.com, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [v2,2/2] PCI: mediatek: Add controller support for MT7629
Message-ID: <20190806163332.GQ56241@e119886-lin.cambridge.arm.com>
References: <20190628073425.25165-1-jianjun.wang@mediatek.com>
 <20190628073425.25165-3-jianjun.wang@mediatek.com>
 <1564385918.17211.6.camel@mhfsdcap03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1564385918.17211.6.camel@mhfsdcap03>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 29, 2019 at 03:38:38PM +0800, Jianjun Wang wrote:
> On Fri, 2019-06-28 at 15:34 +0800, Jianjun Wang wrote:
> > MT7629 is an ARM platform SoC which has the same PCIe IP with MT7622.
> > 
> > The HW default value of its Device ID is invalid, fix its Device ID to
> > match the hardware implementation.
> > 
> > Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> > Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> > ---
> >  drivers/pci/controller/pcie-mediatek.c | 18 ++++++++++++++++++
> >  include/linux/pci_ids.h                |  1 +
> >  2 files changed, 19 insertions(+)
> > 
> > diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> > index 80601e1b939e..e5e6740b635d 100644
> > --- a/drivers/pci/controller/pcie-mediatek.c
> > +++ b/drivers/pci/controller/pcie-mediatek.c
> > @@ -73,6 +73,7 @@
> >  #define PCIE_MSI_VECTOR		0x0c0
> >  
> >  #define PCIE_CONF_VEND_ID	0x100
> > +#define PCIE_CONF_DEVICE_ID	0x102
> >  #define PCIE_CONF_CLASS_ID	0x106
> >  
> >  #define PCIE_INT_MASK		0x420
> > @@ -141,12 +142,16 @@ struct mtk_pcie_port;
> >  /**
> >   * struct mtk_pcie_soc - differentiate between host generations
> >   * @need_fix_class_id: whether this host's class ID needed to be fixed or not
> > + * @need_fix_device_id: whether this host's Device ID needed to be fixed or not
> > + * @device_id: Device ID which this host need to be fixed

Really trivial nit: s/Device ID/device ID/ to be consistent with class ID above it.

Either way:

Reviewed-by: Andrew Murray <andrew.murray@arm.com>


> >   * @ops: pointer to configuration access functions
> >   * @startup: pointer to controller setting functions
> >   * @setup_irq: pointer to initialize IRQ functions
> >   */
> >  struct mtk_pcie_soc {
> >  	bool need_fix_class_id;
> > +	bool need_fix_device_id;
> > +	unsigned int device_id;
> >  	struct pci_ops *ops;
> >  	int (*startup)(struct mtk_pcie_port *port);
> >  	int (*setup_irq)(struct mtk_pcie_port *port, struct device_node *node);
> > @@ -696,6 +701,9 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
> >  		writew(val, port->base + PCIE_CONF_CLASS_ID);
> >  	}
> >  
> > +	if (soc->need_fix_device_id)
> > +		writew(soc->device_id, port->base + PCIE_CONF_DEVICE_ID);
> > +
> >  	/* 100ms timeout value should be enough for Gen1/2 training */
> >  	err = readl_poll_timeout(port->base + PCIE_LINK_STATUS_V2, val,
> >  				 !!(val & PCIE_PORT_LINKUP_V2), 20,
> > @@ -1216,11 +1224,21 @@ static const struct mtk_pcie_soc mtk_pcie_soc_mt7622 = {
> >  	.setup_irq = mtk_pcie_setup_irq,
> >  };
> >  
> > +static const struct mtk_pcie_soc mtk_pcie_soc_mt7629 = {
> > +	.need_fix_class_id = true,
> > +	.need_fix_device_id = true,
> > +	.device_id = PCI_DEVICE_ID_MEDIATEK_7629,
> > +	.ops = &mtk_pcie_ops_v2,
> > +	.startup = mtk_pcie_startup_port_v2,
> > +	.setup_irq = mtk_pcie_setup_irq,
> > +};
> > +
> >  static const struct of_device_id mtk_pcie_ids[] = {
> >  	{ .compatible = "mediatek,mt2701-pcie", .data = &mtk_pcie_soc_v1 },
> >  	{ .compatible = "mediatek,mt7623-pcie", .data = &mtk_pcie_soc_v1 },
> >  	{ .compatible = "mediatek,mt2712-pcie", .data = &mtk_pcie_soc_mt2712 },
> >  	{ .compatible = "mediatek,mt7622-pcie", .data = &mtk_pcie_soc_mt7622 },
> > +	{ .compatible = "mediatek,mt7629-pcie", .data = &mtk_pcie_soc_mt7629 },
> >  	{},
> >  };
> >  
> > diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> > index 70e86148cb1e..aa32962759b2 100644
> > --- a/include/linux/pci_ids.h
> > +++ b/include/linux/pci_ids.h
> > @@ -2131,6 +2131,7 @@
> >  #define PCI_VENDOR_ID_MYRICOM		0x14c1
> >  
> >  #define PCI_VENDOR_ID_MEDIATEK		0x14c3
> > +#define PCI_DEVICE_ID_MEDIATEK_7629	0x7629
> >  
> >  #define PCI_VENDOR_ID_TITAN		0x14D2
> >  #define PCI_DEVICE_ID_TITAN_010L	0x8001
> 
> Hi Bjorn & Lorenzo,
> 
> Is this patch ok or is there anything I need to fixed?
> 
> Thanks.
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
