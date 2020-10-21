Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7518294C3A
	for <lists+linux-pci@lfdr.de>; Wed, 21 Oct 2020 14:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411221AbgJUMGO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Oct 2020 08:06:14 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:54837 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439994AbgJUMGN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Oct 2020 08:06:13 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201021120555euoutp020a20ab7db457fd450b42a9411b647c70~AAHGyi-iv2687126871euoutp02H
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2020 12:05:55 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201021120555euoutp020a20ab7db457fd450b42a9411b647c70~AAHGyi-iv2687126871euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603281955;
        bh=X3kWCN2insXbfhyivHExtQ0c0hScyZQ29grQTMC6Jd4=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=aOViI/kkTaT+jTJcQIuMumypOe+Wg6z860rGnh25YkPjkTfmtqJ19Xm0ZTa4pkz0O
         SXRZ5guRZEFLHPKQzvjLZ+bggHQVFer/K5GLq3XeLdz0sB/FqLVIMVd2m+ia6G3qqg
         fn+KnF0ydNrJ/gG99Vt2tUr/YuMzblGbQ8Woaoxs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201021120543eucas1p223b9fc6bcdd09141054312b4a0db507f~AAG7YIkMY1838718387eucas1p2b;
        Wed, 21 Oct 2020 12:05:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A8.95.06318.714209F5; Wed, 21
        Oct 2020 13:05:43 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201021120543eucas1p29d4affba97d6143a9e2f725c2f561ed9~AAG7A7ABU2093620936eucas1p2C;
        Wed, 21 Oct 2020 12:05:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201021120542eusmtrp12cb67e97e361efc4e23c768176845e2c~AAG690Bso0226702267eusmtrp1J;
        Wed, 21 Oct 2020 12:05:42 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-52-5f9024171eeb
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 5A.9C.06314.314209F5; Wed, 21
        Oct 2020 13:05:39 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201021120538eusmtip2e5d03d4cb5af5004b03051d7e7d31960~AAG2mj0ma0530205302eusmtip2d;
        Wed, 21 Oct 2020 12:05:38 +0000 (GMT)
