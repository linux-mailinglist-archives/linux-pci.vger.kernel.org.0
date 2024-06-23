Return-Path: <linux-pci+bounces-9158-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DC8913D1F
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 19:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F78D1F221BD
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 17:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF0A183097;
	Sun, 23 Jun 2024 17:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EBFBUwOU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F09A3C38;
	Sun, 23 Jun 2024 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719163209; cv=none; b=dOu+WjvRXGhem7Bo6wqWFSKLCtb/b6UIsgH2Kn7Aj5qTi3y8Eqqjy9wANcUsVSkco/0MR9ZuzsWGVC79Cs5pDHTFJCoSh9A1Dchf1cNYHo5cuJxrLSnKHW+THQK1jXp5xqc0laQdKXb072SuVGyq+8vbAQ4cKHdcPntJnYLMMQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719163209; c=relaxed/simple;
	bh=uJZcpJv0hqA88xELHju5tB3hDMt2Is5uBZniePTkLb8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=J2DxmOXhk2iTBy5fjnVy+c9TDUgjUf/ENQNYxVG/Zgi9k3b3GRpTVew/CkRZUF+LFF1vfzE+tFacoXqkYpfpAWBUK1QqmLia8bCQ6otl4O6/4VAj6HKVqhQp69rhrtsDae0kWM2uVgl7evv9r4jrJGbENNf+v22WEtDsa2VM2b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EBFBUwOU; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719163207; x=1750699207;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uJZcpJv0hqA88xELHju5tB3hDMt2Is5uBZniePTkLb8=;
  b=EBFBUwOU85ErC3pF8ASyZ822lDtR9WvdHimitpuUBuS849p3JsFfXCe2
   7ISEvDPGBBnZlssaF53JwBkDnKdU0jTSjGpthZSybijqFfH7pEEEpYj9t
   97jA/BbGXY9OavuuiDMaqy55q63HR5RnIXM+IlZlniWZm1477v6N/m2qr
   zNGu8ZHEa6u8c5cgzkzusyvQeUeJcg/d9scgbqv9joGUNUhf/6rIA+Vrn
   qL+UGPTu8du31d2IuIhHCwdXPpA95zRx84zYv4Po8Jh7HYMR2n1Gb1ate
   B0eef9620inmc+akVcvCvSWfsnEOQMXi3tZKdBusmOS1ud70a95qA+9ed
   w==;
X-CSE-ConnectionGUID: +SONrJCWSWuP5DdHabqQeQ==
X-CSE-MsgGUID: dAG2E3g/SdKDrS/A909rYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11112"; a="27266057"
X-IronPort-AV: E=Sophos;i="6.08,260,1712646000"; 
   d="scan'208";a="27266057"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 10:20:07 -0700
X-CSE-ConnectionGUID: XqbvGZsrTi+RoOiT6ZcPag==
X-CSE-MsgGUID: sreWyJctRkiuWmZkFlK6OA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,260,1712646000"; 
   d="scan'208";a="43771548"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.55])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2024 10:20:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Sun, 23 Jun 2024 20:19:58 +0300 (EEST)
To: daire.mcnamara@microchip.com
cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    conor.dooley@microchip.com, lpieralisi@kernel.org, kw@linux.com, 
    robh@kernel.org, bhelgaas@google.com, LKML <linux-kernel@vger.kernel.org>, 
    linux-riscv@lists.infradead.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
    ilpo.jarvinen@linux.intel.com
Subject: Re: [PATCH v4 2/3] PCI: microchip: Fix inbound address translation
 tables
In-Reply-To: <20240621112915.3434402-3-daire.mcnamara@microchip.com>
Message-ID: <e9c70168-b1cf-2f9a-3249-4e7ade9732b1@linux.intel.com>
References: <20240621112915.3434402-1-daire.mcnamara@microchip.com> <20240621112915.3434402-3-daire.mcnamara@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 21 Jun 2024, daire.mcnamara@microchip.com wrote:

> From: Daire McNamara <daire.mcnamara@microchip.com>
> 
> On Microchip PolarFire SoC the PCIe Root Port can be behind one of three
> general purpose Fabric Interface Controller (FIC) buses that encapsulates
> an AXI-S bus. Depending on which FIC(s) the Root Port is connected
> through to CPU space, and what address translation is done by that FIC,
> the Root Port driver's inbound address translation may vary.
> 
> For all current supported designs and all future expected designs,
> inbound address translation done by a FIC on PolarFire SoC varies
> depending on whether PolarFire SoC in operating in dma-coherent mode or
> dma-noncoherent mode.
> 
> The setup of the outbound address translation tables in the root port
> driver only needs to handle these two cases.
> 
> Setup the inbound address translation tables to one of two address
> translations, depending on whether the rootport is marked as dma-coherent or
> dma-noncoherent.
> 
> Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip Polarfire PCIe controller driver")
> 
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>

