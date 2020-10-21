Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27870294C14
	for <lists+linux-pci@lfdr.de>; Wed, 21 Oct 2020 13:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442133AbgJUL7y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Oct 2020 07:59:54 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:52658 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2442120AbgJUL7y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Oct 2020 07:59:54 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201021115935euoutp02cedfa7a2c1f232e88c1b528f8a62bf0f~AABlFX4mF2189121891euoutp02P
        for <linux-pci@vger.kernel.org>; Wed, 21 Oct 2020 11:59:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201021115935euoutp02cedfa7a2c1f232e88c1b528f8a62bf0f~AABlFX4mF2189121891euoutp02P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603281575;
        bh=Dus0WFKWgtG3RUO35nNgNF6eLTL0Ew2Rvz62kIDSHnw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=HG6LlQMaxhn274r3LRlwEpP7DaTFR33sYPUBx9M1uNE2vDXIpAyiNVHeQSbCBazO9
         DmU8cRWn4E/e08/bYqBqxbLmp9VEyTD3cxYvHggfpAA/q6zNmYqITv+w+0frbAw/Sm
         4rVtDH4qrYaAjpZHTTxI4DXxSLAeXZzpk1UuRxnU=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201021115927eucas1p12cf0c2125a7dccbcf6fe1329ad4ef4a3~AABdYpZx71597615976eucas1p1a;
        Wed, 21 Oct 2020 11:59:27 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 0F.A6.06456.F92209F5; Wed, 21
        Oct 2020 12:59:27 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201021115927eucas1p15b4a43b951fe67b69374c87c97fdfdf9~AABc_p73D1597615976eucas1p1W;
        Wed, 21 Oct 2020 11:59:27 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201021115927eusmtrp1a5fd2918287d0dde791d195a4aeec1f7~AABc9yNuS3047130471eusmtrp1H;
        Wed, 21 Oct 2020 11:59:27 +0000 (GMT)
X-AuditID: cbfec7f2-809ff70000001938-b2-5f90229f6a38
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 00.BB.06314.E92209F5; Wed, 21
        Oct 2020 12:59:26 +0100 (BST)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201021115926eusmtip15186f6fcb609855a43f53997117081a1~AABb6V0BI2328223282eusmtip1S;
        Wed, 21 Oct 2020 11:59:25 +0000 (GMT)
