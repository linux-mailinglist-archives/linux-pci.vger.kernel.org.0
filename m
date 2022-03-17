Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE6E4DC384
	for <lists+linux-pci@lfdr.de>; Thu, 17 Mar 2022 11:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231790AbiCQKD1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Mar 2022 06:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiCQKD1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Mar 2022 06:03:27 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E69311DBAB8;
        Thu, 17 Mar 2022 03:02:10 -0700 (PDT)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KK2gx3s6Lz67mW6;
        Thu, 17 Mar 2022 18:00:13 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 17 Mar 2022 11:02:08 +0100
Received: from localhost (10.47.67.192) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 10:02:07 +0000
Date:   Thu, 17 Mar 2022 10:02:05 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ben.widawsky@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <ira.weiny@intel.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/8] cxl/pci: Cleanup repeated code in cxl_probe_regs()
 helpers
Message-ID: <20220317100205.00002364@Huawei.com>
In-Reply-To: <164740402774.3912056.671750814250190348.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164740402774.3912056.671750814250190348.stgit@dwillia2-desk3.amr.corp.intel.com>
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

On Tue, 15 Mar 2022 21:13:47 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Rather then duplicating the setting of valid, length, and offset for

than

> each type, just convey a pointer to the register map to common code.
> 
> Yes, the equivalent change in cxl_probe_component_regs() does not save

Why "equivalent"?  I'd just drop that word as not clear what it's equivalent to
and sentence makes sense without it.

> any lines of code, but it is preparation for adding another component
> register type to map (RAS Capability Strucutre).

Structure

> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/regs.c |   46 ++++++++++++++++++++++++++--------------------
>  1 file changed, 26 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 39a129c57d40..bd6ae14b679e 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -59,36 +59,41 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  
>  	for (cap = 1; cap <= cap_count; cap++) {
>  		void __iomem *register_block;
> -		u32 hdr;
> -		int decoder_cnt;
> +		struct cxl_reg_map *rmap;
>  		u16 cap_id, offset;
> -		u32 length;
> +		u32 length, hdr;

Unrelated change, but meh, it makes sense and doesn't effect readability of overall
patch much.

>  
>  		hdr = readl(base + cap * 0x4);
>  
>  		cap_id = FIELD_GET(CXL_CM_CAP_HDR_ID_MASK, hdr);
>  		offset = FIELD_GET(CXL_CM_CAP_PTR_MASK, hdr);
>  		register_block = base + offset;
> +		hdr = readl(register_block);
>  
> +		rmap = NULL;
>  		switch (cap_id) {
> -		case CXL_CM_CAP_CAP_ID_HDM:
> +		case CXL_CM_CAP_CAP_ID_HDM: {
> +			int decoder_cnt;
> +
>  			dev_dbg(dev, "found HDM decoder capability (0x%x)\n",
>  				offset);
>  
> -			hdr = readl(register_block);
> -
>  			decoder_cnt = cxl_hdm_decoder_count(hdr);
>  			length = 0x20 * decoder_cnt + 0x10;
> -
> -			map->hdm_decoder.valid = true;
> -			map->hdm_decoder.offset = CXL_CM_OFFSET + offset;
> -			map->hdm_decoder.size = length;
> +			rmap = &map->hdm_decoder;
>  			break;
> +		}
>  		default:
>  			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
>  				offset);
>  			break;
>  		}
> +
> +		if (!rmap)
> +			continue;
> +		rmap->valid = true;
> +		rmap->offset = CXL_CM_OFFSET + offset;
> +		rmap->size = length;
>  	}
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_probe_component_regs, CXL);
> @@ -117,6 +122,7 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  	cap_count = FIELD_GET(CXLDEV_CAP_ARRAY_COUNT_MASK, cap_array);
>  
>  	for (cap = 1; cap <= cap_count; cap++) {
> +		struct cxl_reg_map *rmap;
>  		u32 offset, length;
>  		u16 cap_id;
>  
> @@ -125,28 +131,22 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  		offset = readl(base + cap * 0x10 + 0x4);
>  		length = readl(base + cap * 0x10 + 0x8);
>  
> +		rmap = NULL;
>  		switch (cap_id) {
>  		case CXLDEV_CAP_CAP_ID_DEVICE_STATUS:
>  			dev_dbg(dev, "found Status capability (0x%x)\n", offset);
> -
> -			map->status.valid = true;
> -			map->status.offset = offset;
> -			map->status.size = length;
> +			rmap = &map->status;
>  			break;
>  		case CXLDEV_CAP_CAP_ID_PRIMARY_MAILBOX:
>  			dev_dbg(dev, "found Mailbox capability (0x%x)\n", offset);
> -			map->mbox.valid = true;
> -			map->mbox.offset = offset;
> -			map->mbox.size = length;
> +			rmap = &map->mbox;
>  			break;
>  		case CXLDEV_CAP_CAP_ID_SECONDARY_MAILBOX:
>  			dev_dbg(dev, "found Secondary Mailbox capability (0x%x)\n", offset);
>  			break;
>  		case CXLDEV_CAP_CAP_ID_MEMDEV:
>  			dev_dbg(dev, "found Memory Device capability (0x%x)\n", offset);
> -			map->memdev.valid = true;
> -			map->memdev.offset = offset;
> -			map->memdev.size = length;
> +			rmap = &map->memdev;
>  			break;
>  		default:
>  			if (cap_id >= 0x8000)
> @@ -155,6 +155,12 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  				dev_dbg(dev, "Unknown cap ID: %#x offset: %#x\n", cap_id, offset);
>  			break;
>  		}
> +
> +		if (!rmap)
> +			continue;
> +		rmap->valid = true;
> +		rmap->offset = offset;
> +		rmap->size = length;
>  	}
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_probe_device_regs, CXL);
> 

