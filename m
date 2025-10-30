Return-Path: <linux-pci+bounces-39794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96107C1F902
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 11:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4110534E03C
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 10:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27FD4338586;
	Thu, 30 Oct 2025 10:31:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038BE2C326B
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 10:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761820300; cv=none; b=m7SK1jh4VLSQvgG/uoldb9mpv5geMy+tRJdEO5hjQHbUgW41x5CwzozaVewVCNmR8kZxEPkTNNgnbNWsPSHN63jdHxJRgpatr4Me/t0pVMEu4PJ39gHWFZriEQL/K2XgPR5GfjYeD3ebN3EtoCC39ZnPEZMvOoBiL1iInpSSdqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761820300; c=relaxed/simple;
	bh=/YUvUR3zhDx5+HG1lt6o7hAV5AVHpvcKDtbsJdFid74=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F496tExlWiRAZkVoCWXQL9dyTd+n9gmJZ2Vb3rKjP1i08YrPBHInlvvPdxJlBl/FB762YHhnfIgn+8txNtcfD3OQFpOFeo+ZlKUrsVpE1wT3p7WK0t3OkLytPUa3UH4FXaEtcc/vLHD/DsQ8rpdTCMh4TqdzpHjus4UKdqXHfPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cy0jN4GpWz6K5rl;
	Thu, 30 Oct 2025 18:29:44 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id A9FFB1402F9;
	Thu, 30 Oct 2025 18:31:33 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Oct
 2025 10:31:33 +0000
Date: Thu, 30 Oct 2025 10:31:31 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<xin@zytor.com>, <chao.gao@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [RFC PATCH 03/27] coco/tdx-host: Support Link TSM for TDX host
Message-ID: <20251030103131.00007678@huawei.com>
In-Reply-To: <20250919142237.418648-4-dan.j.williams@intel.com>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
	<20250919142237.418648-4-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 19 Sep 2025 07:22:12 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Xu Yilun <yilun.xu@linux.intel.com>
> 
> Register a Link TSM instance to support host side TSM operations for
> TDISP, when the TDX Connect support bit is set by TDX Module in
> tdx_feature0.
> 
> This is the main purpose of an independent tdx-host module out of TDX
> core. Recall that a TEE Security Manager (TSM) is a platform agent that
> speaks the TEE Device Interface Security Protocol (TDISP) to PCIe
> devices and manages private memory resources for the platform. An
> independent tdx-host module allows for device-security enumeration and
> initialization flows to be deferred from other TDX Module initialization
> requirements. Crucially, when / if TDX Module init moves earlier in x86
> initialization flow this driver is still guaranteed to run after IOMMU
> and PCI init (i.e. subsys_initcall() vs device_initcall()).
> 
> The ability to unload the module, or unbind the driver is also useful
> for debug and coarse grained transitioning between PCI TSM operation and
> PCI CMA operation (native kernel PCI device authentication).
> 
> For now this is the basic boilerplate with operation flows to be added
> later.
> 
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Co-developed-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  arch/x86/include/asm/tdx.h            |   1 +
>  drivers/virt/coco/tdx-host/Kconfig    |   6 ++
>  drivers/virt/coco/tdx-host/tdx-host.c | 145 +++++++++++++++++++++++++-
>  3 files changed, 151 insertions(+), 1 deletion(-)
> 

> diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
> index 49c205913ef6..41813ba352d0 100644
> --- a/drivers/virt/coco/tdx-host/tdx-host.c
> +++ b/drivers/virt/coco/tdx-host/tdx-host.c

> +static struct pci_tsm_ops tdx_link_ops;
> +

Why is this needed?


> +static int tdx_connect_init(struct device *dev)
> +{
> +	struct tsm_dev *link;
> +
> +	if (!IS_ENABLED(CONFIG_TDX_CONNECT))
> +		return 0;
> +
> +	tdx_sysinfo = tdx_get_sysinfo();
> +	if (!tdx_sysinfo)
> +		return -ENXIO;
> +
> +	if (!(tdx_sysinfo->features.tdx_features0 & TDX_FEATURES0_TDXCONNECT))
> +		return 0;
> +
> +	link = tsm_register(dev, &tdx_link_ops);
> +	if (IS_ERR(link)) {
> +		dev_err(dev, "failed to register TSM: (%pe)\n", link);
> +		return PTR_ERR(link);

Might as well use
		return dev_err_probe(dev, PTR_ERR(link), "failed to register TSM\n");
as that will pretty print the error for you anyway and saves a few lines of code.

Thanks,

Jonathan


