Return-Path: <linux-pci+bounces-36348-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D21B7D3F3
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 14:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53B464668E0
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 12:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF0F337EB5;
	Wed, 17 Sep 2025 12:16:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DBE2FFF87
	for <linux-pci@vger.kernel.org>; Wed, 17 Sep 2025 12:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758111409; cv=none; b=b7qhN5g9z/ntBPJJv0E0NQ4I+yYnbGKwfslX2+pL8X+GRL1geZhyDfv2iHCCFeGPFL4j1CUgIIfIN/J2nGA3I9h4ZzPCZqNC1cb8ZZL2j5jPg2nJLyKLtGsuM1yPuE8wdtHdzONiqPhXau3UGcL53fdDFJW8wkBE45xQpT8LONI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758111409; c=relaxed/simple;
	bh=MnL+OLyGBlGIzgc1VK2Ha0TXloPlDmQ3gtUlcniYA5E=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qkj0ghTKlPSY8bM8u1OJFBXwpkhUNIo9UfDP82BviU2uSsorRYvQx+7nADx4Sz9OuADu/lTW8U7TDHCMtr+G0OAgay6ieG3WGhdeBsLZqofmFBX3K/bFCbKo8YFlFbN3LbRaGJLr01PBABp3sZZ+5Yg2oIJOrfVOIE3UruVwDaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 58HCGWNJ024712
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Sep 2025 20:16:32 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS31.andestech.com (10.0.1.89)
 with Microsoft SMTP Server id 14.3.498.0; Wed, 17 Sep 2025 20:16:32 +0800
Date: Wed, 17 Sep 2025 20:16:25 +0800
From: Randolph Lin <randolph@andestech.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <jingoohan1@gmail.com>, <mani@kernel.org>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <robh@kernel.org>, <bhelgaas@google.com>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <alex@ghiti.fr>,
        <aou@eecs.berkeley.edu>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <ben717@andestech.com>,
        <inochiama@gmail.com>, <thippeswamy.havalige@amd.com>,
        <namcao@linutronix.de>, <shradha.t@samsung.com>,
        <randolph.sklin@gmail.com>, <tim609@andestech.com>
Subject: Re: [PATCH v2 4/5] PCI: andes: Add Andes QiLai SoC PCIe host driver
 support
Message-ID: <aMqmmd381sySCGnY@swlinux02>
References: <20250916100417.3036847-5-randolph@andestech.com>
 <20250916144652.GA1795814@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250916144652.GA1795814@bhelgaas>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 58HCGWNJ024712

Hi Bjorn,

On Tue, Sep 16, 2025 at 09:46:52AM -0500, Bjorn Helgaas wrote:
> [EXTERNAL MAIL]
> 
> On Tue, Sep 16, 2025 at 06:04:16PM +0800, Randolph Lin wrote:
> > Add driver support for DesignWare based PCIe controller in Andes
> > QiLai SoC. The driver only supports the Root Complex mode.
> 
> > +config PCIE_ANDES_QILAI
> > +     bool "ANDES QiLai PCIe controller"
> > +     depends on OF && (RISCV || COMPILE_TEST)
> > +     depends on PCI_MSI
> > +     depends on ARCH_ANDES
> 
> This prevents a lot of compile testing.  AFAICT, no other controller
> depends directly on the arch.  Most do something like these:
> 
>   depends on MACH_ARTPEC6 || COMPILE_TEST
>   depends on ARCH_MXC || COMPILE_TEST
>   depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
> 

ok.

> > +     select PCIE_DW_HOST
> > +     help
> > +          Say Y here to enable PCIe controller support on Andes QiLai SoCs,
> > +       which operate in Root Complex mode. The Andes QiLai SoCs PCIe
> > +       controller is based on DesignWare IP (5.97a version) and therefore
> > +       the driver re-uses the DesignWare core functions to implement the
> > +       driver. The Andes QiLai SoC has three Root Complexes (RCs): one
> > +       operates on PCIe 4.0 with 4 lanes at 0x80000000, while the other
> > +       two operate on PCIe 4.0 with 2 lanes at 0xA0000000 and 0xC0000000,
> > +       respectively.
> 
> I assume these addresses come from devicetree, so I don't think
> there's any need to include them here.
> 

