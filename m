Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0DD2BA6DF
	for <lists+linux-pci@lfdr.de>; Fri, 20 Nov 2020 10:59:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727868AbgKTJ7P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 04:59:15 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:35623 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726959AbgKTJ7P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Nov 2020 04:59:15 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201120095902euoutp029a54798ef58d7ab62c7c059e851772c9~JLu42Z5f-0128901289euoutp02F
        for <linux-pci@vger.kernel.org>; Fri, 20 Nov 2020 09:59:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201120095902euoutp029a54798ef58d7ab62c7c059e851772c9~JLu42Z5f-0128901289euoutp02F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1605866342;
        bh=1Xgz3Vi28G/lFDopVGk+v6JNh2kYnT6n6pfNzZQVzhw=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=mCEKNiM8SUm5i7jTc/V4WQIa6my/v3nGMBLYpjSIwaKAbBqa2rnyYtpi4wk3v1c+1
         v5pGSF7xlwFEic85KmSQcmKWqjqPgKIADRGyyAzIwuYJ8kZZ/l33uAOso3A5C8Brix
         kF+eQ2vPfUR99Xn3Xaha5rH7toVojCMY4QjftIDM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201120095857eucas1p2f40340602f63199c141b8856be667c5a~JLuz33vTF3145031450eucas1p2b;
        Fri, 20 Nov 2020 09:58:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 1B.B2.45488.16397BF5; Fri, 20
        Nov 2020 09:58:57 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201120095857eucas1p2d51431962017b478816d3f0920438c91~JLuzjy_Xt2257522575eucas1p2V;
        Fri, 20 Nov 2020 09:58:57 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201120095857eusmtrp19b5be0806e79fdbfd8346bfe3af6cf08~JLuzi5qy-0739907399eusmtrp1Y;
        Fri, 20 Nov 2020 09:58:57 +0000 (GMT)
X-AuditID: cbfec7f5-c77ff7000000b1b0-b4-5fb7936150fc
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 46.88.16282.06397BF5; Fri, 20
        Nov 2020 09:58:56 +0000 (GMT)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201120095856eusmtip145ff2079c7f9880c52a591fc3e68073a~JLuy12Yef0586805868eusmtip1c;
        Fri, 20 Nov 2020 09:58:56 +0000 (GMT)
