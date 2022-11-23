Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF57636CDA
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 23:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbiKWWLg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 17:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiKWWLP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 17:11:15 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688E5134762;
        Wed, 23 Nov 2022 14:09:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D8B07CE27FF;
        Wed, 23 Nov 2022 22:09:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77468C433C1;
        Wed, 23 Nov 2022 22:09:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669241382;
        bh=RNQMCQJlao0O78KP1S5ZJEIcmbnaSDXpMdfAnkuD1dQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HlSic7OwrqRXFCwtUgfY6/1AFG/uzp6TRyqc/bScHhUtAtqW+/5YlS8ft929XhYDF
         fIlfPXff0RzTKsWqoOREG8UqjC+/L1H/dPpzw9b2lEeoeg1AYwArpKlXy2IZx0B5+B
         DASDM3ZZ6fsuuocHv6Mu1DzRJpTHTTgaZC8tz8n6XH8RY07yIrNoW/l0q2dG0Vdzee
         GHnagyX4Lk58jj2RYNxbBAo3f2is5Q/D2GZz/SxfosalAaWcHEOWT+hVVFp9wQb6FG
         M1Xc/HhpTAxS6x9oFMkpv8b6XuYPXCxZw+jXVflo8Nz1elYRV6SUDZRMmQj7ZG01Hf
         qFEXlVQdbSJvw==
Date:   Wed, 23 Nov 2022 22:09:36 +0000
From:   Conor Dooley <conor@kernel.org>
To:     daire.mcnamara@microchip.com
Cc:     conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, lpieralisi@kernel.org,
        kw@linux.com, bhelgaas@google.com, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 5/9] PCI: microchip: Gather MSI information from
 hardware config registers
Message-ID: <Y36aIJoIoMDe+KZV@spud>
References: <20221116135504.258687-1-daire.mcnamara@microchip.com>
 <20221116135504.258687-6-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116135504.258687-6-daire.mcnamara@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 01:55:00PM +0000, daire.mcnamara@microchip.com wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
> 
> The PCIe root complex on PolarFire SoC is configured at bitstream creation
> time using Libero.  Key MSI-related parameters include the number of
> MSIs (1/2/4/8/16/32) and the MSI address. In the device driver, extract
> this information from hw registers at init time, and use it to configure

I don't know the answer here, so I am not being difficult:
Does the HSS program them in based on the XML produced alongside the
bitstream, or is that information encoded in the bitstream itself?

> MSI system, including configuring MSI capability structure correctly in
> configuration space.
> 
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/pci/controller/pcie-microchip-host.c | 73 +++++++++++---------
>  1 file changed, 40 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
> index ecd4d3f3e3d4..faecf419ad6f 100644
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
> @@ -156,8 +159,6 @@
>  
>  /* PCIe Config space MSI capability structure */
>  #define MC_MSI_CAP_CTRL_OFFSET			0xe0u
> -#define  MC_MSI_MAX_Q_AVAIL			(MC_NUM_MSI_IRQS_CODED << 1)
> -#define  MC_MSI_Q_SIZE				(MC_NUM_MSI_IRQS_CODED << 4)
>  
>  /* Events */
>  #define EVENT_PCIE_L2_EXIT			0
> @@ -257,7 +258,7 @@ struct mc_msi {
>  	struct irq_domain *dev_domain;
>  	u32 num_vectors;
>  	u64 vector_phy;
> -	DECLARE_BITMAP(used, MC_NUM_MSI_IRQS);
> +	DECLARE_BITMAP(used, MC_MAX_NUM_MSI_IRQS);
>  };
>  
>  struct mc_pcie {
> @@ -380,25 +381,29 @@ static struct {
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
> +	/* fixup msi enable flag */
> +	reg = readw_relaxed(ecam + MC_MSI_CAP_CTRL_OFFSET + PCI_MSI_FLAGS);
> +	reg |= PCI_MSI_FLAGS_ENABLE;
> +	writew_relaxed(reg, ecam + MC_MSI_CAP_CTRL_OFFSET + PCI_MSI_FLAGS);
> +
> +	/* fixup msi queue flags */
> +	queue_size = reg & PCI_MSI_FLAGS_QMASK;
> +	queue_size >>= 1;
> +	reg &= ~PCI_MSI_FLAGS_QSIZE;
> +	reg |= queue_size << 4;

Could you please explain where the >> 1 & << 4 come from? Maybe it's
sufficient to just make them defines, or the comment here could be
expanded on.

> +	writew_relaxed(reg, ecam + MC_MSI_CAP_CTRL_OFFSET + PCI_MSI_FLAGS);
> +
> +	/* fixup msi addr fields */
>  	writel_relaxed(lower_32_bits(msi->vector_phy),
> -		       base + cap_offset + PCI_MSI_ADDRESS_LO);
> +		       ecam + MC_MSI_CAP_CTRL_OFFSET + PCI_MSI_ADDRESS_LO);
>  	writel_relaxed(upper_32_bits(msi->vector_phy),
> -		       base + cap_offset + PCI_MSI_ADDRESS_HI);
> +		       ecam + MC_MSI_CAP_CTRL_OFFSET + PCI_MSI_ADDRESS_HI);
>  }
>  
>  static void mc_handle_msi(struct irq_desc *desc)
> @@ -471,10 +476,7 @@ static int mc_irq_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
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
> @@ -488,11 +490,6 @@ static int mc_irq_msi_domain_alloc(struct irq_domain *domain, unsigned int virq,
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
> @@ -1102,6 +1099,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
>  	void __iomem *bridge_base_addr;
>  	void __iomem *ctrl_base_addr;
>  	int ret;
> +	u32 val;
>  
>  	port = devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
>  	if (!port)
> @@ -1123,11 +1121,20 @@ static int mc_platform_init(struct pci_config_window *cfg)
>  	bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
>  	ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
>  
> -	port->msi.vector_phy = MSI_ADDR;
> -	port->msi.num_vectors = MC_NUM_MSI_IRQS;
> +	/* allow enabling msi by disabling msi-x */
> +	val = readl(bridge_base_addr + PCIE_PCI_IRQ_DW0);
> +	val &= ~MSIX_CAP_MASK;
> +	writel(val, bridge_base_addr + PCIE_PCI_IRQ_DW0);
> +
> +	/* pick num vectors from design */
> +	val = readl(bridge_base_addr + PCIE_PCI_IRQ_DW0);
> +	val &= NUM_MSI_MSGS_MASK;
> +	val >>= NUM_MSI_MSGS_SHIFT;
> +
> +	port->msi.num_vectors = 1 << val;
>  
> -	/* Hardware doesn't setup MSI by default */
> -	mc_pcie_enable_msi(port, cfg->win);
> +	/* pick vector address from design */

"Design" might make sense to you or I, but I think you could expand this
comment for the lay reader. Copy-paste from the commit message maybe
hah.

Anyways, as with the rest of the series - I'm just nitpicking.
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

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
