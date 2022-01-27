Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 024E449EC62
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jan 2022 21:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbiA0UUG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jan 2022 15:20:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231500AbiA0UUG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 Jan 2022 15:20:06 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FA5C061714;
        Thu, 27 Jan 2022 12:20:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C618ACE23A2;
        Thu, 27 Jan 2022 20:20:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A35C340E4;
        Thu, 27 Jan 2022 20:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643314802;
        bh=jDCjWf6ypNkZuEAsY8LECbP+oIMiPmm168NFCgdTwdU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=swjQYcxVFKi+qB+DFCRTI3l90xXZImd1+2M38FGFoDftL6dEzYwvhKMYtRsvIVvYG
         qmfbb3TA2FICfTtXet/28HRamaXKwqZAtFYF0cUmqgND5G2R5Qh+H8GRX9jvLB3P/8
         Tz8W2zQjCOHIwpmtZKkTPtGx40jAiqGBRfjr7bQNuq82V0sAYI7akEtqI9hYDAInB0
         vk2C+K+ZUdzLnCbE5WwVgTXkXvQKaVJMVsJydnQOTrsVjto36RwGbrvGhMhX8nK86h
         8zDFyR754IPm+VyF9bODM7QKOAbWNV7irJFfLQy/B9yg28je950rdM6bJtSd2+megp
         6mvbCXV2uB4cA==
Date:   Thu, 27 Jan 2022 14:20:00 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     daire.mcnamara@microchip.com
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com, robh@kernel.org,
        linux-pci@vger.kernel.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, david.abdurachmanov@gmail.com,
        cyril.jean@microchip.com, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v21 3/4] PCI: microchip: Add host driver for Microchip
 PCIe controller
Message-ID: <20220127202000.GA126335@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210125162934.5335-4-daire.mcnamara@microchip.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Marc]

On Mon, Jan 25, 2021 at 04:29:33PM +0000, daire.mcnamara@microchip.com wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
> 
> Add support for the Microchip PolarFire PCIe controller when
> configured in host (Root Complex) mode.

> +static void mc_handle_msi(struct irq_desc *desc)
> +{
> +	struct mc_port *port = irq_desc_get_handler_data(desc);
> +	struct device *dev = port->dev;
> +	struct mc_msi *msi = &port->msi;
> +	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> +	unsigned long status;
> +	u32 bit;
> +	u32 virq;
> +
> +	status = readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
> +	if (status & PM_MSI_INT_MSI_MASK) {
> +		status = readl_relaxed(bridge_base_addr + ISTATUS_MSI);
> +		for_each_set_bit(bit, &status, msi->num_vectors) {
> +			virq = irq_find_mapping(msi->dev_domain, bit);
> +			if (virq)
> +				generic_handle_irq(virq);
> +			else
> +				dev_err_ratelimited(dev, "bad MSI IRQ %d\n", bit);
> +		}
> +	}
> +}
> +
> +static void mc_msi_bottom_irq_ack(struct irq_data *data)
> +{
> +	struct mc_port *port = irq_data_get_irq_chip_data(data);
> +	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> +	u32 bitpos = data->hwirq;
> +	unsigned long status;
> +
> +	writel_relaxed(BIT(bitpos), bridge_base_addr + ISTATUS_MSI);
> +	status = readl_relaxed(bridge_base_addr + ISTATUS_MSI);
> +	if (!status)
> +		writel_relaxed(BIT(PM_MSI_INT_MSI_SHIFT), bridge_base_addr + ISTATUS_LOCAL);

This looks like it might be racy.  What happens if we read 0 from
ISTATUS_MSI, but a new MSI is latched before we write ISTATUS_LOCAL?

Will mc_handle_msi() be called?  If so, will PM_MSI_INT_MSI_MASK be
set in the value it reads from ISTATUS_LOCAL?

Current code at:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pcie-microchip-host.c?id=v5.17-rc1#n406