Subject: Re: [PATCH v4 4/5] phy: samsung: phy-exynos-pcie: rework driver to
 support Exynos5433 PCIe PHY
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <8eaebd62-345f-4d13-1b65-055a2acc68bd@samsung.com>
Date:   Fri, 20 Nov 2020 10:58:56 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <20201120094152.GC2925@vkoul-mobl>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsWy7djP87qJk7fHG9zZJmaxccZ6VoslTRkW
        84+cY7W48auN1WLFl5nsFhee9rBZnD+/gd3i8q45bBZn5x1ns5hxfh+TxZvfL9gt/u/ZwW6x
        884JZgdejzXz1jB67Jx1l91jwaZSj02rOtk8+rasYvQ4fmM7k8fnTXIB7FFcNimpOZllqUX6
        dglcGXNfxBT0cFTc3POeqYHxEFsXIyeHhICJxJTZhxi7GLk4hARWMEpcbpzCAuF8YZR4tG4j
        M4TzmVHi76ntzDAt+1Y8ZoNILGeUOLdvLVTLe0aJn4/2soBUCQtkSrzduZcRxBYRUJS42nOc
        FaSIWeAks8TF07vBRrEJGEp0ve0Cu4RXwE7i+5y1YHEWAVWJ1V9vs4LYogJJEtu3bGeFqBGU
        ODnzCdgCTgF9ibbJ08AWMAvIS2x/O4cZwhaXuPVkPhPEqZM5JfbOVoewXST6PmyC+lpY4tXx
        LewQtozE6ck9YB9ICDQzSjw8t5YdwukBBkfTDEaIKmuJO+d+AXVzAG3QlFi/Sx8i7Chx/Oli
        RpCwhACfxI23ghA38ElM2jadGSLMK9HRJgRRrSYx6/g6uLUHL1xinsCoNAvJZ7OQfDMLyTez
        EPYuYGRZxSieWlqcm55abJyXWq5XnJhbXJqXrpecn7uJEZjQTv87/nUH44pXH/UOMTJxMB5i
        lOBgVhLhXau5NV6INyWxsiq1KD++qDQntfgQozQHi5I4766ta+KFBNITS1KzU1MLUotgskwc
        nFINTFPMlZ0KZO68yCr/qdv/vOVtxd8jXV+WlsULc/cxevUVMMuKN1ydsIlVYTeTydcz91oM
        Jmdf4TQ7pbbGvFLr1Mbke03hhrcO1txff3PFlRWL5cQZOSNTG1YpqZ9dyh3bZSd0SmZR/f6w
        Qwax7dP1X5yPbfiSI3rqaHgXI+85V72ZIv80TjC1bIt2Ovyh++LMRpk3HUv86sxKevs2VPSZ
        ae1yP/HqYPX9CMkz287dNkxbYff/Ve7KG8y7YwR4tFNYZ3252KM5pThcwf26wpIpUu+sfT8f
        KjZdVsAonL84cFrnNDnpKydszeav/Jj5r/v0yrMNv/6LmS7ZKx8jmyD07sajg///mldd7DiS
        xaE4S4mlOCPRUIu5qDgRAKNFxy7XAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsVy+t/xu7oJk7fHGxz6bWOxccZ6VoslTRkW
        84+cY7W48auN1WLFl5nsFhee9rBZnD+/gd3i8q45bBZn5x1ns5hxfh+TxZvfL9gt/u/ZwW6x
        884JZgdejzXz1jB67Jx1l91jwaZSj02rOtk8+rasYvQ4fmM7k8fnTXIB7FF6NkX5pSWpChn5
        xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GXNfxBT0cFTc3POeqYHx
        EFsXIyeHhICJxL4Vj4FsLg4hgaWMEhtP3mOESMhInJzWwAphC0v8udYFVfSWUeLYpztMIAlh
        gUyJtzv3gjWICChKXO05zgpSxCxwklli7vbvzBAdrxglpm65AtbBJmAo0fW2C2w3r4CdxPc5
        a5lBbBYBVYnVX2+DrRMVSJKYefwsO0SNoMTJmU9YQGxOAX2JtsnTwLYxC5hJzNv8kBnClpfY
        /nYOlC0ucevJfKYJjEKzkLTPQtIyC0nLLCQtCxhZVjGKpJYW56bnFhvpFSfmFpfmpesl5+du
        YgTG8LZjP7fsYFz56qPeIUYmDsZDjBIczEoivGs1t8YL8aYkVlalFuXHF5XmpBYfYjQF+mci
        s5Rocj4wieSVxBuaGZgamphZGphamhkrifOaHFkTLySQnliSmp2aWpBaBNPHxMEp1cDEsXHb
        yzOJRf/c7DuM9M/f0A5ymB7JVrOnPpmR+W9MdkpV3vo/LgV90ea7LWYVnb700CbxgN2Wvh1h
        +RNm6Ew8oWeSZfXQV/llAv+hHMFsj9/x/Lv3Bswwebl5w3+bpjUvnjOx/k3NTvj42WaVvFJA
        5VmDDUbLWQXrSmb43zCeq9VRl9sTs3vDgk6eLIOW8lnv7NekzPxsOPGc/8ZrIaLrc+qk+5Zv
        PdRm12k/2e5YzyqV0BOc7nlrtmZ3aqUtdtm3Wcm+47YbQ17lm9+XbryZLv7v8uTf/ivsJu92
        MbNy9tx0uapgi53wXm3VefuPG9xVMN+YoDslb1ZiWeOXdvXTlkp7Z0ne3Phxzqr3HSJKLMUZ
        iYZazEXFiQAHfNgvagMAAA==
X-CMS-MailID: 20201120095857eucas1p2d51431962017b478816d3f0920438c91
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201113170158eucas1p14b9e58e35f929e14aeb4f533071c8a47
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201113170158eucas1p14b9e58e35f929e14aeb4f533071c8a47
References: <20201113170139.29956-1-m.szyprowski@samsung.com>
        <CGME20201113170158eucas1p14b9e58e35f929e14aeb4f533071c8a47@eucas1p1.samsung.com>
        <20201113170139.29956-5-m.szyprowski@samsung.com>
        <20201120094152.GC2925@vkoul-mobl>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Vinod,

On 20.11.2020 10:41, Vinod Koul wrote:
> On 13-11-20, 18:01, Marek Szyprowski wrote:
>> From: Jaehoon Chung <jh80.chung@samsung.com>
>>
>> Exynos5440 SoC support has been dropped since commit 8c83315da1cf ("ARM:
>> dts: exynos: Remove Exynos5440"). Rework this driver to support PCIe PHY
>> variant found in the Exynos5433 SoCs.
> I am expecting this series to go thru PCI tree, so:
>
> Acked-By: Vinod Koul <vkoul@kernel.org>

Frankly, the PHY driver can also go via PHY tree without causing any 
issue. The old driver is not used at all, so there is no runtime 
dependency. This will help avoiding the merge conflict: yesterday I've 
noticed that this patch conflicts with the commit 2f0c9fac3be6 ("phy: 
samsung: convert to devm_platform_ioremap_resource") in phy-next. The 
resolution is simple (use all the code from the new driver), but if 
needed I can resend the PHY driver after a rebase onto the current next 
tree.

Best regards

-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

