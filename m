Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD97303D2D
	for <lists+linux-pci@lfdr.de>; Tue, 26 Jan 2021 13:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391550AbhAZMkw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 Jan 2021 07:40:52 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:42026 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403859AbhAZKOO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 Jan 2021 05:14:14 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20210126101322euoutp020b4e0b2578308c7c33ca126f141ef64d~dwJiGCfw91531515315euoutp02c;
        Tue, 26 Jan 2021 10:13:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20210126101322euoutp020b4e0b2578308c7c33ca126f141ef64d~dwJiGCfw91531515315euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1611656003;
        bh=tenaChUOPWN+TjdSN94yGfg4JVgE422Qow8mGZKWxmU=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=PQbFYlUwWphocIp18Zkw995lGKR0ECAnGMqg1rfjLHGLghqqoYZRjWgK+/Dyq2Nas
         UrgAx8sBe9GXcjH9NJ5+V7r4Pjqu7rdwLqtNqItc7HBwY2dwY9AgLxKWmvb02O8Irz
         D6qW90gdzHZhdkXiJoFXVSALNh1469FpiMtRfcVg=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20210126101322eucas1p1bde65ae9ec10e0fd6a2f05840a345a99~dwJh6P9Mk0756807568eucas1p19;
        Tue, 26 Jan 2021 10:13:22 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id AC.57.45488.24BEF006; Tue, 26
        Jan 2021 10:13:22 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20210126101322eucas1p2a54daff89cfebe5aaf3a9b5b0fa281ad~dwJhSBHa31256412564eucas1p2r;
        Tue, 26 Jan 2021 10:13:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20210126101322eusmtrp1503a93e4c3dd78b1e6117c5f441fca2d~dwJhQtVYK2213122131eusmtrp1L;
        Tue, 26 Jan 2021 10:13:22 +0000 (GMT)
X-AuditID: cbfec7f5-c5fff7000000b1b0-a7-600feb4271a3
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 66.5E.21957.14BEF006; Tue, 26
        Jan 2021 10:13:21 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20210126101320eusmtip250948c1ccaa4131b5c43f5f9d697581e~dwJfjH2nZ0723407234eusmtip2d;
        Tue, 26 Jan 2021 10:13:20 +0000 (GMT)
Subject: Re: [PATCH RFC 1/2] dt: pci: designware-pcie.txt: convert it to
 yaml
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Message-ID: <b6ab7110-fc87-85d7-d591-dffad32985ec@samsung.com>
Date:   Tue, 26 Jan 2021 11:13:20 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0)
        Gecko/20100101 Thunderbird/78.6.1
