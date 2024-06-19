Return-Path: <linux-pci+bounces-8980-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E11390EF55
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 15:48:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DEAA1F22802
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 13:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7D814C581;
	Wed, 19 Jun 2024 13:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mSJ5N/vw"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5ECD14388B;
	Wed, 19 Jun 2024 13:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718804908; cv=none; b=D92dkQ/JDb+/RyIGFbgxaWWURuWaHAYK/MycJv+fjj6+03UOEGhKYK9Km6g43cYa2U5n/aPVU/1oo0N7NUqG1UZKA/TdZ75f3Iv2RUxECOQQbj3p8ICEiHnSpuoi8u3CuG9CKvUglL1WODTHry9BprbKKicjlFxjUdDnnoKxw9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718804908; c=relaxed/simple;
	bh=pvCmW/F0/rUAHkhqXnbKYz7EFu26WqeWhNrxjjEOAEw=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tonfyCLbS2bilpWLPY1XBNRPh4MmTDUS+pybjOg9GvKstdrhGMW3Y5j2kCuy+Vr5d/BBr/kUkRAWtHKb5PmcOnq7z9yNAGMeme8oGBX/JREDZOsNa7xLVT1zsvBdtnrAucgpWZXI7WkRqqHlSwLSjnVHaBpJ57uDw1IBjbJLM+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mSJ5N/vw; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1718804905; x=1750340905;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=pvCmW/F0/rUAHkhqXnbKYz7EFu26WqeWhNrxjjEOAEw=;
  b=mSJ5N/vwhz376sPYhSgrwCpf3pOhgp2GpEaCcFNAqN4leh1BuEo0SuWV
   rMuP8JN4nFZ8XQgkPAtodeFK2c9hJPvwS/00FPKGfiLGRe9yyJfRETkUx
   hKypPr/V7gBDM94rmhPFQn4brHW1mgGqZ4+D3LK/6kdEJl/ezO25KWXZB
   rwfQX/NgXydaBNivQ+12sH846OlJ7hp3Pzl3KG1b10/rGNlzKXDAgN3F/
   wWGPeRH4RugVHOqcGmgY3FI+JrPB/2whUQzDZ6AM4h3c+edxYoctRAtEM
   JKeWrn9x8lxfrhs/KU3nHWBnsiro/PiK75pZrKhEBDA06DZfolwZIVexr
   Q==;
X-CSE-ConnectionGUID: gFv9J5D8TKKIbjOj+sIHFA==
X-CSE-MsgGUID: a3PSo+M4S5Six5WXHgEWxw==
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="30736376"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 19 Jun 2024 06:48:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 19 Jun 2024 06:48:19 -0700
Received: from daire-X570 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35 via Frontend
 Transport; Wed, 19 Jun 2024 06:48:17 -0700
Date: Wed, 19 Jun 2024 14:48:15 +0100
From: Daire McNamara <daire.mcnamara@microchip.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<conor.dooley@microchip.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
Subject: Re: [PATCH v3 2/3] PCI: microchip: Fix inbound address translation
 tables
Message-ID: <ZnLhn3DvnEWaa6I+@daire-X570>
References: <20240612112213.2734748-1-daire.mcnamara@microchip.com>
 <20240612112213.2734748-3-daire.mcnamara@microchip.com>
 <7ba2a37a-6012-a0a1-a74f-e9fc83598453@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ba2a37a-6012-a0a1-a74f-e9fc83598453@linux.intel.com>

