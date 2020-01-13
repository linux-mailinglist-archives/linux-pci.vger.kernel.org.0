Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50C04139CA4
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2020 23:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728714AbgAMWej (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 17:34:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:52116 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726530AbgAMWej (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jan 2020 17:34:39 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9CFE0207FF;
        Mon, 13 Jan 2020 22:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578954878;
        bh=vPaoIv3K3OkGHthTe0VwmQQyIHT4a91KzCBghgPlylE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cK2X/HbXh6fTIVAWPjHS3dF05JIN8pCEXV6q9WrBpQezbi27nM/zXpgAkfc/X9XpM
         V7WPdwjnA5hGWJrotUaQJF5VrAaWgdeWX5B55mwZHw8Ga+Lk8hpeTTtGLI5rxP/Dnm
         NpsSBCAeGej1JjaWSg2d+AhzI6akod+v6khtlkT4=
Date:   Mon, 13 Jan 2020 16:34:36 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        rgummal@xilinx.com
Subject: Re: [PATCH v3 2/2] PCI: Versal CPM: Add support for Versal CPM Root
 Port driver
Message-ID: <20200113223436.GA128724@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578909821-10604-3-git-send-email-bharat.kumar.gogada@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

s/PCI: Versal CPM: .../PCI: xilinx-cpm: Add Versal CPM Root Port driver/

Format is "PCI: <driver-name>: Subject"

On Mon, Jan 13, 2020 at 03:33:41PM +0530, Bharat Kumar Gogada wrote:
> - Adding support for Versal CPM as Root Port.

s/- Adding/Add/

> - The Versal ACAP devices include CCIX-PCIe Module (CPM). The integrated
>   block for CPM along with the integrated bridge can function
>   as PCIe Root Port.
> - CPM Versal uses GICv3 ITS feature for acheiving assigning MSI/MSI-X
>   vectors and handling MSI/MSI-X interrupts.

s/acheiving//

> - Bridge error and legacy interrupts in Versal CPM are handled using
>   Versal CPM specific MISC interrupt line.
> 
> Changes v3:
> Fix warnings reported.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> Reported-by: kbuild test robot <lkp@intel.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

"Reported-by" is for bug reports.  This makes it look like the lack of
the driver is the bug, but it's not.  Personally, I'd thank Dan and
the kbuild robot, but not add "Reported-by" here.  It's like patch
reviews; I don't expect you to mention my feedback in the commit log.

> +config PCIE_XILINX_CPM
> +	bool "Xilinx Versal CPM host bridge support"
> +	depends on ARCH_ZYNQMP || COMPILE_TEST
> +	help
> +	  Say 'Y' here if you want kernel to enable support the
> +	  Xilinx Versal CPM host Bridge driver.The driver supports
> +	  MSI/MSI-X interrupts using GICv3 ITS feature.

s/kernel to enable support the/kernel support for the/
s/host Bridge driver./host bridge. /  (note space after period)

> + * xilinx_cpm_pcie_valid_device - Check if a valid device is present on bus

Technically this does not check if the device is present on the bus.
It checks whether it's *possible* for a device to be at this address.
For non-root bus devices in particular, it always returns true, and
you have to do a config read to see whether a device responds.

> + * @bus: PCI Bus structure
> + * @devfn: device/function
> + *
> + * Return: 'true' on success and 'false' if invalid device is found
> + */
> +static bool xilinx_cpm_pcie_valid_device(struct pci_bus *bus,
> +					 unsigned int devfn)
> +{
> +	struct xilinx_cpm_pcie_port *port = bus->sysdata;
> +
> +	/* Only one device down on each root port */
> +	if (bus->number == port->root_busno && devfn > 0)
> +		return false;
> +
> +	return true;
> +}

> +static irqreturn_t xilinx_cpm_pcie_intr_handler(int irq, void *data)
> +{
> +	struct xilinx_cpm_pcie_port *port =
> +				(struct xilinx_cpm_pcie_port *)data;

No cast needed.

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
> +	/* Enable all interrupts */
> +	pcie_write(port, XILINX_CPM_PCIE_IMR_ALL_MASK,
> +		   XILINX_CPM_PCIE_REG_IMR);
> +	pcie_write(port, XILINX_CPM_PCIE_IDRN_MASK,
> +		   XILINX_CPM_PCIE_REG_IDRN_MASK);
> +
> +	writel(XILINX_CPM_PCIE_MISC_IR_LOCAL,
> +	       port->cpm_base + XILINX_CPM_PCIE_MISC_IR_ENABLE);

This lonely writel() in the middle of all the pcie_write() and
pcie_read() calls *looks* like a mistake.

I see that the writel() uses port->cpm_base, while pcie_write() uses
port->reg_base, so I don't think it *is* a mistake, but it's sure not
obvious.  A blank line after it and a comment at the _MISC_IR
definitions about them being in a different register set would be nice
hints.

> +	/* Enable the Bridge enable bit */
> +	pcie_write(port, pcie_read(port, XILINX_CPM_PCIE_REG_RPSC) |
> +		   XILINX_CPM_PCIE_REG_RPSC_BEN,
> +		   XILINX_CPM_PCIE_REG_RPSC);
> +}

> +static int xilinx_cpm_pcie_parse_dt(struct xilinx_cpm_pcie_port *port)
> +{
> +	struct device *dev = port->dev;
> +	struct resource *res;
> +	int err;
> +	struct platform_device *pdev = to_platform_device(dev);

The "struct platform_device ..." line really should be first in the
list.  Not because of "reverse Christmas tree", but because "pdev" is
the first variable used in the code below.

> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
> +	port->reg_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(port->reg_base))
> +		return PTR_ERR(port->reg_base);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM,
> +					   "cpm_slcr");
> +	port->cpm_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(port->cpm_base))
> +		return PTR_ERR(port->cpm_base);

Bjorn
