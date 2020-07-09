Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A22F8219BF4
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jul 2020 11:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgGIJUC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 05:20:02 -0400
Received: from foss.arm.com ([217.140.110.172]:45390 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbgGIJUC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jul 2020 05:20:02 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1BBB31B;
        Thu,  9 Jul 2020 02:20:00 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BAB33F887;
        Thu,  9 Jul 2020 02:19:58 -0700 (PDT)
Date:   Thu, 9 Jul 2020 10:19:50 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Laurentiu Tudor <laurentiu.tudor@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Makarand Pawagi <makarand.pawagi@nxp.com>,
        Diana Craciun <diana.craciun@oss.nxp.com>,
        iommu@lists.linux-foundation.org, linux-acpi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Joerg Roedel <joro@8bytes.org>,
        Hanjun Guo <guohanjun@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v2 12/12] bus: fsl-mc: Add ACPI support for fsl-mc
Message-ID: <20200709091950.GA18149@e121166-lin.cambridge.arm.com>
References: <20200521130008.8266-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-1-lorenzo.pieralisi@arm.com>
 <20200619082013.13661-13-lorenzo.pieralisi@arm.com>
 <a7845603-9bc9-9099-dfc4-19b7bc4f4e44@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7845603-9bc9-9099-dfc4-19b7bc4f4e44@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 01, 2020 at 07:55:28PM +0300, Laurentiu Tudor wrote:
