Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94AD223D3A6
	for <lists+linux-pci@lfdr.de>; Wed,  5 Aug 2020 23:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgHEVjh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Aug 2020 17:39:37 -0400
Received: from foss.arm.com ([217.140.110.172]:37392 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725648AbgHEVjg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Aug 2020 17:39:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 96E611045;
        Wed,  5 Aug 2020 14:39:35 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94A093F7D7;
        Wed,  5 Aug 2020 14:39:34 -0700 (PDT)
Date:   Wed, 5 Aug 2020 22:39:28 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh@kernel.org, maz@kernel.org
Subject: Re: [PATCH v9 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Message-ID: <20200805213928.GA1029@e121166-lin.cambridge.arm.com>
References: <1592312214-9347-3-git-send-email-bharat.kumar.gogada@xilinx.com>
 <20200805204358.GA535480@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805204358.GA535480@bjorn-Precision-5520>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 05, 2020 at 03:43:58PM -0500, Bjorn Helgaas wrote:
> On Tue, Jun 16, 2020 at 06:26:54PM +0530, Bharat Kumar Gogada wrote:
> > - Add support for Versal CPM as Root Port.
> > - The Versal ACAP devices include CCIX-PCIe Module (CPM). The integrated
> >   block for CPM along with the integrated bridge can function
> >   as PCIe Root Port.
> > - Bridge error and legacy interrupts in Versal CPM are handled using
> >   Versal CPM specific interrupt line.
> 
> > +static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie_port *port)
> > +{
> > +	if (cpm_pcie_link_up(port))
> > +		dev_info(port->dev, "PCIe Link is UP\n");
> > +	else
> > +		dev_info(port->dev, "PCIe Link is DOWN\n");
> > +
> > +	/* Disable all interrupts */
> > +	pcie_write(port, ~XILINX_CPM_PCIE_IDR_ALL_MASK,
> > +		   XILINX_CPM_PCIE_REG_IMR);
> > +
> > +	/* Clear pending interrupts */
> > +	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_IDR) &
> > +		   XILINX_CPM_PCIE_IMR_ALL_MASK,
> > +		   XILINX_CPM_PCIE_REG_IDR);
> > +
> > +	/*
> > +	 * XILINX_CPM_PCIE_MISC_IR_ENABLE register is mapped to
> > +	 * CPM SLCR block.
> > +	 */
> > +	writel(XILINX_CPM_PCIE_MISC_IR_LOCAL,
> > +	       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
> > +	/* Enable the Bridge enable bit */
> > +	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_RPSC) |
> > +		   XILINX_CPM_PCIE_REG_RPSC_BEN,
> > +		   XILINX_CPM_PCIE_REG_RPSC);
> > +}
> > +
> > +/**
> > + * xilinx_cpm_pcie_parse_dt - Parse Device tree
> > + * @port: PCIe port information
> > + * @bus_range: Bus resource
> > + *
> > + * Return: '0' on success and error value on failure
> > + */
> > +static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie_port *port,
> > +				    struct resource *bus_range)
> > +{
> > +	struct device *dev = port->dev;
> > +	struct platform_device *pdev = to_platform_device(dev);
> > +	struct resource *res;
> > +
> > +	port->cpm_base = devm_platform_ioremap_resource_byname(pdev,
> > +							       "cpm_slcr");
> > +	if (IS_ERR(port->cpm_base))
> > +		return PTR_ERR(port->cpm_base);
> > +
> > +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> > +	if (!res)
> > +		return -ENXIO;
> > +
> > +	port->cfg = pci_ecam_create(dev, res, bus_range,
> > +				    &pci_generic_ecam_ops);
> 
> Aren't we passing an uninitialized pointer (bus_range) here?  This
> looks broken to me.
> 
> The kernelci build warns about it:
> https://kernelci.org/build/next/branch/master/kernel/next-20200805/
> 
>   /scratch/linux/drivers/pci/controller/pcie-xilinx-cpm.c:557:39: warning: variable 'bus_range' is uninitialized when used here [-Wuninitialized]
> 
> I'm dropping this for now.  I can't believe this actually works.

It is caused by my rebase to fix -next after the rework in pci/misc
(I had to drop the call to pci_parse_request_of_pci_ranges()).

I will look into this tomorrow if Rob does not beat me to it.

Apologies, it is a new driver that was based on an interface
that is being reworked, for good reasons, in pci/misc.

Lorenzo
