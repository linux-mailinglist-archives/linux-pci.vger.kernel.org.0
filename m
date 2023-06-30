Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483E074451B
	for <lists+linux-pci@lfdr.de>; Sat,  1 Jul 2023 01:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbjF3XT3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Jun 2023 19:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjF3XTR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jun 2023 19:19:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 452914683;
        Fri, 30 Jun 2023 16:18:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C1EEE61805;
        Fri, 30 Jun 2023 23:18:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A84C433C8;
        Fri, 30 Jun 2023 23:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688167115;
        bh=JKd3pcacA54AZ0fE+QcV56KctfOkUbfebcxzki2Xzw4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZMi4zhYmfvWJMdkvedanUYstuVE7V++h8+4bGqe8iRsO64USW/4d3yNZcbJWF4dFb
         iqTvVQKxd/hcW4amlQdMvCalBxakXpwsJTYx//KfXK+Ocq3HhdqzLAEEYyA/WYIIO9
         m3cUTjAbAJXwWJTR0npi8sxQCqDafIpDyT5YR4y6LnkTsWJGTejQg1k828QAQJx+xF
         YLnwfYb5OtgQJjbOcQXgbr+hQQtFhmaqz89WhtJPqc0oVV2rfVNBe+d6Ybj7rH73xa
         7quq7fo9yvPZswXaoXZA2zNn/lkZUWFjoQZtXWIaOEyaGkBTpKhMpv4g35BMDBquFB
         c2GoPvpi27qaQ==
Date:   Fri, 30 Jun 2023 18:18:32 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc:     krzysztof.kozlowski@linaro.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        linux-arm-kernel@lists.infradead.org, bharat.kumar.gogada@amd.com,
        michals@amd.com
Subject: Re: [PATCH V5 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
Message-ID: <20230630231832.GA496495@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628092812.1592644-4-thippeswamy.havalige@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 28, 2023 at 02:58:12PM +0530, Thippeswamy Havalige wrote:
> Add support for Xilinx XDMA Soft IP core as Root Port.
> ...

> |Reported-by: kernel test robot <lkp@intel.com>
> |Reported-by: Dan Carpenter <error27@gmail.com>
> |Closes: https://lore.kernel.org/r/202305261250.2cs1phTS-lkp@intel.com/

Remove these.  I mentioned this before:
https://lore.kernel.org/r/ZHd/7AaLaGyr1jNA@bhelgaas

> + * struct pl_dma_pcie - PCIe port information
> + * @dev: Device pointer
> + * @reg_base: IO Mapped Register Base
> + * @irq: Interrupt number
> + * @cfg: Holds mappings of config space window
> + * @phys_reg_base: Physical address of reg base
> + * @intx_domain: Legacy IRQ domain pointer
> + * @pldma_domain: PL DMA IRQ domain pointer
> + * @resources: Bus Resources
> + * @msi: MSI information
> + * @irq_misc: Legacy and error interrupt number
> + * @intx_irq: legacy interrupt number
> + * @lock: lock protecting shared register access

Capitalize the intx_irq and lock descriptions so they match the others.

"Legacy and error interrupt number" and "legacy interrupt number"
sound like they overlap -- "legacy interrupt number" is part of both.
Is that an error?

> +static bool xilinx_pl_dma_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
> +{
> +	struct pl_dma_pcie *port = bus->sysdata;
> +
> +	/* Check if link is up when trying to access downstream ports */
> +	if (!pci_is_root_bus(bus)) {
> +		/*
> +		 * If the link goes down after we check for link-up, we have a problem:
> +		 * if a PIO request is initiated while link-down, the whole controller
> +		 * hangs, and even after link comes up again, previous PIO requests
> +		 * won't work, and a reset of the whole PCIe controller is needed.
> +		 * Henceforth we need link-up check here to avoid sending PIO request
> +		 * when link is down.

Wrap this comment so it fits in 80 columns like the rest of the file.

I think the comment was added because I pointed out that this is racy.
Obviously the comment doesn't *fix* the race, and it actually doesn't
even describe the race.

Even with the xilinx_pl_dma_pcie_link_up() check, this is racy because
xilinx_pl_dma_pcie_link_up() may tell you the link is up, but the link
may go down before the driver attempts the config transaction.  THAT
is the race.

If the controller hangs in that situation, that's a hardware defect,
and from your comment, it sounds like it's unrecoverable.

> +		 */
> +		if (!xilinx_pl_dma_pcie_link_up(port))
> +			return false;

> +static int xilinx_pl_dma_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
> +				       irq_hw_number_t hwirq)

Wrap to fit in 80 columns like the rest of the file.

> +static struct irq_chip xilinx_msi_irq_chip = {
> +	.name = "pl_dma_pciepcie:msi",

Why does this name have two copies of "pcie" in it?  This driver has
four irq_chip structs; maybe the names could be more similar?

  xilinx_leg_irq_chip			INTx
  xilinx_msi_irq_chip			pl_dma_pciepcie:msi
  xilinx_irq_chip			Xilinx MSI
  xilinx_pl_dma_pcie_event_irq_chip	RC-Event

> +	/* Plug the INTx chained handler */
> +	irq_set_chained_handler_and_data(port->intx_irq,
> +					 xilinx_pl_dma_pcie_intx_flow, port);
> +
> +	/* Plug the main event chained handler */
> +	irq_set_chained_handler_and_data(port->irq,
> +					 xilinx_pl_dma_pcie_event_flow, port);

What's the reason for using chained IRQs?  Can this be done without
them?  I don't claim to understand all the issues here, but it seems
better to avoid chained IRQ handlers when possible:
https://lore.kernel.org/all/877csohcll.ffs@tglx/

> +	/*set the Bridge enable bit */

Space before "Set".  I mentioned this before at
https://lore.kernel.org/r/ZHd/7AaLaGyr1jNA@bhelgaas

> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	if (!res) {
> +		dev_err(dev, "missing \"reg\" property\n");

All your other error messages are capitalized.  Make this one match.

> +	bridge->ops = (struct pci_ops *)&xilinx_pl_dma_pcie_ops.pci_ops;

I don't think this cast is needed.

Bjorn
