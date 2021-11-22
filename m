Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1981F45959B
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 20:28:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbhKVTcC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 14:32:02 -0500
Received: from mga05.intel.com ([192.55.52.43]:38591 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240073AbhKVTbv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Nov 2021 14:31:51 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="321089440"
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="321089440"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 11:28:42 -0800
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="570435807"
Received: from wqiu6-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.143.45])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 11:28:41 -0800
Date:   Mon, 22 Nov 2021 11:28:38 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 08/23] cxl/acpi: Map component registers for Root Ports
Message-ID: <20211122192838.cqb57lhtd7aqa6fy@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
 <20211120000250.1663391-9-ben.widawsky@intel.com>
 <20211122155147.00005db4@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122155147.00005db4@Huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-11-22 15:51:47, Jonathan Cameron wrote:
> On Fri, 19 Nov 2021 16:02:35 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > This implements the TODO in cxl_acpi for mapping component registers.
> > cxl_acpi becomes the second consumer of CXL register block enumeration
> > (cxl_pci being the first). Moving the functionality to cxl_core allows
> > both of these drivers to use the functionality. Equally importantly it
> > allows cxl_core to use the functionality in the future.
> > 
> > CXL 2.0 root ports are similar to CXL 2.0 Downstream Ports with the main
> > distinction being they're a part of the CXL 2.0 host bridge. While
> > mapping their component registers is not immediately useful for the CXL
> > drivers, the movement of register block enumeration into core is a vital
> > step towards HDM decoder programming.
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> 
> A few minor comments below.
> 
> Jonathan
> 
> > 
> > ---
> > Changes since RFCv2:
> > - Squash commits together (Dan)
> > - Reword commit message to account for above.
> > ---
> >  drivers/cxl/acpi.c      | 10 ++++++--
> >  drivers/cxl/core/regs.c | 54 +++++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxl.h       |  4 +++
> >  drivers/cxl/pci.c       | 52 ---------------------------------------
> >  drivers/cxl/pci.h       |  4 +++
> >  5 files changed, 70 insertions(+), 54 deletions(-)
> > 
> > diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> > index 3163167ecc3a..7cfa8b568013 100644
> > --- a/drivers/cxl/acpi.c
> > +++ b/drivers/cxl/acpi.c
> > @@ -7,6 +7,7 @@
> >  #include <linux/acpi.h>
> >  #include <linux/pci.h>
> >  #include "cxl.h"
> > +#include "pci.h"
> >  
> >  /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
> >  #define CFMWS_INTERLEAVE_WAYS(x)	(1 << (x)->interleave_ways)
> > @@ -134,11 +135,13 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> >  
> >  __mock int match_add_root_ports(struct pci_dev *pdev, void *data)
> >  {
> > +	resource_size_t creg = CXL_RESOURCE_NONE;
> >  	struct cxl_walk_context *ctx = data;
> >  	struct pci_bus *root_bus = ctx->root;
> >  	struct cxl_port *port = ctx->port;
> >  	int type = pci_pcie_type(pdev);
> >  	struct device *dev = ctx->dev;
> > +	struct cxl_register_map map;
> >  	u32 lnkcap, port_num;
> >  	int rc;
> >  
> > @@ -152,9 +155,12 @@ __mock int match_add_root_ports(struct pci_dev *pdev, void *data)
> >  				  &lnkcap) != PCIBIOS_SUCCESSFUL)
> >  		return 0;
> >  
> > -	/* TODO walk DVSEC to find component register base */
> > +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> 
> Perhaps a comment to explain why this is optional?
> 

Got it. I've also added a dev_info if the regblock isn't found because at some
point in the future it might be confusing should we ever want to use those
registers.

