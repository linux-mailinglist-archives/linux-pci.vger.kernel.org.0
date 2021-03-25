Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF8F348CB7
	for <lists+linux-pci@lfdr.de>; Thu, 25 Mar 2021 10:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhCYJYp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Mar 2021 05:24:45 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:48485 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbhCYJYc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Mar 2021 05:24:32 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210325092430euoutp01915a8156f82fb66db630c7e0c2250c79~vi5alIZah2608626086euoutp01N
        for <linux-pci@vger.kernel.org>; Thu, 25 Mar 2021 09:24:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210325092430euoutp01915a8156f82fb66db630c7e0c2250c79~vi5alIZah2608626086euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1616664270;
        bh=4nZTfqFXPrsScvJfwc/c+eBJ5+ZNv+Y/FOMxLuWtpZc=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=Hr2FGZ+DlKP1jpGs488NkHjciE+HB8Gx1NCcC3TPMgOaM4izbW6n+wOJwTrq5h2Nq
         q0ftz/8/9xXPyjgY+d70lX/5G52FC3MNXuYs5cilj11z4Ct10srziNuCgnqR39xZOm
         Rq2WagvDCi9ivZ4mo5kbSxg9oZkYR3SOl76B9PzM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210325092429eucas1p106479fc7bf90e39b3074f303b535a37a~vi5aJCOTf1386513865eucas1p1P;
        Thu, 25 Mar 2021 09:24:29 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id D3.4A.09444.DC65C506; Thu, 25
        Mar 2021 09:24:29 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210325092429eucas1p25e95dd1920f2a1c9f808c72d10d1952d~vi5ZvzGiJ2937029370eucas1p2V;
        Thu, 25 Mar 2021 09:24:29 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210325092429eusmtrp185501bcc08513c92f0f956c63ed1afce~vi5ZvDUiI0207502075eusmtrp1e;
        Thu, 25 Mar 2021 09:24:29 +0000 (GMT)
X-AuditID: cbfec7f4-dd5ff700000024e4-7c-605c56cd9c68
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 60.09.08696.DC65C506; Thu, 25
        Mar 2021 09:24:29 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210325092428eusmtip1278fea7145449b5197a62306e9c55020~vi5ZFerjl1001710017eusmtip1j;
        Thu, 25 Mar 2021 09:24:28 +0000 (GMT)
Subject: Re: [PATCH] PCI: dwc: Move forward the iATU detection process
To:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com
Cc:     robh@kernel.org, bhelgaas@google.com,
        gustavo.pimentel@synopsys.com, jingoohan1@gmail.com,
        =?UTF-8?B?7KCV7J6s7ZuI?= <jh80.chung@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <21daa79d-cdb3-f31c-0fbf-5d653de02517@samsung.com>
