Return-Path: <linux-pci+bounces-44860-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F88D2137A
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 21:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 748DD302E723
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 20:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF9D732B991;
	Wed, 14 Jan 2026 20:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XwuEPSFv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32D343559FC;
	Wed, 14 Jan 2026 20:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768423784; cv=none; b=jZuSg9TuJLfabz242CEeARer/XukoLNp38KDNGLQod4Dzj9j/Zs9YT2G71o3deXnE8QBhg032Tpiuyso+n2P/gCsWC3DSK7anY0adQcyHR+Q0mkoEKSrGE/EcKwcKVqaBvaUa7udSoYUQ/C4yFRF8PRYBuGTfYWFUzTo+erjagY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768423784; c=relaxed/simple;
	bh=QRSAtfVCkp3tuvFD9poPOM5eUeybKXyMQgJ9UR6Mo/Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QSRJfmwIfCzJ17p1GIrVVnfc9zGlMRhx/BLyo4gvVGUtJxSD17MrHn2+wCS6xHQYiY2dEvyGKa5ewlHq0VDkxBo1WsLGpAI94BUk88ppiCwnOXbrTKEiq1hk9U71xEgkPwkm/CoLtlVhjXd0xmYsR9EBBkVUXIh8mEkps53ApZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XwuEPSFv; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768423783; x=1799959783;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QRSAtfVCkp3tuvFD9poPOM5eUeybKXyMQgJ9UR6Mo/Y=;
  b=XwuEPSFvtm0SqsvzA8bI/qTdkDh/dE9r179jfI/64T6P1Qy/Tz5dUSKa
   8JTMw32uvp5NyDo6hmNplIJVeixe8pVH+LHEbdqZPS3RVnqc9jcKO2quW
   4ysxORAOyQa9WdqJLT3AoagaXQA+bSIE9Q6Pi3aFKDoKsnmwO7g3DyM9D
   DF8DGYFG5/CX3v8Ob8ECBhGmjg6gM7UliEluo/6J5wDp0gWKOB2OTcKW4
   TXFrMYF5yI3vJFMU2AtdH8lGpLMXKdsXk/s8mwAfM70q6xJ3c5SvubPOs
   PYQCdqSp2rI/Ail14ZsnD30Da/CUu22XVKfRVjLdC8GxANoQdhFtZOgWl
   w==;
X-CSE-ConnectionGUID: 2rqIOoN7SZSEYl7g6H5+Yw==
X-CSE-MsgGUID: eNzwHcLFSEaQdA7KQCPJQg==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="57284826"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="57284826"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 12:49:42 -0800
X-CSE-ConnectionGUID: qCtkfb5ASMeNLPnKauof2g==
X-CSE-MsgGUID: qje0tpgyRbqr6iKvg2Swyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="204394911"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.5]) ([10.125.111.5])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 12:49:40 -0800
Message-ID: <63c3c5d9-8766-419c-9fa9-e80bbf9e92e4@intel.com>
Date: Wed, 14 Jan 2026 13:49:39 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 13/34] PCI/AER: Replace PCIEAER_CXL symbol with
 CXL_RAS
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
 <20260114182055.46029-14-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260114182055.46029-14-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/26 11:20 AM, Terry Bowman wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> One of the primary reasons for the CXL driver to exist is to perform error
> handling. If both PCIEAER and CXL are enabled then light up CXL error
> handling as well. The work to remove CONFIG_PCIEAER_CXL started in:
> 
> commit 4ae6ae66649c ("cxl/pci: Remove CXL VH handling in CONFIG_PCIEAER_CXL conditional blocks from core/pci.c")
> 
> Finish that off with conditionally compiling all CXL RAS related helpers
> with CONFIG_CXL_RAS.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> ----
> 
> Changes in v13->v14:
> - New commit
> ---
>  drivers/cxl/Kconfig      | 2 +-
>  drivers/pci/pcie/Kconfig | 9 ---------
>  2 files changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 217888992c88..70acddc08c39 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -235,6 +235,6 @@ config CXL_MCE
>  
>  config CXL_RAS
>  	def_bool y
> -	depends on ACPI_APEI_GHES && PCIEAER && CXL_PCI
> +	depends on ACPI_APEI_GHES && PCIEAER && CXL_BUS
>  
>  endif
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 17919b99fa66..207c2deae35f 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -49,15 +49,6 @@ config PCIEAER_INJECT
>  	  gotten from:
>  	     https://github.com/intel/aer-inject.git
>  
> -config PCIEAER_CXL
> -	bool "PCI Express CXL RAS support"
> -	default y
> -	depends on PCIEAER && CXL_PCI
> -	help
> -	  Enables CXL error handling.
> -
> -	  If unsure, say Y.
> -
>  #
>  # PCI Express ECRC
>  #