MIME-Version: 1.0
In-Reply-To: <55f479324098b66d7dba89c8f9c3e455731df4f7.1611645945.git.mchehab+huawei@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Brightmail-Tracker: H4sIAAAAAAAAA01TaVBTZxTt997Le4/Q0JcIw1e0Y2Wki20Rq3a+KQytbae8bgMzdnQqVojy
        BhzWJuDSqnVAlgRkiyyGtUARGAoSUpR0iQUkpJBARZZSoOygQBwLyDZggact/84999x77vlx
        aVwyRDrQJ0PCOVmINMiRFBI1jYvmN96bfM7XpThmJzIPLxOoKDIANestBMprMAvQYIcn0vXF
        Uai+OxIgdU0OQFNDDTgar1PjqGT2KoUuqQsI1P/oH4DK0moJtBirxVDbaAKJWluvU2gg508M
        5WdZI72hFEOa4U4BStGbKKRcKsVRuy6bRFlFSQQy5RpIlNn6K4YUs2oSNRYYCTSY1QFQXaI3
        iv6lgUIrNzQEmtDao0VdLoEUUxYKDXVmY+86sSVtSgHbVeHFPuiOptjc8m/YWnUfxeZrItjR
        ZBXFDudUUaymTEGyvZ0/k2x10bfs5SgLyVZZbmJs0ooL25QxT7Ba/QzwkhwRuvlxQSdPcbLd
        7r7CgKnvYwRhDTZnJnJnqYsgzVoJrGjI7IOFI3pCCYS0hCkBMNM4gPPFLIBXTIkCvpgBMHF8
        GDwdWRjMFKxjCXMNwJbuo7zoIYBxxcvkemML4wlT9Ty2Zb6ApvJMYh3jzF9CmF54bh2TzB6o
        nFZuaESMO1zOzt5YSjBO8N54zIaZHXMc9vXWY7xGDI1XRzb2WDG+0LCURPI7t8Mb09k4j+1h
        z0getn4QZBaEsFHVQ/FXfwDLC+cJHm+B9w3aJ/w22KxKIPiBKAAHzT9QfJEAYHtk5pPMrrDX
        vLRmR69ZvAordbt5+gDMqMjfoCFjA7unxfwRNjC1JgPnaRGMi5Hw6peg2lDxn+1vbXfwZOCo
        3hRNvSmOelMc9f+++YAoA/ZchDzYn5PvDeFOO8ulwfKIEH/nE6HBGrD2Bs2rhrmboOT+Q+c6
        gNGgDkAad7QV/eT8rK9E5Cc9+zUnC/WRRQRx8jqwlSYc7UW6H8t9JIy/NJwL5LgwTva0i9FW
        DhcxO7srGc/XV1empy8OFWgdyg4lFLoH7Q80hPtJjRfSW1c/ZVXWC8Vdhx88Vv+x6/RnA5+f
        7837ROVxTjfz3YvbPoz1GGWvpUSJxG3Ml69l3fvo/IQnfsI1gzpT8fEF53mTePptt7tH0opf
        77JVxN9lj1ZqWkJjZyeD7ZJLLTvpF+LfHGsPbTIp/DzoaKw26VFp4djhHitF/KEdI07B5ttT
        E9e73YrJfqGPwHJ5rmX7K/3vbHUau33rq9/D9p0NOObzd6rflFdTldXqgYOhgXM7XCYrjwVc
        qrIJci0Ve1NztrdExx9bDqYw2pkmaumZvS9HGsEp4x3fphSxR8f+PO8VTlAteP8tR0IeIN2z
        C5fJpf8CadsTXnUEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUwTdxjH9+td71oEdhYMJ1uEdCHuxZ0UofuBjqBs7hamEF2WTeZKlRPI
        oCU9ujH8A8Z4sY0O1OnoUQpj4BQbI6UIgqOzY1YkQKeh6jLYeJM6CkToFHBlo9Ql/PdJnufz
        ffIkXwEicvNDBVmKPEalkGeLMT+0d9k2/PrOqefTIm3fxMH+sacobCjOhL2WGRTWdvfz4chg
        MuwYOobDn+8VA8hdqQHQNdqNwEkrh8Dzbh0OS7h6FA4/ngOw6cxVFC6Wm3nQPnEcgwMDl3H4
        Z819HqyrXgcttgs8aBpz8OFJSx8OtUsXEHinQ4/B6oYKFPYZbBisGujiQY2bw+CN+h4UjlQP
        Amj9OhWW/tiNQ0+bCYVOcwhc7DCgUOOaweGoQ89LiKDP27V8+u6lFHr2XilOG4xH6avcEE7X
        mdT0ROVpnB6racZpU5MGo393XMPoloZC+sRXMxjdPNPOoys8kfTNb5+gtNkyD1JEB6gdKqU6
        jwnPVLJ5b4pTJTCKksRCKio6lpJse+NgXFSMeGv8jnQmO+szRrU1Po3KdDWW8XO7A/OdBjde
        BM6s0wKhgCSiyYWRKr4W+AlERCMgWycf8n2DF8mes0XPOIj8x6HFfEuzgHT9bQbeQRCxh5xb
        vIN7OZj4iDxmrFllhPjDj2zVhHtZRDwA5C3dES9jhITUTnuDhIIAIp58qtevHkCJCPLhZNlq
        5gbiEHmTm0N8O+vJHt046mUhkUbaliowX76UNLSMID4OI9um9c84hPxtvJZXCUTcGp1bo3Br
        FG6NUgfQJhDMqNmcjBxWQrHyHFatyKAOK3NMYKV+V24strQDw1+PKCvgCYAVkAJEHBzQSfmn
        iQLS5V8UMCqlTKXOZlgriFn55yQSuuGwcqW/ijyZRBoZI4mWxkbGxEq3iUMCWmuMMhGRIc9j
        PmWYXEb1v8cTCEOLeDB1emG+bzf/y3Mek1r3yeWh5V0JokSzaz7Y6FhwckcLl18eX+gUENLE
        wY9va8/6bbHLZm7d/S6pZb1/gj1RWv7k3ZykromuMHCq6lTg9WhF6r76jqae5Djl8T2Tpe9P
        Uhu5INZjoB6MLLfdbvA/Xb+P3VRreefSe0HFu6eQt9hw+0ZMUpDfN/zCxdlkxYevtB96+8jS
        dOEvnl/dgZv+LSiR6a5Xlnfej/je1Juy/0S3Q1DyEozt6zfufNR8Lnd2XmZuvOaaCq88ULvd
        +VNretRjfdYPF1/7IEldNW30ROzaUv952X5xnP9onV9hmLtwabvj4F6NW/fcZqcwge/Kl9qc
        YWKUzZRLXkVUrPw/SLJQEAcEAAA=
