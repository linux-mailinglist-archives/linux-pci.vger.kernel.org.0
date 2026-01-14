Return-Path: <linux-pci+bounces-44863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 90703D213E9
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 21:58:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D3B03081E0F
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 20:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 090553559FB;
	Wed, 14 Jan 2026 20:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D2afWpRS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6959927BF7C;
	Wed, 14 Jan 2026 20:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768424188; cv=none; b=lUDqM8YXf7te0zo1GxguKiW3elZOAQd6jggB9gSH5fopFXaPPP4fxzjwfhoNnkmyer/JufOqUQlMX+LIWppQ3c4O5QHQ4tt922Lj0Jt3ZHTNxO4p1BXxNxSSguFrSU473F/cBGaLWMmSYjXqWUCr/dA9nTjWJTOmOJD0QGsBpro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768424188; c=relaxed/simple;
	bh=Orgs7FaWsB3S9+3gnt7IQOM2hYPTuqmxTLe/bCiHpYI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BleGdvUmgBfsj11NKawJTZj/WKtmT6+zjb13db4BjPK7HX1NgmB3Dt1raLXQu+nwGzK8cH722luAQss6sqV1Xv3O/eUecFLuv8uHmFLTwasxvvwl6Wl4aghjkAhp4PVqETPbiorUw0gQgZbf6ABu+N+WAlzJqr5e5/9huzP+SQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D2afWpRS; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768424187; x=1799960187;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Orgs7FaWsB3S9+3gnt7IQOM2hYPTuqmxTLe/bCiHpYI=;
  b=D2afWpRSJ0ZhKF5UNUHcwLPvI4Bhmezg4Z4asrETWnqtKh5lV+nS4uCw
   tIYXn1TzMKjtpAdWczmJwkorhoTfvSFp/M2KCYCPsNYiXedw4LzGarayi
   KdKV/TYA1my2UV85PHXRfWy2je6+s8gbOEyytoW2l+BK5sVNwVrdsHPn9
   CevuYrd7Gmwnl1+sXznMqx3jxvRGV+r4geDf9muK0VySiQIqnFf/Dw95j
   RkH37Wo2G4YY1Bg8iimda6InVSWll/+fBkjWubFVJ8R1OIcLolrvOvKPZ
   Wv6+/bCysffj6XZgT7lcAtudKzDgs/ns+HwcnHY/f+1RB2nV925npjBNx
   Q==;
X-CSE-ConnectionGUID: 05+YPpvYTZC+F65WBnrerQ==
X-CSE-MsgGUID: 1iaOQYsJQrmpGmHkg2I1mA==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="68940273"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="68940273"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 12:56:27 -0800
X-CSE-ConnectionGUID: 1mnsFSl0Q6uT/xEWp3LJ2w==
X-CSE-MsgGUID: bTgHXjpYRw2z7gWtzlGFWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="208942788"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.5]) ([10.125.111.5])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 12:56:25 -0800
Message-ID: <0192da8e-c7f3-42e9-a040-16e32dfaecb5@intel.com>
Date: Wed, 14 Jan 2026 13:56:24 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 14/34] PCI/AER: Report CXL or PCIe bus type in AER
 trace logging
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
 <20260114182055.46029-15-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260114182055.46029-15-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/26 11:20 AM, Terry Bowman wrote:
