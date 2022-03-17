Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1285D4DCC86
	for <lists+linux-pci@lfdr.de>; Thu, 17 Mar 2022 18:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbiCQReB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Mar 2022 13:34:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236923AbiCQReB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Mar 2022 13:34:01 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BF92156C7;
        Thu, 17 Mar 2022 10:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647538364; x=1679074364;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+HAWrZsfheXDVLPHx4rCRyJeP+W33AP9BKwAIeOEOhA=;
  b=B5Bamhg3b1IGeYRKR1pwrTCV51JUst1Lh3cg4/YJ1lHxmVdiAeAUvnbj
   6LjbfQRN5SoheGMAR/ULVv9Pz1W9f3mV0Huwie5flcTOlxUQ+oYf46mb6
   kj4SpnQ7P2H2UYhGC2BNO/3YvaPAEwXvvAVR0NNFH0Tsi4FQuPeh5RJTZ
   mImzGksNw8UM2xsGaaXAZSFnbv7xzUcHix0UPLUZnYW00MZQ1cTBWJDg0
   fATpNZ9BEDU7hrwNKO/TfDpo83X4pXkFDBdXKcS3dtgU+EpoLyk0gectr
   cr9Krk6UltUIUaCY4YyqTk/60CtgaKhAXjddPNytQk+ndyNKiQU70lF5V
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="239090755"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="239090755"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 10:32:40 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="691014559"
Received: from dshkut-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.132.229])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 10:32:40 -0700
Date:   Thu, 17 Mar 2022 10:32:33 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, vishal.l.verma@intel.com,
        alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
        ira.weiny@intel.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH 6/8] cxl/pci: Prepare for mapping RAS Capability Structure
Message-ID: <20220317173233.w76rkwyd2tzunltd@intel.com>
References: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164740405408.3912056.16337643017370667205.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164740405408.3912056.16337643017370667205.stgit@dwillia2-desk3.amr.corp.intel.com>
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-03-15 21:14:14, Dan Williams wrote:
> The RAS Capabilitiy Structure is a CXL Component register capability
> block. Unlike the HDM Decoder Capability, it will be referenced by the
> cxl_pci driver in response to PCIe AER events. Due to this it is no
> longer the case that cxl_map_component_regs() can assume that it should
> map all component registers. Plumb a bitmask of capability ids to map
> through cxl_map_component_regs().
> 
> For symmetry cxl_probe_device_regs() is updated to populate @id in
> 'struct cxl_reg_map' even though cxl_map_device_regs() does not have a
> need to map a subset of the device registers per caller.

This seems weird to me. You spent the first 4 or so patches consolidating the
mapping into a nice loop only to break out an ID to do individual mappings
again. Are you sure this is such a win over having discrete mapping functions?

> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/hdm.c  |    3 ++-
>  drivers/cxl/core/regs.c |   36 ++++++++++++++++++++++++++----------
>  drivers/cxl/cxl.h       |    7 ++++---
>  3 files changed, 32 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 09221afca309..b348217ab704 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -92,7 +92,8 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
>  		return -ENXIO;
>  	}
>  
> -	return cxl_map_component_regs(&port->dev, regs, &map);
> +	return cxl_map_component_regs(&port->dev, regs, &map,
> +				      BIT(CXL_CM_CAP_CAP_ID_HDM));
>  }
>  
>  /**
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 219c7d0e43e2..c022c8937dfc 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -92,6 +92,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  		if (!rmap)
>  			continue;
>  		rmap->valid = true;
> +		rmap->id = cap_id;
>  		rmap->offset = CXL_CM_OFFSET + offset;
>  		rmap->size = length;
>  	}
> @@ -159,6 +160,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  		if (!rmap)
>  			continue;
>  		rmap->valid = true;
> +		rmap->id = cap_id;
>  		rmap->offset = offset;
>  		rmap->size = length;
>  	}
> @@ -187,17 +189,31 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>  }
>  
>  int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
> -			   struct cxl_register_map *map)
> +			   struct cxl_register_map *map, unsigned long map_mask)
>  {
> -	resource_size_t phys_addr;
> -	resource_size_t length;
> -
> -	phys_addr = map->resource;
> -	phys_addr += map->component_map.hdm_decoder.offset;
> -	length = map->component_map.hdm_decoder.size;
> -	regs->hdm_decoder = devm_cxl_iomap_block(dev, phys_addr, length);
> -	if (!regs->hdm_decoder)
> -		return -ENOMEM;
> +	struct mapinfo {
> +		struct cxl_reg_map *rmap;
> +		void __iomem **addr;
> +	} mapinfo[] = {
> +		{ .rmap = &map->component_map.hdm_decoder, &regs->hdm_decoder },
> +	};
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(mapinfo); i++) {
> +		struct mapinfo *mi = &mapinfo[i];
> +		resource_size_t phys_addr;
> +		resource_size_t length;
> +
> +		if (!mi->rmap->valid)
> +			continue;
> +		if (!test_bit(mi->rmap->id, &map_mask))
> +			continue;
> +		phys_addr = map->resource + mi->rmap->offset;
> +		length = mi->rmap->size;
> +		*(mi->addr) = devm_cxl_iomap_block(dev, phys_addr, length);
> +		if (!*(mi->addr))
> +			return -ENOMEM;
> +	}
>  
>  	return 0;
>  }
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 2080a75c61fe..52bd77d8e22a 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -115,6 +115,7 @@ struct cxl_regs {
>  
>  struct cxl_reg_map {
>  	bool valid;
> +	int id;
>  	unsigned long offset;
>  	unsigned long size;
>  };
> @@ -153,9 +154,9 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  			      struct cxl_component_reg_map *map);
>  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  			   struct cxl_device_reg_map *map);
> -int cxl_map_component_regs(struct device *dev,
> -			   struct cxl_component_regs *regs,
> -			   struct cxl_register_map *map);
> +int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
> +			   struct cxl_register_map *map,
> +			   unsigned long map_mask);
>  int cxl_map_device_regs(struct device *dev,
>  			struct cxl_device_regs *regs,
>  			struct cxl_register_map *map);
> 
