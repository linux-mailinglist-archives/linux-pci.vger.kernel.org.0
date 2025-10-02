Return-Path: <linux-pci+bounces-37430-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E84F8BB40C0
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 15:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E902A8514
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 13:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D03B31354A;
	Thu,  2 Oct 2025 13:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gHCp6t6V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFBD313544;
	Thu,  2 Oct 2025 13:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759411847; cv=none; b=moiPaGZumCW7LKHA63zhQ9u6gs9vc6T5nk/8ahXei6IFQWuVY2P9tPH1BTNK1o3mJXtKtPWYMv20irY8LwGypmlfQJxH3wzyTWEKq87/tXkxPH0L+J1Qx7jaPpIEOOtt4yHdYKybzZ+bjjbHt/779WxgNpNkUi0WhDnHNYgEeZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759411847; c=relaxed/simple;
	bh=+ABiHpsDLSEB54zWZR+RxbOrDxj3riKvPPAfnTqD4Qw=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ID0qtFiDVHLl60mGmcdHbmWd/hRUTkAhK3LvDF9dDQEN5Go3d+aagqNb5WAr3WSXh7SKSKJKWseRBKyA4i4lB6RGJPJYS1sQS1nDWIsjCljSisgrMAAg5FhqWX/aLG7DSxLWY1wcs23LqrGxRWp51hvXClofzO0z5OqMOlQ3/RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gHCp6t6V; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759411845; x=1790947845;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+ABiHpsDLSEB54zWZR+RxbOrDxj3riKvPPAfnTqD4Qw=;
  b=gHCp6t6VjHsiQD198AHDAe1d9xO5YUiMMlw3p3NQ9hQ9h98lI968H9Yv
   tG9EzuloWF6K2sp8nv/zSn5yPFWNNH2XCThKbLcJKl8djNdgfBzvqmhA9
   kkk1ZdprVZjg+OFT9E5EReHt55zy1Wp8ZpyL8Z/oaLGwXpDzqpCPCo7wb
   htQGTZD1Lj2lwWc5szVlO5pUZ75NuBgfj530Nm8c69/TWZhQ6vEO7Kiax
   vwmys/eA+0XjRqnfS6qoAqKYsSgg07B5MkaeDpuUzZAmxHTp5gtNV6KFl
   VSaTIwps5/X+yB2rb0XIgEhlL8U1t+hKfCIqX5+krNdEF7gb1ohb2O2uK
   g==;
X-CSE-ConnectionGUID: UhvqwNFZT7KcBcilny+Mdg==
X-CSE-MsgGUID: f4nc/fAvQ/SKX1AtNIu49A==
X-IronPort-AV: E=McAfee;i="6800,10657,11570"; a="72366497"
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="72366497"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 06:30:44 -0700
X-CSE-ConnectionGUID: Uo9yfzIPSUSr/ZZEgvkP8w==
X-CSE-MsgGUID: 0h67OrxvToivsHsTs964rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,309,1751266800"; 
   d="scan'208";a="178150411"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.246])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 06:30:40 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 2 Oct 2025 16:30:36 +0300 (EEST)
To: dan.j.williams@intel.com
cc: Xu Yilun <yilun.xu@linux.intel.com>, linux-coco@lists.linux.dev, 
    linux-pci@vger.kernel.org, yilun.xu@intel.com, baolu.lu@linux.intel.com, 
    zhenzhong.duan@intel.com, aneesh.kumar@kernel.org, bhelgaas@google.com, 
    aik@amd.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] PCI/IDE: Add Address Association Register setup for
 RP
In-Reply-To: <68dd8d20aafb4_1fa2100f0@dwillia2-mobl4.notmuch>
Message-ID: <481228e4-72d4-bfbb-5e25-660bfea1327d@linux.intel.com>
References: <20250928062756.2188329-1-yilun.xu@linux.intel.com> <20250928062756.2188329-3-yilun.xu@linux.intel.com> <68dd8d20aafb4_1fa2100f0@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Wed, 1 Oct 2025, dan.j.williams@intel.com wrote:

