Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99392427EB4
	for <lists+linux-pci@lfdr.de>; Sun, 10 Oct 2021 06:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbhJJEW4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 10 Oct 2021 00:22:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:15543 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229645AbhJJEW4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 10 Oct 2021 00:22:56 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10132"; a="226994330"
X-IronPort-AV: E=Sophos;i="5.85,361,1624345200"; 
   d="scan'208";a="226994330"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2021 21:20:57 -0700
X-IronPort-AV: E=Sophos;i="5.85,361,1624345200"; 
   d="scan'208";a="658231268"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2021 21:20:56 -0700
Date:   Sat, 9 Oct 2021 21:20:56 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH v3 06/10] cxl/pci: Add @base to cxl_register_map
Message-ID: <20211010042056.GJ3114988@iweiny-DESK2.sc.intel.com>
References: <163379783658.692348.16064992154261275220.stgit@dwillia2-desk3.amr.corp.intel.com>
 <163379786922.692348.2318044990911111834.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163379786922.692348.2318044990911111834.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 09, 2021 at 09:44:29AM -0700, Dan Williams wrote:
> In addition to carrying @barno, @block_offset, and @reg_type, add @base
> to keep all map/unmap parameters in one object. The helpers
> cxl_{map,unmap}_regblock() handle adjusting @base to the @block_offset
> at map and unmap time.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/cxl.h |    1 +
>  drivers/cxl/pci.c |   31 ++++++++++++++++---------------
>  2 files changed, 17 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index a6687e7fd598..7cd16ef144dd 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -140,6 +140,7 @@ struct cxl_device_reg_map {
>  };
>  
>  struct cxl_register_map {
> +	void __iomem *base;
>  	u64 block_offset;
>  	u8 reg_type;
>  	u8 barno;
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 9f006299a0e3..b42407d067ac 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -306,8 +306,7 @@ static int cxl_pci_setup_mailbox(struct cxl_mem *cxlm)
>  	return 0;
>  }
>  
> -static void __iomem *cxl_pci_map_regblock(struct pci_dev *pdev,
> -					  struct cxl_register_map *map)
> +static int cxl_map_regblock(struct pci_dev *pdev, struct cxl_register_map *map)
>  {
>  	void __iomem *addr;
>  	int bar = map->barno;
> @@ -318,24 +317,27 @@ static void __iomem *cxl_pci_map_regblock(struct pci_dev *pdev,
>  	if (pci_resource_len(pdev, bar) < offset) {
>  		dev_err(dev, "BAR%d: %pr: too small (offset: %#llx)\n", bar,
>  			&pdev->resource[bar], (unsigned long long)offset);
> -		return NULL;
> +		return -ENXIO;
>  	}
>  
>  	addr = pci_iomap(pdev, bar, 0);
>  	if (!addr) {
>  		dev_err(dev, "failed to map registers\n");
> -		return addr;
> +		return -ENOMEM;
>  	}
>  
>  	dev_dbg(dev, "Mapped CXL Memory Device resource bar %u @ %#llx\n",
>  		bar, offset);
>  
> -	return addr;
> +	map->base = addr + map->block_offset;
> +	return 0;
>  }
>  
> -static void cxl_pci_unmap_regblock(struct pci_dev *pdev, void __iomem *base)
> +static void cxl_unmap_regblock(struct pci_dev *pdev,
> +			       struct cxl_register_map *map)
>  {
> -	pci_iounmap(pdev, base);
> +	pci_iounmap(pdev, map->base - map->block_offset);

I know we need to get these in soon.  But I think map->base should be 'base'
and map->block_offset should be handled in cxl_probe_regs() rather than
subtract it here..

Either way this is cleaner than what it was.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> +	map->base = NULL;
>  }
>  
>  static int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec)
> @@ -361,12 +363,12 @@ static int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec)
>  	return 0;
>  }
>  
> -static int cxl_probe_regs(struct pci_dev *pdev, void __iomem *base,
> -			  struct cxl_register_map *map)
> +static int cxl_probe_regs(struct pci_dev *pdev, struct cxl_register_map *map)
>  {
>  	struct cxl_component_reg_map *comp_map;
>  	struct cxl_device_reg_map *dev_map;
>  	struct device *dev = &pdev->dev;
> +	void __iomem *base = map->base;
>  
>  	switch (map->reg_type) {
>  	case CXL_REGLOC_RBI_COMPONENT:
> @@ -442,7 +444,6 @@ static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
>   */
>  static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
>  {
> -	void __iomem *base;
>  	u32 regloc_size, regblocks;
>  	int regloc, i, n_maps, ret = 0;
>  	struct device *dev = cxlm->dev;
> @@ -475,12 +476,12 @@ static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
>  		if (map->reg_type > CXL_REGLOC_RBI_MEMDEV)
>  			continue;
>  
> -		base = cxl_pci_map_regblock(pdev, map);
> -		if (!base)
> -			return -ENOMEM;
> +		ret = cxl_map_regblock(pdev, map);
> +		if (ret)
> +			return ret;
>  
> -		ret = cxl_probe_regs(pdev, base + map->block_offset, map);
> -		cxl_pci_unmap_regblock(pdev, base);
> +		ret = cxl_probe_regs(pdev, map);
> +		cxl_unmap_regblock(pdev, map);
>  		if (ret)
>  			return ret;
>  
> 
