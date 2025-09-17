Return-Path: <linux-pci+bounces-36384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81609B820D5
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 23:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 362D217923A
	for <lists+linux-pci@lfdr.de>; Wed, 17 Sep 2025 21:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD918309F19;
	Wed, 17 Sep 2025 21:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEgvKat0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD513D984;
	Wed, 17 Sep 2025 21:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146244; cv=none; b=paxgAPSb1Mboi9uoBiZmethYzZMxsLzgFhtphdjfhFtIJkYdKATwzT6gaTvfyyn/S9LK6lj9XFDOWxjk94WZ67ViX7I2zbiIsNRM2oRN0G7+rnios7Hh1qFQ87Lb2/QVdDh5KvqEiaOd2js+VQYxf30yDZh5DJVbVyEUaLJ0HVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146244; c=relaxed/simple;
	bh=HhzyC0ZZquIaoVW0wTN6cNxHYwm1q26N31dr9FfEXU4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZM50eZ8ipRcoe3eKM44a1m16F2NVV5RqczIA0R/dDeOVro/mWjChEN/zvmKOQxuF8hpWlHFLU0CGs6WLiTsk6EXrZ5mZqldr14es8C6+roBQxEHntAacI3EqCJKKRKP4f5/OaHDosgN5s+y4rG2Znjyf6NVpkOTpHLy5v0Og6y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEgvKat0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00465C4CEE7;
	Wed, 17 Sep 2025 21:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758146244;
	bh=HhzyC0ZZquIaoVW0wTN6cNxHYwm1q26N31dr9FfEXU4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=vEgvKat0epe6kqqVZtBbn30bTqELyhZ2f8QkxJejKvL25YakygsCf0EO8+P1S10wT
	 2XijqumznfrXxiFuWsNcr+dewYFNcGCyu8TeRuTHzFEtL1dF0Gy6F0TcL5Bz9o1xNo
	 UvXQkwn29eTB79mNiGuGtpuyNcX86BzG1McYGBe2YNUaVhV5A+BOLkAIcqrgtz5fTR
	 w5KtoqrV64Vm24hu/rQlgTgEgFJIS3ZoI3Qwb7+QlNA8flyA3G2FsHhNN+nT929R0T
	 M9h0d3zG5ZngswmHGVak/0tKnGp9fJwpVGjuVvxPCUEQbnxjSxZmT57c9hXeE2RZri
	 FSiHwkIFqcKqQ==
Date: Wed, 17 Sep 2025 16:57:22 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Randolph Lin <randolph@andestech.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alex@ghiti.fr,
	aou@eecs.berkeley.edu, palmer@dabbelt.com, paul.walmsley@sifive.com,
	ben717@andestech.com, inochiama@gmail.com,
	thippeswamy.havalige@amd.com, namcao@linutronix.de,
	shradha.t@samsung.com, randolph.sklin@gmail.com,
	tim609@andestech.com
Subject: Re: [PATCH v2 4/5] PCI: andes: Add Andes QiLai SoC PCIe host driver
 support
Message-ID: <20250917215722.GA1876729@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aMqmmd381sySCGnY@swlinux02>

On Wed, Sep 17, 2025 at 08:16:25PM +0800, Randolph Lin wrote:
> On Tue, Sep 16, 2025 at 09:46:52AM -0500, Bjorn Helgaas wrote:
> > On Tue, Sep 16, 2025 at 06:04:16PM +0800, Randolph Lin wrote:
> > > Add driver support for DesignWare based PCIe controller in Andes
> > > QiLai SoC. The driver only supports the Root Complex mode.

> > > +          Say Y here to enable PCIe controller support on Andes QiLai SoCs,
> > > +       which operate in Root Complex mode. The Andes QiLai SoCs PCIe
> > > +       controller is based on DesignWare IP (5.97a version) and therefore
> > > +       the driver re-uses the DesignWare core functions to implement the
> > > +       driver. The Andes QiLai SoC has three Root Complexes (RCs): one
> > > +       operates on PCIe 4.0 with 4 lanes at 0x80000000, while the other
> > > +       two operate on PCIe 4.0 with 2 lanes at 0xA0000000 and 0xC0000000,
> > > +       respectively.
> > 
> > I assume these addresses come from devicetree, so I don't think
> > there's any need to include them here.
> 
> I will add num-lanes property in the devicetree.

