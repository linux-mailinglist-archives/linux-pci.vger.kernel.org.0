Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABE9D55C49C
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 14:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232623AbiF0Ka1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jun 2022 06:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiF0Ka0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jun 2022 06:30:26 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3012960FF
        for <linux-pci@vger.kernel.org>; Mon, 27 Jun 2022 03:30:24 -0700 (PDT)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220627103020euoutp023cabebe39583365db5b6e0dd8ca22e5e~8c47kZula1469714697euoutp022
        for <linux-pci@vger.kernel.org>; Mon, 27 Jun 2022 10:30:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220627103020euoutp023cabebe39583365db5b6e0dd8ca22e5e~8c47kZula1469714697euoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656325820;
        bh=BS6P86w0wqnnnvMHN8gPRzZ4VXUHyI/WUBYzCf/0nYg=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=nWEvoffB2iJpaEO7E+WSXL+C0NAsXAix0zLtg6b3MJiv8Hgf1jMsCPJuwKJAwMmvr
         N1x7wilSmeNTIoWknraGi4uJzRhpuWHGTtuuXzYv49IE1cMP8AJzxuKRfFHqlzSnhj
         xoALnElNo0aKwIFI7XzhPqT2xlf7P3oU1oyBFYfA=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220627103020eucas1p1f1af80654881a71f0006b3332a38e959~8c47Q7YlS3040130401eucas1p1y;
        Mon, 27 Jun 2022 10:30:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B8.80.09580.CB689B26; Mon, 27
        Jun 2022 11:30:20 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20220627103019eucas1p231b106b2ac894ad3818dd5fdc9e611f6~8c461fOL62315023150eucas1p2k;
        Mon, 27 Jun 2022 10:30:19 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220627103019eusmtrp261df4cf3f79978890ee10cd2d8402a62~8c460r7ua1616316163eusmtrp2V;
        Mon, 27 Jun 2022 10:30:19 +0000 (GMT)
X-AuditID: cbfec7f5-9adff7000000256c-77-62b986bc1e94
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id CB.2F.09095.BB689B26; Mon, 27
        Jun 2022 11:30:19 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220627103019eusmtip129ecc2c4a43753d04817c30db901d57d~8c46U02qg1080710807eusmtip1j;
        Mon, 27 Jun 2022 10:30:19 +0000 (GMT)
Message-ID: <591f696f-b55c-d267-7fcb-74f7fd4a6900@samsung.com>
Date:   Mon, 27 Jun 2022 12:30:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0)
        Gecko/20100101 Thunderbird/91.10.0
