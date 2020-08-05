Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 304D323D33D
	for <lists+linux-pci@lfdr.de>; Wed,  5 Aug 2020 22:44:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726200AbgHEUoA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Aug 2020 16:44:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:59622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726282AbgHEUoA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Aug 2020 16:44:00 -0400
Received: from localhost (mobile-166-175-186-42.mycingular.net [166.175.186.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91D29206D4;
        Wed,  5 Aug 2020 20:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596660240;
        bh=cc3Lf4FlNVl371CkEGHgJiQ/kuJ+pE4NL0Yr8sg6rd4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ffYl8CBoOHateD8I23vIlkS5ZkG6SYIskbB4PPN6ABmomgS8J+M9py19VIj47Mbo0
         Ux+lywAjHLF2wr8r1DMATjfYFdugdECBp4toHHPL29Jso2lwY7wCqpsv9tgXXJGVhc
         8bFryKOLjiTvB6MBa9rQVpek4qdl0sVGsgQMwoa8=
Date:   Wed, 5 Aug 2020 15:43:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        maz@kernel.org
Subject: Re: [PATCH v9 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Message-ID: <20200805204358.GA535480@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1592312214-9347-3-git-send-email-bharat.kumar.gogada@xilinx.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 16, 2020 at 06:26:54PM +0530, Bharat Kumar Gogada wrote:
> - Add support for Versal CPM as Root Port.
> - The Versal ACAP devices include CCIX-PCIe Module (CPM). The integrated
>   block for CPM along with the integrated bridge can function
>   as PCIe Root Port.
> - Bridge error and legacy interrupts in Versal CPM are handled using
>   Versal CPM specific interrupt line.

> +static void xilinx_cpm_pcie_init_port(struct xilinx_cpm_pcie_port *port)
> +{
> +	if (cpm_pcie_link_up(port))
> +		dev_info(port->dev, "PCIe Link is UP\n");
> +	else
> +		dev_info(port->dev, "PCIe Link is DOWN\n");
> +
> +	/* Disable all interrupts */
> +	pcie_write(port, ~XILINX_CPM_PCIE_IDR_ALL_MASK,
> +		   XILINX_CPM_PCIE_REG_IMR);
> +
> +	/* Clear pending interrupts */
> +	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_IDR) &
> +		   XILINX_CPM_PCIE_IMR_ALL_MASK,
> +		   XILINX_CPM_PCIE_REG_IDR);
> +
> +	/*
> +	 * XILINX_CPM_PCIE_MISC_IR_ENABLE register is mapped to
> +	 * CPM SLCR block.
> +	 */
> +	writel(XILINX_CPM_PCIE_MISC_IR_LOCAL,
> +	       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);
> +	/* Enable the Bridge enable bit */
> +	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_RPSC) |
> +		   XILINX_CPM_PCIE_REG_RPSC_BEN,
> +		   XILINX_CPM_PCIE_REG_RPSC);
> +}
> +
> +/**
> + * xilinx_cpm_pcie_parse_dt - Parse Device tree
> + * @port: PCIe port information
> + * @bus_range: Bus resource
> + *
> + * Return: '0' on success and error value on failure
> + */
> +static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie_port *port,
> +				    struct resource *bus_range)
> +{
> +	struct device *dev = port->dev;
> +	struct platform_device *pdev = to_platform_device(dev);
> +	struct resource *res;
> +
> +	port->cpm_base = devm_platform_ioremap_resource_byname(pdev,
> +							       "cpm_slcr");
> +	if (IS_ERR(port->cpm_base))
> +		return PTR_ERR(port->cpm_base);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> +	if (!res)
> +		return -ENXIO;
> +
> +	port->cfg = pci_ecam_create(dev, res, bus_range,
> +				    &pci_generic_ecam_ops);

Aren't we passing an uninitialized pointer (bus_range) here?  This
looks broken to me.

The kernelci build warns about it:
https://kernelci.org/build/next/branch/master/kernel/next-20200805/

  /scratch/linux/drivers/pci/controller/pcie-xilinx-cpm.c:557:39: warning: variable 'bus_range' is uninitialized when used here [-Wuninitialized]

I'm dropping this for now.  I can't believe this actually works.

Bjorn
