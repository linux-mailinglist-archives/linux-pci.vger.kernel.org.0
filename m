Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4B263895DE
	for <lists+linux-pci@lfdr.de>; Wed, 19 May 2021 20:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhESS4J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 May 2021 14:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbhESS4I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 May 2021 14:56:08 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6539C06175F;
        Wed, 19 May 2021 11:54:48 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id v13so7568957ple.9;
        Wed, 19 May 2021 11:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=dOHil3dku6us1u8ptJ6JIh3xpDeGpcOMbsXrWxsBKoE=;
        b=cnnxKuD9wRMCCtazVzj6toxbgXcwxrb9Ouc86iDvINHgDyupM9mykeJyyckQXE4Rnq
         hq06c/AhNLxAl+uKAOVIR8t75aOIsL0QVqGA5chzbeSt0vvpUDh6dyPJSN8iQr/8cSTT
         naFa7nEaysxmImWzMWxEPel5LUj87LeUzIBfbiDL5YPxen+HitAXivixEaC0dK5umZ9C
         /hRQaspTbmz5yXsVRHAtEaCoC9OrLSx5wv4NZtIDg4qqr8EWekVxY4epEeIxfEclRFCW
         3sXGad/MPi4oLZncAM2dP7ovJhLYIIt2FuIu6GCpyimyCgdKa0aICR4C+b71QYuc2obh
         TPYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dOHil3dku6us1u8ptJ6JIh3xpDeGpcOMbsXrWxsBKoE=;
        b=DQ3vRVBveXeWB4IUDaXSK8UJY9cQk3CK+LlmJSq4mIkWoIddgzIICkC48o7eIzIiwZ
         LdSByR/oucamxrRVhIBa9OTShhZwf7QkqCG0YvkD0qQSdbrHGOeaK1V21s51WBtPMHmj
         mKtX8C2oyBFra3hrxgI//oRPkxe43sFjqfFIB/W/k3qlK8XsMcktYccPNL8OzMsAU72S
         debnyv8OrKYr5P8J4zzzpeA2C9AVeJJCZqBaP+TZxI38ayStc9F9zs0WKHdZezObzJgs
         /u5RiNBdWa35mSTV0dCb+sih9ZQRVVN/NuF4gD2IrKb8TZ9VMjSpOaA+NZzjheUsemLk
         8x2A==
X-Gm-Message-State: AOAM532kYJchQiIYVWKZZWJZs23M1JP4dP3Gdcmurk0GxIWmNoCGJpND
        dNLrMfA9nkUgqCaUBj8CLCM=
X-Google-Smtp-Source: ABdhPJxW6B5ZCMhQ2r/PwVD83uNx0fbqHe93UAEa6y6ZOrEtjXLovPk1PFllt4xgN3GhSn3N4TP6jw==
X-Received: by 2002:a17:902:ab89:b029:ee:dc90:7008 with SMTP id f9-20020a170902ab89b02900eedc907008mr1143149plr.30.1621450488169;
        Wed, 19 May 2021 11:54:48 -0700 (PDT)
Received: from [10.230.29.202] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id k15sm142717pfi.0.2021.05.19.11.54.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 May 2021 11:54:47 -0700 (PDT)
Subject: Re: [PATCH v7 04/15] swiotlb: Add restricted DMA pool initialization
To:     Claire Chang <tientzu@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, mpe@ellerman.id.au,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        boris.ostrovsky@oracle.com, jgross@suse.com,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        "list@263.net:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
        sstabellini@kernel.org, Robin Murphy <robin.murphy@arm.com>,
        grant.likely@arm.com, xypron.glpk@gmx.de,
        Thierry Reding <treding@nvidia.com>, mingo@kernel.org,
        bauerman@linux.ibm.com, peterz@infradead.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Saravana Kannan <saravanak@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        heikki.krogerus@linux.intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-devicetree <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, xen-devel@lists.xenproject.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        Jim Quinlan <james.quinlan@broadcom.com>, tfiga@chromium.org,
        bskeggs@redhat.com, bhelgaas@google.com, chris@chris-wilson.co.uk,
        daniel@ffwll.ch, airlied@linux.ie, dri-devel@lists.freedesktop.org,
        intel-gfx@lists.freedesktop.org, jani.nikula@linux.intel.com,
        jxgao@google.com, joonas.lahtinen@linux.intel.com,
        linux-pci@vger.kernel.org, maarten.lankhorst@linux.intel.com,
        matthew.auld@intel.com, rodrigo.vivi@intel.com,
        thomas.hellstrom@linux.intel.com
