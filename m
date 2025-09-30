Return-Path: <linux-pci+bounces-37236-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB84BAACC9
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 02:29:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C52422220
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 00:29:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E695927462;
	Tue, 30 Sep 2025 00:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ADk3YYoI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7922C4C6D;
	Tue, 30 Sep 2025 00:29:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759192142; cv=none; b=XPNProZQRdG6k7rzzKhKdMe3AeIGiu5GKsJnHXSlf+dfzk10PBgL2xO/1V6+6GmUAa8EbHMsPveI2Ugcc0Z9bsH+AF+DWILqH2+kYKYpuxjK4kwDBYzvmdbDROUvVvfVyRggx5JhX4oUg0AzLkUDaBMfwrkiiQKpCXRmyS9zbT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759192142; c=relaxed/simple;
	bh=/K1NH2BBDWmQRvUSdG1cX2fwrdzzEIOzQ66NTsUv22Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s2dwcgsjs9RbLiCYmePjkeNv36fo58KfFknBHDwrUzNhNF5K4PCArD35yQmwwSTfv3cwmnxjLoqx1InkG1Du1q5K9nKswa4rrR3YkM4Wti7WKiSOLcqkpyfSRbt8sEODpLVBR2u7deChOStFB8Bg8hxTt7HIvtGAdR9SpLmlpCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ADk3YYoI; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759192141; x=1790728141;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/K1NH2BBDWmQRvUSdG1cX2fwrdzzEIOzQ66NTsUv22Q=;
  b=ADk3YYoIAxBnRYv5sjuIxrAexBPGcAitQdsZ3TyXwp2cPQO333xitwUl
   07e10/V2QtnjmnXIxEVahkrNJw6U62oRgKeoFzZf6sYWWH6BUhCr0cFlg
   Q5bx7Mk/zs/9yozFyLudZCERWgZW5n0Rj3xU9mr9wQj2pSEZIi75oRXD9
   K1kvlq9mp1DCCP03NOE1BWL7fXo9QZ+lMLldGqDgzwzLrSyK8fC5qIECm
   HK0cli96SPT5SpW97MW5mA81x64uS5hbfddOzS7UGMKVWwDLNxdtqr/kD
   eJNiDpY0Dqf2AOVvFAyhkJPaEMB7B8I22cawtOm8oJoyy7hY/RNoxJmfL
   Q==;
X-CSE-ConnectionGUID: kdYvd1/rTAWXtACCLo+T9w==
X-CSE-MsgGUID: wOigqN1eTv6Ag8PdTU6S8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11568"; a="61485508"
X-IronPort-AV: E=Sophos;i="6.18,302,1751266800"; 
   d="scan'208";a="61485508"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 17:28:59 -0700
X-CSE-ConnectionGUID: adU5OzbRSOmzBlhm3uNAPQ==
X-CSE-MsgGUID: eIpb4bnERPizhWZeGOkPqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,302,1751266800"; 
   d="scan'208";a="178410347"
Received: from tslove-mobl4.amr.corp.intel.com (HELO [10.125.109.142]) ([10.125.109.142])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2025 17:28:58 -0700
Message-ID: <43ca8a5c-9da5-4d36-a51a-f551174088e9@intel.com>
Date: Mon, 29 Sep 2025 17:28:57 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 24/25] CXL/PCI: Enable CXL protocol errors during CXL
 Port probe
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
 <20250925223440.3539069-25-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250925223440.3539069-25-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/25/25 3:34 PM, Terry Bowman wrote:
> CXL protocol errors are not enabled for all CXL devices after boot. These
> must be enabled inorder to process CXL protocol errors.
> 
> Introduce cxl_unmask_proto_interrupts() to call pci_aer_unmask_internal_errors().
> pci_aer_unmask_internal_errors() expects the pdev->aer_cap is initialized.
> But, dev->aer_cap is not initialized for CXL Upstream Switch Ports and CXL
> Downstream Switch Ports. Initialize the dev->aer_cap if necessary. Enable AER
> correctable internal errors and uncorrectable internal errors for all CXL
> devices.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> Changes in v11->v12:
> - None
> 
> Changes in v10->v11:
> - Added check for valid PCI devices in is_cxl_error() (Terry)
> - Removed check for RCiEP in cxl_handle_proto_err() and
>   cxl_report_error_detected() (Terry)
> ---
>  drivers/cxl/core/ras.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 45f92defca64..ea65001daba1 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -238,6 +238,21 @@ static inline void cxl_disable_rch_root_ints(struct cxl_dport *dport) { }
>  static inline void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
>  #endif
>  
> +static void cxl_unmask_proto_interrupts(struct device *dev)
> +{
> +	struct pci_dev *pdev __free(pci_dev_put) =
> +		pci_dev_get(to_pci_dev(dev));
> +
> +	if (!pdev->aer_cap) {
> +		pdev->aer_cap = pci_find_ext_capability(pdev,
> +							PCI_EXT_CAP_ID_ERR);
> +		if (!pdev->aer_cap)
> +			return;
> +	}
> +
> +	pci_aer_unmask_internal_errors(pdev);
> +}
> +
>  static void cxl_dport_map_ras(struct cxl_dport *dport)
>  {
>  	struct cxl_register_map *map = &dport->reg_map;
> @@ -391,7 +406,10 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>  
>  		cxl_dport_map_rch_aer(dport);
>  		cxl_disable_rch_root_ints(dport);
> +		return;
>  	}
> +
> +	cxl_unmask_proto_interrupts(dport->dport_dev);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>  
> @@ -402,8 +420,12 @@ static void cxl_uport_init_ras_reporting(struct cxl_port *port,
>  
>  	map->host = host;
>  	if (cxl_map_component_regs(map, &port->uport_regs,
> -				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
> +				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
>  		dev_dbg(&port->dev, "Failed to map RAS capability\n");
> +		return;
> +	}
> +
> +	cxl_unmask_proto_interrupts(port->uport_dev);
>  }
>  
>  void cxl_switch_port_init_ras(struct cxl_port *port)
> @@ -440,6 +462,8 @@ void cxl_endpoint_port_init_ras(struct cxl_port *ep)
>  	}
>  
>  	cxl_dport_init_ras_reporting(parent_dport, cxlmd->cxlds->dev);
> +
> +	cxl_unmask_proto_interrupts(cxlmd->cxlds->dev);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_port_init_ras, "CXL");
>  


