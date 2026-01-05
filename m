Return-Path: <linux-pci+bounces-43992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A8DCF2EF0
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 11:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D681430019CE
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 10:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E8292F2918;
	Mon,  5 Jan 2026 10:13:24 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1810C2F3612;
	Mon,  5 Jan 2026 10:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767608004; cv=none; b=GfjVsPIIQqtftyqcit0LCNgvre+x7LbIExaqb80VbFlKT9/6DIsQ0UonVo5NgUqG0fl0vUcaWrwuqZYXqeCsOxLcWIJkglyNm0PQZgmTbka36ceGIWIFoBYTDtsWddEub7nNuMHojPWDAj4tBPL01t6Nn+gnjV7nZYLmH+6yq5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767608004; c=relaxed/simple;
	bh=DpVElg2DVjnuKoiBnbrUHbsGdsN4hKvpNbtKIBRK/CU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=soZ96KXkNO2iYdQC8wP52DdyHD7AMJ3ImfFsgcDTD/1p3xTk8IpZhFL5dRVbZyHo2sIit9LG4rpk8k5A6EjLwuOkNQR3x8fSOgAMlERF4FHtIXc8nyT0GwaItnnpNSyzKEh1gdZJyh+3JqapZnjUUv9xFBmEDpzkU8R0C19ixyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dl98M4jvWzJ46fX;
	Mon,  5 Jan 2026 18:12:19 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id D45A640086;
	Mon,  5 Jan 2026 18:13:19 +0800 (CST)
Received: from localhost (10.48.146.88) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Mon, 5 Jan
 2026 10:13:19 +0000
Date: Mon, 5 Jan 2026 10:13:17 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<dan.j.williams@intel.com>, <yilun.xu@intel.com>, <baolu.lu@linux.intel.com>,
	<zhenzhong.duan@intel.com>, <linux-kernel@vger.kernel.org>,
	<yi1.lai@intel.com>, <helgaas@kernel.org>
Subject: Re: [PATCH v2] PCI/IDE: Fix duplicate stream symlink names for TSM
 class devices
Message-ID: <20260105101317.00003ade@huawei.com>
In-Reply-To: <20260105093516.2645397-1-yilun.xu@linux.intel.com>
References: <20260105093516.2645397-1-yilun.xu@linux.intel.com>
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

On Mon,  5 Jan 2026 17:35:16 +0800
Xu Yilun <yilun.xu@linux.intel.com> wrote:

> The name streamH.R.E is used for 2 symlinks:
> 
>   1. TSM class devices: /sys/class/tsm/tsmN/streamH.R.E
>   2. host bridge devices: /sys/devices/pciDDDD:BB/streamH.R.E

For those who have managed to completely forget, it would be useful
to just mention what H R and E are. Given the docs
say H is the host bridge number I'm a little confused why it
isn't unique. At least at first glance I'd expect to see
stream0.0.0 and stream 1.0.0 your example.
Maybe H isn't unique across segments / PCI Domains? (DDDD in the above)
Maybe it should be?

Jonathan.

> 
> The first usage is broken cause streamH.R.E is only unique within a
> specific host bridge but not across the system. Error occurs e.g. when
> creating the first stream on a second host bridge:
> 
>   sysfs: cannot create duplicate filename '/devices/faux/tdx_host/tsm/tsm0/stream0.0.0'
> 
> Fix this by adding host bridge name into symlink name for TSM class
> devices so they show up as:
> 
>   /sys/class/tsm/tsmN/pciDDDD:BB:streamH.R.E
> 
> It should be OK to change the uAPI since it's new and has few users.
> 
> The symlink name for host bridge devices keeps unchanged. Keep concise
> as it is already in host bridge context.
> 
> Internally in the IDE library, store the full name in struct pci_ide
> so TSM symlinks can use it directly as before, while host bridge
> symlinks use only the streamH.R.E portion to preserve the existing name.
> 
> Fixes: a4438f06b1db ("PCI/TSM: Report active IDE streams")
> Reported-by: Yi Lai <yi1.lai@intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> ---
> v2: Changelog improvements
> 
> v1: https://lore.kernel.org/linux-coco/20251223085601.2607455-1-yilun.xu@linux.intel.com/
> ---
>  Documentation/ABI/testing/sysfs-class-tsm |  2 +-
>  drivers/pci/ide.c                         | 12 +++++++++---
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
> index 6fc1a5ac6da1..eff71e42c60e 100644
> --- a/Documentation/ABI/testing/sysfs-class-tsm
> +++ b/Documentation/ABI/testing/sysfs-class-tsm
> @@ -8,7 +8,7 @@ Description:
>  		link encryption and other device-security features coordinated
>  		through a platform tsm.
>  
> -What:		/sys/class/tsm/tsmN/streamH.R.E
> +What:		/sys/class/tsm/tsmN/pciDDDD:BB:streamH.R.E
>  Contact:	linux-pci@vger.kernel.org
>  Description:
>  		(RO) When a host bridge has established a secure connection via
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index f0ef474e1a0d..58fbe9cfd68c 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c
> @@ -425,6 +425,7 @@ int pci_ide_stream_register(struct pci_ide *ide)
>  	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
>  	struct pci_ide_stream_id __sid;
>  	u8 ep_stream, rp_stream;
> +	const char *short_name;
>  	int rc;
>  
>  	if (ide->stream_id < 0 || ide->stream_id > U8_MAX) {
> @@ -441,13 +442,16 @@ int pci_ide_stream_register(struct pci_ide *ide)
>  
>  	ep_stream = ide->partner[PCI_IDE_EP].stream_index;
>  	rp_stream = ide->partner[PCI_IDE_RP].stream_index;
> -	const char *name __free(kfree) = kasprintf(GFP_KERNEL, "stream%d.%d.%d",
> +	const char *name __free(kfree) = kasprintf(GFP_KERNEL, "%s:stream%d.%d.%d",
> +						   dev_name(&hb->dev),
>  						   ide->host_bridge_stream,
>  						   rp_stream, ep_stream);
>  	if (!name)
>  		return -ENOMEM;
>  
> -	rc = sysfs_create_link(&hb->dev.kobj, &pdev->dev.kobj, name);
> +	/* Strip host bridge name in the host bridge context */
> +	short_name = name + strlen(dev_name(&hb->dev)) + 1;
> +	rc = sysfs_create_link(&hb->dev.kobj, &pdev->dev.kobj, short_name);
>  	if (rc)
>  		return rc;
>  
> @@ -471,8 +475,10 @@ void pci_ide_stream_unregister(struct pci_ide *ide)
>  {
>  	struct pci_dev *pdev = ide->pdev;
>  	struct pci_host_bridge *hb = pci_find_host_bridge(pdev->bus);
> +	const char *short_name;
>  
> -	sysfs_remove_link(&hb->dev.kobj, ide->name);
> +	short_name = ide->name + strlen(dev_name(&hb->dev)) + 1;
> +	sysfs_remove_link(&hb->dev.kobj, short_name);
>  	kfree(ide->name);
>  	ida_free(&hb->ide_stream_ids_ida, ide->stream_id);
>  	ide->name = NULL;
> 
> base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8


