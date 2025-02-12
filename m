Return-Path: <linux-pci+bounces-21251-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC33A31A55
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 01:19:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0E973A29F3
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 00:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21AA271813;
	Wed, 12 Feb 2025 00:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T7QntYRl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D5C817C2;
	Wed, 12 Feb 2025 00:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739319551; cv=none; b=awrpWrqswDA51gFhdmfHpJAYfU78ARKmWbWJ/CNxf0HC5qurVZKEeAO4R2GshjlcN6IuZi+E0DcWvdkrHPmF04zUDV0fjhexMbUDH+98+gCWkn0G/R6NuMIcedegvbYjX1NW7KNZj3wKQFgMaUv7/aCWkfEcJOs0wg08afIYfgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739319551; c=relaxed/simple;
	bh=UjO9HKRObCM9PjpIzYAIASQHdZcH49xZsv0gQ8NAzZ0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=Mmfyl+y8dIn7OhScZYyplMwQILgziPrwP94Li4Y4Vpe4usQwRtrLlbpYvfguQLQv9DrnZ0g8KcuWH0fi0a1Kb+Y+EGUzUViLlJULC5y/6O4371zQ3cCYDh6ps3DkD0hXtBzoFyGdcztpr22GWV90I7oY1wEL4GBRMdT63DnF8zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T7QntYRl; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739319549; x=1770855549;
  h=message-id:date:mime-version:subject:from:to:references:
   in-reply-to:content-transfer-encoding;
  bh=UjO9HKRObCM9PjpIzYAIASQHdZcH49xZsv0gQ8NAzZ0=;
  b=T7QntYRls8t7R1aWc+/jWzcfm5y4G3fpk9VNsdMFiyfkeA8gAKqWQ+2m
   x6wVNIcyJnQ6X0jB8kcaN20StJTd0xWdTWTAEPiAXs7usCF2Yjgk1HUrV
   Gtm80L7i7jwDr/gO2+Kf0fJklc5ZS4IQ7lOklJPrvGg9r7Cq2GrdSb9nQ
   4SOsH5jSPqwvOo8JqAIAuEeiC1rXHeQx7yp/JfGltc0vu0Xa0u37excJo
   L4QO2udYuMpCBveHCXC9aJjClmZTzN5LSmj8WQYBJGSZwpqat6wnapLSH
   DGJk4++Bx8BSpcEKxVoP+G3oIWdXcCHykMP8ZGFDVHQVzlYP7BOJyjnxI
   A==;
X-CSE-ConnectionGUID: OIfSAtVJSAW1otZSYk9TzA==
X-CSE-MsgGUID: GHbwX9rATJSb2S2G1PMmHg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39981636"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="39981636"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 16:19:09 -0800
X-CSE-ConnectionGUID: oMAMxFIPQdGfzMaqmuyyWA==
X-CSE-MsgGUID: 31FwFOphT6qier/iZbjVNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="143507181"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.108.65]) ([10.125.108.65])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 16:19:07 -0800
Message-ID: <94ab0ed6-753f-4415-87bf-4dd066ec02e1@intel.com>
Date: Tue, 11 Feb 2025 17:19:05 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 13/17] cxl/pci: Add trace logging for CXL PCIe Port RAS
 errors
From: Dave Jiang <dave.jiang@intel.com>
To: Terry Bowman <terry.bowman@amd.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 nifan.cxl@gmail.com, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com, lukas@wunner.de,
 ming.li@zohomail.com, PradeepVineshReddy.Kodamati@amd.com
References: <20250211192444.2292833-1-terry.bowman@amd.com>
 <20250211192444.2292833-14-terry.bowman@amd.com>
 <1ba44c00-26f4-4373-8726-2874d32b61d2@intel.com>
