Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E945633CF1E
	for <lists+linux-pci@lfdr.de>; Tue, 16 Mar 2021 09:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233834AbhCPIAm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Mar 2021 04:00:42 -0400
Received: from verein.lst.de ([213.95.11.211]:58883 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231510AbhCPIAR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Mar 2021 04:00:17 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 75A4D68C4E; Tue, 16 Mar 2021 09:00:09 +0100 (CET)
Date:   Tue, 16 Mar 2021 09:00:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>
Subject: Re: [RFC PATCH v2 07/11] dma-mapping: Add flags to dma_map_ops to
 indicate PCI P2PDMA support
Message-ID: <20210316080008.GC15949@lst.de>
References: <20210311233142.7900-1-logang@deltatee.com> <20210311233142.7900-8-logang@deltatee.com> <20210313023657.GC3402637@iweiny-DESK2.sc.intel.com> <e9a6689a-3cb7-aa30-33e7-b27015754b73@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9a6689a-3cb7-aa30-33e7-b27015754b73@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 15, 2021 at 10:33:13AM -0600, Logan Gunthorpe wrote:
> >> +	return !ops || ops->flags & DMA_F_PCI_P2PDMA_SUPPORTED;
> > 
> > Is this logic correct?  I would have expected.
> > 
> > 	return (ops && ops->flags & DMA_F_PCI_P2PDMA_SUPPORTED);
> 
> 
> If ops is NULL then the operations in kernel/dma/direct.c are used and
> support is added to those in patch 6. So it is correct as written.

It is not quite that easy. There also is the bypass flag and for the
specific case where that is ignored the code needs a really good
comment.  And to assist that formatted so that it makes sense.  The
above line is indeed highly confusing even if it ends up being correct.
