Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B833FD615
	for <lists+linux-pci@lfdr.de>; Wed,  1 Sep 2021 10:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235800AbhIAJAg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Sep 2021 05:00:36 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:34736 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243144AbhIAJAg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Sep 2021 05:00:36 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210901085938euoutp029c4c5f30542409950fc9fddcf0f345b8~gpxYR4h_g1072610726euoutp02i
        for <linux-pci@vger.kernel.org>; Wed,  1 Sep 2021 08:59:38 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210901085938euoutp029c4c5f30542409950fc9fddcf0f345b8~gpxYR4h_g1072610726euoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1630486778;
        bh=/1GWJyf9MK6LNUf7rLIeoa/dSMUhJddwZqa7qTr55GY=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=d/HQmSx/H9hCQ0lgBqo2maeB6ZIi1anAVuZKyjfssxFM5h4Qh2kxgVPSo4lqBsIpq
         5T4NZ6FqF0kNGUnkNkKeBMSUrpupsjeQm2HmBgXWuY3iQOke/h5hrK0aOsXPTOVMeg
         ZBYu/h8/PITwkXrr+Dln/xY/1VA9WbPVN0+UHjNM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210901085938eucas1p19514e1a426e8cba3cec1948e1ae66667~gpxX_wevz1196611966eucas1p1P;
        Wed,  1 Sep 2021 08:59:38 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 11.89.42068.9F04F216; Wed,  1
        Sep 2021 09:59:37 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210901085937eucas1p2d02da65cac797706ca3a10b8a2eb8ba2~gpxXezz5H1730917309eucas1p25;
        Wed,  1 Sep 2021 08:59:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20210901085937eusmtrp2c07fabf822921f71f6623492e0635ca4~gpxXd7y330123601236eusmtrp2P;
        Wed,  1 Sep 2021 08:59:37 +0000 (GMT)
X-AuditID: cbfec7f4-c71ff7000002a454-2e-612f40f929c8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id CE.72.20981.9F04F216; Wed,  1
        Sep 2021 09:59:37 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210901085936eusmtip18900cbf99202977ada04e8db3280ec0c~gpxWrEZrL3209732097eusmtip1z;
        Wed,  1 Sep 2021 08:59:36 +0000 (GMT)
Subject: Re: [PATCH v4] iommu/of: Fix pci_request_acs() before enumerating
 PCI devices
To:     Wang Xingang <wangxingang5@huawei.com>, robh@kernel.org,
        will@kernel.org, joro@8bytes.org, helgaas@kernel.org
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, xieyingtai@huawei.com,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Robin Murphy <robin.murphy@arm.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <01314d70-41e6-70f9-e496-84091948701a@samsung.com>
Date:   Wed, 1 Sep 2021 10:59:36 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <1621566204-37456-1-git-send-email-wangxingang5@huawei.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7djPc7o/HfQTDd5PtrRoXryezeLVmbVs
        Fgv2W1t0zt7AbrHp8TVWi8u75rBZnJ13nM2ide8Rdov/e3awWxz88ITVYt7NdewWLXdMLXYs
        ncnuwOvx5OA8Jo8189YwerQcecvqsWlVJ5vH/rlr2D02L6n3mHxjOaPH501yARxRXDYpqTmZ
        ZalF+nYJXBnnj5xjLFglXHHh3Cv2BsYT/F2MnBwSAiYSp743MnUxcnEICaxglJi7p4sdwvnC
        KDF/430o5zOjRH/TRmaYlg3XuxghEssZJaZ+bGMBSQgJfGSUaOwKA7GFBSIklrxvB4uLCBRL
        NG39C2YzCyxgkpjYDVbDJmAo0fW2iw3E5hWwk3i9/haYzSKgInF/016welGBZImJTyaxQtQI
        Spyc+QQszingIbH0wVKomfIS29/OYYawxSVuPZkP9o+EwGxOiYXXtzNBXO0i8WjyC6gPhCVe
        Hd/CDmHLSPzfCdPQzCjx8Nxadginh1HictMMRogqa4k7534BnccBtEJTYv0ufYiwo8SaGdtY
        QcISAnwSN94KQhzBJzFp23RmiDCvREebEES1msSs4+vg1h68cIl5AqPSLCSvzULyziwk78xC
        2LuAkWUVo3hqaXFuemqxUV5quV5xYm5xaV66XnJ+7iZGYGI7/e/4lx2My1991DvEyMTBeIhR
        goNZSYSX9aFeohBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHepC1r4oUE0hNLUrNTUwtSi2CyTByc
        Ug1MBmfuRlxccu7dB26BrKTboUKl5+vDeIvlvsdvTmWell7tqOry6TnLX47tclIXw7Lvbjy6
        Ktx7t8XbaFu+VQd5qr6dX+5uNqVJ4FPg3zWyyxTV/Kd4rY1M5qtzUNA149/h8H9Z8pGGPCk2
        49S2Cau73K5qzJUOmiDLcbXz45zdy9qjmR9uEjJmtEqrNLCa9v0O7+aS3pTeND/vvHSNJcdW
        Luf9zbttuTDrtOl9rV9XcX016eK2DmbZu2mpwbL7Aj7n7Z+bb/z/8HLWF9HzYWcvCJR4TvKa
        cy63fAqbsc6C/usHQvMfvSqTDFm94GMww4eqn28Lz7maftwo/pK94oPxM+eVS0qdmC/lqzxg
        tU9RYinOSDTUYi4qTgQAOWa029sDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsVy+t/xu7o/HfQTDbbeE7JoXryezeLVmbVs
        Fgv2W1t0zt7AbrHp8TVWi8u75rBZnJ13nM2ide8Rdov/e3awWxz88ITVYt7NdewWLXdMLXYs
        ncnuwOvx5OA8Jo8189YwerQcecvqsWlVJ5vH/rlr2D02L6n3mHxjOaPH501yARxRejZF+aUl
        qQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehnnj5xjLFglXHHh
        3Cv2BsYT/F2MnBwSAiYSG653MXYxcnEICSxllJi67wcrREJG4uS0BihbWOLPtS42iKL3jBLX
        mp8xgSSEBSIkNr74wwJiiwgUS7x+NIMVpIhZYAGTRM/ar4wgCSEBd4klnz+CTWITMJToegsy
        iZODV8BO4vX6W2A2i4CKxP1Ne8EGiQokS3w4vZQVokZQ4uTMJ2BxTgEPiaUPloLZzAJmEvM2
        P2SGsOUltr+dA2WLS9x6Mp9pAqPQLCTts5C0zELSMgtJywJGllWMIqmlxbnpucVGesWJucWl
        eel6yfm5mxiBsbzt2M8tOxhXvvqod4iRiYPxEKMEB7OSCC/rQ71EId6UxMqq1KL8+KLSnNTi
        Q4ymQP9MZJYSTc4HJpO8knhDMwNTQxMzSwNTSzNjJXFekyNr4oUE0hNLUrNTUwtSi2D6mDg4
        pRqY9qrdDD/wL/l0peLHH1+SKo7k9t50rGKYOnuXZFF+YeRWVvaKdZc3TjO7Guv+YP0bft83
        S3pMOxfri/nxOW3m1XP8yM4w9dZbVfZK6e3CcdvS9LX2x4q0soRGh3WXireoWvz/GRO5Vnxq
        jkCdQuoyD/vOW4t1pbuyPJ+tU1PUt5/510xKe/6W60ytD4qyd3We49jXFl11jmHn8W1sRxIX
        PphlfPDKlVuTZKQ/e/sxbUr8WdOc5fbR5bZI77LYOOGMZ+4dxusKzHwaWVOlPG2U9mRILVU7
        v3/qlXevqzLep8xxudC0n9/5Rk/ef4V9Xfv2pLM8493/KOzKnl3V9m/0pKY0buI5fsLzzrSX
        1kxKLMUZiYZazEXFiQCB4iyHbgMAAA==
