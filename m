Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89EF02B2155
	for <lists+linux-pci@lfdr.de>; Fri, 13 Nov 2020 18:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgKMRCV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Nov 2020 12:02:21 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36246 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726322AbgKMRCV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Nov 2020 12:02:21 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201113170202euoutp0222c1c076e8e3f778ed65a506fbfe7042~HH-NQ8nV10472304723euoutp02u
        for <linux-pci@vger.kernel.org>; Fri, 13 Nov 2020 17:02:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201113170202euoutp0222c1c076e8e3f778ed65a506fbfe7042~HH-NQ8nV10472304723euoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1605286922;
        bh=tJSkvdYtBXglEeNJBvB0Afa8OYWPBVISoDw/r2AmPvg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=BQ2bPUgH9ohPlS3PqHkQ/6Vv3lzNgc1ON1GQPqRUXIbjzicGe22pqgBEuHEuk9BzH
         1pfXQnIpDKz52RkObsiXtfG2qSSGKKGzAIjW2IK6jlEuvgkEt0Kjx9bXeBG4B9d/Gx
         ko6uHhIvLaoPdCV/6G3l+vFeqOqPPhRtw0s3WNwM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201113170156eucas1p1ef5fc88bbb40f4889f328f569b3a4ef1~HH-IYlR-A2485424854eucas1p1M;
        Fri, 13 Nov 2020 17:01:56 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id EA.9F.45488.40CBEAF5; Fri, 13
        Nov 2020 17:01:56 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201113170156eucas1p176314e4076c593d1f2e68159be880f86~HH-H_gmLu2493824938eucas1p19;
        Fri, 13 Nov 2020 17:01:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201113170156eusmtrp10b17ba170efe432b8373f2784fc48248~HH-H9pfx81302013020eusmtrp1i;
        Fri, 13 Nov 2020 17:01:56 +0000 (GMT)
X-AuditID: cbfec7f5-c5fff7000000b1b0-d6-5faebc047ad2
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 7C.71.21957.40CBEAF5; Fri, 13
        Nov 2020 17:01:56 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20201113170155eusmtip241ef88e172e807823aa4926cf9f31cf0~HH-HSwGx51944119441eusmtip2a;
        Fri, 13 Nov 2020 17:01:55 +0000 (GMT)
From:   Marek Szyprowski <m.szyprowski@samsung.com>
To:     linux-samsung-soc@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v4 0/5] Add DW PCIe support for Exynos5433 SoCs
Date:   Fri, 13 Nov 2020 18:01:34 +0100
Message-Id: <20201113170139.29956-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSf0yMcRze996fquN1mb5IEfktxObrR5SRd8NkM1YkR68yXbV7C5nldmg6
        pylTV3La8uNc16lTUUvO7eZUc12EmJz+SEnOkrNC6Hr9+O95vs/zfJ7njy+NSc4Rk+mDyWmc
        PFmaFER64TUPh+wL8Xpj3OJ3XQtRpeYWga4qE9EVq51A7d+yCKT7UkghR5eaRC0tFRR6WldM
        osdaG4k0LQ0i1Pe9h0Ll1g4K/aq/S6Ha14+w8LGsQWsAbG1RB8WWmNJZkz6bZHOq9IC1td8R
        sQOmgCgqxmt1PJd08DAnX7Rmr1diWc5pKrXH76gz+x6hAIO+KjCGhswyqP91HlcBL1rC6AAs
        7mgjBfIFQOP3VkogAwBeeZyL/Y10Kt6LBOEGgHZnH/Ev8nY4j/K4SGYJVH1Ujdyi6QlMOBx0
        I48HY15gsPHaJZHH48ushaWFLuDBOBMMzZ3a0QYxEwaH3Vl/2gJhWYUZ84QhY6bh555uQhDW
        wyyHTiRgX9hrq6IE7A+bL6hxIXASwE57OSUQNYBPlRoguFbB1/Zvo/MwZi68VbfIAyETASsa
        AgU4FrZ/HO8xYyMwr6YAE57F8EyWRLgxCxbZjP9aHzie/JnMwjfW1tGVEiYWftB8Is+DgKL/
        VSUA6IEfl87LEjh+aTJ3JISXyvj05ISQ/SkyExj5Mc0/be67QNfbH2IBIhpYAKSxoAniGeGG
        OIk4XppxjJOnxMnTkzjeAqbQeJCfuK56RGISpGncIY5L5eR/VRE9ZrJCpNjj7OJ7h2bOamum
        3ZczXQnz9/JF+UsLM08c8N9hTIks6UNtjmhnRIzTIvPeFsMEG9eF5mfXKpUZqR375CBPf6dp
        pbcs9l5grP+pVrjRNTgQiv3o3uqyqw8om8J3E71TywxJt5/NL910X705c3fJirDZVy/3p82J
        kOqIDHJ22ZPGYHOAX2TO8ohd/CrZzdLcqiZ2sXXBuhUXJ73SRpmffSp49FXLdB+XbWAV2w3x
        3nZ9GznFJ0Czr1Vbv8Vdfda1ySfquXfuDFV+aHnLzuroGPw2Ndz4vMbt0zOtyjrkCAxDX02W
        hnH4hkjsOjjJTQ/VureKK3wq7Z0T+f6X04NwPlG6ZB4m56W/Af4t9fKgAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrILMWRmVeSWpSXmKPExsVy+t/xe7ose9bFG1zpErDYOGM9q8WSpgyL
        +UfOsVrc+NXGarHiy0x2iwtPe9gszp/fwG5xedccNouz846zWcw4v4/J4s3vF+wWa4/cZbf4
        v2cHu8XOOyeYHfg81sxbw+ixc9Zddo8Fm0o9Nq3qZPPo27KK0eP4je1MHp83yQWwR+nZFOWX
        lqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlrO5rZS94IV5x
        v3MvawPjD+EuRk4OCQETiYcNL5lAbCGBpYwS0+6wQcRlJE5Oa2CFsIUl/lzrAopzANV8YpSY
        ogwSZhMwlOh62wVWLiLgJPF+8kXmLkYuDmaBh8wSE+YcBOsVFrCXWDzzHSOIzSKgKnHg4Txm
        EJtXwFbi79c2Zoj58hKrNxxgnsDIs4CRYRWjSGppcW56brGhXnFibnFpXrpecn7uJkZgWG87
        9nPzDsZ5rz7qHWJk4mA8xCjBwawkwqvssCZeiDclsbIqtSg/vqg0J7X4EKMp0L6JzFKiyfnA
        yMoriTc0MzA1NDGzNDC1NDNWEufdOheoSSA9sSQ1OzW1ILUIpo+Jg1OqgWnOXzm23Rd2aZuF
        rnylZSWi1fFq7V0RlbfdUnt670UvUVq0fHLZpnqfLSaLU2IezirjFw9l8Xr8q5u9vih3SXXA
        S53PX7lXXo9euNp1h7LCDf7VE1KEToZLnel0Syp8lDWhcVNzS7mrvoNf2yWzC5yqK+vn33in
        9eiys9/1PQlLlGOu3JxaO+vi9Mjnk1yDpl3WfyFdkFDHcya7xfu04eyOq3ve1c94sfmaYcLz
        X3xHMu3z3+tcdVC/spIj9Tlf/9WQsESla3pJB70tplRsOO3HMbHD9opX6otdCdvKz/XMaY66
        Ey617UaTxn+jvh/L1rqFnw5/oOmXnHoh7Hj6Co7XIqdMXnzeVzDD+iyXoosSS3FGoqEWc1Fx
        IgBGvI3U9AIAAA==
