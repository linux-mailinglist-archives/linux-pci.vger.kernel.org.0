Return-Path: <linux-pci+bounces-26571-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BE6A995A0
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 18:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 954223B0571
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 16:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4B5280CDC;
	Wed, 23 Apr 2025 16:41:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682B027F4D9;
	Wed, 23 Apr 2025 16:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426473; cv=none; b=QFF3gm+3DqcoQ1BoEqMgJ5b0j557VoAwM+gF2OzPH9xIdtWQEMgefo4vaUkFjvTzdv6PddOb8/nL448gC72VlbpAMUKh7VFSaz0FVp9L61ceF7BSAOcp54FeIRjL/hr8bA7PLtKfquPcXu6E0UGYBq4LxOClynwwlfpoATe2Ft8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426473; c=relaxed/simple;
	bh=t4Tz1BCNxW6564+a9wXl3Kpz3CXf6hGRqDEGOOYs6g8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OPUtZqJjV2u+BkM70SuVKlE5ULbPOpgZJ4dHqHVGFn39DgK0agctd2QR7vLLwvJ12XtiGNs/pQDxeGeNEOUDmWOmJrdj0ldq+tXC9Gfaiv+e9tw8V8C8QiAqW3IsflSnPHDwwYrTAYV5AiUz2GnN5BVrff0hgFVNM6A4EQE53cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZjPrp2tbDz6M4lr;
	Thu, 24 Apr 2025 00:36:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id DF920140146;
	Thu, 24 Apr 2025 00:41:07 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 23 Apr
 2025 18:41:06 +0200
Date: Wed, 23 Apr 2025 17:41:05 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v8 10/16] cxl/pci: Add log message if RAS registers are
 not mapped
Message-ID: <20250423174105.0000597b@huawei.com>
In-Reply-To: <20250327014717.2988633-11-terry.bowman@amd.com>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
	<20250327014717.2988633-11-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 26 Mar 2025 20:47:11 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> The CXL RAS handlers do not currently log if the RAS registers are
> unmapped. This is needed in order to help debug CXL error handling. Update
> the CXL driver to log a warning message if the RAS register block is
> unmapped during RAS error handling.
> 
> Also, refactor the __cxl_handle_cor_ras() functions check for status.
> Change it to be consistent with the same status check in
> __cxl_handle_cor_ras().

Not keen on an 'also' bit in here.  Seems entirely separable
into its own patch.

Two trivial one thing patches seems better than one slightly larger one.
Actual changes seem fine to me so feel free to add
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
to resulting pair of patches.

> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/pci.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 1cf1ab4d9160..4770810b2138 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -656,15 +656,18 @@ static void __cxl_handle_cor_ras(struct device *dev,
>  	void __iomem *addr;
>  	u32 status;
>  
> -	if (!ras_base)
> +	if (!ras_base) {
> +		dev_warn_once(dev, "CXL RAS register block is not mapped");
>  		return;
> +	}
>  
>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>  	status = readl(addr);
> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> -		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
> -	}
> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
> +		return;
> +	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> +
> +	trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
>  }
>  
>  static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
> @@ -700,8 +703,10 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>  	u32 status;
>  	u32 fe;
>  
> -	if (!ras_base)
> +	if (!ras_base) {
> +		dev_warn_once(dev, "CXL RAS register block is not mapped");
>  		return false;
> +	}
>  
>  	addr = ras_base + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
>  	status = readl(addr);


