Return-Path: <linux-pci+bounces-29064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24DA5ACF9FD
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 01:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 818FE3B0286
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 23:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773CA274FFB;
	Thu,  5 Jun 2025 23:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ey8u7pF3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99984218AD1;
	Thu,  5 Jun 2025 23:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749165872; cv=none; b=ESkoJMY33nv8T+NoDl7U6Dj07gh3H4NXhrJUMs1hYF7eNxz/NsyALnUKoLCm8wsRonGi5UWVF4pkP0T3n1z0B5mbzPiQz5WryIKfqeQtMNozJhV3aFtaLGOJCyQq4Oxqp4r/yj8GApERcLtBkmXjQC8lvoAkeYjAhGpOoKxOy4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749165872; c=relaxed/simple;
	bh=D4qDQmRcYChj0MTBJgVUzbnY7abBbwgrW4Z1X2oM1Gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KHt0BjRmI9VqQxFuXKcsK2dt/kzsUUyEEMKRTUF7J7eFMeou9ZnCNYr09l+MexLIt2eQHjL0hNqrJ0+ntFI2Jmc0tmfrZRRRCv56SPigMZnIqH7Y/mTAqD5PT8/QA7jaNpzJFbO20qQ5b5OLwBUeHMwC9e5znhL4qMl91973GMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ey8u7pF3; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749165871; x=1780701871;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=D4qDQmRcYChj0MTBJgVUzbnY7abBbwgrW4Z1X2oM1Gk=;
  b=ey8u7pF3+sA7M6c1TCH+MFRciOjqO09JLptV1LLM3QH26DarWg6+qDHR
   gm88S6Qr3ocExXyXAdWKBGNJdP3Dc8vMoW8bRTpaoBL+4IQfKuWxEjxbG
   IE0S1htbBPTp51OpJR/WqqdXpFjL0gagbsLRRyVQhF8UM5sxLrRtDnGli
   aNeKI9tvwx8A5D4oMnowlU9Jd+KT9JAOFk/b6nWZYpaiCadFsMu2q5MHx
   Sk4jffG7dnxv7rCmhC9OYgdssNOHc1sBOQYdhsBev80HRiqzNSXGAM54d
   slzz48XzZDz9xcRAthWLXdObbyKcXT2pBY0/goObQaqap+V6OCyTD2yjH
   w==;
X-CSE-ConnectionGUID: ZZkJZLqvQ8i0sRDraficFw==
X-CSE-MsgGUID: bBaLBVaJRUCH8EymuKiS1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="51187289"
X-IronPort-AV: E=Sophos;i="6.16,213,1744095600"; 
   d="scan'208";a="51187289"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 16:24:30 -0700
X-CSE-ConnectionGUID: iDDBsxE8Rb69QEJX8IDtdA==
X-CSE-MsgGUID: p10WynqrR+uqOPqalLRJZw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,213,1744095600"; 
   d="scan'208";a="146021420"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.7]) ([10.125.111.7])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 16:24:27 -0700
Message-ID: <fb895685-9e73-49e5-b8e6-224b87110892@intel.com>
Date: Thu, 5 Jun 2025 16:24:26 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 01/16] PCI/CXL: Add pcie_is_cxl()
To: Terry Bowman <terry.bowman@amd.com>, PradeepVineshReddy.Kodamati@amd.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 bhelgaas@google.com, bp@alien8.de, ming.li@zohomail.com,
 shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org, colyli@suse.de,
 uaisheng.ye@intel.com, fabio.m.de.francesco@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, yazen.ghannam@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-2-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250603172239.159260-2-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/3/25 10:22 AM, Terry Bowman wrote:
> CXL and AER drivers need the ability to identify CXL devices.
> 
> Add set_pcie_cxl() with logic checking for CXL Flexbus DVSEC presence. The
> CXL Flexbus DVSEC presence is used because it is required for all the CXL
> PCIe devices.[1]
> 
> Add boolean 'struct pci_dev::is_cxl' with the purpose to cache the CXL
> Flexbus presence.
> 
> Add function pcie_is_cxl() to return 'struct pci_dev::is_cxl'.
> 
> [1] CXL 3.1 Spec, 8.1.1 PCIe Designated Vendor-Specific Extended
>     Capability (DVSEC) ID Assignment, Table 8-2
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/pci/probe.c           | 10 ++++++++++
>  include/linux/pci.h           |  6 ++++++
>  include/uapi/linux/pci_regs.h |  8 +++++++-
>  3 files changed, 23 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 364fa2a514f8..aa29b4b98ad1 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1691,6 +1691,14 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
>  		dev->is_thunderbolt = 1;
>  }
>  
> +static void set_pcie_cxl(struct pci_dev *dev)
> +{
> +	u16 dvsec = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_CXL,
> +					      PCI_DVSEC_CXL_FLEXBUS);
> +	if (dvsec)
> +		dev->is_cxl = 1;
> +}
> +
>  static void set_pcie_untrusted(struct pci_dev *dev)
>  {
>  	struct pci_dev *parent = pci_upstream_bridge(dev);
> @@ -2021,6 +2029,8 @@ int pci_setup_device(struct pci_dev *dev)
>  	/* Need to have dev->cfg_size ready */
>  	set_pcie_thunderbolt(dev);
>  
> +	set_pcie_cxl(dev);
> +
>  	set_pcie_untrusted(dev);
>  
>  	if (pci_is_pcie(dev))
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 51e2bd6405cd..bff3009f9ff0 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -455,6 +455,7 @@ struct pci_dev {
>  	unsigned int	is_hotplug_bridge:1;
>  	unsigned int	shpc_managed:1;		/* SHPC owned by shpchp */
>  	unsigned int	is_thunderbolt:1;	/* Thunderbolt controller */
> +	unsigned int	is_cxl:1;               /* Compute Express Link (CXL) */
>  	/*
>  	 * Devices marked being untrusted are the ones that can potentially
>  	 * execute DMA attacks and similar. They are typically connected
> @@ -746,6 +747,11 @@ static inline bool pci_is_vga(struct pci_dev *pdev)
>  	return false;
>  }
>  
> +static inline bool pcie_is_cxl(struct pci_dev *pci_dev)
> +{
> +	return pci_dev->is_cxl;
> +}
> +
>  #define for_each_pci_bridge(dev, bus)				\
>  	list_for_each_entry(dev, &bus->devices, bus_list)	\
>  		if (!pci_is_bridge(dev)) {} else
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index ba326710f9c8..c50ffa75d5fc 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -1215,9 +1215,15 @@
>  /* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE */
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYPE
>  
> -/* Compute Express Link (CXL r3.1, sec 8.1.5) */
> +/* Compute Express Link (CXL r3.2, sec 8.1)
> + *
> + * Note that CXL DVSEC id 3 and 7 to be ignored when the CXL link state
> + * is "disconnected" (CXL r3.2, sec 9.12.3). Re-enumerate these
> + * registers on downstream link-up events.
> + */
>  #define PCI_DVSEC_CXL_PORT				3
>  #define PCI_DVSEC_CXL_PORT_CTL				0x0c
>  #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
> +#define PCI_DVSEC_CXL_FLEXBUS				7
>  
>  #endif /* LINUX_PCI_REGS_H */


