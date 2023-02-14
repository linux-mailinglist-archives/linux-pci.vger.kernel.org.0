Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1996965E8
	for <lists+linux-pci@lfdr.de>; Tue, 14 Feb 2023 15:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbjBNOHK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Feb 2023 09:07:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjBNOG5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Feb 2023 09:06:57 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 265D229174
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 06:06:27 -0800 (PST)
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230214140623epoutp0462d88e07eb557b9ccc8e73de94305095~DtfymOFf52242422424epoutp04B
        for <linux-pci@vger.kernel.org>; Tue, 14 Feb 2023 14:06:23 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230214140623epoutp0462d88e07eb557b9ccc8e73de94305095~DtfymOFf52242422424epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676383583;
        bh=SdNM4Tz3fLK6Ln86MZGGxK52Puw9N/dkEq+z+0rNYYs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=rVpQ4dCyVQpQ1VGxOQ2VRgfvyfdjz/aMTYhbFv6XEHClKh0tVOFPEagnQASzkXQlN
         CooupJPKCAtkeq1pRAQntceFH2J/7pMyyB/Pofzq+lmkaXKXyIiWeahodfvguEbeR5
         BZ3SqJ+TP94pzBDMEU0Qwf7iY02eEKbnnnp9cg+c=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20230214140622epcas5p4f151af96adc5d416d4f57d74b9082c83~DtfyAKCzc3228232282epcas5p4B;
        Tue, 14 Feb 2023 14:06:22 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.182]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4PGNKn1xpWz4x9Pp; Tue, 14 Feb
        2023 14:06:21 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        39.EF.55678.D559BE36; Tue, 14 Feb 2023 23:06:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20230214121348epcas5p48a3b2b225f616d748cc20622d01edb97~Dr9gG5u4l0767707677epcas5p4b;
        Tue, 14 Feb 2023 12:13:48 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230214121348epsmtrp2dc813dcaf173070dfd350293e1cd2916~Dr9gF-WY01865118651epsmtrp2J;
        Tue, 14 Feb 2023 12:13:48 +0000 (GMT)
