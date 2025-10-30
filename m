Return-Path: <linux-pci+bounces-39806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 89678C1FDB4
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 12:38:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7F1DE34E5AB
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 11:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657EC3385A5;
	Thu, 30 Oct 2025 11:37:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725422FFDEB
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 11:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761824271; cv=none; b=dgXkjDkpFgbkK/oTNll0bQx076nT4bDZ4r5ulxr6s/gDS/piSICOXvfatjrFCcyhlP5L2zkX9ymh2xSNXDu0fFORa35LiXpcQPF4mK0ZvAkL4Kdep05AZ9opJdp1QXUtm9Sy71PzjPln4JR2f+GfEff3Q2+BHjlFkpN77W4AEeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761824271; c=relaxed/simple;
	bh=Wxk2mHHj76A0hI7pwkRyd1/X8P/2Hj2bNIo3nx6mSNQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQa63uE2oWOK9EzCjii5M/OduVaqtKRXjFc0WWMGIE2XtmePQi7tWATpxy6bRonMTCxvlBpav+anqUOrVr9jJgcBu2CF7dl+qhV5wkpqyZDMnMh2GmcMey7fDiyD1wn6P/Y/oXr4i3mEhAJPe8xGAZ9+vKhLy46S0zme3f/uiZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cy29k56b0z6K66K;
	Thu, 30 Oct 2025 19:35:54 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id EAD69140113;
	Thu, 30 Oct 2025 19:37:43 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Oct
 2025 11:37:43 +0000
Date: Thu, 30 Oct 2025 11:37:42 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<xin@zytor.com>, <chao.gao@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [RFC PATCH 26/27] x86/virt/tdx: Add SEAMCALL wrappers for IDE
 stream management
Message-ID: <20251030113742.00000d87@huawei.com>
In-Reply-To: <20250919142237.418648-27-dan.j.williams@intel.com>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
	<20250919142237.418648-27-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 19 Sep 2025 07:22:35 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Xu Yilun <yilun.xu@linux.intel.com>
> 
> Add several SEAMCALL wrappers for IDE stream management.
> 
> - TDH.IDE.STREAM.CREATE creates IDE stream metadata buffers for TDX
>   Module, and does root port side IDE configuration.
> - TDH.IDE.STREAM.BLOCK clears the root port side IDE configuration.
> - TDH.IDE.STREAM.DELETE releases the IDE stream metadata buffers.
> - TDH.IDE.STREAM.KM deals with the IDE Key Management protocol (IDE-KM)
> 
> More information see Intel TDX Connect ABI Specification [1]
> Section 3.2 TDX Connect Host-Side (SEAMCALL) Interface Functions.
> 
> [1]: https://cdrdv2.intel.com/v1/dl/getContent/858625
> 
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

> diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
> index 86dd855d7361..179c976eab01 100644
> --- a/arch/x86/virt/vmx/tdx/tdx.c
> +++ b/arch/x86/virt/vmx/tdx/tdx.c

> +
> +u64 tdh_ide_stream_block(u64 spdm_id, u64 stream_id)
> +{
> +	struct tdx_module_args args = {
> +		.rcx = spdm_id,
> +		.rdx = stream_id,
> +	};
> +	u64 r;
> +
> +	r = seamcall(TDH_IDE_STREAM_BLOCK, &args);
> +
> +	return r;

	return seamcall()


