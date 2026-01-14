Return-Path: <linux-pci+bounces-44861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D43AD21380
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 21:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B10830329E3
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 20:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58FD63559F1;
	Wed, 14 Jan 2026 20:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SjzOW5OZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAFEA32B991;
	Wed, 14 Jan 2026 20:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768423836; cv=none; b=uz/BpTewr8fspuxsEh3GF6Bjp4LgMMhjdN9JsdqmMo3XV6D7fkGLNy4ziBC7rSAvhbELv8/oW/eRaj8HI4/K4lMZc7DCpeBiGAtYhDXaRFwU6ps3ZNuvKQXMePZN7NRt86M0TuJVWfTGht8zkg10gC3lgjq2O7thpX1diRLOz3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768423836; c=relaxed/simple;
	bh=QYDvNPLV/dklvDwKTw6ewh+hsaOtHcDxlPQumXIDTTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uAh5GpP1jVeRp5kQT1j1ZdxmWa/6NvvyzDjRnWiflFZ//qRq+HcG0XUChbKeXgVgjejzei8Os/yCzM6g/pCRLUVarcqRH4frRbmcDoMSQehV37U5ilo6cYammG9PFMVBwWvKUdqbjLSkLwxE+1ZKryyOx2oIW8mgeDBcGXTUnB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SjzOW5OZ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768423835; x=1799959835;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QYDvNPLV/dklvDwKTw6ewh+hsaOtHcDxlPQumXIDTTg=;
  b=SjzOW5OZZZ//5tMh7DVbJbqDhnKI8eczl8ywuWmqwQXD3myEPRjBFfD1
   fWjoaOWAKGbJP0Y8ioisjZIGUyEl2YYTDU8xuR+kMaVnhy7pDSsP5zYoI
   oe+9/EaHLOjrwQloQaNn+jCILmVcw8PGjari4LH+KnHJxRXYSiB8miyCZ
   U6G3Mv794WB7ZREOEipy2DtsU1pw+ePMXYYhk9UnZrIndrIZMCEsvAyjO
   3H1ZpMg3cXg0PGgOvKeBj2MwhlZhDeXbsclXUToWx+zKQ7oD/+aTzXSJP
   2Hs77J/mSkTMoY21YfTV/7yaZZsYlaom2k4Iy5wN4ieSnEpyIYyVPox75
   A==;
X-CSE-ConnectionGUID: Wgol5lYwRf+FN4/ygdLHPA==
X-CSE-MsgGUID: qIk4Zi6aQ4qbWAmZNHeUPA==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69640994"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="69640994"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 12:50:34 -0800
X-CSE-ConnectionGUID: 7SPEg1xnQ1ifBxN0LT1rKg==
X-CSE-MsgGUID: KTc3a0pHTCixfW503+F4Jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="209635905"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.5]) ([10.125.111.5])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 12:50:32 -0800
Message-ID: <afb9bfb9-17fd-45c4-8852-b3cbdcae9c12@intel.com>
Date: Wed, 14 Jan 2026 13:50:30 -0700
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

Terry, if you are including this patch from Dan in your series, you need to sign off on it.

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


