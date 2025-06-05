Return-Path: <linux-pci+bounces-29046-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F68ACF48B
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 18:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0F137AADA9
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 16:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6681202961;
	Thu,  5 Jun 2025 16:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MtWVD9Cn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5238B26AD0;
	Thu,  5 Jun 2025 16:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749141731; cv=none; b=X+Da24UQhDLhLFThPxO9hI4cH5F0v57VxpUpw92oFVtTsilWGGhynz9YOnrqidpLo/DfEqYRL5A2p18QC/uFtTzem6md59niGPPdCII4SsgvRhm9+ezXqdGrYmEZjXYfVjXW0pXDDQmP19170ebSnG3Do5YGLvaJfmCwABHaytk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749141731; c=relaxed/simple;
	bh=CwsZCKARFJ5eytLv+/F97x1fVOMgmf4GksGAx75OpcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PvqqMfjj74EGDIhwxgYqpPxH76R6nDH3OTqPYykq5S7gG05V6SeLhkg7K/nTHsjZX9ZU1LIW24NEknXHsyjKZBwmrn16fSqE6ZA5YxYUTJhFq7ZyuWvsHE5dViMncfwaGX2v9ZPsDsBMRrHlRj2HJbjCHeceVy2oQug3AbpRUpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MtWVD9Cn; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749141729; x=1780677729;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=CwsZCKARFJ5eytLv+/F97x1fVOMgmf4GksGAx75OpcU=;
  b=MtWVD9CndrwGHBrllgxKV1l/9C8xNknwDpvvf8tbf795MdfLhY9l8bTI
   WJIQ00A8+ZpaI/dz4/jljHnVJo/YW31Cx65rUZQEoquAVAiamLV44Qpja
   c9LD2/u9Jps+/efoO54F+qEGOTKlrQYGAMgDiIBCWIvrhJxjhthmRFt4k
   9OqJJfa0Im247VyraF+QEVQKJqj3waEd1U0d9yQI6d++UGGUaQtNYLDIF
   kix7nZDaq5SYqLEJSQOBuhFWkiNCmFcOdMBXHL9gnEQNkxBjK/9M+OOJm
   L45af+ukB/kAjC6Y9chObfIWAFti2FGds/CocqbG3UuHfEcqua8qGhMYP
   Q==;
X-CSE-ConnectionGUID: I6xAyZbNSde2TpwCtbuLJQ==
X-CSE-MsgGUID: dHjFrh7rQTma9xVCAyLj6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="55079052"
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="55079052"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 09:42:08 -0700
X-CSE-ConnectionGUID: kuetqStVQjauHRUcCyjK5w==
X-CSE-MsgGUID: mL5XmZbISxuScbEjAP8Axw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,212,1744095600"; 
   d="scan'208";a="150829712"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 09:42:09 -0700
Received: from [10.124.222.23] (unknown [10.124.222.23])
	by linux.intel.com (Postfix) with ESMTP id 15B0A20B5736;
	Thu,  5 Jun 2025 09:42:07 -0700 (PDT)
Message-ID: <3547f24a-ed5b-4f28-b881-e5b4984a4949@linux.intel.com>
Date: Thu, 5 Jun 2025 09:42:06 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 08/16] cxl/pci: Update RAS handler interfaces to also
 support CXL Ports
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
 <20250603172239.159260-9-terry.bowman@amd.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250603172239.159260-9-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/3/25 10:22 AM, Terry Bowman wrote:
> CXL PCIe Port Protocol Error handling support will be added to the
> CXL drivers in the future. In preparation, rename the existing
> interfaces to support handling all CXL PCIe Port Protocol Errors.
>
> The driver's RAS support functions currently rely on a 'struct
> cxl_dev_state' type parameter, which is not available for CXL Port
> devices. However, since the same CXL RAS capability structure is
> needed across most CXL components and devices, a common handling
> approach should be adopted.
>
> To accommodate this, update the __cxl_handle_cor_ras() and
> __cxl_handle_ras() functions to use a `struct device` instead of
> `struct cxl_dev_state`.
>
> No functional changes are introduced.
>
> [1] CXL 3.1 Spec, 8.2.4 CXL.cache and CXL.mem Registers
>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/cxl/core/pci.c | 17 ++++++++---------
>   1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 317cd0a91ffe..78735da7e63d 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -664,7 +664,7 @@ void read_cdat_data(struct cxl_port *port)
>   }
>   EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
>   
> -static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
> +static void __cxl_handle_cor_ras(struct device *dev,
>   				 void __iomem *ras_base)
>   {
>   	void __iomem *addr;
> @@ -677,13 +677,13 @@ static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
>   	status = readl(addr);
>   	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>   		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> -		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
> +		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
>   	}
>   }
>   
>   static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
>   {
> -	return __cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
> +	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
>   }
>   
>   /* CXL spec rev3.0 8.2.4.16.1 */
> @@ -707,8 +707,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>    * Log the state of the RAS status registers and prepare them to log the
>    * next error status. Return 1 if reset needed.
>    */
> -static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
> -				  void __iomem *ras_base)
> +static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>   {
>   	u32 hl[CXL_HEADERLOG_SIZE_U32];
>   	void __iomem *addr;
> @@ -735,7 +734,7 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
>   	}
>   
>   	header_log_copy(ras_base, hl);
> -	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
> +	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
>   	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>   
>   	return true;
> @@ -743,7 +742,7 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
>   
>   static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
>   {
> -	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
> +	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
>   }
>   
>   #ifdef CONFIG_PCIEAER_CXL
> @@ -751,13 +750,13 @@ static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
>   static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
>   					  struct cxl_dport *dport)
>   {
> -	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
> +	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
>   }
>   
>   static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
>   				       struct cxl_dport *dport)
>   {
> -	return __cxl_handle_ras(cxlds, dport->regs.ras);
> +	return __cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
>   }
>   
>   /*

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


