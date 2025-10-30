Return-Path: <linux-pci+bounces-39801-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AD4C1FBCD
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 12:12:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C15AE1A261A3
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 11:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FE6338912;
	Thu, 30 Oct 2025 11:09:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADB6355041
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 11:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761822573; cv=none; b=ci56yX5sTHiCjn2k1+fxdTEfhfT9V+JPOShRfbtXyEgeEyvOpKRm4I+HCICzxSwIIo4ygUTMYponnusUzV7Wh3H2VGSK+v9HWrUsA6wxE66OWlsdLPJRERnr+GqU8bcnfM4V9XvobkVYL3hrkhNTa0aN4B9WqQopZ2/5e2l6ZTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761822573; c=relaxed/simple;
	bh=LzTY2dhP0ii895j0DnW6RZv8zbdiliurgbGmZY4KVng=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gdJlvdJUctlEcbV4S9+JRhXbELf24wKNlwjepDzjbQMyRGPITon28mDGuNTYQlCXPIBwB7g0uETz4T7wwoOwrchbKkXzvLDZgY9L+DiAltwYe4NSYgzzs+R+gXOFTsMi9GdKtInaMb1AIne6WM5PU2SPLMwuxLVzyRwR3PzaCRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4cy1ZC01fFzHnGjV;
	Thu, 30 Oct 2025 11:08:35 +0000 (UTC)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 5D3491402FF;
	Thu, 30 Oct 2025 19:09:29 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Oct
 2025 11:09:28 +0000
Date: Thu, 30 Oct 2025 11:09:27 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<xin@zytor.com>, <chao.gao@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>,
	Lu Baolu <baolu.lu@linux.intel.com>
Subject: Re: [RFC PATCH 18/27] coco/tdx-host: Setup all trusted IOMMUs on
 TDX Connect init
Message-ID: <20251030110927.00001765@huawei.com>
In-Reply-To: <20250919142237.418648-19-dan.j.williams@intel.com>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
	<20250919142237.418648-19-dan.j.williams@intel.com>
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

On Fri, 19 Sep 2025 07:22:27 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Xu Yilun <yilun.xu@linux.intel.com>
> 
> Setup all trusted IOMMUs on TDX Connect initialization and clear all on
> TDX Connect removal.
> 
> Trusted IOMMU setup is the pre-condition for all following TDX Connect
> operations such as SPDM/IDE setup. It is more of a platform
> configuration than a standalone IOMMU configuration, so put the
> implementation in tdx-host driver.
> 
> There is no dedicated way to enumerate which IOMMU devices support
> trusted operations. The host has to call TDH.IOMMU.SETUP on all IOMMU
> devices and tell their trusted capability by the return value.
> 
> Suggested-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Trivial follows.

>  static int tdx_connect_init(struct device *dev)
>  {
>  	struct tsm_dev *link;
> @@ -149,6 +229,16 @@ static int tdx_connect_init(struct device *dev)
>  		return ret;
>  	}
>  
> +	ret = tdx_iommu_enable_all();
> +	if (ret) {
> +		dev_err(dev, "Enable tdx iommu failed\n");

Similar to earlier comment, might as well use return dev_err_probe()

> +		return ret;
> +	}
> +
> +	ret = devm_add_action_or_reset(dev, tdx_iommu_disable_all, NULL);
> +	if (ret)
> +		return ret;
> +
>  	link = tsm_register(dev, &tdx_link_ops);
>  	if (IS_ERR(link)) {
>  		dev_err(dev, "failed to register TSM: (%pe)\n", link);


