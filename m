Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3624E37AB4E
	for <lists+linux-pci@lfdr.de>; Tue, 11 May 2021 18:05:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhEKQGh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 12:06:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34538 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231263AbhEKQGg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 12:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620749129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=te4j0CaO/GGwAePTvy9qf9MhnS54BQnLL/PFFRuQ1v8=;
        b=Tjk9GDoFHru0zETY1y/uUNd80eyvddrw2EVs95oEQiiaC3nbuHPK0vqllPhRsmepEzkju4
        btGthwNWgOObN2YXrkWRnDy/1rbcd1GeSK+eSZ/33en/ybgP15Qix+5cZhH102c0dXcPUM
        ++cSGMN5NG1bB0N127Nldh/rmPprTNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-36MVrBJfO1-KLhYh32wKtA-1; Tue, 11 May 2021 12:05:25 -0400
X-MC-Unique: 36MVrBJfO1-KLhYh32wKtA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2629D805F03;
        Tue, 11 May 2021 16:05:22 +0000 (UTC)
Received: from [10.3.115.19] (ovpn-115-19.phx2.redhat.com [10.3.115.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 895785D9F2;
        Tue, 11 May 2021 16:05:17 +0000 (UTC)
Subject: Re: [PATCH 00/16] Add new DMA mapping operation for P2PDMA
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
From:   Don Dutile <ddutile@redhat.com>
Message-ID: <cc7eab6b-2189-7b6a-d119-d653211cd1fb@redhat.com>
Date:   Tue, 11 May 2021 12:05:16 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20210408170123.8788-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/8/21 1:01 PM, Logan Gunthorpe wrote:
> Hi,
>
> This patchset continues my work to to add P2PDMA support to the common
> dma map operations. This allows for creating SGLs that have both P2PDMA
> and regular pages which is a necessary step to allowing P2PDMA pages in
> userspace.
>
> The earlier RFC[1] generated a lot of great feedback and I heard no show
> stopping objections. Thus, I've incorporated all the feedback and have
> decided to post this as a proper patch series with hopes of eventually
> getting it in mainline.
>
> I'm happy to do a few more passes if anyone has any further feedback
> or better ideas.
>
> This series is based on v5.12-rc6 and a git branch can be found here:
>
>    https://github.com/sbates130272/linux-p2pmem/  p2pdma_map_ops_v1
>
> Thanks,
>
> Logan
>
> [1] https://lore.kernel.org/linux-block/20210311233142.7900-1-logang@deltatee.com/
>
>
> Changes since the RFC:
>   * Added comment and fixed up the pci_get_slot patch. (per Bjorn)
>   * Fixed glaring sg_phys() double offset bug. (per Robin)
>   * Created a new map operation (dma_map_sg_p2pdma()) with a new calling
>     convention instead of modifying the calling convention of
>     dma_map_sg(). (per Robin)
>   * Integrated the two similar pci_p2pdma_dma_map_type() and
>     pci_p2pdma_map_type() functions into one (per Ira)
>   * Reworked some of the logic in the map_sg() implementations into
>     helpers in the p2pdma code. (per Christoph)
>   * Dropped a bunch of unnecessary symbol exports (per Christoph)
>   * Expanded the code in dma_pci_p2pdma_supported() for clarity. (per
>     Ira and Christoph)
>   * Finished off using the new dma_map_sg_p2pdma() call in rdma_rw
>     and removed the old pci_p2pdma_[un]map_sg(). (per Jason)
>
> --
>
> Logan Gunthorpe (16):
>    PCI/P2PDMA: Pass gfp_mask flags to upstream_bridge_distance_warn()
>    PCI/P2PDMA: Avoid pci_get_slot() which sleeps
>    PCI/P2PDMA: Attempt to set map_type if it has not been set
>    PCI/P2PDMA: Refactor pci_p2pdma_map_type() to take pagmap and device
>    dma-mapping: Introduce dma_map_sg_p2pdma()
>    lib/scatterlist: Add flag for indicating P2PDMA segments in an SGL
>    PCI/P2PDMA: Make pci_p2pdma_map_type() non-static
>    PCI/P2PDMA: Introduce helpers for dma_map_sg implementations
>    dma-direct: Support PCI P2PDMA pages in dma-direct map_sg
>    dma-mapping: Add flags to dma_map_ops to indicate PCI P2PDMA support
>    iommu/dma: Support PCI P2PDMA pages in dma-iommu map_sg
>    nvme-pci: Check DMA ops when indicating support for PCI P2PDMA
>    nvme-pci: Convert to using dma_map_sg_p2pdma for p2pdma pages
>    nvme-rdma: Ensure dma support when using p2pdma
>    RDMA/rw: use dma_map_sg_p2pdma()
>    PCI/P2PDMA: Remove pci_p2pdma_[un]map_sg()
>
>   drivers/infiniband/core/rw.c |  50 +++-------
>   drivers/iommu/dma-iommu.c    |  66 ++++++++++--
>   drivers/nvme/host/core.c     |   3 +-
>   drivers/nvme/host/nvme.h     |   2 +-
>   drivers/nvme/host/pci.c      |  39 ++++----
>   drivers/nvme/target/rdma.c   |   3 +-
>   drivers/pci/Kconfig          |   2 +-
>   drivers/pci/p2pdma.c         | 188 +++++++++++++++++++----------------
>   include/linux/dma-map-ops.h  |   3 +
>   include/linux/dma-mapping.h  |  20 ++++
>   include/linux/pci-p2pdma.h   |  53 ++++++----
>   include/linux/scatterlist.h  |  49 ++++++++-
>   include/rdma/ib_verbs.h      |  32 ++++++
>   kernel/dma/direct.c          |  25 ++++-
>   kernel/dma/mapping.c         |  70 +++++++++++--
>   15 files changed, 416 insertions(+), 189 deletions(-)
>
>
> base-commit: e49d033bddf5b565044e2abe4241353959bc9120
> --
> 2.20.1
>
Apologies in the delay to provide feedback; climbing out of several deep trenches at the mother ship :-/

Replying to some directly, and indirectly (mostly through JohH's reply's).

General comments:
1) nits in 1,2,3,5;
    4: I agree w/JohnH & JasonG -- seems like it needs a device-layer that gets to a bus-layer, but I'm wearing my 'broader then PCI' hat in this review; I see a (classic) ChristophH refactoring and cleanup in this area, and wondering if we ought to clean it up now, since CH has done so much to clean it up and make the dma-mapping system so much easier to add/modify/review due to the broad arch (& bus) cleanup that has been done.  If that delays it too much, then add a TODO to do so.
2) 6: yes! let's not worry or even both supporting 32-bit anything wrt p2pdma.
3) 7:nit
4) 8: ok;
5) 9: ditto to JohnH's feedback on added / clearer comment & code flow (if-else).
6) 10: nits; q: should p2pdma mapping go through dma-ops so it is generalized for future interconnects (CXL, GenZ)?
7) 11: It says it is supporting p2pdma in dma-iommu's map_sg, but it seems like it is just leveraging shared code and short-circuiting IOMMU use.
8) 12-14: didn't review; letting the block/nvme/direct-io folks cover this space
9) 15: Looking to JasonG to sanitize
10) 16: cleanup; a-ok.

- DonD

