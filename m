Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBED47BC4F
	for <lists+linux-pci@lfdr.de>; Tue, 21 Dec 2021 10:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234177AbhLUJAM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Dec 2021 04:00:12 -0500
Received: from verein.lst.de ([213.95.11.211]:45969 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233983AbhLUJAM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Dec 2021 04:00:12 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7A18568AFE; Tue, 21 Dec 2021 10:00:04 +0100 (CET)
Date:   Tue, 21 Dec 2021 10:00:03 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
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
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v4 01/23] lib/scatterlist: cleanup macros into static
 inline functions
Message-ID: <20211221090003.GA7949@lst.de>
References: <20211117215410.3695-1-logang@deltatee.com> <20211117215410.3695-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117215410.3695-2-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 17, 2021 at 02:53:48PM -0700, Logan Gunthorpe wrote:
> Convert the sg_is_chain(), sg_is_last() and sg_chain_ptr() macros
> into static inline functions. There's no reason for these to be macros
> and static inline are generally preferred these days.
> 
> Also introduce the SG_PAGE_LINK_MASK define so the P2PDMA work, which is
> adding another bit to this mask, can do so more easily.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Looks fine:

Reviewed-by: Christoph Hellwig <hch@lst.de>

scatterlist.h doesn't have a real maintainer, do you want me to pick
this up through the DMA tree?