Hi,

As mentioned against v3 1/3, don't leave empty lines between tags.

> ---
>  drivers/pci/controller/pcie-microchip-host.c | 102 +++++++++++++++++--
>  1 file changed, 93 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
> index 853adce24492..d0489bd42bef 100644
> --- a/drivers/pci/controller/pcie-microchip-host.c
> +++ b/drivers/pci/controller/pcie-microchip-host.c
> @@ -30,6 +30,9 @@
>  #define MC_PCIE_BRIDGE_ADDR			(MC_PCIE1_BRIDGE_ADDR)
>  #define MC_PCIE_CTRL_ADDR			(MC_PCIE1_CTRL_ADDR)
>  
> +#define MC_MAX_NUM_INBOUND_WINDOWS		8
> +#define MPFS_NC_BOUNCE_ADDR			0x80000000
> +
>  /* PCIe Bridge Phy Regs */
>  #define PCIE_PCI_IRQ_DW0			0xa8
>  #define  MSIX_CAP_MASK				BIT(31)
> @@ -97,14 +100,15 @@
>  
>  /* PCIe AXI slave table init defines */
>  #define ATR0_AXI4_SLV0_SRCADDR_PARAM		0x800u
> -#define  ATR_SIZE_SHIFT				1
> -#define  ATR_IMPL_ENABLE			1
> +#define  ATR_SIZE_MASK				GENMASK(6, 1)

#include <linux/bits.h>

> +#define  ATR_IMPL_ENABLE_MASK			1

This would be BIT(0), I think. IMO, you don't need to add _MASK postfix 
for it, since it's just 1-bit wide field.