Date:   Thu, 25 Mar 2021 10:24:28 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210125044803.4310-1-Zhiqiang.Hou@nxp.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCKsWRmVeSWpSXmKPExsWy7djPc7pnw2ISDI4vMrZY0pRhsetuB7vF
        jV9trBYrvsxkt7i8aw6bxdl5x9ks3vx+wW7xf88OdosTbR/YHTg91sxbw+ixc9Zddo8Fm0o9
        Nq3qZPPY+G4Hk0ffllWMHlv2f2b0+LxJLoAjissmJTUnsyy1SN8ugStj58ZNbAUbFSvaJi1i
        amC8Jt3FyMkhIWAi0X+vk6WLkYtDSGAFo8Sp56uhnC+MEof7l7BDOJ8ZJSb/OM3cxcgB1rLw
        WxFEfDmjxIYv+5kgnI+MEp3b/rOBzBUWcJOY+3oqO0iDiECtxMxjQiA1zAKTGCUWbLvMDFLD
        JmAo0fW2C6yeV8BO4sPlRSwgNouAqkTz7NtgvaICSRIbDsVClAhKnJz5BKyEU8BS4tL8xWBj
        mAXkJba/nQNli0vcejIf7B4Jgf8cEg0X9zBC/Oki0XrqF5QtLPHq+BZ2CFtG4vTkHhaIhmZG
        iYfn1rJDOD2MEpebZkB1WEvcOfeLDeQiZgFNifW79CHCjhKt/WdZIKHCJ3HjrSDEEXwSk7ZN
        hwYWr0RHmxBEtZrErOPr4NYevHCJeQKj0iwkr81C8s4sJO/MQti7gJFlFaN4amlxbnpqsVFe
        arlecWJucWleul5yfu4mRmDCOv3v+JcdjMtffdQ7xMjEwXiIUYKDWUmEN8k3JkGINyWxsiq1
        KD++qDQntfgQozQHi5I4b9KWNfFCAumJJanZqakFqUUwWSYOTqkGpgk3fpodWLr8cfGZJ88y
        /KbkL1jpEztZSPRUx7+zztc3+TZ/u3rN99etLQen13ZpxjXcslonqKvkUFtwi/uI9OH/jHIy
        Rfq7ZXyOC/YKBT59VyzzLDLqp8IDK93IxSKT/aOaKnpv7eqwNfzz9N6OADGWE9paYXf4pP/p
        nhSY/KHhc+TXFUEuU5IuHBS4pK4w9bDq+0sxGS1qFQptH492HEvWvqwXc/zbPtM5Rl+Es7kW
        r368K/6psv5qvaVbFxQ2Xn7Rv/O1U49josc/s2Az4z+Op4351NbbmHzqY9FokFOofZAqvoVb
        7dVthdV3lPaxCi08fDxh7wml6Xs8nipIPHvUqZO+Kyhlypo1/DLT/ymxFGckGmoxFxUnAgBP
        oY8bxwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xu7pnw2ISDDZOlbRY0pRhsetuB7vF
        jV9trBYrvsxkt7i8aw6bxdl5x9ks3vx+wW7xf88OdosTbR/YHTg91sxbw+ixc9Zddo8Fm0o9
        Nq3qZPPY+G4Hk0ffllWMHlv2f2b0+LxJLoAjSs+mKL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRS
        z9DYPNbKyFRJ384mJTUnsyy1SN8uQS9j58ZNbAUbFSvaJi1iamC8Jt3FyMEhIWAisfBbURcj
        J4eQwFJGiStT5UFsCQEZiZPTGlghbGGJP9e62LoYuYBq3jNKbNv4kA0kISzgJjH39VR2EFtE
        oFaibeF9ZpAiZoFJjBJn2vczQ0y1kHh0bwYTiM0mYCjR9bYLrJlXwE7iw+VFLCA2i4CqRPPs
        22CDRAWSJC4vmcgKUSMocXLmE7AaTgFLiUvzF4PNZBYwk5i3+SGULS+x/e0cKFtc4taT+UwT
        GIVmIWmfhaRlFpKWWUhaFjCyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiM0G3Hfm7Zwbjy
        1Ue9Q4xMHIyHGCU4mJVEeJN8YxKEeFMSK6tSi/Lji0pzUosPMZoC/TORWUo0OR+YIvJK4g3N
        DEwNTcwsDUwtzYyVxHlNjqyJFxJITyxJzU5NLUgtgulj4uCUamBanONc2yfxMOtRuafJpyJB
        g6LZV4JyUzVEuhj91SWUwjbd3rhu6izL7tplFx/e5dU8WycpPHXzMc5czkIXs7La7ctbqr9I
        MRVVs11jUy78ttL079qt7sa7A9tSBA9HLuibeLE/Jm75Bw0xQx1PH8MZc17en/TiaEJ2t/LT
        kgar3kXJP+9n+y7iNLay4HGJlUk4tXJZQMvWlauzcnwipXnnzmYJOW5ztU3ZR5Ov68w5s+s8
        fp1G64Pm7N3MEW6aJr7TdP0kf25rUY0irbe8ETFBEXMPXOvUVDy2fHeypdkL3mIzCftdQsqC
        Wardlfdk2X9NPLK5svcqh7Kw5B2RXy+z80PL39jOyXxhMLdGiaU4I9FQi7moOBEA0C1GaFkD
        AAA=
