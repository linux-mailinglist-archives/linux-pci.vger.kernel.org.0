Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BC34DC3A1
	for <lists+linux-pci@lfdr.de>; Thu, 17 Mar 2022 11:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiCQKJS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Mar 2022 06:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiCQKJS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Mar 2022 06:09:18 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFE5B8CD81;
        Thu, 17 Mar 2022 03:08:01 -0700 (PDT)
Received: from fraeml715-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KK2qx5pVQz67wqt;
        Thu, 17 Mar 2022 18:07:09 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml715-chm.china.huawei.com (10.206.15.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 17 Mar 2022 11:07:59 +0100
Received: from localhost (10.47.67.192) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 10:07:58 +0000
Date:   Thu, 17 Mar 2022 10:07:57 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ben.widawsky@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <ira.weiny@intel.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/8] cxl/pci: Cleanup cxl_map_device_regs()
Message-ID: <20220317100757.00005f2b@Huawei.com>
In-Reply-To: <164740403286.3912056.2514975283929305856.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164740403286.3912056.2514975283929305856.stgit@dwillia2-desk3.amr.corp.intel.com>
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

On Tue, 15 Mar 2022 21:13:52 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Use a loop to reduce the duplicated code in cxl_map_device_regs(). This
> is in preparation for deleting cxl_map_regs().
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Trivial style comments inline.  Otherwise LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/regs.c |   51 ++++++++++++++++++-----------------------------
>  1 file changed, 20 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index bd6ae14b679e..bd766e461f7d 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -211,42 +211,31 @@ int cxl_map_device_regs(struct pci_dev *pdev,
>  			struct cxl_device_regs *regs,
>  			struct cxl_register_map *map)
>  {
> +	resource_size_t phys_addr =
> +		pci_resource_start(pdev, map->barno) + map->block_offset;

I'm not totally convinced by this refactoring as it's ugly either
way...  Still your code, and I don't care that strongly ;)

>  	struct device *dev = &pdev->dev;
> -	resource_size_t phys_addr;
> -
> -	phys_addr = pci_resource_start(pdev, map->barno);
> -	phys_addr += map->block_offset;
> -
> -	if (map->device_map.status.valid) {
> -		resource_size_t addr;
> +	struct mapinfo {
> +		struct cxl_reg_map *rmap;
> +		void __iomem **addr;
> +	} mapinfo[] = {
> +		{ .rmap = &map->device_map.status, &regs->status, },

Combining c99 style .rmap for first parameter and then not doing it
for the second is a bit odd looking.  Was there a strong reason for
doing this?  I'd just drop the ".rmap =" as it's not as though
we need to look far to see what it's setting.

> +		{ .rmap = &map->device_map.mbox, &regs->mbox, },
> +		{ .rmap = &map->device_map.memdev, &regs->memdev, },
> +	};
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(mapinfo); i++) {
> +		struct mapinfo *mi = &mapinfo[i];
>  		resource_size_t length;
> -
> -		addr = phys_addr + map->device_map.status.offset;
> -		length = map->device_map.status.size;
> -		regs->status = devm_cxl_iomap_block(dev, addr, length);
> -		if (!regs->status)
> -			return -ENOMEM;
> -	}
> -
> -	if (map->device_map.mbox.valid) {
>  		resource_size_t addr;
> -		resource_size_t length;
>  
> -		addr = phys_addr + map->device_map.mbox.offset;
> -		length = map->device_map.mbox.size;
> -		regs->mbox = devm_cxl_iomap_block(dev, addr, length);
> -		if (!regs->mbox)
> -			return -ENOMEM;
> -	}
> -
> -	if (map->device_map.memdev.valid) {
> -		resource_size_t addr;
> -		resource_size_t length;
> +		if (!mi->rmap->valid)
> +			continue;
>  
> -		addr = phys_addr + map->device_map.memdev.offset;
> -		length = map->device_map.memdev.size;
> -		regs->memdev = devm_cxl_iomap_block(dev, addr, length);
> -		if (!regs->memdev)
> +		addr = phys_addr + mi->rmap->offset;
> +		length = mi->rmap->size;
> +		*(mi->addr) = devm_cxl_iomap_block(dev, addr, length);
> +		if (!*(mi->addr))
>  			return -ENOMEM;
>  	}
>  
> 