Don't add num-lanes to devicetree unless your driver requires it.
dw_pcie_host_init() uses dw_pcie_link_get_max_link_width() try to get
the lane width from PCI_EXP_LNKCAP.

> > > +static
> > > +bool qilai_pcie_outbound_atu_addr_valid(struct dw_pcie *pci,
> > > +                                     const struct dw_pcie_ob_atu_cfg *atu,
> > > +                                     u64 *limit_addr)
> > > +{
> > > +     u64 parent_bus_addr = atu->parent_bus_addr;
> > > +
> > > +     *limit_addr = parent_bus_addr + atu->size - 1;
> > > +
> > > +     /*
> > > +      * Addresses below 4 GB are not 1:1 mapped; therefore, range checks
> > > +      * only need to ensure addresses below 4 GB match pci->region_limit.
> > > +      */
> > > +     if (lower_32_bits(*limit_addr & ~pci->region_limit) !=
> > > +         lower_32_bits(parent_bus_addr & ~pci->region_limit) ||
> > > +         !IS_ALIGNED(parent_bus_addr, pci->region_align) ||
> > > +         !IS_ALIGNED(atu->pci_addr, pci->region_align) || !atu->size)
> > > +             return false;
> > 
> > Seems a little bit strange.  Is this something that could be expressed
> > via devicetree?  Or something peculiar about QiLai that's different
> > from all the other DWC-based controllers?
> 
> After reviewing both the code history and the bug tracking system,
> it turns out that this code doesn't even qualify as a valid
> workaround.  Apologies for having submitted it as a patch.
> 
> The root cause is that the iATU limits were not configured
> correctly.  The original design assumed at least 32GB or 128GB of
> BAR resource assignment, but the actual chip sets the iATU limit to
> only 4GB.  As a result, region_limit is always constrained by this
> 4GB boundary.
> 
> The correct workaround should be to program the iATU only for the
> 32-bit address space and skip iATU programming for the 64-bit space.
> A simple way to implement this workaround is to parse the
> num-viewport property from the devicetree and use this value
> directly, instead of relying on the result of reading
> PCIE_ATU_VIEWPORT.
> 
> I will attempt to implement it this way, but the correct method is
> not yet well-defined. Do you have any suggestions on how to modify
> the num-viewport property from the devicetree for use in the driver?
> It seems it will be modified in pcie-designware.c.

Nope, I don't know enough about DWC to give any advice, sorry!

> > > +static struct platform_driver qilai_pcie_driver = {
> > > +     .probe = qilai_pcie_probe,
> > > +     .driver = {
> > > +             .name   = "qilai-pcie",
> > > +             .of_match_table = qilai_pcie_of_match,
> > > +             /* only test passed at PROBE_DEFAULT_STRATEGY */
> > > +             .probe_type = PROBE_DEFAULT_STRATEGY,
> > 
> > This is the only use of PROBE_DEFAULT_STRATEGY in the entire tree, so
> > I doubt you need it.  If you do, please explain why in more detail.
> 
> In the V1 patch, the reviewer, Manivannan, suggested:
> "You should start using PROBE_PREFER_ASYNCHRONOUS."
> However, after setting up PROBE_PREFER_ASYNCHRONOUS, numerous errors
> were encountered during the EP device probe flow.
> Therefore, we would prefer to continue using PROBE_DEFAULT_STRATEGY.

I don't really know the details of probe_type.  But it sounds like the
errors with PROBE_PREFER_ASYNCHRONOUS should probably be debugged and
fixed.

If PROBE_PREFER_ASYNCHRONOUS can't be made to work, it sounds like you
should specify PROBE_FORCE_SYNCHRONOUS, because the comments suggest
that using PROBE_DEFAULT_STRATEGY means the driver should work with
either PROBE_FORCE_SYNCHRONOUS or PROBE_PREFER_ASYNCHRONOUS:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/device/driver.h?id=v6.16#n24

