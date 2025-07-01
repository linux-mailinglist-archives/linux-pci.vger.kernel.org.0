Return-Path: <linux-pci+bounces-31207-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D339AF059B
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 23:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04B23B7F12
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 21:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 296CF2EBDC7;
	Tue,  1 Jul 2025 21:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dPBiiAXB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603BD26AAA9;
	Tue,  1 Jul 2025 21:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751405250; cv=none; b=i+VbApJF609I1js+zgfEyZ4psPIOGzKBVz6wiDJi2dKIah08ksfOulaKy4NNHpoID+xSjvxXQ2CYhiOOZMep2lTM8+r5L4gSydO44G43SmurZwdyIDquAt/36esU+3Bpo1Bm+gUAYtxvKYLvDgneYIPg+p1ErKXT/9YAG4nUGd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751405250; c=relaxed/simple;
	bh=fKYoRb3/up9s3+dJqQkQ4Y2pMAEaBtfOTKyKwxmjQXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IskExYHyKndm9Ck8l09zeQzetzlQIylvS06eIcLh4BrulWcyHa5CAAFa42xRt2OyQt4K776YKDJi86MxrAmPmlkbEZ0APyNnDy77DxF7yt17Sidcl2jz5I9HJ47Q5R1fPBXNRqVScKOup9v1VbXxS6mjNzC376C9FMSPTvTRtac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dPBiiAXB; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751405248; x=1782941248;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fKYoRb3/up9s3+dJqQkQ4Y2pMAEaBtfOTKyKwxmjQXA=;
  b=dPBiiAXB0sXw7LC9otw43ZaqadRRpuNN92esHnMlX90VOQmhwpSb9rFy
   hsI13AFtN62bBaWwU5M/LEJA/MB0EpPoqaifXUGFF5Z7vOYEpI7ifmM1F
   ggr6myKOrs8ME63hKE2TXQwZq5KyqG/8pq40XuZAWdt9dX84CDdbex1jH
   Izs5Xz9yMqlVAvM39VZM0L0m7lULc/pLCtmFXQFrHWnX3v9x3XZswbGrv
   6CRfvloyvFzKcVe/BcxqVXjnpu9dJi+6ZylOpji3KnFpIRYuK4jd4i34u
   KjmB8eqL8TprtSPdv7WT49XOGhhvYCLJpNXgMJnxqI1VGhvt+93xFenzV
   w==;
X-CSE-ConnectionGUID: wUZkVYdXQqKXnXwjcYLe/w==
X-CSE-MsgGUID: K2JWQnUCSSWrzC+2Z8bazg==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="65144189"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="65144189"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 14:27:27 -0700
X-CSE-ConnectionGUID: ypuy8n05RYa+d1GZovK2og==
X-CSE-MsgGUID: 4Q2YzwxbT+CpUf6ooi8w8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="159594602"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.109.179]) ([10.125.109.179])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 14:27:25 -0700
Message-ID: <5752a35b-2dc8-4f20-b6ad-148eac9f7953@intel.com>
Date: Tue, 1 Jul 2025 14:27:24 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 03/17] PCI/AER: Report CXL or PCIe bus error type in
 trace logging
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20250626224252.1415009-1-terry.bowman@amd.com>
 <20250626224252.1415009-4-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250626224252.1415009-4-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/26/25 3:42 PM, Terry Bowman wrote:
