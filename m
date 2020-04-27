Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091171BA311
	for <lists+linux-pci@lfdr.de>; Mon, 27 Apr 2020 14:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgD0MAJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 08:00:09 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:36584 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726390AbgD0MAJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Apr 2020 08:00:09 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03RBxt0v019547;
        Mon, 27 Apr 2020 06:59:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587988795;
        bh=RwPjkU/TyfREYNsw2qSGE+qMLI6pHP6PnOkaxRCDa30=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=Nc8/sb21qBfvB8mhQ3Xchs+GxOJYcyZFYIWsUVCGRYo7xkpQ5UggxmXpQ0U18mbEo
         352rdyibSt2YgZf/8PV1rmN8ZNB37FRqqwOvvhq4c/KS3hvLgBUxTtCWowXhXaO3kN
         vvBWDEJhstuSUbxj8bBThSn5RQ6CdW1gg4pjoEmk=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03RBxtKS094040;
        Mon, 27 Apr 2020 06:59:55 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 27
 Apr 2020 06:59:55 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 27 Apr 2020 06:59:55 -0500
Received: from [10.250.151.94] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03RBxppD012048;
        Mon, 27 Apr 2020 06:59:52 -0500
Subject: Re: [PATCH -next] PCI: dwc: pci-dra7xx: Fix potential NULL
 dereference in dra7xx_pcie_probe()
To:     Wei Yongjun <weiyongjun1@huawei.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-omap@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
References: <20200427111044.162618-1-weiyongjun1@huawei.com>
From:   Vignesh Raghavendra <vigneshr@ti.com>
Message-ID: <cad871c8-0915-9dda-2c61-30dfb5504d23@ti.com>
Date:   Mon, 27 Apr 2020 17:29:50 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200427111044.162618-1-weiyongjun1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 27/04/20 4:40 pm, Wei Yongjun wrote:
> platform_get_resource() may fail and return NULL, so we should
> better check it's return value to avoid a NULL pointer dereference
> a bit later in the code.
> 
> This is detected by Coccinelle semantic patch.
> 
> @@
> expression pdev, res, n, t, e, e1, e2;
> @@
> 
> res = \(platform_get_resource\|platform_get_resource_byname\)(pdev, t, n);
> + if (!res)
> +   return -EINVAL;
> ... when != res == NULL
> e = devm_ioremap(e1, res->start, e2);
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/pci/controller/dwc/pci-dra7xx.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> index 3b0e58f2de58..7a3d12f7e7d9 100644
> --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> @@ -878,6 +878,9 @@ static int __init dra7xx_pcie_probe(struct platform_device *pdev)
>  	}
>  
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "ti_conf");
> +	if (!res)
> +		return -EINVAL;
> +
>  	base = devm_ioremap(dev, res->start, resource_size(res));

I don't see why this should be devm_ioremap(). It should also have been
devm_ioremap_resource() which does the NULL check.

Alternately, how about using devm_platform_ioremap_resource_byname()?

>  	if (!base)
>  		return -ENOMEM;
> 
> 
> 
> 
> 
