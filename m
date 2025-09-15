Return-Path: <linux-pci+bounces-36111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FF6B56FDA
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 07:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5185D189BB74
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 05:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F019425F96B;
	Mon, 15 Sep 2025 05:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqJsGHA3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B8C19DF4F;
	Mon, 15 Sep 2025 05:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757915354; cv=none; b=qC6AysgHiRfRJ2Kk7IXUtvorSllK0XBgOwfXGPgWW5Px+JrSwozwkD6l1D9iRuz1LcgqLGtevI5dQX7R6XZe+0NxiGJGvnhf6Jrh1OAxraT+kGiI1Nps9n9WxomcBrQGLTPRt4f+NkImOFZbAAtns458e9Cb+jhk7+cGrqyEX3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757915354; c=relaxed/simple;
	bh=vrIXg0HvWiKEZW1gHulvWI1+bn6Dt0Zf8zzIJtYH9KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vq3ZMY/ohATRlNY7RPxFwdkkxf6/b0wSbP9xnv6+qmHEYdgiWyqnDTrGOZ/p6bI2IXfcPiHWzwobD9eriztwBZHtty+NYoeZntt1D8Luer8+YqwOHvrcUbzghNP6U65Jirag0V75gOtjp0qMeT4U4t846wUTq4/++5r0nJ/q8qY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqJsGHA3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD98C4CEF1;
	Mon, 15 Sep 2025 05:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757915354;
	bh=vrIXg0HvWiKEZW1gHulvWI1+bn6Dt0Zf8zzIJtYH9KI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pqJsGHA3Dw84Vt3FNfV+B2PsS/AN483hdmBihkffirbf6IXtwBT8Hh73yngqOxVg/
	 P7XLs00LOsDDlfBjx7b0s0kF/snFZ2HpDCNivp+DcYA8RnwNNglIkDWxuHbMKIenBc
	 Iqw4bFizJepYKUN7acwx2c/SnnXzTCd+ExCZIWLdrMKkPGdk1xJbYCrdsvXIj+aZ1X
	 L7M5K4zywmdxOR0CESTF3qhcATkR2/p0RLo7XD9itqLRl0bjLeWAKEgm2mzzA9bN+9
	 SXQLU3wQOuN6l7iYHoPjgj6GktFtUs2Sg4yrYFIaRWB7/Df1bbgjUXcbEofytIXk60
	 ge30V93X7NPxA==
Date: Mon, 15 Sep 2025 11:19:04 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <hans.zhang@cixtech.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mpillai@cadence.com, fugang.duan@cixtech.com, guoyin.chen@cixtech.com, 
	peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 07/14] PCI: cadence: Add support for High Perf
 Architecture (HPA) controller
Message-ID: <pi5ouej6wae2nfjszfmeyctkavvmtycuaf7uxurfpie5x53zae@gz3ymk7laglx>
References: <20250901092052.4051018-1-hans.zhang@cixtech.com>
 <20250901092052.4051018-8-hans.zhang@cixtech.com>
 <yl5mty7uz3fneyxyeacydbu2l7ptngt2ah7roybxza6vtjvs3s@fobe3kl76msw>
 <5afb25b2-a3ca-4afe-9826-e1d722599ee1@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5afb25b2-a3ca-4afe-9826-e1d722599ee1@cixtech.com>

On Tue, Sep 09, 2025 at 12:41:33AM GMT, Hans Zhang wrote:

[...]

> Dear Mani,
> 
> Thank you very much for your reply. This function is a new one I added
> during my collaboration with Manikandan. Here I'll reply to you. Other
> Manikandan will reply to you.
> 

Please trim your replies so that your message appears at the top.

> > rp_bdf, rc_bus_nr
> 
> Will change.
> 
> > 
> > > +     u32 ecam_addr_0, region_size_0, request_id_0;
> > 
> > So ECAM address is always 32bit? For all Cadence IP implementations?
> 
> Sorry, it's my fault here. Since the ECAM distribution of CIX SKY1 is as
> follows:
> 
> X8: 0x2c00_0000 ~ 0x3000_0000
> X4: 0x2900_0000 ~ 0x2c00_0000
> X2: 0x2600_0000 ~ 0x2900_0000
> X1_1: 0x2300_0000 ~ 0x2600_0000
> X1_0: 0x2000_0000 ~ 0x2300_0000
> 
> This is only the CIX SKY1 designed in the low 32-bit address range. In fact,
> Cadence IP supports 64-bit ECAM addresses. Will change.
> 
> 
> > 
> > > +     int busnr = 0, secbus = 0, subbus = 0;
> > > +     struct resource_entry *entry;
> > > +     resource_size_t size;
> > > +     u32 axi_address_low;
> > > +     int nbits;
> > > +     u64 sz;
> > > +
> > > +     entry = resource_list_first_type(&bridge->windows, IORESOURCE_BUS);
> > > +     if (entry) {
> > > +             busnr = entry->res->start;
> > > +             secbus = (busnr < 0xff) ? (busnr + 1) : 0xff;
> > > +             subbus = entry->res->end;
> > > +     }
> > > +     size = resource_size(cfg_res);
> > > +     sz = 1ULL << fls64(size - 1);
> > > +     nbits = ilog2(sz);
> > > +     if (nbits < 8)
> > > +             nbits = 8;
> > > +
> > > +     root_port_req_id_reg = ((busnr & 0xff) << 8);
> > > +     pcie_bus_number_reg = ((subbus & 0xff) << 16) | ((secbus & 0xff) << 8) |
> > > +                           (busnr & 0xff);
> > > +     ecam_addr_0 = cfg_res->start;
> > 
> > Doesn't the platform require 'cfg_res->start' to be aligned to 256 MiB? The bus
> > range seem to be 0xff, so the Cadence IP allocates 8 bits for 'bus'. As per the
> > PCIe spec r6.0, sec 7.2.2, says:
> > 
> > 'the base address of the range is aligned to a 2(n+20)-byte memory address
> > boundary'
> > 
> > So the 'cfg_res->start' should be aligned to 2^28 byte (256 MiB) address.
> > 
> 
> Just as the ECAM address range mentioned above, our bus is not 0xff.
> Therefore, aligned to 2^28 byte (256 MiB) address is not required.
> 
> X8: 0xc0 ~ 0xff
> X4: 0x90 ~ 0xbf
> X2: 0x60 ~ 0x8f
> X1_1: 0x30 ~ 0x5f
> X1_0: 0x00 ~ 0x2f

