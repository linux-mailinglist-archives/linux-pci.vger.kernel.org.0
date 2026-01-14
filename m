Return-Path: <linux-pci+bounces-44874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0BFD217A2
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 22:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A4B6B300B9CF
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 21:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188D33ACA45;
	Wed, 14 Jan 2026 21:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SGjicGw/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ACB3A9623;
	Wed, 14 Jan 2026 21:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768427970; cv=none; b=pXg0C24XvEW1loePzPrLLDblRXifpIGa7XgvFeL0GrzIlu9t1Slpvb2/71+RXHi13PMgBj1qQ4//+rQahOuo/EI2i1AjZ2tBbZ7eLEhBh7Fj5Gm9VIFYQeay8iXTAJrsMtB+SjiHcj0Sm37C0+0/lny9dw0TK57yuHX64xEEYiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768427970; c=relaxed/simple;
	bh=bYIxbJ9lv6/0OcQfSYndVezlcIj/WDgCuInK7f+qBoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZRD1RKz0j0dbYnCOujecuL0Pfk8yjUUnRzOH0lg292EIAuPFhVxMTobVlkbf//6tuc/E3O/OK9FzXE4bbPDvnMknzAQzHLKEISQmPuwnVNSI8x0izqT8PANOieBDW6VdRTPSqoWwlh8lpTrQEajQmp/yhwEE3NUkD/9f7vItrPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SGjicGw/; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768427958; x=1799963958;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bYIxbJ9lv6/0OcQfSYndVezlcIj/WDgCuInK7f+qBoM=;
  b=SGjicGw/GTjKHKGS0rX9XIL/gaKaw+yvPb81VY0OE3zSHRnWciV44uxK
   m6STlwSpMQ/QnEZfo5oJFrLWHSQxa0GHe4x54YHJOBhnZ8wklQfhPIjFs
   TMxN5wcfsjmzsn9S8iwgUeOiaMP5ucqdilw3IDHvP8AejyFP19OVrP6lr
   JnSenS6vFc76eDVfx7/phZmpq7njsgZG8o7M6rEL4/VBstdha1zvFlOq5
   hUUrvoIenO9Ghr4i1CFkJSsn242KkZ9+GADqNG0T0QQysyTQjIoiz/5te
   vUJS3cHbzUQZteDehdiJeyYmz0FsgmEfqvBuH17ywVDVec7IfsUklymxZ
   w==;
X-CSE-ConnectionGUID: DcK2vppHT0iyyv41s5RovA==
X-CSE-MsgGUID: 7vSS8maKTOWdEbPkK/0HEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69794050"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="69794050"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 13:59:11 -0800
X-CSE-ConnectionGUID: If0m460mRJGG1Rn7LuSiqA==
X-CSE-MsgGUID: xF9DP5OATp6NC8UCziS53g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="203927701"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.5]) ([10.125.111.5])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 13:59:10 -0800
Message-ID: <fbde3945-f8d3-4ec4-b8e8-72fac2b18c90@intel.com>
Date: Wed, 14 Jan 2026 14:59:09 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 25/34] cxl/port: Map Port component registers before
 switchport init
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
 <20260114182055.46029-26-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260114182055.46029-26-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/26 11:20 AM, Terry Bowman wrote:
> Port HDM registers must be mapped before calling
> devm_cxl_switch_port_decoders_setup(). Invoke a call to this function
> in cxl_port_add_dport().

s/Invoke.../Map the per port component registers when the first dport is being enumerated./
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/cxl/core/port.c | 3 ++-
>  drivers/cxl/cxlpci.h    | 3 +++
>  drivers/cxl/port.c      | 5 +++++
>  3 files changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 2c4e28e7975c..3f730511f11d 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -778,7 +778,7 @@ static int cxl_setup_comp_regs(struct device *host, struct cxl_register_map *map
>  	return cxl_setup_regs(map);
>  }
>  
> -static int cxl_port_setup_regs(struct cxl_port *port,
> +int cxl_port_setup_regs(struct cxl_port *port,
>  			resource_size_t component_reg_phys)
>  {
>  	if (dev_is_platform(port->uport_dev))
> @@ -786,6 +786,7 @@ static int cxl_port_setup_regs(struct cxl_port *port,
>  	return cxl_setup_comp_regs(&port->dev, &port->reg_map,
>  				   component_reg_phys);
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_port_setup_regs, "CXL");
>  
>  static int cxl_dport_setup_regs(struct device *host, struct cxl_dport *dport,
>  				resource_size_t component_reg_phys)
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index ef4496b4e55e..532506595d0f 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -99,4 +99,7 @@ static inline void devm_cxl_port_ras_setup(struct cxl_port *port)
>  }
>  #endif
>  
> +int cxl_port_setup_regs(struct cxl_port *port,
> +			resource_size_t component_reg_phys);
> +
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index d76b4b532064..f8a33dbf8222 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -278,6 +278,11 @@ static struct cxl_dport *cxl_port_add_dport(struct cxl_port *port,
>  		return ERR_CAST(port_group);
>  
>  	if (port->nr_dports == 0) {
> +
> +		rc = cxl_port_setup_regs(port, port->component_reg_phys);
> +		if (rc)
> +			return ERR_PTR(rc);
> +
>  		rc = devm_cxl_switch_port_decoders_setup(port);
>  		if (rc)
>  			return ERR_PTR(rc);


