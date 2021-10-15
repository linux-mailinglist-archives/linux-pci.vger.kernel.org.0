Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F29F42F886
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 18:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241534AbhJOQrH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 12:47:07 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3987 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241546AbhJOQqn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 12:46:43 -0400
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HWBqj5665z67PhJ;
        Sat, 16 Oct 2021 00:41:37 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 15 Oct 2021 18:44:35 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 15 Oct
 2021 17:44:34 +0100
Date:   Fri, 15 Oct 2021 17:44:33 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hch@lst.de>
Subject: Re: [PATCH v3 07/10] cxl/pci: Split cxl_pci_setup_regs()
Message-ID: <20211015174433.0000368a@Huawei.com>
In-Reply-To: <163379787433.692348.2451270397309803556.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163379783658.692348.16064992154261275220.stgit@dwillia2-desk3.amr.corp.intel.com>
        <163379787433.692348.2451270397309803556.stgit@dwillia2-desk3.amr.corp.intel.com>
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

On Sat, 9 Oct 2021 09:44:34 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> From: Ben Widawsky <ben.widawsky@intel.com>
> 
> In preparation for moving parts of register mapping to cxl_core, split

Ah. Guess this planned move is why the naming change in the earlier patch.
Fair enough, but perhaps call it out there as well as here.

No comments to add to this one.

> cxl_pci_setup_regs() into a helper that finds register blocks,
> (cxl_find_regblock()), and a generic wrapper that probes the precise
> register sets within a block (cxl_setup_regs()).
> 
> Move the actual mapping (cxl_map_regs()) of the only register-set that
> cxl_pci cares about (memory device registers) up a level from the former
> cxl_pci_setup_regs() into cxl_pci_probe().
> 
> With this change the unused component registers are no longer mapped,
> but the helpers are primed to move into the core.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> [djbw: rebase on the cxl_register_map refactor]
> [djbw: drop cxl_map_regs() for component registers]
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/pci.c |   73 +++++++++++++++++++++++++++--------------------------
>  1 file changed, 37 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index b42407d067ac..b6bc8e5ca028 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -433,72 +433,69 @@ static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
>  }
>  
>  /**
> - * cxl_pci_setup_regs() - Setup necessary MMIO.
> - * @cxlm: The CXL memory device to communicate with.
> + * cxl_find_regblock() - Locate register blocks by type
> + * @pdev: The CXL PCI device to enumerate.
> + * @type: Register Block Indicator id
> + * @map: Enumeration output, clobbered on error
>   *
> - * Return: 0 if all necessary registers mapped.
> + * Return: 0 if register block enumerated, negative error code otherwise
>   *
> - * A memory device is required by spec to implement a certain set of MMIO
> - * regions. The purpose of this function is to enumerate and map those
> - * registers.
> + * A CXL DVSEC may additional point one or more register blocks, search

may point to one or more...
(perhaps - I'm not quite sure of the intended meaning)

> + * for them by @type.
>   */
> -static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
> +static int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> +			     struct cxl_register_map *map)
>  {
>  	u32 regloc_size, regblocks;
> -	int regloc, i, n_maps, ret = 0;
> -	struct device *dev = cxlm->dev;
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -	struct cxl_register_map *map, maps[CXL_REGLOC_RBI_TYPES];
> +	int regloc, i;
>  
>  	regloc = cxl_pci_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID);
> -	if (!regloc) {
> -		dev_err(dev, "register location dvsec not found\n");
> +	if (!regloc)
>  		return -ENXIO;
> -	}
>  
> -	/* Get the size of the Register Locator DVSEC */
>  	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
>  	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
>  
>  	regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
>  	regblocks = (regloc_size - PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET) / 8;
>  
> -	for (i = 0, n_maps = 0; i < regblocks; i++, regloc += 8) {
> +	for (i = 0; i < regblocks; i++, regloc += 8) {
>  		u32 reg_lo, reg_hi;
>  
>  		pci_read_config_dword(pdev, regloc, &reg_lo);
>  		pci_read_config_dword(pdev, regloc + 4, &reg_hi);
>  
> -		map = &maps[n_maps];
>  		cxl_decode_regblock(reg_lo, reg_hi, map);
>  
> -		/* Ignore unknown register block types */
> -		if (map->reg_type > CXL_REGLOC_RBI_MEMDEV)
> -			continue;
> +		if (map->reg_type == type)
> +			return 0;
> +	}
>  
> -		ret = cxl_map_regblock(pdev, map);
> -		if (ret)
> -			return ret;
> +	return -ENODEV;
> +}
>  
> -		ret = cxl_probe_regs(pdev, map);
> -		cxl_unmap_regblock(pdev, map);
> -		if (ret)
> -			return ret;
> +static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> +			  struct cxl_register_map *map)
> +{
> +	int rc;
>  
> -		n_maps++;
> -	}
> +	rc = cxl_find_regblock(pdev, type, map);
> +	if (rc)
> +		return rc;
>  
> -	for (i = 0; i < n_maps; i++) {
> -		ret = cxl_map_regs(cxlm, &maps[i]);
> -		if (ret)
> -			break;
> -	}
> +	rc = cxl_map_regblock(pdev, map);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_probe_regs(pdev, map);
> +	cxl_unmap_regblock(pdev, map);
>  
> -	return ret;
> +	return rc;
>  }
>  
>  static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
> +	struct cxl_register_map map;
>  	struct cxl_memdev *cxlmd;
>  	struct cxl_mem *cxlm;
>  	int rc;
> @@ -518,7 +515,11 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (IS_ERR(cxlm))
>  		return PTR_ERR(cxlm);
>  
> -	rc = cxl_pci_setup_regs(cxlm);
> +	rc = cxl_setup_regs(pdev, CXL_REGLOC_RBI_MEMDEV, &map);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_map_regs(cxlm, &map);
>  	if (rc)
>  		return rc;
>  
> 

