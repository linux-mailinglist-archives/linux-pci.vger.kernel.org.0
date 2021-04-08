Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59ABC358486
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 15:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbhDHNWC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Apr 2021 09:22:02 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16420 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhDHNWB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Apr 2021 09:22:01 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FGMLn6Js1zkj2J;
        Thu,  8 Apr 2021 21:20:01 +0800 (CST)
Received: from [10.174.176.73] (10.174.176.73) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 21:21:40 +0800
Subject: Re: [PATCH v2] PCI: xgene-msi: Remove redundant dev_err call in
 xgene_msi_probe()
To:     <toan@os.amperecomputing.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <kw@linux.com>
CC:     <linux-pci@vger.kernel.org>, <yukuai3@huawei.com>
References: <20210408132751.1198171-1-yangerkun@huawei.com>
From:   ErKun Yang <yangerkun@huawei.com>
Message-ID: <213ff609-4e79-35b6-ac1c-c21c6d3314ff@huawei.com>
Date:   Thu, 8 Apr 2021 21:21:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20210408132751.1198171-1-yangerkun@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.73]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+ Krzysztof Wilczyński

Sorry for missing mail-to...

在 2021/4/8 21:27, ErKun Yang 写道:
> devm_ioremap_resource() internally calls __devm_ioremap_resource() which
> is where error checking and handling is actually having place. So the
> dev_err in xgene_msi_probe() seems redundant and remove it.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Reviewed-by: Krzysztof Wilczyński <kw@linux.com>
> Signed-off-by: ErKun Yang <yangerkun@huawei.com>
> ---
>   drivers/pci/controller/pci-xgene-msi.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pci-xgene-msi.c b/drivers/pci/controller/pci-xgene-msi.c
> index 1c34c897a7e2..369b50f626fd 100644
> --- a/drivers/pci/controller/pci-xgene-msi.c
> +++ b/drivers/pci/controller/pci-xgene-msi.c
> @@ -451,7 +451,6 @@ static int xgene_msi_probe(struct platform_device *pdev)
>   	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>   	xgene_msi->msi_regs = devm_ioremap_resource(&pdev->dev, res);
>   	if (IS_ERR(xgene_msi->msi_regs)) {
> -		dev_err(&pdev->dev, "no reg space\n");
>   		rc = PTR_ERR(xgene_msi->msi_regs);
>   		goto error;
>   	}
> 
