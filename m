Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1264342F7DC
	for <lists+linux-pci@lfdr.de>; Fri, 15 Oct 2021 18:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241179AbhJOQRR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Oct 2021 12:17:17 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3984 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237297AbhJOQRR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Oct 2021 12:17:17 -0400
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HWB9l0ss6z67RS4;
        Sat, 16 Oct 2021 00:12:11 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Fri, 15 Oct 2021 18:15:08 +0200
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Fri, 15 Oct
 2021 17:15:08 +0100
Date:   Fri, 15 Oct 2021 17:15:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <stable@vger.kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <hch@lst.de>
Subject: Re: [PATCH v3 03/10] cxl/pci: Fix NULL vs ERR_PTR confusion
Message-ID: <20211015171507.000010dd@Huawei.com>
In-Reply-To: <163379785305.692348.7804260538462033304.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163379783658.692348.16064992154261275220.stgit@dwillia2-desk3.amr.corp.intel.com>
        <163379785305.692348.7804260538462033304.stgit@dwillia2-desk3.amr.corp.intel.com>
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

On Sat, 9 Oct 2021 09:44:13 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> cxl_pci_map_regblock() may return an ERR_PTR(), but cxl_pci_setup_regs()
> is only prepared for NULL as the error case.
> 

What's the logic behind doing this rather than adjusting the call site to
check for an error pointer?

Either approach is fine as far as I'm concerned though so this is really
just a request for a bit more info in this patch description.

FWIW

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> Fixes: f8a7e8c29be8 ("cxl/pci: Reserve all device regions at once")
> Cc: <stable@vger.kernel.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/pci.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index ccc7c2573ddc..9c178002d49e 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -317,7 +317,7 @@ static void __iomem *cxl_pci_map_regblock(struct cxl_mem *cxlm,
>  	if (pci_resource_len(pdev, bar) < offset) {
>  		dev_err(dev, "BAR%d: %pr: too small (offset: %#llx)\n", bar,
>  			&pdev->resource[bar], (unsigned long long)offset);
> -		return IOMEM_ERR_PTR(-ENXIO);
> +		return NULL;
>  	}
>  
>  	addr = pci_iomap(pdev, bar, 0);
> 

