Return-Path: <linux-pci+bounces-15642-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B474D9B68DD
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 17:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 738DD284DA1
	for <lists+linux-pci@lfdr.de>; Wed, 30 Oct 2024 16:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C7601E2838;
	Wed, 30 Oct 2024 16:07:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C3836126;
	Wed, 30 Oct 2024 16:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730304476; cv=none; b=kJTP6OuiVtg+am/T/x4DxcqfiZA26JD7YhAzD0DLYuFyE/L+QUhsFcu6SdTHLJsacjfRgmkL/rezvd/i9/GEGwhVFWblS55PuSGaEcNuNMuPiYN1/JCSJf/xMq/6RDD17wOhgRZIod+iKpW6hjpVq5tNrBbZPAgkCMhNjdzyr9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730304476; c=relaxed/simple;
	bh=sYrCCtSJMM/vNIM5bemKiWX1x209eI6n/2Wtl3Rrhiw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ovPc7mrZ2pu7Lx5VQocKKB5dPnCxEcaWJfpVh+avdkbl7uj/iZXI3KagnV7nChorCKFIy/fDx/0mbD9ns5Oqqbtei7LTC4n5Wo7ot0N2iaxPZH8e+Jgm6mlF60bFoXaz5FTvA0ABxyRyX+gP7SE2uvRfqcrLNLuRNBzGafrjeps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XdsQk6fm8z6K6kk;
	Thu, 31 Oct 2024 00:05:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 65497140B38;
	Thu, 31 Oct 2024 00:07:28 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 30 Oct
 2024 17:07:27 +0100
Date: Wed, 30 Oct 2024 16:07:26 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <ming4.li@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<shiju.jose@huawei.com>, <M.Chehab@huawei.com>
Subject: Re: [PATCH v2 13/14] cxl/pci: Add trace logging for CXL PCIe port
 RAS errors
Message-ID: <20241030160726.0000533e@Huawei.com>
In-Reply-To: <20241025210305.27499-14-terry.bowman@amd.com>
References: <20241025210305.27499-1-terry.bowman@amd.com>
	<20241025210305.27499-14-terry.bowman@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
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

On Fri, 25 Oct 2024 16:03:04 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> The CXL drivers use kernel trace functions for logging endpoint and
> RCH downstream port RAS errors. Similar functionality is
> required for CXL root ports, CXL downstream switch ports, and CXL
> upstream switch ports.
> 
> Introduce trace logging functions for both RAS correctable and
> uncorrectable errors specific to CXL PCIe ports. Additionally, update
> the PCIe port error handlers to invoke these new trace functions.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
+CC Mauro and Shiju to give the tracepoint a sanity check and for
awareness that we have something new to feed rasdaemon :)

Jonathan

> ---
>  drivers/cxl/core/pci.c   | 16 ++++++++++----
>  drivers/cxl/core/trace.h | 47 ++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 59 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index adb184d346ae..eeb4a64ba5b5 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -661,10 +661,14 @@ static void __cxl_handle_cor_ras(struct device *dev,
>  
>  	addr = ras_base + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
>  	status = readl(addr);
> -	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
> -		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> +	if (!(status & CXL_RAS_CORRECTABLE_STATUS_MASK))
> +		return;
> +	writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
> +
> +	if (is_cxl_memdev(dev))
>  		trace_cxl_aer_correctable_error(to_cxl_memdev(dev), status);
> -	}
> +	else if (dev_is_pci(dev))
How would you get here otherwise? Is it useful to know it is a pci device
here?
> +		trace_cxl_port_aer_correctable_error(dev, status);
>  }
>  
>  static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
> @@ -720,7 +724,11 @@ static bool __cxl_handle_ras(struct device *dev, void __iomem *ras_base)
>  	}
>  
>  	header_log_copy(ras_base, hl);
> -	trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
> +	if (is_cxl_memdev(dev))
> +		trace_cxl_aer_uncorrectable_error(to_cxl_memdev(dev), status, fe, hl);
> +	else if (dev_is_pci(dev))
as above.

> +		trace_cxl_port_aer_uncorrectable_error(dev, status, fe, hl);
> +
>  	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
>  
>  	return true;
> diff --git a/drivers/cxl/core/trace.h b/drivers/cxl/core/trace.h
> index 8672b42ee4d1..1c4368a7b50b 100644
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
I'm not sure any printing as such goes on in the trace buffer. It is from
the data in the trace buffer I think.

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


