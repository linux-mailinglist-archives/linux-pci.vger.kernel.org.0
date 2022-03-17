Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7FBC4DC3EE
	for <lists+linux-pci@lfdr.de>; Thu, 17 Mar 2022 11:25:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232528AbiCQK0x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Mar 2022 06:26:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231430AbiCQK0x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Mar 2022 06:26:53 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7E2E10819D;
        Thu, 17 Mar 2022 03:25:35 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KK3Bx59Xcz67KX2;
        Thu, 17 Mar 2022 18:23:37 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 17 Mar 2022 11:25:32 +0100
Received: from localhost (10.47.67.192) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 10:25:31 +0000
Date:   Thu, 17 Mar 2022 10:25:30 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ben.widawsky@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <ira.weiny@intel.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 4/8] cxl/core/regs: Make cxl_map_{component,
 device}_regs() device generic
Message-ID: <20220317102530.00007a79@Huawei.com>
In-Reply-To: <164740404348.3912056.9598057996803947688.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164740404348.3912056.9598057996803947688.stgit@dwillia2-desk3.amr.corp.intel.com>
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

On Tue, 15 Mar 2022 21:14:03 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> There is no need to carry the barno and the block offset through the
> stack, just convert them to a resource base immediately.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Other that this involving paths where we try to carry on after a broken
device is detected which I'd be far from confident are correct or regularly
tested, the patch looks fine.
Particular case that bothers me is undersized bars. Before this patch
those were (I think) an error that would fail probe.  Are they still after
this patch?

