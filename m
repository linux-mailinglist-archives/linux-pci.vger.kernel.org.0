Return-Path: <linux-pci+bounces-37250-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D341BBACD6F
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 14:30:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C71C0188801A
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 12:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD9826461F;
	Tue, 30 Sep 2025 12:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cT9Ju5ms"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C37C20F08E;
	Tue, 30 Sep 2025 12:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759235396; cv=none; b=TBZAvFr0qTdRQGrPRVK6RhAQMTGmeO6tVCF4J6NnY/9+U0UE9S/3TOlhfIliABNMsdtodQ21Y1wjRioilBzLm48UNYiIK5ZpYrVWIohJZIH6hl3Aw7YAxYUvmaNtnm7hQTqkqTRz2BNf1VhpFoPFzvbc52Lh8LXpBtaNPvnvi4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759235396; c=relaxed/simple;
	bh=GDmus2CGw+l5vE3v3aGHGnfFjE/5q50mDpeUd0fkz+M=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VBpPg1ZHN0d/+nGnIseRYDeeJP+gaP4HKpPU7YWT2MJQyNcvyMn/rZrFpyNYrOHOoSyZ7AVwq5UVAigCTwKuV7p01qHyr44ZTYnnc2b/4FgfBFeu6Ja2jrOxjTg3pxBXwKWMBHMl81guW7FTVZVl3vvh+T/BL1TZNqORI3O666c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cT9Ju5ms; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759235395; x=1790771395;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GDmus2CGw+l5vE3v3aGHGnfFjE/5q50mDpeUd0fkz+M=;
  b=cT9Ju5msFdPcIQ33AHDQXVlKSuRqwrFEXPp9BLIeP5M2LRGfr5qsMWT5
   fVCum9eJNa3fxat48HaNEiMniSKJwaJnR+97fRTt4swNa+z2KhL/3WAKL
   YJxp1o3IcWuJ0MjCiJVmDJQa9fauZcUdQBKZCSdUuFo+ra3LmNQItgpvV
   mvKkJEDpMMzsAgqmirtXgVUdAv6jEdWlKaENRm3rH2Ea94dCZ8vK7IYLi
   UzaQwbMwzbLmQJZHswt06Uaui+9owBynsHOcKMQXDGZ1EdSjjIfrn6dp2
   gJf0ApA4wM/bHPweogG2vdm+on21HGxBIMKabSEtKehsrwRZshfEFmFxZ
   A==;
X-CSE-ConnectionGUID: xyp1wuM+Sl+tBJGF8OL/Vg==
X-CSE-MsgGUID: ZuTd7HT8TXK9RxmwlDKM+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="84106627"
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="84106627"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 05:29:54 -0700
X-CSE-ConnectionGUID: OCEuioj0RVGP0Gcgvu7szw==
X-CSE-MsgGUID: 0PYDBXcMS+iyKgM01kzEXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,304,1751266800"; 
   d="scan'208";a="182527025"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.162])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2025 05:29:50 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 30 Sep 2025 15:29:46 +0300 (EEST)
To: Xu Yilun <yilun.xu@linux.intel.com>
cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org, 
    dan.j.williams@intel.com, yilun.xu@intel.com, baolu.lu@linux.intel.com, 
    zhenzhong.duan@intel.com, aneesh.kumar@kernel.org, bhelgaas@google.com, 
    aik@amd.com, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] PCI/IDE: Add Address Association Register setup for
 RP
In-Reply-To: <20250928062756.2188329-3-yilun.xu@linux.intel.com>
Message-ID: <d58dfdf5-0058-a03f-dd75-5afb8ae69e04@linux.intel.com>
References: <20250928062756.2188329-1-yilun.xu@linux.intel.com> <20250928062756.2188329-3-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Sun, 28 Sep 2025, Xu Yilun wrote:

