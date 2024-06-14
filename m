Return-Path: <linux-pci+bounces-8792-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E339086DE
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 10:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08A381F27AD1
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 08:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08781188CC1;
	Fri, 14 Jun 2024 08:59:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6C714884B;
	Fri, 14 Jun 2024 08:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718355571; cv=none; b=n6iLlQstqLDtBmJLKsmi+fDZl5bRnNofgviiBDs7eGiXVEsGknW3LZhQOPOjLDDl5fFPGTHG+0kGx46q8NWgyzA8uonFofAuhLIXpqG1qz7WGMdCfH+yol3yGiV90PVOCMOqTWjR+DYPPbi7DSEsVX3o65zOzIoGMxsSVsurWKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718355571; c=relaxed/simple;
	bh=Dn659CpvPrqEBO6oLG7tDarlWSwX43moRi/fdKRv/yM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fBJskLyLnYo47lOsn+LGKNUq7vT+47rgCGSskUuuexI1NqV6bVOdWzQOc8pw2Gpz//ww2KiYmPg0p3kgIxroN7YLyZy6s6L4ByHXB9GMsbW3aoUbQJ4zXGN43VeHMAnbLUEZQmOc7Et1X4zm0MOPnNiNi2Gkfe68d8kQo9+bZdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W0tPt4YXBz6JB6L;
	Fri, 14 Jun 2024 16:54:42 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 1048A140C72;
	Fri, 14 Jun 2024 16:59:26 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Jun
 2024 09:59:25 +0100
Date: Fri, 14 Jun 2024 09:59:24 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Alistair Francis <alistair23@gmail.com>
CC: <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, <lukas@wunner.de>,
	<alex.williamson@redhat.com>, <christian.koenig@amd.com>, <kch@nvidia.com>,
	<gregkh@linuxfoundation.org>, <logang@deltatee.com>,
	<linux-kernel@vger.kernel.org>, <chaitanyak@nvidia.com>,
	<rdunlap@infradead.org>, Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v11 3/4] PCI/DOE: Expose the DOE features via sysfs
Message-ID: <20240614095924.00004eb5@Huawei.com>
In-Reply-To: <20240614001244.925401-3-alistair.francis@wdc.com>
References: <20240614001244.925401-1-alistair.francis@wdc.com>
	<20240614001244.925401-3-alistair.francis@wdc.com>
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
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 14 Jun 2024 10:12:43 +1000
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

One question inline.  Feels like I'm either missing something or
the code has evolved in a fashion that left us with a pointless check
on attr visibility.

Jonathan

> diff --git a/drivers/pci/doe.c b/drivers/pci/doe.c
> index defc4be81bd4..9858b709c020 100644
> --- a/drivers/pci/doe.c
> +++ b/drivers/pci/doe.c

> +static umode_t pci_doe_features_sysfs_attr_visible(struct kobject *kobj,
> +						   struct attribute *a, int n)
> +{
> +	struct pci_dev *pdev = to_pci_dev(kobj_to_dev(kobj));
> +	struct pci_doe_mb *doe_mb;
> +	unsigned long index, j;
> +	unsigned long vid, type;
> +	void *entry;
> +
> +	xa_for_each(&pdev->doe_mbs, index, doe_mb) {
> +		xa_for_each(&doe_mb->feats, j, entry) {

I'm confused.  What is the intent here?

Given every DOE should have the discovery entry any call of this function
that actually finds a DOE should return a->mode, so why search the
actual entries? 

Given absence of the files anyway (due to the directory visible checks)
if there are no DOEs, why not drop this function completely?

> +			vid = xa_to_value(entry) >> 8;
> +			type = xa_to_value(entry) & 0xFF;
> +
> +			if (vid == 0x01 && type == 0x00) {
> +				/*
> +				 * This is the DOE discovery protocol
> +				 * Every DOE instance must support this, so we
> +				 * give it a useful name.
> +				 */
> +				return a->mode;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}




