Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0DBD2AB34A
	for <lists+linux-pci@lfdr.de>; Mon,  9 Nov 2020 10:13:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbgKIJNB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Nov 2020 04:13:01 -0500
Received: from verein.lst.de ([213.95.11.211]:57665 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726482AbgKIJNB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Nov 2020 04:13:01 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8929268AFE; Mon,  9 Nov 2020 10:12:58 +0100 (CET)
Date:   Mon, 9 Nov 2020 10:12:58 +0100
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
Subject: Re: [RFC PATCH 04/15] lib/scatterlist: Add flag for indicating
 P2PDMA segments in an SGL
Message-ID: <20201109091258.GB28918@lst.de>
References: <20201106170036.18713-1-logang@deltatee.com> <20201106170036.18713-5-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106170036.18713-5-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 06, 2020 at 10:00:25AM -0700, Logan Gunthorpe wrote:
> We make use of the top bit of the dma_length to indicate a P2PDMA
> segment.

I don't think "we" can.  There is nothing limiting the size of a SGL
segment.
