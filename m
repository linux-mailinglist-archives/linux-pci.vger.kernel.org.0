Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFF3A2985A3
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 03:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421541AbgJZCtt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 25 Oct 2020 22:49:49 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:10977 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389274AbgJZCtt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 25 Oct 2020 22:49:49 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201026024946epoutp01aa7fb9f09f8606518506edcdb6822886~Bav8gH4rH0958409584epoutp012
        for <linux-pci@vger.kernel.org>; Mon, 26 Oct 2020 02:49:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201026024946epoutp01aa7fb9f09f8606518506edcdb6822886~Bav8gH4rH0958409584epoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603680586;
        bh=etEYkZCcrpL2KaF9YUbH57RFkXefdoCn9HYq/ea+4FU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=u/NvKk6ATK3g4Z/1i3/hcYIhLKs/jLdc5Qcd/Ngo6g+ozh4ZoCNiedzv3jxZwLXtB
         fojrD4y5STBNYV/diWqpzUmJpt6jr9rVLDunmRLfYx3W724ghw2LOjZ8KSK4b5I7wE
         fazWad2w/j7o7eYzDuML7R7b0t26U4I5QxFk3aos=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201026024945epcas1p2e0d2e2da646cc360792b0f3e6c029ee0~Bav76dkLk1245712457epcas1p2C;
        Mon, 26 Oct 2020 02:49:45 +0000 (GMT)
