Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00DB17EBF1B
	for <lists+linux-pci@lfdr.de>; Wed, 15 Nov 2023 10:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbjKOJHJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Nov 2023 04:07:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbjKOJHI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Nov 2023 04:07:08 -0500
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7967114
        for <linux-pci@vger.kernel.org>; Wed, 15 Nov 2023 01:07:04 -0800 (PST)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20231115090703euoutp0169c59d9a6afd2f10a4dff9d27074b064~XwKqKQvSM2304923049euoutp01I
        for <linux-pci@vger.kernel.org>; Wed, 15 Nov 2023 09:07:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20231115090703euoutp0169c59d9a6afd2f10a4dff9d27074b064~XwKqKQvSM2304923049euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1700039223;
        bh=4c/MecdrukIl8E9ts4Zem79Sv0ehscpjzOJZLIR48xc=;
        h=Date:From:Subject:To:Cc:In-Reply-To:References:From;
        b=rc/Tojdn6BAxp/29cnd5fY3mynIRPr6kYL7HaEZYsapypX/pTJACzggHjjV0ac1Yb
         a1p7ChaOdnutgSqUb7uIXqtAkN9lNhKiGLRrrAA1Nq12TCusIhbQmosYBpcXi/nT0m
         UEQM7wO+zrARnqad0rm75ku3SQeX0XS0LZD4C44I=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20231115090702eucas1p232cc8bd41af130a7b076e2a93967815a~XwKpqfXja0817608176eucas1p2S;
        Wed, 15 Nov 2023 09:07:02 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 27.5C.09539.63A84556; Wed, 15
        Nov 2023 09:07:02 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20231115090701eucas1p1f759f3cd2e79837bf3778295bcedd20e~XwKpKG7Ln1373313733eucas1p19;
        Wed, 15 Nov 2023 09:07:01 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20231115090701eusmtrp21e7508f04f040a8830e581f2c8ceb885~XwKpFjQbr0212702127eusmtrp2B;
        Wed, 15 Nov 2023 09:07:01 +0000 (GMT)
X-AuditID: cbfec7f2-515ff70000002543-64-65548a364c15
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 75.0A.09274.53A84556; Wed, 15
        Nov 2023 09:07:01 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20231115090701eusmtip1733fe67bb7aef9bed6dd4f8148c206e5~XwKoSqeCm1311813118eusmtip1Q;
        Wed, 15 Nov 2023 09:07:00 +0000 (GMT)
Message-ID: <fc7d60ea-c48a-4666-8b69-0572ba2c66b1@samsung.com>
Date:   Wed, 15 Nov 2023 10:07:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] PCI: exynos: Adapt to clk_bulk_* APIs
To:     Shradha Todi <shradha.t@samsung.com>,
        'Manivannan Sadhasivam' <manivannan.sadhasivam@linaro.org>
Cc:     jingoohan1@gmail.com, lpieralisi@kernel.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com,
        krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        pankaj.dubey@samsung.com
