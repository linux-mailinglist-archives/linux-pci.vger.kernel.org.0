Return-Path: <linux-pci+bounces-9591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC067923FBB
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 15:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD8921C2520E
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 13:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1B01B5805;
	Tue,  2 Jul 2024 13:58:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB8C8BA2D;
	Tue,  2 Jul 2024 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719928694; cv=none; b=NKo7eoz+TpDS1ZCViuaq3sfFpX7UQ5JfVZufw6Sltp5btsLN2pqp5PqJugY2irlCDjcv4MlyBqCPVqHEXsyqtHoPUVCQFBaUMjLS8Fi+3KC7dBYftw+rfL4ML1OrGBR4zkSsFeivwR2wIDgw0q4mBS/D7CeXOLCkVYM+21p3Yaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719928694; c=relaxed/simple;
	bh=xCE2RIpbeVhzMwF3yidFMIlxp8054MgOi5XS7kUnoAU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=K66NVEiDqWEDjuJTXMaDAJefnZe92tuMqoFzJ/7Z02PMdAHjbVtONGcpzmZqsEAQ0BI8eu/jL29GvNk6EzZaLUv7dGuofxuCsF0fLAG/2cXUZ0Cjd+7/ol71CKbWlvuXSnS3ENxTTIUTGBdXEL858Mja9nMcaGxNmyjVLVIE7/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WD4FX5sC3z6K91h;
	Tue,  2 Jul 2024 21:56:16 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 21525140A70;
	Tue,  2 Jul 2024 21:58:08 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 2 Jul
 2024 14:58:07 +0100
Date: Tue, 2 Jul 2024 14:58:06 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alistair Francis <alistair23@gmail.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, <lukas@wunner.de>,
	<alex.williamson@redhat.com>, <christian.koenig@amd.com>, <kch@nvidia.com>,
	<gregkh@linuxfoundation.org>, <logang@deltatee.com>,
	<linux-kernel@vger.kernel.org>, <chaitanyak@nvidia.com>,
	<rdunlap@infradead.org>, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v13 3/4] PCI/DOE: Expose the DOE features via sysfs
Message-ID: <20240702145806.0000669b@Huawei.com>
In-Reply-To: <20240702060418.387500-3-alistair.francis@wdc.com>
References: <20240702060418.387500-1-alistair.francis@wdc.com>
	<20240702060418.387500-3-alistair.francis@wdc.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue,  2 Jul 2024 16:04:17 +1000
Alistair Francis <alistair23@gmail.com> wrote:

> The PCIe 6 specification added support for the Data Object
> Exchange (DOE).
> When DOE is supported the DOE Discovery Feature must be implemented per
> PCIe r6.1 sec 6.30.1.1. The protocol allows a requester to obtain
> information about the other DOE features supported by the device.
> 
> The kernel is already querying the DOE features supported and cacheing
> the values. Expose the values in sysfs to allow user space to
> determine which DOE features are supported by the PCIe device.
> 
> By exposing the information to userspace tools like lspci can relay the
> information to users. By listing all of the supported features we can
> allow userspace to parse the list, which might include
> vendor specific features as well as yet to be supported features.
> 
> After this patch is supported you can see something like this when
> attaching a DOE device
> 
> $ ls /sys/devices/pci0000:00/0000:00:02.0//doe*
> 0001:00        0001:01        0001:02
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
> v13:
>  - Drop pci_doe_sysfs_init() and use pci_doe_sysfs_group
>      - As discussed in https://lore.kernel.org/all/20231019165829.GA1381099@bhelgaas/
>        we can just modify pci_doe_sysfs_group at the DOE init and let

Can't do that as it is global so you expose the same DOE features for
all DOEs.

Also, I think that this is only processing features on last doe_mb found
for a given device. Fix that and the duplicates problem resurfaces.


>        device_add() handle the sysfs attributes.


> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index defc4be81bd4..e7b702afce88 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c

> +
>  static int pci_doe_wait(struct pci_doe_mb *doe_mb, unsigned long timeout)
>  {
>  	if (wait_event_timeout(doe_mb->wq,
> @@ -687,6 +747,12 @@ void pci_doe_init(struct pci_dev *pdev)
>  {
>  	struct pci_doe_mb *doe_mb;
>  	u16 offset = 0;
> +	struct attribute **sysfs_attrs;
> +	struct device_attribute *attrs;
> +	unsigned long num_features = 0;
> +	unsigned long i;
> +	unsigned long vid, type;
> +	void *entry;
>  	int rc;
>  
>  	xa_init(&pdev->doe_mbs);
> @@ -707,6 +773,45 @@ void pci_doe_init(struct pci_dev *pdev)
>  			pci_doe_destroy_mb(doe_mb);
>  		}
>  	}

The above is looping over multiple DOEs but this just considers last one.
That doesn't look right...

I think this needs to be in the loop and having done that
the duplicate handing may be an issue.  I'm not sure what happens
in that path with a presupplied set of attributes.

> +
> +	if (doe_mb) {
> +		xa_for_each(&doe_mb->feats, i, entry)
> +			num_features++;
> +
> +		sysfs_attrs = kcalloc(num_features + 1, sizeof(*sysfs_attrs), GFP_KERNEL);
> +		if (!sysfs_attrs)
> +			return;
> +
> +		attrs = kcalloc(num_features, sizeof(*attrs), GFP_KERNEL);
> +		if (!attrs) {
> +			kfree(sysfs_attrs);
> +			return;
> +		}
> +
> +		doe_mb->device_attrs = attrs;
> +		doe_mb->sysfs_attrs = sysfs_attrs;
> +
> +		xa_for_each(&doe_mb->feats, i, entry) {
> +			sysfs_attr_init(&attrs[i].attr);
> +
> +			vid = xa_to_value(entry) >> 8;
> +			type = xa_to_value(entry) & 0xFF;
> +
> +			attrs[i].attr.name = kasprintf(GFP_KERNEL, "%04lx:%02lx", vid, type);
> +			if (!attrs[i].attr.name) {
> +				pci_doe_sysfs_feature_remove(pdev, doe_mb);
> +				return;
> +			}
> +			attrs[i].attr.mode = 0444;
> +			attrs[i].show = pci_doe_sysfs_feature_show;
> +
> +			sysfs_attrs[i] = &attrs[i].attr;
> +		}
> +
> +		sysfs_attrs[num_features] = NULL;
> +
> +		pci_doe_sysfs_group.attrs = sysfs_attrs;
Hmm. Isn't this global?  What if you have multiple devices.

> +	}
>  }
>  


