Return-Path: <linux-pci+bounces-36419-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E5FB84B22
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 14:55:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59AC21B20F68
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 12:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737232D3207;
	Thu, 18 Sep 2025 12:55:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net [60.248.80.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ABD283FD0
	for <linux-pci@vger.kernel.org>; Thu, 18 Sep 2025 12:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.248.80.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200127; cv=none; b=HVBhI2kWxN4IgvcuHApJZ4cTja1ZNekio0w0nCse5CYRCC2ZN8AweAh4GMuwNGZnR9V1ItOyoSPQYqghD6axWdz3Afq06OYGtQagfgJYxB8F+q9nTF40o9J+3G08L5liCiLWkv3DPeUcvnXzpRHvgT9drA5YppNOPo8/MYJqqgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200127; c=relaxed/simple;
	bh=m3EqRKAwY9UDXyEPAWoe177Ipr31uPyNxTxWRE0I8Lg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sjYtaqsWF1s7x1dB6D4/En1TxFFqZM+okx/++0vKROn8McZ7tgcLaMNMI/2J/gCqS6J/OPnaxsEhxQsyRdZRRM7R6i3GGWN7IKYP196RekZg0RIRTcT6RIIdQ2bX+/kaTtO5b37l6IXGJdNGb7ltU+ebsDAaukjJWe0qX+sKq3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com; spf=pass smtp.mailfrom=andestech.com; arc=none smtp.client-ip=60.248.80.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=permerror header.from=andestech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=andestech.com
Received: from mail.andestech.com (ATCPCS31.andestech.com [10.0.1.89])
	by Atcsqr.andestech.com with ESMTPS id 58ICsllo009181
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 20:54:47 +0800 (+08)
	(envelope-from randolph@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS31.andestech.com (10.0.1.89)
 with Microsoft SMTP Server id 14.3.498.0; Thu, 18 Sep 2025 20:54:47 +0800
Date: Thu, 18 Sep 2025 20:54:40 +0800
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
Message-ID: <aMwBEBNo0AAxlfHx@swlinux02>
References: <aMqmmd381sySCGnY@swlinux02>
 <20250917215722.GA1876729@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250917215722.GA1876729@bhelgaas>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-DKIM-Results: atcpcs31.andestech.com; dkim=none;
X-DNSRBL: 
X-SPAM-SOURCE-CHECK: pass
X-MAIL:Atcsqr.andestech.com 58ICsllo009181

Hi Bjorn,

On Wed, Sep 17, 2025 at 04:57:22PM -0500, Bjorn Helgaas wrote:
> [EXTERNAL MAIL]
> 
> On Wed, Sep 17, 2025 at 08:16:25PM +0800, Randolph Lin wrote:
> > On Tue, Sep 16, 2025 at 09:46:52AM -0500, Bjorn Helgaas wrote:
> > > On Tue, Sep 16, 2025 at 06:04:16PM +0800, Randolph Lin wrote:
> > > > Add driver support for DesignWare based PCIe controller in Andes
> > > > QiLai SoC. The driver only supports the Root Complex mode.
> 
> > > > +          Say Y here to enable PCIe controller support on Andes QiLai SoCs,
> > > > +       which operate in Root Complex mode. The Andes QiLai SoCs PCIe
> > > > +       controller is based on DesignWare IP (5.97a version) and therefore
> > > > +       the driver re-uses the DesignWare core functions to implement the
> > > > +       driver. The Andes QiLai SoC has three Root Complexes (RCs): one
> > > > +       operates on PCIe 4.0 with 4 lanes at 0x80000000, while the other
> > > > +       two operate on PCIe 4.0 with 2 lanes at 0xA0000000 and 0xC0000000,
> > > > +       respectively.
> > >
> > > I assume these addresses come from devicetree, so I don't think
> > > there's any need to include them here.
> >
> > I will add num-lanes property in the devicetree.
> 
> Don't add num-lanes to devicetree unless your driver requires it.
> dw_pcie_host_init() uses dw_pcie_link_get_max_link_width() try to get
> the lane width from PCI_EXP_LNKCAP.
>

ok.

> > > > +static
> > > > +bool qilai_pcie_outbound_atu_addr_valid(struct dw_pcie *pci,
> > > > +                                     const struct dw_pcie_ob_atu_cfg *atu,
> > > > +                                     u64 *limit_addr)
> > > > +{
> > > > +     u64 parent_bus_addr = atu->parent_bus_addr;
> > > > +
> > > > +     *limit_addr = parent_bus_addr + atu->size - 1;
> > > > +
> > > > +     /*
> > > > +      * Addresses below 4 GB are not 1:1 mapped; therefore, range checks
> > > > +      * only need to ensure addresses below 4 GB match pci->region_limit.
> > > > +      */
> > > > +     if (lower_32_bits(*limit_addr & ~pci->region_limit) !=
> > > > +         lower_32_bits(parent_bus_addr & ~pci->region_limit) ||
> > > > +         !IS_ALIGNED(parent_bus_addr, pci->region_align) ||
> > > > +         !IS_ALIGNED(atu->pci_addr, pci->region_align) || !atu->size)
> > > > +             return false;
> > >
> > > Seems a little bit strange.  Is this something that could be expressed
> > > via devicetree?  Or something peculiar about QiLai that's different
> > > from all the other DWC-based controllers?
> >
> > After reviewing both the code history and the bug tracking system,
> > it turns out that this code doesn't even qualify as a valid
> > workaround.  Apologies for having submitted it as a patch.
> >
> > The root cause is that the iATU limits were not configured
> > correctly.  The original design assumed at least 32GB or 128GB of
> > BAR resource assignment, but the actual chip sets the iATU limit to
> > only 4GB.  As a result, region_limit is always constrained by this
> > 4GB boundary.
> >
> > The correct workaround should be to program the iATU only for the
> > 32-bit address space and skip iATU programming for the 64-bit space.
> > A simple way to implement this workaround is to parse the
> > num-viewport property from the devicetree and use this value
> > directly, instead of relying on the result of reading
> > PCIE_ATU_VIEWPORT.
> >
> > I will attempt to implement it this way, but the correct method is
> > not yet well-defined. Do you have any suggestions on how to modify
> > the num-viewport property from the devicetree for use in the driver?
> > It seems it will be modified in pcie-designware.c.
> 
> Nope, I don't know enough about DWC to give any advice, sorry!
> 
> > > > +static struct platform_driver qilai_pcie_driver = {
> > > > +     .probe = qilai_pcie_probe,
> > > > +     .driver = {
> > > > +             .name   = "qilai-pcie",
> > > > +             .of_match_table = qilai_pcie_of_match,
> > > > +             /* only test passed at PROBE_DEFAULT_STRATEGY */
> > > > +             .probe_type = PROBE_DEFAULT_STRATEGY,
> > >
> > > This is the only use of PROBE_DEFAULT_STRATEGY in the entire tree, so
> > > I doubt you need it.  If you do, please explain why in more detail.
> >
> > In the V1 patch, the reviewer, Manivannan, suggested:
> > "You should start using PROBE_PREFER_ASYNCHRONOUS."
> > However, after setting up PROBE_PREFER_ASYNCHRONOUS, numerous errors
> > were encountered during the EP device probe flow.
> > Therefore, we would prefer to continue using PROBE_DEFAULT_STRATEGY.
> 
> I don't really know the details of probe_type.  But it sounds like the
> errors with PROBE_PREFER_ASYNCHRONOUS should probably be debugged and
> fixed.
> 
> If PROBE_PREFER_ASYNCHRONOUS can't be made to work, it sounds like you
> should specify PROBE_FORCE_SYNCHRONOUS, because the comments suggest
> that using PROBE_DEFAULT_STRATEGY means the driver should work with
> either PROBE_FORCE_SYNCHRONOUS or PROBE_PREFER_ASYNCHRONOUS:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/device/driver.h?id=v6.16#n24

refer to the following patches:
    91703041697c ("PCI: Allow built-in drivers to use async initial probing")
    8e77d3d59d7b ("Revert "usb: xhci-pci: Set PROBE_PREFER_ASYNCHRONOUS"")

We can continue using PROBE_PREFER_ASYNCHRONOUS.
When used with drivers that support it, such as NVMe, the system behaves as
expected. In the past, we primarily used Renesas xHCI controller.

Sincerely,
Randolph