X-CMS-MailID: 20210901085937eucas1p2d02da65cac797706ca3a10b8a2eb8ba2
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210901085937eucas1p2d02da65cac797706ca3a10b8a2eb8ba2
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210901085937eucas1p2d02da65cac797706ca3a10b8a2eb8ba2
References: <1621566204-37456-1-git-send-email-wangxingang5@huawei.com>
        <CGME20210901085937eucas1p2d02da65cac797706ca3a10b8a2eb8ba2@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21.05.2021 05:03, Wang Xingang wrote:
> From: Xingang Wang <wangxingang5@huawei.com>
>
> When booting with devicetree, the pci_request_acs() is called after the
> enumeration and initialization of PCI devices, thus the ACS is not
> enabled. And ACS should be enabled when IOMMU is detected for the
> PCI host bridge, so add check for IOMMU before probe of PCI host and call
> pci_request_acs() to make sure ACS will be enabled when enumerating PCI
> devices.
>
> Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when
> configuring IOMMU linkage")
> Signed-off-by: Xingang Wang <wangxingang5@huawei.com>

This patch landed in linux-next as commit 57a4ab1584e6 ("iommu/of: Fix 
pci_request_acs() before enumerating PCI devices"). Sadly it breaks PCI 
operation on ARM Juno R1 board (arch/arm64/boot/dts/arm/juno-r1.dts). It 
looks that the IOMMU controller is not probed for some reasons:

# cat /sys/kernel/debug/devices_deferred
2b600000.iommu

Reverting this patch on top of current linux-next fixes this issue. If 
you need more information to debug this issue, just let me know.

> ---
>   drivers/iommu/of_iommu.c | 1 -
>   drivers/pci/of.c         | 8 +++++++-
>   2 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index a9d2df001149..54a14da242cc 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -205,7 +205,6 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>   			.np = master_np,
>   		};
>   
> -		pci_request_acs();
>   		err = pci_for_each_dma_alias(to_pci_dev(dev),
>   					     of_pci_iommu_init, &info);
>   	} else {
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index da5b414d585a..2313c3f848b0 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -581,9 +581,15 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
>   
>   int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
>   {
> -	if (!dev->of_node)
> +	struct device_node *node = dev->of_node;
> +
> +	if (!node)
>   		return 0;
>   
> +	/* Detect IOMMU and make sure ACS will be enabled */
> +	if (of_property_read_bool(node, "iommu-map"))
> +		pci_request_acs();
> +
>   	bridge->swizzle_irq = pci_common_swizzle;
>   	bridge->map_irq = of_irq_parse_and_map_pci;
>   

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

