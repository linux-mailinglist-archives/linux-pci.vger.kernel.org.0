Return-Path: <linux-pci+bounces-15730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9F39B8005
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 17:27:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1051C21863
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 16:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571CE1BBBE0;
	Thu, 31 Oct 2024 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZjSDf+yZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2264F1BBBE5;
	Thu, 31 Oct 2024 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392034; cv=none; b=AqcybxrJ4atyBLXwvwMszRmFqKcVSrdCqYGLovL9HOrOt1H9YoVMjPZmaj+tVkXMP0mj6pd/je7qftXXIeiFfuclXZLsjwnHIk91oCqL+oNUqK1GRu3SMoxkck9OrC7cM/I/IucHRJgUaZuqaP3MavTfK+wvZTy5qliRjh1Df/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392034; c=relaxed/simple;
	bh=x3VGYA7MwWp6jzN6/+h9SPAxStwbeYk1Po1rpI6RtDw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PaE0mCsDXFtQu7eGLXjTsBOyRWN4xPErybfsJ91Tog6JDAOSScK0wQZp+O4WgEyF25aB8vlPQpQoPrejj3NkG5s0TrOZWc379iXLckiMldey+zpp6MKDPZkqlhe0dEZdW2xUbYQomwQ2M4oA9Eeby1aMwn8l0yZeWYS/uNH73Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZjSDf+yZ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730392032; x=1761928032;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=x3VGYA7MwWp6jzN6/+h9SPAxStwbeYk1Po1rpI6RtDw=;
  b=ZjSDf+yZCzfeSe4f76dsMAmeFRSf1MoCQz4HcwhoAomkvbeFtYhNAhct
   YMU/i+85y94J7L++bsgxf8d+fjOFDheHhm6ND2CVRpPvUTXq/6K8mf2PE
   pxa35IrKHi4gqq5jtydCny6FyRVs+9HvNyXhX5Z205IyRH+sVL7RiMuRM
   7MsAwvBmHZQglNRW4VNWgqY7yAQAx7Wy/YercxH5pxchzzzC4MFO/V7JO
   51duPkPVXXJF83k6BY3/Wfybsyjjno7ktJ7rpqOUDnoBVj6XXqhSYsKDR
   /a9lguCQitWlEKcUUThq/vEJNWmsNdz1owQMzxQzkL3k9/I/SXLudQP+E
   w==;
X-CSE-ConnectionGUID: CWzcs4kzQaS7jg2b/N7G6g==
X-CSE-MsgGUID: +hQDnnxpQ0GdQlaHi6WfwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="30259150"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="30259150"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 09:27:12 -0700
X-CSE-ConnectionGUID: viogqThGRGaTbUW0jFYyZA==
X-CSE-MsgGUID: esvJn3cCS3a4UmUJRkrf8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="113522798"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.108.232]) ([10.125.108.232])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 09:27:10 -0700
Message-ID: <271e1830-11a3-4ee7-a87b-4585b93438fb@intel.com>
Date: Thu, 31 Oct 2024 09:27:09 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 04/14] PCI/AER: Modify AER driver logging to report CXL
 or PCIe bus error type
To: Terry Bowman <terry.bowman@amd.com>, ming4.li@intel.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, dave@stgolabs.net, jonathan.cameron@huawei.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, mahesh@linux.ibm.com,
 ira.weiny@intel.com, oohall@gmail.com, Benjamin.Cheatham@amd.com,
 rrichter@amd.com, nathan.fontenot@amd.com,
 Smita.KoralahalliChannabasappa@amd.com
References: <20241025210305.27499-1-terry.bowman@amd.com>
 <20241025210305.27499-5-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20241025210305.27499-5-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/25/24 2:02 PM, Terry Bowman wrote:
> The AER driver and aer_event tracing currently log 'PCIe Bus Type'
> for all errors.
> 
> Update the driver and aer_event tracing to log 'CXL Bus Type' for CXL devices.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/pci/pcie/aer.c  | 14 ++++++++------
>  include/ras/ras_event.h |  9 ++++++---
>  2 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index fe6edf26279e..53e9a11f6c0f 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -699,13 +699,14 @@ static void __aer_print_error(struct pci_dev *dev,
>  
>  void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  {
> +	const char *bus_type = pcie_is_cxl(dev) ? "CXL"  : "PCIe";
>  	int layer, agent;
>  	int id = pci_dev_id(dev);
>  	const char *level;
>  
>  	if (!info->status) {
> -		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
> -			aer_error_severity_string[info->severity]);
> +		pci_err(dev, "%s Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
> +			bus_type, aer_error_severity_string[info->severity]);
>  		goto out;
>  	}
>  
> @@ -714,8 +715,8 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  
>  	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
>  
> -	pci_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
> -		   aer_error_severity_string[info->severity],
> +	pci_printk(level, dev, "%s Bus Error: severity=%s, type=%s, (%s)\n",
> +		   bus_type, aer_error_severity_string[info->severity],
>  		   aer_error_layer[layer], aer_agent_string[agent]);
>  
>  	pci_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
> @@ -730,7 +731,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  	if (info->id && info->error_dev_num > 1 && info->id == id)
>  		pci_err(dev, "  Error of this Agent is reported first\n");
>  
> -	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
> +	trace_aer_event(dev_name(&dev->dev), bus_type, (info->status & ~info->mask),
>  			info->severity, info->tlp_header_valid, &info->tlp);
>  }
>  
> @@ -764,6 +765,7 @@ EXPORT_SYMBOL_GPL(cper_severity_to_aer);
>  void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  		   struct aer_capability_regs *aer)
>  {
> +	const char *bus_type = pcie_is_cxl(dev) ? "CXL"  : "PCIe";
>  	int layer, agent, tlp_header_valid = 0;
>  	u32 status, mask;
>  	struct aer_err_info info;
> @@ -798,7 +800,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  	if (tlp_header_valid)
>  		__print_tlp_header(dev, &aer->header_log);
>  
> -	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
> +	trace_aer_event(dev_name(&dev->dev), bus_type, (status & ~mask),
>  			aer_severity, tlp_header_valid, &aer->header_log);
>  }
>  EXPORT_SYMBOL_NS_GPL(pci_print_aer, CXL);
> diff --git a/include/ras/ras_event.h b/include/ras/ras_event.h
> index e5f7ee0864e7..1bf8e7050ba8 100644
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