So n is 6 for your platforma and you need to check for 64MiB alignment. But
since this check is performed in the common code, you need to somehow pass the
'n' bits value from your csky driver.

> 
> > > +     region_size_0 = nbits - 1;
> > > +     request_id_0 = ((busnr & 0xff) << 8);
> > > +
> > > +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> > > +                          CDNS_PCIE_HPA_TAG_MANAGEMENT, 0x200000);
> > > +
> > > +     /* Taking slave err as OKAY */
> > > +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE, CDNS_PCIE_HPA_SLAVE_RESP,
> > > +                          0x0);
> > > +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> > > +                          CDNS_PCIE_HPA_SLAVE_RESP + 0x4, 0x0);
> > > +
> > > +     /* Program the register "i_root_port_req_id_reg" with RP's BDF */
> > > +     cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG, I_ROOT_PORT_REQ_ID_REG,
> > > +                          root_port_req_id_reg);
> > > +
> > > +     /**
> > > +      * Program the register "i_pcie_bus_numbers" with Primary(RP's bus number),
> > > +      * secondary and subordinate bus numbers
> > > +      */
> > > +     cdns_pcie_hpa_writel(pcie, REG_BANK_RP, I_PCIE_BUS_NUMBERS,
> > > +                          pcie_bus_number_reg);
> > > +
> > > +     /* Program the register "lm_hal_sbsa_ctrl[0]" to enable the sbsa */
> > > +     value = cdns_pcie_hpa_readl(pcie, REG_BANK_IP_REG, LM_HAL_SBSA_CTRL);
> > > +     value |= BIT(0);
> > > +     cdns_pcie_hpa_writel(pcie, REG_BANK_IP_REG, LM_HAL_SBSA_CTRL, value);
> > > +
> > > +     /* Program region[0] for ECAM */
> > > +     axi_address_low = (ecam_addr_0 & 0xfff00000) | region_size_0;
> > 
> > Could you explain what is getting programmed and why?
> 
> Cadence IP register description:
> 
> Region Base Address [31:8] (24 bits)
> Lower [31:8] bits of the AXI region base address.
> 
> Region Size (6 bits)
> The programme value in this field + 1 gives the region size. Minimum value
> to be programmed into this field is 7 as the lower 8 bits of the AXI region
> base address are replaced by zeros by the region select logic. Minumum
> supported region size is 256 bytes.
> 

Add some of this info in the comments.

> 
> The original intention of ecam_addr_0 & 0xfff00000 is to align with 1MB.
> This is clearly redundant, as one Bus alone requires a 1MB ECAM range.
> 

You need to check for alignment at the start as I mentioned above.

> Will delete & 0xfff00000.
> 
> Here it refers to CPU address.
> 
> > 
> > > +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> > > +                          CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR0(0),
> > > +                          axi_address_low);
> > > +
> > > +     /* rc0-high-axi-address */
> > > +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> > > +                          CDNS_PCIE_HPA_AT_OB_REGION_CPU_ADDR1(0), 0x0);
> > > +     /* Type-1 CFG */
> > > +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> > > +                          CDNS_PCIE_HPA_AT_OB_REGION_DESC0(0), 0x05000000);
> > > +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> > > +                          CDNS_PCIE_HPA_AT_OB_REGION_DESC1(0),
> > > +                          (request_id_0 << 16));
> > > +
> > > +     /* All AXI bits pass through PCIe */
> > > +     cdns_pcie_hpa_writel(pcie, REG_BANK_AXI_SLAVE,
> > > +                          CDNS_PCIE_HPA_AT_OB_REGION_PCI_ADDR0(0), 0x1b);
> > > +     /* PCIe address-high */
> > 
> > What is this address?
> 
> Cadence IP register description:
> 
> AXI to PCIe Address Translation
> AXI Slave to PCIe Address Translation registers. Provides bits 31:8 of the
> PCIe address and the number of AXI address bits passed through.
> 
> The annotations here will be changed to:  /* AXI to PCIe Address Translation
> */

Okay.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