Subject: Re: pci-exynos.c phy_init() usage
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>
Cc:     =?UTF-8?Q?Krzysztof_Wilczy=c5=84ski?= <kw@linux.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <c0c802c0-82e1-e7bb-48be-974ac23b5a15@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djPc7p72nYmGexaymHxYN42NotXZ9ay
        Wdz41cZqseLLTHaLva+3sls09Pxmtdj0+Bqrxdl5x9ksZpzfx+TA6bFz1l12j02rOtk87lzb
        w+bx5Mp0Jo/NS+o9+rasYvT4vEkugD2KyyYlNSezLLVI3y6BK2PRpHPsBSc4K3a8W8HewHib
        vYuRk0NCwETizL4FzCC2kMAKRonJp6O7GLmA7C+MEtdmn2WFcD4zSrxfc5cNpuPnzA8sEInl
        jBJPdrxghnA+MkocfrwWbBavgJ3E3ccLWUFsFgFVicb179kg4oISJ2c+YQGxRQWSJc6dvQoW
        FxbQkrh3bQNYL7OAuMStJ/OZQIaKCKxmlLg/YwI7iMMscJxRYsLO92CXswkYSnS97QLr5gTa
        9mXBVahueYntb+eAnSQh8J9D4nnba6AzOIAcF4mrk7ggfhCWeHV8CzQEZCT+7wTZBlKSL/F3
        hjFEuELi2us1zBC2tcSdc7/YQEqYBTQl1u/Shwg7ShzeO5ERopNP4sZbQYgD+CQmbZvODBHm
        lehoE4KoVpOYdXwd3M6DFy4xT2BUmoUUKLOQPD8LySuzEPYuYGRZxSieWlqcm55abJyXWq5X
        nJhbXJqXrpecn7uJEZimTv87/nUH44pXH/UOMTJxMB5ilOBgVhLhfX19a5IQb0piZVVqUX58
        UWlOavEhRmkOFiVx3uTMDYlCAumJJanZqakFqUUwWSYOTqkGJq7NrUqpd+02b5azXOLpXZn+
        dIrSjCwxx8PrX9zmP6W/I8ZopcifKy1vuT+Gbt87d96Sk6Z/zFbylfjNDi10vnPdMvyHxv8P
        y3NmfXD0tj8U5XEgeaKC4eIoI+uTN93+PZ3xvTT7oiOTtcaNpR1np2fe6TvwOmjeze+iXiJX
        uM/l/evpX866JfPKzCwDwVeFPD5h+4VypvM7de1cVMdT4naSLeD15OXNrN17fEXX/fiq/fuZ
        8qFbT1ZKtl1ZLz0hw21Sq/0JpUcrPhYbONl6iF6yX6O7PeuJq5JYNcNE05sKvxvXSE7qMVSr
        1Jl1fdvNuZ+qduz9+nDelqAn37YnL/fedcDBVKJT+FjWt7ZlfTeUWIozEg21mIuKEwE2M9ee
        wgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsVy+t/xu7q723YmGazpVLd4MG8bm8WrM2vZ
        LG78amO1WPFlJrvF3tdb2S0aen6zWmx6fI3V4uy842wWM87vY3Lg9Ng56y67x6ZVnWwed67t
        YfN4cmU6k8fmJfUefVtWMXp83iQXwB6lZ1OUX1qSqpCRX1xiqxRtaGGkZ2hpoWdkYqlnaGwe
        a2VkqqRvZ5OSmpNZllqkb5egl7Fo0jn2ghOcFTverWBvYLzN3sXIySEhYCLxc+YHli5GDg4h
        gaWMEh+yIcIyEienNbBC2MISf651sXUxcgGVvGeUWPB1NwtIglfATuLu44VgRSwCqhKN69+z
        QcQFJU7OfAJWIyqQLNG85RATiC0soCVx79oGZhCbWUBc4taT+UwgQ0UEVjNKvNp9lAXEYRY4
        zijxcN4Fdoh12xklXrccAhvFJmAo0fW2C2wFJ9DqLwuuQo0yk+ja2sUIYctLbH87h3kCo9As
        JJfMQrJxFpKWWUhaFjCyrGIUSS0tzk3PLTbUK07MLS7NS9dLzs/dxAiMzm3Hfm7ewTjv1Ue9
        Q4xMHIyHGCU4mJVEeF9f35okxJuSWFmVWpQfX1Sak1p8iNEUGBwTmaVEk/OB6SGvJN7QzMDU
        0MTM0sDU0sxYSZzXs6AjUUggPbEkNTs1tSC1CKaPiYNTqoGpdtrkToXDOy4kLXPa53mxXN/t
        dsGlgheqUzSvueevyfdLeZ3511Vmj97urAOpr+4d23zZSHNXb1+oYeqtrkLnV9en8Qfvm/5G
        wq+zd1qf9Zooy50hU+2l56+28f/hN9dsr1TAW7sT3Y/zgq0amHg/fHh1sYllafbkV08EH7hb
        Xi/eXpL6QDz015rivBeq6Se9HodMmmLJr5ZUoHbS5X/R1JBFCcdrQgpzV7f55W+79Ewq0654
        0/t2/xO2yfN2371mzZPsfmVR/UaxVXcvv9g599s+SbePsxUjMsRSvfZtED2quPySQ5Hk8tkH
        e+Xn+fAe/1Ec2fg6q9D+p7WFLdeBh7zcpqVZz3XX205+VmijxFKckWioxVxUnAgAr4dHFVcD
        AAA=
X-CMS-MailID: 20220627103019eucas1p231b106b2ac894ad3818dd5fdc9e611f6
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220624180806eucas1p16a18d9598c0a08770b428cd58916b65d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220624180806eucas1p16a18d9598c0a08770b428cd58916b65d
References: <20220624173541.GA1543581@bhelgaas>
        <CGME20220624180806eucas1p16a18d9598c0a08770b428cd58916b65d@eucas1p1.samsung.com>
        <c0c802c0-82e1-e7bb-48be-974ac23b5a15@linaro.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 24.06.2022 20:07, Krzysztof Kozlowski wrote:
> On 24/06/2022 19:35, Bjorn Helgaas wrote:
>> In exynos_pcie_host_init() [1], we call:
>>
>>    phy_reset(ep->phy);
>>    phy_power_on(ep->phy);
>>    phy_init(ep->phy);
>>
>> The phy_init() function comment [2] says it must be called before
>> phy_power_on().  Is exynos doing this backwards?
> Looks like. I don't have Exynos hardware with a PCI, so cannot
> test/fix/verify.
>
> Luckily for Exynos ;-) it's not alone in this pattern:
> drivers/net/ethernet/marvell/sky2.c
> drivers/usb/dwc2/platform.c

I've checked that on the real hardware. Swapping the order of 
phy_power_on and phy_init breaks driver operation.

However pci-exynos is the only driver that uses the phy-exynos-pcie, so 
we can simply swap the content of the init and power_on in the phy 
driver to adjust the code to the right order. power_on/init and 
exit/power_off are also called one after the other in pci-exynos, 
without any activity between them, so we can also simply move all 
operation to one pair of the callback, like power_on/off.

Krzysztof, which solution would you prefer?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

