Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33BA718A6B4
	for <lists+linux-pci@lfdr.de>; Wed, 18 Mar 2020 22:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727560AbgCRVKF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Mar 2020 17:10:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:46934 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727217AbgCRVKE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Mar 2020 17:10:04 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DDF2620409;
        Wed, 18 Mar 2020 21:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584565804;
        bh=3sXdSdhyiwUJD9GULDXvtPZES5Ttbh4g1SxSYnQUp9A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=H4yA8RvkRdbsQIqVXba5XF2I8yPR3rsPpuHgZBXlBgWBwwRh0F7BdWeW3S2geRVWy
         VasoGsmaYUDB0U8J2upyi7m67M7+OEWQc2ye0M/6HQ/6Xj3490Rut7wXTRxbL1crdO
         0yXxmaCUKGAkMvdzxslzJT8+BefbhTYtxhlqlmPk=
Date:   Wed, 18 Mar 2020 16:10:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe@linaro.org>
Cc:     iommu@lists.linux-foundation.org,
        virtualization@lists.linux-foundation.org,
        linux-pci@vger.kernel.org, joro@8bytes.org, mst@redhat.com,
        jasowang@redhat.com, kevin.tian@intel.com,
        sebastien.boeuf@intel.com, eric.auger@redhat.com,
        jacob.jun.pan@intel.com, robin.murphy@arm.com
Subject: Re: [PATCH v2 2/3] PCI: Add DMA configuration for virtual platforms
Message-ID: <20200318211002.GA237687@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200228172537.377327-3-jean-philippe@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 28, 2020 at 06:25:37PM +0100, Jean-Philippe Brucker wrote:
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
> 
> Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/pci-driver.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 0454ca0e4e3f..69303a814f21 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -18,6 +18,7 @@
>  #include <linux/kexec.h>
>  #include <linux/of_device.h>
>  #include <linux/acpi.h>
> +#include <linux/virt_iommu.h>
>  #include "pci.h"
>  #include "pcie/portdrv.h"
>  
> @@ -1602,6 +1603,10 @@ static int pci_dma_configure(struct device *dev)
>  	struct device *bridge;
>  	int ret = 0;
>  
> +	ret = virt_dma_configure(dev);
> +	if (ret)
> +		return ret;
> +
>  	bridge = pci_get_host_bridge_device(to_pci_dev(dev));
>  
>  	if (IS_ENABLED(CONFIG_OF) && bridge->parent &&
> -- 
> 2.25.0
> 
