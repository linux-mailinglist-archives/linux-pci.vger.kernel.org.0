Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 602BB392FCF
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 15:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236007AbhE0NfR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 09:35:17 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:2317 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235947AbhE0NfP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 27 May 2021 09:35:15 -0400
Received: from dggeml701-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4FrTDc6D4sz1BFVX;
        Thu, 27 May 2021 21:29:04 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggeml701-chm.china.huawei.com (10.3.17.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 27 May 2021 21:33:39 +0800
Received: from [10.174.177.210] (10.174.177.210) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 27 May 2021 21:33:39 +0800
Subject: Re: [PATCH v2] PCI: xgene-msi: Remove redundant dev_err call in
 xgene_msi_probe()
To:     <toan@os.amperecomputing.com>, <lorenzo.pieralisi@arm.com>,
        <robh@kernel.org>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <yukuai3@huawei.com>
References: <20210408132751.1198171-1-yangerkun@huawei.com>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <b91f0b24-07c4-094c-4f9e-04d9530136b6@huawei.com>
Date:   Thu, 27 May 2021 21:33:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210408132751.1198171-1-yangerkun@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.210]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema766-chm.china.huawei.com (10.1.198.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ping...

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
