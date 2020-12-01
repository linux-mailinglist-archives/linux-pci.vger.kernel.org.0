Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C0112CA3D8
	for <lists+linux-pci@lfdr.de>; Tue,  1 Dec 2020 14:30:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391098AbgLAN24 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Dec 2020 08:28:56 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55963 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728806AbgLAN2z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Dec 2020 08:28:55 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201201132804euoutp01aba7818b8ac31bb604fa0c8af44edb81~MmriM2jL-2754727547euoutp011
        for <linux-pci@vger.kernel.org>; Tue,  1 Dec 2020 13:28:04 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201201132804euoutp01aba7818b8ac31bb604fa0c8af44edb81~MmriM2jL-2754727547euoutp011
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1606829284;
        bh=VFkr+TeeXOlcI2Bu1gftl7UN2NGPdlJ7xgNDYKVJe3w=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=FJf8uGRq0oJd5TL+76fFH1FAt83I1X9l0tEPk80neQrArIcFgmAaKyDFfdeN/TtXb
         hh7u+iV2thCzIAuTeRiILzCHktsBRxWlBUseGMwGG9R5aoGKeBV5kAxbOUNQBR2wkk
         i7/OkaagxTQoNWlDvN7ZWUdSUMVRpD1fIYL8H6/Y=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201201132759eucas1p125949234c39f998adb50bc954b979fbd~MmrdL0_Nj0921209212eucas1p1v;
        Tue,  1 Dec 2020 13:27:59 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 14.E9.45488.FD446CF5; Tue,  1
        Dec 2020 13:27:59 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201201132758eucas1p2646dd84fcc2a91b6ac1d224842478eda~Mmrcx-qSz2851028510eucas1p2L;
        Tue,  1 Dec 2020 13:27:58 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201201132758eusmtrp20c2063f121f75f22f0bb93c9eeefecc3~MmrcxVN-31364113641eusmtrp2v;
        Tue,  1 Dec 2020 13:27:58 +0000 (GMT)
X-AuditID: cbfec7f5-c5fff7000000b1b0-71-5fc644de08d8
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 13.71.16282.ED446CF5; Tue,  1
        Dec 2020 13:27:58 +0000 (GMT)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201201132758eusmtip16ebdde7b562762fec494129d1b2d002b~MmrcQDuOL2490724907eusmtip1r;
        Tue,  1 Dec 2020 13:27:58 +0000 (GMT)
