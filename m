Return-Path: <linux-pci+bounces-8251-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1258FB8D5
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 18:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2ED01F278FA
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 16:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B6A1487F4;
	Tue,  4 Jun 2024 16:25:42 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A154C1487DC;
	Tue,  4 Jun 2024 16:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717518342; cv=none; b=WRuE/VfK+vUqzAa5QTKSjEiPqTYg/BmDlD3l/s7tKUuowkQs/su9X2oEqkGycHWARXP8VMJjz1xhb/0nTTrPNQ5/Uk2cT2/hTJbh+f80fk1EBINoUqBFFHDGtxbQmStzUOoKasON6T/XUvEut+1gZwnFUh1g2D29LynJPviIUJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717518342; c=relaxed/simple;
	bh=FAr7oMFOkWQbWaHObwOrQT09tqfYT7TbKaA8cZ5bUkM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UFQpwcfTZcpYw176eTBIDTSs4L2Hnhd+2YVlG3tfe8oP3U+Bz7cmz1oljSqO/TPERANRF7Pmi/w1BjtDrvWQyof83uVo0PZ0JFw2c3ZUJdZnFtmP3LU6fW/kGPdKJ6QyFQarZwb2OlPiTui++XPFFrsotEZMoftGxrtIgMfwt/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VtwnW2rD2z6K6Dx;
	Wed,  5 Jun 2024 00:21:03 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 2E9A31409EA;
	Wed,  5 Jun 2024 00:25:37 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Jun
 2024 17:25:36 +0100
Date: Tue, 4 Jun 2024 17:25:35 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
CC: <kobayashi.da-06@jp.fujitsu.com>, <linux-cxl@vger.kernel.org>,
	<y-goto@fujitsu.com>, <linux-pci@vger.kernel.org>, <mj@ucw.cz>,
	<dan.j.williams@intel.com>
Subject: Re: [PATCH v7 1/2] cxl/core/regs: Add rcd_regs initialization at
 __rcrb_to_component()
Message-ID: <20240604172535.00000230@Huawei.com>
In-Reply-To: <20240510073710.98953-2-kobayashi.da-06@fujitsu.com>
References: <20240510073710.98953-1-kobayashi.da-06@fujitsu.com>
	<20240510073710.98953-2-kobayashi.da-06@fujitsu.com>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 10 May 2024 16:37:09 +0900
"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com> wrote:

> Add rcd_regs and its initialization at __rcrb_to_component() to cache

This rcd_regs doesn't immediately align with what is in the code. I'd just
call it out as

Add caching of Link Status, Link Control and Link Capability registers for
a Restricted CXL Device to struct cxl_rcrb_info.

> the cxl1.1 device link status information. Reduce access to the memory
> map area where the RCRB is located by caching the cxl1.1 device
> link status information.

Why do we care about accessing that memory mapped area?
Avoiding the walk to find the offset might be an alternative as then
we could directly read these registers when needed.
So handle these similarly to aer_cap.

That will allow for them changing at runtime without carefully needing
to update the cached values.

> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

New day, new comments :( 

> Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
> ---
>  drivers/cxl/core/core.h |  4 ++++
>  drivers/cxl/core/regs.c | 16 ++++++++++++++++
>  drivers/cxl/cxl.h       |  3 +++
>  3 files changed, 23 insertions(+)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 3b64fb1b9ed0..42e3483b4a14 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -75,6 +75,10 @@ resource_size_t __rcrb_to_component(struct device *dev,
>  				    enum cxl_rcrb which);
>  u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
>  
> +#define PCI_RCRB_CAP_LIST_ID_MASK	GENMASK(7, 0)
> +#define PCI_RCRB_CAP_HDR_ID_MASK	GENMASK(7, 0)
> +#define PCI_RCRB_CAP_HDR_NEXT_MASK	GENMASK(15, 8)
> +
>  extern struct rw_semaphore cxl_dpa_rwsem;
>  extern struct rw_semaphore cxl_region_rwsem;
>  
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 372786f80955..1ad58c464488 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -514,6 +514,8 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
>  	u32 bar0, bar1;
>  	u16 cmd;
>  	u32 id;
> +	u16 offset;
> +	u32 cap_hdr;
>  
>  	if (which == CXL_RCRB_UPSTREAM)
>  		rcrb += SZ_4K;
> @@ -537,6 +539,20 @@ resource_size_t __rcrb_to_component(struct device *dev, struct cxl_rcrb_info *ri
>  	cmd = readw(addr + PCI_COMMAND);
>  	bar0 = readl(addr + PCI_BASE_ADDRESS_0);
>  	bar1 = readl(addr + PCI_BASE_ADDRESS_1);
> +	offset = FIELD_GET(PCI_RCRB_CAP_LIST_ID_MASK, readw(addr + PCI_CAPABILITY_LIST));
> +	cap_hdr = readl(addr + offset);
> +	while ((FIELD_GET(PCI_RCRB_CAP_HDR_ID_MASK, cap_hdr)) != PCI_CAP_ID_EXP) {
> +		offset = FIELD_GET(PCI_RCRB_CAP_HDR_NEXT_MASK, cap_hdr);
> +		if (offset == 0 || offset > SZ_4K)
> +			break;
> +		cap_hdr = readl(addr + offset);
> +	}
> +	if (offset) {
> +		ri->rcd_lnkcap = readl(addr + offset + PCI_EXP_LNKCAP);
> +		ri->rcd_lnkctrl = readl(addr + offset + PCI_EXP_LNKCTL);
> +		ri->rcd_lnkstatus = readl(addr + offset + PCI_EXP_LNKSTA);
> +	}
> +
>  	iounmap(addr);
>  	release_mem_region(rcrb, SZ_4K);
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 003feebab79b..808818ccc255 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -646,6 +646,9 @@ cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
>  
>  struct cxl_rcrb_info {
>  	resource_size_t base;
> +	u16 rcd_lnkstatus;
> +	u16 rcd_lnkctrl;
> +	u32 rcd_lnkcap;
>  	u16 aer_cap;
>  };
>  


