Return-Path: <linux-pci+bounces-44859-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A603D21338
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 21:40:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82F3F3008C6F
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 20:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6553559DF;
	Wed, 14 Jan 2026 20:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kdE3n5wF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13EA52F0C7D;
	Wed, 14 Jan 2026 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768423234; cv=none; b=WOhoUQUCjMtrH3vZ2iyEYMPLjk5Tl5CNCV/dhbkNfqKitT6GLMzKSSB00OGQGyyAHuGKs49dTGaUHF0x9sY/3aHF9Ldj7nDcj5y6anevHv/Nx7JPJc6DdPUx6ycoXqwyyVF+PCnhIJL3pJMIsqTQJODLq6C+jIRL+i9/7dBB7b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768423234; c=relaxed/simple;
	bh=Zw2XXQ+nfavn2/OriqXRthtETOrwfFk+Mg43uhSTDZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TnrTE5n0nGeasDKtCLU7NrqE3xn3TNqI6s7P7SZdQAQgFO+BnnQ/MQF/wWuCw9OcV5CI0bD4V57I1y64vIEsBwnPZag94ZXgP1nZWzRn7+HQveGV1875WieFDUKAkrdaw6UJdxl8SDp7IHrXU5UlS5P0Nlp+t85ajwn9/KzBXQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kdE3n5wF; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768423233; x=1799959233;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Zw2XXQ+nfavn2/OriqXRthtETOrwfFk+Mg43uhSTDZU=;
  b=kdE3n5wFh4G8ijkB1zC1EAB8K/8phF2azwnzdhhJrsPXIXJfmT2xFzGA
   8eP3c2QAXNWkMHp7cg4FN91d1rLBMFpmWTSWHjmdjUXjWoWmyRO8pZeKg
   LvtpvIV0Wf3clMpiuoV/UjIT9OfxQs2366QizLKIclzlQMNdzWXmRYZKy
   e2DD/YFgK+4QL73/F563VIcn1bESU/pPuk+Qg0j6cs3W8HREMUw1vhnGu
   LolVDxtuhl2M6x85KjNRZqjwvfw3itBiEaroRuCS57R7/OHPytLzDlTye
   tRgwaUJV0U6Nm43Xut9hBzUYyyvEpQeObqJdsPB8pbBfZoZzKIegrWhmn
   w==;
X-CSE-ConnectionGUID: IUjqHcOTTsWUtrPMcKUUTA==
X-CSE-MsgGUID: XyaqA3tRTi2t1ZUI707gDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69631145"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="69631145"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 12:40:32 -0800
X-CSE-ConnectionGUID: KLO3ndsHQZi3FGoMy7bzNA==
X-CSE-MsgGUID: iK3hcDaXTXqG88zBzsNMQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="235499351"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.5]) ([10.125.111.5])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 12:40:31 -0800
Message-ID: <445a0cac-a2ae-4d6e-ade3-18263e3a1f3a@intel.com>
Date: Wed, 14 Jan 2026 13:40:30 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 09/34] PCI/AER: Export
 pci_aer_unmask_internal_errors()
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, vishal.l.verma@intel.com, alucerop@amd.com,
 ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-10-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260114182055.46029-10-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/26 11:20 AM, Terry Bowman wrote:
> Internal PCIe errors are not enabled by default during initialization. This
> creates a problem for CXL drivers, which rely on PCIe Correctable and
> Uncorrectable Internal Errors to receive CXL protocol error notifications.
> 
> Export pci_aer_unmask_internal_errors() so CXL and other drivers can
> enable internal PCIe errors.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> ---
> 
> Changes in v13->v14:
> - New commit. Bjorn requested separating out and adding immediatetly
> before being used. This is called from cxl_rch_enable_rcec() in
> following patch.
> ---
>  drivers/pci/pcie/aer.c | 6 +++---
>  include/linux/aer.h    | 2 ++
>  2 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index c99ba2a1159c..63658e691aa2 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1120,8 +1120,6 @@ static bool find_source_device(struct pci_dev *parent,
>  	return true;
>  }
>  
> -#ifdef CONFIG_PCIEAER_CXL
> -
>  /**
>   * pci_aer_unmask_internal_errors - unmask internal errors
>   * @dev: pointer to the pci_dev data structure
> @@ -1132,7 +1130,7 @@ static bool find_source_device(struct pci_dev *parent,
>   * Note: AER must be enabled and supported by the device which must be
>   * checked in advance, e.g. with pcie_aer_is_native().
>   */
> -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> +void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  {
>  	int aer = dev->aer_cap;
>  	u32 mask;
> @@ -1145,7 +1143,9 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>  	mask &= ~PCI_ERR_COR_INTERNAL;
>  	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>  }
> +EXPORT_SYMBOL_GPL(pci_aer_unmask_internal_errors);
>  
> +#ifdef CONFIG_PCIEAER_CXL
>  static bool is_cxl_mem_dev(struct pci_dev *dev)
>  {
>  	/*
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 02940be66324..df0f5c382286 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -56,12 +56,14 @@ struct aer_capability_regs {
>  #if defined(CONFIG_PCIEAER)
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>  int pcie_aer_is_native(struct pci_dev *dev);
> +void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>  #else
>  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  {
>  	return -EINVAL;
>  }
>  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
> +static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
>  #endif
>  
>  void pci_print_aer(struct pci_dev *dev, int aer_severity,


