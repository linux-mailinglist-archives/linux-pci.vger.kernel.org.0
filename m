Return-Path: <linux-pci+bounces-37601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A7BBBD01A
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 05:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5B8F1893D55
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 03:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 813031A9FA1;
	Mon,  6 Oct 2025 03:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FlXi0eeN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F106136E3F;
	Mon,  6 Oct 2025 03:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759720693; cv=none; b=bS9R5XtlzX1Gxx0MNVajGnn+GmZgRBeF0RabrDnwVVIRkdgc+gWmjWYLiURm+p9nLTaArIXAE2XhIW+UO6pMlSTFt8tHsVU/L7JrMhvOEyYYymofF0LPAHSX5vT0Qyd9f2egbnd3v0NTdHY58Gmv6f5JnwPvAXN3fvhxvVlgRpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759720693; c=relaxed/simple;
	bh=Cq2ulHlu7fUhnZ+6oyGQW4RnxGjY3EivCTIYwz6OvKE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rw/1LezOQfsawWSDJy15pi5QuyXV9BdzYqvf0E7ECHouXpGo4fAZzuL4UlJfiMnkCyLhMnR/Y0t/OVgjro4fXd4wSCudLh75f/HzTGsnTBw2FAPjNMAGv/hxRPM1yafGcG5Maj9vonCuRns2STiENASWwQvdXotiYs7ek/hYRQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FlXi0eeN; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759720691; x=1791256691;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Cq2ulHlu7fUhnZ+6oyGQW4RnxGjY3EivCTIYwz6OvKE=;
  b=FlXi0eeNu0/EvGvUShsDS0FFmC8mx4IufLfH2Q8kaqMtde3RI9j05yI/
   mBJXLHUlE1WedchWr20kUMj+5bL7FgnqefhZ0oaZxe/3ZzOuiSSzIj54Y
   1Sl8ZRZjVmjOmWChGE5A7FbN6Q7m3ViKYn91bh+HzS5Zt9VZBkk3HvTLZ
   8w92rWSYXw02QdWo9WF4Tngn67/lYSQZWJmX2suAk/1d+Cs+MMH5dMv1V
   WIoJo6TNCumAdQNDG9gRuEMpHHdS4XQZKyAepY2JL8DMOURP9/zAci29Q
   F5DA6tEZoH+3TFQW+GZ+7k9DvfS0a84SVDF5NWaszmul2WfhZ+Dz5tgmI
   A==;
X-CSE-ConnectionGUID: 5+fAxbCxRK6PVpJCB/lrdA==
X-CSE-MsgGUID: RzQbzjZhQXq4cXXI2QwLPw==
X-IronPort-AV: E=McAfee;i="6800,10657,11573"; a="61779535"
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="61779535"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2025 20:18:10 -0700
X-CSE-ConnectionGUID: VmJaGqdXRi6+aNnC9qn75w==
X-CSE-MsgGUID: GLRJ+oqOT9iKU7hglO8eRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,319,1751266800"; 
   d="scan'208";a="180203680"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa009.fm.intel.com with ESMTP; 05 Oct 2025 20:18:08 -0700
Date: Mon, 6 Oct 2025 11:05:29 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: dan.j.williams@intel.com
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	yilun.xu@intel.com, baolu.lu@linux.intel.com,
	zhenzhong.duan@intel.com, aneesh.kumar@kernel.org,
	bhelgaas@google.com, aik@amd.com, linux-kernel@vger.kernel.org,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH 2/3] PCI/IDE: Add Address Association Register setup for
 RP
Message-ID: <aOMx+TAH66vI92R9@yilunxu-OptiPlex-7050>
References: <20250928062756.2188329-1-yilun.xu@linux.intel.com>
 <20250928062756.2188329-3-yilun.xu@linux.intel.com>
 <68dd8d20aafb4_1fa2100f0@dwillia2-mobl4.notmuch>
 <aN9iKtxzv83Y/qvy@yilunxu-OptiPlex-7050>
 <68e0136bd9bcf_1992810012@dwillia2-mobl4.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68e0136bd9bcf_1992810012@dwillia2-mobl4.notmuch>