> The AER service driver and aer_event tracing currently log 'PCIe Bus Type'
> for all errors. Update the driver and aer_event tracing to log 'CXL Bus
> Type' for CXL device errors.
> 
> This requires that AER can identify and distinguish between PCIe errors and
> CXL errors.
> 
> Introduce boolean 'is_cxl' to 'struct aer_err_info'. Add assignment in
> aer_get_device_error_info() and pci_print_aer().
> 
> Update the aer_event trace routine to accept a bus type string parameter.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> 
> ---
> 
> Changes in v13->v14:
> - Merged with Dan's commit. Changes are moving bus_type the last
>   parameter in function calls (Dan)
> - Removed all DCOs because of changes (Terry)
> - Update commit message (Bjorn)
> - Add Bjorn's ack-by
> 
> Changes in v12->v13:
> - Remove duplicated aer_err_info inline comments. Is already in the
>   kernel-doc header (Ben)
> 
> Changes in v11->v12:
>  - Change aer_err_info::is_cxl to be bool a bitfield. Update structure
>  padding. (Lukas)
>  - Add kernel-doc for 'struct aer_err_info' (Lukas)
> 
> Changes in v10->v11:
>  - Remove duplicate call to trace_aer_event() (Shiju)
>  - Added Dan William's and Dave Jiang's reviewed-by
> ---
>  drivers/pci/pci.h       |  8 +++++++-
>  drivers/pci/pcie/aer.c  | 20 +++++++++++++-------
>  include/ras/ras_event.h | 12 ++++++++----
>  3 files changed, 28 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 0e67014aa001..41ec38e82c08 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -738,7 +738,8 @@ struct aer_err_info {
>  	unsigned int multi_error_valid:1;
>  
>  	unsigned int first_error:5;
> -	unsigned int __pad2:2;
> +	unsigned int __pad2:1;
> +	unsigned int is_cxl:1;
>  	unsigned int tlp_header_valid:1;
>  
>  	unsigned int status;		/* COR/UNCOR Error Status */
> @@ -749,6 +750,11 @@ struct aer_err_info {
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
> index b1e6ee7468b9..d30a217fae46 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -870,6 +870,7 @@ void aer_print_error(struct aer_err_info *info, int i)
>  	struct pci_dev *dev;
>  	int layer, agent, id;
>  	const char *level = info->level;
> +	const char *bus_type = aer_err_bus(info);
>  
>  	if (WARN_ON_ONCE(i >= AER_MAX_MULTI_ERR_DEVICES))
>  		return;
> @@ -879,22 +880,22 @@ void aer_print_error(struct aer_err_info *info, int i)
>  
>  	pci_dev_aer_stats_incr(dev, info);
>  	trace_aer_event(pci_name(dev), (info->status & ~info->mask),
> -			info->severity, info->tlp_header_valid, &info->tlp);
> +			info->severity, info->tlp_header_valid, &info->tlp, bus_type);
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
> @@ -928,6 +929,7 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  		   struct aer_capability_regs *aer)
>  {
> +	const char *bus_type;
>  	int layer, agent, tlp_header_valid = 0;
>  	u32 status, mask;
>  	struct aer_err_info info = {
> @@ -948,10 +950,13 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  
>  	info.status = status;
>  	info.mask = mask;
> +	info.is_cxl = pcie_is_cxl(dev);
> +
> +	bus_type = aer_err_bus(&info);
>  
>  	pci_dev_aer_stats_incr(dev, &info);
> -	trace_aer_event(pci_name(dev), (status & ~mask),
> -			aer_severity, tlp_header_valid, &aer->header_log);
> +	trace_aer_event(pci_name(dev), (status & ~mask), aer_severity,
> +			tlp_header_valid, &aer->header_log, bus_type);
>  
>  	if (!aer_ratelimit(dev, info.severity))
>  		return;
> @@ -1301,6 +1306,7 @@ int aer_get_device_error_info(struct aer_err_info *info, int i)
>  	/* Must reset in this function */
>  	info->status = 0;
>  	info->tlp_header_valid = 0;
> +	info->is_cxl = pcie_is_cxl(dev);
>  
>  	/* The device might not support AER */
>  	if (!aer)
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index eaecc3c5f772..fdb785fa4613 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -339,9 +339,11 @@ TRACE_EVENT(aer_event,
>  		 const u32 status,
>  		 const u8 severity,
>  		 const u8 tlp_header_valid,
> -		 struct pcie_tlp_log *tlp),
> +		 struct pcie_tlp_log *tlp,
> +		 const char *bus_type),
>  
> -	TP_ARGS(dev_name, status, severity, tlp_header_valid, tlp),
> +
> +	TP_ARGS(dev_name, status, severity, tlp_header_valid, tlp, bus_type),
>  
>  	TP_STRUCT__entry(
>  		__string(	dev_name,	dev_name	)
> @@ -349,10 +351,12 @@ TRACE_EVENT(aer_event,
>  		__field(	u8,		severity	)
>  		__field(	u8, 		tlp_header_valid)
>  		__array(	u32, 		tlp_header, PCIE_STD_MAX_TLP_HEADERLOG)
> +		__string(	bus_type,	bus_type	)
>  	),
>  
>  	TP_fast_assign(
>  		__assign_str(dev_name);
> +		__assign_str(bus_type);
>  		__entry->status		= status;
>  		__entry->severity	= severity;
>  		__entry->tlp_header_valid = tlp_header_valid;
> @@ -364,8 +368,8 @@ TRACE_EVENT(aer_event,
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


