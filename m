Return-Path: <linux-pci+bounces-44834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EF6D20FAB
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 20:09:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94F0C3042487
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 19:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B35B33F386;
	Wed, 14 Jan 2026 19:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QY0skBn7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE71F33D6DC;
	Wed, 14 Jan 2026 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768417776; cv=none; b=WVpVUZiQ8xI9ctIwcpBTyZ7co1vJSHyERGekEn88XMEqAWZFv+DjI4Yb/WE2wZS/XaePqT5Pp0vvgXU2TAkV7qgU6bq93I9HH4NymhE9s/Ib/M8mZLAWDsp1oFhi7/ei3O5HaJTSH4BL9N7pw6j6L5vGt54iZOyAUIrRaL0otUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768417776; c=relaxed/simple;
	bh=r2CNcELEJRtFgXXGDuSswLA8zBK3ZHwJVGhmu0zGmZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q1THhK5RBDWoLejaJM3vbE8SKxHQ9oyfgXoC2SqDFxPEO6ijplctNT/Vg9RHyBsTScuASIFzXY4ze0O4vrCYHghbCic8Z4ZdZtooQT2etoqRXb1jLD0iFfFT9rIrqlO0ZtlQv+soUpUrF5rpdq0KebTKbYxGD6ePwVmsJ4HJIQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QY0skBn7; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768417775; x=1799953775;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r2CNcELEJRtFgXXGDuSswLA8zBK3ZHwJVGhmu0zGmZY=;
  b=QY0skBn7yRavmXQt6mq9AT48uSXkDo9DoRbQWYY5WouCWpbiUKj0PfI6
   vjVeIEgjHYsAjNje2H0OCcy3KJm6RUAWuifRSRrNBX/6whp+rxZEKqxvC
   5tjRvNQsVGcHJfHTEU1d9XMcnNxEMvav8IuHU1Ot/q474KdpA8avVdZdP
   8CaanLUFRcQsZyXRh+fT82PKw6D7eJEebgkDQMggIzk2EeSpjLxPwrnbR
   lXfcqtCuolgttrNimzVgEwUcHrgWNYrkF5SnqURbOHEA+vnkS3BgkQWVU
   0fCi6mFSUhVUiJJ7AXXmN6Dvt4cp0GGjvFY3mB6MPXUqm3F13NmpFnOzL
   g==;
X-CSE-ConnectionGUID: cgc9is1YThS5yxfP0iTLrA==
X-CSE-MsgGUID: BkUwG8pESgOcvK34Fss6gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="73577163"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="73577163"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 11:09:34 -0800
X-CSE-ConnectionGUID: Kxapj76/TJi+gVCD+pVvcA==
X-CSE-MsgGUID: SvkP35gIT2i52WvfU7jdFQ==
X-ExtLoop1: 1
Received: from soc-pf446t5c.clients.intel.com (HELO [10.24.81.126]) ([10.24.81.126])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 11:09:34 -0800
Message-ID: <031f3f48-6cf5-4435-8ecb-93f275b66286@linux.intel.com>
Date: Wed, 14 Jan 2026 11:09:32 -0800
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
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com, linux-cxl@vger.kernel.org,
 vishal.l.verma@intel.com, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-10-terry.bowman@amd.com>
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20260114182055.46029-10-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/2026 10:20 AM, Terry Bowman wrote:
> Internal PCIe errors are not enabled by default during initialization. This
> creates a problem for CXL drivers, which rely on PCIe Correctable and
> Uncorrectable Internal Errors to receive CXL protocol error notifications.
> 
> Export pci_aer_unmask_internal_errors() so CXL and other drivers can
> enable internal PCIe errors.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> 
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>


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

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


