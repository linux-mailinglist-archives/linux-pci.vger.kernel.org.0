Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2A8127EDB
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2019 15:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727388AbfLTO6f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Dec 2019 09:58:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:49156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727233AbfLTO6f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Dec 2019 09:58:35 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 478E021655;
        Fri, 20 Dec 2019 14:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576853914;
        bh=m6fiKtTDXZuHPTihN9gMIJKc7nsDJK8i2aTkUAulxHY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=xaZvrMbYpPIvyW61vg8KopAcqFXj0EyBVBdpHctX9Wl8WWu8TZAFr6cBVy/VtBtb2
         GVU6Zq1oLxYcXvcXHsLeHIBiCqzS2dNbebMWaKzzU4Zn3aSpenGXU1TBOz1J+gY5wB
         v/w2VQoKtjzQNi7til2Za1g10efjSr3o0DDxBqiI=
Date:   Fri, 20 Dec 2019 08:58:32 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        rgummal@xilinx.com, Michal Simek <michal.simek@xilinx.com>,
        Ley Foon Tan <lftan@altera.com>, rfi@lists.rocketboards.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: Re: [PATCH 2/2] PCI: Versal CPM: Add support for Versal CPM Root
 Port driver
Message-ID: <20191220145832.GA93984@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576842072-32027-3-git-send-email-bharat.kumar.gogada@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc other drivers that use the broken "is link up" test in config
access]

On Fri, Dec 20, 2019 at 05:11:12PM +0530, Bharat Kumar Gogada wrote:
> - Adding support for versal CPM as Root Port.
> - The Versal ACAP devices include CCIX-PCIe Module (CPM). The integrated
>   block for CPM along with the integrated bridge can function
>   as PCIe Root Port.
> - Versal CPM uses GICv3 ITS feature for assigning MSI/MSI-X
>   vectors and handling MSI/MSI-X interrupts.
> - Bridge error and legacy interrupts in versal CPM are handled using
>   versal CPM specific MISC interrupt line.

"Versal" appears to be a brand name and should be capitalized
consistently.

> +#define INTX_NUM                        4

Don't we have a generic PCI core definition for this?

> +static inline bool cpm_pcie_link_is_up(struct xilinx_cpm_pcie_port *port)

Please follow the example of other drivers and name this
"cpm_pcie_link_up()".

> +{
> +	return (pcie_read(port, XILINX_CPM_PCIE_REG_PSCR) &
> +		XILINX_CPM_PCIE_REG_PSCR_LNKUP) ? 1 : 0;
> +}

> +/**
> + * xilinx_cpm_pcie_valid_device - Check if a valid device is present on bus
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
> +	/* Check if link is up when trying to access downstream ports */
> +	if (bus->number != port->root_busno)
> +		if (!cpm_pcie_link_is_up(port))
> +			return false;

This check for the link being up is racy and should be removed.  The
link may go down after the check and before the config access.

A config access to a device where the link is down is an error, but
it's an error we expect to happen because of enumeration, surprise
unplug, or electrical issue.  It's impossible to avoid so we must be
able to handle and recover from it.

I know there are other drivers that do this (dwc, altera, xilinix-nwl,
xilinx), and I've pointed this out many times in the past.  This needs
to be fixed.

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

  struct device *dev = port->dev;

to reduce repetition of "port->dev" below.

> +	u32 val, mask, status, bit;
> +	unsigned long intr_val;
> +
> +	/* Read interrupt decode and mask registers */
> +	val = pcie_read(port, XILINX_CPM_PCIE_REG_IDR);
> +	mask = pcie_read(port, XILINX_CPM_PCIE_REG_IMR);
> +
> +	status = val & mask;
> +	if (!status)
> +		return IRQ_NONE;
> +
> +	if (status & XILINX_CPM_PCIE_INTR_LINK_DOWN)
> +		dev_warn(port->dev, "Link Down\n");
> +
> +	if (status & XILINX_CPM_PCIE_INTR_HOT_RESET)
> +		dev_info(port->dev, "Hot reset\n");
> ...

