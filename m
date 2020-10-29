Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF93629ED79
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 14:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727697AbgJ2NsF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 09:48:05 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39906 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727360AbgJ2NsF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 09:48:05 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201029134040euoutp02e21d6a422e1ff49010fb9f28b851485c~CekHxmRKX1391413914euoutp024
        for <linux-pci@vger.kernel.org>; Thu, 29 Oct 2020 13:40:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201029134040euoutp02e21d6a422e1ff49010fb9f28b851485c~CekHxmRKX1391413914euoutp024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603978840;
        bh=aQOgeMqZjgVuAGRhabboSv5zRKv3BlW8YnKQUQEQqCo=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ohjDspkTqglgzj7Bfi40qAQiAiL+7T3nm6ZmyMrLwmLumtDlmBjj0gXhR+brLvM5e
         XvQH76ZuPteqJUj8J9Qffn/eonF+FuVmpaN8dhHtTd0OsomPtN/5aRqB0hseBysnDO
         K2iYRhnwyczGL+As0IR1m1VamP056Nqt0VrPREzM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201029134037eucas1p2a73cb2b7ce9d2b9944fd56f713123750~CekEoyReu0911309113eucas1p2U;
        Thu, 29 Oct 2020 13:40:37 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C7.99.05997.556CA9F5; Thu, 29
        Oct 2020 13:40:37 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20201029134037eucas1p17f861adc0858e8a80d516dc0f2733f84~CekEQsVyI2139321393eucas1p17;
        Thu, 29 Oct 2020 13:40:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20201029134037eusmtrp1329729a1817a5cbc53314e48c9416181~CekEOXEsz1072510725eusmtrp1a;
        Thu, 29 Oct 2020 13:40:37 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-32-5f9ac6559b99
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 1A.91.06017.556CA9F5; Thu, 29
        Oct 2020 13:40:37 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201029134036eusmtip1fe990fbcf4b5c607465e60a4ff159a51~CekDqpT-q1565515655eusmtip1t;
        Thu, 29 Oct 2020 13:40:36 +0000 (GMT)
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
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 0/6] Add DW PCIe support for Exynos5433 SoCs
Date:   Thu, 29 Oct 2020 14:40:11 +0100
Message-Id: <20201029134017.27400-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKKsWRmVeSWpSXmKPExsWy7djPc7qhx2bFGxy8I2expCnDYv6Rc6wW
        N361sVqs+DKT3eLC0x42i/PnN7BbXN41h83i7LzjbBYzzu9jsnjz+wW7xdojd9kt/u/ZwW6x
        884JZgdejzXz1jB67Jx1l91jwaZSj02rOtk8+rasYvQ4fmM7k8fnTXIB7FFcNimpOZllqUX6
        dglcGXNvvWYvuCxWse3aEeYGxvdCXYycHBICJhK3P/1h7GLk4hASWMEo8fXCDijnC6PEhEu9
        zBDOZ0aJjfN+scK0rD1+jA0isZxR4teviexwLW1HprODVLEJGEp0ve0CquLgEBFwkPjx1QKk
        hllgPrPExHu3mUDiwgL2EoevFICUswioSnyfeIYZxOYVsJW4+ecsM8QyeYnVGw6AXSEh0M8u
        cfjNHkaIhIvExPWvoS4Slnh1fAs7hC0jcXpyDwtEQzOjxMNza9khnB5GictNM6C6rSXunPsF
        dh2zgKbE+l36EGFHie3vzoMdJyHAJ3HjrSBImBnInLRtOjNEmFeiow0admoSs46vg1t78MIl
        qJs9JD6ePQAWFxKIlfj86hjzBEa5WQi7FjAyrmIUTy0tzk1PLTbKSy3XK07MLS7NS9dLzs/d
        xAhMLKf/Hf+yg3HXn6RDjAIcjEo8vBduz4wXYk0sK67MPcQowcGsJMLrdPZ0nBBvSmJlVWpR
        fnxRaU5q8SFGaQ4WJXFe40UvY4UE0hNLUrNTUwtSi2CyTBycUg2M0Uv+peXVp+9U78patnl7
        Wx1jeEPYu9OiC52UL+jyXm+8K9nNmKL4R4qp+7VvDustr1dFau9fNwmsO/ojV0WnrY3hekTH
        vF3Cq79JM17jP8ehpOMQKabGHqdiLcXdtbDa92X4zA08cob7rgYGSpg+OTZJLnYXy57nOTl7
        fZ3PtZza4+AgKqvEUpyRaKjFXFScCACu9ymdKAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFLMWRmVeSWpSXmKPExsVy+t/xu7qhx2bFGxxfxGqxpCnDYv6Rc6wW
        N361sVqs+DKT3eLC0x42i/PnN7BbXN41h83i7LzjbBYzzu9jsnjz+wW7xdojd9kt/u/ZwW6x
        884JZgdejzXz1jB67Jx1l91jwaZSj02rOtk8+rasYvQ4fmM7k8fnTXIB7FF6NkX5pSWpChn5
        xSW2StGGFkZ6hpYWekYmlnqGxuaxVkamSvp2NimpOZllqUX6dgl6GXNvvWYvuCxWse3aEeYG
        xvdCXYycHBICJhJrjx9j62Lk4hASWMoocW3/ByaIhIzEyWkNrBC2sMSfa11QRZ8YJe4tWMsG
        kmATMJToetsFZosIOEm8n3yRGcRmFljJLHFwW14XIweHsIC9xOErBSBhFgFVie8Tz4CV8ArY
        Stz8c5YZYr68xOoNB5gnMPIsYGRYxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERjO24793LKD
        setd8CFGAQ5GJR7eC7dnxguxJpYVV+YeYpTgYFYS4XU6ezpOiDclsbIqtSg/vqg0J7X4EKMp
        0PKJzFKiyfnAWMsriTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cC4
        8bl50/0VjvVpb3TD3l6uZDM6edTihhCbzYPM39prVcU9vDMZHJ8oMnxOOXhmzp6YZyp3P5z5
        kXbKV5Kp/ZZnVF8Q9+Of+5YuWXO+k2t9z8a9OTfL17L8O+dtFmcjsFz53aXpcz7MelWryLJH
        XiH1qvaV88+SQ7s6FrztFX1pdriQv+3o72/TlViKMxINtZiLihMBrCByX30CAAA=