Received: from epsmges1p1.samsung.com (unknown [182.195.40.152]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4CKK7C3S9YzMqYkm; Mon, 26 Oct
        2020 02:49:43 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        3C.3D.09543.249369F5; Mon, 26 Oct 2020 11:49:38 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTPA id
        20201026024937epcas1p33bc137c4f7d1d754415d93925ecd42bf~Bavz39oPE1306713067epcas1p3d;
        Mon, 26 Oct 2020 02:49:37 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201026024937epsmtrp14f608951874d345a1401e54fe3a9fa15~Bavz3OttJ2619026190epsmtrp1U;
        Mon, 26 Oct 2020 02:49:37 +0000 (GMT)
X-AuditID: b6c32a35-35dff70000002547-6f-5f9639425dc7
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2C.A5.08745.049369F5; Mon, 26 Oct 2020 11:49:36 +0900 (KST)
Received: from [10.113.113.235] (unknown [10.113.113.235]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201026024936epsmtip2f332ea73972da86ff5a43f4d57c4bb7e~BavzhTsMN1398313983epsmtip2M;
        Mon, 26 Oct 2020 02:49:36 +0000 (GMT)
Subject: Re: [PATCH v2 5/6] pci: dwc: pci-exynos: rework the driver to
 support Exynos5433 variant
To:     Jingoo Han <jingoohan1@gmail.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Jaehoon Chung <jh80.chung@samsung.com>
Message-ID: <29fa2071-dd4e-4528-d2db-dcd86e443794@samsung.com>
Date:   Mon, 26 Oct 2020 11:49:44 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
        Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <SLXP216MB047790A7FD4D1E7304493343AA1B0@SLXP216MB0477.KORP216.PROD.OUTLOOK.COM>
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrJJsWRmVeSWpSXmKPExsWy7bCmnq6T5bR4g4UnBSyWNGVYzD9yjtVi
        xZeZ7BYXnvawWZw/v4Hd4vKuOWwWZ+cdZ7OYcX4fk8Wb3y/YLdYeuctu0br3CLvFzjsnmB14
        PNbMW8PosXPWXXaPBZtKPTat6mTz6NuyitHj+I3tTB6fN8kFsEdl22SkJqakFimk5iXnp2Tm
        pdsqeQfHO8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYA3amkUJaYUwoUCkgsLlbSt7Mpyi8t
        SVXIyC8usVVKLUjJKbAs0CtOzC0uzUvXS87PtTI0MDAyBSpMyM74uUG+YJNQxY8JS5gbGG/z
        dTFyckgImEjseXKbrYuRi0NIYAejxKJrU6CcT4wSJyfuYoVwPjNK7F9zgBmm5eCrRcwQiV2M
        EpunH2GEcN4zSnx73gRWJSyQLLH6+mQmkISIwC1GiQcnmsBmMQu8YJI4d/YlI0gVm4COxPZv
        x4GqODh4Bewkfr6yBjFZBFQlTp8VBKkQFYiU2Pn0JTuIzSsgKHFy5hMWEJtTIEaivfUn2C5m
        AXGJW0/mM0HY8hLb384Bu05C4ACHxJR7P1ghznaR2HFjHtQLwhKvjm9hh7ClJF72t0HZ1RK7
        ms9ANXcwStza1sQEkTCW2L90MtidzAKaEut36UOEFSV2/p7LCLGYT+Ld1x5WkBIJAV6JjjYh
        iBIViUuvXzLBrLr75D/UOR4SB099Y5vAqDgLyWuzkLwzC8k7sxAWL2BkWcUollpQnJueWmxY
        YIgc25sYwWlYy3QH48S3H/QOMTJxMB5ilOBgVhLhnSMzNV6INyWxsiq1KD++qDQntfgQoykw
        rCcyS4km5wMzQV5JvKGpkbGxsYWJoZmpoaGSOO8f7Y54IYH0xJLU7NTUgtQimD4mDk6pBiar
        cHvOVn8WnmnCPHL/+1NebvBZNunUy99Tlu58rF/08pKQ+fymq9tFZeJ631dlJsQ63Am3e+Pj
        Jv1Uc9HeIvHLEpsdtgVN4VrjWWMXyWPlMbfaa+W3U8b3hc5sC3scwc/efelR0/NH/65UKV8L
        KtbuvvfEemNLcf3pd10heWurf8SXepY5M17N2eTQGv9L4fmd01mKp55rLDte/vH5A5ML8p/b
        /0Zv5Cr/orD16+VP/YoJ986/+RlvHTNfaHO/hiXnok/TElcVfpyud+RXVjbD4kmzNj3u5F51
        z3Qqr0t9bUx8z62XHwT0P8ooVk5/IMMz61yBdtuCJ+FxKz3kZhq5eW7+tWFG6V2dT/p3F8gp
        sRRnJBpqMRcVJwIA+oNz0UwEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKIsWRmVeSWpSXmKPExsWy7bCSvK6D5bR4g4+dJhZLmjIs5h85x2qx
        4stMdosLT3vYLM6f38BucXnXHDaLs/OOs1nMOL+PyeLN7xfsFmuP3GW3aN17hN1i550TzA48
        HmvmrWH02DnrLrvHgk2lHptWdbJ59G1Zxehx/MZ2Jo/Pm+QC2KO4bFJSczLLUov07RK4Mn5u
        kC/YJFTxY8IS5gbG23xdjJwcEgImEgdfLWIGsYUEdjBKzH9rChGXkvj8dCpbFyMHkC0scfhw
        cRcjF1DJW0aJqbdOsIDUCAskS7RPeM4CkhARuMUocX/RSzYQh1ngFZPEvN5pjBAt05kkjm2b
        wA7SwiagI7H923EmkLG8AnYSP19Zg5gsAqoSp88KgpiiApESO3dYghTzCghKnJz5BGwXp0CM
        RHvrT7A7mQXUJf7MuwRli0vcejKfCcKWl9j+dg7zBEahWUjaZyFpmYWkZRaSlgWMLKsYJVML
        inPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYJjTktrB+OeVR/0DjEycTAeYpTgYFYS4Z0jMzVe
        iDclsbIqtSg/vqg0J7X4EKM0B4uSOO/XWQvjhATSE0tSs1NTC1KLYLJMHJxSDUyzFS7J2P2S
        UT4drvt9Rt65r/m5xTx8fjsXRiSsMS3QMZE98zzzdejfX2ouxW3/s6fszDR6H9rL3CSfF9G7
        wypm/5aDMUble4ujXD8JzFFmj+PUW8g2MS5AyefxjeKXyxY6KrMc1S8PvLHG+eGvkJQNxzgM
        Jr+YKN3kov44czMj2+T6t3LHrz8+uczos1bBmn7DtYKLlr3Z3rrld/PyqO5YhnSPqtzz2QcN
        vLqCt1u7rGM4qc7TzP418WUP73fj0MLFLyJE+Re0H3tde7Cdn2nFo0NcwoUMtvNunApb3zV5
        6otMQ5v5bjuM9OcoejO1WXb4cwRsrNogyMl2OnXx67kPbC//YEvTf9OWkpEjp8RSnJFoqMVc
        VJwIAJfYVf0oAwAA
X-CMS-MailID: 20201026024937epcas1p33bc137c4f7d1d754415d93925ecd42bf
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201023075756eucas1p18765653e747842eef4b438aff32ef136
References: <20201023075744.26200-1-m.szyprowski@samsung.com>
        <CGME20201023075756eucas1p18765653e747842eef4b438aff32ef136@eucas1p1.samsung.com>
        <20201023075744.26200-6-m.szyprowski@samsung.com>
        <SLXP216MB047790A7FD4D1E7304493343AA1B0@SLXP216MB0477.KORP216.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dear Jingoo,

On 10/24/20 12:12 PM, Jingoo Han wrote:
> On 10/23/20, 3:58 AM, Marek Szyprowski wrote:
>>
>> From: Jaehoon Chung <jh80.chung@samsung.com>
>>
>> Exynos5440 SoC support has been dropped since commit 8c83315da1cf ("ARM:
>> dts: exynos: Remove Exynos5440"). Rework this driver to support DWC PCIe
>> variant found in the Exynos5433 SoCs.
>>
>> The main difference in Exynos5433 variant is lack of the MSI support
>> (the MSI interrupt is not even routed to the CPU).
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> [mszyprow: reworked the driver to support only Exynos5433 variant,
>> 	   simplified code, rebased onto current kernel code, added
>> 	   regulator support, converted to the regular platform driver,
>> 	   removed MSI related code, rewrote commit message]
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>> ---
>>  drivers/pci/controller/dwc/Kconfig      |   3 +-
>>  drivers/pci/controller/dwc/pci-exynos.c | 358 ++++++++++--------------
>>  drivers/pci/quirks.c                    |   1 +
>>  3 files changed, 145 insertions(+), 217 deletions(-)
> 
> [....]
> 
>> diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
>> index 242683cde04a..58056fbdc2fa 100644
>> --- a/drivers/pci/controller/dwc/pci-exynos.c
>> +++ b/drivers/pci/controller/dwc/pci-exynos.c
>> @@ -2,26 +2,23 @@
>>  /*
>>   * PCIe host controller driver for Samsung Exynos SoCs
>>   *
>> - * Copyright (C) 2013 Samsung Electronics Co., Ltd.
>> + * Copyright (C) 2013-2020 Samsung Electronics Co., Ltd.
>>   *		https://www.samsung.com
>>   *
>>   * Author: Jingoo Han <jg1.han@samsung.com>
>> + *	   Jaehoon Chung <jh80.chung@samsung.com>
> 
> Would you explain the reason why you add him as an author?
> If reasonable, I will accept it. Also, I want gentle discussion, not aggressive one.
> Thank you.

It's not important to add me as author. :)
If you don't want to accept it, i think it can be removed it.
I think that pci-exynos was supported on only exynos5440.
As you know, exynos5440 was not common as compared with other exynos SoC.
After this patch, pci-exynos is re-newed.

Best Regards,
Jaehoon Chung

> 
> Best regards,
> Jingoo Han
> 
>>   */
> 
> [....]
> 

