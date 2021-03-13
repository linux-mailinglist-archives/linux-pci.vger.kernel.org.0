Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE237339B41
	for <lists+linux-pci@lfdr.de>; Sat, 13 Mar 2021 03:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbhCMCce (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 21:32:34 -0500
Received: from mga11.intel.com ([192.55.52.93]:39329 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232878AbhCMCcV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Mar 2021 21:32:21 -0500
IronPort-SDR: ca6+EmFzLB6rn4PfFvmKGdTLSQAKAga6I11OuEQgI/uWudtxaArSF9UQ2010blewnRNoqHE33o
 pcO+kWww8SuA==
X-IronPort-AV: E=McAfee;i="6000,8403,9921"; a="185556890"
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; 
   d="scan'208";a="185556890"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 18:32:21 -0800
IronPort-SDR: BWPKoNFrC0CbvFbvqC7bofsQvJCNTBhJDT+7AoC9cufX1+KLu6FM5vOz8SA4xWlBa1sCU5vqVL
 Ls62JjUfG9ug==
X-IronPort-AV: E=Sophos;i="5.81,245,1610438400"; 
   d="scan'208";a="448805796"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2021 18:32:20 -0800
Date:   Fri, 12 Mar 2021 18:32:20 -0800
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
Subject: Re: [RFC PATCH v2 04/11] PCI/P2PDMA: Introduce
 pci_p2pdma_should_map_bus() and pci_p2pdma_bus_offset()
Message-ID: <20210313023220.GB3402637@iweiny-DESK2.sc.intel.com>
References: <20210311233142.7900-1-logang@deltatee.com>
 <20210311233142.7900-5-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311233142.7900-5-logang@deltatee.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 11, 2021 at 04:31:34PM -0700, Logan Gunthorpe wrote:
> Introduce pci_p2pdma_should_map_bus() which is meant to be called by
            ^^^^^^^^^^^^^^^^^^^^^^^^^
	    pci_p2pdma_dma_map_type() ???

FWIW I find this name confusing with pci_p2pdma_map_type() and looking at the
implementation I'm not clear why pci_p2pdma_dma_map_type() needs to exist?

Ira

[snip]

> +
> +/**
> + * pci_p2pdma_dma_map_type - determine if a DMA mapping should use the
> + *	bus address, be mapped normally or fail
> + * @dev: device doing the DMA request
> + * @pgmap: dev_pagemap structure for the mapping
> + *
> + * Returns:
> + *    1 - if the page should be mapped with a bus address,
> + *    0 - if the page should be mapped normally through an IOMMU mapping or
> + *        physical address; or
> + *   -1 - if the device should not map the pages and an error should be
> + *        returned
> + */
> +int pci_p2pdma_dma_map_type(struct device *dev, struct dev_pagemap *pgmap)
> +{
> +	struct pci_p2pdma_pagemap *p2p_pgmap = to_p2p_pgmap(pgmap);
> +	struct pci_dev *client;
> +
> +	if (!dev_is_pci(dev))
> +		return -1;
> +
> +	client = to_pci_dev(dev);
> +
> +	switch (pci_p2pdma_map_type(p2p_pgmap->provider, client)) {
> +	case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE:
> +		return 0;
> +	case PCI_P2PDMA_MAP_BUS_ADDR:
> +		return 1;
> +	default:
> +		return -1;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(pci_p2pdma_dma_map_type);

I guess the main point here is to export this to the DMA layer?

Ira
