Return-Path: <linux-pci+bounces-6190-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1CD8A351D
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 19:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63C9228825F
	for <lists+linux-pci@lfdr.de>; Fri, 12 Apr 2024 17:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1522014D71E;
	Fri, 12 Apr 2024 17:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YTQiGXDK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39AEE14E2F0;
	Fri, 12 Apr 2024 17:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712944051; cv=none; b=ZvW8fwJh14Rifshp5KEuuyur8fejwSCSO2o78bliKgHP4ZFol3jcRGivNF+qkEE3DVfdeXWZUJfT3D4Bw6Na6TPiz61IJwQP3wUMynO0AqXwqtt9dbl3kQZ3J3gsRtGGhoGvYUOERcE6WuHjHIj7J8XdulEmgjMQCCTmlzBC2kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712944051; c=relaxed/simple;
	bh=CXe8/eHpIbYJZcLSTxZ+IHKOOfY1c5U2pDynUzQNUjk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BgH6p9q0QValkQpHKqGf0nUsdl6X+WP0WWST7Oc9ZiJ293B9UvGsIt2mG5npbD6pItMC0R5QnjJpgbDEjao76RbGZEyI8YAyhwzyYfAa7OtkobxUvv18txdANFhbu9znDGfO7ZmwKYeMlDirhKz7Uh1cUSyARrS+fFJk9GX6o3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YTQiGXDK; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712944049; x=1744480049;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CXe8/eHpIbYJZcLSTxZ+IHKOOfY1c5U2pDynUzQNUjk=;
  b=YTQiGXDKsuAuRONVW7Zzuiz0r9KdcrLEvtRECzAbNh/xpxEoTk3q0bSj
   vnu8Lf4d4bL4aWPpYtoCU262C9eZAbaTqSdRyWFJ8QsD4ZWARW+dpMf1B
   JyXv8XJ49QRdKA19XJzu3ppfxKf9gdnlQoWdKp2l9AVVITi6jMzScYrwD
   imn1flwJ/wg9ZdNzP8Ejrw5e6AWk0dpuDQOHFLPIP9MySv54B4zJfRMW8
   PBl+TLw4JSWRgKMGtdr8mCM0liorxHMx/knpCTAyQbKSOH3WZSA1zA1i4
   jHSYrck/oeMQJDvnMf9vB4xTQMvo9xX9OMdZuhaQa0HNahvGWc5GyuCrn
   Q==;
X-CSE-ConnectionGUID: ykxSoxIISPqSpdZOy1EmsA==
X-CSE-MsgGUID: vEAhinMET9ym1VOEq6L+6Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11042"; a="8627223"
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="8627223"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 10:47:28 -0700
X-CSE-ConnectionGUID: xtaZPBqoSAevNZXFit0PIQ==
X-CSE-MsgGUID: MH52zZHIQCq/c67iw5UQkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,196,1708416000"; 
   d="scan'208";a="21328579"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.34.215]) ([10.212.34.215])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2024 10:47:28 -0700
Message-ID: <dcf61e50-2a56-4e1e-a21d-c887e3c07427@intel.com>
Date: Fri, 12 Apr 2024 10:47:27 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] cxl/core/regs: Add rcd_regs initialization at
 __rcrb_to_component()
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>,
 kobayashi.da-06@jp.fujitsu.com, linux-cxl@vger.kernel.org
Cc: y-goto@fujitsu.com, linux-pci@vger.kernel.org, mj@ucw.cz,
 dan.j.williams@intel.com
References: <20240412070715.16160-1-kobayashi.da-06@fujitsu.com>
 <20240412070715.16160-2-kobayashi.da-06@fujitsu.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240412070715.16160-2-kobayashi.da-06@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/12/24 12:07 AM, Kobayashi,Daisuke wrote:
> Add rcd_regs and its initialization at __rcrb_to_component() to cache
> the cxl1.1 device link status information. Reduce access to the memory
> map area where the RCRB is located by caching the cxl1.1 device
> link status information.
> 
> Signed-off-by: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
> ---
>  drivers/cxl/core/regs.c | 16 ++++++++++++++++
>  drivers/cxl/cxl.h       |  3 +++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 372786f80955..e0e96be0ca7d 100644
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
> +	offset = FIELD_GET(GENMASK(7, 0), readw(addr + PCI_CAPABILITY_LIST));

Maybe
#define PCI_RCRB_CAPABILITY_LIST_ID_MASK	GENMASK(7, 0)

> +	cap_hdr = readl(addr + offset);
> +	while ((cap_hdr & GENMASK(7, 0)) != PCI_CAP_ID_EXP) {

while ((FIELD_GET(PCI_RCRB_CAP_HDR_ID_MASK, cap_hdr) != PCI_CAP_ID_EXP) {

Also I think you need to add a check and see if the loop went beyond SZ_4K that was mapped.

> +		offset = (cap_hdr >> 8) & GENMASK(7, 0);

#define PCI_RCRB_CAP_HDR_NEXT_MASK	GENMASK(15, 8);
offset = FIELD_GET(PCI_RCRB_CAP_HDR_NEXT_MASK, cap_hdr);
> +		if (offset == 0)
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
> index 003feebab79b..2dc827c301a1 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -647,6 +647,9 @@ cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
>  struct cxl_rcrb_info {
>  	resource_size_t base;
>  	u16 aer_cap;
> +	u16 rcd_lnkctrl;
> +	u16 rcd_lnkstatus;
> +	u32 rcd_lnkcap;
>  };
>  
>  /**

