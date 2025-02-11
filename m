Return-Path: <linux-pci+bounces-21244-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F589A319A3
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 00:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A01561889737
	for <lists+linux-pci@lfdr.de>; Tue, 11 Feb 2025 23:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15C2263887;
	Tue, 11 Feb 2025 23:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g7wV7ZlO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8AF627291F;
	Tue, 11 Feb 2025 23:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739317372; cv=none; b=Po4+7jgv3k1UPr8/mM+ygQKAicIWXHaIBni5NL6JyOJ8aTQEfhIwFDIV44GM3rUBF0mgJ6unr6eafAwzHx95qvvCSZEMLvS8EbYmpzF781P/E5DAvyxSSn4t/Nf0YwInD6qE2P7psM4xBhyMP9mc9DbC3MTTAEzCTSiP6MomYUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739317372; c=relaxed/simple;
	bh=DVt6U8qCQ8eaR3utJ/YPvrEOtkpBxGkfeePUWY3n3YA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=tOVutVqd2uZDb68qRfKhLKblsWnN2RPglukxLcV2lwpexFGfM9EgjpYiQhNZ6lLVSaGxTNMEQDcthORSBLVTCKzk0X5ijy+6U1W+y1AroVfOWG3dFfEw0D2biCm193DKLRwlceVZ2ZKAtmHel7R3/USB9bZ624h7Gsnwx/Wp4+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g7wV7ZlO; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739317371; x=1770853371;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=DVt6U8qCQ8eaR3utJ/YPvrEOtkpBxGkfeePUWY3n3YA=;
  b=g7wV7ZlO2TWFAsz9fIyBmuOdV1upFxe066zcGgeCjmDwELZOpc+AEiCy
   3lHfCel4Z7OCx6pNUmQzfbgO67Znghaw5UTh+L0ArTdUNrifCEZV502Zf
   +cLNFO4tTSR7pi6rNGTnS6XBmwUo9jp5gxT8oiy11LqsaWSZ1DPfiE9pJ
   /WyVdDmWFE+FfDinLc1Njhv4n+1DPFKqignwDlawKrl5pT0rOmFBs6lYY
   kFjuMFcZpR1GmGg5J/CEy+oMWEdpj+prOPE0QIHblAcswJDmrqSAt3qzZ
   t1BunY3vMxQbPxricOffsaVFG4jeM5li4ukHqb4Hynq4dIErkXyS/8m74
   A==;
X-CSE-ConnectionGUID: zQLf+6lAQ1K+sBADnw0DyA==
X-CSE-MsgGUID: pyIa31uaQJiITlNtfHlAMg==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="40101462"
X-IronPort-AV: E=Sophos;i="6.13,278,1732608000"; 
   d="scan'208";a="40101462"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 15:42:50 -0800
X-CSE-ConnectionGUID: kGmRwJEfTe635lIoqkjiOA==
X-CSE-MsgGUID: KJoDQnpyRiaDb31ZMjzO0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="143568576"
Received: from agladkov-desk.ger.corp.intel.com (HELO [10.125.108.65]) ([10.125.108.65])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 15:42:48 -0800
Message-ID: <e95baa3b-d8f9-4fae-866a-7fa6a58d0169@intel.com>
Date: Tue, 11 Feb 2025 16:42:47 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/17] cxl/pci: Change find_cxl_port() to non-static
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
 <20250211192444.2292833-12-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250211192444.2292833-12-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/25 12:24 PM, Terry Bowman wrote:
> CXL PCIe Port Protocol Error support will be added in the future. This
> requires searching for a CXL PCIe Port device in the CXL topology as
> provided by find_cxl_port(). But, find_cxl_port() is defined static
> and as a result is not callable outside of this source file.
> 
> Update the find_cxl_port() declaration to be non-static.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

I think this could've went with the same patch that's doing the calling of this function. 

> ---
>  drivers/cxl/core/core.h | 2 ++
>  drivers/cxl/core/port.c | 4 ++--
>  2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index a20ea2b7d1a4..796334f2ad6c 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -118,5 +118,7 @@ int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
>  					struct access_coordinate *c);
>  
>  int cxl_gpf_port_setup(struct device *dport_dev, struct cxl_port *port);
> +struct cxl_port *find_cxl_port(struct device *dport_dev,
> +			       struct cxl_dport **dport);
>  
>  #endif /* __CXL_CORE_H__ */
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index f9501a16b390..ae6471e4ebff 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1352,8 +1352,8 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
>  	return NULL;
>  }
>  
> -static struct cxl_port *find_cxl_port(struct device *dport_dev,
> -				      struct cxl_dport **dport)
> +struct cxl_port *find_cxl_port(struct device *dport_dev,
> +			       struct cxl_dport **dport)
>  {
>  	struct cxl_find_port_ctx ctx = {
>  		.dport_dev = dport_dev,


