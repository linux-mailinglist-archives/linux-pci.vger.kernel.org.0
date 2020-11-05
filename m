Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 350D52A797D
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 09:33:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbgKEIdf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 03:33:35 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:59832 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgKEIde (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Nov 2020 03:33:34 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201105083322euoutp02353072e69ded1f38e2254ed2b70ae731~Ej4z6GQl91070610706euoutp02w
        for <linux-pci@vger.kernel.org>; Thu,  5 Nov 2020 08:33:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201105083322euoutp02353072e69ded1f38e2254ed2b70ae731~Ej4z6GQl91070610706euoutp02w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1604565202;
        bh=7Yz8J6GZTwbfNKCQ4mFOSvlotdtwPM6/q1PO3xxI4iw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=e6dj/FcZNTo52348Olyufro+2qbMm3FNHDOWVogItiHsWUIE9o2gzto0gzWFfqfJd
         LPsiMuo4JCY32pbB6IeufTBxnj+286JHw9MTMawW7r8/r1YTCkrCH6p91WBYDq/OMX
         qz7ZRaxu1ftxvZh5Xwcxw9hpd23wlQR91wj8d4eo=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201105083317eucas1p144d27fd0ea27ff048b0f65b712b53a12~Ej4vEIQQa0043600436eucas1p1E;
        Thu,  5 Nov 2020 08:33:17 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 3C.CB.05997.DC8B3AF5; Thu,  5
        Nov 2020 08:33:17 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201105083317eucas1p22ce3b1760115a67f790cc61fd56afdb1~Ej4uvJe4j0538005380eucas1p2F;
        Thu,  5 Nov 2020 08:33:17 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201105083317eusmtrp1301749a1feb3fdea4905284f7e361490~Ej4uuKHsq0914309143eusmtrp1C;
        Thu,  5 Nov 2020 08:33:17 +0000 (GMT)
X-AuditID: cbfec7f4-65dff7000000176d-03-5fa3b8cd67e8
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id E0.23.06017.DC8B3AF5; Thu,  5
        Nov 2020 08:33:17 +0000 (GMT)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201105083316eusmtip27c1d22eb07c5b02a50a517b3ef230789~Ej4uGymFp3232832328eusmtip2b;
        Thu,  5 Nov 2020 08:33:16 +0000 (GMT)
Subject: Re: [PATCH v3 2/6] dt-bindings: pci: add the samsung,exynos-pcie
 binding
To:     Rob Herring <robh@kernel.org>
Cc:     linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <d89f5f0a-c45e-0bda-4db7-7b0cf9cd49fe@samsung.com>
Date:   Thu, 5 Nov 2020 09:33:18 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <20201104213539.GA4144654@bogus>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfUyMcRz3u+f1jodfV/SVl3RrXqI3mj0bWhFu/vJuM+TSo6Iuu+sif7Wa
        xrmlmLquVJPtEqX1er0s06yLdEVMkhrLVBOmzJxcunuK/vt8P5/vy+fz248l5B2UFxunThI0
        alW8gpaRdW2/uvw7LSWRQZNf1vB30mL5osc2iu+1Z1B86UQew3d/NNB8V1clw/c0FtB8Z6GV
        5o1dLRL+8+9hhp9qtjB8Q387EbZAeb/wPlI2mN4xyuIqnbKq7AqtzKwpQ0prb71EOV61ci9z
        VLY1WoiPSxY0gaEnZbGZDjs6d2vJhabyVjIVtcn1SMoCDoGpthFGj2SsHJciKMhtYZyCHE8g
        eD4VIArjCO60VEpmJ8zFzZQomBHUmK/RYvEVgf5LNu3scscHYKR8wLXKA/vA74wc1wSBswm4
        O2CgnAKNg0E/pp8eYFkOh0KOhXXSJPaFBvOAa89iHAV/xicJJ+awGzzJGyKdWIr9wTJ6yYUJ
        7A3ptfmEiD2hb6hoxukHBoae7hZxBGTdvEeJ2B1GrTWMiJdDxw0D6fQGOB3Be1s5IxYGBD1p
        RiR2bYF+m91llMDr4EFjoEiHg7H0ocRJA14IvWNuooeFcL0ulxBpDi5nzDz1ajBZK/6dfdT9
        gshCCtOcZKY5aUxz0pj+3y1GZBnyFHTahBhBu1EtnA/QqhK0OnVMwKnEhCo0/cU6HNYJC2qc
        jGpFmEWKBVwYWxIpp1TJ2pSEVgQsofDgtnd2nJBz0aqUi4ImMVKjixe0rWgZSyo8uU23R47L
        cYwqSTgrCOcEzawqYaVeqUi29luON3eLzH198rvHPqnviMlAcZtTdsf57BwM33De8WqsXZBk
        BdfWN/muP5jacPjMIb8AqzFihS7wk7/SsaPvx9KSdNqQZHtbkXngWfi2vvmWq7tOp/3UbWl/
        WW0s378o5Fj1kpjm2GEPu4+X40jpaP7gh8c1qeT4mz1BftSeeasUpDZWFexHaLSqvxUuWrhe
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsVy+t/xe7pndyyON+iaImyxpCnDYv6Rc6wW
        N361sVqs+DKT3eLC0x42i/PnN7BbXN41h83i7LzjbBYzzu9jsnjz+wW7xf89O9gtdt45wezA
        47Fm3hpGj52z7rJ7LNhU6rFpVSebR9+WVYwex29sZ/L4vEkugD1Kz6Yov7QkVSEjv7jEVina
        0MJIz9DSQs/IxFLP0Ng81srIVEnfziYlNSezLLVI3y5BL6Pv3y/GgrliFbvXHmJpYDwm1MXI
        ySEhYCKxfMEe1i5GLg4hgaWMErO6X7FCJGQkTk5rgLKFJf5c62KDKHrLKNHTdRcsISwQLPFy
        7T12EFtEQFHid9s0sEnMAhOZJS7vvcoM0fGCUWLNx2dsIFVsAoYSXW9BRnFw8ArYSUzbwQES
        ZhFQkdi5/B5YiahAksTLC1OZQGxeAUGJkzOfsIDYnAK6EjtetYLZzAJmEvM2P2SGsOUlmrfO
        hrLFJW49mc80gVFoFpL2WUhaZiFpmYWkZQEjyypGkdTS4tz03GIjveLE3OLSvHS95PzcTYzA
        yN127OeWHYxd74IPMQpwMCrx8DpwLI4XYk0sK67MPcQowcGsJMLrdPZ0nBBvSmJlVWpRfnxR
        aU5q8SFGU6DnJjJLiSbnA5NKXkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKY
        PiYOTqkGRoPgeEGDgoanHPyebcF7r3HPFMyZMrH92LJ/vvo21pyL3FdN4zeymimWfiaxNozl
        vinvD/Mvm7q8fZ5pc376e191mQRnXqq79t7Fb67Ncn7DNv++aN6sYIXjl5MPtB1X0fscYfWz
        Ra8n033v67OdkvyNznHGn18rdpo2ZSefC35+O0nsvVW1EktxRqKhFnNRcSIAUwLToPICAAA=
X-CMS-MailID: 20201105083317eucas1p22ce3b1760115a67f790cc61fd56afdb1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201029134038eucas1p28d9bd33bc9e36b960b021a40ef299b47
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201029134038eucas1p28d9bd33bc9e36b960b021a40ef299b47
References: <20201029134017.27400-1-m.szyprowski@samsung.com>
        <CGME20201029134038eucas1p28d9bd33bc9e36b960b021a40ef299b47@eucas1p2.samsung.com>
        <20201029134017.27400-3-m.szyprowski@samsung.com>
        <20201104213539.GA4144654@bogus>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 04.11.2020 22:35, Rob Herring wrote:
> On Thu, Oct 29, 2020 at 02:40:13PM +0100, Marek Szyprowski wrote:
>> Add dt-bindings for the Samsung Exynos PCIe controller (Exynos5433
>> variant). Based on the text dt-binding posted by Jaehoon Chung.
>>
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
>> ---
>>   .../bindings/pci/samsung,exynos-pcie.yaml     | 119 ++++++++++++++++++
>>   1 file changed, 119 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml

>> ...

>> +  num-viewport:
>> +    const: 3
> I'm confused why you need this. This is only used with the iATU except
> for keystone. Platforms like Exynos with their own child bus config
> space accessors don't have an iATU.

Frankly I have no idea, I don't know much about the PCI internals. After 
rebasing onto your latest DW PCI changes I've noticed a following 
warning message:

exynos-pcie 15700000.pcie: Resources exceed number of ATU entries (2)

Here is a complete log:

# dmesg | grep pci
ehci-pci: EHCI PCI platform driver
ohci-pci: OHCI PCI platform driver
exynos-pcie 15700000.pcie: host bridge /soc@0/pcie@15700000 ranges:
exynos-pcie 15700000.pcie:       IO 0x000c001000..0x000c010fff -> 
0x0000000000
exynos-pcie 15700000.pcie:      MEM 0x000c011000..0x000ffffffe -> 
0x000c011000
exynos-pcie 15700000.pcie: Resources exceed number of ATU entries (2)
exynos-pcie 15700000.pcie: Link up
exynos-pcie 15700000.pcie: PCI host bridge to bus 0000:00
pci_bus 0000:00: root bus resource [bus 00-ff]
pci_bus 0000:00: root bus resource [io  0x0000-0xffff]
pci_bus 0000:00: root bus resource [mem 0x0c011000-0x0ffffffe]
pci 0000:00:00.0: [144d:a5e3] type 01 class 0x060400
pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
pci 0000:01:00.0: [14e4:43e9] type 00 class 0x028000
pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00007fff 64bit]
pci 0000:01:00.0: reg 0x18: [mem 0x00000000-0x003fffff 64bit]
pci 0000:01:00.0: supports D1 D2
pci 0000:01:00.0: PME# supported from D0 D1 D2 D3hot D3cold
pci 0000:00:00.0: BAR 14: assigned [mem 0x0c200000-0x0c7fffff]
pci 0000:01:00.0: BAR 2: assigned [mem 0x0c400000-0x0c7fffff 64bit]
pci 0000:01:00.0: BAR 0: assigned [mem 0x0c200000-0x0c207fff 64bit]
pci 0000:00:00.0: PCI bridge to [bus 01-ff]
pci 0000:00:00.0:   bridge window [mem 0x0c200000-0x0c7fffff]
pci 0000:00:00.0: MSI quirk detected; MSI disabled
pcieport 0000:00:00.0: PME: Signaling with IRQ 97
brcmfmac: brcmf_fw_alloc_request: using brcm/brcmfmac4358-pcie for chip 
BCM4358/1

When I've increased the numer of viewports it has gone.

If this is not the proper solution, I will removed it.

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

