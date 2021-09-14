Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25A7640AB3A
	for <lists+linux-pci@lfdr.de>; Tue, 14 Sep 2021 11:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbhINJ5Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Sep 2021 05:57:25 -0400
Received: from sibelius.xs4all.nl ([83.163.83.176]:62212 "EHLO
        sibelius.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhINJ5Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Sep 2021 05:57:24 -0400
Received: from localhost (bloch.sibelius.xs4all.nl [local])
        by bloch.sibelius.xs4all.nl (OpenSMTPD) with ESMTPA id 8905fce2;
        Tue, 14 Sep 2021 11:56:05 +0200 (CEST)
Date:   Tue, 14 Sep 2021 11:56:05 +0200 (CEST)
From:   Mark Kettenis <mark.kettenis@xs4all.nl>
To:     Marc Zyngier <maz@kernel.org>
Cc:     sven@svenpeter.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, lorenzo.pieralisi@arm.com,
        kw@linux.com, alyssa@rosenzweig.io, stan@corellium.com,
        kettenis@openbsd.org, marcan@marcan.st, Robin.Murphy@arm.com,
        kernel-team@android.com
In-Reply-To: <87y27zbiu3.wl-maz@kernel.org> (message from Marc Zyngier on Tue,
        14 Sep 2021 10:35:32 +0100)
Subject: Re: [PATCH v3 10/10] PCI: apple: Configure RID to SID mapper on device addition
References: <20210913182550.264165-1-maz@kernel.org>
        <20210913182550.264165-11-maz@kernel.org>
        <b502383a-fe68-498a-b714-7832d3c8703e@www.fastmail.com> <87y27zbiu3.wl-maz@kernel.org>
Message-ID: <56145a72aa978ebd@bloch.sibelius.xs4all.nl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> Date: Tue, 14 Sep 2021 10:35:32 +0100
> From: Marc Zyngier <maz@kernel.org>
> 
> On Mon, 13 Sep 2021 21:45:13 +0100,
> "Sven Peter" <sven@svenpeter.dev> wrote:
> > 
> > On Mon, Sep 13, 2021, at 20:25, Marc Zyngier wrote:
> > > The Apple PCIe controller doesn't directly feed the endpoint's
> > > Requester ID to the IOMMU (DART), but instead maps RIDs onto
> > > Stream IDs (SIDs). The DART and the PCIe controller must thus
> > > agree on the SIDs that are used for translation (by using
> > > the 'iommu-map' property).
> > > 
> > > For this purpose, parse the 'iommu-map' property each time a
> > > device gets added, and use the resulting translation to configure
> > > the PCIe RID-to-SID mapper. Similarily, remove the translation
> > > if/when the device gets removed.
> > > 
> > > This is all driven from a bus notifier which gets registered at
> > > probe time. Hopefully this is the only PCI controller driver
> > > in the whole system.
> > > 
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > ---
> > >  drivers/pci/controller/pcie-apple.c | 158 +++++++++++++++++++++++++++-
> > >  1 file changed, 156 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/pcie-apple.c 
> > > b/drivers/pci/controller/pcie-apple.c
> > > index 76344223245d..68d71eabe708 100644
> > > --- a/drivers/pci/controller/pcie-apple.c
> > > +++ b/drivers/pci/controller/pcie-apple.c
> > > @@ -23,8 +23,10 @@
> > >  #include <linux/iopoll.h>
> > >  #include <linux/irqchip/chained_irq.h>
> > >  #include <linux/irqdomain.h>
> > > +#include <linux/list.h>
> > >  #include <linux/module.h>
> > >  #include <linux/msi.h>
> > > +#include <linux/notifier.h>
> > >  #include <linux/of_irq.h>
> > >  #include <linux/pci-ecam.h>
> > >  
> > > @@ -116,6 +118,8 @@
> > >  #define   PORT_TUNSTAT_PERST_ACK_PEND	BIT(1)
> > >  #define PORT_PREFMEM_ENABLE		0x00994
> > >  
> > > +#define MAX_RID2SID			64
> > 
> > Do these actually have 64 slots? I thought that was only for
> > the Thunderbolt controllers and that these only had 16.
> 
> You are indeed right, and I blindly used the limit used in the
> Correlium driver. Using entries from 16 onward result in a non booting
> system. The registers do not fault though, and simply ignore writes. I
> came up with an simple fix for this, see below.

Or should be add a property to the DT binding to indicate the number
of entries (using a default of 16)?  We don't have to add that
property right away; we can delay that until we actually try to
support the Thunderbolt ports.

In case you didn't know already, RIDs that have no mapping in the
RID2SID table map to SID 0.  That's why I picked 1 as the SID in the
iommu-map property for the port.

> > I never checked it myself though and it doesn't make much
> > of a difference for now since only four different RIDs will
> > ever be connected anyway.
> 
> Four? I guess the radios expose more than a single RID?

At this point, on the M1 mini there is the Broadcom BCM4378 WiFi/BT
device (which has two functions), the Fresco Logic FL1100 xHCI
controller (single function) and the Broadcom BCM57765 Ethernet
controller.  So yes, there are for RIDs.

Cheers,

Mark

> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index 68d71eabe708..ec9e7abd2aca 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -148,6 +148,7 @@ struct apple_pcie_port {
>  	struct irq_domain	*domain;
>  	struct list_head	entry;
>  	DECLARE_BITMAP(		sid_map, MAX_RID2SID);
> +	int			sid_map_sz;
>  	int			idx;
>  };
>  
> @@ -495,12 +496,12 @@ static int apple_pcie_setup_refclk(struct apple_pcie *pcie,
>  	return 0;
>  }
>  
> -static void apple_pcie_rid2sid_write(struct apple_pcie_port *port,
> +static u32 apple_pcie_rid2sid_write(struct apple_pcie_port *port,
>  				     int idx, u32 val)
>  {
>  	writel_relaxed(val, port->base + PORT_RID2SID(idx));
>  	/* Read back to ensure completion of the write */
> -	(void)readl_relaxed(port->base + PORT_RID2SID(idx));
> +	return readl_relaxed(port->base + PORT_RID2SID(idx));
>  }
>  
>  static int apple_pcie_setup_port(struct apple_pcie *pcie,
> @@ -557,9 +558,16 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
>  	if (ret)
>  		return ret;
>  
> -	/* Reset all RID/SID mappings */
> -	for (i = 0; i < MAX_RID2SID; i++)
> +	/* Reset all RID/SID mappings, and check for RAZ/WI registers */
> +	for (i = 0; i < MAX_RID2SID; i++) {
> +		if (apple_pcie_rid2sid_write(port, i, 0xbad1d) != 0xbad1d)
> +			break;
>  		apple_pcie_rid2sid_write(port, i, 0);
> +	}
> +
> +	dev_dbg(pcie->dev, "%pOF: %d RID/SID mapping entries\n", np, i);
> +
> +	port->sid_map_sz = i;
>  
>  	list_add_tail(&port->entry, &pcie->ports);
>  	init_completion(&pcie->event);
> @@ -667,7 +675,7 @@ static int apple_pcie_add_device(struct pci_dev *pdev)
>  		return err;
>  
>  	mutex_lock(&port->pcie->lock);
> -	sid_idx = bitmap_find_free_region(port->sid_map, MAX_RID2SID, 0);
> +	sid_idx = bitmap_find_free_region(port->sid_map, port->sid_map_sz, 0);
>  	mutex_unlock(&port->pcie->lock);
>  
>  	if (sid_idx < 0)
> @@ -696,7 +704,7 @@ static void apple_pcie_release_device(struct pci_dev *pdev)
>  
>  	mutex_lock(&port->pcie->lock);
>  
> -	for_each_set_bit(idx, port->sid_map, MAX_RID2SID) {
> +	for_each_set_bit(idx, port->sid_map, port->sid_map_sz) {
>  		u32 val;
>  
>  		val = readl_relaxed(port->base + PORT_RID2SID(idx));
> 
> -- 
> Without deviation from the norm, progress is not possible.
> 
