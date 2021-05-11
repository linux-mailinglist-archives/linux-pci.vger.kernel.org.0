Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD37737AB70
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 18:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhEKQHi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 12:07:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35034 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231875AbhEKQHf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 12:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620749188;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8UV1wByeUIYlPOcdwlcmJhFE5ghODP+1p9OllaOX3sI=;
        b=gLw/Y6msZanJ7HEyDxnjR54Ay+Aq2OMEwTFqnlQLVTiO6v1VrvBL3CqIBFuah4OSqhWABS
        1NHLS9mXvrmkYPTdt1FmsFz9IAUYjV2uNiqlQzNOwKYDteA0KIRkJT1/zslzBCbD24Jr5D
        MQ9GeWecEPZLPh1a07Pftny/e/uZx9Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-LePH9WAtNran78JB9Xx15w-1; Tue, 11 May 2021 12:06:25 -0400
X-MC-Unique: LePH9WAtNran78JB9Xx15w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E05B91854E2A;
        Tue, 11 May 2021 16:06:19 +0000 (UTC)
Received: from [10.3.115.19] (ovpn-115-19.phx2.redhat.com [10.3.115.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FF4F9CA0;
        Tue, 11 May 2021 16:06:17 +0000 (UTC)
Subject: Re: [PATCH 10/16] dma-mapping: Add flags to dma_map_ops to indicate
 PCI P2PDMA support
To:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-11-logang@deltatee.com>
From:   Don Dutile <ddutile@redhat.com>
Message-ID: <92704199-4cee-3811-3902-08ccf6cc1f5f@redhat.com>
Date:   Tue, 11 May 2021 12:06:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210408170123.8788-11-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/8/21 1:01 PM, Logan Gunthorpe wrote:
> Add a flags member to the dma_map_ops structure with one flag to
> indicate support for PCI P2PDMA.
>
> Also, add a helper to check if a device supports PCI P2PDMA.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   include/linux/dma-map-ops.h |  3 +++
>   include/linux/dma-mapping.h |  5 +++++
>   kernel/dma/mapping.c        | 18 ++++++++++++++++++
>   3 files changed, 26 insertions(+)
>
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 51872e736e7b..481892822104 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -12,6 +12,9 @@
>   struct cma;
>   
>   struct dma_map_ops {
> +	unsigned int flags;
> +#define DMA_F_PCI_P2PDMA_SUPPORTED     (1 << 0)
> +
I'm not a fan of in-line define's; if we're going to add a flags field to the dma-ops
-- and logically it'd be good to have p2pdma go through the dma-ops struct --
then let's move this up in front of the dma-ops description.

And now that the dma-ops struct is being 'opened' for p2pdma, should p2pdma ops be added
to this struct, so all this work can be mimic'd/reflected/leveraged/refactored for CXL, GenZ, etc. p2pdma in (the near?) future?

>   	void *(*alloc)(struct device *dev, size_t size,
>   			dma_addr_t *dma_handle, gfp_t gfp,
>   			unsigned long attrs);
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 50b8f586cf59..c31980ecca62 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -146,6 +146,7 @@ int dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
>   		unsigned long attrs);
>   bool dma_can_mmap(struct device *dev);
>   int dma_supported(struct device *dev, u64 mask);
> +bool dma_pci_p2pdma_supported(struct device *dev);
>   int dma_set_mask(struct device *dev, u64 mask);
>   int dma_set_coherent_mask(struct device *dev, u64 mask);
>   u64 dma_get_required_mask(struct device *dev);
> @@ -247,6 +248,10 @@ static inline int dma_supported(struct device *dev, u64 mask)
>   {
>   	return 0;
>   }
> +static inline bool dma_pci_p2pdma_supported(struct device *dev)
> +{
> +	return 0;
> +}
>   static inline int dma_set_mask(struct device *dev, u64 mask)
>   {
>   	return -EIO;
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 923089c4267b..ce44a0fcc4e5 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -573,6 +573,24 @@ int dma_supported(struct device *dev, u64 mask)
>   }
>   EXPORT_SYMBOL(dma_supported);
>   
> +bool dma_pci_p2pdma_supported(struct device *dev)
> +{
> +	const struct dma_map_ops *ops = get_dma_ops(dev);
> +
> +	/* if ops is not set, dma direct will be used which supports P2PDMA */
> +	if (!ops)
> +		return true;
So, this means one cannot have p2pdma with IOMMU's? ...
-- or is this 'for now' and this may change?  if it may change, add a note here.

> +
> +	/*
> +	 * Note: dma_ops_bypass is not checked here because P2PDMA should
> +	 * not be used with dma mapping ops that do not have support even
> +	 * if the specific device is bypassing them.
> +	 */
> +
> +	return ops->flags & DMA_F_PCI_P2PDMA_SUPPORTED;
that's a bool?

> +}
> +EXPORT_SYMBOL_GPL(dma_pci_p2pdma_supported);
> +
>   #ifdef CONFIG_ARCH_HAS_DMA_SET_MASK
>   void arch_dma_set_mask(struct device *dev, u64 mask);
>   #else

