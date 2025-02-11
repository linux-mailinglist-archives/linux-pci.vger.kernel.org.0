Return-Path: <linux-pci+bounces-21241-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A75A3197F
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 00:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D8241887CFB
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 23:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED338268FD2;
	Tue, 11 Feb 2025 23:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gwpm/5VX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E04272908;
	Tue, 11 Feb 2025 23:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739316367; cv=none; b=JeSslUQveBBXDTebW5zy+8snUtdw4edRvCDPgS1GD+2nbRkggWxwHyqa9r6wmHap8QsWB9sEWW2dB6ONUAI3QIn1f2oZS8USo1PbJXthgMaN4BrCJ83Xppc45zJfoOsftzxUubIkB4ULp5ZBALXXcDB/bcq9/rIVGze5KqyqRFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739316367; c=relaxed/simple;
	bh=gIfOo8UkAIrZ7glbw0uEh9hudfODtbsm/B1rUlWFczE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gj/Sp5RU3zs7xV2sTdXQGS+tqI+PKihMZggdXFSdk+l+7U03pQsWBD3XVJ46NklZ3YL93P9GF5jafOcL3oKvEjr2oeZPQccWVcqwgRoN0gzTntZZVD6113fhblvFnwaiBshNZOcP/fj/jVHiHuMfPeE8ZGMmGqmyVez1ilqtDSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gwpm/5VX; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739316363; x=1770852363;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=gIfOo8UkAIrZ7glbw0uEh9hudfODtbsm/B1rUlWFczE=;
  b=gwpm/5VXBG96XchUwSB1ruDxbZX/C2DnHv89Nsfaftak2eARgVYMsP34
   FrxZKxBbWm7npkrph3jfM2T/4+/AfqUqUk1FZaJHkyE7jWtbS2ZgSRKnh
   Zx/qj2VK/Wd2b/T0gEkZBPF6KR4qFI+uyx73zUcnZZQVaZeTji+GPm7pR
   4jL4fKwUM3IZ321jHoEK4Rkt4AbdNlCVTh4HUhaU4apGTx+Nz/PZ/yaLa
   5qPtmHmzxfk7VMV1H7CF3RTxG4PseDZXnP9YJnop0oa9hQaTytgnhlrSK
   XJQvzujECtDyuajIH3vrQVGk/NuQKaTU3KytxSTNMzUn9gA65b4NV0U2p
   w==;
X-CSE-ConnectionGUID: ZvHBluueS6mdLXMj8BhJag==
X-CSE-MsgGUID: yJz2KuOsQzSg5Q6PtaDQcA==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="43883312"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="43883312"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 15:26:02 -0800
X-CSE-ConnectionGUID: Ssa2X1/HSg6j4yq6J82TTQ==
X-CSE-MsgGUID: ksFdjuQmTOGZ6V+W+J3f+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="113155783"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.108.65]) ([10.125.108.65])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 15:26:02 -0800
Message-ID: <665afddb-734d-46cb-9af1-13e97658dc2d@intel.com>
Date: Tue, 11 Feb 2025 16:26:00 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 09/17] cxl/pci: Update RAS handler interfaces to also
 support CXL PCIe Ports
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
 <20250211192444.2292833-10-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250211192444.2292833-10-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/25 12:24 PM, Terry Bowman wrote:
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/pci.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 25513b9a8aff..69bb030aa8e1 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -652,7 +652,7 @@ void read_cdat_data(struct cxl_port *port)
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, "CXL");
>  
> -static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
> +static void __cxl_handle_cor_ras(struct device *dev,
>  				 void __iomem *ras_base)
>  {
>  	void __iomem *addr;
> @@ -665,13 +665,13 @@ static void __cxl_handle_cor_ras(struct cxl_dev_state *cxlds,
>  	status = readl(addr);
>  	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
>  		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> -		trace_cxl_aer_correctable_error(cxlds->cxlmd, status);
> +		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
>  	}
>  }
>  
>  static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
>  {
> -	return __cxl_handle_cor_ras(cxlds, cxlds->regs.ras);
> +	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
>  }
>  
>  /* CXL spec rev3.0 8.2.4.16.1 */
> @@ -695,8 +695,7 @@ static void header_log_copy(void __iomem *ras_base, u32 *log)
>   * Log the state of the RAS status registers and prepare them to log the
>   * next error status. Return 1 if reset needed.
>   */
> -static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
> -				  void __iomem *ras_base)
> +static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>  {
>  	u32 hl[CXL_HEADERLOG_SIZE_U32];
>  	void __iomem *addr;
> @@ -723,7 +722,7 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
>  	}
>  
>  	header_log_copy(ras_base, hl);
> -	trace_cxl_aer_uncorrectable_error(cxlds->cxlmd, status, fe, hl);
> +	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>  
>  	return true;
> @@ -731,7 +730,7 @@ static bool __cxl_handle_ras(struct cxl_dev_state *cxlds,
>  
>  static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
>  {
> -	return __cxl_handle_ras(cxlds, cxlds->regs.ras);
> +	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->regs.ras);
>  }
>  
>  #ifdef CONFIG_PCIEAER_CXL
> @@ -825,13 +824,13 @@ EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>  static void cxl_handle_rdport_cor_ras(struct cxl_dev_state *cxlds,
>  					  struct cxl_dport *dport)
>  {
> -	return __cxl_handle_cor_ras(cxlds, dport->regs.ras);
> +	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, dport->regs.ras);
>  }
>  
>  static bool cxl_handle_rdport_ras(struct cxl_dev_state *cxlds,
>  				       struct cxl_dport *dport)
>  {
> -	return __cxl_handle_ras(cxlds, dport->regs.ras);
> +	return __cxl_handle_ras(&cxlds->cxlmd->dev, dport->regs.ras);
>  }
>  
>  /*