Content-Language: en-US
In-Reply-To: <000b01da178e$a43088d0$ec919a70$@samsung.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djPc7pmXSGpBr+3S1g8mLeNzWJJU4bF
        ii8z2S32vt7KbtHQ85vVYtPja6wWl3fNYbM4O+84m8WM8/uYLFr+tLBY3G3pZLVYtPULu8X/
        PTvYLXoP1zrweeycdZfdY8GmUo9NqzrZPO5c28Pm8eTKdCaPzUvqPfq2rGL0+LxJLoAjissm
        JTUnsyy1SN8ugStj5hnlghcqFVMX32NpYOyX62Lk5JAQMJHYtKWfrYuRi0NIYAWjxInNs5gg
        nC+MEssbFrNDOJ8ZJW5e28UO0/Ji2iqoxHJGiW0zeqH6PwJVnd7GBFLFK2AnsXdhA3MXIwcH
        i4CqRPtBfYiwoMTJmU9YQGxRAXmJ+7dmgA1lEzCU6HrbxQZiCwtYScy6cQYsLiKQJvFlTRPY
        fGaBA0wSO148AGtmFhCXuPVkPtguTqCGdVvnsULE5SW2v53DDNIgITCfU+Lr+14WiLNdJHpv
        NbBB2MISr45vgXpHRuL/zvlMEA3tjBILft+HciYwSjQ8v8UIUWUtcefcLzaQd5gFNCXW79KH
        CDtKLN/3GexLCQE+iRtvBSGO4JOYtG06VJhXoqNNCKJaTWLW8XVwaw9euMQ8gVFpFlK4zELy
        2iwk78xC2LuAkWUVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYII7/e/4px2Mc1991DvE
        yMTBeIhRgoNZSYTXXC4kVYg3JbGyKrUoP76oNCe1+BCjNAeLkjivaop8qpBAemJJanZqakFq
        EUyWiYNTqoFJ7mbqqinnXGedblPLWO+SJBwS9C/Kd/L+wJrYOXwHv0yd/X9a/gqJfYLP9q4U
        3/9RVVyV7ZRrkMqpAsfKyhM8f9/92/l4n8ujYsE9qe9PHD42UbAk8X2WX4vtG4eChWWXFgj0
        mSSemRXjWefK2jdF57f//2ltkl36zeUSC74YXzNSu//t8aHiKeEu/57pfbm49efW+NK/TwuV
        0hwKDs4KXHZetr1hXtPaO7fiqn4y1W7pXB7pV5e27/T6lfKVZY5Shfwl3pv2m6z1W3qBu9G7
        KcpyY1rUsm2STJ9lDqxZ/WzavPQJ/p6BblV7bcSvyXu6XV3DIOV6+9ClKpEczadfnrd+CwxI
        mb16oePd+T6nlViKMxINtZiLihMBd3cPM98DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsVy+t/xu7qmXSGpBh8fGlo8mLeNzWJJU4bF
        ii8z2S32vt7KbtHQ85vVYtPja6wWl3fNYbM4O+84m8WM8/uYLFr+tLBY3G3pZLVYtPULu8X/
        PTvYLXoP1zrweeycdZfdY8GmUo9NqzrZPO5c28Pm8eTKdCaPzUvqPfq2rGL0+LxJLoAjSs+m
        KL+0JFUhI7+4xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9j5hnlghcq
        FVMX32NpYOyX62Lk5JAQMJF4MW0VexcjF4eQwFJGidO7Z7NBJGQkTk5rYIWwhSX+XOtigyh6
        zyhxe84xsCJeATuJvQsbmLsYOThYBFQl2g/qQ4QFJU7OfMICYosKyEvcvzWDHcRmEzCU6Hrb
        BdYqLGAlMevGGbC4iECaxK7FO1lB5jMLHGCSWNf4HmrZQ0aJl1NbwDqYBcQlbj2ZzwRicwJ1
        r9s6jxUibibRtbWLEcKWl9j+dg7zBEahWUgOmYWkfRaSlllIWhYwsqxiFEktLc5Nzy020itO
        zC0uzUvXS87P3cQIjOhtx35u2cG48tVHvUOMTByMhxglOJiVRHjN5UJShXhTEiurUovy44tK
        c1KLDzGaAgNjIrOUaHI+MKXklcQbmhmYGpqYWRqYWpoZK4nzehZ0JAoJpCeWpGanphakFsH0
        MXFwSjUwadxL69utufZJZsjDlTb5K45/MrPXmWekdC9bw2jf9m33n+bmbvMKYLid6n8p50wU
        V+iZvD1yksfcWSa/ueTXZSPwpl/zOufTz+UHP1zd3mdiblfw6PVxodU9G5UKTfUWbtApawx4
        cDu++OU0+StvC+OePeYpdOVSVGfxs+F/yDg9buVdrWZ1PuU+l12FPEVzp7SLKR+Sr18663mf
        5PWbesvMtV8/u6b2OZXz3kSz3v6Dyofu1zGf+sX8XMpyxjEl8QpTxS4XnrURK9lTvgkls0/c
        49Z5IFcj/Gf92y38p94WLme0t14awCtpcMbJQLb9ea1eUmtQ8755znH35KTPGBxrTMi5G8dg
        azm/cJsSS3FGoqEWc1FxIgANAsPNcQMAAA==
X-CMS-MailID: 20231115090701eucas1p1f759f3cd2e79837bf3778295bcedd20e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20231009062222epcas5p36768b75c13c7c79965b5863521361a64
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20231009062222epcas5p36768b75c13c7c79965b5863521361a64
References: <CGME20231009062222epcas5p36768b75c13c7c79965b5863521361a64@epcas5p3.samsung.com>
        <20231009062216.6729-1-shradha.t@samsung.com>
        <20231027134849.GA23716@thinkpad>
        <000b01da178e$a43088d0$ec919a70$@samsung.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi!

