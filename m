Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717EF2AB342
	for <lists+linux-pci@lfdr.de>; Mon,  9 Nov 2020 10:12:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728335AbgKIJMK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Nov 2020 04:12:10 -0500
Received: from verein.lst.de ([213.95.11.211]:57655 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgKIJMK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Nov 2020 04:12:10 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 52E0D6736F; Mon,  9 Nov 2020 10:12:06 +0100 (CET)
Date:   Mon, 9 Nov 2020 10:12:06 +0100
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
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [RFC PATCH 01/15] PCI/P2PDMA: Don't sleep in
 upstream_bridge_distance_warn()
Message-ID: <20201109091206.GA28918@lst.de>
References: <20201106170036.18713-1-logang@deltatee.com> <20201106170036.18713-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106170036.18713-2-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 06, 2020 at 10:00:22AM -0700, Logan Gunthorpe wrote:
> In order to call this function from a dma_map function, it must not sleep.
> The only reason it does sleep so to allocate the seqbuf to print
> which devices are within the ACS path.
> 
> Switch the kmalloc call to use GFP_NOWAIT and simply not print that
> message if the buffer fails to be allocated.

Please pass in the actual gfp_t.  Especially from an I/O path
GFP_NOWAIT is not the right gfp_t anyway, you probably want GFP_ATOMIC
there.  But also for the path where we can sleep we should allow that.
