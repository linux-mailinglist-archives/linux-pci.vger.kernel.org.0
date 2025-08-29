Return-Path: <linux-pci+bounces-35140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06812B3C255
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 20:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 090CD1CC3F6F
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 18:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F556340D91;
	Fri, 29 Aug 2025 18:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A5wnYkmv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ABFA314A62;
	Fri, 29 Aug 2025 18:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756491468; cv=none; b=eSFBELc1/UtibwX0nqL5vl24lAaZ/GVZduVa5zc6cW/7RrNHNufQGkryEWwv+KMCZ6rTgwg39FfC1IX1IOeAnSJ5Q6IQT5giVuA5u13ttRo89ttAB2UJQqcsQMduC2jU0XLLmW+oK1xhilFo23YcgMCZkelk4YzOB44VmevGwLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756491468; c=relaxed/simple;
	bh=lw8ak57rMHfT4/pQJq5aSB79Lcnt8tR7XtTQ0VDcSDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KdWIuTmt/u5JFhPq9IH64cFYS5hM6kz+6SXMjMUTABSowZMIt8GeeUiVxqaFD/6YcSOSS2H47O1nHadryp9dmsvW9gGKS5QmZOyJCBQXh4Bq6RLBfwnZeYYHjdXNwnEcJhWGf81vOmaGRiDjXD3my99Naz6QK8G9ddnGN5syVEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A5wnYkmv; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756491467; x=1788027467;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=lw8ak57rMHfT4/pQJq5aSB79Lcnt8tR7XtTQ0VDcSDg=;
  b=A5wnYkmvMzhzIvhvX9ujgFRy70PDTURzVJWn6w/JctogCmftGEThs4jU
   klBHyofNVQFoMMdnD9X1QmIi2vOYFmmKgUtjUFDd1Kc1rApPHxygDbDJs
   ifSOQ5OYnOQo99ivue5Mz4XPYpVrRg2SuV7T+Obwbb8uy4OaGd0Wrz5KN
   5KZcx2sYD5HhotOH9PeNZvm/P/YpozugcAif15Rd+byjaMmDPPZ80Zfr3
   KWIB0G1hiS4/pOT06C8jf+8S9tPM7+9ExmKZk7HtlIvhFxwvjvRsuD/+O
   EmzzRf6+RtUn8bykaH4wicSU5OtNWITE2V8GGTcWSO/T7ZjeLLiwpHERw
   Q==;
X-CSE-ConnectionGUID: 3DelBLT3QhOsPq28pe7XeA==
X-CSE-MsgGUID: EYdSlRzoTf+zLqPaYbGTtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11537"; a="69378230"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="69378230"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 11:17:46 -0700
X-CSE-ConnectionGUID: TDGBfdz7QCu4X0hPGUFr6A==
X-CSE-MsgGUID: ObJDOCk9RSmkjviqZdkirQ==
X-ExtLoop1: 1
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 11:17:45 -0700
Received: from [10.124.220.231] (unknown [10.124.220.231])
	by linux.intel.com (Postfix) with ESMTP id 2A58B20B571C;
	Fri, 29 Aug 2025 11:17:43 -0700 (PDT)
Message-ID: <129284a1-1fc7-4d25-baba-53d5de32ebd6@linux.intel.com>
Date: Fri, 29 Aug 2025 11:16:57 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 02/23] CXL/AER: Remove CONFIG_PCIEAER_CXL and replace
 with CONFIG_CXL_RAS
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, dan.j.williams@intel.com, bhelgaas@google.com,
 shiju.jose@huawei.com, ming.li@zohomail.com,
 Smita.KoralahalliChannabasappa@amd.com, rrichter@amd.com,
 dan.carpenter@linaro.org, PradeepVineshReddy.Kodamati@amd.com,
 lukas@wunner.de, Benjamin.Cheatham@amd.com, linux-cxl@vger.kernel.org,
 alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-3-terry.bowman@amd.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250827013539.903682-3-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 8/26/25 6:35 PM, Terry Bowman wrote:
> CXL RAS compilation is enabled using CONFIG_CXL_RAS while the AER CXL logic
> uses CONFIG_PCIEAER_CXL. The 2 share the same dependencies and can be
> combined. The 2 kernel configs are unnecessary and are problematic for the
> user because of the duplication. Replace occurrences of CONFIG_PCIEAER_CXL
> to be CONFIG_CXL_RAS.
>
> Update the CONFIG_CXL_RAS Kconfig definition to include dependencies 'PCIEAER
> && CXL_PCI' taken from the CONFIG_PCIEAER_CXL definition.
>
> Remove the Kconfig CONFIG_PCIEAER_CXL definition.
>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>
> ---

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> Changes in v10 -> v11:
> - New patch
> ---
>   drivers/pci/pcie/Kconfig | 9 ---------
>   drivers/pci/pcie/aer.c   | 2 +-
>   2 files changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index 17919b99fa66..207c2deae35f 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -49,15 +49,6 @@ config PCIEAER_INJECT
>   	  gotten from:
>   	     https://github.com/intel/aer-inject.git
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
>   #
>   # PCI Express ECRC
>   #
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 70ac66188367..7fe9f883f5c5 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1086,7 +1086,7 @@ static bool find_source_device(struct pci_dev *parent,
>   	return true;
>   }
>   
> -#ifdef CONFIG_PCIEAER_CXL
> +#ifdef CONFIG_CXL_RAS
>   
>   /**
>    * pci_aer_unmask_internal_errors - unmask internal errors

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


