Return-Path: <linux-pci+bounces-37068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 24768BA2041
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 02:02:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 160A14E3043
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 00:02:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2EFAD51;
	Fri, 26 Sep 2025 00:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JPJpNjSy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63429634;
	Fri, 26 Sep 2025 00:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758844961; cv=none; b=aJmG/blcFhIA6oYJUAfKTeDcIbZJvxiV/VsIZwSAYaRs+ojAZpImjaU3NEujJdOnHyV041/b1cdJKTNMy6m4M/sNJ/jWGa5GySKKZybNj9zaL0yDe3b8zIEz23FkBtcH2kikvnJkZP9kLxat1fQey/5+e/OfCRyOQ8hSj4P6zXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758844961; c=relaxed/simple;
	bh=edY1TGiWacywcdUVCaayOZnqrHDydCZZrHxEC+2PtOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4EPQHWYMRzYCQO4nOjaQGesup7BFtHdV9EqkOwW20IUJOk+YHKcxDJsnPoc3tCgFV5BrM2bL9KHnRY88igxC3cGEY7GEzLltrPU/7DXfxp9r0wV7eaSRirRI6qrhprsCY9ma+HRUoIKj48Z5/ZQV9eHEpF98lgGVVXqQU8XAJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JPJpNjSy; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758844960; x=1790380960;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=edY1TGiWacywcdUVCaayOZnqrHDydCZZrHxEC+2PtOA=;
  b=JPJpNjSyK3wsrPTrLwkM8JSgT7m6TdZxMZ5w/WXVBDPnCKxhpf3UJZ+2
   I3MezYoLUE+jtidn2FXW+mlt6btGUKYYSJE4OWTCS/R0rssuPsx9iVobt
   M1pAb5GVF2OKQP3quYdF/GLhlptfeLu8HU0KYNJgGBAv4Is3n5VQKhQwF
   GOzPdLi5j39UAcAOWw1jr9llzI+N7Uf2yrGi5U5mYK+hksrV4rwU3H018
   0aPOEOTd5jVFNioF4BQBhYQO3uS3NgAHY0cvkjH2tA4rTHKfiablvactq
   iFbz3A2vF8/Sd+n0t6tDVtKewUGZbN48VBnui54XftPIVqyJrxXA2XiCD
   g==;
X-CSE-ConnectionGUID: FRTC37GwTx61bDOZOzdgeA==
X-CSE-MsgGUID: ZiPsjd1PS1S4jQ0W5en2kg==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="60387890"
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="60387890"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 17:02:39 -0700
X-CSE-ConnectionGUID: DKsIGkttRf+tsOwqCsFKzw==
X-CSE-MsgGUID: WnrWbHuCStCZHnZK7S0gmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="177860424"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.109.4]) ([10.125.109.4])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 17:02:37 -0700
Message-ID: <9f6c80e1-3da4-4b23-a1be-5e5093ddd210@intel.com>
Date: Thu, 25 Sep 2025 17:02:36 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 10/25] CXL/AER: Update PCI class code check to use
 FIELD_GET()
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250925223440.3539069-1-terry.bowman@amd.com>
 <20250925223440.3539069-11-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250925223440.3539069-11-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/25/25 3:34 PM, Terry Bowman wrote:
> Update the AER driver's is_cxl_mem_dev() to use FIELD_GET() while checking
> for a CXL Endpoint class code.
> 
> Introduce a genmask bitmask for checking PCI class codes and locate in
> include/uapi/linux/pci_regs.h.
> 
> Update the function documentation to reference the latest CXL
> specification.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> 
> Changes in v11->v12:
> 
> Changes in v10->v11:
> - Add #include <linux/bitfield.h> to cxl_ras.c
> - Removed line wrapping at "(CXL 3.2, 8.1.12.1)".
> ---
>  drivers/pci/pcie/aer.c         | 1 +
>  drivers/pci/pcie/aer_cxl_rch.c | 6 +++---
>  include/uapi/linux/pci_regs.h  | 2 ++
>  3 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index befa73ace9bb..6ba8f84add70 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -30,6 +30,7 @@
>  #include <linux/kfifo.h>
>  #include <linux/ratelimit.h>
>  #include <linux/slab.h>
> +#include <linux/bitfield.h>
>  #include <acpi/apei.h>
>  #include <acpi/ghes.h>
>  #include <ras/ras_event.h>
> diff --git a/drivers/pci/pcie/aer_cxl_rch.c b/drivers/pci/pcie/aer_cxl_rch.c
> index bfe071eebf67..c3e2d4cbe8cc 100644
> --- a/drivers/pci/pcie/aer_cxl_rch.c
> +++ b/drivers/pci/pcie/aer_cxl_rch.c
> @@ -17,10 +17,10 @@ static bool is_cxl_mem_dev(struct pci_dev *dev)
>  		return false;
>  
>  	/*
> -	 * CXL Memory Devices must have the 502h class code set (CXL
> -	 * 3.0, 8.1.12.1).
> +	 * CXL Memory Devices must have the 502h class code set
> +	 * (CXL 3.2, 8.1.12.1).
>  	 */
> -	if ((dev->class >> 8) != PCI_CLASS_MEMORY_CXL)
> +	if (FIELD_GET(PCI_CLASS_CODE_MASK, dev->class) != PCI_CLASS_MEMORY_CXL)
>  		return false;
>  
>  	return true;
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index bd03799612d3..802a7384f99a 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -73,6 +73,8 @@
>  #define PCI_CLASS_PROG		0x09	/* Reg. Level Programming Interface */
>  #define PCI_CLASS_DEVICE	0x0a	/* Device class */
>  
> +#define PCI_CLASS_CODE_MASK     __GENMASK(23, 8)
> +
>  #define PCI_CACHE_LINE_SIZE	0x0c	/* 8 bits */
>  #define PCI_LATENCY_TIMER	0x0d	/* 8 bits */
>  #define PCI_HEADER_TYPE		0x0e	/* 8 bits */


