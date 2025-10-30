Return-Path: <linux-pci+bounces-39798-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CEBC1FA9A
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 11:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3A01188F389
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 10:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DD826299;
	Thu, 30 Oct 2025 10:55:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F088631815D
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 10:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761821757; cv=none; b=Z1QU/Epp37wgjlHN4rZWFxI8I2lFd6JvfstpOib9Fhiz4r4LsVn47uwUmKTWNQt/An24g06tBxo7gcr2Bp84vIOtfSD7gDZi/oAkhNbjRoOo5/pzzWs26gaGZkzVlG43pY/XxWmKpxi2YamkLdCWiQY8F5/hqUzAiTPk6JJRVBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761821757; c=relaxed/simple;
	bh=hd8PakLvmTrF4Noiua5H5VRLbKqQCbvNI8Yfhnf2B8U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HmA3Uco8BbatgZltcxelJ8O3ctwNAumv6iYLQhcIsdAv1xsNpXW4XoEmZ75vtyx/TDBwLsOrjLf558e/UsUlqubFQYDuEz64XqxXpOrJIRY7hzqXisQsv6RBVoAajidED0yX+i+6bJs+MH1qEQz+85O58H8tolmAjZFccwApXuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cy1C50D4Yz6M4V2;
	Thu, 30 Oct 2025 18:52:01 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 1EB1D1402F9;
	Thu, 30 Oct 2025 18:55:53 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Oct
 2025 10:55:52 +0000
Date: Thu, 30 Oct 2025 10:55:51 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<xin@zytor.com>, <chao.gao@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>
Subject: Re: [RFC PATCH 08/27] x86/virt/tdx: Add tdx_enable_ext() to enable
 of TDX Module Extensions
Message-ID: <20251030105551.00002fe4@huawei.com>
In-Reply-To: <20250919142237.418648-9-dan.j.williams@intel.com>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
	<20250919142237.418648-9-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 19 Sep 2025 07:22:17 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Xu Yilun <yilun.xu@linux.intel.com>
> 
> tdx_enable() implements a simple state machine with @tdx_module_status to
> determine if TDX is already enabled, or failed to enable. Add another state
> to that enum (TDX_MODULE_INITIALIZED_EXT) to track if extensions have been enabled.
> 
> The extension initialization uses the new TDH.EXT.MEM.ADD and TDX.EXT.INIT
> seamcalls.
> 
> Note that this extension initialization does not impact existing in-flight
> SEAMCALLs that are not implemented by the extension. So only the first user
> of an extension-seamcall needs invoke this helper.
> 
> Co-developed-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

A few more trivial comments.

> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index d47b2612c816..9d4cebace054 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c

> +
> +DEFINE_FREE(tdx_ext_mempool_free, struct tdx_page_array *, if (!IS_ERR_OR_NULL(_T)) tdx_ext_mempool_free(_T))
Very long line. Add a break somewhere!


> +/**
> + * tdx_enable_ext - Enable TDX module extensions.
> + *
> + * This function assumes the caller has done VMXON.
> + *
> + * This function can be called in parallel by multiple callers.
> + *
> + * Return 0 if TDX module extension is enabled successfully, otherwise error.
> + */
> +int tdx_enable_ext(void)
> +{
> +	int ret;
> +
> +	mutex_lock(&tdx_module_lock);
guard() perhaps which would make early returns an option if nothing esle
gets added after the switch.

> +
> +	switch (tdx_module_status) {
> +	case TDX_MODULE_INITIALIZED:
> +		ret = __tdx_enable_ext();
> +		break;
> +	case TDX_MODULE_INITIALIZED_EXT:
> +		ret = 0;
> +		break;
> +	default:
> +		ret = -EINVAL;
> +		break;
> +	}
> +
> +	mutex_unlock(&tdx_module_lock);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(tdx_enable_ext);