Assuming that part is fine.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/pci.c  |    3 +--
>  drivers/cxl/core/port.c |    2 +-
>  drivers/cxl/core/regs.c |   40 +++++++++++++++++++++++-----------------
>  drivers/cxl/cxl.h       |   12 ++++++------
>  drivers/cxl/cxlpci.h    |    9 ---------
>  drivers/cxl/pci.c       |   25 ++++++-------------------
>  6 files changed, 37 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index c9a494d6976a..6e9ad9933dd4 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -46,8 +46,7 @@ static int match_add_dports(struct pci_dev *pdev, void *data)
>  		dev_dbg(&port->dev, "failed to find component registers\n");
>  
>  	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
> -	dport = devm_cxl_add_dport(port, &pdev->dev, port_num,
> -				   cxl_regmap_to_base(pdev, &map));
> +	dport = devm_cxl_add_dport(port, &pdev->dev, port_num, map.resource);
>  	if (IS_ERR(dport)) {
>  		ctx->error = PTR_ERR(dport);
>  		return PTR_ERR(dport);
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index c1681248f322..2cf27e71d8af 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -972,7 +972,7 @@ static resource_size_t find_component_registers(struct device *dev)
>  	pdev = to_pci_dev(dev);
>  
>  	cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> -	return cxl_regmap_to_base(pdev, &map);
> +	return map.resource;
>  }
>  
>  static int add_port_attach_ep(struct cxl_memdev *cxlmd,
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index bd766e461f7d..219c7d0e43e2 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -186,17 +186,13 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>  	return ret_val;
>  }
>  
> -int cxl_map_component_regs(struct pci_dev *pdev,
> -			   struct cxl_component_regs *regs,
> +int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
>  			   struct cxl_register_map *map)
>  {
> -	struct device *dev = &pdev->dev;
>  	resource_size_t phys_addr;
>  	resource_size_t length;
>  
> -	phys_addr = pci_resource_start(pdev, map->barno);
> -	phys_addr += map->block_offset;
> -
> +	phys_addr = map->resource;
>  	phys_addr += map->component_map.hdm_decoder.offset;
>  	length = map->component_map.hdm_decoder.size;
>  	regs->hdm_decoder = devm_cxl_iomap_block(dev, phys_addr, length);
> @@ -207,13 +203,11 @@ int cxl_map_component_regs(struct pci_dev *pdev,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_map_component_regs, CXL);
>  
> -int cxl_map_device_regs(struct pci_dev *pdev,
> +int cxl_map_device_regs(struct device *dev,
>  			struct cxl_device_regs *regs,
>  			struct cxl_register_map *map)
>  {
> -	resource_size_t phys_addr =
> -		pci_resource_start(pdev, map->barno) + map->block_offset;
> -	struct device *dev = &pdev->dev;
> +	resource_size_t phys_addr = map->resource;
>  	struct mapinfo {
>  		struct cxl_reg_map *rmap;
>  		void __iomem **addr;
> @@ -243,13 +237,24 @@ int cxl_map_device_regs(struct pci_dev *pdev,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_map_device_regs, CXL);
>  
> -static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
> +static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
>  				struct cxl_register_map *map)
>  {
> -	map->block_offset = ((u64)reg_hi << 32) |
> -			    (reg_lo & CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
> -	map->barno = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BIR_MASK, reg_lo);
> +	int bar = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BIR_MASK, reg_lo);
> +	u64 offset = ((u64)reg_hi << 32) |
> +		     (reg_lo & CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
> +
> +	if (offset > pci_resource_len(pdev, bar)) {
> +		dev_warn(&pdev->dev,
> +			 "BAR%d: %pr: too small (offset: %pa, type: %d)\n", bar,
> +			 &pdev->resource[bar], &offset, map->reg_type);
> +		return false;
> +	}
> +
>  	map->reg_type = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
> +	map->resource = pci_resource_start(pdev, bar) + offset;
> +	map->max_size = pci_resource_len(pdev, bar) - offset;
> +	return true;
>  }
>  
>  /**
> @@ -269,7 +274,7 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>  	u32 regloc_size, regblocks;
>  	int regloc, i;
>  
> -	map->block_offset = U64_MAX;
> +	map->resource = CXL_RESOURCE_NONE;
>  	regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
>  					   CXL_DVSEC_REG_LOCATOR);
>  	if (!regloc)
> @@ -287,13 +292,14 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>  		pci_read_config_dword(pdev, regloc, &reg_lo);
>  		pci_read_config_dword(pdev, regloc + 4, &reg_hi);
>  
> -		cxl_decode_regblock(reg_lo, reg_hi, map);
> +		if (!cxl_decode_regblock(pdev, reg_lo, reg_hi, map))
> +			continue;
>  
>  		if (map->reg_type == type)
>  			return 0;
>  	}
>  
> -	map->block_offset = U64_MAX;
> +	map->resource = CXL_RESOURCE_NONE;
>  	return -ENODEV;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 990b6670222e..2080a75c61fe 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -132,17 +132,17 @@ struct cxl_device_reg_map {
>  /**
>   * struct cxl_register_map - DVSEC harvested register block mapping parameters
>   * @base: virtual base of the register-block-BAR + @block_offset
> - * @block_offset: offset to start of register block in @barno
> + * @resource: physical resource base of the register block
> + * @max_size: maximum mapping size to perform register search
>   * @reg_type: see enum cxl_regloc_type
> - * @barno: PCI BAR number containing the register block
>   * @component_map: cxl_reg_map for component registers
>   * @device_map: cxl_reg_maps for device registers
>   */
>  struct cxl_register_map {
>  	void __iomem *base;
> -	u64 block_offset;
> +	resource_size_t resource;
> +	resource_size_t max_size;
>  	u8 reg_type;
> -	u8 barno;
>  	union {
>  		struct cxl_component_reg_map component_map;
>  		struct cxl_device_reg_map device_map;
> @@ -153,10 +153,10 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  			      struct cxl_component_reg_map *map);
>  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  			   struct cxl_device_reg_map *map);
> -int cxl_map_component_regs(struct pci_dev *pdev,
> +int cxl_map_component_regs(struct device *dev,
>  			   struct cxl_component_regs *regs,
>  			   struct cxl_register_map *map);
> -int cxl_map_device_regs(struct pci_dev *pdev,
> +int cxl_map_device_regs(struct device *dev,
>  			struct cxl_device_regs *regs,
>  			struct cxl_register_map *map);
>  
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 329e7ea3f36a..3c5be664ab22 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -62,14 +62,5 @@ enum cxl_regloc_type {
>  	CXL_REGLOC_RBI_TYPES
>  };
>  
> -static inline resource_size_t cxl_regmap_to_base(struct pci_dev *pdev,
> -						 struct cxl_register_map *map)
> -{
> -	if (map->block_offset == U64_MAX)
> -		return CXL_RESOURCE_NONE;
> -
> -	return pci_resource_start(pdev, map->barno) + map->block_offset;
> -}
> -
>  int devm_cxl_port_enumerate_dports(struct cxl_port *port);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0efbb356cce0..d8361331a013 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -275,35 +275,22 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
>  
>  static int cxl_map_regblock(struct pci_dev *pdev, struct cxl_register_map *map)
>  {
> -	void __iomem *addr;
> -	int bar = map->barno;
>  	struct device *dev = &pdev->dev;
> -	resource_size_t offset = map->block_offset;
>  
> -	/* Basic sanity check that BAR is big enough */
> -	if (pci_resource_len(pdev, bar) < offset) {
> -		dev_err(dev, "BAR%d: %pr: too small (offset: %pa)\n", bar,
> -			&pdev->resource[bar], &offset);
> -		return -ENXIO;
> -	}
> -
> -	addr = pci_iomap(pdev, bar, 0);
> -	if (!addr) {
> +	map->base = ioremap(map->resource, map->max_size);
> +	if (!map->base) {
>  		dev_err(dev, "failed to map registers\n");
>  		return -ENOMEM;
>  	}
>  
> -	dev_dbg(dev, "Mapped CXL Memory Device resource bar %u @ %pa\n",
> -		bar, &offset);
> -
> -	map->base = addr + map->block_offset;
> +	dev_dbg(dev, "Mapped CXL Memory Device resource %pa\n", &map->resource);
>  	return 0;
>  }
>  
>  static void cxl_unmap_regblock(struct pci_dev *pdev,
>  			       struct cxl_register_map *map)
>  {
> -	pci_iounmap(pdev, map->base - map->block_offset);
> +	iounmap(map->base);
>  	map->base = NULL;
>  }
>  
> @@ -578,7 +565,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_map_device_regs(pdev, &cxlds->regs.device_regs, &map);
> +	rc = cxl_map_device_regs(&pdev->dev, &cxlds->regs.device_regs, &map);
>  	if (rc)
>  		return rc;
>  
> @@ -591,7 +578,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		dev_warn(&pdev->dev, "No component registers (%d)\n", rc);
>  
> -	cxlds->component_reg_phys = cxl_regmap_to_base(pdev, &map);
> +	cxlds->component_reg_phys = map.resource;
>  
>  	rc = cxl_pci_setup_mailbox(cxlds);
>  	if (rc)
> 

