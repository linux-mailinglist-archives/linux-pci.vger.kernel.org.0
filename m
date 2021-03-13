Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F5A339B53
	for <lists+linux-pci@lfdr.de>; Sat, 13 Mar 2021 03:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231679AbhCMCh2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 21:37:28 -0500
Received: from mga06.intel.com ([134.134.136.31]:47383 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233086AbhCMCg7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Mar 2021 21:36:59 -0500
IronPort-SDR: cJORzfneF+E1h6BVEedk2B31mPGAkpZmaKvhxZLRM+7QZ0kgVQRWom2LxJg/V06Maxa9TM9wrd
 522Po48FfejA==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="250281130"
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; 
   d="scan'208";a="250281130"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 18:36:58 -0800
IronPort-SDR: vWH9MrQPUopS4cxXwdJS5su75dKHztdNXjGGlH9ufjynLLu86PmrmvGK6dqQ7nNaiN1giHbb0p
 Ed7tLl9U/OgQ==
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; 
   d="scan'208";a="404614708"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 18:36:57 -0800
Date:   Fri, 12 Mar 2021 18:36:57 -0800
From:   Ira Weiny <ira.weiny@intel.com>
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
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>
Subject: Re: [RFC PATCH v2 07/11] dma-mapping: Add flags to dma_map_ops to
 indicate PCI P2PDMA support
Message-ID: <20210313023657.GC3402637@iweiny-DESK2.sc.intel.com>
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-8-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311233142.7900-8-logang@deltatee.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 11, 2021 at 04:31:37PM -0700, Logan Gunthorpe wrote:
 
> +int dma_pci_p2pdma_supported(struct device *dev)
   ^^^
  bool?

> +{
> +	const struct dma_map_ops *ops = get_dma_ops(dev);
> +
> +	return !ops || ops->flags & DMA_F_PCI_P2PDMA_SUPPORTED;

Is this logic correct?  I would have expected.

	return (ops && ops->flags & DMA_F_PCI_P2PDMA_SUPPORTED);

Ira
