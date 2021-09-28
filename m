Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0950141B6BC
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 20:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242279AbhI1S5f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 14:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242153AbhI1S5e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 14:57:34 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30AD7C06161C
        for <linux-pci@vger.kernel.org>; Tue, 28 Sep 2021 11:55:55 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id x9so20972154qtv.0
        for <linux-pci@vger.kernel.org>; Tue, 28 Sep 2021 11:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ebZlYMj5MQ2pOTOwk0j9IKlcwdjsdmrFMDz+5vItq+c=;
        b=QmduZpNQDgW0HX/nW9RkW9k4dvojdWvu6yI+Y+rCA9o9oH5bVLI6TsHunUzrSn1qan
         PHU5+AW3MXramsIkU+ZDSrxmYZBvYuQYjMJ8ZK3HTUAC/kk+ABbFI4PQo0l6PK6M7nRv
         n9Qd+JTkspzOmRVuSE1NXDvXPcxu9E655NnWfHIdpbSyUqeZ7AB0M+jzXvboydl8/4mW
         Q+dh5+5Bb8TwSQyJYjXU55dzd2f6hLFNFMramZxQUeiowu7DX/YyaxsNVUfw6W0sCx/t
         RtayIzeJe4Z2LkvZb8z0oxWAhpakBOql79f7LUXTsyzSQH6U2cnhDUwgm442Ri1+Tm5t
         65Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ebZlYMj5MQ2pOTOwk0j9IKlcwdjsdmrFMDz+5vItq+c=;
        b=z2ffWh83xKB7AEWmJhQJn1vQXGaGuJxKNKDwg4BKTDw2/dmxG5S+3V/1yIGD/SxFig
         705W0C49b1vHguZuMmQqiasEyW+x8s/sT9oSNTwSTxRmEZ0ZyPcpCwx88czz2yJutEL3
         RLlqHJ2Q2UMoRDqVjOOdOxjn2KZwIzEPfy82BUaz6HvDaqLI3bV1J6pI3i2nQDrn3gv9
         /dWXBtMeCEYeJA76JBno9WjtJzazxWxfvWdpH6VpM/ATeSRHnkod3ppFSt7eA6BrpV4z
         p6GB0847nfy/4iL3lVKmCYcOOc09r4FLmxGbPUdLyVWp7J6wpJsiA6gHECpmTEE4Mxli
         /jYg==
X-Gm-Message-State: AOAM5333GXiWTM4Ci3NJ3ALo39vvnM2JtOsEroVD/wVc7O/6TcJMhxa7
        ZJxujH5rlO5FN3rg/rzFCjqINA==
X-Google-Smtp-Source: ABdhPJzc93AKyHeS6K7zWxJdqrv7pkOmkEPKPPpfQfpspxPiIl8jo/No84ral2c1mS98kp4huyOz7g==
X-Received: by 2002:ac8:7eee:: with SMTP id r14mr7427193qtc.56.1632855354397;
        Tue, 28 Sep 2021 11:55:54 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id bm27sm15284065qkb.6.2021.09.28.11.55.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 11:55:53 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mVIGe-007Fgc-Tq; Tue, 28 Sep 2021 15:55:52 -0300
Date:   Tue, 28 Sep 2021 15:55:52 -0300
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
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>
Subject: Re: [PATCH v3 04/20] PCI/P2PDMA: introduce helpers for dma_map_sg
 implementations
Message-ID: <20210928185552.GL3544071@ziepe.ca>
References: <20210916234100.122368-1-logang@deltatee.com>
 <20210916234100.122368-5-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916234100.122368-5-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 16, 2021 at 05:40:44PM -0600, Logan Gunthorpe wrote:
> Add pci_p2pdma_map_segment() as a helper for simple dma_map_sg()
> implementations. It takes an scatterlist segment that must point to a
> pci_p2pdma struct page and will map it if the mapping requires a bus
> address.
> 
> The return value indicates whether the mapping required a bus address
> or whether the caller still needs to map the segment normally. If the
> segment should not be mapped, -EREMOTEIO is returned.
> 
> This helper uses a state structure to track the changes to the
> pgmap across calls and avoid needing to lookup into the xarray for
> every page.
> 
> Also add pci_p2pdma_map_bus_segment() which is useful for IOMMU
> dma_map_sg() implementations where the sg segment containing the page
> differs from the sg segment containing the DMA address.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>  drivers/pci/p2pdma.c       | 59 ++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-p2pdma.h | 21 ++++++++++++++
>  2 files changed, 80 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index b656d8c801a7..58c34f1f1473 100644
> +++ b/drivers/pci/p2pdma.c
> @@ -943,6 +943,65 @@ void pci_p2pdma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>  }
>  EXPORT_SYMBOL_GPL(pci_p2pdma_unmap_sg_attrs);
>  
> +/**
> + * pci_p2pdma_map_segment - map an sg segment determining the mapping type
> + * @state: State structure that should be declared outside of the for_each_sg()
> + *	loop and initialized to zero.
> + * @dev: DMA device that's doing the mapping operation
> + * @sg: scatterlist segment to map
> + *
> + * This is a helper to be used by non-iommu dma_map_sg() implementations where
> + * the sg segment is the same for the page_link and the dma_address.
> + *
> + * Attempt to map a single segment in an SGL with the PCI bus address.
> + * The segment must point to a PCI P2PDMA page and thus must be
> + * wrapped in a is_pci_p2pdma_page(sg_page(sg)) check.
> + *
> + * Returns the type of mapping used and maps the page if the type is
> + * PCI_P2PDMA_MAP_BUS_ADDR.
> + */
> +enum pci_p2pdma_map_type
> +pci_p2pdma_map_segment(struct pci_p2pdma_map_state *state, struct device *dev,
> +		       struct scatterlist *sg)
> +{
> +	if (state->pgmap != sg_page(sg)->pgmap) {
> +		state->pgmap = sg_page(sg)->pgmap;
> +		state->map = pci_p2pdma_map_type(state->pgmap, dev);
> +		state->bus_off = to_p2p_pgmap(state->pgmap)->bus_offset;
> +	}

Is this safe? I was just talking with Joao about this,

 https://lore.kernel.org/r/20210928180150.GI3544071@ziepe.ca

API wise I absolutely think this should be safe as written, but is it
really?

Does pgmap ensure that a positive refcount struct page always has a
valid pgmap pointer (and thus the mess in gup can be deleted) or does
this need to get the pgmap as well to keep it alive?

Jason
