Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAD4A47CE00
	for <lists+linux-pci@lfdr.de>; Wed, 22 Dec 2021 09:22:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243278AbhLVIWP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Dec 2021 03:22:15 -0500
Received: from verein.lst.de ([213.95.11.211]:49648 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243282AbhLVIWP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Dec 2021 03:22:15 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0144B68B05; Wed, 22 Dec 2021 09:22:10 +0100 (CET)
Date:   Wed, 22 Dec 2021 09:22:09 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
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
Message-ID: <20211222082209.GA22606@lst.de>
References: <20211117215410.3695-1-logang@deltatee.com> <20211117215410.3695-2-logang@deltatee.com> <20211221090003.GA7949@lst.de> <05095125-464e-4e85-f609-c7bc93d2f479@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05095125-464e-4e85-f609-c7bc93d2f479@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 21, 2021 at 10:23:24AM -0700, Logan Gunthorpe wrote:
> > scatterlist.h doesn't have a real maintainer, do you want me to pick
> > this up through the DMA tree?
> 
> Sure, that would be great!

Done.
