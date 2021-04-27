Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1236A36CBB7
	for <lists+linux-pci@lfdr.de>; Tue, 27 Apr 2021 21:33:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbhD0Tei (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Apr 2021 15:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235686AbhD0Teh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Apr 2021 15:34:37 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C247C061574
        for <linux-pci@vger.kernel.org>; Tue, 27 Apr 2021 12:33:54 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id t21so365092plo.2
        for <linux-pci@vger.kernel.org>; Tue, 27 Apr 2021 12:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=R+F2zOJdoXavuDhUMY1QiZp/NrhfLweB0na9Qyx1V6M=;
        b=TJz59G9wTmQQcbNbRY6OLyN78TksPOrBEHchyw0NBoPqX7sH+F3GGV9C/CfZW1h60M
         za+EgCvhm5j94fG3EFrSszh3F9AtXSEv6o4v4pzjNzSIPeAEJTXAJgDlK3w7dIOwvVl3
         GDz/9VRq+nxGIFibJgIM4ZDwttw1bZanScMikT8vBhr3hHdh3+D1AMW+87r/3r/WeSeL
         mFN1NYGu0fU/BHLpJfQ111ayxh2eOXs3wIHf4Gc1C7LSKzpmBZACVlSiQZcSoeU7Fukr
         d9IJK8EwTF9bbg0KdJNjSvCfq8EatvIhTdt5V794cL+MA6LlTikeW2O5j+OCr1c9eKX8
         S8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=R+F2zOJdoXavuDhUMY1QiZp/NrhfLweB0na9Qyx1V6M=;
        b=YVCXqelmGi3PJ8gDxLBw244G9YTXCZwkEYJJyqidPjlJ7lUnix1xtm6a6Zk4Hrlv7P
         QJClZe2Y9xV1JN34UA7HdAqa8Tz6N+0i/B/0+3tsMiUkqcbpmbM2YfltEYd9uJlBzPOG
         SpifpLZ6JuBLfFIHqOXCNUylnHi1HIjDHEzRi3Ebxa1IVa9MxsSAFA93me63VqWHCR1y
         7sIkcUjSg2qC0GjVHTn5tUgtXqOr8c3/nxYUQo44cROw7WE4ZM9/cS4O2NE8EXFIaI8X
         4rmywhQUOYr5zd8Lg/Mdh5OKX87Rc2mLXffOVuRI7zEAxWHZLdlZxi2/vJZ3tRKB1Msj
         36uQ==
X-Gm-Message-State: AOAM533bjIF86936gWKF0SMDV4tvuQeT2w3rOcg1yLqkouomHk6+o6az
        PIOZMn6s+e9T4H+oltRz1TRu/Q==
X-Google-Smtp-Source: ABdhPJwz3MILTFTzWsw6JFNbmAnxbzNG2cgSRXVHlPFwKXyKDZuqS3fiLINQaBtKfebJ6/AT25pPWg==
X-Received: by 2002:a17:902:8a8a:b029:ec:857a:4d51 with SMTP id p10-20020a1709028a8ab02900ec857a4d51mr25612392plo.68.1619552034009;
        Tue, 27 Apr 2021 12:33:54 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id o5sm460461pgq.58.2021.04.27.12.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 12:33:53 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lbTSx-00Dgwh-Mo; Tue, 27 Apr 2021 16:33:51 -0300
Date:   Tue, 27 Apr 2021 16:33:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
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
Subject: Re: [PATCH 09/16] dma-direct: Support PCI P2PDMA pages in dma-direct
 map_sg
Message-ID: <20210427193351.GR2047089@ziepe.ca>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-10-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210408170123.8788-10-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 08, 2021 at 11:01:16AM -0600, Logan Gunthorpe wrote:
> Add PCI P2PDMA support for dma_direct_map_sg() so that it can map
> PCI P2PDMA pages directly without a hack in the callers. This allows
> for heterogeneous SGLs that contain both P2PDMA and regular pages.
> 
> SGL segments that contain PCI bus addresses are marked with
> sg_mark_pci_p2pdma() and are ignored when unmapped.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>  kernel/dma/direct.c | 25 ++++++++++++++++++++++---
>  1 file changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 002268262c9a..108dfb4ecbd5 100644
> +++ b/kernel/dma/direct.c
> @@ -13,6 +13,7 @@
>  #include <linux/vmalloc.h>
>  #include <linux/set_memory.h>
>  #include <linux/slab.h>
> +#include <linux/pci-p2pdma.h>
>  #include "direct.h"
>  
>  /*
> @@ -387,19 +388,37 @@ void dma_direct_unmap_sg(struct device *dev, struct scatterlist *sgl,
>  	struct scatterlist *sg;
>  	int i;
>  
> -	for_each_sg(sgl, sg, nents, i)
> +	for_each_sg(sgl, sg, nents, i) {
> +		if (sg_is_pci_p2pdma(sg)) {
> +			sg_unmark_pci_p2pdma(sg);

This doesn't seem nice, the DMA layer should only alter the DMA
portion of the SG, not the other portions. Is it necessary?

Jason
