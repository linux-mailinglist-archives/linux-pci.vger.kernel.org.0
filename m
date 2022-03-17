Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D718A4DC3AE
	for <lists+linux-pci@lfdr.de>; Thu, 17 Mar 2022 11:09:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiCQKLI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Mar 2022 06:11:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiCQKLI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Mar 2022 06:11:08 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0208BD7C1;
        Thu, 17 Mar 2022 03:09:51 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KK2rp590Pz67gjp;
        Thu, 17 Mar 2022 18:07:54 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 17 Mar 2022 11:09:49 +0100
Received: from localhost (10.47.67.192) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 10:09:49 +0000
Date:   Thu, 17 Mar 2022 10:09:47 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ben.widawsky@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <ira.weiny@intel.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/8] cxl/pci: Kill cxl_map_regs()
Message-ID: <20220317100947.000060f9@Huawei.com>
In-Reply-To: <164740403796.3912056.13648238900454640514.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164740403796.3912056.13648238900454640514.stgit@dwillia2-desk3.amr.corp.intel.com>
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

On Tue, 15 Mar 2022 21:13:58 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> The component registers are currently unused by the cxl_pci driver.
> Only the physical address base of the component registers is conveyed to
> the cxl_mem driver. Just call cxl_map_device_registers() directly.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Makes sense.   Not sure how we ended up with the unused component register
handling.  I guess code evolution...

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/pci.c |   23 +----------------------
>  1 file changed, 1 insertion(+), 22 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 994c79bf6afd..0efbb356cce0 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -346,27 +346,6 @@ static int cxl_probe_regs(struct pci_dev *pdev, struct cxl_register_map *map)
>  	return 0;
>  }
>  
> -static int cxl_map_regs(struct cxl_dev_state *cxlds, struct cxl_register_map *map)
> -{
> -	struct device *dev = cxlds->dev;
> -	struct pci_dev *pdev = to_pci_dev(dev);
> -
> -	switch (map->reg_type) {
> -	case CXL_REGLOC_RBI_COMPONENT:
> -		cxl_map_component_regs(pdev, &cxlds->regs.component, map);
> -		dev_dbg(dev, "Mapping component registers...\n");
> -		break;
> -	case CXL_REGLOC_RBI_MEMDEV:
> -		cxl_map_device_regs(pdev, &cxlds->regs.device_regs, map);
> -		dev_dbg(dev, "Probing device registers...\n");
> -		break;
> -	default:
> -		break;
> -	}
> -
> -	return 0;
> -}
> -
>  static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>  			  struct cxl_register_map *map)
>  {
> @@ -599,7 +578,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_map_regs(cxlds, &map);
> +	rc = cxl_map_device_regs(pdev, &cxlds->regs.device_regs, &map);
>  	if (rc)
>  		return rc;
>  
> 
> 