Subject: Re: [PATCH 2/6] Documetation: dt-bindings: add the
 samsung,exynos-pcie binding
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <50b13de0-168b-3fad-1e84-cc86f1a376d8@samsung.com>
Date:   Wed, 21 Oct 2020 13:59:25 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.3.3
MIME-Version: 1.0
In-Reply-To: <CAJKOXPcyruYQxcioPxGE8J8jS0Yey+09HpXxFgQm4f2w98s5cg@mail.gmail.com>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01SfyyUcRze99737n3dHK9DPqlJZxU2v1Lr3TShbPdPW7bW0vLj5N2xHLpz
        fvWPCXGZH2XiJgwbSTEZTqPYcdnhjIWZMiZhifkxXIucl/Lf53mez/N9Ps/2JTHhANeejI5N
        YOSxkhgRj4+39u0Y3CpEBWGejXoRXZMeRVdoh7j0hDGLS9dtlBL08PdcHm0wNBH0aEcZjx4s
        1/HoEkMXh/75e4GgMzu1BK2Z+oz5mYsbyhuQWKP+Sogrm5Xi5vocnjivpR6JdRNtHPF6s8Mt
        4h7/aiQTE53IyD18w/lRK9vzeHyVY3JR9yqehtZOqpAZCdQlmP3RilSITwqpOgRv8nYxFmwg
        6JzUc1mwjqBYY8SOLPkfxg+FWgR7+d0EC1YQzE7XcVSIJK2pYJjsjTYZbCgXGP+zdWDAqC8Y
        dBe1cEwCj/IC1bKKZ5oFlC/sqYzINOPUOcguLzngbakIGJlOJ9gdK+gvncNN75tRQVDdGmKi
        MeoMtC2XYexsB5NzFRxTFlCLBPTPFxLs1Tfg1/uNwwbWsKRrOeRPg/5FLs4aniCYGXpLsCAX
        wWh6CWK3fGBqyMgzJWP7dRo7PFjaHxqebhwUBsoCJpat2CMs4HnrS4ylBZCdJWS3z4Na9+5f
        bPfwCFaAROpjzdTH6qiP1VH/z61EeD2yY5QKmZRReMUySe4KiUyhjJW6P4iTNaP9P6bf1a21
        o82RiB5EkUhkLkjm5IcJuZJERYqsBwGJiWwEAYP6UKEgUpKSysjjwuTKGEbRg06RuMhO4F21
        GCKkpJIE5iHDxDPyI5VDmtmnocguT//CHaKg7bY2xMG9xuoxXRpUPeaRtGWLZC4fBeG9jTnK
        4uATwXcGiq9l7G56YzNI2ZS54NxQ5rt55dPYK41rp4NfvfHsIx8nLClGquG33Hyd7nu9b6na
        LdCR0+6UvSoJjdB6XXT6VnsryyL5vuflC/2WGXdTA1eeOesDLLdFuCJK4uWKyRWSv17fhwFf
        AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLIsWRmVeSWpSXmKPExsVy+t/xu7rzlSbEG7Su5LBY0pRhMf/IOVaL
        G7/aWC1WfJnJbnHhaQ+bxfnzG9gtLu+aw2Zxdt5xNosZ5/cxWbz5/YLdonXvEXaLnXdOMDvw
        eKyZt4bRY+esu+weCzaVemxa1cnm0bdlFaPH8RvbmTw+b5ILYI/SsynKLy1JVcjILy6xVYo2
        tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3St0vQy3j/4xlLwSKFiikHP7A0MH6S7GLk
        5JAQMJHo332dtYuRi0NIYCmjxK8d75ggEjISJ6c1sELYwhJ/rnWxgdhCAm8ZJY48T+pi5OAQ
        FoiUuHU0EyQsIqApcf3vd7A5zALXmSXudK1nhhi6kUli+b25LCBVbAKGEl1vIQbxCthJ/O/6
        xQhiswioSnTMmwEWFxVIkth/4iYLRI2gxMmZT1hAlnEKBEos3hYLEmYWMJOYt/khM4QtL7H9
        7RwoW1zi1pP5TBMYhWYh6Z6FpGUWkpZZSFoWMLKsYhRJLS3OTc8tNtQrTswtLs1L10vOz93E
        CIzabcd+bt7BeGlj8CFGAQ5GJR7eCyz98UKsiWXFlbmHGCU4mJVEeJ3Ono4T4k1JrKxKLcqP
        LyrNSS0+xGgK9NtEZinR5HxgQskriTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBa
        BNPHxMEp1cCoJvXt95OKWo3/TfsESv+bvzixa5roq3tzzl6TKXx54yoTX9Yh6f9WYhP3Pqmf
        bfD37gtLAXUH794che01nv+M+E0Y7UTFzwvMz98/RzVvjZHGe6lA2SlFPtNrZiQGNC9fcrd1
        /a+bCrumbPyftuO3eJzDq419/akbT29tiNHWPp2nM3PtbaZgJZbijERDLeai4kQADjeQvfAC
        AAA=
X-CMS-MailID: 20201021115927eucas1p15b4a43b951fe67b69374c87c97fdfdf9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201019094739eucas1p18cd4c7e5a0197393d2e7c5c6fcc2777d
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201019094739eucas1p18cd4c7e5a0197393d2e7c5c6fcc2777d
References: <20201019094715.15343-1-m.szyprowski@samsung.com>
        <CGME20201019094739eucas1p18cd4c7e5a0197393d2e7c5c6fcc2777d@eucas1p1.samsung.com>
        <20201019094715.15343-3-m.szyprowski@samsung.com>
        <20201019101233.GB51073@kozik-lap>
        <CAJKOXPcyruYQxcioPxGE8J8jS0Yey+09HpXxFgQm4f2w98s5cg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krzysztof,

