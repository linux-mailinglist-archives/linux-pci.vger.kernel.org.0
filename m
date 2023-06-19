Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FDA77351E2
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jun 2023 12:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbjFSKUu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jun 2023 06:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjFSKUt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jun 2023 06:20:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D183698
        for <linux-pci@vger.kernel.org>; Mon, 19 Jun 2023 03:20:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66B0660A37
        for <linux-pci@vger.kernel.org>; Mon, 19 Jun 2023 10:20:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A24BC433C0;
        Mon, 19 Jun 2023 10:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687170046;
        bh=2D07gGDATS9E+8E2s5eIZqWDqDUa7PH9sWevS6mL1X4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BaKIzJNhVcurYkIAZwCk/WpUNFptpzFOigpBkHDo4KJquXAr/34IIyRgt8GfVeKZL
         ulGJCTWmyciesGFJIaJ6zWqYRf19bDcbMeTkRPtI9vAd8PvUl9OREk9/7IQNQTj597
         OQwxtHwIEuwPjqud7rtdavOMUEljCmgswslOUzkUh1HEpNgYCKFQa45cJv5UeU3M1l
         a/NZH+Qa4pYlZ+hRGh4T5Ex4bNaHJVhXEXE7oZY/h7dl9Qf+wVDGP933xAP1IRnxsn
         hM8VO35C1LrruPdiyYsnHpNHUK+6H80kcIrfLqHozRgi9x+HkuF/yxDnWwvHL9tjgN
         zNPeyqXaztcXw==
Date:   Mon, 19 Jun 2023 12:20:37 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     daire.mcnamara@microchip.com
Cc:     conor.dooley@microchip.com, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 7/8] PCI: microchip: Gather MSI information from
 hardware config registers
Message-ID: <ZJAr9Rvvn6MRrJz+@lpieralisi>
References: <20230614155556.4095526-1-daire.mcnamara@microchip.com>
 <20230614155556.4095526-8-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614155556.4095526-8-daire.mcnamara@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 14, 2023 at 04:55:55PM +0100, daire.mcnamara@microchip.com wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
> 
> The PCIe Root Complex on PolarFire SoC is configured at bitstream creation
> time using Libero.  Key MSI-related parameters include the number of
> MSIs (1/2/4/8/16/32) and the MSI address. In the device driver, extract
> this information from hw registers at init time, and use it to configure
> MSI system, including configuring MSI capability structure correctly in
> configuration space.
> 
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

This hunk is just code refactoring that has nothing to do AFAICS with
the commit log purpose, a patch must have a single logical purpose.

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

Mmm..see above. It is not clear to me what this patch does overall, for
certain it does more that what's stated in the commit log and this ought
to be fixed.

Lorenzo

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
