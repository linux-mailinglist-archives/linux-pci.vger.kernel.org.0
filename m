Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB944380ABA
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 15:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbhENNwl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 May 2021 09:52:41 -0400
Received: from verein.lst.de ([213.95.11.211]:50586 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229927AbhENNwl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 May 2021 09:52:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2C7076736F; Fri, 14 May 2021 15:51:26 +0200 (CEST)
Date:   Fri, 14 May 2021 15:51:26 +0200
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
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 08/22] dma-mapping: Allow map_sg() ops to return
 negative error codes
Message-ID: <20210514135126.GB4715@lst.de>
References: <20210513223203.5542-1-logang@deltatee.com> <20210513223203.5542-9-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210513223203.5542-9-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

> +int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>  		enum dma_data_direction dir, unsigned long attrs);

I don't think it makes sense to expose this __dma_map_sg_attrs helper.
Just keep it static and move the sgtable helper to kernel/dma/mapping.c
as well.