> The address association setting is not *controlled* by the PCI IDE core,
> it is simply *initialized* by the PCI IDE core. The PCI IDE core should
> always be a library, not a mid-layer when it comes to policy. So, if TDX
> knows that only prefetchable memory will ever be protected then it can
> do the following:
> 
>         struct pci_ide *ide __free(pci_ide_stream_release) =
>                 pci_ide_stream_alloc(pdev);
>         if (!ide)
>                 return -ENOMEM;
> 	...
>         rp_settings = pci_ide_to_settings(rp, ide);
>         /* only support address association for prefetchable memory */
>         rp_settings->mem_assoc = { 0, -1 };
> 
> [..]
> > > +	/*
> > > +	 * Check if the device consumes memory and/or prefetch-memory. Setup
> > > +	 * downstream address association ranges for each.
> > > +	 */
> > > +	mem = pci_resource_n(br, PCI_BRIDGE_MEM_WINDOW);
> > > +	pref = pci_resource_n(br, PCI_BRIDGE_PREF_MEM_WINDOW);
> > > +	pci_dev_for_each_resource(pdev, res) {
> > > +		if (resource_assigned(mem) && resource_contains(mem, res) &&
> > 
> > We still need to cover all sub-functions of the dsm device, only
> > check the need of the dsm device is not enough. But if we check all
> > functions, we don't have to check then.
> 
> True, good point, no real need to limit the stream just based on the DSM
> device just do:
> 
>         if (resource_assigned(mem))
>                 pcibios_resource_to_bus(br->bus, &mem_assoc, mem);
>         if (resource_assigned(pref))
>                 pcibios_resource_to_bus(br->bus, &pref_assoc, pref);
> 
> I was hoping that limiting it to the bridge windows that are used might
> naturally result in the non-prefetchable memory window dropping out.
> However, better to associate all downstream memory by default and let
> the TSM driver trim associations it does not want to support.

Yeah, good to me.

> 
> [..]
> > > + * pci_ide_stream_to_regs() - convert IDE settings to association register values
> > > + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> > > + * @ide: registered IDE settings descriptor
> > > + * @regs: output register values
> > > + */
> > > +static void pci_ide_stream_to_regs(struct pci_dev *pdev, struct pci_ide *ide,
> > > +				   struct pci_ide_regs *regs)
> > > +{
> > > +	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> > > +	int pos, assoc_idx = 0;
> > > +
> > > +	memset(regs, 0, sizeof(*regs));
> > > +
> > > +	if (!settings)
> > > +		return;
> > >  
> > > -	val = PREP_PCI_IDE_SEL_ADDR1(mem->start, mem->end);
> > > -	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(assoc_idx), val);
> > > +	pos = sel_ide_offset(pdev, settings);

Delete the pos stuff, not used in this function.

> > > +
> > > +	regs->rid_1 = FIELD_PREP(PCI_IDE_SEL_RID_1_LIMIT, settings->rid_end);
> > > +
> > > +	regs->rid_2 = FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |
> > > +		      FIELD_PREP(PCI_IDE_SEL_RID_2_BASE, settings->rid_start) |
> > > +		      FIELD_PREP(PCI_IDE_SEL_RID_2_SEG, pci_ide_domain(pdev));
> > > +
> > > +	if (pdev->nr_ide_mem && pci_bus_region_size(&settings->mem_assoc)) {
> > 
> > I image the quirk for TDX is, reset the RP side settings->mem_assoc back
> > to {0, -1} before calling this function.
> 
> Oh, yup, you predicted my response above.
> 
> Now, I worry that some device will need its memory window protected in
> addition to its prefetch window, but that is an architecture limitation
> that the TDX Module will need to solve when / if it happens.

Agree.

I've tested all your changes, work for me.

Thanks,
Yilun

