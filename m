Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2180523359
	for <lists+linux-pci@lfdr.de>; Wed, 11 May 2022 14:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbiEKMtk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 08:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237096AbiEKMti (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 08:49:38 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9969EA6222
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 05:49:35 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80FFBED1;
        Wed, 11 May 2022 05:49:35 -0700 (PDT)
Received: from lpieralisi (unknown [10.57.1.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0FAA93F66F;
        Wed, 11 May 2022 05:49:33 -0700 (PDT)
Date:   Wed, 11 May 2022 13:49:30 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     helgaas@kernel.org, Daire.McNamara@microchip.com,
        bhelgaas@google.com, Cyril.Jean@microchip.com,
        david.abdurachmanov@gmail.com, linux-pci@vger.kernel.org,
        maz@kernel.org, robh@kernel.org
Subject: Re: [PATCH] PCI: microchip: add missing chained_irq enter/exit calls
Message-ID: <Ynuw2jiLB7+ZSd3z@lpieralisi>
References: <20220511095504.2273799-1-conor.dooley@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511095504.2273799-1-conor.dooley@microchip.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

"PCI: microchip: Add missing chained_irq_enter()/exit() calls"

Always capitalize the first word in the commit subject sentence
and add brackets to functions calls.

On Wed, May 11, 2022 at 10:55:05AM +0100, Conor Dooley wrote:
> Bjorn spotted that two of the chained irq handlers were missing their

It is clear in the Link/reported-by that Bjorn spotted it, it is a nit
but I'd prefer the commit log to just explain what you are fixing
rather than telling the background story that is already there in
the Link: provided.

I can make these changes for you, just let me know.

Thanks,
Lorenzo

> chained_irq_enter()/chained_irq_exit() calls, so add them in to avoid
> potentially lost interrupts.
> 
> Reported by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://lore.kernel.org/linux-pci/87h76b8nxc.wl-maz@kernel.org
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/pci/controller/pcie-microchip-host.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
> index 29d8e81e4181..8175abed0f05 100644
> --- a/drivers/pci/controller/pcie-microchip-host.c
> +++ b/drivers/pci/controller/pcie-microchip-host.c
> @@ -406,6 +406,7 @@ static void mc_pcie_enable_msi(struct mc_pcie *port, void __iomem *base)
>  static void mc_handle_msi(struct irq_desc *desc)
>  {
>  	struct mc_pcie *port = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>  	struct device *dev = port->dev;
>  	struct mc_msi *msi = &port->msi;
>  	void __iomem *bridge_base_addr =
> @@ -414,6 +415,8 @@ static void mc_handle_msi(struct irq_desc *desc)
>  	u32 bit;
>  	int ret;
>  
> +	chained_irq_enter(chip, desc);
> +
>  	status = readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
>  	if (status & PM_MSI_INT_MSI_MASK) {
>  		status = readl_relaxed(bridge_base_addr + ISTATUS_MSI);
> @@ -424,6 +427,8 @@ static void mc_handle_msi(struct irq_desc *desc)
>  						    bit);
>  		}
>  	}
> +
> +	chained_irq_exit(chip, desc);
>  }
>  
>  static void mc_msi_bottom_irq_ack(struct irq_data *data)
> @@ -563,6 +568,7 @@ static int mc_allocate_msi_domains(struct mc_pcie *port)
>  static void mc_handle_intx(struct irq_desc *desc)
>  {
>  	struct mc_pcie *port = irq_desc_get_handler_data(desc);
> +	struct irq_chip *chip = irq_desc_get_chip(desc);
>  	struct device *dev = port->dev;
>  	void __iomem *bridge_base_addr =
>  		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> @@ -570,6 +576,8 @@ static void mc_handle_intx(struct irq_desc *desc)
>  	u32 bit;
>  	int ret;
>  
> +	chained_irq_enter(chip, desc);
> +
>  	status = readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
>  	if (status & PM_MSI_INT_INTX_MASK) {
>  		status &= PM_MSI_INT_INTX_MASK;
> @@ -581,6 +589,8 @@ static void mc_handle_intx(struct irq_desc *desc)
>  						    bit);
>  		}
>  	}
> +
> +	chained_irq_exit(chip, desc);
>  }
>  
>  static void mc_ack_intx_irq(struct irq_data *data)
> -- 
> 2.36.1
> 
