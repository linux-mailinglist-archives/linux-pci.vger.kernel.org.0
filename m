Return-Path: <linux-pci+bounces-9915-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02ADD929EBB
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 11:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24CCA1C2176A
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 09:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B14F453E22;
	Mon,  8 Jul 2024 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HhhjHDwh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F98B4AEF7;
	Mon,  8 Jul 2024 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720429978; cv=none; b=LRISHcitClahjwQ8BXcbhNG49tqYFMB2OjaKb/yHHJWg7pUFfNr2L0RTf6ObZNCqfHdg54p8/OCDGZ6eXta6ecu5rIEWjVhXwA239uJCy+1LHTQkmSYDoWK4HSppTGEt7C+g1lWDzuNk+eUeJ5H47EcunA4feOUu9OdCvEcCIV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720429978; c=relaxed/simple;
	bh=CAaJk++tecrLaptH+16hNaBiNTEIQYH3fzlW19fwgC8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=YC11U0YCk/x8MHoR7NsQ4Utyhrzg3uYlHD0WzjtnMOqlXfQPjMcJp5NawuzMiVivcUI/gtFkFVWAz/taFlrJTGfZ3BmdtM3+TMcrfJeZEsWQf3R2fL9xn4weaulIcgYfS+xIGcUzTClKLiTvaapUNVL5qFaMyVfCHl9KBzHMOUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HhhjHDwh; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720429977; x=1751965977;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=CAaJk++tecrLaptH+16hNaBiNTEIQYH3fzlW19fwgC8=;
  b=HhhjHDwhanIM/ZBn5ioqv2C28DFo+wddg4yG1JRLUmvBUVuhxyWO+Gbx
   bO8RN/poSBl7rBMwTVUooYN2Xg9XBxuU3oZiuDt8k+22mn+qpH1N2Uo3a
   cOxELzChgI3/4YtKiaM5TgZaNs2j9VErEVoayNg0/BbZy4QeCWTvVJGzL
   LvWc8xAQ1THl7M34xHXdmWlvv8PM76sxYnMGSx2k3LPI7ilRqJD6wIw0Z
   UlHqaWZc1MbgYk6EbkkT0AQhW0fb9N4PNAqms+wGSF+KPk3S25ah/HU+W
   9qQ5vvGUZECv9R3x1SdjFlAyk1kOaWpOp9iLr67tIRtae7bk9kvqDblVw
   g==;
X-CSE-ConnectionGUID: 6sDNUsU/Q469SsZWeA+v3A==
X-CSE-MsgGUID: oeshmtegR9i7o4tndMaTcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11126"; a="17436554"
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="17436554"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 02:12:56 -0700
X-CSE-ConnectionGUID: Bri5CEPIQAqx34xgx/2URQ==
X-CSE-MsgGUID: WSwuHQr9TZyy0hw2Fm3MbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,191,1716274800"; 
   d="scan'208";a="47509006"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.115])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 02:12:51 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 8 Jul 2024 12:12:46 +0300 (EEST)
To: daire.mcnamara@microchip.com
cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
    conor.dooley@microchip.com, lpieralisi@kernel.org, kw@linux.com, 
    robh@kernel.org, bhelgaas@google.com, LKML <linux-kernel@vger.kernel.org>, 
    linux-riscv@lists.infradead.org, krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v6 2/3] PCI: microchip: Fix inbound address translation
 tables
In-Reply-To: <20240628115923.4133286-3-daire.mcnamara@microchip.com>
Message-ID: <addb88b3-1318-d337-052e-088c832bc088@linux.intel.com>
References: <20240628115923.4133286-1-daire.mcnamara@microchip.com> <20240628115923.4133286-3-daire.mcnamara@microchip.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 28 Jun 2024, daire.mcnamara@microchip.com wrote:

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

Please improve the use of capital letters in general.

DMA x2

> 
> The setup of the outbound address translation tables in the root port

Root Port

> driver only needs to handle these two cases.
> 
> Setup the inbound address translation tables to one of two address
> translations, depending on whether the rootport is marked as dma-coherent or
> dma-noncoherent.

DMA x2