References: <20210518064215.2856977-1-tientzu@chromium.org>
 <20210518064215.2856977-5-tientzu@chromium.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <ae050c36-8179-e465-84f0-e46c361bd71e@gmail.com>
Date:   Wed, 19 May 2021 11:54:42 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210518064215.2856977-5-tientzu@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 5/17/2021 11:42 PM, Claire Chang wrote:
> Add the initialization function to create restricted DMA pools from
> matching reserved-memory nodes.
> 
> Signed-off-by: Claire Chang <tientzu@chromium.org>
> ---
>  include/linux/device.h  |  4 +++
>  include/linux/swiotlb.h |  3 +-
>  kernel/dma/swiotlb.c    | 76 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 82 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 38a2071cf776..4987608ea4ff 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -416,6 +416,7 @@ struct dev_links_info {
>   * @dma_pools:	Dma pools (if dma'ble device).
>   * @dma_mem:	Internal for coherent mem override.
>   * @cma_area:	Contiguous memory area for dma allocations
> + * @dma_io_tlb_mem: Internal for swiotlb io_tlb_mem override.
>   * @archdata:	For arch-specific additions.
>   * @of_node:	Associated device tree node.
>   * @fwnode:	Associated device node supplied by platform firmware.
> @@ -521,6 +522,9 @@ struct device {
>  #ifdef CONFIG_DMA_CMA
>  	struct cma *cma_area;		/* contiguous memory area for dma
>  					   allocations */
> +#endif
> +#ifdef CONFIG_DMA_RESTRICTED_POOL
> +	struct io_tlb_mem *dma_io_tlb_mem;
>  #endif
>  	/* arch specific additions */
>  	struct dev_archdata	archdata;
> diff --git a/include/linux/swiotlb.h b/include/linux/swiotlb.h
> index 216854a5e513..03ad6e3b4056 100644
> --- a/include/linux/swiotlb.h
> +++ b/include/linux/swiotlb.h
> @@ -72,7 +72,8 @@ extern enum swiotlb_force swiotlb_force;
>   *		range check to see if the memory was in fact allocated by this
>   *		API.
>   * @nslabs:	The number of IO TLB blocks (in groups of 64) between @start and
> - *		@end. This is command line adjustable via setup_io_tlb_npages.
> + *		@end. For default swiotlb, this is command line adjustable via
> + *		setup_io_tlb_npages.
>   * @used:	The number of used IO TLB block.
>   * @list:	The free list describing the number of free entries available
>   *		from each index.
> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index b849b01a446f..1d8eb4de0d01 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -39,6 +39,13 @@
>  #ifdef CONFIG_DEBUG_FS
>  #include <linux/debugfs.h>
>  #endif
> +#ifdef CONFIG_DMA_RESTRICTED_POOL
> +#include <linux/io.h>
> +#include <linux/of.h>
> +#include <linux/of_fdt.h>
> +#include <linux/of_reserved_mem.h>
> +#include <linux/slab.h>
> +#endif
>  
>  #include <asm/io.h>
>  #include <asm/dma.h>
> @@ -690,3 +697,72 @@ static int __init swiotlb_create_default_debugfs(void)
>  late_initcall(swiotlb_create_default_debugfs);
>  
>  #endif
> +
> +#ifdef CONFIG_DMA_RESTRICTED_POOL
> +static int rmem_swiotlb_device_init(struct reserved_mem *rmem,
> +				    struct device *dev)
> +{
> +	struct io_tlb_mem *mem = rmem->priv;
> +	unsigned long nslabs = rmem->size >> IO_TLB_SHIFT;
> +
> +	if (dev->dma_io_tlb_mem)
> +		return 0;
> +
> +	/*
> +	 * Since multiple devices can share the same pool, the private data,
> +	 * io_tlb_mem struct, will be initialized by the first device attached
> +	 * to it.
> +	 */
> +	if (!mem) {
> +		mem = kzalloc(struct_size(mem, slots, nslabs), GFP_KERNEL);
> +		if (!mem)
> +			return -ENOMEM;
> +
> +		if (PageHighMem(pfn_to_page(PHYS_PFN(rmem->base)))) {
> +			kfree(mem);
> +			return -EINVAL;

This could probably deserve a warning here to indicate that the reserved
area must be accessible within the linear mapping as I would expect a
lot of people to trip over that.

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
