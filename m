Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34462358AE8
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 19:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232377AbhDHRJp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 13:09:45 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:2809 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232123AbhDHRJp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 13:09:45 -0400
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4FGSDY66bzz68709;
        Fri,  9 Apr 2021 00:59:57 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Thu, 8 Apr 2021 19:09:31 +0200
Received: from localhost (10.47.93.239) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Thu, 8 Apr 2021
 18:09:31 +0100
Date:   Thu, 8 Apr 2021 18:08:06 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <dan.j.williams@intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/7] cxl/mem: Use dev instead of pdev->dev
Message-ID: <20210408180806.0000351f@Huawei.com>
In-Reply-To: <20210407222625.320177-2-ben.widawsky@intel.com>
References: <20210407222625.320177-1-ben.widawsky@intel.com>
        <20210407222625.320177-2-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.93.239]
X-ClientProxiedBy: lhreml750-chm.china.huawei.com (10.201.108.200) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 7 Apr 2021 15:26:19 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Trivial cleanup.

Obviously correct :)

> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
FWIW
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/mem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index b6fe4e81d38a..99534260034e 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -935,7 +935,7 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
>  	u8 bar;
>  	int rc;
>  
> -	cxlm = devm_kzalloc(&pdev->dev, sizeof(*cxlm), GFP_KERNEL);
> +	cxlm = devm_kzalloc(dev, sizeof(*cxlm), GFP_KERNEL);
>  	if (!cxlm) {
>  		dev_err(dev, "No memory available\n");
>  		return NULL;

