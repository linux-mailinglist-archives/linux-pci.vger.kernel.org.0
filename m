Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C52687C36
	for <lists+linux-pci@lfdr.de>; Thu,  2 Feb 2023 12:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231761AbjBBL3C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Feb 2023 06:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbjBBL24 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Feb 2023 06:28:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE8B18A85;
        Thu,  2 Feb 2023 03:28:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11AA3B825A2;
        Thu,  2 Feb 2023 11:28:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AF0C4339B;
        Thu,  2 Feb 2023 11:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675337331;
        bh=OMK+KW7ja98XObBSQHTKdHZe0TjDr1ywfYDnF4/2O7Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=F5ILH1TYNDY0t/rZ7LAC4KuEvySrne5Pj94z1Me/o/ek6VYHEENMD/jF1or7rTJe2
         uY1tw/Q306zWhStSXlsFirIAss7Ra6G6sxI6YSl5pyUQkV6PpT8MouT317RL2XRwwq
         1VsSyyEOXq72lbHDwssBuT5nepFjWWo6DXwFZrJPgv7ITIGGcjv0dTi5YK2Ct/SfcU
         itWoV2DcKTWuW72s5EKI21VPdz+JC8Fjod79fMkechr3+yWcPBAlsP0kPOYxVksknt
         oUXeWBMW2U0NdMh17dfoquO9MQgeXcVpAhKIUBb8ZbxMAo2X6YCYZqyAWGResv0kXi
         qtpBUvaoierJw==
Date:   Thu, 2 Feb 2023 12:28:45 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     daire.mcnamara@microchip.com
Cc:     conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, kw@linux.com,
        bhelgaas@google.com, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        robin.murphy@arm.com
Subject: Re: [PATCH v3 09/11] PCI: microchip: Partition outbound address
 translation
Message-ID: <Y9uebWEvuJYO31j1@lpieralisi>
References: <20230111125323.1911373-1-daire.mcnamara@microchip.com>
 <20230111125323.1911373-10-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111125323.1911373-10-daire.mcnamara@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+CC Robin]

On Wed, Jan 11, 2023 at 12:53:21PM +0000, daire.mcnamara@microchip.com wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
> 
> On Microchip PolarFire SoC the PCIe Root Port is behind a set of Fabric
> Interface Controller (FIC) buses that encapsulate buses like ABP/AHP and
> AXI-M. Depending on which FIC(s) the Root Port is wired through to cpu
> space, the Root Port driver needs to take account of the address
> translation done by a parent (e.g. fabric) node before setting up its
> own outbound address translation tables to config space and attached
> devices.
> 
> Parse the range properties to determine how much address translation
> needs to be done in the Root Port.

This requires some vetting from RobH/Robin to make sure we are using
generic DT concepts (ie "ranges" property) the right way.

Lorenzo

> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/pci/controller/pcie-microchip-host.c | 109 +++++++++++++++----
>  1 file changed, 86 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
> index c55911c48ec6..f3dfcdf39c8a 100644
> --- a/drivers/pci/controller/pcie-microchip-host.c
> +++ b/drivers/pci/controller/pcie-microchip-host.c
> @@ -85,27 +85,42 @@
>  #define IMSI_ADDR				0x190
>  #define ISTATUS_MSI				0x194
>  
> +#define ATR_WINDOW_DESC_SIZE			32
> +#define ATR_PCIE_ATR_SIZE			0x25
> +#define ATR_SIZE_SHIFT				1
> +#define ATR_IMPL_ENABLE				1
> +
>  /* PCIe Master table init defines */
>  #define ATR0_PCIE_WIN0_SRCADDR_PARAM		0x600u
> -#define  ATR0_PCIE_ATR_SIZE			0x25
> -#define  ATR0_PCIE_ATR_SIZE_SHIFT		1
>  #define ATR0_PCIE_WIN0_SRC_ADDR			0x604u
>  #define ATR0_PCIE_WIN0_TRSL_ADDR_LSB		0x608u
>  #define ATR0_PCIE_WIN0_TRSL_ADDR_UDW		0x60cu
>  #define ATR0_PCIE_WIN0_TRSL_PARAM		0x610u
>  
> +enum {
> +	TRSL_ID_PCIE_TXRX,
> +	TRSL_ID_PCIE_CONFIG,
> +	TRSL_ID_AXI4_LITE_MASTER,
> +	TRSL_ID_AXI4_MASTER_0 = 4,
> +	TRSL_ID_AXI4_MASTER_1,
> +	TRSL_ID_AXI4_MASTER_2,
> +	TRSL_ID_AXI4_MASTER_3,
> +	TRSL_ID_AXI4_STREAM_0,
> +	TRSL_ID_AXI4_STREAM_1,
> +	TRSL_ID_AXI4_STREAM_2,
> +	TRSL_ID_AXI4_STREAM_3,
> +	TRSL_ID_INTERNAL_BRIDGE_REGISTERS
> +};
> +
> +#define ATR0_PCIE_WIN0_TRSL_MASK_LSB		0x618u
> +#define ATR0_PCIE_WIN0_TRSL_MASK_UDW		0x61cu
> +
>  /* PCIe AXI slave table init defines */
>  #define ATR0_AXI4_SLV0_SRCADDR_PARAM		0x800u
> -#define  ATR_SIZE_SHIFT				1
> -#define  ATR_IMPL_ENABLE			1
>  #define ATR0_AXI4_SLV0_SRC_ADDR			0x804u
>  #define ATR0_AXI4_SLV0_TRSL_ADDR_LSB		0x808u
>  #define ATR0_AXI4_SLV0_TRSL_ADDR_UDW		0x80cu
>  #define ATR0_AXI4_SLV0_TRSL_PARAM		0x810u
> -#define  PCIE_TX_RX_INTERFACE			0x00000000u
> -#define  PCIE_CONFIG_INTERFACE			0x00000001u
> -
> -#define ATR_ENTRY_SIZE				32
>  
>  /* PCIe Controller Phy Regs */
>  #define SEC_ERROR_EVENT_CNT			0x20
> @@ -270,6 +285,7 @@ struct mc_pcie {
>  	struct irq_domain *event_domain;
>  	raw_spinlock_t lock;
>  	struct mc_msi msi;
> +	u64 outbound_range_offset;
>  };
>  
>  struct cause {
> @@ -936,36 +952,36 @@ static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
>  				 phys_addr_t axi_addr, phys_addr_t pci_addr,
>  				 size_t size)
>  {
> -	u32 atr_sz = ilog2(size) - 1;
> +	u32 atr_size = ilog2(size) - 1;
>  	u32 val;
>  
>  	if (index == 0)
> -		val = PCIE_CONFIG_INTERFACE;
> +		val = TRSL_ID_PCIE_CONFIG;
>  	else
> -		val = PCIE_TX_RX_INTERFACE;
> +		val = TRSL_ID_PCIE_TXRX;
>  
> -	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
> +	writel(val, bridge_base_addr + (index * ATR_WINDOW_DESC_SIZE) +
>  	       ATR0_AXI4_SLV0_TRSL_PARAM);
>  
> -	val = lower_32_bits(axi_addr) | (atr_sz << ATR_SIZE_SHIFT) |
> +	val = lower_32_bits(axi_addr) | (atr_size << ATR_SIZE_SHIFT) |
>  			    ATR_IMPL_ENABLE;
> -	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
> +	writel(val, bridge_base_addr + (index * ATR_WINDOW_DESC_SIZE) +
>  	       ATR0_AXI4_SLV0_SRCADDR_PARAM);
>  
>  	val = upper_32_bits(axi_addr);
> -	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
> +	writel(val, bridge_base_addr + (index * ATR_WINDOW_DESC_SIZE) +
>  	       ATR0_AXI4_SLV0_SRC_ADDR);
>  
>  	val = lower_32_bits(pci_addr);
> -	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
> +	writel(val, bridge_base_addr + (index * ATR_WINDOW_DESC_SIZE) +
>  	       ATR0_AXI4_SLV0_TRSL_ADDR_LSB);
>  
>  	val = upper_32_bits(pci_addr);
> -	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
> +	writel(val, bridge_base_addr + (index * ATR_WINDOW_DESC_SIZE) +
>  	       ATR0_AXI4_SLV0_TRSL_ADDR_UDW);
>  
>  	val = readl(bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
> -	val |= (ATR0_PCIE_ATR_SIZE << ATR0_PCIE_ATR_SIZE_SHIFT);
> +	val |= (ATR_PCIE_ATR_SIZE << ATR_SIZE_SHIFT);
>  	writel(val, bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
>  	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);
>  }
> @@ -978,14 +994,14 @@ static int mc_pcie_setup_windows(struct platform_device *pdev,
>  	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
>  	struct resource_entry *entry;
>  	u64 pci_addr;
> -	u32 index = 1;
> +	u32 index = 1; /* Window 0 used for config space */
>  
>  	resource_list_for_each_entry(entry, &bridge->windows) {
>  		if (resource_type(entry->res) == IORESOURCE_MEM) {
>  			pci_addr = entry->res->start - entry->offset;
>  			mc_pcie_setup_window(bridge_base_addr, index,
> -					     entry->res->start, pci_addr,
> -					     resource_size(entry->res));
> +					     entry->res->start - port->outbound_range_offset,
> +					     pci_addr, resource_size(entry->res));
>  			index++;
>  		}
>  	}
> @@ -1109,6 +1125,44 @@ static int mc_init_interrupts(struct platform_device *pdev, struct mc_pcie *port
>  	return 0;
>  }
>  
> +static int mc_check_for_parent_range_handling(struct platform_device *pdev, struct mc_pcie *port)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *dn = dev->of_node;
> +	struct of_range_parser parser;
> +	struct of_range range;
> +	u64 cpu_addr;
> +
> +	/* Find any pcie range */
> +	if (of_range_parser_init(&parser, dn)) {
> +		dev_err(dev, "missing ranges property\n");
> +		return -EINVAL;
> +	}
> +
> +	for_each_of_range(&parser, &range) {
> +		cpu_addr = range.cpu_addr;
> +		/*
> +		 * First range is enough - extend if anyone ever needs more
> +		 * than one fabric interface
> +		 */
> +		break;
> +	}
> +
> +	/* Check for one level up; that is enough */
> +	dn = of_get_parent(dn);
> +	if (dn) {
> +		of_range_parser_init(&parser, dn);
> +		for_each_of_range(&parser, &range) {
> +			/* Find the parent range that contains cpu_addr */
> +			if (range.cpu_addr > port->outbound_range_offset &&
> +			    range.cpu_addr < cpu_addr)
> +				port->outbound_range_offset = range.cpu_addr;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static int mc_platform_init(struct pci_config_window *cfg)
>  {
>  	struct device *dev = cfg->parent;
> @@ -1117,9 +1171,18 @@ static int mc_platform_init(struct pci_config_window *cfg)
>  		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
>  	int ret;
>  
> +	/*
> +	 * Need information about any parent bus that may be performing some
> +	 * of the outbound address translation to setup outbound address
> +	 * translation tables later
> +	 */
> +	ret = mc_check_for_parent_range_handling(pdev, port);
> +	if (ret)
> +		return ret;
> +
>  	/* Configure address translation table 0 for PCIe config space */
> -	mc_pcie_setup_window(bridge_base_addr, 0, cfg->res.start,
> -			     cfg->res.start,
> +	mc_pcie_setup_window(bridge_base_addr, 0, cfg->res.start - port->outbound_range_offset,
> +			     cfg->res.start - port->outbound_range_offset,
>  			     resource_size(&cfg->res));
>  
>  	/* Need some fixups in config space */
> -- 
> 2.25.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
