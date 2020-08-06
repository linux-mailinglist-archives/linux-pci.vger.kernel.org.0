Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497A723D8F4
	for <lists+linux-pci@lfdr.de>; Thu,  6 Aug 2020 11:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgHFJyz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Aug 2020 05:54:55 -0400
Received: from foss.arm.com ([217.140.110.172]:41786 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728971AbgHFJyw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Aug 2020 05:54:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A9D4B106F;
        Thu,  6 Aug 2020 02:54:51 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A97A33F9AB;
        Thu,  6 Aug 2020 02:54:50 -0700 (PDT)
Date:   Thu, 6 Aug 2020 10:54:45 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh@kernel.org, maz@kernel.org
Subject: Re: [PATCH v9 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Message-ID: <20200806095445.GA9715@e121166-lin.cambridge.arm.com>
References: <20200805220326.GA550962@bjorn-Precision-5520>
 <20200805233050.GA607207@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805233050.GA607207@bjorn-Precision-5520>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 05, 2020 at 06:30:50PM -0500, Bjorn Helgaas wrote:
> On Wed, Aug 05, 2020 at 05:03:26PM -0500, Bjorn Helgaas wrote:
> > On Wed, Aug 05, 2020 at 10:39:28PM +0100, Lorenzo Pieralisi wrote:
> > > On Wed, Aug 05, 2020 at 03:43:58PM -0500, Bjorn Helgaas wrote:
> > > > On Tue, Jun 16, 2020 at 06:26:54PM +0530, Bharat Kumar Gogada wrote:
> > > > > - Add support for Versal CPM as Root Port.
> > > > > - The Versal ACAP devices include CCIX-PCIe Module (CPM). The integrated
> > > > >   block for CPM along with the integrated bridge can function
> > > > >   as PCIe Root Port.
> > > > > - Bridge error and legacy interrupts in Versal CPM are handled using
> > > > >   Versal CPM specific interrupt line.
> > > > 
> > > > > +static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie_port *port)
> > > > > +{
> > > > > +	if (cpm_pcie_link_up(port))
> > > > > +		dev_info(port->dev, "PCIe Link is UP\n");
> > > > > +	else
> > > > > +		dev_info(port->dev, "PCIe Link is DOWN\n");
> > > > > +
> > > > > +	/* Disable all interrupts */
> > > > > +	pcie_write(port, ~XILINX_CPM_PCIE_IDR_ALL_MASK,
> > > > > +		   XILINX_CPM_PCIE_REG_IMR);
> > > > > +
> > > > > +	/* Clear pending interrupts */
> > > > > +	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_IDR) &
> > > > > +		   XILINX_CPM_PCIE_IMR_ALL_MASK,
> > > > > +		   XILINX_CPM_PCIE_REG_IDR);
> > > > > +
> > > > > +	/*
> > > > > +	 * XILINX_CPM_PCIE_MISC_IR_ENABLE register is mapped to
> > > > > +	 * CPM SLCR block.
> > > > > +	 */
> > > > > +	writel(XILINX_CPM_PCIE_MISC_IR_LOCAL,
> > > > > +	       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
> > > > > +	/* Enable the Bridge enable bit */
> > > > > +	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_RPSC) |
> > > > > +		   XILINX_CPM_PCIE_REG_RPSC_BEN,
> > > > > +		   XILINX_CPM_PCIE_REG_RPSC);
> > > > > +}
> > > > > +
> > > > > +/**
> > > > > + * xilinx_cpm_pcie_parse_dt - Parse Device tree
> > > > > + * @port: PCIe port information
> > > > > + * @bus_range: Bus resource
> > > > > + *
> > > > > + * Return: '0' on success and error value on failure
> > > > > + */
> > > > > +static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie_port *port,
> > > > > +				    struct resource *bus_range)
> > > > > +{
> > > > > +	struct device *dev = port->dev;
> > > > > +	struct platform_device *pdev = to_platform_device(dev);
> > > > > +	struct resource *res;
> > > > > +
> > > > > +	port->cpm_base = devm_platform_ioremap_resource_byname(pdev,
> > > > > +							       "cpm_slcr");
> > > > > +	if (IS_ERR(port->cpm_base))
> > > > > +		return PTR_ERR(port->cpm_base);
> > > > > +
> > > > > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> > > > > +	if (!res)
> > > > > +		return -ENXIO;
> > > > > +
> > > > > +	port->cfg = pci_ecam_create(dev, res, bus_range,
> > > > > +				    &pci_generic_ecam_ops);
> > > > 
> > > > Aren't we passing an uninitialized pointer (bus_range) here?  This
> > > > looks broken to me.
> > > > 
> > > > The kernelci build warns about it:
> > > > https://kernelci.org/build/next/branch/master/kernel/next-20200805/
> > > > 
> > > >   /scratch/linux/drivers/pci/controller/pcie-xilinx-cpm.c:557:39: warning: variable 'bus_range' is uninitialized when used here [-Wuninitialized]
> > > > 
> > > > I'm dropping this for now.  I can't believe this actually works.
> > > 
> > > It is caused by my rebase to fix -next after the rework in pci/misc
> > > (I had to drop the call to pci_parse_request_of_pci_ranges()).
> > > 
> > > I will look into this tomorrow if Rob does not beat me to it.
> > > 
> > > Apologies, it is a new driver that was based on an interface
> > > that is being reworked, for good reasons, in pci/misc.
> > 
> > Oh, yep, I think I see what happened.  I'll try to fix this in hopes
> > of making linux-next tonight.
> 
> OK, I think I fixed it.  Man, that was a lot of work for a git novice
> like me ;)  Current head: 6f119ec8d9c8 ("Merge branch 'pci/irq-error'")

Sorry about that.

> Diff from yesterday's "next" branch (a231039775c4 ("Merge branch
> 'pci/irq-error'")):
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-cpm.c b/drivers/pci/controller/pcie-xilinx-cpm.c
> index 5f9b9fc12500..f3082de44e8a 100644
> --- a/drivers/pci/controller/pcie-xilinx-cpm.c
> +++ b/drivers/pci/controller/pcie-xilinx-cpm.c
> @@ -539,7 +539,7 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
>  	struct xilinx_cpm_pcie_port *port;
>  	struct device *dev = &pdev->dev;
>  	struct pci_host_bridge *bridge;
> -	struct resource *bus_range;
> +	struct resource_entry *bus;
>  	int err;
>  
>  	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*port));
> @@ -554,7 +554,11 @@ static int xilinx_cpm_pcie_probe(struct platform_device *pdev)
>  	if (err)
>  		return err;
>  
> -	err = xilinx_cpm_pcie_parse_dt(port, bus_range);
> +	bus = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
> +	if (!bus)
> +		return -ENODEV;
> +
> +	err = xilinx_cpm_pcie_parse_dt(port, bus->res);
>  	if (err) {
>  		dev_err(dev, "Parsing DT failed\n");
>  		goto err_parse_dt;

Thanks - that seems all right to me. Side note: I think this is
even more robust than the original code since you are *actually*
checking that an IORESOURCE_BUS is present (and it is not a possible
dangling pointer).
