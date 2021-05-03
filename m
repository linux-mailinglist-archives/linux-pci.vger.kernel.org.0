Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD172371FA3
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 20:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbhECS3M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 14:29:12 -0400
Received: from verein.lst.de ([213.95.11.211]:36724 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229870AbhECS3K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 May 2021 14:29:10 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 16D2068BEB; Mon,  3 May 2021 20:28:12 +0200 (CEST)
Date:   Mon, 3 May 2021 20:28:11 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
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
Subject: Re: [PATCH 05/16] dma-mapping: Introduce dma_map_sg_p2pdma()
Message-ID: <20210503182811.GC17174@lst.de>
References: <20210408170123.8788-1-logang@deltatee.com> <20210408170123.8788-6-logang@deltatee.com> <20210427193157.GQ2047089@ziepe.ca> <3c9ba6df-750a-3847-f1fc-8e41f533d1a2@deltatee.com> <20210427230113.GV2047089@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210427230113.GV2047089@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 27, 2021 at 08:01:13PM -0300, Jason Gunthorpe wrote:
> At a high level I'm OK with it. dma_map_sg_attrs() is the extra
> extended version of dma_map_sg(), it already has a different
> signature, a different return code is not out of the question.
> 
> dma_map_sg() is just the simple easy to use interface that can't do
> advanced stuff.
> 
> > I'm not that opposed to this. But it will make this series a fair bit
> > longer to change the 8 map_sg_attrs() usages.
> 
> Yes, but the result seems much nicer to not grow the DMA API further.

We already have a mapping function that can return errors:
dma_map_sgtable.

I think it might make more sense to piggy back on that, as the sg_table
abstraction is pretty useful basically everywhere that we deal with
scatterlists anyway.

In the hopefully no too long run I plan to get rid of scatterlists in
at least NVMe and other high performance devices anyway.
