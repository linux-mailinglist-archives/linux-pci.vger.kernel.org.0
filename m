Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8F934E28C
	for <lists+linux-pci@lfdr.de>; Tue, 30 Mar 2021 09:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhC3Hvo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Mar 2021 03:51:44 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45710 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhC3HvZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Mar 2021 03:51:25 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20210330075120euoutp016f49b8b0293dbb1c087dec846749759a~xD2gRJUL51805918059euoutp014
        for <linux-pci@vger.kernel.org>; Tue, 30 Mar 2021 07:51:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20210330075120euoutp016f49b8b0293dbb1c087dec846749759a~xD2gRJUL51805918059euoutp014
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1617090680;
        bh=4ZU8JU5dLu7olvGA5ZP/USKvERh/tTogrL8NjlqXONQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=DT2oQeLusID/rFUNubrW9cJIVXZjKuq/PqwmZY8KE5Z6V+85NFhiDvKCgceq4ngzX
         uW7etzu03qEvYzfsXtrAHf7kUjgbnVyZfJDFgY6hHEo9N1RbcD+ZJLS05mUTebcRmV
         DxdXr83OjaT25Wq9+fO31Sj7Qsz0J6lQvCc4lTvQ=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20210330075120eucas1p24025aa530ba166593416ddd6c2b42ddd~xD2f7ISxW1692616926eucas1p26;
        Tue, 30 Mar 2021 07:51:20 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id AA.5C.09439.878D2606; Tue, 30
        Mar 2021 08:51:20 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210330075119eucas1p21f5e82c2af91a35212527c774235f130~xD2fXRLRt2528325283eucas1p2g;
        Tue, 30 Mar 2021 07:51:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210330075119eusmtrp153c5fd72e9e1ee8fb71cc78592f6bc09~xD2fWjHo91369013690eusmtrp1o;
        Tue, 30 Mar 2021 07:51:19 +0000 (GMT)
X-AuditID: cbfec7f5-c03ff700000024df-2e-6062d87866db
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 7D.87.08696.778D2606; Tue, 30
        Mar 2021 08:51:19 +0100 (BST)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20210330075119eusmtip14bc780d84124d956bdcb8dee85d0a9ce~xD2etibKW1462914629eusmtip1V;
        Tue, 30 Mar 2021 07:51:19 +0000 (GMT)
Subject: Re: [PATCH] PCI: dwc: Move forward the iATU detection process
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Zhiqiang Hou <Zhiqiang.Hou@nxp.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        robh@kernel.org, bhelgaas@google.com,
        gustavo.pimentel@synopsys.com, jingoohan1@gmail.com,
        =?UTF-8?B?7KCV7J6s7ZuI?= <jh80.chung@samsung.com>