> 
> 
> On 6/19/2020 11:20 AM, Lorenzo Pieralisi wrote:
> > From: Makarand Pawagi <makarand.pawagi@nxp.com>
> > 
> > Add ACPI support in the fsl-mc driver. Driver parses MC DSDT table to
> > extract memory and other resources.
> > 
> > Interrupt (GIC ITS) information is extracted from the MADT table
> > by drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c.
> > 
> > IORT table is parsed to configure DMA.
> > 
> > Signed-off-by: Makarand Pawagi <makarand.pawagi@nxp.com>
> > Signed-off-by: Diana Craciun <diana.craciun@oss.nxp.com>
> > Signed-off-by: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> > ---
> >  drivers/bus/fsl-mc/fsl-mc-bus.c             | 73 ++++++++++++----
> >  drivers/bus/fsl-mc/fsl-mc-msi.c             | 37 +++++----
> >  drivers/irqchip/irq-gic-v3-its-fsl-mc-msi.c | 92 ++++++++++++++++-----
> >  3 files changed, 150 insertions(+), 52 deletions(-)
> > 
> > diff --git a/drivers/bus/fsl-mc/fsl-mc-bus.c b/drivers/bus/fsl-mc/fsl-mc-bus.c
> > index 824ff77bbe86..324d49d6df89 100644
> > --- a/drivers/bus/fsl-mc/fsl-mc-bus.c
> > +++ b/drivers/bus/fsl-mc/fsl-mc-bus.c
> > @@ -18,6 +18,8 @@
> >  #include <linux/bitops.h>
> >  #include <linux/msi.h>
> >  #include <linux/dma-mapping.h>
> > +#include <linux/acpi.h>
> > +#include <linux/iommu.h>
> >  
> >  #include "fsl-mc-private.h"
> >  
> > @@ -38,6 +40,7 @@ struct fsl_mc {
> >  	struct fsl_mc_device *root_mc_bus_dev;
> >  	u8 num_translation_ranges;
> >  	struct fsl_mc_addr_translation_range *translation_ranges;
> > +	void *fsl_mc_regs;
> >  };
> >  
> >  /**
> > @@ -56,6 +59,10 @@ struct fsl_mc_addr_translation_range {
> >  	phys_addr_t start_phys_addr;
> >  };
> >  
> > +#define FSL_MC_FAPR	0x28
> > +#define MC_FAPR_PL	BIT(18)
> > +#define MC_FAPR_BMT	BIT(17)
> > +
> >  /**
> >   * fsl_mc_bus_match - device to driver matching callback
> >   * @dev: the fsl-mc device to match against
> > @@ -124,7 +131,10 @@ static int fsl_mc_dma_configure(struct device *dev)
> >  	while (dev_is_fsl_mc(dma_dev))
> >  		dma_dev = dma_dev->parent;
> >  
> > -	return of_dma_configure_id(dev, dma_dev->of_node, 0, &input_id);
> > +	if (dev_of_node(dma_dev))
> > +		return of_dma_configure_id(dev, dma_dev->of_node, 0, &input_id);
> > +
> > +	return acpi_dma_configure_id(dev, DEV_DMA_COHERENT, &input_id);
> >  }
> >  
> >  static ssize_t modalias_show(struct device *dev, struct device_attribute *attr,
> > @@ -865,8 +875,11 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
> >  	struct fsl_mc_io *mc_io = NULL;
> >  	int container_id;
> >  	phys_addr_t mc_portal_phys_addr;
> > -	u32 mc_portal_size;
> > -	struct resource res;
> > +	u32 mc_portal_size, mc_stream_id;
> > +	struct resource *plat_res;
> > +
> > +	if (!iommu_present(&fsl_mc_bus_type))
> > +		return -EPROBE_DEFER;
> >  
> >  	mc = devm_kzalloc(&pdev->dev, sizeof(*mc), GFP_KERNEL);
> >  	if (!mc)
> > @@ -874,19 +887,33 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
> >  
> >  	platform_set_drvdata(pdev, mc);
> >  
> > +	plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
> > +	mc->fsl_mc_regs = devm_ioremap_resource(&pdev->dev, plat_res);
> > +	if (IS_ERR(mc->fsl_mc_regs))
> > +		return PTR_ERR(mc->fsl_mc_regs);
> > +
> > +	if (IS_ENABLED(CONFIG_ACPI) && !dev_of_node(&pdev->dev)) {
> > +		mc_stream_id = readl(mc->fsl_mc_regs + FSL_MC_FAPR);
> > +		/*
> > +		 * HW ORs the PL and BMT bit, places the result in bit 15 of
> > +		 * the StreamID and ORs in the ICID. Calculate it accordingly.
> > +		 */
> > +		mc_stream_id = (mc_stream_id & 0xffff) |
> > +				((mc_stream_id & (MC_FAPR_PL | MC_FAPR_BMT)) ?
> > +					0x4000 : 0);
> > +		error = acpi_dma_configure_id(&pdev->dev, DEV_DMA_COHERENT,
> > +					      &mc_stream_id);
> > +		if (error)
> > +			dev_warn(&pdev->dev, "failed to configure dma: %d.\n",
> > +				 error);
> > +	}
> > +
> >  	/*
> >  	 * Get physical address of MC portal for the root DPRC:
> >  	 */
> > -	error = of_address_to_resource(pdev->dev.of_node, 0, &res);
> > -	if (error < 0) {
> > -		dev_err(&pdev->dev,
> > -			"of_address_to_resource() failed for %pOF\n",
> > -			pdev->dev.of_node);
> > -		return error;
> > -	}
> > -
> > -	mc_portal_phys_addr = res.start;
> > -	mc_portal_size = resource_size(&res);
> > +	plat_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	mc_portal_phys_addr = plat_res->start;
> > +	mc_portal_size = resource_size(plat_res);
> >  	error = fsl_create_mc_io(&pdev->dev, mc_portal_phys_addr,
> >  				 mc_portal_size, NULL,
> >  				 FSL_MC_IO_ATOMIC_CONTEXT_PORTAL, &mc_io);
> > @@ -903,11 +930,13 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
> >  	dev_info(&pdev->dev, "MC firmware version: %u.%u.%u\n",
> >  		 mc_version.major, mc_version.minor, mc_version.revision);
> >  
> > -	error = get_mc_addr_translation_ranges(&pdev->dev,
> > -					       &mc->translation_ranges,
> > -					       &mc->num_translation_ranges);
> > -	if (error < 0)
> > -		goto error_cleanup_mc_io;
> > +	if (dev_of_node(&pdev->dev)) {
> > +		error = get_mc_addr_translation_ranges(&pdev->dev,
> > +						&mc->translation_ranges,
> > +						&mc->num_translation_ranges);
> > +		if (error < 0)
> > +			goto error_cleanup_mc_io;
> > +	}
> >  
> >  	error = dprc_get_container_id(mc_io, 0, &container_id);
> >  	if (error < 0) {
> > @@ -934,6 +963,7 @@ static int fsl_mc_bus_probe(struct platform_device *pdev)
> >  		goto error_cleanup_mc_io;
> >  
> >  	mc->root_mc_bus_dev = mc_bus_dev;
> > +	mc_bus_dev->dev.fwnode = pdev->dev.fwnode;
> 
> Makarand, this looks a bit weird. Is there really a reason for it?

Can you clarify please so that we can reach a conclusion on this matter ?

Thanks,
Lorenzo
