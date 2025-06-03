Return-Path: <linux-pci+bounces-28918-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF4AACCF8A
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 00:02:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EE513A495E
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 22:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8E01C3306;
	Tue,  3 Jun 2025 22:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LEo94ASV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C591A8405;
	Tue,  3 Jun 2025 22:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748988134; cv=none; b=g5bvujmMOpX13ph+ASHOdQyi+fDS7ubwDc6F/XADm/TKSbhjOTIGnHDJQEAawSrZgtaQBlA6XTq0rdSOTuyyjjsEHtjzio6MU6SnmLNCCL9UAsU7N3Ar1/yyKIeIFuy6ZsRKOpjYlkKZfIHW/+HH6sCxSVwbkOwS9FaZc+RtANE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748988134; c=relaxed/simple;
	bh=/N4x6JH/JcTx6ATrdbbDoNwqNE7XakA7w925Ax5H8L8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B4qzMyUQQFlXYeorYa2niiP1F+c0tgpp/FaeJVLVqQsW1xJP/m3fM0vIURFrPomXA20XU4tcK+InlEw7t5j+sLIZ5EjvBCaIIN48VD6GlAf2skCUr3vj0SDXnOmNrPhY5jRnZhkTHqVmZtnaVI+moRb1ZZ/xIpem9bOxW1d/5ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LEo94ASV; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748988132; x=1780524132;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=/N4x6JH/JcTx6ATrdbbDoNwqNE7XakA7w925Ax5H8L8=;
  b=LEo94ASV5rx15GZK+NRpwZyj423a+h5kgqulwhZawxOwaBG/G/c0Z1cT
   ZZAQAeIrEHsP8JmrGuhgiYSzGFE+T3np2rHAenvi10+mG6N29H1WEtcVI
   QxOYNJT8fJvrbw509dn3kt5WWnctvx9dwETt+tImi89nLzgVsSHS6vTcm
   jY7iHuOh9TuRwE6mZQne92oeObHTJJHgNY9Z2HVAF8hO92G1DHxGKpMHX
   hw/xui7hKnJO1/WfUzBGD/n8oIt9hXRJhyyVfijlbyWLcYyijjdAff6p2
   M3ry0lSzyd0bqFkTFmOq5bO63YVH9VUMwhEamMszk6sR9i5w1RCoCNQul
   A==;
X-CSE-ConnectionGUID: /EnHfYBoSSaAZ+sI7etcdw==
X-CSE-MsgGUID: kgzR3a4ERt6Xc8NnuBixqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="61669521"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="61669521"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 15:02:11 -0700
X-CSE-ConnectionGUID: FxcTjBUdQ8Soeyc/hlK4pw==
X-CSE-MsgGUID: DEj5LGPGRP2Su+aM3klY8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="145308795"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 15:02:10 -0700
Received: from [10.124.221.22] (unknown [10.124.221.22])
	by linux.intel.com (Postfix) with ESMTP id ACFB220B5736;
	Tue,  3 Jun 2025 15:02:08 -0700 (PDT)
Message-ID: <0619c83f-84d9-4dcd-866d-d6df1da4d1c9@linux.intel.com>
Date: Tue, 3 Jun 2025 15:02:08 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 02/16] PCI/AER: Report CXL or PCIe bus error type in
 trace logging
