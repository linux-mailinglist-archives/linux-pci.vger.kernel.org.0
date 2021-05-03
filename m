Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E528F371FC1
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 20:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhECSgI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 14:36:08 -0400
Received: from verein.lst.de ([213.95.11.211]:36759 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229603AbhECSgH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 3 May 2021 14:36:07 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id A773768B05; Mon,  3 May 2021 20:35:09 +0200 (CEST)
Date:   Mon, 3 May 2021 20:35:09 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
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
Subject: Re: [PATCH 03/16] PCI/P2PDMA: Attempt to set map_type if it has
 not been set
Message-ID: <20210503183509.GA17971@lst.de>
References: <20210408170123.8788-1-logang@deltatee.com> <20210408170123.8788-4-logang@deltatee.com> <3834be62-3d1b-fc98-d793-e7dcb0a74624@nvidia.com> <a1b6ffa9-7a9c-753f-6350-5ea26506cdc3@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1b6ffa9-7a9c-753f-6350-5ea26506cdc3@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 03, 2021 at 10:17:59AM -0600, Logan Gunthorpe wrote:
> I agree that some of this has evolved in a way that some of the names
> are a bit odd now. Could definitely use a cleanup, but that's not really
> part of this series. When I have some time I can look at doing a cleanup
> series to help with some of this.

I think adding it to the series would be very helpful.
