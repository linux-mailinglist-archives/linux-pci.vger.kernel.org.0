Return-Path: <linux-pci+bounces-42919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42095CB434D
	for <lists+linux-pci@lfdr.de>; Thu, 11 Dec 2025 00:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C2CFF300725B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Dec 2025 23:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BE3221543;
	Wed, 10 Dec 2025 23:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWsiAMGZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FD421D3F5;
	Wed, 10 Dec 2025 23:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765408368; cv=none; b=ejBdIdmMe+/rxgsWvXiMC76VQXORXXU0LDIKXj3fcEr3zNVMgpl/PcrG2vV8MvXpXkNngpTzfG0vdzqJ3ehgA4XMx4032z+08bYNQKCFdNexceluDTPvb3Y/yJGp4OVYeLYt+AUGbXMGzS8f7tHoNHcYy7eh0Agg2z+h1yauZak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765408368; c=relaxed/simple;
	bh=Db3akImy2NdKbhEBWj0OzkuxDP8YFCTP+ID/xh052g4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KiLbkpWaelve58EHwHITObV0BomwMh+xkAc8EbXY11K8+Jgrje9xFugJ8YDx1Xlero5IVmdF5Xt0ng4nFRLEP/xmVWhCeWuZHKvpkBZU2dggajvQ66/Uke3UmhuxY5lemFrIlDOT6smrrNJbtcx01U/v90NltAq0GN1SZRVvPBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWsiAMGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36E5C4CEF1;
	Wed, 10 Dec 2025 23:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765408366;
	bh=Db3akImy2NdKbhEBWj0OzkuxDP8YFCTP+ID/xh052g4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RWsiAMGZPf+9QkHue5VGod1c4x8D8Cpw2yV5Q6mbhdef5sjAp6oNF7QpRdRZg5Obv
	 6KRPIzbJE7FDrfKPqvQU4Nqhni+/3iyeJsKhyKXsqlAt6Coyq13eQXFhIH5qzBDVSr
	 zKEe7q/BfmpgOxYkH8EVJHAqdUSFvL1FEjrfahHnGbQQno27EgJEAtsKOYAL/GKwWd
	 5DIOmg1IyMu1DM1Z90GbWkSEO6v+ckkOj2kYrDRBnERgz6f0ePGZzqj2y1VdVxXvhB
	 ykcDsDtgguuDb6UKvV2t9wGqU0a7x4eGc/YG8wZTyA1IPaBXhbhzqT9JdatDAyKj8F
	 909GWx5OIoOQg==
Date: Wed, 10 Dec 2025 17:12:44 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Bowman, Terry" <terry.bowman@amd.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	alison.schofield@intel.com, dan.j.williams@intel.com,
	bhelgaas@google.com, shiju.jose@huawei.com, ming.li@zohomail.com,
	Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
	dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
	lukas@wunner.de, Benjamin.Cheatham@amd.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v13 08/25] CXL/AER: Move AER drivers RCH error handling
 into pcie/aer_cxl_rch.c
Message-ID: <20251210231244.GA3545581@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <212e35e0-3c71-443b-9f4a-8720ef3d0ba0@amd.com>

On Wed, Dec 10, 2025 at 03:57:57PM -0600, Bowman, Terry wrote:
> On 12/8/2025 3:28 PM, Bowman, Terry wrote:
> > On 12/8/2025 12:06 PM, Bjorn Helgaas wrote:
> >> On Mon, Nov 03, 2025 at 06:09:44PM -0600, Terry Bowman wrote:
> >>> The restricted CXL Host (RCH) AER error handling logic currently resides
> >>> in the AER driver file, drivers/pci/pcie/aer.c. CXL specific changes are
> >>> conditionally compiled using #ifdefs.
> ...

> >>> Export pci_aer_unmask_internal_errors() allowing for all
> >>> subsystems to use.
> ...

> >>> @@ -1143,116 +1143,25 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> >>>  	mask &= ~PCI_ERR_COR_INTERNAL;
> >>>  	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
> >>>  }
> >>> +EXPORT_SYMBOL_GPL(pci_aer_unmask_internal_errors);
> >>
> >> Not sure why these EXPORTs are needed.  Is there a caller that
> >> can be a module?  The callers I see look like they would be
> >> builtin.  If you add callers later that need this, the export can
> >> be done then.
> > 
> > pci_aer_unmask_internal_errors() is called by the cxl_core module
> > later in the 2nd to-last patch. I'll move the export change to the
> > later patch. At one point I was trying to avoid changes to same
> > definitions multiple times.
> > 
> >>> +++ b/include/linux/aer.h
> >>> @@ -56,12 +56,20 @@ struct aer_capability_regs {
> >>>  #if defined(CONFIG_PCIEAER)
> >>>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
> >>>  int pcie_aer_is_native(struct pci_dev *dev);
> >>> +void pci_aer_unmask_internal_errors(struct pci_dev *dev);
> >>>  #else
> >>>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
> >>>  {
> >>>  	return -EINVAL;
> >>>  }
> >>>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
> >>> +static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }

> >> These include/linux/aer.h changes look like a separate patch.
> >> Moving code from aer.c to aer_cxl_rch.c doesn't add any callers
> >> outside drivers/pci, so these shouldn't need to be in
> >> include/linux/.
> > 
> > I'll remove these from here.
> 
> I reviewed this more closely and recalled the reasoning behind the
> change.  Lukas requested that pci_aer_unmask_internal_errors() be
> made available across the entire kernel. I already noted this in the
> commit message, but I can also include a link to Lukas’s request.
> Alternatively, I could split this into a separate patch with a
> Recommended-by tag, leave it as is, or make another adjustment.
> Additionally, I’ll update cxl_error_is_native() so it’s only
> included when necessary.

There's a lot going on in this patch, which makes the commit log long
and a bit cluttered.

Let's make the pci_aer_unmask_internal_errors() change a separate
patch, combined with or immediately before adding a new user outside
drivers/pci.

I assume you're referring to Lukas's email at [1], but he's responding
to a patch that exported pci_aer_unmask_internal_errors() for modules
but left the declaration in drivers/pci/pci.h.

[1] https://lore.kernel.org/all/aK66OcdL4Meb0wFt@wunner.de/

