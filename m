Return-Path: <linux-pci+bounces-39803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A0BDAC1FCA0
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 12:21:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B36F34E4ADC
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 11:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43BF92E6CC8;
	Thu, 30 Oct 2025 11:21:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 321432E6CD1
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 11:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823262; cv=none; b=HuJfEbQDagK07scUpNVeXChxwMJgpmReCLIoW42s02x1OGAGris1ntLoaLQmKBP0iatDfnxe+cPGLHjakKXdOt4as8PlxU+iabtVirRNg/v2Uyh/EnVhMCR7OS6WKbiKauZQlF8O0NxNu0/U9HNM9NNPUV062OIU43UOE7Fs4MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823262; c=relaxed/simple;
	bh=7NyqNTdzHlzERXNIqtIW6/vNbYTfScvrHzJSMOP0n18=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5sbs9O33T9qGYx+hWfShefA8rKSGYnD4NYfPqLnVApJ+++2J0LWjt16B/U34Dt0Gtkl5yEOKoUSiPhFbJdsSWDhoKwyzSDnzaxuSiaImA3kWHc+uB7+EvLhQoVPG8RTiyw5/Hi/EvKV4zGc46BGDDyewNiK2gBVl1Xc9H3m3Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cy1pN4tDTz686xP;
	Thu, 30 Oct 2025 19:19:08 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id C477514025A;
	Thu, 30 Oct 2025 19:20:57 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Oct
 2025 11:20:57 +0000
Date: Thu, 30 Oct 2025 11:20:55 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<xin@zytor.com>, <chao.gao@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [RFC PATCH 20/27] coco/tdx-host: Add connect()/disconnect()
 handlers prototype
Message-ID: <20251030112055.00001fcb@huawei.com>
In-Reply-To: <20250919142237.418648-21-dan.j.williams@intel.com>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
	<20250919142237.418648-21-dan.j.williams@intel.com>
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

On Fri, 19 Sep 2025 07:22:29 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Xu Yilun <yilun.xu@linux.intel.com>
> 
> Add basic skeleton for connect()/disconnect() handlers. The major steps
> are SPDM setup first and then IDE selective stream setup.
> 
> No detailed TDX Connect implementation.
> 
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Feels like use of __free() in here is inappropriate to me.

> ---
>  drivers/virt/coco/tdx-host/tdx-host.c | 49 ++++++++++++++++++++++++++-
>  1 file changed, 48 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
> index f5a869443b15..0d052a1acf62 100644
> --- a/drivers/virt/coco/tdx-host/tdx-host.c
> +++ b/drivers/virt/coco/tdx-host/tdx-host.c
> @@ -104,13 +104,60 @@ static int __maybe_unused tdx_spdm_msg_exchange(struct tdx_link *tlink,
>  	return ret;

> +
> +static void __tdx_link_disconnect(struct tdx_link *tlink)
> +{
> +	tdx_ide_stream_teardown(tlink);
> +	tdx_spdm_session_teardown(tlink);
> +}
> +
> +DEFINE_FREE(__tdx_link_disconnect, struct tdx_link *, if (_T) __tdx_link_disconnect(_T))
> +
>  static int tdx_link_connect(struct pci_dev *pdev)
>  {
> -	return -ENXIO;
> +	struct tdx_link *tlink = to_tdx_link(pdev->tsm);
> +	int ret;
> +
> +	struct tdx_link *__tlink __free(__tdx_link_disconnect) = tlink;
I'm not a fan on an ownership pass like this just for purposes of cleaning up.

I'd be a bit happier if you could make it
	struct tdx_link *tlink __free(__tdx_link_disconnect) = to_tdx_link(pdev->dsm);

but I still don't really like it.  I think I'd just not use __free and stick
to traditional cleanup in via a goto. 

> +	ret = tdx_spdm_session_setup(tlink);
> +	if (ret) {
> +		pci_err(pdev, "fail to setup spdm session\n");
> +		return ret;
> +	}
> +
> +	ret = tdx_ide_stream_setup(tlink);
> +	if (ret) {
> +		pci_err(pdev, "fail to setup ide stream\n");

If this fails we still call tdx_ide_stream_teardown().  Why does that make sense
given I'd expect this to have no side effects on failure?  Definitely needs
a comment. I also definitely don't think __free is appropriate here as it
is hiding this detail somewhat

> +		return ret;
> +	}
> +
> +	tlink = no_free_ptr(__tlink);
> +
> +	return 0;
>  }
>  
>  static void tdx_link_disconnect(struct pci_dev *pdev)
>  {
> +	struct tdx_link *tlink = to_tdx_link(pdev->tsm);
> +
> +	__tdx_link_disconnect(tlink);
>  }
>  
>  static struct pci_tsm_ops tdx_link_ops;


