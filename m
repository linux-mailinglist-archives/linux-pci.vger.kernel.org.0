Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A134214B65C
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2020 15:04:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728077AbgA1OE1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jan 2020 09:04:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:51638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728070AbgA1OE1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jan 2020 09:04:27 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 212012468F;
        Tue, 28 Jan 2020 14:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580220266;
        bh=ub4UwKqrZMgy6+sqrMhH+mrNyxJs1wj0mog/wg3Wxx0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=2UXpA6vi6H0YSp/fpxanVwcpc42jUmIi3kYBrYYIq/in9lxz55IcxTVto6yR3Qns0
         zTf0Qdk2pZcJzQ+ZCjDYagC9ZENOLyQudDxjhQc0n4CwKAJ38zq+TdHLcBE/OuOwMK
         askCzG5zDppDZuwGYKJ+jhu/ibUp1dTtJS5tGHcA=
Date:   Tue, 28 Jan 2020 08:04:24 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        rgummal@xilinx.com
Subject: Re: [PATCH v4 2/2] PCI: xilinx-cpm: Add Versal CPM Root Port driver
Message-ID: <20200128140424.GA150109@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580215483-8835-3-git-send-email-bharat.kumar.gogada@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 28, 2020 at 06:14:43PM +0530, Bharat Kumar Gogada wrote:
> - Add support for Versal CPM as Root Port.
> - The Versal ACAP devices include CCIX-PCIe Module (CPM). The integrated
>   block for CPM along with the integrated bridge can function
>   as PCIe Root Port.
> - CPM Versal uses GICv3 ITS feature for achieving assigning MSI/MSI-X
>   vectors and handling MSI/MSI-X interrupts.
> - Bridge error and legacy interrupts in Versal CPM are handled using
>   Versal CPM specific MISC interrupt line.
> 
> Changes v4:
> - change commit subject.
> - Remove unnecessary comments and type cast.
> - Added comments for CPM block register access using readl/writel.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ...

> +static bool xilinx_cpm_pcie_valid_device(struct pci_bus *bus,
> +					 unsigned int devfn)
> +{
> +	struct xilinx_cpm_pcie_port *port = bus->sysdata;
> +
> +	/* Only one device down on each root port */
> +	if (bus->number == port->root_busno && devfn > 0)
> +		return false;

This whole *_valid_device() thing is a mess.  We shouldn't need it at
all.  But if we *do* need it, I don't think you should check the
entire devfn because that means you can't attach a multifunction
device.

Several other drivers with similar *_valid_device() implementations
check only PCI_SLOT():

  dw_pcie_valid_device()
  advk_pcie_valid_device()
  pci_dw_valid_device()
  altera_pcie_valid_device()
  mobiveil_pcie_valid_device()
  rockchip_pcie_valid_device()

Even checking just PCI_SLOT() is problematic because I think an ARI
device with more than 8 functions will not work correctly.

What exactly happens if you omit this function, i.e., if we just go
ahead and attempt config accesses when the device is not present?  We
*should* get something like an Unsupported Request completion, and
that *should* be a recoverable error.  Most hardware turns this error
into read data of 0xffffffff.  The OS should be able to figure out
that there's no device there and continue with no ill effects.

> +	return true;
> +}
> +
> +/**
> + * xilinx_cpm_pcie_map_bus - Get configuration base
> + * @bus: PCI Bus structure
> + * @devfn: Device/function
> + * @where: Offset from base
> + *
> + * Return: Base address of the configuration space needed to be
> + *	   accessed.
> + */
> +static void __iomem *xilinx_cpm_pcie_map_bus(struct pci_bus *bus,
> +					     unsigned int devfn, int where)
> +{
> +	struct xilinx_cpm_pcie_port *port = bus->sysdata;
> +	int relbus;
> +
> +	if (!xilinx_cpm_pcie_valid_device(bus, devfn))
> +		return NULL;
> +
> +	relbus = (bus->number << ECAM_BUS_NUM_SHIFT) |
> +		 (devfn << ECAM_DEV_NUM_SHIFT);
> +
> +	return port->reg_base + relbus + where;
> +}
> +
> +/* PCIe operations */
> +static struct pci_ops xilinx_cpm_pcie_ops = {
> +	.map_bus = xilinx_cpm_pcie_map_bus,
> +	.read	= pci_generic_config_read,
> +	.write	= pci_generic_config_write,
> +};