> > +	if (!rc)
> > +		creg = cxl_reg_block(pdev, &map);
> > +
> >  	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
> > -	rc = cxl_add_dport(port, &pdev->dev, port_num, CXL_RESOURCE_NONE);
> > +	rc = cxl_add_dport(port, &pdev->dev, port_num, creg);
> >  	if (rc) {
> >  		ctx->error = rc;
> >  		return rc;
> > diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> > index e37e23bf4355..41a0245867ea 100644
> > --- a/drivers/cxl/core/regs.c
> > +++ b/drivers/cxl/core/regs.c
> > @@ -5,6 +5,7 @@
> >  #include <linux/slab.h>
> >  #include <linux/pci.h>
> >  #include <cxlmem.h>
> > +#include <pci.h>
> >  
> >  /**
> >   * DOC: cxl registers
> > @@ -247,3 +248,56 @@ int cxl_map_device_regs(struct pci_dev *pdev,
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_map_device_regs, CXL);
> > +
> > +static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
> > +				struct cxl_register_map *map)
> > +{
> > +	map->block_offset = ((u64)reg_hi << 32) |
> > +			    (reg_lo & CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
> > +	map->barno = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BIR_MASK, reg_lo);
> > +	map->reg_type = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
> > +}
> > +
> > +/**
> > + * cxl_find_regblock() - Locate register blocks by type
> > + * @pdev: The CXL PCI device to enumerate.
> > + * @type: Register Block Indicator id
> > + * @map: Enumeration output, clobbered on error
> > + *
> > + * Return: 0 if register block enumerated, negative error code otherwise
> > + *
> > + * A CXL DVSEC may additional point one or more register blocks, search
> 
> Why additional?  I'm not sure what this means.
> 
> point to one or more additional register blocks perhaps?
> 

Was a typo from how I rebased. Good catch.

> > + * for them by @type.
> > + */
> > +int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> > +		      struct cxl_register_map *map)
> > +{
> > +	u32 regloc_size, regblocks;
> > +	int regloc, i;
> > +
> > +	regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> > +					   CXL_DVSEC_REG_LOCATOR);
> > +	if (!regloc)
> > +		return -ENXIO;
> > +
> > +	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
> > +	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
> > +
> > +	regloc += CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET;
> > +	regblocks = (regloc_size - CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET) / 8;
> > +
> > +	for (i = 0; i < regblocks; i++, regloc += 8) {
> > +		u32 reg_lo, reg_hi;
> > +
> > +		pci_read_config_dword(pdev, regloc, &reg_lo);
> > +		pci_read_config_dword(pdev, regloc + 4, &reg_hi);
> > +
> > +		cxl_decode_regblock(reg_lo, reg_hi, map);
> > +
> > +		if (map->reg_type == type)
> > +			return 0;
> > +	}
> > +
> > +	return -ENODEV;
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index ab4596f0b751..7150a9694f66 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -145,6 +145,10 @@ int cxl_map_device_regs(struct pci_dev *pdev,
> >  			struct cxl_device_regs *regs,
> >  			struct cxl_register_map *map);
> >  
> > +enum cxl_regloc_type;
> > +int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> > +		      struct cxl_register_map *map);
> > +
> >  #define CXL_RESOURCE_NONE ((resource_size_t) -1)
> >  #define CXL_TARGET_STRLEN 20
> >  
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 711bf4514480..d2c743a31b0c 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -433,58 +433,6 @@ static int cxl_map_regs(struct cxl_dev_state *cxlds, struct cxl_register_map *ma
> >  	return 0;
> >  }
> >  
> > -static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
> > -				struct cxl_register_map *map)
> > -{
> > -	map->block_offset = ((u64)reg_hi << 32) |
> > -			    (reg_lo & CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
> > -	map->barno = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BIR_MASK, reg_lo);
> > -	map->reg_type = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
> > -}
> > -
> > -/**
> > - * cxl_find_regblock() - Locate register blocks by type
> > - * @pdev: The CXL PCI device to enumerate.
> > - * @type: Register Block Indicator id
> > - * @map: Enumeration output, clobbered on error
> > - *
> > - * Return: 0 if register block enumerated, negative error code otherwise
> > - *
> > - * A CXL DVSEC may point to one or more register blocks, search for them
> > - * by @type.
> > - */
> > -static int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> > -			     struct cxl_register_map *map)
> > -{
> > -	u32 regloc_size, regblocks;
> > -	int regloc, i;
> > -
> > -	regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> > -					   CXL_DVSEC_REG_LOCATOR);
> > -	if (!regloc)
> > -		return -ENXIO;
> > -
> > -	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
> > -	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
> > -
> > -	regloc += CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET;
> > -	regblocks = (regloc_size - CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET) / 8;
> > -
> > -	for (i = 0; i < regblocks; i++, regloc += 8) {
> > -		u32 reg_lo, reg_hi;
> > -
> > -		pci_read_config_dword(pdev, regloc, &reg_lo);
> > -		pci_read_config_dword(pdev, regloc + 4, &reg_hi);
> > -
> > -		cxl_decode_regblock(reg_lo, reg_hi, map);
> > -
> > -		if (map->reg_type == type)
> > -			return 0;
> > -	}
> > -
> > -	return -ENODEV;
> > -}
> > -
> >  static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
> >  			  struct cxl_register_map *map)
> >  {
> > diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> > index 8ae2b4adc59d..a4b506bb37d1 100644
> > --- a/drivers/cxl/pci.h
> > +++ b/drivers/cxl/pci.h
> > @@ -47,4 +47,8 @@ enum cxl_regloc_type {
> >  	CXL_REGLOC_RBI_TYPES
> >  };
> >  
> > +#define cxl_reg_block(pdev, map)                                               \
> > +	((resource_size_t)(pci_resource_start(pdev, (map)->barno) +            \
> > +			   (map)->block_offset))
> > +
> >  #endif /* __CXL_PCI_H__ */
> 
