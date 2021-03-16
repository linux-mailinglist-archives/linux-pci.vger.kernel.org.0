Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F01D33CF0A
	for <lists+linux-pci@lfdr.de>; Tue, 16 Mar 2021 08:59:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbhCPH6d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Mar 2021 03:58:33 -0400
Received: from verein.lst.de ([213.95.11.211]:58866 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234079AbhCPH6Z (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 16 Mar 2021 03:58:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 677A768C65; Tue, 16 Mar 2021 08:58:22 +0100 (CET)
Date:   Tue, 16 Mar 2021 08:58:21 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux-foundation.org,
        Minturn Dave B <dave.b.minturn@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        Stephen Bates <sbates@raithlin.com>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Xiong Jianxin <jianxin.xiong@intel.com>
Subject: Re: [RFC PATCH v2 06/11] dma-direct: Support PCI P2PDMA pages in
 dma-direct map_sg
Message-ID: <20210316075821.GB15949@lst.de>
References: <20210311233142.7900-1-logang@deltatee.com> <20210311233142.7900-7-logang@deltatee.com> <215e1472-5294-d20a-a43a-ff6dfe8cd66e@arm.com> <d7ead722-7356-8e0f-22de-cb9dea12b556@deltatee.com> <a8205c02-a43f-d4e8-a9fe-5963df3a7b40@arm.com> <367fa81e-588d-5734-c69c-8cdc800dcb7e@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <367fa81e-588d-5734-c69c-8cdc800dcb7e@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 12, 2021 at 11:27:46AM -0700, Logan Gunthorpe wrote:
> So then we reject the patches that make that change. Seems like an odd
> argument to say that we can't do something that won't cause problems
> because someone might use it as an example and do something that will
> cause problems. Reject the change that causes the problem.

No, the problem is a mess of calling conventions.  A calling convention
returning 0 for error, positive values for success is fine.  One returning
a negative errno for error and positive values for success is fine a well.
One returning 0 for the usual errors and negativ errnos for an unusual
corner case is just a complete mess.
