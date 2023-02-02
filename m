Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 770C5687C8D
	for <lists+linux-pci@lfdr.de>; Thu,  2 Feb 2023 12:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjBBLpm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Feb 2023 06:45:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjBBLpk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Feb 2023 06:45:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A1E87165;
        Thu,  2 Feb 2023 03:45:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94E35B82400;
        Thu,  2 Feb 2023 11:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B7CBC433D2;
        Thu,  2 Feb 2023 11:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675338336;
        bh=m87/DE9fpIUi8cZc8zFaS3+uraBQbfVmUU3Jv/n9q3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rPxSt+Dqpis7qHMsDQaD7dOjyTgkbczeo3rPxrPIgpnJn9uFmqhF7tU8uAoV0ErJg
         /hWdiHl4mQ1Hky+a1k4ewQdPm6vyXE7Ogpq0YDrd49UGrQgRRTzcSsDzBH6LF3yeeN
         81eNtVruaN7b5vmLqcUGmR4Xt2qcGAiyS6ALtyvUxmFlDnA/WQNosMdDwIzPpMUUvb
         FjMFxKK6bgK2X8llRTBuT6AmMO1+fKi5WBxU4U0/j657SwwIqXp9z+tdJs91ZgQ31X
         xSzynawvGJGgHspKSV+2C17zggK3ACwLpy+wYAHRkjs5I/btP1kaf+Z1TwnHKJ3Vgb
         4TdTITgnhs+cA==
Date:   Thu, 2 Feb 2023 12:45:30 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     daire.mcnamara@microchip.com
Cc:     conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, kw@linux.com,
        bhelgaas@google.com, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3 07/11] PCI: microchip: Gather MSI information from
 hardware config registers
Message-ID: <Y9uiWscjKQpD7JvE@lpieralisi>
References: <20230111125323.1911373-1-daire.mcnamara@microchip.com>
 <20230111125323.1911373-8-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111125323.1911373-8-daire.mcnamara@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 11, 2023 at 12:53:19PM +0000, daire.mcnamara@microchip.com wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
> 
> The PCIe Root Complex on PolarFire SoC is configured at bitstream creation
> time using Libero.  Key MSI-related parameters include the number of
> MSIs (1/2/4/8/16/32) and the MSI address. In the device driver, extract
> this information from hw registers at init time, and use it to configure
> MSI system, including configuring MSI capability structure correctly in
> configuration space.

I don't understand whether this is backward compatible with all existing
host controllers in the field. I assume MSI parameters can always been
probed and that has been always the case for all controllers supported
based on this design, please confirm before I proceed with the review.

Thanks,
Lorenzo

> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/pci/controller/pcie-microchip-host.c | 73 +++++++++++---------
>  1 file changed, 40 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
> index 751f0243deb4..9ff0fb04b953 100644
> --- a/drivers/pci/controller/pcie-microchip-host.c
> +++ b/drivers/pci/controller/pcie-microchip-host.c
> @@ -20,8 +20,7 @@
>  #include "../pci.h"
>  
>  /* Number of MSI IRQs */
> -#define MC_NUM_MSI_IRQS				32
> -#define MC_NUM_MSI_IRQS_CODED			5
> +#define MC_MAX_NUM_MSI_IRQS			32
>  
>  /* PCIe Bridge Phy and Controller Phy offsets */
>  #define MC_PCIE1_BRIDGE_ADDR			0x00008000u
> @@ -31,6 +30,11 @@
>  #define MC_PCIE_CTRL_ADDR			(MC_PCIE1_CTRL_ADDR)
>  
>  /* PCIe Bridge Phy Regs */
> +#define PCIE_PCI_IRQ_DW0			0xa8
> +#define  MSIX_CAP_MASK				BIT(31)
> +#define  NUM_MSI_MSGS_MASK			GENMASK(6, 4)
> +#define  NUM_MSI_MSGS_SHIFT			4
> +
>  #define IMASK_LOCAL				0x180
>  #define  DMA_END_ENGINE_0_MASK			0x00000000u
>  #define  DMA_END_ENGINE_0_SHIFT			0
> @@ -79,7 +83,6 @@
>  #define IMASK_HOST				0x188
>  #define ISTATUS_HOST				0x18c
>  #define IMSI_ADDR				0x190
> -#define  MSI_ADDR				0x190
>  #define ISTATUS_MSI				0x194
>  
>  /* PCIe Master table init defines */
> @@ -158,8 +161,6 @@
>  
>  /* PCIe Config space MSI capability structure */
>  #define MC_MSI_CAP_CTRL_OFFSET			0xe0u
> -#define  MC_MSI_MAX_Q_AVAIL			(MC_NUM_MSI_IRQS_CODED << 1)
> -#define  MC_MSI_Q_SIZE				(MC_NUM_MSI_IRQS_CODED << 4)
>  
>  /* Events */
>  #define EVENT_PCIE_L2_EXIT			0
> @@ -259,7 +260,7 @@ struct mc_msi {
>  	struct irq_domain *dev_domain;
>  	u32 num_vectors;
>  	u64 vector_phy;
> -	DECLARE_BITMAP(used, MC_NUM_MSI_IRQS);
> +	DECLARE_BITMAP(used, MC_MAX_NUM_MSI_IRQS);
>  };
>  
>  struct mc_pcie {
> @@ -382,25 +383,29 @@ static struct {
>  
>  static char poss_clks[][5] = { "fic0", "fic1", "fic2", "fic3" };
>  
> -static void mc_pcie_enable_msi(struct mc_pcie *port, void __iomem *base)
> +static void mc_pcie_fixup_ecam(struct mc_pcie *port, void __iomem *ecam)
>  {
>  	struct mc_msi *msi = &port->msi;
> -	u32 cap_offset = MC_MSI_CAP_CTRL_OFFSET;
> -	u16 msg_ctrl = readw_relaxed(base + cap_offset + PCI_MSI_FLAGS);
> -
> -	msg_ctrl |= PCI_MSI_FLAGS_ENABLE;
> -	msg_ctrl &= ~PCI_MSI_FLAGS_QMASK;
> -	msg_ctrl |= MC_MSI_MAX_Q_AVAIL;
> -	msg_ctrl &= ~PCI_MSI_FLAGS_QSIZE;
> -	msg_ctrl |= MC_MSI_Q_SIZE;
> -	msg_ctrl |= PCI_MSI_FLAGS_64BIT;
> -
> -	writew_relaxed(msg_ctrl, base + cap_offset + PCI_MSI_FLAGS);
> -
> +	u16 reg;
> +	u8 queue_size;
> +
> +	/* Fixup MSI enable flag */
> +	reg = readw_relaxed(ecam + MC_MSI_CAP_CTRL_OFFSET + PCI_MSI_FLAGS);
> +	reg |= PCI_MSI_FLAGS_ENABLE;
> +	writew_relaxed(reg, ecam + MC_MSI_CAP_CTRL_OFFSET + PCI_MSI_FLAGS);
> +
> +	/* Fixup PCI MSI queue flags */
> +	queue_size = reg & PCI_MSI_FLAGS_QMASK;
> +	queue_size >>= 1;
> +	reg &= ~PCI_MSI_FLAGS_QSIZE;
> +	reg |= queue_size << 4;
> +	writew_relaxed(reg, ecam + MC_MSI_CAP_CTRL_OFFSET + PCI_MSI_FLAGS);
> +
> +	/* Fixup MSI addr fields */
>  	writel_relaxed(lower_32_bits(msi->vector_phy),
> -		       base + cap_offset + PCI_MSI_ADDRESS_LO);
> +		       ecam + MC_MSI_CAP_CTRL_OFFSET + PCI_MSI_ADDRESS_LO);
>  	writel_relaxed(upper_32_bits(msi->vector_phy),
> -		       base + cap_offset + PCI_MSI_ADDRESS_HI);
> +		       ecam + MC_MSI_CAP_CTRL_OFFSET + PCI_MSI_ADDRESS_HI);
>  }
>  
>  static void mc_handle_msi(struct irq_desc *desc)
> @@ -473,10 +478,7 @@ static int mc_irq_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  {
>  	struct mc_pcie *port = domain->host_data;
>  	struct mc_msi *msi = &port->msi;
> -	void __iomem *bridge_base_addr =
> -		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
>  	unsigned long bit;
> -	u32 val;
>  
>  	mutex_lock(&msi->lock);
>  	bit = find_first_zero_bit(msi->used, msi->num_vectors);
> @@ -490,11 +492,6 @@ static int mc_irq_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
>  	irq_domain_set_info(domain, virq, bit, &mc_msi_bottom_irq_chip,
>  			    domain->host_data, handle_edge_irq, NULL, NULL);
>  
> -	/* Enable MSI interrupts */
> -	val = readl_relaxed(bridge_base_addr + IMASK_LOCAL);
> -	val |= PM_MSI_INT_MSI_MASK;
> -	writel_relaxed(val, bridge_base_addr + IMASK_LOCAL);
> -
>  	mutex_unlock(&msi->lock);
>  
>  	return 0;
> @@ -1117,6 +1114,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
>  	struct mc_pcie *port;
>  	void __iomem *bridge_base_addr;
>  	int ret;
> +	u32 val;
>  
>  	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
>  	if (!port)
> @@ -1137,11 +1135,20 @@ static int mc_platform_init(struct pci_config_window *cfg)
>  
>  	bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
>  
> -	port->msi.vector_phy = MSI_ADDR;
> -	port->msi.num_vectors = MC_NUM_MSI_IRQS;
> +	/* Allow enabling MSI by disabling MSI-X */
> +	val = readl(bridge_base_addr + PCIE_PCI_IRQ_DW0);
> +	val &= ~MSIX_CAP_MASK;
> +	writel(val, bridge_base_addr + PCIE_PCI_IRQ_DW0);
> +
> +	/* Pick num vectors from bitfile programmed onto FPGA fabric */
> +	val = readl(bridge_base_addr + PCIE_PCI_IRQ_DW0);
> +	val &= NUM_MSI_MSGS_MASK;
> +	val >>= NUM_MSI_MSGS_SHIFT;
> +
> +	port->msi.num_vectors = 1 << val;
>  
> -	/* Hardware doesn't setup MSI by default */
> -	mc_pcie_enable_msi(port, cfg->win);
> +	/* Pick vector address from design */
> +	port->msi.vector_phy = readl_relaxed(bridge_base_addr + IMSI_ADDR);
>  
>  	/* Configure Address Translation Table 0 for PCIe config space */
>  	mc_pcie_setup_window(bridge_base_addr, 0, cfg->res.start & 0xffffffff,
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