On Fri, Jun 14, 2024 at 04:29:47PM +0300, Ilpo Järvinen wrote:
> On Wed, 12 Jun 2024, daire.mcnamara@microchip.com wrote:
> 
> > From: Daire McNamara <daire.mcnamara@microchip.com>
> > 
> > On Microchip PolarFire SoC the PCIe Root Port can be behind one of three
> > general purpose Fabric Interface Controller (FIC) buses that encapsulates
> > an AXI-S bus. Depending on which FIC(s) the Root Port is connected
> > through to CPU space, and what address translation is done by that FIC,
> > the Root Port driver's inbound address translation may vary.
> > 
> > For all current supported designs and all future expected designs,
> > inbound address translation done by a FIC on PolarFire SoC varies
> > depending on whether PolarFire SoC in operating in dma-coherent mode or
> > dma-noncoherent mode.
> > 
> > The setup of the outbound address translation tables in the root port
> > driver only needs to handle these two cases.
> > 
> > Setup the inbound address translation tables to one of two address
> > translations, depending on whether the rootport is marked as dma-coherent or
> > dma-noncoherent.
> > 
> > Fixes: 6f15a9c9f941 ("PCI: microchip: Add Microchip Polarfire PCIe controller driver")
> > 
> > Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> > ---
> >  drivers/pci/controller/pcie-microchip-host.c | 97 +++++++++++++++++++-
> >  1 file changed, 92 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
> > index 853adce24492..d5021333e2aa 100644
> > --- a/drivers/pci/controller/pcie-microchip-host.c
> > +++ b/drivers/pci/controller/pcie-microchip-host.c
> > @@ -30,6 +30,9 @@
> >  #define MC_PCIE_BRIDGE_ADDR			(MC_PCIE1_BRIDGE_ADDR)
> >  #define MC_PCIE_CTRL_ADDR			(MC_PCIE1_CTRL_ADDR)
> >  
> > +#define MC_MAX_NUM_INBOUND_WINDOWS		8
> > +#define MPFS_NC_BOUNCE_ADDR			0x80000000
> > +
> >  /* PCIe Bridge Phy Regs */
> >  #define PCIE_PCI_IRQ_DW0			0xa8
> >  #define  MSIX_CAP_MASK				BIT(31)
> > @@ -105,6 +108,7 @@
> >  #define ATR0_AXI4_SLV0_TRSL_PARAM		0x810u
> >  #define  PCIE_TX_RX_INTERFACE			0x00000000u
> >  #define  PCIE_CONFIG_INTERFACE			0x00000001u
> > +#define  TRSL_ID_AXI4_MASTER_0			0x00000004u
> >  
> >  #define ATR_ENTRY_SIZE				32
> >  
> > @@ -931,6 +935,89 @@ static int mc_pcie_init_irq_domains(struct mc_pcie *port)
> >  	return mc_allocate_msi_domains(port);
> >  }
> >  
> > +static void mc_pcie_setup_inbound_atr(int window_index, u64 axi_addr, u64 pcie_addr, size_t size)
> > +{
> > +	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> > +	u32 table_offset = window_index * ATR_ENTRY_SIZE;
> > +	u32 atr_sz;
> > +	u32 val;
> > +
> > +	atr_sz = ilog2(size) - 1;
> > +	atr_sz &= GENMASK(5, 0);
> > +	val = lower_32_bits(pcie_addr) & GENMASK(31, 12);
> 
> ALIGN_DOWN(, SZ_xx) ?
Nice, I'll pop that into v4
> 
> > +	val |= (atr_sz << ATR_SIZE_SHIFT);
> 
> This looks like a named define + FIELD_PREP() would be more appropriate 
> here.
And, also nice.  Again, I'll pop that into v4.
> 
> > +	val |= ATR_IMPL_ENABLE;
> > +	writel(val, bridge_base_addr + table_offset + ATR0_PCIE_WIN0_SRCADDR_PARAM);
> > +
> > +	writel(upper_32_bits(pcie_addr), bridge_base_addr + table_offset +
> > +	       ATR0_PCIE_WIN0_SRC_ADDR);
> > +
> > +	writel(lower_32_bits(axi_addr), bridge_base_addr + table_offset +
> > +	       ATR0_PCIE_WIN0_TRSL_ADDR_LSB);
> > +	writel(upper_32_bits(axi_addr), bridge_base_addr + table_offset +
> > +	       ATR0_PCIE_WIN0_TRSL_ADDR_UDW);
> > +
> > +	writel(TRSL_ID_AXI4_MASTER_0, bridge_base_addr + table_offset +
> > +	       ATR0_PCIE_WIN0_TRSL_PARAM);
> 
> Having a table_addr local variable instead would make these much less 
> repetitive and shorter.
Agreed. v4
> 
> > +}
> > +
> > +static int mc_pcie_setup_inbound_ranges(struct platform_device *pdev, struct mc_pcie *port)
> > +{
> > +	struct device *dev = &pdev->dev;
> > +	struct device_node *dn = dev->of_node;
> > +	struct of_range_parser parser;
> > +	struct of_range range;
> > +	int atr_index = 0;
> > +
> > +	/*
> > +	 * MPFS PCIe root port is 32-bit only, behind a Fabric Interface
> > +	 * Controller FPGA logic block which contains the AXI-S interface.
> > +	 *
> > +	 * From the point of view of the PCIe root port, There are only
> > +	 * two supported Root Port configurations
> > +	 *
> > +	 * Configuration 1: for use with fully coherent designs; supports a
> > +	 * window from 0x0 (CPU space) to specified PCIe space.
> > +	 *
> > +	 * Configuration 2: for use with non-coherent designs; supports two
> > +	 * 1 Gb wide windows to CPU space; one mapping cpu space 0 to pcie
> > +	 * space 0x80000000 and mapping cpu space 0x40000000 to pcie
> > +	 * space 0xc0000000. This cfg needs two windows because of how
> > +	 * the MSI space is allocated in the AXI-S range on MPFS.
> > +	 *
> > +	 * The FIC interface outside the PCIe block *must* complete the inbound
> > +	 * address translation as per MCHP MPFS FPGA design guidelines.
> > +	 */
> > +	if (device_property_read_bool(dev, "dma-noncoherent")) {
> > +		/*
> > +		 * Always need same two tables in this case.  Need two tables
> > +		 * due to hardware interactions between address and size.
> > +		 */
> > +		mc_pcie_setup_inbound_atr(0, 0, MPFS_NC_BOUNCE_ADDR, SZ_1G);
> > +		mc_pcie_setup_inbound_atr(1, SZ_1G, MPFS_NC_BOUNCE_ADDR + SZ_1G, SZ_1G);
> > +	} else {
> > +		/* Find any dma-ranges */
> > +		if (of_pci_dma_range_parser_init(&parser, dn)) {
> > +			/* No dma-range property - setup default */
> > +			mc_pcie_setup_inbound_atr(0, 0, 0, SZ_4G);
> > +			return 0;
> > +		}
> > +
> > +		for_each_of_range(&parser, &range) {
> > +			if (atr_index >= MC_MAX_NUM_INBOUND_WINDOWS) {
> > +				dev_err(dev, "too many inbound ranges; %d available tables\n",
> > +					MC_MAX_NUM_INBOUND_WINDOWS);
> > +				return -EINVAL;
> 
> You don't need to rollback anything when this error is encountered?
This one, I can't see how the driver can do anything more useful than just give up - the
address translation tables are now no better nor no worse than they were before; i.e. the
root port won't work properly.
I can't see any deploment-time recovery of the root port from this.

For general end-users of PolarFire systems, I'd expect they're going to see a working system
that has been brought up/debugged by someone doing a bsp.

So, in my mind, this is a case only a developer bringing up a new bsp on
PolarFire SoC needs to know about and all the driver can do is a notify that their proposed
 address translations won't work as they imagine (as they've run out of tables).

> 
> > +			}
> > +			mc_pcie_setup_inbound_atr(atr_index, 0, range.pci_addr, range.size);
> > +			atr_index++;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
> >  				 phys_addr_t axi_addr, phys_addr_t pci_addr,
> >  				 u64 size)
> > @@ -962,11 +1049,6 @@ static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
> >  	val = upper_32_bits(pci_addr);
> >  	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
> >  	       ATR0_AXI4_SLV0_TRSL_ADDR_UDW);
> > -
> > -	val = readl(bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
> > -	val |= (ATR0_PCIE_ATR_SIZE << ATR0_PCIE_ATR_SIZE_SHIFT);
> > -	writel(val, bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
> > -	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);
> >  }
> >  
> >  static int mc_pcie_setup_windows(struct platform_device *pdev,
> > @@ -1129,6 +1211,11 @@ static int mc_platform_init(struct pci_config_window *cfg)
> >  	if (ret)
> >  		return ret;
> >  
> > +	/* Configure inbound translation tables */
> 
> IMO, this comment adds 0 value over what the code tells all by itself so 
> it would be best to drop it.
Dropped
> 
> > +	ret = mc_pcie_setup_inbound_ranges(pdev, port);
> > +	if (ret)
> > +		return ret;
> > +
> >  	/* Address translation is up; safe to enable interrupts */
> >  	ret = mc_init_interrupts(pdev, port);
> >  	if (ret)
> > 
> 
> -- 
>  i.
> 
> 