> [ Add Ilpo for resource_assigned() usage proposal below ]
> 
> Xu Yilun wrote:
> > Add Address Association Register setup for Root Ports.
> 
> Perhaps it would be more accurate to call this "Address Association for
> downstream MMIO" to clearly distinguish it from memory cycles targetting
> the root port.
> 
> > The address ranges for RP side Address Association Registers should
> > cover memory addresses for all PFs/VFs/downstream devices of the DSM
> > device. A simple solution is to get the aggregated 32-bit and 64-bit
> > address ranges from directly connected downstream port (either an RP or
> > a switch port) and set into 2 Address Association Register blocks.
> 
> For the bridge the split is not 32-bit vs 64-bit. The split is
> non-prefetchable vs prefetchable where the latter is potentially 64-bit,
> but not always.
> 
> > There is a case the platform doesn't require Address Association
> > Registers setup and provides no register block for RP (AMD). Will skip
> > the setup in pci_ide_stream_setup().
> 
> Instead of calling out architecture specific details this can say
> 
> "Just like RID association, address associations will be set by default
> if hardware sets 'Number of Address Association Register Blocks' in the
> 'Selective IDE Stream Capability Register' to a non-zero value.
> Alternatively, TSM drivers can opt-out of the settings by zero'ing out
> the probed region."
> 
> > Also imaging another case where there is only one block for RP.
> > Prioritize 64-bit address ranges setup for it. No strong reason for the
> > preference until a real use case comes.
> 
> Rather than invent a new a policy just follow the PCI bridge
> specification precedent where memory is mandatory and
> prefetchable-memory is optional. If a bridge maps both, check if the
> device needs both. If the device needs both and the platform only
> provides 1 address association block then setup the non-optional BAR
> first. If that results in an incomplete solution that is a quirk that
> the vendor needs to solve, not the core PCI implementation.
> 
> Specifically, if that happens, the solution might be either a quirk to
> disable address associations, or a quirk to disable one of the ranges.
> Which path to take is unknown until there is a practical problem to
> solve.
> 
> > The Address Association Register setup for Endpoint Side is still
> > uncertain so isn't supported in this patch.
> > 
> > Take the oppotunity to export some mini helpers for Address Association
> > Registers setup. TDX Connect needs the provided aggregated address
> > ranges but will use specific firmware calls for actual setup instead of
> > pci_ide_stream_setup().
> > 
> > Co-developed-by: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> > Co-developed-by: Arto Merilainen <amerilainen@nvidia.com>
> > Signed-off-by: Arto Merilainen <amerilainen@nvidia.com>
> > Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> > ---
> >  include/linux/pci-ide.h | 11 +++++++
> >  drivers/pci/ide.c       | 64 ++++++++++++++++++++++++++++++++++++++++-
> >  2 files changed, 74 insertions(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> > index 5adbd8b81f65..ac84fb611963 100644
> > --- a/include/linux/pci-ide.h
> > +++ b/include/linux/pci-ide.h
> > @@ -6,6 +6,15 @@
> >  #ifndef __PCI_IDE_H__
> >  #define __PCI_IDE_H__
> >  
> > +#define SEL_ADDR1_LOWER GENMASK(31, 20)
> > +#define SEL_ADDR_UPPER GENMASK_ULL(63, 32)
> > +#define PREP_PCI_IDE_SEL_ADDR1(base, limit)                    \
> > +	(FIELD_PREP(PCI_IDE_SEL_ADDR_1_VALID, 1) |             \
> > +	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_BASE_LOW,          \
> > +		    FIELD_GET(SEL_ADDR1_LOWER, (base))) | \
> > +	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_LIMIT_LOW,         \
> > +		    FIELD_GET(SEL_ADDR1_LOWER, (limit))))
> > +
> >  #define PREP_PCI_IDE_SEL_RID_2(base, domain)               \
> >  	(FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |          \
> >  	 FIELD_PREP(PCI_IDE_SEL_RID_2_BASE, (base)) | \
> > @@ -42,6 +51,8 @@ struct pci_ide_partner {
> >  	unsigned int default_stream:1;
> >  	unsigned int setup:1;
> >  	unsigned int enable:1;
> > +	struct range mem32;
> > +	struct range mem64;
> >  };
> >  
> >  /**
> > diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> > index 7633b8e52399..8db1163737e5 100644
> > --- a/drivers/pci/ide.c
> > +++ b/drivers/pci/ide.c
> > @@ -159,7 +159,11 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
> >  	struct stream_index __stream[PCI_IDE_HB + 1];
> >  	struct pci_host_bridge *hb;
> >  	struct pci_dev *rp;
> > +	struct pci_dev *br;
> >  	int num_vf, rid_end;
> > +	struct range mem32 = {}, mem64 = {};
> 
> Per-above these should be mem_assoc, and pref_assoc;
> 
> > +	struct pci_bus_region region;
> > +	struct resource *res;
> >  
> >  	if (!pci_is_pcie(pdev))
> >  		return NULL;
> > @@ -206,6 +210,24 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
> >  	else
> >  		rid_end = pci_dev_id(pdev);
> >  
> > +	br = pci_upstream_bridge(pdev);
> > +	if (!br)
> > +		return NULL;
> > +
> > +	res = &br->resource[PCI_BRIDGE_MEM_WINDOW];
> > +	if (res->flags & IORESOURCE_MEM) {
> 
> Per Ilpo this can now just be a size check.

I don't know why you said this about size as you implemented it below 
correctly using res->parent check (inside resource_assigned()).

> > +		pcibios_resource_to_bus(br->bus, &region, res);
> > +		mem32.start = region.start;
> > +		mem32.end = region.end;
> > +	}
> > +
> > +	res = &br->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
> > +	if (res->flags & IORESOURCE_PREFETCH) {
> > +		pcibios_resource_to_bus(br->bus, &region, res);
> > +		mem64.start = region.start;
> > +		mem64.end = region.end;
> > +	}
> > +
> >  	*ide = (struct pci_ide) {
> >  		.pdev = pdev,
> >  		.partner = {
> > @@ -218,6 +240,8 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
> >  				.rid_start = pci_dev_id(pdev),
> >  				.rid_end = rid_end,
> >  				.stream_index = no_free_ptr(rp_stream)->stream_index,
> > +				.mem32 = mem32,
> > +				.mem64 = mem64,
> >  			},
> >  		},
> >  		.host_bridge_stream = no_free_ptr(hb_stream)->stream_index,
> > @@ -397,6 +421,21 @@ static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide,
> >  	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
> >  }
> >  
> > +static void set_ide_sel_addr(struct pci_dev *pdev, int pos, int assoc_idx,
> > +			     struct range *mem)
> > +{
> > +	u32 val;
> > +
> > +	val = PREP_PCI_IDE_SEL_ADDR1(mem->start, mem->end);
> > +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(assoc_idx), val);
> > +
> > +	val = FIELD_GET(SEL_ADDR_UPPER, mem->end);
> > +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(assoc_idx), val);
> > +
> > +	val = FIELD_GET(SEL_ADDR_UPPER, mem->start);
> > +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(assoc_idx), val);
> > +}
> > +
> >  /**
> >   * pci_ide_stream_setup() - program settings to Selective IDE Stream registers
> >   * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> > @@ -410,6 +449,7 @@ static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide,
> >  void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
> >  {
> >  	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> > +	u8 assoc_idx = 0;
> >  	int pos;
> >  	u32 val;
> >  
> > @@ -424,6 +464,21 @@ void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
> >  	val = PREP_PCI_IDE_SEL_RID_2(settings->rid_start, pci_ide_domain(pdev));
> >  	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
> >  
> > +	/*
> > +	 * Feel free to change the default stratagy, Intel & AMD don't directly
> > +	 * setup RP registers.
> > +	 *
> > +	 * 64 bit memory first, assuming it's more popular.
> > +	 */
> > +	if (assoc_idx < pdev->nr_ide_mem && settings->mem64.end != 0) {
> > +		set_ide_sel_addr(pdev, pos, assoc_idx, &settings->mem64);
> > +		assoc_idx++;
> > +	}
> > +
> > +	/* 64 bit memory in lower block and 32 bit in higher block, any risk? */
> > +	if (assoc_idx < pdev->nr_ide_mem && settings->mem32.end != 0)
> > +		set_ide_sel_addr(pdev, pos, assoc_idx, &settings->mem32);
> > +
> 
> Per-above, just drop the 64-bit policy and assumption. It will naturally
> fail if the required number of address associations is insufficient.
> I.e. either we are in the AMD situation and no amount of address
> association is required, or we are in the ARM / Intel situation where it
> assigns memory then prefetch-memory (if both are present). If both of
> those are required and the hardware only supports 1 address association
> then that hardware vendor is responsible for figuring out a quirk.
> 
> Otherwise Linux expects that any hardware that requires address
> association always produces at least 2 address association blocks at the
> root port, or otherwise arranges for only one memory window type to be
> active.
> 
> >  	/*
> >  	 * Setup control register early for devices that expect
> >  	 * stream_id is set during key programming.
> > @@ -445,7 +500,7 @@ EXPORT_SYMBOL_GPL(pci_ide_stream_setup);
> >  void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide)
> >  {
> >  	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> > -	int pos;
> > +	int pos, i;
> >  
> >  	if (!settings)
> >  		return;
> > @@ -453,6 +508,13 @@ void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide)
> >  	pos = sel_ide_offset(pdev, settings);
> >  
> >  	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
> > +
> > +	for (i = 0; i < pdev->nr_ide_mem; i++) {
> > +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(i), 0);
> > +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(i), 0);
> > +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(i), 0);
> > +	}
> 
> Hmm, if we are going to clear all on stop then probably should also
> clear all unused on setup just to be consistent.
> 
> > +
> >  	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, 0);
> >  	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, 0);
> >  	settings->setup = 0;
> > -- 
> > 2.25.1
> > 
> 
> Here are the proposed incremental changes addressing the above. The new
> pci_ide_stream_to_regs() helper can later be exported to TSM drivers
> that need a formatted copy of the register settings. I prefer that to
> exporting the internals (the PREP_() macros for register setup and the
> pci_ide_domain()).
> 
> -- >8 --
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index b46e42bcafe3..e7c14ce1b1d0 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -336,6 +336,12 @@ static inline bool resource_union(const struct resource *r1, const struct resour
>  	return true;
>  }
>  
> +/* Check if this resource is added to a resource tree or detached. */
> +static inline bool resource_assigned(struct resource *res)
> +{
> +	return res->parent != NULL;
> +}
> +
>  int find_resource_space(struct resource *root, struct resource *new,
>  			resource_size_t size, struct resource_constraint *constraint);
>  
> diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> index ad4fcde75a56..4e33fa6944a1 100644
> --- a/include/linux/pci-ide.h
> +++ b/include/linux/pci-ide.h
> @@ -28,6 +28,9 @@ enum pci_ide_partner_select {
>   * @rid_start: Partner Port Requester ID range start
>   * @rid_end: Partner Port Requester ID range end
>   * @stream_index: Selective IDE Stream Register Block selection
> + * @mem_assoc: PCI bus memory address association for targetting peer partner
> + * @pref_assoc: (optional) PCI bus prefetchable memory address association for
> + *		targetting peer partner
>   * @default_stream: Endpoint uses this stream for all upstream TLPs regardless of
>   *		    address and RID association registers
>   * @setup: flag to track whether to run pci_ide_stream_teardown() for this
> @@ -38,11 +41,33 @@ struct pci_ide_partner {
>  	u16 rid_start;
>  	u16 rid_end;
>  	u8 stream_index;
> +	struct pci_bus_region mem_assoc;
> +	struct pci_bus_region pref_assoc;
>  	unsigned int default_stream:1;
>  	unsigned int setup:1;
>  	unsigned int enable:1;
> -	struct range mem32;
> -	struct range mem64;
> +};
> +
> +/**
> + * struct pci_ide_regs - Hardware register association settings for Selective
> + *			 IDE Streams
> + * @rid_1: IDE RID Association Register 1
> + * @rid_2: IDE RID Association Register 2
> + * @addr: Up to two address association blocks (IDE Address Association Register
> + *	  1 through 3) for MMIO and prefetchable MMIO
> + * @nr_addr: Number of address association blocks initialized
> + *
> + * See pci_ide_stream_to_regs()
> + */
> +struct pci_ide_regs {
> +	u32 rid_1;
> +	u32 rid_2;
> +	struct {
> +		u32 assoc1;
> +		u32 assoc2;
> +		u32 assoc3;
> +	} addr[2];
> +	int nr_addr;
>  };
>  
>  /**
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 3a71f30211a5..ca97590de116 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -877,6 +877,11 @@ struct pci_bus_region {
>  	pci_bus_addr_t	end;
>  };
>  
> +static inline pci_bus_addr_t pci_bus_region_size(const struct pci_bus_region *region)
> +{
> +	return region->end - region->start + 1;
> +}
> +
>  struct pci_dynids {
>  	spinlock_t		lock;	/* Protects list, index */
>  	struct list_head	list;	/* For IDs added at runtime */
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index 7b2aa0b30376..8e30b75f1f4d 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c
> @@ -157,13 +157,13 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
>  {
>  	/* EP, RP, + HB Stream allocation */
>  	struct stream_index __stream[PCI_IDE_HB + 1];
> +	struct pci_bus_region pref_assoc = { 0, -1 };
> +	struct pci_bus_region mem_assoc = { 0, -1 };
> +	struct resource *res, *mem, *pref;
>  	struct pci_host_bridge *hb;
> +	int num_vf, rid_end;
>  	struct pci_dev *rp;
>  	struct pci_dev *br;
> -	int num_vf, rid_end;
> -	struct range mem32 = {}, mem64 = {};
> -	struct pci_bus_region region;
> -	struct resource *res;
>  
>  	if (!pci_is_pcie(pdev))
>  		return NULL;
> @@ -214,18 +214,20 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
>  	if (!br)
>  		return NULL;
>  
> -	res = &br->resource[PCI_BRIDGE_MEM_WINDOW];
> -	if (res->flags & IORESOURCE_MEM) {
> -		pcibios_resource_to_bus(br->bus, &region, res);
> -		mem32.start = region.start;
> -		mem32.end = region.end;
> -	}
> -
> -	res = &br->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
> -	if (res->flags & IORESOURCE_PREFETCH) {
> -		pcibios_resource_to_bus(br->bus, &region, res);
> -		mem64.start = region.start;
> -		mem64.end = region.end;
> +	/*
> +	 * Check if the device consumes memory and/or prefetch-memory. Setup
> +	 * downstream address association ranges for each.
> +	 */
> +	mem = pci_resource_n(br, PCI_BRIDGE_MEM_WINDOW);
> +	pref = pci_resource_n(br, PCI_BRIDGE_PREF_MEM_WINDOW);
> +	pci_dev_for_each_resource(pdev, res) {
> +		if (resource_assigned(mem) && resource_contains(mem, res) &&
> +		    !pci_bus_region_size(&mem_assoc))
> +			pcibios_resource_to_bus(br->bus, &mem_assoc, mem);
> +
> +		if (resource_assigned(pref) && resource_contains(pref, res) &&
> +		    !pci_bus_region_size(&pref_assoc))
> +			pcibios_resource_to_bus(br->bus, &pref_assoc, pref);
>  	}
>  
>  	*ide = (struct pci_ide) {
> @@ -235,13 +237,16 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
>  				.rid_start = pci_dev_id(rp),
>  				.rid_end = pci_dev_id(rp),
>  				.stream_index = no_free_ptr(ep_stream)->stream_index,
> +				/* Disable upstream address association */
> +				.mem_assoc = { 0, -1 },
> +				.pref_assoc = { 0, -1 },
>  			},
>  			[PCI_IDE_RP] = {
>  				.rid_start = pci_dev_id(pdev),
>  				.rid_end = rid_end,
>  				.stream_index = no_free_ptr(rp_stream)->stream_index,
> -				.mem32 = mem32,
> -				.mem64 = mem64,
> +				.mem_assoc = mem_assoc,
> +				.pref_assoc = pref_assoc,
>  			},
>  		},
>  		.host_bridge_stream = no_free_ptr(hb_stream)->stream_index,
> @@ -420,19 +425,61 @@ static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide,
>  	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
>  }
>  
> -static void set_ide_sel_addr(struct pci_dev *pdev, int pos, int assoc_idx,
> -			     struct range *mem)
> +#define SEL_ADDR1_LOWER GENMASK(31, 20)
> +#define SEL_ADDR_UPPER GENMASK_ULL(63, 32)
> +#define PREP_PCI_IDE_SEL_ADDR1(base, limit)               \
> +	(FIELD_PREP(PCI_IDE_SEL_ADDR_1_VALID, 1) |        \
> +	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_BASE_LOW,          \
> +		    FIELD_GET(SEL_ADDR1_LOWER, (base))) | \
> +	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_LIMIT_LOW,         \
> +		    FIELD_GET(SEL_ADDR1_LOWER, (limit))))
> +
> +static void mem_assoc_to_regs(struct pci_bus_region *region,
> +			      struct pci_ide_regs *regs, int idx)
>  {
> -	u32 val;
> +	regs->addr[idx].assoc1 =
> +		PREP_PCI_IDE_SEL_ADDR1(region->start, region->end);
> +	regs->addr[idx].assoc2 = FIELD_GET(SEL_ADDR_UPPER, region->end);
> +	regs->addr[idx].assoc3 = FIELD_GET(SEL_ADDR_UPPER, region->start);
> +}
> +
> +/**
> + * pci_ide_stream_to_regs() - convert IDE settings to association register values
> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> + * @ide: registered IDE settings descriptor
> + * @regs: output register values
> + */
> +static void pci_ide_stream_to_regs(struct pci_dev *pdev, struct pci_ide *ide,
> +				   struct pci_ide_regs *regs)
> +{
> +	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> +	int pos, assoc_idx = 0;
> +
> +	memset(regs, 0, sizeof(*regs));
> +
> +	if (!settings)
> +		return;
>  
> -	val = PREP_PCI_IDE_SEL_ADDR1(mem->start, mem->end);
> -	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(assoc_idx), val);
> +	pos = sel_ide_offset(pdev, settings);
> +
> +	regs->rid_1 = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT, settings->rid_end);
> +
> +	regs->rid_2 = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
> +		      FIELD_PREP(PCI_IDE_SEL_RID_2_BASE, settings->rid_start) |
> +		      FIELD_PREP(PCI_IDE_SEL_RID_2_SEG, pci_ide_domain(pdev));
> +
> +	if (pdev->nr_ide_mem && pci_bus_region_size(&settings->mem_assoc)) {
> +		mem_assoc_to_regs(&settings->mem_assoc, regs, assoc_idx);
> +		assoc_idx++;
> +	}
>  
> -	val = FIELD_GET(SEL_ADDR_UPPER, mem->end);
> -	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(assoc_idx), val);
> +	if (pdev->nr_ide_mem > assoc_idx &&
> +	    pci_bus_region_size(&settings->pref_assoc)) {
> +		mem_assoc_to_regs(&settings->pref_assoc, regs, assoc_idx);
> +		assoc_idx++;
> +	}
>  
> -	val = FIELD_GET(SEL_ADDR_UPPER, mem->start);
> -	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(assoc_idx), val);
> +	regs->nr_addr = assoc_idx;
>  }
>  
>  /**
> @@ -448,38 +495,34 @@ static void set_ide_sel_addr(struct pci_dev *pdev, int pos, int assoc_idx,
>  void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
>  {
>  	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> -	u8 assoc_idx = 0;
> +	struct pci_ide_regs regs;
>  	int pos;
> -	u32 val;
>  
>  	if (!settings)
>  		return;
>  
> -	pos = sel_ide_offset(pdev, settings);
> +	pci_ide_stream_to_regs(pdev, ide, &regs);
>  
> -	val = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT, settings->rid_end);
> -	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, val);
> -
> -	val = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
> -	      FIELD_PREP(PCI_IDE_SEL_RID_2_BASE, settings->rid_start) |
> -	      FIELD_PREP(PCI_IDE_SEL_RID_2_SEG, pci_ide_domain(pdev));
> +	pos = sel_ide_offset(pdev, settings);
>  
> -	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, regs.rid_1);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, regs.rid_2);
>  
> -	/*
> -	 * Feel free to change the default stratagy, Intel & AMD don't directly
> -	 * setup RP registers.
> -	 *
> -	 * 64 bit memory first, assuming it's more popular.
> -	 */
> -	if (assoc_idx < pdev->nr_ide_mem && settings->mem64.end != 0) {
> -		set_ide_sel_addr(pdev, pos, assoc_idx, &settings->mem64);
> -		assoc_idx++;
> +	for (int i = 0; i < regs.nr_addr; i++) {
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(i),
> +				       regs.addr[i].assoc1);
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(i),
> +				       regs.addr[i].assoc2);
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(i),
> +				       regs.addr[i].assoc3);
>  	}
>  
> -	/* 64 bit memory in lower block and 32 bit in higher block, any risk? */
> -	if (assoc_idx < pdev->nr_ide_mem && settings->mem32.end != 0)
> -		set_ide_sel_addr(pdev, pos, assoc_idx, &settings->mem32);
> +	/* clear extra unused address association blocks */
> +	for (int i = regs.nr_addr; i < pdev->nr_ide_mem; i++) {
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(i), 0);
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(i), 0);
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(i), 0);
> +	}
>  
>  	/*
>  	 * Setup control register early for devices that expect
> 

-- 
 i.


