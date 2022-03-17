Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09EAF4DC45B
	for <lists+linux-pci@lfdr.de>; Thu, 17 Mar 2022 11:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232776AbiCQK6V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Mar 2022 06:58:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232774AbiCQK6U (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Mar 2022 06:58:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D68DE1DFDF2;
        Thu, 17 Mar 2022 03:57:03 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KK3wW6RjWz67jS1;
        Thu, 17 Mar 2022 18:56:11 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 17 Mar 2022 11:57:01 +0100
Received: from localhost (10.47.67.192) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 10:57:01 +0000
Date:   Thu, 17 Mar 2022 10:56:59 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ben.widawsky@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <ira.weiny@intel.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 6/8] cxl/pci: Prepare for mapping RAS Capability
 Structure
Message-ID: <20220317105659.000075fc@Huawei.com>
In-Reply-To: <164740405408.3912056.16337643017370667205.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164740405408.3912056.16337643017370667205.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.67.192]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 15 Mar 2022 21:14:14 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

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

I guess it doesn't hurt to add that, though without the mask being
passed into appropriate functions it's a bit pointless.  What we have
is now 'half symmetric' perhaps.

> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
A few trivial comments inline, but basically looks good to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

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

Maybe pass an unsigned long *map_mask from the start for the inevitable
capability IDs passing the minimum length of a long?
Disadvantage being you'll need to roll a local BITMAP to pass in at all callsites.

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

As in previous instance, mixing two styles of assignment seems odd.

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

Worth the rewrapping and extra diff as a result?  (I think it's precisely 80 chars)

> +			   struct cxl_register_map *map,
> +			   unsigned long map_mask);
>  int cxl_map_device_regs(struct device *dev,
>  			struct cxl_device_regs *regs,
>  			struct cxl_register_map *map);
> 

