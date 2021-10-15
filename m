Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43BD42F815
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 18:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241302AbhJOQ3n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 12:29:43 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3985 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241277AbhJOQ3m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 12:29:42 -0400
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HWBRK1snbz67bX1;
        Sat, 16 Oct 2021 00:23:57 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 15 Oct 2021 18:27:33 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 15 Oct
 2021 17:27:33 +0100
Date:   Fri, 15 Oct 2021 17:27:32 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hch@lst.de>
Subject: Re: [PATCH v3 06/10] cxl/pci: Add @base to cxl_register_map
Message-ID: <20211015172732.000012fc@Huawei.com>
In-Reply-To: <163379786922.692348.2318044990911111834.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163379783658.692348.16064992154261275220.stgit@dwillia2-desk3.amr.corp.intel.com>
        <163379786922.692348.2318044990911111834.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 9 Oct 2021 09:44:29 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> In addition to carrying @barno, @block_offset, and @reg_type, add @base
> to keep all map/unmap parameters in one object. The helpers
> cxl_{map,unmap}_regblock() handle adjusting @base to the @block_offset
> at map and unmap time.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

I don't really mind them, but why the renames
from cxl_pci_* to cxl_* ?

Jonathan
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