> 
> Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip Polarfire PCIe controller driver")
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/pci/controller/pcie-microchip-host.c | 106 +++++++++++++++++--
>  1 file changed, 97 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
> index 47c397ae515a..27bfa3b7a187 100644
> --- a/drivers/pci/controller/pcie-microchip-host.c
> +++ b/drivers/pci/controller/pcie-microchip-host.c
> @@ -7,16 +7,20 @@
>   * Author: Daire McNamara <daire.mcnamara@microchip.com>
>   */
>  
> +#include <linux/align.h>
>  #include <linux/bitfield.h>
> +#include <linux/bits.h>
>  #include <linux/clk.h>
>  #include <linux/irqchip/chained_irq.h>
>  #include <linux/irqdomain.h>
> +#include <linux/log2.h>
>  #include <linux/module.h>
>  #include <linux/msi.h>
>  #include <linux/of_address.h>
>  #include <linux/of_pci.h>
>  #include <linux/pci-ecam.h>
>  #include <linux/platform_device.h>
> +#include <linux/wordpart.h>
>  
>  #include "../pci.h"
>  
> @@ -32,6 +36,9 @@
>  #define MC_PCIE_BRIDGE_ADDR			(MC_PCIE1_BRIDGE_ADDR)
>  #define MC_PCIE_CTRL_ADDR			(MC_PCIE1_CTRL_ADDR)
>  
> +#define MC_MAX_NUM_INBOUND_WINDOWS		8
> +#define MPFS_NC_BOUNCE_ADDR			0x80000000
> +
>  /* PCIe Bridge Phy Regs */
>  #define PCIE_PCI_IRQ_DW0			0xa8
>  #define  MSIX_CAP_MASK				BIT(31)
> @@ -99,14 +106,15 @@
>  
>  /* PCIe AXI slave table init defines */
>  #define ATR0_AXI4_SLV0_SRCADDR_PARAM		0x800u
> -#define  ATR_SIZE_SHIFT				1
> -#define  ATR_IMPL_ENABLE			1
> +#define  ATR_SIZE_MASK				GENMASK(6, 1)
> +#define  ATR_IMPL_ENABLE			BIT(0)
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
> @@ -933,6 +941,86 @@ static int mc_pcie_init_irq_domains(struct mc_pcie *port)
>  	return mc_allocate_msi_domains(port);
>  }
>  
> +static void mc_pcie_setup_inbound_atr(int window_index, u64 axi_addr, u64 pcie_addr, u64 size)
> +{
> +	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> +	u32 table_offset = window_index * ATR_ENTRY_SIZE;
> +	void __iomem *table_addr = bridge_base_addr + table_offset;
> +	u32 atr_sz;
> +	u32 val;
> +
> +	atr_sz = ilog2(size) - 1;
> +
> +	val = ALIGN_DOWN(lower_32_bits(pcie_addr), SZ_4K);
> +	val |= FIELD_PREP(ATR_SIZE_MASK, atr_sz);
> +	val |= ATR_IMPL_ENABLE;
> +
> +	writel(val, table_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
> +
> +	writel(upper_32_bits(pcie_addr), table_addr + ATR0_PCIE_WIN0_SRC_ADDR);
> +
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

, There -> , there

Root Port

> +	 * two supported Root Port configurations

Terminate with either : or .

> +	 *
> +	 * Configuration 1: for use with fully coherent designs; supports a
> +	 * window from 0x0 (CPU space) to specified PCIe space.
> +	 *
> +	 * Configuration 2: for use with non-coherent designs; supports two
> +	 * 1 Gb wide windows to CPU space; one mapping cpu space 0 to pcie

Gb means gigabits?? GB is for gigabytes.

CPU
PCIe

> +	 * space 0x80000000 and mapping cpu space 0x40000000 to pcie

Ditto.

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

DMA

> +		if (of_pci_dma_range_parser_init(&parser, dn)) {
> +			/* No dma-range property - setup default */

DMA

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
>  				 resource_size_t size)
> @@ -948,8 +1036,9 @@ static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
>  	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
>  	       ATR0_AXI4_SLV0_TRSL_PARAM);
>  
> -	val = lower_32_bits(axi_addr) | (atr_sz << ATR_SIZE_SHIFT) |
> -			    ATR_IMPL_ENABLE;
> +	val = ALIGN_DOWN(lower_32_bits(axi_addr), SZ_4K);
> +	val |= FIELD_PREP(ATR_SIZE_MASK, atr_sz);
> +	val |= ATR_IMPL_ENABLE;
>  	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
>  	       ATR0_AXI4_SLV0_SRCADDR_PARAM);
>  
> @@ -964,11 +1053,6 @@ static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
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
> @@ -1131,6 +1215,10 @@ static int mc_platform_init(struct pci_config_window *cfg)
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

The code change itself looks fine for the extent I understand it.

-- 
 i.


