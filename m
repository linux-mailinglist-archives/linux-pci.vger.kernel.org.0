Return-Path: <linux-pci+bounces-19728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2C7FA105E3
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 12:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBA4E7A23DB
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 11:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E6D229629;
	Tue, 14 Jan 2025 11:49:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9168234D1C;
	Tue, 14 Jan 2025 11:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736855374; cv=none; b=UaBDUo81xRth12KA0DBAWAL5N7mgZeNQ2xUmA6fjDly5+ohn9KMMXvs3pM1HK/zS49S/X5Sw7+QSRx4r2rKDPnvq318A+umWKU+83UwQwk8AjP7B33b47zbdrDvggqM6TwP4idHvalSAYL0o1IYigNMKXb0/vpHLAEf9D9NCFHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736855374; c=relaxed/simple;
	bh=OV6Yx25XvPvYV+BBmLCr5k/iNkK3kHQo4rNSwW7uB04=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DDMO7fI60U8Yn20HJw4YhtunOKcyJtAI8zvKYkGc2x+n5NQaeNqM9eekTJtg1wogOdptVemqB801P8wihy4xFPZiG3kPQ1ggKFHylFQdauRueMxss76JbSza6toelAMgQReJg92m1mHBGXZQdPzYgXK0OGDaj8lf0W+jsk8erLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YXS6n72Dkz6M4N5;
	Tue, 14 Jan 2025 19:47:45 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 89F2D140A86;
	Tue, 14 Jan 2025 19:49:29 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 14 Jan
 2025 12:49:28 +0100
Date: Tue, 14 Jan 2025 11:49:27 +0000
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
	<PradeepVineshReddy.Kodamati@amd.com>, <alucerop@amd.com>
Subject: Re: [PATCH v5 14/16] cxl/pci: Add trace logging for CXL PCIe Port
 RAS errors
Message-ID: <20250114114927.000022ef@huawei.com>
In-Reply-To: <20250107143852.3692571-15-terry.bowman@amd.com>
References: <20250107143852.3692571-1-terry.bowman@amd.com>
	<20250107143852.3692571-15-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 7 Jan 2025 08:38:50 -0600
Terry Bowman <terry.bowman@amd.com> wrote:

> The CXL drivers use kernel trace functions for logging endpoint and
> Restricted CXL host (RCH) Downstream Port RAS errors. Similar functionality
> is required for CXL Root Ports, CXL Downstream Switch Ports, and CXL
> Upstream Switch Ports.
> 
> Introduce trace logging functions for both RAS correctable and
> uncorrectable errors specific to CXL PCIe Ports. Additionally, update
> the CXL Port Protocol Error handlers to invoke these new trace functions.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Alejandro Lucero <alucerop@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
An example print in commit message would help understand what the tracepoints
look like.

Few more things inline following on from earlier comments.

Jonathan
> ---
>  drivers/cxl/core/pci.c   | 17 +++++++++++----
>  drivers/cxl/core/trace.h | 47 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 60 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 411834f7efe0..3e87fe54a1a2 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -663,10 +663,15 @@ static void __cxl_handle_cor_ras(struct device *dev,
>  
>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>  	status = readl(addr);
> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
> +		return;
> +
> +	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> +
> +	if (is_cxl_memdev(dev))
As below. Drag to earlier patch.
>  		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
> -	}
> +	else

and perhaps check it's a port mostly for documentation purposes.


> +		trace_cxl_port_aer_correctable_error(dev, status);
>  }
>  
>  static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
> @@ -724,7 +729,11 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>  	}
>  
>  	header_log_copy(ras_base, hl);
> -	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
> +	if (is_cxl_memdev(dev))

As mentioned above, drag this if to the earlier patch.

> +		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
> +	else

For documentation purposes mostly I'd be tempted to have an is_cxl_port() check
before calling the following.

> +		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
> +
>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>  
>  	return true;
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 8389a94adb1a..681e415ac8f5 100644
> --- a/drivers/cxl/core/trace.h
> +++ b/drivers/cxl/core/trace.h
> @@ -48,6 +48,34 @@
>  	{ CXL_RAS_UC_IDE_RX_ERR, "IDE Rx Error" }			  \
>  )
>  
> +TRACE_EVENT(cxl_port_aer_uncorrectable_error,
> +	TP_PROTO(struct device *dev, u32 status, u32 fe, u32 *hl),
> +	TP_ARGS(dev, status, fe, hl),
> +	TP_STRUCT__entry(
> +		__string(devname, dev_name(dev))
> +		__string(host, dev_name(dev->parent))
What is host in this case? Perhaps a comment.
> +		__field(u32, status)
> +		__field(u32, first_error)
> +		__array(u32, header_log, CXL_HEADERLOG_SIZE_U32)
> +	),
> +	TP_fast_assign(
> +		__assign_str(devname);
> +		__assign_str(host);
> +		__entry->status = status;
> +		__entry->first_error = fe;
> +		/*
> +		 * Embed the 512B headerlog data for user app retrieval and
> +		 * parsing, but no need to print this in the trace buffer.
> +		 */
> +		memcpy(__entry->header_log, hl, CXL_HEADERLOG_SIZE);
> +	),
> +	TP_printk("device=%s host=%s status: '%s' first_error: '%s'",
> +		  __get_str(devname), __get_str(host),
> +		  show_uc_errs(__entry->status),
> +		  show_uc_errs(__entry->first_error)
> +	)
> +);
> +
>  TRACE_EVENT(cxl_aer_uncorrectable_error,
>  	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status, u32 fe, u32 *hl),
>  	TP_ARGS(cxlmd, status, fe, hl),
> @@ -96,6 +124,25 @@ TRACE_EVENT(cxl_aer_uncorrectable_error,
>  	{ CXL_RAS_CE_PHYS_LAYER_ERR, "Received Error From Physical Layer" }	\
>  )
>  
> +TRACE_EVENT(cxl_port_aer_correctable_error,
> +	TP_PROTO(struct device *dev, u32 status),
> +	TP_ARGS(dev, status),
> +	TP_STRUCT__entry(
> +		__string(devname, dev_name(dev))
> +		__string(host, dev_name(dev->parent))
> +		__field(u32, status)
> +	),
> +	TP_fast_assign(
> +		__assign_str(devname);
> +		__assign_str(host);
> +		__entry->status = status;
> +	),
> +	TP_printk("device=%s host=%s status='%s'",
> +		  __get_str(devname), __get_str(host),
> +		  show_ce_errs(__entry->status)
> +	)
> +);
> +
>  TRACE_EVENT(cxl_aer_correctable_error,
>  	TP_PROTO(const struct cxl_memdev *cxlmd, u32 status),
>  	TP_ARGS(cxlmd, status),


