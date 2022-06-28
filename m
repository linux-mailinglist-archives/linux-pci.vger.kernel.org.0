Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED6C55C7D2
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 14:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244485AbiF1IOE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 04:14:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243795AbiF1INt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 04:13:49 -0400
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C30D2D1CE
        for <linux-pci@vger.kernel.org>; Tue, 28 Jun 2022 01:13:42 -0700 (PDT)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20220628081339euoutp02526e9d9b5d7736b09947392d9f2c8320~8uq3_UMjd1515515155euoutp02S
        for <linux-pci@vger.kernel.org>; Tue, 28 Jun 2022 08:13:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20220628081339euoutp02526e9d9b5d7736b09947392d9f2c8320~8uq3_UMjd1515515155euoutp02S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1656404019;
        bh=PlenMJZIMvg+yssHUrSEVcbqZWVVKLRTR1oE2sU1L04=;
        h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
        b=Py+/elLgFTA2wSamoJesR+rrkmPmTvRETEiMcvj0e3vUPESm20QsjGfTYXbKnF2Gz
         hFoh6SMTipAjlQVjpBfWxL0Ztyw8gPkdvYrZzJyQ1OGVyX75OEMiVOL/njbXhVx77y
         hgqT5sC4c2xXnsb9reCD3vA0vZRosmV+9yaiIiXQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220628081338eucas1p19f6fd8f2771cae90fe7aec67c6ed1c63~8uq3fsx3o2201622016eucas1p1z;
        Tue, 28 Jun 2022 08:13:38 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id EA.C8.09664.238BAB26; Tue, 28
        Jun 2022 09:13:38 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20220628081338eucas1p1e0aab18d1d8c7aa0601399cf9a1cab34~8uq3B2KWe0414204142eucas1p1n;
        Tue, 28 Jun 2022 08:13:38 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220628081338eusmtrp1ca67fa56b51049c663aedf1a86730c29~8uq3BCtqU3120431204eusmtrp1O;
        Tue, 28 Jun 2022 08:13:38 +0000 (GMT)
X-AuditID: cbfec7f2-d97ff700000025c0-00-62bab83200e8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 29.99.09038.238BAB26; Tue, 28
        Jun 2022 09:13:38 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220628081337eusmtip2613a19042f2ffebe257e68a03b14106d~8uq2f07Rm0756207562eusmtip2r;
        Tue, 28 Jun 2022 08:13:37 +0000 (GMT)
Message-ID: <a7d73302-ce96-4adb-1981-fcde0ff03e87@samsung.com>
Date:   Tue, 28 Jun 2022 10:13:36 +0200
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
In-Reply-To: <ae8cee69-2ca5-0b27-f6d5-0f9f74871fd8@linaro.org>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA01SeUxScRzfjwfvPdiwF2r+kmaJy61cmkf1tspuR9eWrta5EvENXR4EauVq
        uWIdZOZVIh3qdMuw0qmoOLEyjXkRyzIsxQ7soFF5VjYt8Fn53+f3Ob7XfjjCK2d54rEJSZQs
        QRQnQDnMmsc/jUuC6uqjlvYbQ8jXN2tQ0tZxFyXN42dZZOlIPkbqP2sxMi39F4usfNfNIjtv
        GlBS9aSRsZYt1Kn7MGGl5gIq7O1uQIXWZ3kMYVXJKWFGtQYIhyu9dmD7OKuiqbjYFEoWEBrJ
        ienK1zKkE67Hfl/8yEoDRYQSsHFIhMCskh6gBBycR5QCmPXFynAKPGIEwJKBBbQwDKBiqIf5
        N3F5+D5CC7cA1AwppuODjkTPBHC6uEQovNQ6PoWZxEL4rXRgmp8NW/OtU5XcCTE0dj5HndiV
        WAwt3RWIEyOEB3xpLWA4i7oRZQD2qzIx5wMhDABm6r5iThdKBEKlXTmVZju6lXfVYnR6Pqy1
        X0foWc+w4aDJl8Yboa6wCaOxK7QZqqfxPNiek+6YCHfgRDihCqbpY7D7853pMithr3EcdVoQ
        YhEsrw+g6XXwkT4L0EkXaLbPpgdwgdk1eQhNc+H5szza7QvVhnv/ej40PUUygUA94yjqGcur
        Z6yi/t+3EDA1wINKlsdLKHlgAnXUXy6KlycnSPzFifGVwPGn2icNQ3Xghm3QvwkwcNAEII4I
        3LhFHbooHjdadDyVkiUekiXHUfImwMeZAg+uOLZCxCMkoiTqMEVJKdlflYGzPdMYcQfCNv8M
        j9JuTX3TclxVb1EEbS+ft2ksQjNYldHi3Wu/Wjy5u2CIJWL2ZYRt3P9rz5yc3g9HL65b5i7R
        53Jvmxq9qkN1YW45rbZmNTtdG3bFAMxd8XyqzufdyUU7Z0VK0gb0ZasvWxr7V4wp+sbyz632
        q/LT87coxZ5vvfheOaFVD8sWnNjAr89qa65N2vvGsvx9at9IxANtpP3wC47nDZX0dMoKTcSP
        L6c+LVvlZzcoVTHIwdFrY6+OmEIGvJurpSUFPonJ46PfsW2R1Ppg6ybjpRQ23hLYEzO3X6KQ
        RnubI7Jfmdp+7ArKvl1sFN93+Z7b0JlrnsxjFoWvaRm1eAuY8hhR4GJEJhf9AUWnsUfCAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGIsWRmVeSWpSXmKPExsVy+t/xe7pGO3YlGbzcLWrxYN42NotXZ9ay
        Wdz41cZqseLLTHaLva+3sls09Pxmtdj0+Bqrxdl5x9ksZpzfx+TA6bFz1l12j02rOtk87lzb
        w+bx5Mp0Jo/NS+o9+rasYvT4vEkugD1Kz6Yov7QkVSEjv7jEVina0MJIz9DSQs/IxFLP0Ng8
        1srIVEnfziYlNSezLLVI3y5BL+PyzK1MBX+FK/53v2BtYFwo0MXIySEhYCLR/3k/cxcjF4eQ
        wFJGiUlrn7JAJGQkTk5rYIWwhSX+XOtigyh6zyix4O1ENpAEr4CdRO/JX4wgNouAqsSHFU8Z
        IeKCEidnPgEbJCqQLNG85RATiC0soCVx79oGZhCbWUBc4taT+UwgQ0UEVjNKvNp9lAXEYRY4
        zijxcN4Fdoh1C5gklm+5AzaWTcBQouttF9hqTqDV6y9vZ4cYZSbRtbWLEcKWl9j+dg7zBEah
        WUgumYVk4ywkLbOQtCxgZFnFKJJaWpybnltspFecmFtcmpeul5yfu4kRGKHbjv3csoNx5auP
        eocYmTgYDzFKcDArifAuPLMzSYg3JbGyKrUoP76oNCe1+BCjKTA4JjJLiSbnA1NEXkm8oZmB
        qaGJmaWBqaWZsZI4r2dBR6KQQHpiSWp2ampBahFMHxMHp1QDU/nmsrkeN9wuG9UJqOUseye8
        7clGBpZdm63mfym8fGXZyfXr+pZnfj9sJrwlxHZmUkmF665Tly584pS49XHOqWe1d2bFGfFf
        OqDJvq5sWee2aT03XH98u7CL01FxzkfF7ufTJoektiitfu/14/wZnnd6hc68Dn9azrO2bpI0
        P2rWPSMsafuEdTxt/BO99m0OD8iTL3q/tnRu5KXG91srRWu9D35jKCuKeTdts81FltdnP1bG
        h5ruFegRq9L983jShfXLu8/KrDjzM9lVuu5Z/hFHdSWtvAL+k7PDKuR9zz08JyPvIZ1tdV2G
        VfflaUVrHdYI7SzbpqUZJkuO52zmeSc6xTvq3rpDnRcqlbhUdymxFGckGmoxFxUnAgBg6KeN
        WQMAAA==