Subject: Re: linux-next: Tree for Nov 30
 (drivers/pci/controller/dwc/pcie-designware-host.c)
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Randy Dunlap <rdunlap@infradead.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <8b81ba16-7493-ddd2-65ac-b1ac46537deb@samsung.com>
Date:   Tue, 1 Dec 2020 14:27:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20201201113412.GA2389@e121166-lin.cambridge.arm.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsWy7djP87r3XY7FGyz4yWSxpCnD4savNlaL
        y7vmsFkcXNjGaHF23nE2ize/X7BbvL0zncVi696r7A4cHmvmrWH0aLxxg81jwaZSj80rtDz6
        tqxi9Pi8SS6ALYrLJiU1J7MstUjfLoEr4+aVz8wFBzgqrh+dwtrA+Jiti5GTQ0LARGLd/umM
        XYxcHEICKxgl1nZuZIJwvjBK/Jp4gB3C+cwocfXfA2aYljfdzSwQieWMEu+fHWGDcN4zSkzb
        9RCsSlggTuLSye9MILaIQKTEg7aZrCBFzAJTmSS2zexhBUmwCRhKdL3tAruEV8BOYsu/hewg
        NouAisTXg6cYQWxRgSSJgx8fQNUISpyc+YQFxOYUcJLY9OIzWD2zgLzE9rdzmCFscYlbT+aD
        PSEh8IJD4sKtb0CDOIAcF4mlH1UgXhCWeHV8CzuELSPxfydMfTOjxMNza9khnB5GictNMxgh
        qqwl7pz7xQYyiFlAU2L9Ln2ImY4SZ97GQZh8EjfeCkKcwCcxadt0Zogwr0RHmxDEDDWJWcfX
        wW09eOES8wRGpVlIHpuF5JlZSJ6ZhbB2ASPLKkbx1NLi3PTUYuO81HK94sTc4tK8dL3k/NxN
        jMCUdPrf8a87GFe8+qh3iJGJg/EQowQHs5IIL8u/I/FCvCmJlVWpRfnxRaU5qcWHGKU5WJTE
        eXdtXRMvJJCeWJKanZpakFoEk2Xi4JRqYFpyc51E28+jWx7v2i2V7rhDkmmxnJKz2H+n7xGa
        3IvCHTVsb0Yc7V388sKWxm1GE+LvnGzjN9Squ/DjqvJU6WL56Z1HFLb35uxMrb9jODPV1Pd8
        3ky/sOoVbvHr2/u6U2KnlNfPiWILe3mk3ffbzoOvNq3cVXPpTWPU9QuSRodi7rztWmVRr96g
        K7PD+56lVdWVwrVz9Ct+Tdkp9N/NbF/0X6Uuq2OFUUnzwq4vspC2iNm3XF3UX2DNqXOGYqr3
        fy2IXdrhuSUy7DXvJrXIBxs0ypn25r4yf7fmXMu5nIMnGp5mzXrrsc5V1sB493qNG/xcUQzH
        MlWsD54VVNvYcc90S/D3qAIhyVcPOYSVWJRYijMSDbWYi4oTAUOfp+S4AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsVy+t/xu7r3XI7FGyxpVLZY0pRhceNXG6vF
        5V1z2CwOLmxjtDg77zibxZvfL9gt3t6ZzmKxde9VdgcOjzXz1jB6NN64weaxYFOpx+YVWh59
        W1YxenzeJBfAFqVnU5RfWpKqkJFfXGKrFG1oYaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mW
        WqRvl6CXcfPKZ+aCAxwV149OYW1gfMzWxcjJISFgIvGmu5mli5GLQ0hgKaPEq5mvWCESMhIn
        pzVA2cISf651gTUICbxllDg8D8wWFoiTuHTyO1MXIweHiECkRNuxCJA5zALTmST+Nx5ghxj6
        k1Fiys5rzCANbAKGEl1vIQbxCthJbPm3kB3EZhFQkfh68BQjiC0qkCTxe+laqBpBiZMzn7CA
        2JwCThKbXnwGq2cWMJOYt/khM4QtL7H97RwoW1zi1pP5TBMYhWYhaZ+FpGUWkpZZSFoWMLKs
        YhRJLS3OTc8tNtIrTswtLs1L10vOz93ECIzBbcd+btnBuPLVR71DjEwcjIcYJTiYlUR4Wf4d
        iRfiTUmsrEotyo8vKs1JLT7EaAr0z0RmKdHkfGASyCuJNzQzMDU0MbM0MLU0M1YS5zU5siZe
        SCA9sSQ1OzW1ILUIpo+Jg1OqgWn6xoUKWjrsVRduPDhx//XutD1WsyKeaj14upNHSfXCZM4p
        c05zzqotY5JeOW9/isGDxTrJl+f7J9f1ylzlVYm1U+dWKdhnnbTm1qO/pUuMVafpS/u3/wjZ
        Zlrw/1HkRWWVFQed9ri6yXM9/vlC2HmRW3qJj82HbGWBWK5C/c+HS47H/NSecmbbvLVxUpyJ
        RT9e70nky7s469OnsJl3n6ju3nVBrlYo73rBtUBXTT1RdoczEXGnp6UZX9zwW0z04s+3t049
        WTLx8a7u9uQPc4C+nTVTZf+Cec7yVxxfyTuGi0r7WusssCjftJhVY9K3ouzns1l+NGYrfQ+7
        J7o59uKbTawhOlM5WTrdrO9r/VJiKc5INNRiLipOBAAO5hpxSgMAAA==
X-CMS-MailID: 20201201132758eucas1p2646dd84fcc2a91b6ac1d224842478eda
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201201113428eucas1p2114ad01341ad5cfb9683bc4a410c74b5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201201113428eucas1p2114ad01341ad5cfb9683bc4a410c74b5
References: <20201130193626.1c408e47@canb.auug.org.au>
        <bc0f6da9-6dd4-c1ad-f2f3-dc1a5cd6a51b@infradead.org>
        <CGME20201201113428eucas1p2114ad01341ad5cfb9683bc4a410c74b5@eucas1p2.samsung.com>
        <20201201113412.GA2389@e121166-lin.cambridge.arm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi

On 01.12.2020 12:34, Lorenzo Pieralisi wrote:
> On Mon, Nov 30, 2020 at 08:44:55PM -0800, Randy Dunlap wrote:
>> On 11/30/20 12:36 AM, Stephen Rothwell wrote:
>>> Changes since 20201127:
>> on x86_64:
>>
>> WARNING: unmet direct dependencies detected for PCIE_DW_HOST
>>    Depends on [n]: PCI [=y] && PCI_MSI_IRQ_DOMAIN [=n]
>>    Selected by [y]:
>>    - PCI_EXYNOS [=y] && PCI [=y] && (ARCH_EXYNOS || COMPILE_TEST [=y])
>
> [...]
>
>> caused by:
>> commit f0a6743028f938cdd34e0c3249d3f0e6bfa04073
>> Author: Jaehoon Chung <jh80.chung@samsung.com>
>> Date:   Fri Nov 13 18:01:39 2020 +0100
>>
>>      PCI: dwc: exynos: Rework the driver to support Exynos5433 varian
>>
>>
>> which removed "depends on PCI_MSI_IRQ_DOMAIN from config PCI_EXYNOS.
> Fixed up and squashed in the original commit - we should probably rework
> the DWC driver dependencies on PCI_MSI_IRQ_DOMAIN to really fix it, for
> the time being this should do.

Thanks! I wasn't aware of that hidden dependency.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

