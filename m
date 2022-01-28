Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02E5349FA6A
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 14:16:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbiA1NQp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jan 2022 08:16:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244161AbiA1NQp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jan 2022 08:16:45 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5F8C06173B;
        Fri, 28 Jan 2022 05:16:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7AE3A61CEF;
        Fri, 28 Jan 2022 13:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F537C340E0;
        Fri, 28 Jan 2022 13:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643375803;
        bh=SQGbdIxK2jXMet5rdSyqh9l7r2JgX1vxi9l2bra6+J0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IQC7jsJFCcqglJaiGUrf/nGx6UxlaWx8QeVpiWWmhIcMfDp/UmX47WVs6/JgHGNl5
         dqVTTy50gT8pr6myzyLmW/T+IfZMiUsc+bGMDEkqhh3KsLHRSf/OZMnRSGrT23PSvl
         KfA5JMF/ge8g10Jz9oKmPCRnahUVryOW2Qp7mFVHS8JPeLPjVazBZMUoxJpQoQCmZv
         HBS5eseNNjG8r8JDd/unTmfAcObsi0yPYT5XRdBu45TXI4QjiB4mzQzKFav7i9Wwec
         FIEKW5bcPy0mdwDeYdD+SLZvzu3ty1ROp981CWtD4Wt4PalPQJjwuw701Kiby9/Ug5
         IVJlj2iGCgopA==
Date:   Fri, 28 Jan 2022 07:16:42 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marc Zyngier <maz@kernel.org>
Cc:     daire.mcnamara@microchip.com, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, robh@kernel.org, linux-pci@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        david.abdurachmanov@gmail.com, cyril.jean@microchip.com
Subject: Re: [PATCH v21 3/4] PCI: microchip: Add host driver for Microchip
 PCIe controller
Message-ID: <20220128131642.GA200731@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmoc5gnb.wl-maz@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 28, 2022 at 09:55:04AM +0000, Marc Zyngier wrote:
> On Thu, 27 Jan 2022 20:20:00 +0000,
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Mon, Jan 25, 2021 at 04:29:33PM +0000, daire.mcnamara@microchip.com wrote:
> > > From: Daire McNamara <daire.mcnamara@microchip.com>
> > > 
> > > Add support for the Microchip PolarFire PCIe controller when
> > > configured in host (Root Complex) mode.
> > 
> > > +static void mc_handle_msi(struct irq_desc *desc)
> > > +{
> > > +	struct mc_port *port = irq_desc_get_handler_data(desc);
> > > +	struct device *dev = port->dev;
> > > +	struct mc_msi *msi = &port->msi;
> > > +	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> > > +	unsigned long status;
> > > +	u32 bit;
> > > +	u32 virq;
> > > +
> > > +	status = readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
> > > +	if (status & PM_MSI_INT_MSI_MASK) {
> > > +		status = readl_relaxed(bridge_base_addr + ISTATUS_MSI);
> > > +		for_each_set_bit(bit, &status, msi->num_vectors) {
> > > +			virq = irq_find_mapping(msi->dev_domain, bit);
> > > +			if (virq)
> > > +				generic_handle_irq(virq);
> 
> Wrong construct. Please use generic_handle_domain_irq().

I responded to this old posting because it was the most recent one
that included the code below.   This irq_find_mapping() bit has since
been updated:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/pcie-microchip-host.c?id=v5.17-rc1#n406

> > > +			else
> > > +				dev_err_ratelimited(dev, "bad MSI IRQ %d\n", bit);
> > > +		}
> > > +	}
> > > +}
> > > +
> > > +static void mc_msi_bottom_irq_ack(struct irq_data *data)
> > > +{
> > > +	struct mc_port *port = irq_data_get_irq_chip_data(data);
> > > +	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> > > +	u32 bitpos = data->hwirq;
> > > +	unsigned long status;
> > > +
> > > +	writel_relaxed(BIT(bitpos), bridge_base_addr + ISTATUS_MSI);
> > > +	status = readl_relaxed(bridge_base_addr + ISTATUS_MSI);
> > > +	if (!status)
> > > +		writel_relaxed(BIT(PM_MSI_INT_MSI_SHIFT), bridge_base_addr + ISTATUS_LOCAL);
> > 
> > This looks like it might be racy.  What happens if we read 0 from
> > ISTATUS_MSI, but a new MSI is latched before we write ISTATUS_LOCAL?
> 
> I agree, this looks really odd. The irq_ack callback is per interrupt,
> while this seems to deal with some global state. This cannot be right.
> 
> 	M.
> 
> -- 
> Without deviation from the norm, progress is not possible.
