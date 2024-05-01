Return-Path: <linux-pci+bounces-6934-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 679948B8999
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 14:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BA6B2838A5
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 12:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739B352F96;
	Wed,  1 May 2024 12:14:47 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0937E824A3;
	Wed,  1 May 2024 12:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714565687; cv=none; b=RUs9QA+sp/pM8//un5KoYRT5OM5bnncvTL1K9TpJF5Zz+idpl93mBqc8IQqYGdjlf51lu/iRNAKHCjnuRKk1i8cKBFyt2A9gs4g3y/nlD8MTScz4u5TYlSCieqrxlmkiHmtqBXIU+o/YDFaMSQ9XHeF4ltp58LmhJxJB4jDaubA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714565687; c=relaxed/simple;
	bh=pgGNrxk3F24DbvRrty/kmhL08/FK5+AG6NLNKH8oAOI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KH0pz4kLvqs1TRKg7DUXBtBg7mPQeZD6i0xHshZ4KncEirmrUgWfZnVXG6aEY3cOK6xw6vXxXa76K2hbkatQR7RQD0uls3W8g6C+CQjsuJgCLeXK2FAmdrped8cdfz2sOKAzKQEeEJl0Zsb2Yip9bMUkDmfAhxz1cSYsGMZVMFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTwss2yRrz6GD5R;
	Wed,  1 May 2024 20:12:01 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A0041400D7;
	Wed,  1 May 2024 20:14:41 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 1 May
 2024 13:14:40 +0100
Date: Wed, 1 May 2024 13:14:39 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
CC: <kobayashi.da-06@jp.fujitsu.com>, <linux-cxl@vger.kernel.org>,
	<y-goto@fujitsu.com>, <linux-pci@vger.kernel.org>, <mj@ucw.cz>,
	<dan.j.williams@intel.com>, <dave.jiang@intel.com>
Subject: Re: [PATCH v6 1/2] cxl/core/regs: Add rcd_regs initialization at
 __rcrb_to_component()
Message-ID: <20240501131439.00004ac8@Huawei.com>
In-Reply-To: <20240424050102.26788-2-kobayashi.da-06@fujitsu.com>
References: <20240424050102.26788-1-kobayashi.da-06@fujitsu.com>
	<20240424050102.26788-2-kobayashi.da-06@fujitsu.com>
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
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 24 Apr 2024 14:01:01 +0900
"Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com> wrote:

> Add rcd_regs and its initialization at __rcrb_to_component() to cache
> the cxl1.1 device link status information. Reduce access to the memory
> map area where the RCRB is located by caching the cxl1.1 device
> link status information.
> 
> Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>

Hi,

LGTM but some trivial comments on white space inline.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/core.h |  4 +++-
>  drivers/cxl/core/regs.c | 16 ++++++++++++++++
>  drivers/cxl/cxl.h       |  3 +++
>  3 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 3b64fb1b9ed0..66f62b5bb9f7 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -74,7 +74,9 @@ resource_size_t __rcrb_to_component(struct device *dev,
>  				    struct cxl_rcrb_info *ri,
>  				    enum cxl_rcrb which);
>  u16 cxl_rcrb_to_aer(struct device *dev, resource_size_t rcrb);
> -
I'd leave the blank line. No obvious reason to remove it.  If anything I'd
put one after these defines.
> +#define PCI_RCRB_CAP_LIST_MASK	GENMASK(7, 0)
> +#define PCI_RCRB_CAP_HDR_ID_MASK	GENMASK(7, 0)
> +#define PCI_RCRB_CAP_HDR_NEXT_MASK	GENMASK(15, 8)
blank line here perhaps.
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
> +	offset = FIELD_GET(PCI_RCRB_CAP_LIST_MASK, readw(addr + PCI_CAPABILITY_LIST));
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


