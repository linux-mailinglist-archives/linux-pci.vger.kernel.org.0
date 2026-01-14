Return-Path: <linux-pci+bounces-44868-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D0F9CD2151D
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 22:24:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5688230090FF
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 21:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 352C736165B;
	Wed, 14 Jan 2026 21:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MOWjYQnN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086D235EDC1;
	Wed, 14 Jan 2026 21:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768425878; cv=none; b=jSzoXRD5pwVX1YhUMkVWgwq8z//k2ah1JMUnT3/olvWXfSZn4SZy8pfKlEkoqxGHHqXGqVvsDbhT2taInbvWDVW6U2cyii2u88DLUwZgPpC3b3m0p/PQgJExcAdNIf9XuRHIvRkNXjNgriIJzRu9XHa5z/4d+TMijgXcFDuwMvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768425878; c=relaxed/simple;
	bh=88Q3bhRxNp0LxEtfN/OiFOfJIumySZncOvtZi/HWVAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jf0Si0cAr/JqDCwhjsEuOBLLqy0PwPEkRApy2y0T5rga3zc037R2Wlvp8cuZc683BzUMUSOle6PuNj5+Hb2yt/QXWv24TG7pQveQHRT+2nrKrzZje8iNlNyCb9re2IRHtmKDUOiFC4G5R+cQ0tSGtxuWhgfEo/9Duhu76xuuWog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MOWjYQnN; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768425876; x=1799961876;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=88Q3bhRxNp0LxEtfN/OiFOfJIumySZncOvtZi/HWVAg=;
  b=MOWjYQnNv6h7sNlzKaC4cKyFwfAeTivT1Z67ayFS/XfqgUqKq2LMXhg1
   CISK4wilbkRBYuibkNC4Kr3Fzg0mYRLXNqVGnbRZYr8WTa5BokkvHMnH9
   yKvZA1UHUTsHchjTqqPAZ9F78h5JhzzLiVufxJPswlQlD4r1bE+aSaLqv
   xEuukvNhO68C88QokrWmANy2AmfrlK68UTK6n03sd2FNjmY8nZi2IS8xK
   YbR5tAFksBCSq6mBZ1SihauZvJ5WAHWCyQajxBrnftcgC2R8qJkSxw1JE
   RJfyO8feaVc9F1scCXjMiV9bhMjba+faJ9PH5W43AORd9kXHIkMydo99j
   g==;
X-CSE-ConnectionGUID: FyS+EEgERVCeBYMgMLSlkw==
X-CSE-MsgGUID: /RWHOlHuRPW0+3Ze2GdK4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="80454457"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="80454457"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 13:24:35 -0800
X-CSE-ConnectionGUID: 6NQnr9MUQdeVzfU6nfF0gA==
X-CSE-MsgGUID: 2fC8vUc2SUm8eTAzG76/nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="204001422"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.5]) ([10.125.111.5])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 13:24:34 -0800
Message-ID: <8b5ec06d-4200-4e45-a397-03938d5a0558@intel.com>
Date: Wed, 14 Jan 2026 14:24:33 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 18/34] cxl/port: Remove "enumerate dports" helpers
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
 <20260114182055.46029-19-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260114182055.46029-19-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/26 11:20 AM, Terry Bowman wrote:
> From: Dan Williams <dan.j.williams@intel.com>
> 
> Now that cxl_switch_port_probe() no longer walks potential dports, because
> they are enumerated dynamically on descendant endpoint arrival, remove the
> dead code.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Reviewed-by: Terry Bowman <terry.bowman@amd.com>

Missing your sign off tag


> 
> ---
> 
> Changes in v13 -> v14:
> - New patch
> ---
>  drivers/cxl/core/pci.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index b838c59d7a3c..0305a421504e 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -71,6 +71,14 @@ struct cxl_dport *__devm_cxl_add_dport_by_dev(struct cxl_port *port,
>  }
>  EXPORT_SYMBOL_NS_GPL(__devm_cxl_add_dport_by_dev, "CXL");
>  
> +struct cxl_walk_context {
> +	struct pci_bus *bus;
> +	struct cxl_port *port;
> +	int type;
> +	int error;
> +	int count;
> +};
> +
>  static int cxl_dvsec_mem_range_valid(struct cxl_dev_state *cxlds, int id)
>  {
>  	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
> @@ -820,14 +828,6 @@ int cxl_gpf_port_setup(struct cxl_dport *dport)
>  	return 0;
>  }
>  
> -struct cxl_walk_context {
> -	struct pci_bus *bus;
> -	struct cxl_port *port;
> -	int type;
> -	int error;
> -	int count;
> -};
> -
>  static int count_dports(struct pci_dev *pdev, void *data)
>  {
>  	struct cxl_walk_context *ctx = data;


