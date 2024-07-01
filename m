Return-Path: <linux-pci+bounces-9515-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 146DE91DDD0
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 13:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BACB81F21E72
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 11:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E70113D63B;
	Mon,  1 Jul 2024 11:27:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AEF13D53D;
	Mon,  1 Jul 2024 11:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719833249; cv=none; b=hw7NhAmACnxc+yZP0I4jq0/LFoiRBO9T7MeMAcUaCZ4hgf0DNgzDkgbOM54Ss1FmTmmva6q46vBx2PFPpWgTeL/S/PLm0jASzO2MarERlWtN3307EogK2DugQlul4CxEjOfvoC9Cv8QruP0q9jKpe/LmRukZLfTxqzrwzEdsbhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719833249; c=relaxed/simple;
	bh=VF7ABEH7CUrrrauei+ZFGbjO1CVQzw2+43N56g2h9Rg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XxXIJVDZ4G/2GdOSHEzER5OXmYpyDTjduv1Kd0kNBvHF6u95ZnhMAZOVdvKb91CGeiG1YI/Tq7Kagw+iY9zKZKcvT2toDss4cFAPLt+zxVUbl4KscuNQowgb5It9JOXfJgqViHS35WT8tPP4PlbfXuoMhHqLYuYW6zfV3Ywwj8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WCNzZ5fZpz6JB7Y;
	Mon,  1 Jul 2024 19:26:50 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 76B62140B63;
	Mon,  1 Jul 2024 19:27:23 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 1 Jul
 2024 12:27:22 +0100
Date: Mon, 1 Jul 2024 12:27:21 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alistair Francis <alistair23@gmail.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, <lukas@wunner.de>,
	<alex.williamson@redhat.com>, <christian.koenig@amd.com>, <kch@nvidia.com>,
	<gregkh@linuxfoundation.org>, <logang@deltatee.com>,
	<linux-kernel@vger.kernel.org>, <chaitanyak@nvidia.com>,
	<rdunlap@infradead.org>, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v12 3/4] PCI/DOE: Expose the DOE features via sysfs
Message-ID: <20240701122721.0000034d@Huawei.com>
In-Reply-To: <20240626045926.680380-3-alistair.francis@wdc.com>
References: <20240626045926.680380-1-alistair.francis@wdc.com>
	<20240626045926.680380-3-alistair.francis@wdc.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 26 Jun 2024 14:59:25 +1000
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
> As the DOE Discovery feature must always be supported we treat it as a
> special named attribute case. This allows the usual PCI attribute_group
> handling to correctly create the doe_features directory when registering
> pci_doe_sysfs_group (otherwise it doesn't and sysfs_add_file_to_group()
> will seg fault).
> 
> After this patch is supported you can see something like this when
> attaching a DOE device
> 
> $ ls /sys/devices/pci0000:00/0000:00:02.0//doe*
> 0001:01        0001:02        doe_discovery
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Hi Alistair,

I think I missed an error path issue in earlier reviews.

Suggestion for minimal fix inline. If that is fine feel
free to add

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index defc4be81bd4..580370dc71ee 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c


> +
> +int pci_doe_sysfs_init(struct pci_dev *pdev)
> +{
> +	struct pci_doe_mb *doe_mb;
> +	unsigned long index;
> +	int ret;
> +
> +	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> +		ret = pci_doe_sysfs_feature_populate(pdev, doe_mb);

This doesn't feel quite right.  If we wait after a doe_mb features
set succeeds and then an error occurs this code doesn't cleanup and...

> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +#endif
> +
>  static int pci_doe_wait(struct pci_doe_mb *doe_mb, unsigned long timeout)
>  {
>  	if (wait_event_timeout(doe_mb->wq,
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 40cfa716392f..b5db191cb29f 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -16,6 +16,7 @@
>  #include <linux/kernel.h>
>  #include <linux/sched.h>
>  #include <linux/pci.h>
> +#include <linux/pci-doe.h>
>  #include <linux/stat.h>
>  #include <linux/export.h>
>  #include <linux/topology.h>
> @@ -1143,6 +1144,9 @@ static void pci_remove_resource_files(struct pci_dev *pdev)
>  {
>  	int i;
>  
> +	if (IS_ENABLED(CONFIG_PCI_DOE))
> +		pci_doe_sysfs_teardown(pdev);
> +
>  	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>  		struct bin_attribute *res_attr;
>  
> @@ -1227,6 +1231,12 @@ static int pci_create_resource_files(struct pci_dev *pdev)
>  	int i;
>  	int retval;
>  
> +	if (IS_ENABLED(CONFIG_PCI_DOE)) {
> +		retval = pci_doe_sysfs_init(pdev);
> +		if (retval)

... this doesn't call pci_remove_resource_files() unlike te
other error path in this function which does.

I think just calling that here would be sufficient and inline
with how error cleanup works for the rest of this code.
Personally I prefer driving for a function to have no side effects
but such is life.

> +			return retval;
> +	}
> +
>  	/* Expose the PCI resources from this device as files */
>  	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
>  
> @@ -1661,6 +1671,9 @@ const struct attribute_group *pci_dev_attr_groups[] = {
>  #endif
>  #ifdef CONFIG_PCIEASPM
>  	&aspm_ctrl_attr_group,
> +#endif
> +#ifdef CONFIG_PCI_DOE
> +	&pci_doe_sysfs_group,
>  #endif
>  	NULL,
>  };


