Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A78629AD3B
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 14:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900641AbgJ0NZd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 09:25:33 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:42364 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2900636AbgJ0NZZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 09:25:25 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20201027132501euoutp01e8bb0e3e3f2f6b0c7613aaaa2fa64666~B3D36NPCY1680116801euoutp01F
        for <linux-pci@vger.kernel.org>; Tue, 27 Oct 2020 13:25:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20201027132501euoutp01e8bb0e3e3f2f6b0c7613aaaa2fa64666~B3D36NPCY1680116801euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603805101;
        bh=POwP+6ssYbGtjKbozvag9P4TjIzi8CJK2Df+yEQb2Lo=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=K6LhHa/YWeddzq8aR7SmpSE3CPDmPj9oWRa4v+AHh4ANJUsYCXg7bOOx4ow9i6BbP
         e3nLp+K7YiDuwdB956MT1447kMc3r8FKp2jAFMFVe5WM1oY+Smtro7hR03GFJoV49O
         JGYw6mW58PsYmR8FanyyjoCSiGO4wFY9CxDYU7OY=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201027132459eucas1p227059f617b7ec439b0071b35264f5440~B3D2evzFI1793017930eucas1p2B;
        Tue, 27 Oct 2020 13:24:59 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 15.42.06456.BAF189F5; Tue, 27
        Oct 2020 13:24:59 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201027132459eucas1p1e31c288a9939f751765a3b54d00adf22~B3D2CwpNp1791517915eucas1p17;
        Tue, 27 Oct 2020 13:24:59 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201027132459eusmtrp1d17108d75a4f8a3f4980d58d607b4437~B3D2BlawX1693416934eusmtrp1a;
        Tue, 27 Oct 2020 13:24:59 +0000 (GMT)
X-AuditID: cbfec7f2-7efff70000001938-6f-5f981fabde84
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 10.05.06017.AAF189F5; Tue, 27
        Oct 2020 13:24:58 +0000 (GMT)