X-AuditID: b6c32a4a-909fc7000000d97e-d3-63eb955d2f17
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        2A.EA.17995.CFA7BE36; Tue, 14 Feb 2023 21:13:48 +0900 (KST)
Received: from cheetah.sa.corp.samsungelectronics.net (unknown
        [107.109.115.53]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230214121345epsmtip126bd4d57eb7bd902e5958cb92e11db8d~Dr9dRniJT2436024360epsmtip1d;
        Tue, 14 Feb 2023 12:13:45 +0000 (GMT)
From:   Shradha Todi <shradha.t@samsung.com>
To:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        alim.akhtar@samsung.com, jingoohan1@gmail.com,
        Sergey.Semin@baikalelectronics.ru, lukas.bulwahn@gmail.com,
        hongxing.zhu@nxp.com, tglx@linutronix.de, m.szyprowski@samsung.com,
        jh80.chung@samsung.co, pankaj.dubey@samsung.com
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shradha Todi <shradha.t@samsung.com>
Subject: [PATCH 00/16] Refactor Exynos PCIe driver to make it generic
Date:   Tue, 14 Feb 2023 17:43:17 +0530
Message-Id: <20230214121333.1837-1-shradha.t@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEJsWRmVeSWpSXmKPExsWy7bCmpm7s1NfJBsdesFk8mLeNzWJJU4bF
        /CPnWC1mbZvLaPHx9zkWixVfZrJb9L14yGzR0POb1WLT42usFpd3zWGzODvvOJvFjPP7mCxa
        /rSwWLQcbWexWHvkLrvFoq1f2C3+79nBbvFn+gcWi97DtRabN01ldhDxeLPpO7vHzll32T0W
        bCr12LSqk83jzrU9bB7vzp1j93hyZTqTx+Yl9R4b3+1g8ljU8JHNo2/LKkaPz5vkAniism0y
        UhNTUosUUvOS81My89JtlbyD453jTc0MDHUNLS3MlRTyEnNTbZVcfAJ03TJzgN5UUihLzCkF
        CgUkFhcr6dvZFOWXlqQqZOQXl9gqpRak5BSYFOgVJ+YWl+al6+WlllgZGhgYmQIVJmRndJ5d
        xVwwib/i1+aiBsY2ni5GTg4JAROJLfNuMnYxcnEICexmlOjfOZcdwvnEKLH983RWCOczo8Ty
        b6uZYFrmNn+BSuxilJi//AlUfyuTxK6j65lBqtgEtCQav3YxgyREBG4xSbz8/BBsMLPAKUaJ
        Ay/2AjkcHMICrhL7lueDNLAIqEp8uLQELMwrYClxcjnUgfISqzccAJsjIbCHQ2Jhwy9mkBoJ
        AReJpf8DIWqEJV4d38IOYUtJfH63lw3CTpdYuXkGM4SdI/Ft8xKoD+wlDlyZwwIyhllAU2L9
        Ln2IsKzE1FPrwEqYBfgken8/gSrnldgxD8ZWlvjydw8LhC0pMe/YZVYI20Pi8/QjYHEhgViJ
        prY3rBMYZWchbFjAyLiKUTK1oDg3PbXYtMAoL7UcHk/J+bmbGMGJV8trB+PDBx/0DjEycTAe
        YpTgYFYS4RV++iJZiDclsbIqtSg/vqg0J7X4EKMpMMQmMkuJJucDU39eSbyhiaWBiZmZmYml
        sZmhkjivuu3JZCGB9MSS1OzU1ILUIpg+Jg5OqQYmsae6CtzxKaohLKlCn441qXB4Wb/9Mtcq
        fe8D2dvS2kvmLM77fl987l+lnKnO2w3ZpWOWbFmw8qMal13smmvib7fPVQ6Mmbm/qkSc5bfj
        qSnz+05lNbBIaE/4/9ig+lZ3/W4XrV1bzzreZnE7xi12YWPl1BlNPP/MKu86rjv5I9JOInpi
        9W7/Ds/D6pKCfGzP7zGez/gg9++HxfPcSV+be9I2Zk79p9kjZn1SdN2LdoElFR+C4kqfa0rI
        P5+T8ran6FdW0ZLnOsoTLd1OFKzNXxd3Paioa9p7j4k9pYJ7GxLn+E7O/DgvrzZRLSiQzfju
        AXd98xBXx4XKmz2Y0069Dp0VVG15Zs6jppeF/IZKLMUZiYZazEXFiQBuU2XPRQQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHLMWRmVeSWpSXmKPExsWy7bCSnO6fqtfJBlMbZC0ezNvGZrGkKcNi
        /pFzrBazts1ltPj4+xyLxYovM9kt+l48ZLZo6PnNarHp8TVWi8u75rBZnJ13nM1ixvl9TBYt
        f1pYLFqOtrNYrD1yl91i0dYv7Bb/9+xgt/gz/QOLRe/hWovNm6YyO4h4vNn0nd1j56y77B4L
        NpV6bFrVyeZx59oeNo93586xezy5Mp3JY/OSeo+N73YweSxq+Mjm0bdlFaPH501yATxRXDYp
        qTmZZalF+nYJXBmdZ1cxF0zir/i1uaiBsY2ni5GTQ0LARGJu8xfWLkYuDiGBHYwSS5f9ZINI
        SEp8vriOCcIWllj57zk7RFEzk8THJ5fBEmwCWhKNX7uYQRIiAq+YJA7vmQHmMAtcYJS4dbAb
        qIWDQ1jAVWLf8nyQBhYBVYkPl5aAhXkFLCVOLoe6Ql5i9YYDzBMYeRYwMqxilEwtKM5Nzy02
        LDDKSy3XK07MLS7NS9dLzs/dxAiOAi2tHYx7Vn3QO8TIxMF4iFGCg1lJhFf46YtkId6UxMqq
        1KL8+KLSnNTiQ4zSHCxK4rwXuk7GCwmkJ5akZqemFqQWwWSZODilGphKfniZiR5PSOo8k5og
        Pffni6+TDpqrHjnh4CUif/1+0IQq2c19230EZLwuf+hduUb94ZuK3UvPLNqnrTPv9ouz+fm2
        D/YrLhb4PPeE6r3zEyvnfFf0tPlXs8jnW7+sr+BuvUtL9eRbP/md7G/dM8F7aY+Zr/z0hV9u
        Xvt77/+CSZXyPSKt6lzrGV+fZq2WtTjdfubo2hM+r1dYv/P18ey6dzgt+GqqnpLHo+RHx5/P
        UL6X/TLwsLpP3i3228E61+9Hp2UqzU+c7LXgzYXmWyXKJ5yLmzprpb/v2FokJH5ndYZFbq+1
        99+dUh/EN/29JcyVJ/hAuD0g4ZTVv1/SLnlXEvMfvzimmH3br/fuI/WzSizFGYmGWsxFxYkA
        kfOhw/ECAAA=
X-CMS-MailID: 20230214121348epcas5p48a3b2b225f616d748cc20622d01edb97
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230214121348epcas5p48a3b2b225f616d748cc20622d01edb97
References: <CGME20230214121348epcas5p48a3b2b225f616d748cc20622d01edb97@epcas5p4.samsung.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently pci-exynos is being used as a PCIe driver for Exynos5433
only. This patch set refactors the driver to make it extensible to
other Samsung manufactured SoCs having DWC PCIe controllers.
The major change points are:
- Renaming all common functions/structures to use "samsung" instead
  of "exynos". Make common probe/remove/suspend/resume
- Making clock/regulator get/enable/disable generic
- Adding private struct to hold platform specific function ops

Shradha Todi (16):
  dt-bindings: PCI: Rename Exynos PCIe binding to Samsung PCIe
  PCI: exynos: Rename Exynos PCIe driver to Samsung PCIe
  PCI: samsung: Change macro names to exynos specific
  PCI: samsung: Use clock bulk API to get clocks
  dt-bindings: PCI: Rename the term elbi to appl
  arm64: dts: exynos: Rename the term elbi to appl
  PCI: samsung: Rename the term elbi to appl
  PCI: samsung: Rename exynos_pcie to samsung_pcie
  PCI: samsung: Make common appl readl/writel functions
  dt-bindings: PCI: Add phy-names as required property
  arm64: dts: exynos: Add phy-names as DT property
  PCI: samsung: Get PHY using non-DT version
  PCI: samsung: Rename common functions to samsung
  PCI: samsung: Add platform device private data
  PCI: samsung: Add structure to hold resource operations
  PCI: samsung: Make handling of regulators generic

 ...ung,exynos-pcie.yaml => samsung,pcie.yaml} |  15 +-
 MAINTAINERS                                   |   4 +-
 arch/arm64/boot/dts/exynos/exynos5433.dtsi    |   3 +-
 drivers/pci/controller/dwc/Kconfig            |   6 +-
 drivers/pci/controller/dwc/Makefile           |   2 +-
 drivers/pci/controller/dwc/pci-samsung.c      | 508 ++++++++++++++++++
 6 files changed, 526 insertions(+), 12 deletions(-)
 rename Documentation/devicetree/bindings/pci/{samsung,exynos-pcie.yaml => samsung,pcie.yaml} (89%)
 create mode 100644 drivers/pci/controller/dwc/pci-samsung.c

-- 
2.17.1