> The AER service driver and aer_event tracing currently log 'PCIe Bus Type'
> for all errors. Update the driver and aer_event tracing to log 'CXL Bus
> Type' for CXL device errors.
> 
> This requires the AER can identify and distinguish between PCIe errors and
> CXL errors.
> 
> Introduce boolean 'is_cxl' to 'struct aer_err_info'. Add assignment in
> aer_get_device_error_info() and pci_print_aer().
> 
> Update the aer_event trace routine to accept a bus type string parameter.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/pci/pci.h       |  6 ++++++
>  drivers/pci/pcie/aer.c  | 21 +++++++++++++++------
>  include/ras/ras_event.h |  9 ++++++---
>  3 files changed, 27 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 12215ee72afb..a0d1e59b5666 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -608,6 +608,7 @@ struct aer_err_info {
>  	int ratelimit_print[AER_MAX_MULTI_ERR_DEVICES];
>  	int error_dev_num;
>  	const char *level;		/* printk level */
> +	bool is_cxl;
>  
>  	unsigned int id:16;
>  
> @@ -628,6 +629,11 @@ struct aer_err_info {
>  int aer_get_device_error_info(struct aer_err_info *info, int i);
>  void aer_print_error(struct aer_err_info *info, int i);
>  
> +static inline const char *aer_err_bus(struct aer_err_info *info)
> +{
> +	return info->is_cxl ? "CXL" : "PCIe";
> +}
> +
>  int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
>  		      unsigned int tlp_len, bool flit,
>  		      struct pcie_tlp_log *log);
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 70ac66188367..a2df9456595a 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -837,6 +837,7 @@ void aer_print_error(struct aer_err_info *info, int i)
>  	struct pci_dev *dev;
>  	int layer, agent, id;
>  	const char *level = info->level;
> +	const char *bus_type = aer_err_bus(info);
>  
>  	if (WARN_ON_ONCE(i >= AER_MAX_MULTI_ERR_DEVICES))
>  		return;
> @@ -845,23 +846,23 @@ void aer_print_error(struct aer_err_info *info, int i)
>  	id = pci_dev_id(dev);
>  
>  	pci_dev_aer_stats_incr(dev, info);
> -	trace_aer_event(pci_name(dev), (info->status & ~info->mask),
> +	trace_aer_event(pci_name(dev), bus_type, (info->status & ~info->mask),
>  			info->severity, info->tlp_header_valid, &info->tlp);
>  
>  	if (!info->ratelimit_print[i])
>  		return;
>  
>  	if (!info->status) {
> -		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
> -			aer_error_severity_string[info->severity]);
> +		pci_err(dev, "%s Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
> +			bus_type, aer_error_severity_string[info->severity]);
>  		goto out;
>  	}
>  
>  	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
>  	agent = AER_GET_AGENT(info->severity, info->status);
>  
> -	aer_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
> -		   aer_error_severity_string[info->severity],
> +	aer_printk(level, dev, "%s Bus Error: severity=%s, type=%s, (%s)\n",
> +		   bus_type, aer_error_severity_string[info->severity],
>  		   aer_error_layer[layer], aer_agent_string[agent]);
>  
>  	aer_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
> @@ -895,6 +896,7 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  		   struct aer_capability_regs *aer)
>  {
> +	const char *bus_type;
>  	int layer, agent, tlp_header_valid = 0;
>  	u32 status, mask;
>  	struct aer_err_info info = {
> @@ -915,9 +917,12 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  
>  	info.status = status;
>  	info.mask = mask;
> +	info.is_cxl = pcie_is_cxl(dev);
> +
> +	bus_type = aer_err_bus(&info);
>  
>  	pci_dev_aer_stats_incr(dev, &info);
> -	trace_aer_event(pci_name(dev), (status & ~mask),
> +	trace_aer_event(pci_name(dev), bus_type, (status & ~mask),
>  			aer_severity, tlp_header_valid, &aer->header_log);
>  
>  	if (!aer_ratelimit(dev, info.severity))
> @@ -939,6 +944,9 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  	if (tlp_header_valid)
>  		pcie_print_tlp_log(dev, &aer->header_log, info.level,
>  				   dev_fmt("  "));
> +
> +	trace_aer_event(dev_name(&dev->dev), bus_type, (status & ~mask),
> +			aer_severity, tlp_header_valid, &aer->header_log);
>  }
>  EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
>  
> @@ -1371,6 +1379,7 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
>  	/* Must reset in this function */
>  	info->status = 0;
>  	info->tlp_header_valid = 0;
> +	info->is_cxl = pcie_is_cxl(dev);
>  
>  	/* The device might not support AER */
>  	if (!aer)
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index 14c9f943d53f..080829d59c36 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -297,15 +297,17 @@ TRACE_EVENT(non_standard_event,
>  
>  TRACE_EVENT(aer_event,
>  	TP_PROTO(const char *dev_name,
> +		 const char *bus_type,
>  		 const u32 status,
>  		 const u8 severity,
>  		 const u8 tlp_header_valid,
>  		 struct pcie_tlp_log *tlp),
>  
> -	TP_ARGS(dev_name, status, severity, tlp_header_valid, tlp),
> +	TP_ARGS(dev_name, bus_type, status, severity, tlp_header_valid, tlp),
>  
>  	TP_STRUCT__entry(
>  		__string(	dev_name,	dev_name	)
> +		__string(	bus_type,	bus_type	)
>  		__field(	u32,		status		)
>  		__field(	u8,		severity	)
>  		__field(	u8, 		tlp_header_valid)
> @@ -314,6 +316,7 @@ TRACE_EVENT(aer_event,
>  
>  	TP_fast_assign(
>  		__assign_str(dev_name);
> +		__assign_str(bus_type);
>  		__entry->status		= status;
>  		__entry->severity	= severity;
>  		__entry->tlp_header_valid = tlp_header_valid;
> @@ -325,8 +328,8 @@ TRACE_EVENT(aer_event,
>  		}
>  	),
>  
> -	TP_printk("%s PCIe Bus Error: severity=%s, %s, TLP Header=%s\n",
> -		__get_str(dev_name),
> +	TP_printk("%s %s Bus Error: severity=%s, %s, TLP Header=%s\n",
> +		__get_str(dev_name), __get_str(bus_type),
>  		__entry->severity == AER_CORRECTABLE ? "Corrected" :
>  			__entry->severity == AER_FATAL ?
>  			"Fatal" : "Uncorrected, non-fatal",