Message-ID: <b777ab31-e0b9-bbc0-9631-72b93097919e@samsung.com>
Date:   Tue, 30 Mar 2021 09:51:18 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <5a4a7177-f8e1-6c8b-7c8a-8f5831de8455@samsung.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsWy7djP87oVN5ISDKa8FLNY0pRhsetuB7vF
        qzNr2Sxu/GpjtVjxZSa7xeVdc9gszs47zmbx5vcLdov/e3awW5xo+8DuwOWxZt4aRo+ds+6y
        eyzYVOqxaVUnm8fGdzuYPPq2rGL02LL/M6PH501yARxRXDYpqTmZZalF+nYJXBmHJvSxFDzg
        rfjT+puxgXEOdxcjJ4eEgInEhx9/mLoYuTiEBFYwSqxYth7K+cIocXXqClYI5zOjRMfUh2ww
        LZfermGDSCxnlDj7fwJU1UdGiSO3X7GDVAkLuEnMfT0VzGYTMJToetsF1MHBISKgJtHVHgpS
        zyzQzyTx9MAFZpAaXgE7iauPzjOC1LAIqEoc/GUOEhYVSJJY+ugfI0SJoMTJmU9YQGxOAXuJ
        Dc/WgrUyC8hLNG+dDWWLS9x6Mh/sBQmBdk6Jw+dmskJc7SLRfeUPO4QtLPHq+BYoW0bi9OQe
        FoiGZkaJh+fWskM4PYwSl5tmMEJUWUvcOfcL7ANmAU2J9bv0IcKOEm9bb7CDhCUE+CRuvBWE
        OIJPYtK26cwQYV6JjjYhiGo1iVnH18GtPXjhEvMERqVZSF6bheSdWUjemYWwdwEjyypG8dTS
        4tz01GLjvNRyveLE3OLSvHS95PzcTYzA5HX63/GvOxhXvPqod4iRiYPxEKMEB7OSCK/wgcQE
        Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4ry7tq6JFxJITyxJzU5NLUgtgskycXBKNTC1/WnY7B6R
        cbhJwz9+X6ha4x5ZP6ZJDEsWOk+7Xsc0V259sqzvuqv7/NZbuW4+GxwTWDy9oHoh6+m9njqP
        jx4482e3QdKOiCuv+fzaN6afPCyp0nzBuefm9Kp9bvmsTMfuHNyTmqD41ue+jef0pKUlDTGX
        c6V+7XhTav/x+tTjMgu118ZXTj3dxREw6U3oTAOxiwe43ZsO/uSv7trHH3p3vuzKM8uzFzc8
        ud8hd6LCyeBYZ+PM+Flxbs42Jy/lfbkS1Gil9C11Wv6laV1aEXdm3MkN8Hu38/CrhboeWZcO
        uZclM0nfuNoze4vBvfJm5Y4XVYfUYr0mxNgEfrxQyywsvmqSzRPVF5XynMv62TYqsRRnJBpq
        MRcVJwIAODEg2M0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFIsWRmVeSWpSXmKPExsVy+t/xu7rlN5ISDBa80bVY0pRhsetuB7vF
        qzNr2Sxu/GpjtVjxZSa7xeVdc9gszs47zmbx5vcLdov/e3awW5xo+8DuwOWxZt4aRo+ds+6y
        eyzYVOqxaVUnm8fGdzuYPPq2rGL02LL/M6PH501yARxRejZF+aUlqQoZ+cUltkrRhhZGeoaW
        FnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehmHJvSxFDzgrfjT+puxgXEOdxcjJ4eEgInE
        pbdr2LoYuTiEBJYySnz7c4oZIiEjcXJaAyuELSzx51oXG4gtJPCeUaJzAlhcWMBNYu7rqewg
        NpuAoUTXW5AaDg4RATWJrvZQkJnMAv1MEk+XbYTqPcwoceaXLYjNK2AncfXReUaQehYBVYmD
        v8xBwqICSRJtu2eyQ5QISpyc+YQFxOYUsJfY8Gwt2GnMAmYS8zY/hLLlJZq3zoayxSVuPZnP
        NIFRaBaS9llIWmYhaZmFpGUBI8sqRpHU0uLc9NxiI73ixNzi0rx0veT83E2MwEjdduznlh2M
        K1991DvEyMTBeIhRgoNZSYRX+EBighBvSmJlVWpRfnxRaU5q8SFGU6B3JjJLiSbnA1NFXkm8
        oZmBqaGJmaWBqaWZsZI4r8mRNfFCAumJJanZqakFqUUwfUwcnFINTKUm5m3lNxO/q9+UX5qv
        +kUz1rDwHe/5+1NvBJ6oeH9hdujuZTp7pNbKrisJTuo9e33XEkbx1412Hnt/qvTd3vWv27Iq
        vnT1Sm397Y02m5n2rfj29Fu50RSHW6InpgcGHRa72lkudsHqWv7S3ff2ZE7ML1es+bVYSO/D
        01u7+L1U7Yo3fGiu4G1wnR3rEvBBaXYfr6r4RYO4Y6a6072vC/D2nHfq3vU78ZyDSuyk1elv
        JI+KvzF3C+Q9a5r+ac2Px7WrHr/e0LTu+U+3vpvpyw7+1ckq65m3XPvPxrMXN0eZymruSz32
        VDUpReEPZ8a8ZOlFvwo09E9dE/x+Z9Z2RevtN2YlHExbGWXVLXPcZIsSS3FGoqEWc1FxIgCk
        mt6nXQMAAA==
X-CMS-MailID: 20210330075119eucas1p21f5e82c2af91a35212527c774235f130
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210325201938eucas1p14d874a2805450173ef7eb1ac20bb7941
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210325201938eucas1p14d874a2805450173ef7eb1ac20bb7941
References: <CGME20210325201938eucas1p14d874a2805450173ef7eb1ac20bb7941@eucas1p1.samsung.com>
        <20210325201932.GA808102@bjorn-Precision-5520>
        <5a4a7177-f8e1-6c8b-7c8a-8f5831de8455@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 26.03.2021 18:05, Marek Szyprowski wrote:
> On 25.03.2021 21:19, Bjorn Helgaas wrote:
>> On Thu, Mar 25, 2021 at 10:24:28AM +0100, Marek Szyprowski wrote:
>>> On 25.01.2021 05:48, Zhiqiang Hou wrote:
>>>> From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>>>>
>>>> In the dw_pcie_ep_init(), it depends on the detected iATU region
>>>> numbers to allocate the in/outbound window management bit map.
>>>> It fails after the commit 281f1f99cf3a ("PCI: dwc: Detect number
>>>> of iATU windows").
>>>>
>>>> So this patch move the iATU region detection into a new function,
>>>> move forward the detection to the very beginning of functions
>>>> dw_pcie_host_init() and dw_pcie_ep_init(). And also remove it
>>>> from the dw_pcie_setup(), since it's more like a software
>>>> perspective initialization step than hardware setup.
>>>>
>>>> Fixes: 281f1f99cf3a ("PCI: dwc: Detect number of iATU windows")
>>>> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
>>> This patch causes exynos-pcie to hang during the initialization. It
>>> looks that some resources are not enabled yet, so calling
>>> dw_pcie_iatu_detect() much earlier causes a hang. When I have some 
>>> time,
>>> I will try to identify what is needed to call it properly.
>> Thanks, I dropped it for now.  We can add it back after we figure out
>> what the exynos issue is.
> Thanks, I will try to identify at which point of initialization it is 
> safe to call iATU region detection.

I've just checked and it is enough to move the

dw_pcie_iatu_detect(pci);

after

pp->ops->host_init(pp);

in dw_pcie_host_init() to fix driver operation on Exynos SoCs with the 
$subject patch applied.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