Subject: Re: [PATCH 2/6] Documetation: dt-bindings: add the
 samsung,exynos-pcie binding
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
Message-ID: <b85e65bc-5a76-e9af-db59-6ea7539668ef@samsung.com>
Date:   Wed, 21 Oct 2020 14:05:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <CAL_Jsq+X3w=1-_SpXPTdO_UGg5er9vU-XETT-NbS96LSfNLUVQ@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SbUhTYRTm3b279youXpexg33R0r5IrezHhaIs+nFJotJILMpm3lTUJbta
        OYLWSrMxdBiVLUuRKFtqtkalqeiyVgw3MxbDTAlWaTaLZkVfVvNq+e+c54PnPHAYQu6URjLZ
        6gJeo1blKqlQ8s6jb+4YRZQpbYWvV8Fe0Wex1V0uKev9XiJl68Yu0GzPayPFut1NNPuspYpi
        uy87KLbS3S5h3/8Yotniti6abe5/TCSEcfWX6xHXbH5JczXWQs5qOU1xZTYL4hzeuxIuYJ23
        jd4VujaDz80+xGvi1u0LzfKUj9P5ZxcduXErWYea5hpQCAN4NQx8O0MbUCgjx3UIfIGPlLiM
        IbC57k0uAQQPbg/QU5YObx0pEtcQ3O+4Kg0ScvwBwZBxpwExzEycCn0Ps4NwBI6Cprd9RFBP
        YBcBrZ9GyCBB4ZVg8Buo4CzD6+DHb89EAImjwT/SMKGZhdOhd1BPi5pweHLBN4GH4O0w6NRN
        eAk8H+76qwhxVkCfr1oSDAM8TMMlkx6JV2+C3hEbJc4z4Z3DNtlmDjjPGEnRcALBK1cDLS5G
        BM/0lZPuNdDv+k4FqxF4KdxsiRPhDVB/akwShAHPAK8/XDxiBlTcOU+IsAxKS+SiehGYHY3/
        Yjt7egkTUpqnVTNPq2OeVsf8P7cGkRak4AuFvExeiFfzh2MFVZ5QqM6M3X8wz4r+vphz3PH5
        Hmr/mW5HmEHKMFkPWZ4ml6oOCUV5dgQMoYyQbex27pXLMlRFWl5zME1TmMsLdjSbIZUKWXzt
        8B45zlQV8Dk8n89rplgJExKpQ+nxozlt8oLk19Efvy4v73rBJ110XB94078iIcmTs2fzuQj9
        +q2a0d3aDJOs+mzigYr0yt+lmvwyqqHVbdrL3Rw/HhPwQc2qxTuFRHttJ5fiO/Yp5fCv21rD
        lpNlv2xHn4dZFnTv0I1rl3zxpDztjhLeFju1C6skm7Y2ShNT6ztblaSQpVq5jNAIqj9jIiFP
        XgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsVy+t/xe7rCKhPiDXacZbFY0pRhMf/IOVaL
        G7/aWC1WfJnJbnHhaQ+bxfnzG9gtLu+aw2Zxdt5xNosZ5/cxWbz5/YLdonXvEXaLnXdOMDvw
        eKyZt4bRY+esu+weCzaVemxa1cnm0bdlFaPH8RvbmTw+b5ILYI/SsynKLy1JVcjILy6xVYo2
        tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy7ja/4+9YKpaxeqNwQ2MG2S7GDk5
        JARMJA7cWMHSxcjFISSwlFFi77u/TBAJGYmT0xpYIWxhiT/Xutggit4ySvRMbwLq4OAQFoiU
        uHU0E6RGREBFYsPzW8wgNcwC55glTn29wAjR0MMk8XnWfDaQKjYBQ4mut11gNq+AncTv/1fZ
        QWwWAVWJt6/XsoDYogJJEvtP3GSBqBGUODnzCZjNKRAocf90A1gvs4CZxLzND5khbHmJ7W/n
        QNniEreezGeawCg0C0n7LCQts5C0zELSsoCRZRWjSGppcW56brGhXnFibnFpXrpecn7uJkZg
        3G479nPzDsZLG4MPMQpwMCrx8F5g6Y8XYk0sK67MPcQowcGsJMLrdPZ0nBBvSmJlVWpRfnxR
        aU5q8SFGU6DnJjJLiSbnA1NKXkm8oamhuYWlobmxubGZhZI4b4fAwRghgfTEktTs1NSC1CKY
        PiYOTqkGxmkPDBe+P5xprPnV9kjuuxUct85td+rJuCl3vz+2POSuoeyN60xqc5SO26yb9XH/
        za3Ht0e6c0aqd7ZPvX5g72yfLSr8B5eyMn5bct5838LaG2YC76TXPLCeup7VdKFSTse35mQ+
        HTV+s8PzHnLdZ38ketf0wTQvvoVaOltWPT0qtmiRc2mGWYwSS3FGoqEWc1FxIgASbYMc8QIA
        AA==
X-CMS-MailID: 20201021120543eucas1p29d4affba97d6143a9e2f725c2f561ed9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201019094739eucas1p18cd4c7e5a0197393d2e7c5c6fcc2777d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201019094739eucas1p18cd4c7e5a0197393d2e7c5c6fcc2777d
References: <CGME20201019094739eucas1p18cd4c7e5a0197393d2e7c5c6fcc2777d@eucas1p1.samsung.com>
        <20201019094715.15343-1-m.szyprowski@samsung.com>
        <20201019094715.15343-3-m.szyprowski@samsung.com>
        <CAL_Jsq+X3w=1-_SpXPTdO_UGg5er9vU-XETT-NbS96LSfNLUVQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rob,