X-CMS-MailID: 20201029134037eucas1p17f861adc0858e8a80d516dc0f2733f84
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201029134037eucas1p17f861adc0858e8a80d516dc0f2733f84
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201029134037eucas1p17f861adc0858e8a80d516dc0f2733f84
References: <CGME20201029134037eucas1p17f861adc0858e8a80d516dc0f2733f84@eucas1p1.samsung.com>
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

This patchset is based on the following branch:
git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git pci-more-dwc-cleanup

Best regards,
Marek Szyprowski


Changelog:

v3:
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

Jaehoon Chung (3):
  phy: samsung: phy-exynos-pcie: rework driver to support Exynos5433
    PCIe PHY
  pci: dwc: pci-exynos: rework the driver to support Exynos5433 variant
  arm64: dts: exynos: add the WiFi/PCIe support to TM2(e) boards

Marek Szyprowski (3):
  dt-bindings: pci: drop samsung,exynos5440-pcie binding
  dt-bindings: pci: add the samsung,exynos-pcie binding
  dt-bindings: phy: add the samsung,exynos-pcie-phy binding

 .../bindings/pci/samsung,exynos-pcie.yaml     | 119 ++++++
 .../bindings/pci/samsung,exynos5440-pcie.txt  |  58 ---
 .../bindings/phy/samsung,exynos-pcie-phy.yaml |  51 +++
 .../boot/dts/exynos/exynos5433-pinctrl.dtsi   |   2 +-
 .../dts/exynos/exynos5433-tm2-common.dtsi     |  24 +-
 arch/arm64/boot/dts/exynos/exynos5433.dtsi    |  36 ++
 drivers/pci/controller/dwc/Kconfig            |  10 +-
 drivers/pci/controller/dwc/pci-exynos.c       | 353 +++++++-----------
 drivers/pci/quirks.c                          |   1 +
 drivers/phy/samsung/phy-exynos-pcie.c         | 304 ++++++---------
 10 files changed, 489 insertions(+), 469 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml

-- 
2.17.1

