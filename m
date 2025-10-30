Return-Path: <linux-pci+bounces-39807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6500C1FDDE
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 12:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F561424C43
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 11:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EF5261B77;
	Thu, 30 Oct 2025 11:43:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48BFC2F9D9A
	for <linux-pci@vger.kernel.org>; Thu, 30 Oct 2025 11:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761824639; cv=none; b=cvqRxc9EGbcHB5/VkiweALv07NnkhHaYQrA4XwB/Y3kGstK2CYah7fKbL9GWMIcwSK0I8aguhNsON86KRKMK7hNe5NFpnA1/MXfpJ+U4GxFUvAaWtXMWlyuUyG3N/mtfAb00SKIeOK/17/esSTzLVnCfl4tvYje3xVvhb7ZlQB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761824639; c=relaxed/simple;
	bh=iR185h3VvF4CPoc5rhCxDqkfTGvVNOZnZk2oTNSZNww=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D7FiG2vKP2HGWf4c/qA0jx6rTIdfi/V5fyGU9bOGfuL90zbSTnQQeBt7lfVIsc23S0JeGp8Fgv4jMd6ARmwYldF5fgtNK8CiuzJumU1juL2l9HNp1L1AYwr+4QWK1N+5BCuIn6rF4UEfYr2+bNOg6REOAKnj9/H050/7b8Cg/Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cy2Jt0K84z6K6JZ;
	Thu, 30 Oct 2025 19:42:06 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 4A2971402F0;
	Thu, 30 Oct 2025 19:43:55 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 30 Oct
 2025 11:43:54 +0000
Date: Thu, 30 Oct 2025 11:43:53 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<xin@zytor.com>, <chao.gao@intel.com>, Xu Yilun <yilun.xu@linux.intel.com>
Subject: Re: [RFC PATCH 27/27] coco/tdx-host: Implement IDE stream
 setup/teardown
Message-ID: <20251030114353.00007c92@huawei.com>
In-Reply-To: <20250919142237.418648-28-dan.j.williams@intel.com>
References: <20250919142237.418648-1-dan.j.williams@intel.com>
	<20250919142237.418648-28-dan.j.williams@intel.com>
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

On Fri, 19 Sep 2025 07:22:36 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Xu Yilun <yilun.xu@linux.intel.com>
> 
> Implementation for a most straightforward Selective IDE stream setup.
> Hard code all parameters for Stream Control Register. And no IDE Key
> Refresh support.
> 
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
A few small things in here.

Jonathan

> ---
>  drivers/virt/coco/tdx-host/tdx-host.c | 271 +++++++++++++++++++++++++-
>  1 file changed, 270 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virt/coco/tdx-host/tdx-host.c b/drivers/virt/coco/tdx-host/tdx-host.c
> index 258539cf0cdf..7f156d219cee 100644
> --- a/drivers/virt/coco/tdx-host/tdx-host.c
> +++ b/drivers/virt/coco/tdx-host/tdx-host.c


> +static void tdx_ide_stream_delete(struct tdx_link *tlink)
> +{
> +	struct pci_dev *pdev = tlink->pci.base_tsm.pdev;
> +	unsigned int nr_released;
> +	u64 released_hpa, r;
> +
> +	r = tdh_ide_stream_block(tlink->spdm_id, tlink->stream_id);
> +	if (r) {
> +		pci_err(pdev, "ide stream block fail %llx\n", r);
> +		goto leak;
> +	}
> +
> +	r = tdh_ide_stream_delete(tlink->spdm_id, tlink->stream_id,
> +				  tlink->stream_mt, &nr_released,
> +				  &released_hpa);
> +	if (r) {
> +		pci_err(pdev, "ide stream delete fail %llx\n", r);
> +		goto leak;
> +	}
> +
> +	if (tdx_page_array_ctrl_release(tlink->stream_mt, nr_released,
> +					released_hpa)) {
> +		pci_err(pdev, "fail to release IDE stream metadata pages\n");
> +		goto leak;
> +	}
> +
> +	goto out;
> +
> +leak:
> +	tdx_page_array_ctrl_leak(tlink->stream_mt);
> +out:
> +	tlink->stream_mt = NULL;

Similar to the other case below. I'd just duplicate this last line
in the interests of simpler code flow.

> +}
> +
>  static void tdx_ide_stream_teardown(struct tdx_link *tlink)
>  {
> +	struct pci_dev *pdev = tlink->pci.base_tsm.pdev;
> +	struct pci_ide *ide = tlink->ide;
> +
> +	if (!ide)
> +		return;
> +
> +	pci_ide_stream_disable(pdev, ide);
> +	tsm_ide_stream_unregister(ide);
> +	tdx_ide_stream_key_stop(tlink);
> +	pci_ide_stream_teardown(pdev, ide);
> +	pci_ide_stream_unregister(ide);
> +	tdx_ide_stream_delete(tlink);
> +	pci_ide_stream_free(tlink->ide);
Use ide local variable

> +	tlink->ide = NULL;
Can you do this earlier so it's reverse of ordering in the
setup function?
>  }
>  
>  static int tdx_ide_stream_setup(struct tdx_link *tlink)
>  {
> -	return -EOPNOTSUPP;
> +	struct pci_dev *pdev = tlink->pci.base_tsm.pdev;
> +	struct pci_ide *ide;
> +	int ret;
> +
> +	ide = pci_ide_stream_alloc(pdev);
> +	if (!ide)
> +		return -ENOMEM;
> +
> +	/* Configure IDE capability for RP & get stream_id */
> +	ret = tdx_ide_stream_create(tlink, ide);
> +	if (ret)
> +		goto stream_free;
> +
> +	ide->stream_id = tlink->stream_id;
> +	ret = pci_ide_stream_register(ide);
> +	if (ret)
> +		goto tdx_stream_delete;
> +
> +	/* Configure IDE capability for target device */
> +	pci_ide_stream_setup(pdev, ide);
> +
> +	/* Key Programming for RP & target device, enable IDE stream for RP */
> +	ret = tdx_ide_stream_key_program(tlink);
> +	if (ret)
> +		goto stream_teardown;
> +
> +	ret = tsm_ide_stream_register(ide);
> +	if (ret)
> +		goto tdx_key_stop;
> +
> +	/* Enable IDE stream for target device */
> +	pci_ide_stream_enable(pdev, ide);
> +
> +	tlink->ide = ide;
> +
> +	return 0;
> +
> +tdx_key_stop:
> +	tdx_ide_stream_key_stop(tlink);
> +stream_teardown:
> +	pci_ide_stream_teardown(pdev, ide);
> +	pci_ide_stream_unregister(ide);
> +tdx_stream_delete:
> +	tdx_ide_stream_delete(tlink);
> +stream_free:
> +	pci_ide_stream_free(tlink->ide);
(ide) I think because...
> +	tlink->ide = NULL;
How is this set in any path that gets here?  Looks
like it is only assigned right at the end after all error paths.

> +	return ret;
>  }
>  
>  static void __tdx_link_disconnect(struct tdx_link *tlink)