On 19.10.2020 15:38, Rob Herring wrote:
> On Mon, Oct 19, 2020 at 4:47 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> From: Jaehoon Chung <jh80.chung@samsung.com>
>>
>> Add dt-bindings for the Samsung Exynos PCIe controller (Exynos5433
>> variant).
>>
>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>> [mszyprow: updated the binding to latest driver changes, rewrote it in yaml,
>>             rewrote commit message]
>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> ---
>>   .../bindings/pci/samsung,exynos-pcie.yaml     | 106 ++++++++++++++++++
>>   1 file changed, 106 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
>> new file mode 100644
>> index 000000000000..48fb569c238c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
>> @@ -0,0 +1,104 @@
>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>> +%YAML 1.2
>> +---
>> +$id: https://protect2.fireeye.com/v1/url?k=3dfd0348-6067aaeb-3dfc8807-002590f5b904-a68fd848316a7cc4&q=1&e=261ae2d1-4457-43b7-8727-35f3cfbc45c0&u=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fpci%2Fsamsung%2Cexynos-pcie.yaml%23
>> +$schema: https://protect2.fireeye.com/v1/url?k=ab825ba1-f618f202-ab83d0ee-002590f5b904-4aba44c12cb70753&q=1&e=261ae2d1-4457-43b7-8727-35f3cfbc45c0&u=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
>> +
>> +title: Samsung SoC series PCIe Host Controller Device Tree Bindings
>> +
>> +maintainers:
>> +  - Jaehoon Chung <jh80.chung@samsung.com>
>> +
>> +description: |+
>> +  Exynos5433 SoC PCIe host controller is based on the Synopsys DesignWare
>> +  PCIe IP and thus inherits all the common properties defined in
>> +  designware-pcie.txt.
>> +
>> +allOf:
>> +  - $ref: /schemas/pci/pci-bus.yaml#
>> +
>> +properties:
>> +  compatible:
>> +    enum:
>> +      - samsung,exynos5433-pcie
>> +
>> +  reg:
>> +    items:
>> +      - description: External Local Bus interface (ELBI) registers.
>> +      - description: Data Bus Interface (DBI) registers.
>> +      - description: PCIe configuration space region.
>> +
>> +  reg-names:
>> +    items:
>> +      - const: elbi
>> +      - const: bdi
> dbi
>
>> +      - const: config
>> +
>> +  interrupts:
>> +    maxItems: 1
>> +
>> +  clocks:
>> +    items:
>> +      - description: PCIe bridge clock
>> +      - description: PCIe bus clock
>> +
>> +  clock-names:
>> +    items:
>> +      - const: pcie
>> +      - const: pcie_bus
>> +
>> +  phys:
>> +    maxItems: 1
>> +
>> +  phy-names:
>> +    const: pcie-phy
> Kind of a pointless name.

Most of the other PCI(e) drivers uses such:

# git grep "phy-names =" Documentation/devicetree/bindings/pci/

Do you want me to change it to simple "pcie"?

>> +
>> +  vdd10-supply:
>> +    description:
>> +      Phandle to a regulator that provides 1.0V power to the PCIe block.
>> +
>> +  vdd18-supply:
>> +    description:
>> +      Phandle to a regulator that provides 1.8V power to the PCIe block.
>> +
>> +required:
>> +  - reg
>> +  - reg-names
>> +  - interrupts
>> +  - interrupt-names
>> +  - clocks
>> +  - clock-names
>> +  - phys
>> +  - phy-names
>> +  - vdd10-supply
>> +
>> +examples:
>> +  - |
>> +    #include <dt-bindings/interrupt-controller/irq.h>
>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +    #include <dt-bindings/clock/exynos5433.h>
>> +
>> +    pcie: pcie@15700000 {
>> +        compatible = "samsung,exynos5433-pcie";
>> +        reg = <0x156b0000 0x1000>, <0x15700000 0x1000>, <0x0c000000 0x1000>;
>> +        reg-names = "elbi", "dbi", "config";
>> +        #address-cells = <3>;
>> +        #size-cells = <2>;
>> +        #interrupt-cells = <1>;
>> +        device_type = "pci";
>> +        interrupts = <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>;
>> +        clocks = <&cmu_fsys CLK_PCIE>, <&cmu_fsys CLK_PCLK_PCIE_PHY>;
>> +        clock-names = "pcie", "pcie_bus";
>> +        phys = <&pcie_phy>;
>> +        phy-names = "pcie-phy";
>> +        pinctrl-names = "default";
>> +        pinctrl-0 = <&pcie_bus &pcie_wlanen>;
>> +        num-lanes = <1>;
>> +        bus-range = <0x00 0xff>;
>> +        ranges = <0x81000000 0 0         0x0c001000 0 0x00010000>,
>> +                 <0x82000000 0 0x0c011000 0x0c011000 0 0x03feefff>;
>> +        vdd10-supply = <&ldo6_reg>;
>> +        vdd18-supply = <&ldo7_reg>;
>> +        iterrupt-map-mask = <0 0 0 0>;
> typo
>
>> +        interrupt-map = <0 0 0 0 &gic GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>;
>> +    };
>> --
>> 2.17.1
>>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