X-CMS-MailID: 20220628081338eucas1p1e0aab18d1d8c7aa0601399cf9a1cab34
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20220624180806eucas1p16a18d9598c0a08770b428cd58916b65d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20220624180806eucas1p16a18d9598c0a08770b428cd58916b65d
References: <20220624173541.GA1543581@bhelgaas>
        <CGME20220624180806eucas1p16a18d9598c0a08770b428cd58916b65d@eucas1p1.samsung.com>
        <c0c802c0-82e1-e7bb-48be-974ac23b5a15@linaro.org>
        <591f696f-b55c-d267-7fcb-74f7fd4a6900@samsung.com>
        <ae8cee69-2ca5-0b27-f6d5-0f9f74871fd8@linaro.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krzysztof,

On 27.06.2022 12:47, Krzysztof Kozlowski wrote:
> On 27/06/2022 12:30, Marek Szyprowski wrote:
>> On 24.06.2022 20:07, Krzysztof Kozlowski wrote:
>>> On 24/06/2022 19:35, Bjorn Helgaas wrote:
>>>> In exynos_pcie_host_init() [1], we call:
>>>>
>>>>     phy_reset(ep->phy);
>>>>     phy_power_on(ep->phy);
>>>>     phy_init(ep->phy);
>>>>
>>>> The phy_init() function comment [2] says it must be called before
>>>> phy_power_on().  Is exynos doing this backwards?
>>> Looks like. I don't have Exynos hardware with a PCI, so cannot
>>> test/fix/verify.
>>>
>>> Luckily for Exynos ;-) it's not alone in this pattern:
>>> drivers/net/ethernet/marvell/sky2.c
>>> drivers/usb/dwc2/platform.c
>> I've checked that on the real hardware. Swapping the order of
>> phy_power_on and phy_init breaks driver operation.
>>
>> However pci-exynos is the only driver that uses the phy-exynos-pcie, so
>> we can simply swap the content of the init and power_on in the phy
>> driver to adjust the code to the right order. power_on/init and
>> exit/power_off are also called one after the other in pci-exynos,
>> without any activity between them, so we can also simply move all
>> operation to one pair of the callback, like power_on/off.
>>
>> Krzysztof, which solution would you prefer?
> I think the real problem is that the Exynos PCIe phy init
> (exynos5433_pcie_phy_init) performs parts of power on procedure, so the
> code is mixed. Probably also the phy init could not happen earlier due
> to gated clocks (ungated in exynos5433_pcie_phy_power_on).
>
> I would prefer to clean it up while ordering init+power_on, so figure
> out more or less correct procedure.
>
> You can also look at Artpec-8 PHY - it seems using correct order
> (init+reset):
> https://lore.kernel.org/all/20220614011616epcms2p7dcaa67c53b7df5802dd7a697e2d472d7@epcms2p7/

I've played a bit with those register writes in exynos_pcie_phy and 
frankly speaking the currenly used (power_on + init) is the only 
sequence that works properly. I'm leaning to move everything to 
phy_init/exit. I really don't see how to split it into init + power_on 
callbacks.

While touching this - I would also remove the phy_reset() call in the 
exynos-pcie driver. It is a left over from the old, obsoleted exynos5440 
pcie code, not implemented in the current phy driver, also only a few 
drivers use or implement it. IMHO it doesn't make sense to keep such 
dead code.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