On 19.10.2020 12:18, Krzysztof Kozlowski wrote:
> On Mon, 19 Oct 2020 at 12:12, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>> On Mon, Oct 19, 2020 at 11:47:11AM +0200, Marek Szyprowski wrote:
>>> From: Jaehoon Chung <jh80.chung@samsung.com>
>>>
>>> Add dt-bindings for the Samsung Exynos PCIe controller (Exynos5433
>>> variant).
>> The title has typo and actually entire "Doc" should be dropped. Just
>> "dt-bindings: pci:".  This applies to all DT patches.
>>
>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>> [mszyprow: updated the binding to latest driver changes, rewrote it in yaml,
>>>           rewrote commit message]
>> If you wrote them in YAML it should be a new patch of yours. It is the
>> same then as converting TXT to YAML.
>>
>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> ---
>>>   .../bindings/pci/samsung,exynos-pcie.yaml     | 106 ++++++++++++++++++
>>>   1 file changed, 106 insertions(+)
>>>   create mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
>>> new file mode 100644
>>> index 000000000000..48fb569c238c
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
>>> @@ -0,0 +1,104 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: https://protect2.fireeye.com/v1/url?k=a6caf3f8-fb18e55d-a6cb78b7-0cc47a31bee8-bb3776dee0a03bbb&q=1&e=5f1b0c1e-e4d1-4ae2-b527-8cd5ec52695f&u=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fpci%2Fsamsung%2Cexynos-pcie.yaml%23
>>> +$schema: https://protect2.fireeye.com/v1/url?k=591573a2-04c76507-5914f8ed-0cc47a31bee8-bd08b2eac7a5040d&q=1&e=5f1b0c1e-e4d1-4ae2-b527-8cd5ec52695f&u=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23
>>> +
>>> +title: Samsung SoC series PCIe Host Controller Device Tree Bindings
>>> +
>>> +maintainers:
>>> +  - Jaehoon Chung <jh80.chung@samsung.com>
>>> +
>>> +description: |+
>>> +  Exynos5433 SoC PCIe host controller is based on the Synopsys DesignWare
>>> +  PCIe IP and thus inherits all the common properties defined in
>>> +  designware-pcie.txt.
>>> +
>>> +allOf:
>>> +  - $ref: /schemas/pci/pci-bus.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    enum:
>>> +      - samsung,exynos5433-pcie
>> const, not enum
>>
>>> +
>>> +  reg:
>>> +    items:
>>> +      - description: External Local Bus interface (ELBI) registers.
>>> +      - description: Data Bus Interface (DBI) registers.
>>> +      - description: PCIe configuration space region.
>>> +
>>> +  reg-names:
>>> +    items:
>>> +      - const: elbi
>>> +      - const: bdi
>>> +      - const: config
>>> +
>>> +  interrupts:
>>> +    maxItems: 1
>>> +
>>> +  clocks:
>>> +    items:
>>> +      - description: PCIe bridge clock
>>> +      - description: PCIe bus clock
>>> +
>>> +  clock-names:
>>> +    items:
>>> +      - const: pcie
>>> +      - const: pcie_bus
>>> +
>>> +  phys:
>>> +    maxItems: 1
>>> +
>>> +  phy-names:
>>> +    const: pcie-phy
>>> +
>>> +  vdd10-supply:
>>> +    description:
>>> +      Phandle to a regulator that provides 1.0V power to the PCIe block.
>>> +
>>> +  vdd18-supply:
>>> +    description:
>>> +      Phandle to a regulator that provides 1.8V power to the PCIe block.
>>> +
>>> +required:
>>> +  - reg
>>> +  - reg-names
>>> +  - interrupts
>>> +  - interrupt-names
>>> +  - clocks
>>> +  - clock-names
>>> +  - phys
>>> +  - phy-names
>>> +  - vdd10-supply
>> additionalProperties: false
> This can be unevaluatedProperties, since you include pci-bus schema.
> However still you should either include designware schema or include
> it's properties here.

Frankly, I would like to include designware-pci bindling/schema, but it 
has not been converted to yaml yet. I don't feel that I know PCI enough 
to do that conversion...

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

