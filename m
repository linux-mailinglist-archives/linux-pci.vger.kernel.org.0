Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2DBE29AC11
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 13:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2899852AbgJ0M3X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 08:29:23 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:52361 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2899850AbgJ0M3W (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 08:29:22 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201027122911euoutp0173c80ff166756407605dd4ae9556b651~B2TIDw3MP0162501625euoutp01a
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2020 12:29:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201027122911euoutp0173c80ff166756407605dd4ae9556b651~B2TIDw3MP0162501625euoutp01a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603801751;
        bh=CjdMI1tmB90miqbqTksyvUXWDiO0ncL6v7W915kb7J4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=APFWvEkJvSt8uoFS9HJf3PG/KjYDSUPqtsIH6nr95eBnbtjnBSIBqyMzgyUdtYhsr
         AUBJ+QokOK6xSNSITkr8laxh9bTlansTVFdrWgZMkolgqmE/o5ikcO/yJVDDa6GkDx
         GRaqImSvBSOUDA3iHT5SRp+dvR132AAyn9WK7B/M=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201027122906eucas1p194269e642811d06b63335e300de88ea4~B2TDRVZXo0881708817eucas1p1f;
        Tue, 27 Oct 2020 12:29:06 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F6.6B.05997.192189F5; Tue, 27
        Oct 2020 12:29:05 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201027122905eucas1p16ba9af9ea08ac43aed86970595a2ea78~B2TC95igX0038500385eucas1p1c;
        Tue, 27 Oct 2020 12:29:05 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201027122905eusmtrp25c498067e019f40f47c5e34f8297eaa2~B2TC8SiH92828528285eusmtrp2b;
        Tue, 27 Oct 2020 12:29:05 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-e7-5f9812915051
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 65.C8.06314.882189F5; Tue, 27
        Oct 2020 12:28:56 +0000 (GMT)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201027122855eusmtip14adc70a2a031ac56fab75930dc378878~B2S5gyLQm2340823408eusmtip1V;
        Tue, 27 Oct 2020 12:28:55 +0000 (GMT)
Subject: Re: [PATCH v2 4/6] phy: samsung: phy-exynos-pcie: rework driver to
 support Exynos5433 PCIe PHY
To:     Rob Herring <robh+dt@kernel.org>
Cc:     linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <e2ba43d4-3991-e98e-6ec0-6ff3ad5d954b@samsung.com>
Date:   Tue, 27 Oct 2020 13:28:55 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqLUT7aLnQsLvcCOHCaoVAao9VSmEhoscBxu3ARXX33zrA@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsWy7djPc7oThWbEG9x8aGWxpCnDYv6Rc6wW
        N361sVqs+DKT3eLC0x42i/PnN7BbXN41h83i7LzjbBYzzu9jsnjz+wW7ReveI+wWO++cYHbg
        8Vgzbw2jx85Zd9k9Fmwq9di0qpPNo2/LKkaP4ze2M3l83iQXwB7FZZOSmpNZllqkb5fAlTHz
        zlzWgtPqFd9f3mRvYLwk28XIwSEhYCLxuDmki5GLQ0hgBaPElNuPWLsYOYGcL4wS97b6QyQ+
        M0rcXX2OESQB0rBwxXI2iMRyRoknkzsZIZz3jBJXn9xiAxkrLJAp0bLXAKRBREBFYsPzW8wg
        NcwC55gl9nx6zQKSYBMwlOh628UGYvMK2EnsOL0ZLM4ioCqxr2UemC0qkCTx9/MfZogaQYmT
        M5+AxTkFAiXWv/oOZjMLyEtsfzuHGcIWl7j1ZD4TyDIJgUfsEjtvrWCGONtFYsXVmVC2sMSr
        41vYIWwZif87YRqaGSUenlvLDuH0MEpcbpoB9bS1xJ1zv8BeYxbQlFi/Sx8i7Cix4eBZNkhA
        8knceCsIcQSfxKRt05khwrwSHW1CENVqErOOr4Nbe/DCJeYJjEqzkLw2C8k7s5C8Mwth7wJG
        llWM4qmlxbnpqcVGeanlesWJucWleel6yfm5mxiBSez0v+NfdjDu+pN0iFGAg1GJh/fC22nx
        QqyJZcWVuYcYJTiYlUR4nc6ejhPiTUmsrEotyo8vKs1JLT7EKM3BoiTOa7zoZayQQHpiSWp2
        ampBahFMlomDU6qBMSxDrlna9MIEpdWHs+cIXLbyfdSip1YlemXP5dP/vW5lbDi+qs7g833u
        6BMsX2ID1FVKVm+O+Kj4Nv5ReON2/40N31bEc0n8k8q91GW3p9/o8u2ly687vquzNHM6+F5r
        4oWPamv/BwWrf/n5zHGuyNmg2jCDK2+bPmxPXartfGK23rwi+9upuUosxRmJhlrMRcWJAM4R
        oQheAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsVy+t/xu7odQjPiDeZv4LJY0pRhMf/IOVaL
        G7/aWC1WfJnJbnHhaQ+bxfnzG9gtLu+aw2Zxdt5xNosZ5/cxWbz5/YLdonXvEXaLnXdOMDvw
        eKyZt4bRY+esu+weCzaVemxa1cnm0bdlFaPH8RvbmTw+b5ILYI/SsynKLy1JVcjILy6xVYo2
        tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy5h5Zy5rwWn1iu8vb7I3MF6S7WLk
        5JAQMJFYuGI5G4gtJLCUUaK/XwsiLiNxcloDK4QtLPHnWhdQDRdQzVtGiZs/9jB2MXJwCAtk
        SrTsNQCpERFQkdjw/BYzSA2zwDlmiVNfLzBCNPQwSfTtegw2iU3AUKLrbRfYNl4BO4kdpzez
        gNgsAqoS+1rmgdmiAkkSLy9MZYKoEZQ4OfMJWJxTIFBi/avvYDazgJnEvM0PmSFseYntb+dA
        2eISt57MZ5rAKDQLSfssJC2zkLTMQtKygJFlFaNIamlxbnpusaFecWJucWleul5yfu4mRmDc
        bjv2c/MOxksbgw8xCnAwKvHwXng7LV6INbGsuDL3EKMEB7OSCK/T2dNxQrwpiZVVqUX58UWl
        OanFhxhNgZ6byCwlmpwPTCl5JfGGpobmFpaG5sbmxmYWSuK8HQIHY4QE0hNLUrNTUwtSi2D6
        mDg4pRoY03/0Wt9eJ/5IallTb9uktxtXqvYEFfjPM5X/H3PkaNa69e6Wa/YyuL2xvvJUvOXk
        z8Lcf00+l859Mbzhy6Xa+7eroynNQIDJYurnTX2nNeMPyqi0CcuWqM7uirl+Jru0dtvcu13+
        K3SPLwqa6f5/0aQ9fDqeJw80h4nWh3tUTjr2Wm2Z4NHrSizFGYmGWsxFxYkAtzVddvECAAA=
X-CMS-MailID: 20201027122905eucas1p16ba9af9ea08ac43aed86970595a2ea78
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201023075756eucas1p2c27cc3e6372127d107e5b84c810ba98f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201023075756eucas1p2c27cc3e6372127d107e5b84c810ba98f
References: <CGME20201023075756eucas1p2c27cc3e6372127d107e5b84c810ba98f@eucas1p2.samsung.com>
        <20201023075744.26200-1-m.szyprowski@samsung.com>
        <20201023075744.26200-5-m.szyprowski@samsung.com>
        <CAL_JsqLUT7aLnQsLvcCOHCaoVAao9VSmEhoscBxu3ARXX33zrA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 26.10.2020 19:50, Rob Herring wrote:
> On Fri, Oct 23, 2020 at 2:58 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> From: Jaehoon Chung <jh80.chung@samsung.com>
>>
>> Exynos5440 SoC support has been dropped since commit 8c83315da1cf ("ARM:
>> dts: exynos: Remove Exynos5440"). Rework this driver to support PCIe PHY
>> variant found in the Exynos5433 SoCs.
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> [mszyprow: reworked the driver to support only Exynos5433 variant, rebased
>>             onto current kernel code, rewrote commit message]
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>> ---
>>   drivers/phy/samsung/phy-exynos-pcie.c | 304 ++++++++++----------------
>>   1 file changed, 112 insertions(+), 192 deletions(-)
>>
>> diff --git a/drivers/phy/samsung/phy-exynos-pcie.c b/drivers/phy/samsung/phy-exynos-pcie.c
>> index 7e28b1aea0d1..d91de323dd0e 100644
>> --- a/drivers/phy/samsung/phy-exynos-pcie.c
>> +++ b/drivers/phy/samsung/phy-exynos-pcie.c
>> @@ -4,70 +4,41 @@
>>    *
>>    * Phy provider for PCIe controller on Exynos SoC series
>>    *
>> - * Copyright (C) 2017 Samsung Electronics Co., Ltd.
>> + * Copyright (C) 2017-2020 Samsung Electronics Co., Ltd.
>>    * Jaehoon Chung <jh80.chung@samsung.com>
>>    */
>>
>> -#include <linux/delay.h>
>>   #include <linux/io.h>
>> -#include <linux/iopoll.h>
>> -#include <linux/init.h>
>>   #include <linux/mfd/syscon.h>
>> -#include <linux/of.h>
>> -#include <linux/of_address.h>
>>   #include <linux/of_platform.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/phy/phy.h>
>>   #include <linux/regmap.h>
>>
>> -/* PCIe Purple registers */
>> -#define PCIE_PHY_GLOBAL_RESET          0x000
>> -#define PCIE_PHY_COMMON_RESET          0x004
>> -#define PCIE_PHY_CMN_REG               0x008
>> -#define PCIE_PHY_MAC_RESET             0x00c
>> -#define PCIE_PHY_PLL_LOCKED            0x010
>> -#define PCIE_PHY_TRSVREG_RESET         0x020
>> -#define PCIE_PHY_TRSV_RESET            0x024
>> -
>> -/* PCIe PHY registers */
>> -#define PCIE_PHY_IMPEDANCE             0x004
>> -#define PCIE_PHY_PLL_DIV_0             0x008
>> -#define PCIE_PHY_PLL_BIAS              0x00c
>> -#define PCIE_PHY_DCC_FEEDBACK          0x014
>> -#define PCIE_PHY_PLL_DIV_1             0x05c
>> -#define PCIE_PHY_COMMON_POWER          0x064
>> -#define PCIE_PHY_COMMON_PD_CMN         BIT(3)
>> -#define PCIE_PHY_TRSV0_EMP_LVL         0x084
>> -#define PCIE_PHY_TRSV0_DRV_LVL         0x088
>> -#define PCIE_PHY_TRSV0_RXCDR           0x0ac
>> -#define PCIE_PHY_TRSV0_POWER           0x0c4
>> -#define PCIE_PHY_TRSV0_PD_TSV          BIT(7)
>> -#define PCIE_PHY_TRSV0_LVCC            0x0dc
>> -#define PCIE_PHY_TRSV1_EMP_LVL         0x144
>> -#define PCIE_PHY_TRSV1_RXCDR           0x16c
>> -#define PCIE_PHY_TRSV1_POWER           0x184
>> -#define PCIE_PHY_TRSV1_PD_TSV          BIT(7)
>> -#define PCIE_PHY_TRSV1_LVCC            0x19c
>> -#define PCIE_PHY_TRSV2_EMP_LVL         0x204
>> -#define PCIE_PHY_TRSV2_RXCDR           0x22c
>> -#define PCIE_PHY_TRSV2_POWER           0x244
>> -#define PCIE_PHY_TRSV2_PD_TSV          BIT(7)
>> -#define PCIE_PHY_TRSV2_LVCC            0x25c
>> -#define PCIE_PHY_TRSV3_EMP_LVL         0x2c4
>> -#define PCIE_PHY_TRSV3_RXCDR           0x2ec
>> -#define PCIE_PHY_TRSV3_POWER           0x304
>> -#define PCIE_PHY_TRSV3_PD_TSV          BIT(7)
>> -#define PCIE_PHY_TRSV3_LVCC            0x31c
>> -
>> -struct exynos_pcie_phy_data {
>> -       const struct phy_ops    *ops;
>> -};
>> +#define PCIE_PHY_OFFSET(x)             ((x) * 0x4)
>> +
>> +/* Sysreg FSYS register offsets and bits for Exynos5433 */
>> +#define PCIE_EXYNOS5433_PHY_MAC_RESET          0x0208
>> +#define PCIE_MAC_RESET_MASK                    0xFF
>> +#define PCIE_MAC_RESET                         BIT(4)
>> +#define PCIE_EXYNOS5433_PHY_L1SUB_CM_CON       0x1010
>> +#define PCIE_REFCLK_GATING_EN                  BIT(0)
>> +#define PCIE_EXYNOS5433_PHY_COMMON_RESET       0x1020
>> +#define PCIE_PHY_RESET                         BIT(0)
>> +#define PCIE_EXYNOS5433_PHY_GLOBAL_RESET       0x1040
>> +#define PCIE_GLOBAL_RESET                      BIT(0)
> Resets, why is this block not a reset provider?

Because most of those registers need to be configured together with the 
rest of the PHY registers. IMHO there is no simple "do the reset" logic 
there. There is also PHY reference clock configuration there. This phy 
driver is already Exynos5433 specific and I see no point in extracting 
separate reset driver from it. Other Exynos PHY drivers also access PMU 
and SYSREG via the respective regmaps and don't use any kind of reset 
drivers.

>> +#define PCIE_REFCLK                            BIT(1)
>> +#define PCIE_REFCLK_MASK                       0x16
>> +#define PCIE_APP_REQ_EXIT_L1_MODE              BIT(5)

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

