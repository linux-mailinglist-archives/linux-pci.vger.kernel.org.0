Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 667FC15E8D9
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2020 18:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404397AbgBNRDT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Feb 2020 12:03:19 -0500
Received: from foss.arm.com ([217.140.110.172]:40718 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404321AbgBNRDT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Feb 2020 12:03:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABC8B328;
        Fri, 14 Feb 2020 09:03:18 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 683133F68E;
        Fri, 14 Feb 2020 09:03:17 -0800 (PST)
Subject: Re: [PATCH 2/3] PCI: Add DMA configuration for virtual platforms
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org
Cc:     kevin.tian@intel.com, mst@redhat.com, sebastien.boeuf@intel.com,
        jacob.jun.pan@intel.com, bhelgaas@google.com, jasowang@redhat.com
References: <20200214160413.1475396-1-jean-philippe@linaro.org>
 <20200214160413.1475396-3-jean-philippe@linaro.org>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <393cce27-dbed-f075-2a67-9882bed801e7@arm.com>
Date:   Fri, 14 Feb 2020 17:03:16 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200214160413.1475396-3-jean-philippe@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14/02/2020 4:04 pm, Jean-Philippe Brucker wrote:
> Hardware platforms usually describe the IOMMU topology using either
> device-tree pointers or vendor-specific ACPI tables.  For virtual
> platforms that don't provide a device-tree, the virtio-iommu device
> contains a description of the endpoints it manages.  That information
> allows us to probe endpoints after the IOMMU is probed (possibly as late
> as userspace modprobe), provided it is discovered early enough.
> 
> Add a hook to pci_dma_configure(), which returns -EPROBE_DEFER if the
> endpoint is managed by a vIOMMU that will be loaded later, or 0 in any
> other case to avoid disturbing the normal DMA configuration methods.
> When CONFIG_VIRTIO_IOMMU_TOPOLOGY isn't selected, the call to
> virt_dma_configure() is compiled out.
> 
> As long as the information is consistent, platforms can provide both a
> device-tree and a built-in topology, and the IOMMU infrastructure is
> able to deal with multiple DMA configuration methods.

Urgh, it's already been established[1] that having IOMMU setup tied to 
DMA configuration at driver probe time is not just conceptually wrong 
but actually broken, so the concept here worries me a bit. In a world 
where of_iommu_configure() and friends are being called much earlier 
around iommu_probe_device() time, how badly will this fall apart?

Robin.

[1] 
https://lore.kernel.org/linux-iommu/9625faf4-48ef-2dd3-d82f-931d9cf26976@huawei.com/

> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> ---
>   drivers/pci/pci-driver.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 0454ca0e4e3f..69303a814f21 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -18,6 +18,7 @@
>   #include <linux/kexec.h>
>   #include <linux/of_device.h>
>   #include <linux/acpi.h>
> +#include <linux/virt_iommu.h>
>   #include "pci.h"
>   #include "pcie/portdrv.h"
>   
> @@ -1602,6 +1603,10 @@ static int pci_dma_configure(struct device *dev)
>   	struct device *bridge;
>   	int ret = 0;
>   
> +	ret = virt_dma_configure(dev);
> +	if (ret)
> +		return ret;
> +
>   	bridge = pci_get_host_bridge_device(to_pci_dev(dev));
>   
>   	if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
> 