X-CMS-MailID: 20210325092429eucas1p25e95dd1920f2a1c9f808c72d10d1952d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210325092429eucas1p25e95dd1920f2a1c9f808c72d10d1952d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210325092429eucas1p25e95dd1920f2a1c9f808c72d10d1952d
References: <20210125044803.4310-1-Zhiqiang.Hou@nxp.com>
        <CGME20210325092429eucas1p25e95dd1920f2a1c9f808c72d10d1952d@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 25.01.2021 05:48, Zhiqiang Hou wrote:
> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>
> In the dw_pcie_ep_init(), it depends on the detected iATU region
> numbers to allocate the in/outbound window management bit map.
> It fails after the commit 281f1f99cf3a ("PCI: dwc: Detect number
> of iATU windows").
>
> So this patch move the iATU region detection into a new function,
> move forward the detection to the very beginning of functions
> dw_pcie_host_init() and dw_pcie_ep_init(). And also remove it
> from the dw_pcie_setup(), since it's more like a software
> perspective initialization step than hardware setup.
>
> Fixes: 281f1f99cf3a ("PCI: dwc: Detect number of iATU windows")
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

This patch causes exynos-pcie to hang during the initialization. It 
looks that some resources are not enabled yet, so calling 
dw_pcie_iatu_detect() much earlier causes a hang. When I have some time, 
I will try to identify what is needed to call it properly.

> ---
>   drivers/pci/controller/dwc/pcie-designware-ep.c   |  2 ++
>   drivers/pci/controller/dwc/pcie-designware-host.c |  2 ++
>   drivers/pci/controller/dwc/pcie-designware.c      | 11 ++++++++---
>   drivers/pci/controller/dwc/pcie-designware.h      |  1 +
>   4 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index bcd1cd9ba8c8..fcf935bf6f5e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -707,6 +707,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>   		}
>   	}
>   
> +	dw_pcie_iatu_detect(pci);
> +
>   	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
>   	if (!res)
>   		return -EINVAL;
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 8a84c005f32b..8eae817c138d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -316,6 +316,8 @@ int dw_pcie_host_init(struct pcie_port *pp)
>   			return PTR_ERR(pci->dbi_base);
>   	}
>   
> +	dw_pcie_iatu_detect(pci);
> +
>   	bridge = devm_pci_alloc_host_bridge(dev, 0);
>   	if (!bridge)
>   		return -ENOMEM;
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 5b72a5448d2e..5b9bf02d918b 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -654,11 +654,9 @@ static void dw_pcie_iatu_detect_regions(struct dw_pcie *pci)
>   	pci->num_ob_windows = ob;
>   }
>   
> -void dw_pcie_setup(struct dw_pcie *pci)
> +void dw_pcie_iatu_detect(struct dw_pcie *pci)
>   {
> -	u32 val;
>   	struct device *dev = pci->dev;
> -	struct device_node *np = dev->of_node;
>   	struct platform_device *pdev = to_platform_device(dev);
>   
>   	if (pci->version >= 0x480A || (!pci->version &&
> @@ -687,6 +685,13 @@ void dw_pcie_setup(struct dw_pcie *pci)
>   
>   	dev_info(pci->dev, "Detected iATU regions: %u outbound, %u inbound",
>   		 pci->num_ob_windows, pci->num_ib_windows);
> +}
> +
> +void dw_pcie_setup(struct dw_pcie *pci)
> +{
> +	u32 val;
> +	struct device *dev = pci->dev;
> +	struct device_node *np = dev->of_node;
>   
>   	if (pci->link_gen > 0)
>   		dw_pcie_link_set_max_speed(pci, pci->link_gen);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 5d979953800d..867369d4c4f7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -305,6 +305,7 @@ int dw_pcie_prog_inbound_atu(struct dw_pcie *pci, u8 func_no, int index,
>   void dw_pcie_disable_atu(struct dw_pcie *pci, int index,
>   			 enum dw_pcie_region_type type);
>   void dw_pcie_setup(struct dw_pcie *pci);
> +void dw_pcie_iatu_detect(struct dw_pcie *pci);
>   
>   static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
>   {

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