X-CMS-MailID: 20210126101322eucas1p2a54daff89cfebe5aaf3a9b5b0fa281ad
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20210126074127eucas1p1dd8f2d1704d708d64458922566b934f1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20210126074127eucas1p1dd8f2d1704d708d64458922566b934f1
References: <cover.1611645945.git.mchehab+huawei@kernel.org>
        <CGME20210126074127eucas1p1dd8f2d1704d708d64458922566b934f1@eucas1p1.samsung.com>
        <55f479324098b66d7dba89c8f9c3e455731df4f7.1611645945.git.mchehab+huawei@kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Mauro,

On 26.01.2021 08:35, Mauro Carvalho Chehab wrote:
> Convert the file into a JSON description at the yaml format.
>
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>   .../bindings/pci/amlogic,meson-pcie.txt       |   4 +-
>   .../bindings/pci/axis,artpec6-pcie.txt        |   2 +-
>   .../bindings/pci/designware,pcie.yaml         | 194 ++++++++++++++++++
>   .../bindings/pci/designware-pcie.txt          |  77 -------
>   .../bindings/pci/fsl,imx6q-pcie.txt           |   2 +-
>   .../bindings/pci/hisilicon-histb-pcie.txt     |   2 +-
>   .../bindings/pci/hisilicon-pcie.txt           |   2 +-
>   .../devicetree/bindings/pci/kirin-pcie.txt    |   2 +-
>   .../bindings/pci/layerscape-pci.txt           |   2 +-
>   .../bindings/pci/nvidia,tegra194-pcie.txt     |   4 +-
>   .../devicetree/bindings/pci/pci-armada8k.txt  |   2 +-
>   .../devicetree/bindings/pci/pci-keystone.txt  |  10 +-
>   .../devicetree/bindings/pci/pcie-al.txt       |   2 +-
>   .../devicetree/bindings/pci/qcom,pcie.txt     |  14 +-
>   .../bindings/pci/samsung,exynos5440-pcie.txt  |   4 +-
You must have used an old tree for preparing this patchset. The above 
file is gone in v5.11-rc1 and there is 
Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml instead.
>   .../pci/socionext,uniphier-pcie-ep.yaml       |   2 +-
>   .../devicetree/bindings/pci/ti-pci.txt        |   4 +-
>   .../devicetree/bindings/pci/uniphier-pcie.txt |   2 +-
>   MAINTAINERS                                   |   2 +-
>   19 files changed, 225 insertions(+), 108 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/pci/designware,pcie.yaml
>   delete mode 100644 Documentation/devicetree/bindings/pci/designware-pcie.txt
> ...

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