On 15.11.2023 07:40, Shradha Todi wrote:
>> -----Original Message-----
>> From: Manivannan Sadhasivam [mailto:manivannan.sadhasivam@linaro.org]
>> Sent: 27 October 2023 19:19
>> To: Shradha Todi<shradha.t@samsung.com>
>> Cc:jingoohan1@gmail.com;lpieralisi@kernel.org;kw@linux.com;
>> robh@kernel.org;bhelgaas@google.com;krzysztof.kozlowski@linaro.org;
>> alim.akhtar@samsung.com;linux-pci@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org;linux-samsung-soc@vger.kernel.org; linux-
>> kernel@vger.kernel.org;pankaj.dubey@samsung.com
>> Subject: Re: [PATCH] PCI: exynos: Adapt to clk_bulk_* APIs
>>
>> On Mon, Oct 09, 2023 at 11:52:16AM +0530, Shradha Todi wrote:
>>> There is no need to hardcode the clock info in the driver as driver
>>> can rely on the devicetree to supply the clocks required for the
>>> functioning of the peripheral. Get rid of the static clock info and
>>> obtain the platform supplied clocks. The total number of clocks
>>> supplied is obtained using the devm_clk_bulk_get_all() API and used
>>> for the rest of the clk_bulk_* APIs.
>>>
>>> Signed-off-by: Shradha Todi<shradha.t@samsung.com>
>>> ---
>>>   drivers/pci/controller/dwc/pci-exynos.c | 46
>>> ++++++-------------------
>>>   1 file changed, 11 insertions(+), 35 deletions(-)
>>>
>>> diff --git a/drivers/pci/controller/dwc/pci-exynos.c
>>> b/drivers/pci/controller/dwc/pci-exynos.c
>>> index 9e42cfcd99cc..023cf41fccd7 100644
>>> --- a/drivers/pci/controller/dwc/pci-exynos.c
>>> +++ b/drivers/pci/controller/dwc/pci-exynos.c
>>> @@ -54,8 +54,8 @@
>>>   struct exynos_pcie {
>>>   	struct dw_pcie			pci;
>>>   	void __iomem			*elbi_base;
>>> -	struct clk			*clk;
>>> -	struct clk			*bus_clk;
>>> +	struct clk_bulk_data		*clks;
>>> +	int				clk_cnt;
>>>   	struct phy			*phy;
>>>   	struct regulator_bulk_data	supplies[2];
>>>   };
>>> @@ -65,30 +65,18 @@ static int exynos_pcie_init_clk_resources(struct
>> exynos_pcie *ep)
>>>   	struct device *dev = ep->pci.dev;
>>>   	int ret;
>>>
>>> -	ret = clk_prepare_enable(ep->clk);
>>> -	if (ret) {
>>> -		dev_err(dev, "cannot enable pcie rc clock");
>>> +	ret = devm_clk_bulk_get_all(dev, &ep->clks);
>>> +	if (ret < 0)
>> Please use !(ret) here and below to be consistent with the driver.
>>
> In this case, only negative values indicate failure. Hence we cannot use (!ret) here.
>
>>>   		return ret;
>>> -	}
>>>
>>> -	ret = clk_prepare_enable(ep->bus_clk);
>>> -	if (ret) {
>>> -		dev_err(dev, "cannot enable pcie bus clock");
>>> -		goto err_bus_clk;
>>> -	}
>>> +	ep->clk_cnt = ret;
>> Since clk_cnt is "int", you can just use it directly instead of "ret".
>>
> Thanks for this suggestion! Will take care in v2.
>
>>> -	return 0;
>>> -
>>> -err_bus_clk:
>>> -	clk_disable_unprepare(ep->clk);
>>> -
>>> -	return ret;
>>> +	return clk_bulk_prepare_enable(ep->clk_cnt, ep->clks);
>>>   }
>>>
>>>   static void exynos_pcie_deinit_clk_resources(struct exynos_pcie *ep)
>>> {
>>> -	clk_disable_unprepare(ep->bus_clk);
>>> -	clk_disable_unprepare(ep->clk);
>>> +	clk_bulk_disable_unprepare(ep->clk_cnt, ep->clks);
>>>   }
>>>
>>>   static void exynos_pcie_writel(void __iomem *base, u32 val, u32 reg)
>>> @@ -332,17 +320,9 @@ static int exynos_pcie_probe(struct
>> platform_device *pdev)
>>>   	if (IS_ERR(ep->elbi_base))
>>>   		return PTR_ERR(ep->elbi_base);
>>>
>>> -	ep->clk = devm_clk_get(dev, "pcie");
>>> -	if (IS_ERR(ep->clk)) {
>>> -		dev_err(dev, "Failed to get pcie rc clock\n");
>>> -		return PTR_ERR(ep->clk);
>>> -	}
>>> -
>>> -	ep->bus_clk = devm_clk_get(dev, "pcie_bus");
>>> -	if (IS_ERR(ep->bus_clk)) {
>>> -		dev_err(dev, "Failed to get pcie bus clock\n");
>>> -		return PTR_ERR(ep->bus_clk);
>>> -	}
>>> +	ret = exynos_pcie_init_clk_resources(ep);
>>> +	if (ret < 0)
>>> +		return ret;
>>>
>>>   	ep->supplies[0].supply = "vdd18";
>>>   	ep->supplies[1].supply = "vdd10";
>>> @@ -351,10 +331,6 @@ static int exynos_pcie_probe(struct
>> platform_device *pdev)
>>>   	if (ret)
>>>   		return ret;
>>>
>>> -	ret = exynos_pcie_init_clk_resources(ep);
>>> -	if (ret)
>>> -		return ret;
>>> -
>>>   	ret = regulator_bulk_enable(ARRAY_SIZE(ep->supplies), ep-
>>> supplies);
>>>   	if (ret)
>> You need to disable_unprepare() clocks in error path here and above.
>>
> Thanks for pointing out! Will take care in v2.


Maybe it would make sense to add devm_clk_bulk_get_all_enabled() to 
clock framework, similar to the existing devm_clk_get_enabled()?

It is really a common pattern to get all clocks and enable them for the 
time of driver operation.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

