Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1F3945908E
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 15:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbhKVOwp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 09:52:45 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4128 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbhKVOwo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Nov 2021 09:52:44 -0500
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HyVWp4tc7z6H7tl;
        Mon, 22 Nov 2021 22:48:38 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 15:49:35 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 22 Nov
 2021 14:49:35 +0000
Date:   Mon, 22 Nov 2021 14:49:34 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 02/23] cxl: Flesh out register names
Message-ID: <20211122144934.000050ca@Huawei.com>
In-Reply-To: <20211120000250.1663391-3-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
        <20211120000250.1663391-3-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 19 Nov 2021 16:02:29 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Get a better naming scheme in place for upcoming additions.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

Seems like a good balance to me between the different directions this
sort of naming gets dragged in.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> Changes since RFCv2:
> Use some abbreviations (Jonathan)
> Prefix everything with CXL (Jonathan)
> Remove new additions (Dan)
> 
> Original discussion motivating this occurred here:
> https://lore.kernel.org/linux-pci/20210913190131.xiiszmno46qie7v5@intel.com/
> ---
>  drivers/cxl/pci.c | 14 +++++++-------
>  drivers/cxl/pci.h | 19 ++++++++++---------
>  2 files changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 8dc91fd3396a..a6ea9811a05b 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -403,10 +403,10 @@ static int cxl_map_regs(struct cxl_dev_state *cxlds, struct cxl_register_map *ma
>  static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
>  				struct cxl_register_map *map)
>  {
> -	map->block_offset =
> -		((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
> -	map->barno = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
> -	map->reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
> +	map->block_offset = ((u64)reg_hi << 32) |
> +			    (reg_lo & CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
> +	map->barno = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BIR_MASK, reg_lo);
> +	map->reg_type = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
>  }
>  
>  /**
> @@ -427,15 +427,15 @@ static int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>  	int regloc, i;
>  
>  	regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> -					   PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID);
> +					   CXL_DVSEC_REG_LOCATOR);
>  	if (!regloc)
>  		return -ENXIO;
>  
>  	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
>  	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
>  
> -	regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
> -	regblocks = (regloc_size - PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET) / 8;
> +	regloc += CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET;
> +	regblocks = (regloc_size - CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET) / 8;
>  
>  	for (i = 0; i < regblocks; i++, regloc += 8) {
>  		u32 reg_lo, reg_hi;
> diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> index 7d3e4bf06b45..29b8eaef3a0a 100644
> --- a/drivers/cxl/pci.h
> +++ b/drivers/cxl/pci.h
> @@ -7,17 +7,21 @@
>  
>  /*
>   * See section 8.1 Configuration Space Registers in the CXL 2.0
> - * Specification
> + * Specification. Names are taken straight from the specification with "CXL" and
> + * "DVSEC" redundancies removed. When obvious, abbreviations may be used.
>   */
>  #define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
>  #define PCI_DVSEC_VENDOR_ID_CXL		0x1E98
> -#define PCI_DVSEC_ID_CXL		0x0
>  
> -#define PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID	0x8
> -#define PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET	0xC
> +/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
> +#define CXL_DVSEC_PCIE_DEVICE					0
>  
> -/* BAR Indicator Register (BIR) */
> -#define CXL_REGLOC_BIR_MASK GENMASK(2, 0)
> +/* CXL 2.0 8.1.9: Register Locator DVSEC */
> +#define CXL_DVSEC_REG_LOCATOR					8
> +#define   CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET			0xC
> +#define     CXL_DVSEC_REG_LOCATOR_BIR_MASK			GENMASK(2, 0)
> +#define	    CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK			GENMASK(15, 8)
> +#define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK		GENMASK(31, 16)
>  
>  /* Register Block Identifier (RBI) */
>  enum cxl_regloc_type {
> @@ -28,7 +32,4 @@ enum cxl_regloc_type {
>  	CXL_REGLOC_RBI_TYPES
>  };
>  
> -#define CXL_REGLOC_RBI_MASK GENMASK(15, 8)
> -#define CXL_REGLOC_ADDR_MASK GENMASK(31, 16)
> -
>  #endif /* __CXL_PCI_H__ */

