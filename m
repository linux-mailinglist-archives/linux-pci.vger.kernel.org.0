Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8DF94DC9A5
	for <lists+linux-pci@lfdr.de>; Thu, 17 Mar 2022 16:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbiCQPM0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Mar 2022 11:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231846AbiCQPMZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Mar 2022 11:12:25 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5CC2042B8;
        Thu, 17 Mar 2022 08:11:04 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KK9XL4xXPz67NRr;
        Thu, 17 Mar 2022 23:09:06 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 17 Mar 2022 16:11:02 +0100
Received: from localhost (10.47.67.100) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 15:11:01 +0000
Date:   Thu, 17 Mar 2022 15:10:57 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ben.widawsky@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <ira.weiny@intel.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 7/8] cxl/pci: Find and map the RAS Capability Structure
Message-ID: <20220317151057.00000f16@Huawei.com>
In-Reply-To: <164740405921.3912056.7575762163944798747.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164740405921.3912056.7575762163944798747.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.67.100]
X-ClientProxiedBy: lhreml735-chm.china.huawei.com (10.201.108.86) To
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

On Tue, 15 Mar 2022 21:14:19 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> The RAS Capability Structure has some ancillary information that may be
> relevant with respect to AER events, link and protcol error status
> registers. Map the RAS Capability Registers in support of defining a
> 'struct pci_error_handlers' instance for the cxl_pci driver.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Looks right to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/regs.c |    7 +++++++
>  drivers/cxl/cxl.h       |   19 +++++++++++++++++++
>  drivers/cxl/pci.c       |    8 ++++++++
>  3 files changed, 34 insertions(+)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index c022c8937dfc..53aac68b9ce4 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -83,6 +83,12 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  			rmap = &map->hdm_decoder;
>  			break;
>  		}
> +		case CXL_CM_CAP_CAP_ID_RAS:
> +			dev_dbg(dev, "found RAS capability (0x%x)\n",
> +				offset);
> +			length = CXL_RAS_CAPABILITY_LENGTH;
> +			rmap = &map->ras;
> +			break;
>  		default:
>  			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
>  				offset);
> @@ -196,6 +202,7 @@ int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
>  		void __iomem **addr;
>  	} mapinfo[] = {
>  		{ .rmap = &map->component_map.hdm_decoder, &regs->hdm_decoder },
> +		{ .rmap = &map->component_map.ras, &regs->ras },
>  	};
>  	int i;
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 52bd77d8e22a..cf3d8d0aaf22 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -32,6 +32,7 @@
>  #define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
>  #define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
>  
> +#define   CXL_CM_CAP_CAP_ID_RAS 0x2
>  #define   CXL_CM_CAP_CAP_ID_HDM 0x5
>  #define   CXL_CM_CAP_CAP_HDM_VERSION 1
>  
> @@ -64,6 +65,21 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
>  	return val ? val * 2 : 1;
>  }
>  
> +/* RAS Registers CXL 2.0 8.2.5.9 CXL RAS Capability Structure */
> +#define CXL_RAS_UNCORRECTABLE_STATUS_OFFSET 0x0
> +#define   CXL_RAS_UNCORRECTABLE_STATUS_MASK (GENMASK(16, 14) | GENMASK(11, 0))
> +#define CXL_RAS_UNCORRECTABLE_MASK_OFFSET 0x4
> +#define   CXL_RAS_UNCORRECTABLE_MASK_MASK (GENMASK(16, 14) | GENMASK(11, 0))
> +#define CXL_RAS_UNCORRECTABLE_SEVERITY_OFFSET 0x8
> +#define   CXL_RAS_UNCORRECTABLE_SEVERITY_MASK (GENMASK(16, 14) | GENMASK(11, 0))
> +#define CXL_RAS_CORRECTABLE_STATUS_OFFSET 0xC
> +#define   CXL_RAS_CORRECTABLE_STATUS_MASK GENMASK(6, 0)
> +#define CXL_RAS_CORRECTABLE_MASK_OFFSET 0x10
> +#define   CXL_RAS_CORRECTABLE_MASK_MASK GENMASK(6, 0)
> +#define CXL_RAS_CAP_CONTROL_OFFSET 0x14
> +#define CXL_RAS_HEADER_LOG_OFFSET 0x18
> +#define CXL_RAS_CAPABILITY_LENGTH 0x58
> +
>  /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
>  #define CXLDEV_CAP_ARRAY_OFFSET 0x0
>  #define   CXLDEV_CAP_ARRAY_CAP_ID 0
> @@ -98,9 +114,11 @@ struct cxl_regs {
>  	/*
>  	 * Common set of CXL Component register block base pointers
>  	 * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
> +	 * @ras: CXL 2.0 8.2.5.9 CXL RAS Capability Structure
>  	 */
>  	struct_group_tagged(cxl_component_regs, component,
>  		void __iomem *hdm_decoder;
> +		void __iomem *ras;
>  	);
>  	/*
>  	 * Common set of CXL Device register block base pointers
> @@ -122,6 +140,7 @@ struct cxl_reg_map {
>  
>  struct cxl_component_reg_map {
>  	struct cxl_reg_map hdm_decoder;
> +	struct cxl_reg_map ras;
>  };
>  
>  struct cxl_device_reg_map {
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index d8361331a013..bde8929450f0 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -310,6 +310,9 @@ static int cxl_probe_regs(struct pci_dev *pdev, struct cxl_register_map *map)
>  			return -ENXIO;
>  		}
>  
> +		if (!comp_map->ras.valid)
> +			dev_dbg(dev, "RAS registers not found\n");
> +
>  		dev_dbg(dev, "Set up component registers\n");
>  		break;
>  	case CXL_REGLOC_RBI_MEMDEV:
> @@ -580,6 +583,11 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  
>  	cxlds->component_reg_phys = map.resource;
>  
> +	rc = cxl_map_component_regs(&pdev->dev, &cxlds->regs.component,
> +				    &map, BIT(CXL_CM_CAP_CAP_ID_RAS));
> +	if (rc)
> +		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
> +
>  	rc = cxl_pci_setup_mailbox(cxlds);
>  	if (rc)
>  		return rc;
> 

