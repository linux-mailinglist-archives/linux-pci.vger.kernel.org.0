Return-Path: <linux-pci+bounces-35044-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF626B3A82C
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 19:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6985C3AB334
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 17:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB9E32BF20;
	Thu, 28 Aug 2025 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iyZ707Hp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094251E502;
	Thu, 28 Aug 2025 17:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756402392; cv=none; b=l2BJ1nUbz2dVTQtbALBplA8HRwTp/S6DaYz1K7Y5bum3YKz6UmplhUbC92LWRaFDijg6HNwqi/mxs+1VoQ6dvd1sN/TcsP62gMYM6ckZ3AauZ9SNnG7hsVI9PtG4GTV+DxLW1aPi6kQMDvnAwELSSWzxxvcAHZd/AWbKiu1NVM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756402392; c=relaxed/simple;
	bh=PAyB9KGs5Ltk6f45VQNODlFyLGsLWrYIJfa0PPsi3V4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mm2FWdCtVWBWE+lBjzoifZ0AtZHSBDX4AAJZgV8o1TDO4lxVkIgCz5sY+QT1CxBieRqNosEBWEhiSi8uw2chi8ay4/di5a8Y7UUcATeb1umJwiVCt3xPHxIicQT6sXAAfjLCI9oMsIRPn4fzEhAxkn0IKgKQGF1PM4P8L+FdjW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iyZ707Hp; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756402390; x=1787938390;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=PAyB9KGs5Ltk6f45VQNODlFyLGsLWrYIJfa0PPsi3V4=;
  b=iyZ707HpaWE+jafhNAa52/s79yiJPugANkZ3a7KSbq68c6W/hIDmIN6g
   ZFRJZgB4gBch5ErzJmC8zmHT3fkodCz0Dr36G8j45SQ32SlAJ8E335n+N
   UKthw4cXxNYkZ0oObyjKvPKCSxdxVwjsjIOApqu+NkmmMHZoKIjrRkoMY
   EaWP2mnJM3a9HFfgW+6d50hqHIyXBF0VR11HLbNlI8AYtSSGzETCsijgf
   lJbXFoGPQTDD33AL7PL7V6a2F6EqzNPauh6fWNt0yQGKVjr9exXGKs1Mq
   6TykbwZGl0NGrnQNno0vRIQGb4C9MqkYkbx+Wn2vLBHFug/0k+DctxzEB
   g==;
X-CSE-ConnectionGUID: yh0Du+L+RnOOlttr8oMYlA==
X-CSE-MsgGUID: ftwQ7mlITKWvjmdQx27Xvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="81274070"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="81274070"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 10:33:09 -0700
X-CSE-ConnectionGUID: +GxJnzhAQR6QdfQiwOqIyA==
X-CSE-MsgGUID: 01lRZJ04QIStC/z5vPVh1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,220,1751266800"; 
   d="scan'208";a="170343066"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.118.49]) ([10.247.118.49])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 10:32:59 -0700
Message-ID: <1f2f0156-b320-4962-838d-b907aaf37044@intel.com>
Date: Thu, 28 Aug 2025 10:32:53 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 04/23] cxl/pci: Remove unnecessary CXL RCH handling
 helper functions
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-5-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250827013539.903682-5-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/26/25 6:35 PM, Terry Bowman wrote:
> cxl_handle_rdport_cor_ras() and cxl_handle_rdport_ras() are specific
> to Restricted CXL Host (RCH) handling. Improve readability and
> maintainability by replacing these and instead using the common
> cxl_handle_cor_ras() and cxl_handle_ras() functions.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> 
> Changes in v10->v11:
> - New patch
> ---
>  drivers/cxl/core/ras.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 544a0d8773fa..0875ce8116ff 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -233,12 +233,6 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>  	}
>  }
>  
> -static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
> -				      struct cxl_dport *dport)
> -{
> -	return cxl_handle_cor_ras(cxlds, dport->regs.ras);
> -}
> -
>  /*
>   * Log the state of the RAS status registers and prepare them to log the
>   * next error status. Return 1 if reset needed.
> @@ -276,12 +270,6 @@ static bool cxl_handle_ras(struct cxl_dev_state *cxlds, void __iomem *ras_base)
>  	return true;
>  }
>  
> -static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
> -				  struct cxl_dport *dport)
> -{
> -	return cxl_handle_ras(cxlds, dport->regs.ras);
> -}
> -
>  /*
>   * Copy the AER capability registers using 32 bit read accesses.
>   * This is necessary because RCRB AER capability is MMIO mapped. Clear the
> @@ -350,9 +338,9 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>  
>  	pci_print_aer(pdev, severity, &aer_regs);
>  	if (severity == AER_CORRECTABLE)
> -		cxl_handle_rdport_cor_ras(cxlds, dport);
> +		cxl_handle_cor_ras(cxlds, dport->regs.ras);
>  	else
> -		cxl_handle_rdport_ras(cxlds, dport);
> +		cxl_handle_ras(cxlds, dport->regs.ras);
>  }
>  
>  void cxl_cor_error_detected(struct pci_dev *pdev)