I will add num-lanes property in the devicetree.

> Fix space/tab indentation issue on first line of help text.  Do the
> indentation the same way as the rest of the file.
> 

I'm sorry for making this mistake.

> > + * Refer to Table A4-5 (Memory type encoding) in the
> > + * AMBA AXI and ACE Protocol Specification.
> > + * The selected value corresponds to the Memory type field:
> > + * "Write-back, Read and Write-allocate".
> 
> Add blank line between paragraphs or rewrap into a single paragraph.
> 

Ok.

> > +static
> > +bool qilai_pcie_outbound_atu_addr_valid(struct dw_pcie *pci,
> > +                                     const struct dw_pcie_ob_atu_cfg *atu,
> > +                                     u64 *limit_addr)
> > +{
> > +     u64 parent_bus_addr = atu->parent_bus_addr;
> > +
> > +     *limit_addr = parent_bus_addr + atu->size - 1;
> > +
> > +     /*
> > +      * Addresses below 4 GB are not 1:1 mapped; therefore, range checks
> > +      * only need to ensure addresses below 4 GB match pci->region_limit.
> > +      */
> > +     if (lower_32_bits(*limit_addr & ~pci->region_limit) !=
> > +         lower_32_bits(parent_bus_addr & ~pci->region_limit) ||
> > +         !IS_ALIGNED(parent_bus_addr, pci->region_align) ||
> > +         !IS_ALIGNED(atu->pci_addr, pci->region_align) || !atu->size)
> > +             return false;
> 
> Seems a little bit strange.  Is this something that could be expressed
> via devicetree?  Or something peculiar about QiLai that's different
> from all the other DWC-based controllers?
> 

After reviewing both the code history and the bug tracking system, it turns out
that this code doesn't even qualify as a valid workaround.
Apologies for having submitted it as a patch.

The root cause is that the iATU limits were not configured correctly.
The original design assumed at least 32GB or 128GB of BAR resource assignment,
but the actual chip sets the iATU limit to only 4GB.
As a result, region_limit is always constrained by this 4GB boundary.

The correct workaround should be to program the iATU only for the 32-bit address
space and skip iATU programming for the 64-bit space. A simple way to implement
this workaround is to parse the num-viewport property from the devicetree and
use this value directly, instead of relying on the result of reading
PCIE_ATU_VIEWPORT.

I will attempt to implement it this way, but the correct method is not yet
well-defined. Do you have any suggestions on how to modify the num-viewport
property from the devicetree for use in the driver?
It seems it will be modified in pcie-designware.c.

> > + * Setup the Qilai PCIe IOCP (IO Coherence Port) Read/Write Behaviors to the
> > + * Write-Back, Read and Write Allocate mode.
> > + * The IOCP HW target is SoC last-level cache (L2 Cache), which serves as the
> > + * system cache.
> > + * The IOCP HW helps maintain cache monitoring, ensuring that the device can
> > + * snoop data from/to the cache.
> 
> Add blank lines between paragraphs (or rewrap into a single paragraph
> if that's what you intend).
> 

Ok.

> > +static struct platform_driver qilai_pcie_driver = {
> > +     .probe = qilai_pcie_probe,
> > +     .driver = {
> > +             .name   = "qilai-pcie",
> > +             .of_match_table = qilai_pcie_of_match,
> > +             /* only test passed at PROBE_DEFAULT_STRATEGY */
> > +             .probe_type = PROBE_DEFAULT_STRATEGY,
> 
> This is the only use of PROBE_DEFAULT_STRATEGY in the entire tree, so
> I doubt you need it.  If you do, please explain why in more detail.
> 

In the V1 patch, the reviewer, Manivannan, suggested:
"You should start using PROBE_PREFER_ASYNCHRONOUS."
However, after setting up PROBE_PREFER_ASYNCHRONOUS, numerous errors
were encountered during the EP device probe flow.
Therefore, we would prefer to continue using PROBE_DEFAULT_STRATEGY.

> Bjorn

Sincerely,
Randolph