X-CMS-MailID: 20201113170156eucas1p176314e4076c593d1f2e68159be880f86
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201113170156eucas1p176314e4076c593d1f2e68159be880f86
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201113170156eucas1p176314e4076c593d1f2e68159be880f86
References: <CGME20201113170156eucas1p176314e4076c593d1f2e68159be880f86@eucas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Dear All,

This patchset is a resurrection of the DW PCIe support for the Exynos5433
SoCs posted long time ago here: https://lkml.org/lkml/2016/12/26/6 and
later here: https://lkml.org/lkml/2017/12/21/296 .

In meantime the support for the Exynos5440 SoCs has been completely
dropped from mainline kernel, as those SoCs never reached the market. The
PCIe driver for Exynos5440 variant however has not been removed yet. This
patchset simply reworks it to support the Exynos5433 variant. The lack of
the need to support both variants significantly simplifies the driver
code.

This patchset is based on the commit b90c53b06597 ("PCI: dwc: Detect
number of iATU windows") available on the following branch:
git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git pci-more-dwc-cleanup

Best regards,
Marek Szyprowski


Changelog:

v4:
- fixed topics to better match the common style of the each subsystem
- rebased onto "[PATCH v2 00/16] PCI: dwc: Another round of clean-ups"
- collected tags, dropped merged dts patch

v3: https://lore.kernel.org/linux-samsung-soc/20201029134017.27400-1-m.szyprowski@samsung.com/
- rebased onto "[00/13] PCI: dwc: Another round of clean-ups" patchset:
  https://patchwork.kernel.org/project/linux-samsung-soc/cover/20201028204646.356535-1-robh@kernel.org/
- fixed issues pointed by Rob in the driver logic:
  * removed DBI_RO_WR_EN register poking
  * made driver a standard module
- fixed section mismatch issue
- added "num-viewport = <3>" property to dts and bindings to fix warning

v2: https://lore.kernel.org/linux-samsung-soc/20201023075744.26200-1-m.szyprowski@samsung.com/
- fixed issues in dt-bindings pointed by Krzysztof and Rob

v1: https://lore.kernel.org/linux-samsung-soc/20201019094715.15343-1-m.szyprowski@samsung.com/
- initial version of this resurrected patchset


Patch summary:

Jaehoon Chung (2):
  phy: samsung: phy-exynos-pcie: rework driver to support Exynos5433
    PCIe PHY
  PCI: dwc: exynos: Rework the driver to support Exynos5433 variant

Marek Szyprowski (3):
  dt-bindings: PCI: exynos: drop samsung,exynos5440-pcie binding
  dt-bindings: PCI: exynos: add the samsung,exynos-pcie binding
  dt-bindings: phy: exynos: add the samsung,exynos-pcie-phy binding

 .../bindings/pci/samsung,exynos-pcie.yaml     | 119 ++++++
 .../bindings/pci/samsung,exynos5440-pcie.txt  |  58 ---
 .../bindings/phy/samsung,exynos-pcie-phy.yaml |  51 +++
 drivers/pci/controller/dwc/Kconfig            |  10 +-
 drivers/pci/controller/dwc/pci-exynos.c       | 353 +++++++-----------
 drivers/pci/quirks.c                          |   1 +
 drivers/phy/samsung/phy-exynos-pcie.c         | 304 ++++++---------
 7 files changed, 429 insertions(+), 467 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml

-- 
2.17.1