> Add Address Association Register setup for Root Ports.
> 
> The address ranges for RP side Address Association Registers should
> cover memory addresses for all PFs/VFs/downstream devices of the DSM
> device. A simple solution is to get the aggregated 32-bit and 64-bit
> address ranges from directly connected downstream port (either an RP or
> a switch port) and set into 2 Address Association Register blocks.
> 
> There is a case the platform doesn't require Address Association
> Registers setup and provides no register block for RP (AMD). Will skip
> the setup in pci_ide_stream_setup().
> 
> Also imaging another case where there is only one block for RP.
> Prioritize 64-bit address ranges setup for it. No strong reason for the
> preference until a real use case comes.
> 
> The Address Association Register setup for Endpoint Side is still
> uncertain so isn't supported in this patch.
> 
> Take the oppotunity to export some mini helpers for Address Association
> Registers setup. TDX Connect needs the provided aggregated address
> ranges but will use specific firmware calls for actual setup instead of
> pci_ide_stream_setup().
> 
> Co-developed-by: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Co-developed-by: Arto Merilainen <amerilainen@nvidia.com>
> Signed-off-by: Arto Merilainen <amerilainen@nvidia.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
>  include/linux/pci-ide.h | 11 +++++++
>  drivers/pci/ide.c       | 64 ++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 74 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> index 5adbd8b81f65..ac84fb611963 100644
> --- a/include/linux/pci-ide.h
> +++ b/include/linux/pci-ide.h
> @@ -6,6 +6,15 @@
>  #ifndef __PCI_IDE_H__
>  #define __PCI_IDE_H__
>  
> +#define SEL_ADDR1_LOWER GENMASK(31, 20)
> +#define SEL_ADDR_UPPER GENMASK_ULL(63, 32)
> +#define PREP_PCI_IDE_SEL_ADDR1(base, limit)                    \
> +	(FIELD_PREP(PCI_IDE_SEL_ADDR_1_VALID, 1) |             \
> +	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_BASE_LOW,          \
> +		    FIELD_GET(SEL_ADDR1_LOWER, (base))) | \
> +	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_LIMIT_LOW,         \
> +		    FIELD_GET(SEL_ADDR1_LOWER, (limit))))
> +
>  #define PREP_PCI_IDE_SEL_RID_2(base, domain)               \
>  	(FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |          \
>  	 FIELD_PREP(PCI_IDE_SEL_RID_2_BASE, (base)) | \
> @@ -42,6 +51,8 @@ struct pci_ide_partner {
>  	unsigned int default_stream:1;
>  	unsigned int setup:1;
>  	unsigned int enable:1;
> +	struct range mem32;
> +	struct range mem64;
>  };
>  
>  /**
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index 7633b8e52399..8db1163737e5 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c
> @@ -159,7 +159,11 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
>  	struct stream_index __stream[PCI_IDE_HB + 1];
>  	struct pci_host_bridge *hb;
>  	struct pci_dev *rp;
> +	struct pci_dev *br;

Why not join with the previous line?

>  	int num_vf, rid_end;
> +	struct range mem32 = {}, mem64 = {};
> +	struct pci_bus_region region;
> +	struct resource *res;
>  
>  	if (!pci_is_pcie(pdev))
>  		return NULL;
> @@ -206,6 +210,24 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
>  	else
>  		rid_end = pci_dev_id(pdev);
>  
> +	br = pci_upstream_bridge(pdev);
> +	if (!br)
> +		return NULL;
> +
> +	res = &br->resource[PCI_BRIDGE_MEM_WINDOW];

pci_resource_n()

> +	if (res->flags & IORESOURCE_MEM) {
> +		pcibios_resource_to_bus(br->bus, &region, res);
> +		mem32.start = region.start;
> +		mem32.end = region.end;
> +	}
> +
> +	res = &br->resource[PCI_BRIDGE_PREF_MEM_WINDOW];

Ditto.

> +	if (res->flags & IORESOURCE_PREFETCH) {

While I don't know much about what's going on here, is this assuming the 
bridge window is not disabled solely based on this flag check?

Previously inactive bridge window flags were reset but that's no longer 
the case after the commit 8278c6914306 ("PCI: Preserve bridge window 
resource type flags") (currently in pci/resource)?

-- 
 i.

> +		pcibios_resource_to_bus(br->bus, &region, res);
> +		mem64.start = region.start;
> +		mem64.end = region.end;
> +	}
> +
>  	*ide = (struct pci_ide) {
>  		.pdev = pdev,
>  		.partner = {
> @@ -218,6 +240,8 @@ struct pci_ide *pci_ide_stream_alloc(struct pci_dev *pdev)
>  				.rid_start = pci_dev_id(pdev),
>  				.rid_end = rid_end,
>  				.stream_index = no_free_ptr(rp_stream)->stream_index,
> +				.mem32 = mem32,
> +				.mem64 = mem64,
>  			},
>  		},
>  		.host_bridge_stream = no_free_ptr(hb_stream)->stream_index,
> @@ -397,6 +421,21 @@ static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide,
>  	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, val);
>  }
>  
> +static void set_ide_sel_addr(struct pci_dev *pdev, int pos, int assoc_idx,
> +			     struct range *mem)
> +{
> +	u32 val;
> +
> +	val = PREP_PCI_IDE_SEL_ADDR1(mem->start, mem->end);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(assoc_idx), val);
> +
> +	val = FIELD_GET(SEL_ADDR_UPPER, mem->end);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(assoc_idx), val);
> +
> +	val = FIELD_GET(SEL_ADDR_UPPER, mem->start);
> +	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(assoc_idx), val);
> +}
> +
>  /**
>   * pci_ide_stream_setup() - program settings to Selective IDE Stream registers
>   * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> @@ -410,6 +449,7 @@ static void set_ide_sel_ctl(struct pci_dev *pdev, struct pci_ide *ide,
>  void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
>  {
>  	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> +	u8 assoc_idx = 0;
>  	int pos;
>  	u32 val;
>  
> @@ -424,6 +464,21 @@ void pci_ide_stream_setup(struct pci_dev *pdev, struct pci_ide *ide)
>  	val = PREP_PCI_IDE_SEL_RID_2(settings->rid_start, pci_ide_domain(pdev));
>  	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, val);
>  
> +	/*
> +	 * Feel free to change the default stratagy, Intel & AMD don't directly
> +	 * setup RP registers.
> +	 *
> +	 * 64 bit memory first, assuming it's more popular.
> +	 */
> +	if (assoc_idx < pdev->nr_ide_mem && settings->mem64.end != 0) {
> +		set_ide_sel_addr(pdev, pos, assoc_idx, &settings->mem64);
> +		assoc_idx++;
> +	}
> +
> +	/* 64 bit memory in lower block and 32 bit in higher block, any risk? */
> +	if (assoc_idx < pdev->nr_ide_mem && settings->mem32.end != 0)
> +		set_ide_sel_addr(pdev, pos, assoc_idx, &settings->mem32);
> +
>  	/*
>  	 * Setup control register early for devices that expect
>  	 * stream_id is set during key programming.
> @@ -445,7 +500,7 @@ EXPORT_SYMBOL_GPL(pci_ide_stream_setup);
>  void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide)
>  {
>  	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> -	int pos;
> +	int pos, i;
>  
>  	if (!settings)
>  		return;
> @@ -453,6 +508,13 @@ void pci_ide_stream_teardown(struct pci_dev *pdev, struct pci_ide *ide)
>  	pos = sel_ide_offset(pdev, settings);
>  
>  	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_CTL, 0);
> +
> +	for (i = 0; i < pdev->nr_ide_mem; i++) {
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_1(i), 0);
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_2(i), 0);
> +		pci_write_config_dword(pdev, pos + PCI_IDE_SEL_ADDR_3(i), 0);
> +	}
> +
>  	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_2, 0);
>  	pci_write_config_dword(pdev, pos + PCI_IDE_SEL_RID_1, 0);
>  	settings->setup = 0;
> 

