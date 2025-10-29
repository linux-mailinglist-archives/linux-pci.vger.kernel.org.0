Return-Path: <linux-pci+bounces-39684-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF69C1C2FE
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2B071A25CA6
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 16:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE14233F8BE;
	Wed, 29 Oct 2025 16:34:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54A933F8AD
	for <linux-pci@vger.kernel.org>; Wed, 29 Oct 2025 16:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761755684; cv=none; b=TfbcxgJNi5a4/r63cB87Myog4FwzhDNnWMvWNyxH2JSSuUg9I59bSu9r5NobEdaz75K255VOB8W3U9wznGgE1AyGPYt/mBcdRTbrsij+0fGJbdFXmENqZiS65jEXrn8y1+C2CDmJ0jMY0/k2BGlg5yR2Xi3YV95mGJvh2IBZapg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761755684; c=relaxed/simple;
	bh=LfGAviVUOEpXKmGXo+inIe1wSjvHmiakAtbRxVoDs4c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dsyyo/0cOtoBcZq2rFeEsmSFniW2mVGbKw7+IicAujFx7AkSKYOvcuMeqIah4UpWrzOIdD58kAJ7qUMRvvliBRfH+k7G3qoMyXIBUWHel0sAxkEzyKDRV6bEhymhlqyX/0F4DeJTzlY9tAzlQy9rm1Fny3nBILKqM5/4/RrrVVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cxXmq5yB1z6GD69;
	Thu, 30 Oct 2025 00:31:07 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id E29E2140370;
	Thu, 30 Oct 2025 00:34:40 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 Oct
 2025 16:34:40 +0000
Date: Wed, 29 Oct 2025 16:34:38 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>, <aik@amd.com>,
	<yilun.xu@linux.intel.com>, <aneesh.kumar@kernel.org>, <bhelgaas@google.com>,
	<gregkh@linuxfoundation.org>
Subject: Re: [PATCH v7 9/9] PCI/TSM: Report active IDE streams
Message-ID: <20251029163438.00001391@huawei.com>
In-Reply-To: <20251024020418.1366664-10-dan.j.williams@intel.com>
References: <20251024020418.1366664-1-dan.j.williams@intel.com>
	<20251024020418.1366664-10-dan.j.williams@intel.com>
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

On Thu, 23 Oct 2025 19:04:18 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Given that the platform TSM owns IDE Stream ID allocation, report the
> active streams via the TSM class device. Establish a symlink from the
> class device to the PCI endpoint device consuming the stream, named by
> the Stream ID.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Couple of trivial things noticed whilst refreshing my memory.

> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---

> diff --git a/drivers/virt/coco/tsm-core.c b/drivers/virt/coco/tsm-core.c
> index 4499803cf20d..c0dae531b64f 100644
> --- a/drivers/virt/coco/tsm-core.c
> +++ b/drivers/virt/coco/tsm-core.c
> @@ -2,14 +2,17 @@
>  /* Copyright(c) 2024 Intel Corporation. All rights reserved. */
>  
>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +#define dev_fmt(fmt) KBUILD_MODNAME ": " fmt

Why is this dev_fmt() in this patch (which doesn't seem to introduce
anything that would use it)?

>  
>  #include <linux/tsm.h>
>  #include <linux/idr.h>
> +#include <linux/pci.h>
>  #include <linux/rwsem.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
>  #include <linux/cleanup.h>
>  #include <linux/pci-tsm.h>
> +#include <linux/pci-ide.h>
>  
>  static struct class *tsm_class;
>  static DECLARE_RWSEM(tsm_rwsem);
> @@ -106,6 +109,32 @@ void tsm_unregister(struct tsm_dev *tsm_dev)
>  }
>  EXPORT_SYMBOL_GPL(tsm_unregister);
>  
> +/* must be invoked between tsm_register / tsm_unregister */
> +int tsm_ide_stream_register(struct pci_ide *ide)
> +{
> +	struct pci_dev *pdev = ide->pdev;
> +	struct pci_tsm *tsm = pdev->tsm;
> +	struct tsm_dev *tsm_dev = tsm->tsm_dev;
> +	int rc;
> +
> +	rc = sysfs_create_link(&tsm_dev->dev.kobj, &pdev->dev.kobj, ide->name);
> +	if (rc)
> +		return rc;
> +
> +	ide->tsm_dev = tsm_dev;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(tsm_ide_stream_register);
> +
> +void tsm_ide_stream_unregister(struct pci_ide *ide)
> +{
> +	struct tsm_dev *tsm_dev = ide->tsm_dev;
> +
> +	sysfs_remove_link(&tsm_dev->dev.kobj, ide->name);
> +	ide->tsm_dev = NULL;

Trivial preference for reverse order of register.  That means
setting this NULL before removing the link.


> +}
> +EXPORT_SYMBOL_GPL(tsm_ide_stream_unregister);
> +
>  static void tsm_release(struct device *dev)
>  {
>  	struct tsm_dev *tsm_dev = container_of(dev, typeof(*tsm_dev), dev);