>  #define ATR0_AXI4_SLV0_SRC_ADDR			0x804u
>  #define ATR0_AXI4_SLV0_TRSL_ADDR_LSB		0x808u
>  #define ATR0_AXI4_SLV0_TRSL_ADDR_UDW		0x80cu
>  #define ATR0_AXI4_SLV0_TRSL_PARAM		0x810u
>  #define  PCIE_TX_RX_INTERFACE			0x00000000u
>  #define  PCIE_CONFIG_INTERFACE			0x00000001u
> +#define  TRSL_ID_AXI4_MASTER_0			0x00000004u
>  
>  #define ATR_ENTRY_SIZE				32
>  
> @@ -931,6 +935,86 @@ static int mc_pcie_init_irq_domains(struct mc_pcie *port)
>  	return mc_allocate_msi_domains(port);
>  }
>  
> +static void mc_pcie_setup_inbound_atr(int window_index, u64 axi_addr, u64 pcie_addr, size_t size)
> +{
> +	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> +	u32 table_offset = window_index * ATR_ENTRY_SIZE;
> +	void __iomem *table_addr = bridge_base_addr + table_offset;
> +	u32 atr_sz;
> +	u32 val;
> +
> +	atr_sz = ilog2(size) - 1;

You should add explicit includes you use:

#include <linux/log2.h>

> +
> +	val = ALIGN_DOWN(lower_32_bits(pcie_addr), SZ_4K);

#include <linux/align.h>

> +	val |= FIELD_PREP(ATR_SIZE_MASK, atr_sz);
> +	val |= FIELD_PREP(ATR_IMPL_ENABLE_MASK, 1);
> +
> +	writel(val, table_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
> +
> +	writel(upper_32_bits(pcie_addr), table_addr + ATR0_PCIE_WIN0_SRC_ADDR);

#include <linux/wordpart.h>

> +	writel(lower_32_bits(axi_addr), table_addr + ATR0_PCIE_WIN0_TRSL_ADDR_LSB);
> +	writel(upper_32_bits(axi_addr), table_addr + ATR0_PCIE_WIN0_TRSL_ADDR_UDW);
> +
> +	writel(TRSL_ID_AXI4_MASTER_0, table_addr + ATR0_PCIE_WIN0_TRSL_PARAM);
> +}
> +
> +static int mc_pcie_setup_inbound_ranges(struct platform_device *pdev, struct mc_pcie *port)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct device_node *dn = dev->of_node;
> +	struct of_range_parser parser;
> +	struct of_range range;
> +	int atr_index = 0;
> +
> +	/*
> +	 * MPFS PCIe root port is 32-bit only, behind a Fabric Interface
> +	 * Controller FPGA logic block which contains the AXI-S interface.
> +	 *
> +	 * From the point of view of the PCIe root port, There are only
> +	 * two supported Root Port configurations
> +	 *
> +	 * Configuration 1: for use with fully coherent designs; supports a
> +	 * window from 0x0 (CPU space) to specified PCIe space.
> +	 *
> +	 * Configuration 2: for use with non-coherent designs; supports two
> +	 * 1 Gb wide windows to CPU space; one mapping cpu space 0 to pcie
> +	 * space 0x80000000 and mapping cpu space 0x40000000 to pcie
> +	 * space 0xc0000000. This cfg needs two windows because of how
> +	 * the MSI space is allocated in the AXI-S range on MPFS.
> +	 *
> +	 * The FIC interface outside the PCIe block *must* complete the inbound
> +	 * address translation as per MCHP MPFS FPGA design guidelines.
> +	 */
> +	if (device_property_read_bool(dev, "dma-noncoherent")) {
> +		/*
> +		 * Always need same two tables in this case.  Need two tables
> +		 * due to hardware interactions between address and size.
> +		 */
> +		mc_pcie_setup_inbound_atr(0, 0, MPFS_NC_BOUNCE_ADDR, SZ_1G);
> +		mc_pcie_setup_inbound_atr(1, SZ_1G, MPFS_NC_BOUNCE_ADDR + SZ_1G, SZ_1G);
> +	} else {
> +		/* Find any dma-ranges */
> +		if (of_pci_dma_range_parser_init(&parser, dn)) {
> +			/* No dma-range property - setup default */
> +			mc_pcie_setup_inbound_atr(0, 0, 0, SZ_4G);
> +			return 0;
> +		}
> +
> +		for_each_of_range(&parser, &range) {
> +			if (atr_index >= MC_MAX_NUM_INBOUND_WINDOWS) {
> +				dev_err(dev, "too many inbound ranges; %d available tables\n",
> +					MC_MAX_NUM_INBOUND_WINDOWS);
> +				return -EINVAL;
> +			}
> +			mc_pcie_setup_inbound_atr(atr_index, 0, range.pci_addr, range.size);
> +			atr_index++;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
>  static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
>  				 phys_addr_t axi_addr, phys_addr_t pci_addr,
>  				 u64 size)
> @@ -946,8 +1030,9 @@ static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
>  	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
>  	       ATR0_AXI4_SLV0_TRSL_PARAM);
>  
> -	val = lower_32_bits(axi_addr) | (atr_sz << ATR_SIZE_SHIFT) |
> -			    ATR_IMPL_ENABLE;
> +	val = ALIGN_DOWN(lower_32_bits(axi_addr), SZ_4K);
> +	val |= FIELD_PREP(ATR_SIZE_MASK, atr_sz);
> +	val |= FIELD_PREP(ATR_IMPL_ENABLE_MASK, 1);

This can be just val |= ATR_IMPL_ENABLE when you don't have _MASK 
there which is easier to read (IMO).

It would be nice to put the GENMASK()/FIELD_PREP() refactor into a 
preparatory patch on top of which you'd make the actual fix to keep the 
fix change itself simpler.

Nonetheless, this was already much better than the previous version.

-- 
 i.

>  	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
>  	       ATR0_AXI4_SLV0_SRCADDR_PARAM);
>  
> @@ -962,11 +1047,6 @@ static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
>  	val = upper_32_bits(pci_addr);
>  	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
>  	       ATR0_AXI4_SLV0_TRSL_ADDR_UDW);
> -
> -	val = readl(bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
> -	val |= (ATR0_PCIE_ATR_SIZE << ATR0_PCIE_ATR_SIZE_SHIFT);
> -	writel(val, bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
> -	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);
>  }
>  
>  static int mc_pcie_setup_windows(struct platform_device *pdev,
> @@ -1129,6 +1209,10 @@ static int mc_platform_init(struct pci_config_window *cfg)
>  	if (ret)
>  		return ret;
>  
> +	ret = mc_pcie_setup_inbound_ranges(pdev, port);
> +	if (ret)
> +		return ret;
> +
>  	/* Address translation is up; safe to enable interrupts */
>  	ret = mc_init_interrupts(pdev, port);
>  	if (ret)
> 