Received: from [106.210.88.143] (unknown [106.210.88.143]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201027132458eusmtip20ed65f267ccd092a632603c2fa3a3129~B3D1Z9p6B0052200522eusmtip2A;
        Tue, 27 Oct 2020 13:24:58 +0000 (GMT)
Subject: Re: [PATCH v2 5/6] pci: dwc: pci-exynos: rework the driver to
 support Exynos5433 variant
From:   Marek Szyprowski <m.szyprowski@samsung.com>
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
Message-ID: <4cad3d12-e47b-18a3-7c9f-1947415a14b6@samsung.com>
Date:   Tue, 27 Oct 2020 14:24:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <86df523b-cf3d-5a88-5ccc-c6f2ca9830a4@samsung.com>
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01Se0hTcRjtt3t3791ydTcNPywyRhlJOa2wC8V616WkFyFR2Zx60cjN2m09
        7B9rKLUsKqF0PiZlJHM+mI80LGlYSzY3syCRogdGrTTBZdB6er09/O983zmHcz74KEzlk8ZQ
        B41HOZNRn6sm5Hjbw6/+JXWxpbrEdlssU3Mmh7F3+6XMQLhIytR+LiOZvrfFBBMINJHMkzsV
        BNNb5SGY0sA9CTP87T3JFN7tJpmO54+wNRGss8qJ2A7bC5KtdplZl+McwV5scSDWM3BbwoZc
        c3eQe+Wrsrjcg8c4k0abLs+5X59y+NWSE69DBWQBciy0IhkF9HIYLazErUhOqehaBAHrOBKH
        zwga3HZSHEIIgnU+6V+Lr7KaEIlbCF7W3CAFQkWPIvC9yBRwJJ0Jdc9KJAIm6CSwjlgJAUfR
        86Hp3SAmmDHaj0Hn2EdcIBS0Fty/nmICxukF8PHVg0nDLDoDfoS+Y6JGCT1lQ5N6Gb0a2q94
        JoMxOhYsreWYiKNhcMguEQKAfkNCeaX7T+0NEAx9I0UcCR88LX/wHPCWFOOiwYLgtb+eFIdi
        BE/OlCJRtRKe+8MTlaiJiEXQeEcjrtdCV6BVIqyBngEDI0qxxAy40nYNE9cKOFukEtVxYPM0
        /Iu939ePXUJq25TTbFPOsU05x/Y/txrhDhTNmXlDNscnGbnjCbzewJuN2QmZeQYXmvgx70/P
        WDsa789wI5pC6ghF38hVnUqqP8afNLgRUJg6SrGu13tApcjSn8znTHk6kzmX491oNoWroxXL
        rgfTVHS2/ih3iOMOc6a/rISSxRQgV3xjxcjtVNCp+a7O7v3bNT3HY2Xs5ZhP6wuS/duah8fL
        NNqb6x2WxRd2s9O1X4jiPHyopLNs5wrlvlPnPaDRNleE7V2J/VWp7yLTBsM/8A3OjlW8d9O0
        mU5lum5efpp3z2nD5pQtccnDxq27vj82bvy5tCZ4pI23W95YLmuT1Tifo0+Kx0y8/jf4+QwJ
        XwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsVy+t/xe7qr5WfEG1xltVjSlGEx/8g5Vosb
        v9pYLVZ8mcluceFpD5vF+fMb2C0u75rDZnF23nE2ixnn9zFZvPn9gt2ide8Rdoudd04wO/B4
        rJm3htFj56y77B4LNpV6bFrVyebRt2UVo8fxG9uZPD5vkgtgj9KzKcovLUlVyMgvLrFVija0
        MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLOLjWp+CBbsXDzw3sDYyr1LsYOTkk
        BEwkzsxdwNbFyMUhJLCUUWLB1wdMEAkZiZPTGlghbGGJP9e6oIreMkoc//iIHSQhLJAs0T7h
        OQuIzSZgKNH1FqSIk0NEQEViw/NbzCANzALnmCVOfb3ACNF9kEli1/SPYFW8AnYSh/5fYQax
        WQRUJV4/OAoWFxVIknh5YSoTRI2gxMmZT8A2cArYS+yYdBxsM7OAmcS8zQ+ZIWx5ieats6Fs
        cYlbT+YzTWAUmoWkfRaSlllIWmYhaVnAyLKKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMG63
        Hfu5ZQdj17vgQ4wCHIxKPLwX3k6LF2JNLCuuzD3EKMHBrCTC63T2dJwQb0piZVVqUX58UWlO
        avEhRlOg5yYyS4km5wNTSl5JvKGpobmFpaG5sbmxmYWSOG+HwMEYIYH0xJLU7NTUgtQimD4m
        Dk6pBkab/29mcxpUlC7USbAo7J0VLZZjrdUUcFAyLDvpn3XXomWfK+vvmy7++nBC7bfXRn4L
        AsR6997NXahhHzBP+dBlpictC0uSNOR2sguuWjdt9p2jzb/Mze1OXuXY+e5PVlwb74fFPdrL
        T4ULLvj53bL7kUPuw0JT1rjSzh9b/Xddte9g+nXxtq0SS3FGoqEWc1FxIgBLGhE48QIAAA==
X-CMS-MailID: 20201027132459eucas1p1e31c288a9939f751765a3b54d00adf22
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201023075756eucas1p18765653e747842eef4b438aff32ef136
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201023075756eucas1p18765653e747842eef4b438aff32ef136
References: <CGME20201023075756eucas1p18765653e747842eef4b438aff32ef136@eucas1p1.samsung.com>
        <20201023075744.26200-1-m.szyprowski@samsung.com>
        <20201023075744.26200-6-m.szyprowski@samsung.com>
        <CAL_JsqK+kVOzLaYS6Xk9RoK8AOpVF+n5nNC1EBS-+UxR334d3g@mail.gmail.com>
        <86df523b-cf3d-5a88-5ccc-c6f2ca9830a4@samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi

On 27.10.2020 13:04, Marek Szyprowski wrote:
> On 26.10.2020 20:14, Rob Herring wrote:
>> On Fri, Oct 23, 2020 at 2:58 AM Marek Szyprowski
>> <m.szyprowski@samsung.com> wrote:
>>> From: Jaehoon Chung <jh80.chung@samsung.com>
>>>
>>> Exynos5440 SoC support has been dropped since commit 8c83315da1cf 
>>> ("ARM:
>>> dts: exynos: Remove Exynos5440"). Rework this driver to support DWC 
>>> PCIe
>>> variant found in the Exynos5433 SoCs.
>>>
>>> The main difference in Exynos5433 variant is lack of the MSI support
>>> (the MSI interrupt is not even routed to the CPU).
>>>
>>> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>
>>> [mszyprow: reworked the driver to support only Exynos5433 variant,
>>>             simplified code, rebased onto current kernel code, added
>>>             regulator support, converted to the regular platform 
>>> driver,
>>>             removed MSI related code, rewrote commit message]
>>> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
>>> Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
>>> ---
>>>   drivers/pci/controller/dwc/Kconfig      |   3 +-
>>>   drivers/pci/controller/dwc/pci-exynos.c | 358 
>>> ++++++++++--------------
>>>   drivers/pci/quirks.c                    |   1 +
>>>   3 files changed, 145 insertions(+), 217 deletions(-) 
...
>>> +static int __maybe_unused exynos_pcie_suspend_noirq(struct device 
>>> *dev)
>>> +{
>> Why noirq variant needed? Lot's of PCI host drivers do this and I've
>> yet to get a reason...
> Frankly, I have no idea, but switching to SET_LATE_SYSTEM_SLEEP_PM_OPS 
> breaks system suspend/resume operation - the board doesn't resume from 
> suspend. If this is really important I will add some more logs and try 
> to find what happens between late/early and noirq phases.

It looks that PCI framework does something with the device or controller 
in noirq phase, so the driver cannot shutdown the controller earlier. 
Here is a relevant part from the kernel log after system suspend/resume 
cycle captured with init_calldebug enabled:

$ dmesg | grep pci
brcmfmac 0000:01:00.0: calling pci_pm_suspend+0x0/0x248 @ 96, parent: 
0000:00:00.0
brcmfmac 0000:01:00.0: pci_pm_suspend+0x0/0x248 returned 0 after 650 usecs
pcieport 0000:00:00.0: calling pci_pm_suspend+0x0/0x248 @ 7, parent: 
pci0000:00
pcieport 0000:00:00.0: pci_pm_suspend+0x0/0x248 returned 0 after 85 usecs
exynos-pcie 15700000.pcie: calling platform_pm_suspend+0x0/0x68 @ 447, 
parent: soc@0
exynos-pcie 15700000.pcie: platform_pm_suspend+0x0/0x68 returned 0 after 
4 usecs
exynos_pcie_phy 15680000.pcie-phy: calling platform_pm_suspend+0x0/0x68 
@ 447, parent: soc@0
exynos_pcie_phy 15680000.pcie-phy: platform_pm_suspend+0x0/0x68 returned 
0 after 3 usecs
brcmfmac 0000:01:00.0: calling pci_pm_suspend_late+0x0/0x50 @ 448, 
parent: 0000:00:00.0
brcmfmac 0000:01:00.0: pci_pm_suspend_late+0x0/0x50 returned 0 after 4 usecs
pcieport 0000:00:00.0: calling pci_pm_suspend_late+0x0/0x50 @ 449, 
parent: pci0000:00
pcieport 0000:00:00.0: pci_pm_suspend_late+0x0/0x50 returned 0 after 4 usecs
exynos-pcie 15700000.pcie: calling exynos_pcie_suspend_late+0x0/0x30 @ 
447, parent: soc@0
exynos-pcie 15700000.pcie: exynos_pcie_suspend_late 439
exynos-pcie 15700000.pcie: exynos_pcie_suspend_late+0x0/0x30 returned 0 
after 17 usecs
brcmfmac 0000:01:00.0: calling pci_pm_suspend_noirq+0x0/0x278 @ 449, 
parent: 0000:00:00.0
brcmfmac 0000:01:00.0: pci_pm_suspend_noirq+0x0/0x278 returned 0 after 
24272 usecs
pcieport 0000:00:00.0: calling pci_pm_suspend_noirq+0x0/0x278 @ 448, 
parent: pci0000:00
pcieport 0000:00:00.0: pci_pm_suspend_noirq+0x0/0x278 returned 0 after 
196 usecs
exynos-pcie 15700000.pcie: calling exynos_pcie_suspend_noirq+0x0/0x40 @ 
447, parent: soc@0
exynos-pcie 15700000.pcie: exynos_pcie_suspend_noirq+0x0/0x40 returned 0 
after 653 usecs
exynos-pcie 15700000.pcie: calling exynos_pcie_resume_noirq+0x0/0x38 @ 
447, parent: soc@0
exynos-pcie 15700000.pcie: Link up
exynos-pcie 15700000.pcie: exynos_pcie_resume_noirq+0x0/0x38 returned 0 
after 91433 usecs
pcieport 0000:00:00.0: calling pci_pm_resume_noirq+0x0/0x140 @ 96, 
parent: pci0000:00
pcieport 0000:00:00.0: pci_pm_resume_noirq+0x0/0x140 returned 0 after 
316 usecs
brcmfmac 0000:01:00.0: calling pci_pm_resume_noirq+0x0/0x140 @ 143, 
parent: 0000:00:00.0
brcmfmac 0000:01:00.0: pci_pm_resume_noirq+0x0/0x140 returned 0 after 
25470 usecs
exynos-pcie 15700000.pcie: calling exynos_pcie_resume_late+0x0/0x30 @ 
447, parent: soc@0
exynos-pcie 15700000.pcie: exynos_pcie_resume_late 445
exynos-pcie 15700000.pcie: exynos_pcie_resume_late+0x0/0x30 returned 0 
after 24 usecs
pcieport 0000:00:00.0: calling pci_pm_resume_early+0x0/0x48 @ 449, 
parent: pci0000:00
pcieport 0000:00:00.0: pci_pm_resume_early+0x0/0x48 returned 0 after 3 usecs
brcmfmac 0000:01:00.0: calling pci_pm_resume_early+0x0/0x48 @ 448, 
parent: 0000:00:00.0
brcmfmac 0000:01:00.0: pci_pm_resume_early+0x0/0x48 returned 0 after 3 usecs
exynos_pcie_phy 15680000.pcie-phy: calling platform_pm_resume+0x0/0x60 @ 
447, parent: soc@0
exynos_pcie_phy 15680000.pcie-phy: platform_pm_resume+0x0/0x60 returned 
0 after 4 usecs
exynos-pcie 15700000.pcie: calling platform_pm_resume+0x0/0x60 @ 447, 
parent: soc@0
exynos-pcie 15700000.pcie: platform_pm_resume+0x0/0x60 returned 0 after 
4 usecs
pcieport 0000:00:00.0: calling pci_pm_resume+0x0/0xe0 @ 96, parent: 
pci0000:00
pcieport 0000:00:00.0: pci_pm_resume+0x0/0xe0 returned 0 after 54 usecs
brcmfmac 0000:01:00.0: calling pci_pm_resume+0x0/0xe0 @ 142, parent: 
0000:00:00.0
brcmfmac 0000:01:00.0: pci_pm_resume+0x0/0xe0 returned 0 after 554 usecs


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

