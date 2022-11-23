Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8763636D78
	for <lists+linux-pci@lfdr.de>; Wed, 23 Nov 2022 23:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbiKWWpA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 17:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiKWWo7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 17:44:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC311528A0;
        Wed, 23 Nov 2022 14:44:57 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8266B82556;
        Wed, 23 Nov 2022 22:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0DACC433C1;
        Wed, 23 Nov 2022 22:44:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669243494;
        bh=I3fWD1F1oA8nUjuxL+X3yz0LnBtE37vNR8CJt9f9zSE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=My0oAECE6Uh0RZxRfb0QEG+byZ8uXJW+L8yuSj78V7aR9C2Jr0+kcUoUU9d4+Idqy
         p+S7he/FKA1oIqPVBsYOYAuS0KGVd/P2+Dgyqx74y7Fi3RxNfdTYOZHLth4wZwHaTp
         +RVSvi39rjQ8Qm6J9KCQnj9XRQqfit2LCdioMZh1mttuXOWD1QtORUQCSjmvm5cYfb
         9PwRdqZ8JwbJjVzK1lxnXv27EF7iZ5CdxkxwRQT7+snTrORocXUEMLXNO0Q6G5yayk
         GQbDSe3s4+ZgqgE9a35i0wr2rUA5e1aeLE0LYfcg5pNKl5FSGc9lI9FUQFz1F+YgSU
         PPXZ9utDbq5hg==
Date:   Wed, 23 Nov 2022 22:44:49 +0000
From:   Conor Dooley <conor@kernel.org>
To:     daire.mcnamara@microchip.com
Cc:     conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, lpieralisi@kernel.org,
        kw@linux.com, bhelgaas@google.com, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 7/9] PCI: microchip: Partition outbound address
 translation
Message-ID: <Y36iYUbaZfK7364B@spud>
References: <20221116135504.258687-1-daire.mcnamara@microchip.com>
 <20221116135504.258687-8-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116135504.258687-8-daire.mcnamara@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 01:55:02PM +0000, daire.mcnamara@microchip.com wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
> 
> On Microchip PolarFire SoC the PCIe rootport is behind a set of fabric
> inter connect (fic) busses that encapsulate busses like ABP/AHP and
> AXI-M. Depending on which fic(s) the rootport is wired through to cpu
> space, the rootport driver needs to take account of the address
> translation done by a parent (e.g. fabric) node before setting up its
> own outbound address translation tables to config space and attached
> devices.
> 
> Parse the range properties to determine how much address translation
> needs to be done in the rootport.
> 
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/pci/controller/pcie-microchip-host.c | 109 +++++++++++++++----
>  1 file changed, 86 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
> index 73856647f321..62f8c5edfd0e 100644
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
> +	TRSL_ID_PCIE_TXRX = 0,
> +	TRSL_ID_PCIE_CONFIG = 1,
> +	TRSL_ID_AXI4_LITE_MASTER = 2,
> +	TRSL_ID_AXI4_MASTER_0 = 4,

My enum-fu is pretty bad, but can't we just drop all the numbers here
apart from 4 & the ordering will still be correct?
Maybe that's not ideal from a readability point of view though?

Otherwise, with whatever complaints LKP had & Bjorn's/my previous nits
fixed:
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

> +	TRSL_ID_AXI4_MASTER_1 = 5,
> +	TRSL_ID_AXI4_MASTER_2 = 6,
> +	TRSL_ID_AXI4_MASTER_3 = 7,
> +	TRSL_ID_AXI4_STREAM_0 = 8,
> +	TRSL_ID_AXI4_STREAM_1 = 9,
> +	TRSL_ID_AXI4_STREAM_2 = 10,
> +	TRSL_ID_AXI4_STREAM_3 = 11,
> +	TRSL_ID_INTERNAL_BRIDGE_REGISTERS = 12,
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
> @@ -268,6 +283,7 @@ struct mc_pcie {
>  	struct irq_domain *event_domain;
>  	raw_spinlock_t lock;
>  	struct mc_msi msi;
> +	u64 outbound_range_offset;
>  };
>  
>  struct cause {
> @@ -928,36 +944,36 @@ static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
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
> @@ -970,14 +986,14 @@ static int mc_pcie_setup_windows(struct platform_device *pdev,
>  	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
>  	struct resource_entry *entry;
>  	u64 pci_addr;
> -	u32 index = 1;
> +	u32 index = 1; /* window 0 used for config space */
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
> @@ -1093,6 +1109,44 @@ static int mc_init_interrupts(struct platform_device *pdev, struct mc_pcie *port
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
> +	/* find any pcie range */
> +	if (of_range_parser_init(&parser, dn)) {
> +		dev_err(dev, "missing ranges property\n");
> +		return -EINVAL;
> +	}
> +
> +	for_each_of_range(&parser, &range) {
> +		cpu_addr = range.cpu_addr;
> +		/*
> +		 * first range is enough - extend if anyone
> +		 * ever needs more than one fabric interface
> +		 */
> +		break;
> +	}
> +
> +	/* check for one level up; that is enough */
> +	dn = of_get_parent(dn);
> +	if (dn) {
> +		of_range_parser_init(&parser, dn);
> +		for_each_of_range(&parser, &range) {
> +			/* find the parent range that contains cpu_addr */
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
> @@ -1101,9 +1155,18 @@ static int mc_platform_init(struct pci_config_window *cfg)
>  		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
>  	int ret;
>  
> +	/*
> +	 * need information about any parent bus that may
> +	 * be performing some of the outbound address translation
> +	 * to setup outbound address translation tables later
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