To: Terry Bowman <terry.bowman@amd.com>, PradeepVineshReddy.Kodamati@amd.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, bp@alien8.de,
 ming.li@zohomail.com, shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org, colyli@suse.de,
 uaisheng.ye@intel.com, fabio.m.de.francesco@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, yazen.ghannam@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-3-terry.bowman@amd.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250603172239.159260-3-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/3/25 10:22 AM, Terry Bowman wrote:
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
> ---
>   drivers/pci/pci.h       |  6 ++++++
>   drivers/pci/pcie/aer.c  | 18 ++++++++++++------
>   include/ras/ras_event.h |  9 ++++++---
>   3 files changed, 24 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index b81e99cd4b62..d6296500b004 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -588,6 +588,7 @@ static inline bool pci_dev_test_and_set_removed(struct pci_dev *dev)
>   struct aer_err_info {
>   	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
>   	int error_dev_num;
> +	bool is_cxl;

Do you really need this member ? Why not just use pcie_is_cxl() in aer_err_bus()?

>   
>   	unsigned int id:16;
>   
> @@ -604,6 +605,11 @@ struct aer_err_info {
>   	struct pcie_tlp_log tlp;	/* TLP Header */
>   };
>   
> +static inline const char *aer_err_bus(struct aer_err_info *info)
> +{
> +	return info->is_cxl ? "CXL" : "PCIe";
> +}
> +
>   int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
>   void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
>   
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index a1cf8c7ef628..adb4b1123b9b 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -698,13 +698,14 @@ static void __aer_print_error(struct pci_dev *dev,
>   
>   void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>   {
> +	const char *bus_type = aer_err_bus(info);
>   	int layer, agent;
>   	int id = pci_dev_id(dev);
>   	const char *level;
>   
>   	if (!info->status) {
> -		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
> -			aer_error_severity_string[info->severity]);
> +		pci_err(dev, "%s Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
> +			bus_type, aer_error_severity_string[info->severity]);
>   		goto out;
>   	}
>   
> @@ -713,8 +714,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>   
>   	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
>   
> -	aer_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
> -		   aer_error_severity_string[info->severity],
> +	aer_printk(level, dev, "%s Bus Error: severity=%s, type=%s, (%s)\n",
> +		   bus_type, aer_error_severity_string[info->severity],
>   		   aer_error_layer[layer], aer_agent_string[agent]);
>   
>   	aer_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
> @@ -729,7 +730,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>   	if (info->id && info->error_dev_num > 1 && info->id == id)
>   		pci_err(dev, "  Error of this Agent is reported first\n");
>   
> -	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
> +	trace_aer_event(dev_name(&dev->dev), bus_type, (info->status & ~info->mask),
>   			info->severity, info->tlp_header_valid, &info->tlp);
>   }
>   
> @@ -763,6 +764,7 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
>   void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   		   struct aer_capability_regs *aer)
>   {
> +	const char *bus_type;
>   	int layer, agent, tlp_header_valid = 0;
>   	u32 status, mask;
>   	struct aer_err_info info;
> @@ -784,6 +786,9 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   	info.status = status;
>   	info.mask = mask;
>   	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
> +	info.is_cxl = pcie_is_cxl(dev);
> +
> +	bus_type = aer_err_bus(&info);
>   
>   	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
>   	__aer_print_error(dev, &info);
> @@ -797,7 +802,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   	if (tlp_header_valid)
>   		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
>   
> -	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
> +	trace_aer_event(dev_name(&dev->dev), bus_type, (status & ~mask),
>   			aer_severity, tlp_header_valid, &aer->header_log);
>   }
>   EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
> @@ -1215,6 +1220,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>   	/* Must reset in this function */
>   	info->status = 0;
>   	info->tlp_header_valid = 0;
> +	info->is_cxl = pcie_is_cxl(dev);
>   
>   	/* The device might not support AER */
>   	if (!aer)
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index 14c9f943d53f..080829d59c36 100644
> --- a/include/ras/ras_event.h
> +++ b/include/ras/ras_event.h
> @@ -297,15 +297,17 @@ TRACE_EVENT(non_standard_event,
>   
>   TRACE_EVENT(aer_event,
>   	TP_PROTO(const char *dev_name,
> +		 const char *bus_type,
>   		 const u32 status,
>   		 const u8 severity,
>   		 const u8 tlp_header_valid,
>   		 struct pcie_tlp_log *tlp),
>   
> -	TP_ARGS(dev_name, status, severity, tlp_header_valid, tlp),
> +	TP_ARGS(dev_name, bus_type, status, severity, tlp_header_valid, tlp),
>   
>   	TP_STRUCT__entry(
>   		__string(	dev_name,	dev_name	)
> +		__string(	bus_type,	bus_type	)
>   		__field(	u32,		status		)
>   		__field(	u8,		severity	)
>   		__field(	u8, 		tlp_header_valid)
> @@ -314,6 +316,7 @@ TRACE_EVENT(aer_event,
>   
>   	TP_fast_assign(
>   		__assign_str(dev_name);
> +		__assign_str(bus_type);
>   		__entry->status		= status;
>   		__entry->severity	= severity;
>   		__entry->tlp_header_valid = tlp_header_valid;
> @@ -325,8 +328,8 @@ TRACE_EVENT(aer_event,
>   		}
>   	),
>   
> -	TP_printk("%s PCIe Bus Error: severity=%s, %s, TLP Header=%s\n",
> -		__get_str(dev_name),
> +	TP_printk("%s %s Bus Error: severity=%s, %s, TLP Header=%s\n",
> +		__get_str(dev_name), __get_str(bus_type),
>   		__entry->severity == AER_CORRECTABLE ? "Corrected" :
>   			__entry->severity == AER_FATAL ?
>   			"Fatal" : "Uncorrected, non-fatal",

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


