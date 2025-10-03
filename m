Return-Path: <linux-pci+bounces-37511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B59BB5F6A
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 07:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 86BAA4E2A03
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 05:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0E81C6FEC;
	Fri,  3 Oct 2025 05:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Hek4vz9t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABFB18C03F;
	Fri,  3 Oct 2025 05:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759470877; cv=none; b=W0f7X2SK6A2fs4Fcq2E/yUG+T85q+HjCcT8sjwvtVXFujI1Yae7scyPynmNYoTaakSzAQUjPlRJbHBmirjXE7OiRPjynkbSqm7PX76FwbTQqIXFRFUOsr51NKAC2PNznPXtZZUi4S1mh9ozK5zUnAPSBer0wGCm0d+bJi5eOEOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759470877; c=relaxed/simple;
	bh=W6iO9lJnnjV/rWAkF/wZ/jo2+g391sRpMTFBGSDuJLw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mSDx0Zk22rgZ4qc2fbcD6tKxlE5snZ3/rniFIJ5S0kFLk5ksM0oBU7vAGL5gE9EZmLpxK3pAo0n6bzwmLVLRGqZq2Y3gciCMhRVQiL81696YefCBHnaoR3iMOLsXhUczXZ3vjtXSRdYOl81Mi/zL+GVFRrby+jgyKQg7EIttdXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Hek4vz9t; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759470876; x=1791006876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=W6iO9lJnnjV/rWAkF/wZ/jo2+g391sRpMTFBGSDuJLw=;
  b=Hek4vz9tyEeMPfxK2EC69MiUHTj7hmWeODFS8GagINPyNTNxzrdEmPdL
   dYomL0+wTdFtaOmJMUKXWlxhI+Ef7mQjljb5P6FNizxFgCsP206imxrPA
   3EgzezN7PBdPyPVSj1kYdqdX70gXuL8BarqAcmMznhxm7MznziDFaXCjh
   rE55qMBIkHFQshr3bZ8zXNLixZyyyWXFB+R1MgjMavw/vgPihN8wDeIst
   SZTD3nH8b/amNYyi8vI3BsJwi7wIVFIlrT1rwF9Qp5wgZ2lsDzNdZQ+B2
   hUcrQYHLqLXSL7Wu00W+62JcF1VyGZofmv6hBD9Wv6gKu8dO7rdHNmAQr
   A==;
X-CSE-ConnectionGUID: mcTpOvUPTJe89UZZ5l3lnA==
X-CSE-MsgGUID: k1boPsrWQFGyJnJpnAOKIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="61672045"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="61672045"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2025 22:54:35 -0700
X-CSE-ConnectionGUID: iU7WCRYtTsOKKl7sm7Rw7w==
X-CSE-MsgGUID: jx2g9bsZSPmRMPvE9rvgPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,311,1751266800"; 
   d="scan'208";a="180004760"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa010.fm.intel.com with ESMTP; 02 Oct 2025 22:54:32 -0700
Date: Fri, 3 Oct 2025 13:42:02 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: dan.j.williams@intel.com
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, aneesh.kumar@kernel.org,
	bhelgaas@google.com, aik@amd.com, linux-kernel@vger.kernel.org,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 2/3] PCI/IDE: Add Address Association Register setup for
 RP
Message-ID: <aN9iKtxzv83Y/qvy@yilunxu-OptiPlex-7050>
References: <20250928062756.2188329-1-yilun.xu@linux.intel.com>
 <20250928062756.2188329-3-yilun.xu@linux.intel.com>
 <68dd8d20aafb4_1fa2100f0@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68dd8d20aafb4_1fa2100f0@dwillia2-mobl4.notmuch>

> Per-above, just drop the 64-bit policy and assumption. It will naturally
> fail if the required number of address associations is insufficient.
> I.e. either we are in the AMD situation and no amount of address
> association is required, or we are in the ARM / Intel situation where it
> assigns memory then prefetch-memory (if both are present). If both of

Intel can't assign both memory now.

In my patch, the new policy only applies to pci_ide_stream_setup(rp)
which TDX won't use. pci_ide_stream_alloc() just listed the 2 memory
ranges regardless the actuall number of address association blocks.
That's why I said TDX is not the user of the new policy.

> those are required and the hardware only supports 1 address association
> then that hardware vendor is responsible for figuring out a quirk.

But if we want the address association register setting all controlled by
PCI IDE core, TDX is the practical problem and needs a quirk. I see there
is only 1 address association block for RP in my test ENV, and the test
device requires perf memory to be IDE protected and later private
assigned.

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

I get the answer to my question in Patch #1.

[...]

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

We still need to cover all sub-functions of the dsm device, only
check the need of the dsm device is not enough. But if we check all
functions, we don't have to check then.

[...]

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

I image the quirk for TDX is, reset the RP side settings->mem_assoc back
to {0, -1} before calling this function.
 

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

