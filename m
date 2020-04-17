Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBA91AD680
	for <lists+linux-pci@lfdr.de>; Fri, 17 Apr 2020 08:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgDQGzv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Apr 2020 02:55:51 -0400
Received: from verein.lst.de ([213.95.11.211]:55961 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728075AbgDQGzv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Apr 2020 02:55:51 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D96E868BEB; Fri, 17 Apr 2020 08:55:48 +0200 (CEST)
Date:   Fri, 17 Apr 2020 08:55:48 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     linux-pci@vger.kernel.org, hch@lst.de, fbarrat@linux.ibm.com,
        clsoto@us.ibm.com, idanw@mellanox.com, aneela@mellanox.com,
        shlomin@mellanox.com
Subject: Re: [PATCH 1/2] powerpc/dma: Define map/unmap mmio resource
 callbacks
Message-ID: <20200417065548.GB18880@lst.de>
References: <20200416165725.206741-1-maxg@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416165725.206741-1-maxg@mellanox.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

>  		dma_direct_unmap_sg(dev, sglist, nelems, direction, attrs);
>  }
>  
> +static dma_addr_t dma_iommu_map_resource(struct device *dev,
> +					 phys_addr_t phys_addr, size_t size,
> +					 enum dma_data_direction dir,
> +					 unsigned long attrs)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct pci_controller *phb = pci_bus_to_host(pdev->bus);
> +
> +	if (dma_iommu_map_bypass(dev, attrs)) {
> +		if (phb->controller_ops.dma_map_resource &&
> +		    phb->controller_ops.dma_map_resource(pdev, phys_addr, size,
> +							 dir))
> +			return DMA_MAPPING_ERROR;
> +		return dma_direct_map_resource(dev, phys_addr, size,
> +					       dir, attrs);
> +	}
> +	return DMA_MAPPING_ERROR;

Just a nitpick, but to the return errors early would be a much more
logical flow.  Also if the callback just decides if the mapping is
possible in bypass mode it should have that in the name:

	struct pci_controller_ops *ops = &phb->controller_ops;

	if (!dma_iommu_map_bypass(dev, attrs) ||
	    !ops->dma_can_direct_map_resource ||
	    !ops->dma_can_direct_map_resource(pdev, phys_addr, size, dir)
		return DMA_MAPPING_ERROR;
	return dma_direct_map_resource(dev, phys_addr, size, dir, attrs);

> +	if (dma_iommu_map_bypass(dev, attrs)) {
> +		if (phb->controller_ops.dma_unmap_resource)
> +			phb->controller_ops.dma_unmap_resource(pdev, dma_handle,
> +							size, dir);
> +	}

This can do a little early return as well, coupled with a WARN_ON_ONCE
as we should never end up in the unmap path for a setup where the map didn't
work.
