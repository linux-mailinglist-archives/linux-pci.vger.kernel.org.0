Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFA12CE053
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 22:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgLCVIb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 16:08:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:57882 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbgLCVIb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Dec 2020 16:08:31 -0500
Date:   Thu, 3 Dec 2020 15:07:48 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607029670;
        bh=i/K4qM6rvvoGU+gBFZ6aU74Om1t2vhb7uve+DvEcHFM=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=P4ii/Gh6+neVmY9/6q+ywj+sJXBvga2TXFhv/k2ezogat6CHP60YWzHGnJCgFYJaA
         Y1bIkDpSPTOHrZMN4C6hAFjQXDu9CRa328QDpsDyiaJ9ROMbENmGiIIq6Xfsjuq8EH
         ekfLHG0ZAqMcyhUPoEdGssSEJFbMh79bB6TWmsBndAMxSCPPX6mYOIueVasrU0FQWM
         M4bod0AA1EmDE/D4BJigwemql0SFZl9xjis8yrfr6rjXILJ1PfXJxnFl7uW9Zs7h/i
         kDlHgm/S2yfcLSGtloXXdzxYLAPUnAf+6zKcVHlsR4dtPPf82+15Dm2qzlGeV2Ubpa
         KEz6SWqwDJb8g==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     daire.mcnamara@microchip.com
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh@kernel.org,
        linux-pci@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, david.abdurachmanov@gmail.com,
        cyril.jean@microchip.com, ben.dooks@codethink.co.uk
Subject: Re: [PATCH v18 3/4] PCI: microchip: Add host driver for Microchip
 PCIe controller
Message-ID: <20201203210748.GA1594918@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203121018.16432-4-daire.mcnamara@microchip.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 03, 2020 at 12:10:17PM +0000, daire.mcnamara@microchip.com wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
> 
> Add support for the Microchip PolarFire PCIe controller when
> configured in host (Root Complex) mode.
> 
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

> +static void mc_pcie_isr(struct irq_desc *desc)
> +{
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
> +	struct mc_port *port = irq_desc_get_handler_data(desc);
> +	struct device *dev = port->dev;
> +	struct mc_msi *msi = &port->msi;
> +	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE1_BRIDGE_ADDR;
> +	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE1_CTRL_ADDR;
> +	u32 status;
> +	unsigned long intx_status;
> +	unsigned long msi_status;
> +	u32 bit;
> +	u32 virq;
> +
> +	/*
> +	 * The core provides a single interrupt for both INTx/MSI messages.
> +	 * So we'll read both INTx and MSI status.
> +	 */
> +	chained_irq_enter(chip, desc);
> +
> +	status = readl_relaxed(ctrl_base_addr + MC_SEC_ERROR_INT);

Other than a few in mc_setup_window(), it looks like all the accesses
in this driver are relaxed.

readl_relaxed() and writel_relaxed() are only used by a few of the
host bridge drivers.  I doubt this is because those devices behave
differently than all the rest, so I suspect there's a general rule
that they all should use.  I don't know what that rule is, but maybe
you do?

Per Documentation/memory-barriers.txt, the relaxed versions provide
weaker ordering guarantees, so the safest thing would be to use the
non-relaxed versions and include a little justification for when/why
it is safe to use the relaxed versions.

A lot of uses are in non-performance paths where there's really no
benefit to using the relaxed versions.

Not asking you to do anything here, but in case you've analyzed this
and come to the conclusion that the relaxed versions are safe here,
but not in mc_setup_window(), that rationale might be useful to others
if you included it in the commit log or a brief comment in the code.

> +static void mc_setup_window(void __iomem *bridge_base_addr, u32 index, phys_addr_t axi_addr,
> +			    phys_addr_t pci_addr, size_t size)
> +{
> +	u32 atr_sz = ilog2(size) - 1;
> +	u32 val;
> +
> +	if (index == 0)
> +		val = PCIE_CONFIG_INTERFACE;
> +	else
> +		val = PCIE_TX_RX_INTERFACE;
> +
> +	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) + MC_ATR0_AXI4_SLV0_TRSL_PARAM);
> ...
