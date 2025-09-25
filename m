Return-Path: <linux-pci+bounces-37062-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CCECBA1F32
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 01:18:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 81FA51B27173
	for <lists+linux-pci@lfdr.de>; Thu, 25 Sep 2025 23:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FDDB2D24B4;
	Thu, 25 Sep 2025 23:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GRRDd03q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E6527381B;
	Thu, 25 Sep 2025 23:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758842277; cv=none; b=o4seUzdQyHK7owzR1OOWSTXTm9mhAbkFhS6KAg2Gc1oqEL2IC/IDZc+5BLS+EGcJ1E7D5v1m7P5djyDdnJm20uhx8WEjGDSak29zHUa0bkF2n+QG+WUkECOPpYBIYX3bNw+mt8RgqhhJ+Yesj4Nj+3CED8peVOx/YEnr7W3b2JU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758842277; c=relaxed/simple;
	bh=BKtYCy9G9iVhJc0klPiuwgjzGIgZ7dpqJFAFJBGZAes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lo53CbKgZmnCsbzlA3HxKfnWTI5HHci4RlYrnKRy8KCW37n5InIK9v/OB7hL8pffKbHe5wEJ+/xm0mupM0jmj6abR2foWkAYUXDhmF5X6tVzV+BYGgSNQQycbdqAxmBg0aXTqtF33vmkAJT5ERraeF3sa0/gol7yoNl3uGhFl/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GRRDd03q; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758842275; x=1790378275;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=BKtYCy9G9iVhJc0klPiuwgjzGIgZ7dpqJFAFJBGZAes=;
  b=GRRDd03qfrSNhF2+f7w8pcdg7ZDv2q6jahqM2TpIAEuUhEXusDS9qkIG
   GrKHENI6MKJOBG6A5EwamIWlBjWQi4D4j8esEtMV4vO8GGgFSjuN76FkB
   bz/nK81JZzk9mHS7RMN2JL9R4moprWdHWjO7Lf3ivYq+P/KCp2QvFldS2
   MNJZdMU/8nO1xtPOXtvPVdktQodP23ujgyC4J2XTvA+RDWTFrFmvjKUbE
   ZJPZXAbYP1oDq6x3UOB+uVEVR1EoU9nsQ4IejB5DRJnL8XMQp4jbk19lL
   o99Oyd7bETlDsMAL5FFLC1ofFqZsDxvVRSyFh4w4pxDuhPyHcgPmO9CG3
   w==;
X-CSE-ConnectionGUID: L9k9MKF3RK+nFJ4qiNRqZQ==
X-CSE-MsgGUID: a/20PC8WSjahcSWW8RV5Cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11564"; a="71864268"
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="71864268"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 16:17:54 -0700
X-CSE-ConnectionGUID: dSKR1SqLRyybFH4KT23hmQ==
X-CSE-MsgGUID: /FRsZKc9RtO9FKxEWyINuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,293,1751266800"; 
   d="scan'208";a="176739451"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.109.4]) ([10.125.109.4])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2025 16:17:53 -0700
Message-ID: <810a6012-69eb-4e0b-9efa-dd676bd665fa@intel.com>
Date: Thu, 25 Sep 2025 16:17:51 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 04/25] CXL/AER: Remove CONFIG_PCIEAER_CXL and replace
 with CONFIG_CXL_RAS
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
 <20250925223440.3539069-5-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250925223440.3539069-5-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/25/25 3:34 PM, Terry Bowman wrote:
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
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> 
> Changes in v11 -> v12:
> - Added review-by for Sathyanarayanan
> - Changed Kconfig dependency from PCIEAER_CXL to PCIEAER. Moved
>   this backwards into this patch.
> 
> Changes in v10 -> v11:
> - New patch
> ---
>  drivers/cxl/Kconfig      | 2 +-
>  drivers/pci/pcie/Kconfig | 9 ---------
>  drivers/pci/pcie/aer.c   | 2 +-
>  3 files changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 9246f734e6ca..b92d544cfe6f 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -235,5 +235,5 @@ config CXL_MCE
>  
>  config CXL_RAS
>  	def_bool y
> -	depends on ACPI_APEI_GHES && PCIEAER_CXL && CXL_PCI
> +	depends on ACPI_APEI_GHES && PCIEAER && CXL_PCI
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
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e286c197d716..7a1dc2a3460b 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1087,7 +1087,7 @@ static bool find_source_device(struct pci_dev *parent,
>  	return true;
>  }
>  
> -#ifdef CONFIG_PCIEAER_CXL
> +#ifdef CONFIG_CXL_RAS
>  
>  /**
>   * pci_aer_unmask_internal_errors - unmask internal errors


