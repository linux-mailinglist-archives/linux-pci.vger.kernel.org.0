Return-Path: <linux-pci+bounces-29928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AD0ADCF9C
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 16:26:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 203DE16535E
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 14:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 110282EF66F;
	Tue, 17 Jun 2025 14:16:29 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B1E2EF640
	for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2025 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169789; cv=none; b=mzAa671KtJKHVQ0zQd9kfNGYrBkHk5NASyN3UgAJv0x+dVRlqVz1vGJhGUx+OB/8T60AeehMKBIc4sAirbbBtLcUqZgbr/ltJ98+TYWmAHiSvzOJwacFvBkfkQZditkThSRQCI+uKCMzHxcwqzEshzx+H0jZkwbpNHKLk5BNl0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169789; c=relaxed/simple;
	bh=hQSFK/OuBJ3KhqhN6sFyYBbCOq42PjmmPZO4FPx7f7k=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aLTrDUxqUF6xPzZ7alEGbYGDL0M7NCInDQaOX4NopYGHmWBVisgsItorosALxdArRF05qJ4PFYzJSy9h9OEPPe4qrkEAf3YhbwBK2yaMQha+fWyxdfQaE3WN7YdI/uNqNQBjHxKtMu8TVIYYHTuWfQdstSVJPqj4sQYeHy2MNn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bM86X6D8Jz6H7WG;
	Tue, 17 Jun 2025 22:15:48 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A31D1404C4;
	Tue, 17 Jun 2025 22:16:22 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 17 Jun
 2025 16:16:21 +0200
Date: Tue, 17 Jun 2025 15:16:19 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <lukas@wunner.de>, <aneesh.kumar@kernel.org>,
	<suzuki.poulose@arm.com>, <sameo@rivosinc.com>, <aik@amd.com>,
	<jgg@nvidia.com>, <zhiw@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>, Xu
 Yilun <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 09/13] PCI/IDE: Report available IDE streams
Message-ID: <20250617151619.0000325d@huawei.com>
In-Reply-To: <20250516054732.2055093-10-dan.j.williams@intel.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
	<20250516054732.2055093-10-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 15 May 2025 22:47:28 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> The limited number of link-encryption (IDE) streams that a given set of
> host bridges supports is a platform specific detail. Provide
> pci_ide_init_nr_streams() as a generic facility for either platform TSM
> drivers, or PCI core native IDE, to report the number available streams.
> After invoking pci_ide_init_nr_streams() an "available_secure_streams"
> attribute appears in PCI host bridge sysfs to convey that count.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Trivial stuff inline.

> ---
>  .../ABI/testing/sysfs-devices-pci-host-bridge | 13 ++++
>  drivers/pci/ide.c                             | 59 +++++++++++++++++++
>  drivers/pci/pci.h                             |  3 +
>  drivers/pci/probe.c                           | 12 +++-
>  include/linux/pci.h                           |  8 +++
>  5 files changed, 94 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> index d592b68c7333..382866a21703 100644
> --- a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> +++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> @@ -36,3 +36,16 @@ Description:
>  		stream resources shared by the Root Ports in a host bridge.  See
>  		/sys/devices/pciDDDD:BB entry for details about the DDDD:BB
>  		format.
> +
> +What:		pciDDDD:BB/available_secure_streams
> +Date:		December, 2024
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		(RO) When a host bridge has Root Ports that support PCIe IDE
> +		(link encryption and integrity protection) there may be a
> +		limited number of streams that can be used for establishing new
> +		secure links. This attribute decrements upon secure link setup,
> +		and increments upon secure link teardown. The in-use stream
> +		count is determined by counting stream symlinks.  See
> +		/sys/devices/pciDDDD:BB entry for details about the DDDD:BB
> +		format.

Is this name specific enough given mix of link and selective streams, both of which are
limited?  Nice to use generic terms but this one feels too generic!

> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index a529926647f4..b7561ac03405 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c

> +static struct attribute *pci_ide_attrs[] = {
> +	&dev_attr_available_secure_streams.attr,
> +	NULL,

As below. No trailing comma here.

> +};



> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 56704e851224..93be55321537 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -640,6 +640,16 @@ static void pci_release_host_bridge_dev(struct device *dev)
>  	kfree(bridge);
>  }
>  
> +static const struct attribute_group *pci_host_bridge_groups[] = {
> +	PCI_IDE_ATTR_GROUP,
> +	NULL,

One of my favourite comments :)  No comma on terminators. Let's
not make it easy to accidentally put something after them.

> +};
> +
> +static const struct device_type pci_host_bridge_type = {
> +	.groups = pci_host_bridge_groups,
> +	.release = pci_release_host_bridge_dev,

I've no problem with this as a clean up but you could have just
used the bridge->dev.groups instead I think? If you are clearing
that out for some other use alter, mention that in the patch description.

> +};
> +
>  static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>  {
>  	INIT_LIST_HEAD(&bridge->windows);
> @@ -659,6 +669,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
>  	bridge->native_dpc = 1;
>  	bridge->domain_nr = PCI_DOMAIN_NR_NOT_SET;
>  	bridge->native_cxl_error = 1;
> +	bridge->dev.type = &pci_host_bridge_type;
>  
>  	device_initialize(&bridge->dev);
>  }
> @@ -672,7 +683,6 @@ struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
>  		return NULL;
>  
>  	pci_init_host_bridge(bridge);
> -	bridge->dev.release = pci_release_host_bridge_dev;
>  
>  	return bridge;
>  }