Content-Language: en-US
In-Reply-To: <1ba44c00-26f4-4373-8726-2874d32b61d2@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/25 5:17 PM, Dave Jiang wrote:
> 
> 
> On 2/11/25 12:24 PM, Terry Bowman wrote:
>> The CXL drivers use kernel trace functions for logging Endpoint and
>> Restricted CXL host (RCH) Downstream Port RAS errors. Similar functionality
>> is required for CXL Root Ports, CXL Downstream Switch Ports, and CXL
>> Upstream Switch Ports.
>>
>> Introduce trace logging functions for both RAS correctable and
>> uncorrectable errors specific to CXL PCIe Ports. Additionally, update
>> the CXL Port Protocol Error handlers to invoke these new trace functions.
>>
>> Examples of the output from these changes is below.
>>
>> Correctable error:
>> cxl_port_aer_correctable_error: device=port1 parent=root0 status='Received Error From Physical Layer'
> 
> Is there any way to identify if the error comes from the USP or DSP? Specifically the PCI devname for the specific port?

Hah I spoke too soon. You addressed it in the next patch. :)

DJ

>>
>> Uncorrectable error:
>> cxl_port_aer_uncorrectable_error: device=port1 parent=root0 status: 'Memory Byte Enable Parity Error' first_error: 'Memory Byte Enable Parity Erro'
>>
>> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
>> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> 
>> ---
>>  drivers/cxl/core/pci.c   |  4 ++++
>>  drivers/cxl/core/trace.h | 47 ++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 51 insertions(+)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 3f13d9dfb610..9a3090dae46a 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -671,6 +671,8 @@ static void __cxl_handle_cor_ras(struct device *dev,
>>  
>>  	if (is_cxl_memdev(dev))
>>  		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
>> +	else if (is_cxl_port(dev))
>> +		trace_cxl_port_aer_correctable_error(dev, status);
>>  }
>>  
>>  static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
>> @@ -730,6 +732,8 @@ static pci_ers_result_t __cxl_handle_ras(struct device *dev, void __iomem *ras_b
>>  	header_log_copy(ras_base, hl);
>>  	if (is_cxl_memdev(dev))
>>  		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
>> +	else if (is_cxl_port(dev))
>> +		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
>>  
>>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>>  
>> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
>> index cea706b683b5..b536233ac210 100644
>> --- a/drivers/cxl/core/trace.h
>> +++ b/drivers/cxl/core/trace.h
>> @@ -48,6 +48,34 @@
>>  	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
>>  )
>>  
>> +TRACE_EVENT(cxl_port_aer_uncorrectable_error,
>> +	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
>> +	TP_ARGS(dev, status, fe, hl),
>> +	TP_STRUCT__entry(
>> +		__string(devname, dev_name(dev))
>> +		__string(parent, dev_name(dev->parent))
>> +		__field(u32, status)
>> +		__field(u32, first_error)
>> +		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
>> +	),
>> +	TP_fast_assign(
>> +		__assign_str(devname);
>> +		__assign_str(parent);
>> +		__entry->status = status;
>> +		__entry->first_error = fe;
>> +		/*
>> +		 * Embed the 512B headerlog data for user app retrieval and
>> +		 * parsing, but no need to print this in the trace buffer.
>> +		 */
>> +		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
>> +	),
>> +	TP_printk("device=%s parent=%s status: '%s' first_error: '%s'",
>> +		__get_str(devname), __get_str(parent),
>> +		show_uc_errs(__entry->status),
>> +		show_uc_errs(__entry->first_error)
>> +	)
>> +);
>> +
>>  TRACE_EVENT(cxl_aer_uncorrectable_error,
>>  	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32 *hl),
>>  	TP_ARGS(cxlmd, status, fe, hl),
>> @@ -96,6 +124,25 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>>  	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }	\
>>  )
>>  
>> +TRACE_EVENT(cxl_port_aer_correctable_error,
>> +	TP_PROTO(struct device *dev, u32 status),
>> +	TP_ARGS(dev, status),
>> +	TP_STRUCT__entry(
>> +		__string(devname, dev_name(dev))
>> +		__string(parent, dev_name(dev->parent))
>> +		__field(u32, status)
>> +	),
>> +	TP_fast_assign(
>> +		__assign_str(devname);
>> +		__assign_str(parent);
>> +		__entry->status = status;
>> +	),
>> +	TP_printk("device=%s parent=%s status='%s'",
>> +		__get_str(devname), __get_str(parent),
>> +		show_ce_errs(__entry->status)
>> +	)
>> +);
>> +
>>  TRACE_EVENT(cxl_aer_correctable_error,
>>  	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
>>  	TP_ARGS(cxlmd, status),
> 
> 


