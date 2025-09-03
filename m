Return-Path: <linux-pci+bounces-35415-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F10CCB42D52
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 01:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7841C1B262B2
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 23:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C5C2D24A4;
	Wed,  3 Sep 2025 23:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P1RnlPRZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43F527464F;
	Wed,  3 Sep 2025 23:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756941790; cv=none; b=g7Q8eMRoCE2zRLoqieSS4kmnwmkDdB4/HxV63YpW41zFQqNVeTnXviGXlaCuyto6vTW7tCugB+X6HQbeVBqhJDyztb+eX8A1wngkG4dqB5Wb6oF4TGTIqXKV2cpFBuQs/Pwws7wEBOHFDrBDwH6xJrcoi6LuuGM5HkSgVueRL2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756941790; c=relaxed/simple;
	bh=E2DDIUm1Asuy7g+z0r5szUHglM8b3qs8abA9+8SByI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jCY9Vh6+tNu3wkdZCndR44tHrTPNxE8uJXfg8cKtXNujWuCN7D1O7q+k/aVviUbOr8FG/j8ToocuGJdoH8dOHJTen4KKWg5Ye/IP21SCHHDWoA/CFaVOa40VAEtZmLodU7/k51EHKl06xawH8C81hhlmUzHUeG2qrS7NMoP/7os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P1RnlPRZ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756941789; x=1788477789;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=E2DDIUm1Asuy7g+z0r5szUHglM8b3qs8abA9+8SByI0=;
  b=P1RnlPRZ5GY7cFZJA1t3I3D6oj7S6zlOHb7wXsrEWduB5Ej2rCw8eEUY
   y2JkJeeCHmnSADgZYe1eneRADgg7HNB1j9QszaOqypxTKHbI4V8YpnGWt
   CZLUDUD1bk4xHCZOTGF1Bn2nmDWUD1aawTBjFmkh02QTwfDNI4JqCMluw
   Rf0xpaPCuFfrHOg8PUbV6IEk6ycyXgjBcugqQxbXE3ztUyywz28v4zVGP
   fc2HXAD/c2ye4aw8hzwt5o7M0js+P5ToovN32yZ6c57t9HTaULVUskZDD
   T3NX5DIg4E1iRKJLsYhI4Or3nc80NZd2WtE/CSgL07TDvx6sLBviOsb+/
   Q==;
X-CSE-ConnectionGUID: aCfXDoXoRHCmPW1WHluawQ==
X-CSE-MsgGUID: vuHTShJ8RwWtdyc94tcCEA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59187377"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59187377"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 16:23:08 -0700
X-CSE-ConnectionGUID: DsbL7M/nSva5tMJZ76VbIw==
X-CSE-MsgGUID: gepGdxWgQRuIgo689NopRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,236,1751266800"; 
   d="scan'208";a="171284106"
Received: from kcaccard-desk.amr.corp.intel.com (HELO [10.125.109.251]) ([10.125.109.251])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2025 16:23:05 -0700
Message-ID: <c175d39d-699e-4e1b-b6c0-089eda74432c@intel.com>
Date: Wed, 3 Sep 2025 16:23:04 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 22/23] CXL/PCI: Enable CXL protocol errors during CXL
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
References: <20250827013539.903682-1-terry.bowman@amd.com>
 <20250827013539.903682-23-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250827013539.903682-23-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/26/25 6:35 PM, Terry Bowman wrote:
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
> Changes in v10->v11:
> - Added check for valid PCI devices in is_cxl_error() (Terry)
> - Removed check for RCiEP in cxl_handle_proto_err() and
>   cxl_report_error_detected() (Terry)
> ---
>  drivers/cxl/core/ras.c | 26 +++++++++++++++++++++++++-
>  drivers/pci/pci.h      |  2 --
>  include/linux/aer.h    |  2 ++
>  3 files changed, 27 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 3da675f72616..90ea0dfb942f 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -122,6 +122,21 @@ static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>  static pci_ers_result_t cxl_handle_ras(struct device *dev, u64 serial, void __iomem *ras_base);
>  static void cxl_handle_cor_ras(struct device *dev, u64 serial, void __iomem *ras_base);
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
>  #ifdef CONFIG_CXL_RCH_RAS
>  static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>  {
> @@ -418,7 +433,10 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
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
> @@ -429,8 +447,12 @@ static void cxl_uport_init_ras_reporting(struct cxl_port *port,
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
> @@ -466,6 +488,8 @@ void cxl_endpoint_port_init_ras(struct cxl_port *ep)
>  	}
>  
>  	cxl_dport_init_ras_reporting(parent_dport, cxlmd->cxlds->dev);
> +
> +	cxl_unmask_proto_interrupts(cxlmd->cxlds->dev);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_endpoint_port_init_ras, "CXL");
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 0c4f73dd645f..090b52a26862 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -1169,12 +1169,10 @@ static inline void cxl_rch_enable_rcec(struct pci_dev *rcec) { }
>  #endif
>  
>  #ifdef CONFIG_CXL_RAS
> -void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>  bool is_internal_error(struct aer_err_info *info);
>  bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info);
>  void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info);
>  #else
> -static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
>  static inline bool is_internal_error(struct aer_err_info *info) { return false; }
>  static inline bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return false; }
>  static inline void cxl_forward_error(struct pci_dev *pdev, struct aer_err_info *info) { }
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 751a026fea73..4e2fc55f2497 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -82,11 +82,13 @@ int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd);
>  void cxl_register_proto_err_work(struct work_struct *work);
>  void cxl_unregister_proto_err_work(void);
>  bool cxl_error_is_native(struct pci_dev *dev);
> +void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>  #else
>  static inline int cxl_proto_err_kfifo_get(struct cxl_proto_err_work_data *wd) { return 0; }
>  static inline void cxl_register_proto_err_work(struct work_struct *work) { }
>  static inline void cxl_unregister_proto_err_work(void) { }
>  static inline bool cxl_error_is_native(struct pci_dev *dev) { return false; }
> +static inline void pci_aer_unmask_internal_errors(struct pci_dev *dev) { }
>  #endif
>  
>  void pci_print_aer(struct pci_dev *dev, int aer_severity,


