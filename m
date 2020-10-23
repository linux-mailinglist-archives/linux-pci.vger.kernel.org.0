Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68FB3296AC3
	for <lists+linux-pci@lfdr.de>; Fri, 23 Oct 2020 09:58:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S376066AbgJWH6b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Oct 2020 03:58:31 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:46475 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S376060AbgJWH6a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Oct 2020 03:58:30 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201023075809euoutp020aef4b70006bf7df5d79248e4d453a4c~AkBV_52u61643216432euoutp02t
        for <linux-pci@vger.kernel.org>; Fri, 23 Oct 2020 07:58:09 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201023075809euoutp020aef4b70006bf7df5d79248e4d453a4c~AkBV_52u61643216432euoutp02t
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603439889;
        bh=evdQ0JQ4MgQjq/lEzt1kYGqztUWWSPa+L3GuDGy0H7g=;
        h=From:To:Cc:Subject:Date:References:From;
        b=Vu/6choJNiDawUt84IqxEbRHhpeWz7NOv6cklSfyyguCoWpZcYQ4IDOI7G84f+Pkx
         V4h0KWKZmd1EJvMeCt4h8MuYbxNErMbBw7gsfIpQ3cNKG4Holr8wULDyvOHqgz47j1
         eNa5wKwd5YmWX5VqElKxT9KLZal3TReY4kpTc25M=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20201023075754eucas1p1458e61f374553c33b1225fb6309a075d~AkBIO_S321157111571eucas1p1D;
        Fri, 23 Oct 2020 07:57:54 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id B0.06.06318.20D829F5; Fri, 23
        Oct 2020 08:57:54 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201023075754eucas1p2ee617893ba13493236814235c619bc56~AkBHyK_8q1362913629eucas1p2b;
        Fri, 23 Oct 2020 07:57:54 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201023075754eusmtrp2ec6d97691a18777cab7006a42135eaf8~AkBHxX4Bo2144121441eusmtrp2q;
        Fri, 23 Oct 2020 07:57:54 +0000 (GMT)
X-AuditID: cbfec7f5-38bff700000018ae-ab-5f928d02dc78
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D0.27.06017.10D829F5; Fri, 23
        Oct 2020 08:57:54 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201023075753eusmtip1655b18a053bc79db9c19ac32186fe871~AkBHMEfKA2168021680eusmtip1N;
        Fri, 23 Oct 2020 07:57:53 +0000 (GMT)
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
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v2 0/6] Add DW PCIe support for Exynos5433 SoCs
Date:   Fri, 23 Oct 2020 09:57:38 +0200
Message-Id: <20201023075744.26200-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSWUwTURTN67QzA7EwFJQXJBCbWJdEkKBm3FGJzgdR+BMjS5UJENnsUATi
        B4HIMoKsKhCChICU0gIpDUqFArWxNNhFSZAQiOEDlyr+FJQigrSD+Hfuuefcc+/LwxFRvSAI
        T8/KpWVZ0gwx6s0ffOOyHuFV1SUd/dYQSnYUp5HPjFYBObNWKiAVy00YaV+sREmbrR8jp3Qt
        KGlpNaFko03PI7///oKRauM8Rj4YMWLk0NwEEiWkVK0qQA01z2NUm0ZOaZQVKPVIqwSUaeYF
        j3JqQmKxG95nUuiM9DxaFn4u2TvtieIzyBn2yzfUJxYBjQ8LvHBIHIOjHXbMjUWEAsBS9hIL
        vLfwMoAtb/UCrnACaGNX+SzAPQ5dRTzHdwHYVLaJ7DhqVdM89yiUiIDsEou6DQFEFFxdId0a
        hGhHYFG1Ebg1/sR5uNb7zKPnE/thicbs4YXEWaj+M83n1guFPf1jngBIVGOwQbeOco1oWPuh
        C+GwP3SYtBiHg+HmkHuo21AC4IJVjXFFJYBTxY2AU52Gc9Y1z3oIcQj26cI5+gLceF61faYP
        nFnyc9PIFqwbfIpwtBCWl4o4tQQ2m3p3Ysft77fXoeC0o5vPPWkCnOj8xasBIc3/s9oAUIJA
        Ws5kptJMZBZ9L4yRZjLyrNSw29mZGrD1VSY3TCsvgX79lgEQOBDvEibX1CaJBNI8piDTACCO
        iAOEFy2TiSJhirSgkJZlJ8nkGTRjAHtxvjhQGNn+NUFEpEpz6Ts0nUPL/nV5uFdQEdj9wyUZ
        TXB+AmUbK/vEm3Eqxv76+oa8cCy+93j5eAzE1J2+wyMLB5ytk9oBX3uf1aKHBx3RwaLw/GHL
        5EP1K4n5iiEo38UueiVqu3++OzkbfbXHPOWYO3FKeDMuPrbxfozy8vJYaAxPsafkY2ulS2me
        bprVDkge371G+W2SYj6TJo04jMgY6V+EAoUvJgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsVy+t/xu7pMvZPiDeaGWixpyrCYf+Qcq8WN
        X22sFiu+zGS3uPC0h83i/PkN7BaXd81hszg77zibxYzz+5gs3vx+wW6x9shddovWvUfYLXbe
        OcHswOuxZt4aRo+ds+6yeyzYVOqxaVUnm0ffllWMHsdvbGfy+LxJLoA9Ss+mKL+0JFUhI7+4
        xFYp2tDCSM/Q0kLPyMRSz9DYPNbKyFRJ384mJTUnsyy1SN8uQS9j2ornjAV7BCsOTY5rYNzE
        18XIwSEhYCKxqzOyi5GLQ0hgKaPEl3sT2boYOYHiMhInpzWwQtjCEn+udbFBFH1ilNj0aAU7
        SIJNwFCi620XWIOIgJPE+8kXmUGKmAXWMEs0tnUzgSSEBewlfq2bD2azCKhKNG86yQhi8wrY
        Sqz9e40FYoO8xOoNB5gnMPIsYGRYxSiSWlqcm55bbKRXnJhbXJqXrpecn7uJERjM24793LKD
        setd8CFGAQ5GJR7ehAkT44VYE8uKK3MPMUpwMCuJ8DqdPR0nxJuSWFmVWpQfX1Sak1p8iNEU
        aPlEZinR5HxgpOWVxBuaGppbWBqaG5sbm1koifN2CByMERJITyxJzU5NLUgtgulj4uCUamBk
        WXm58YiDsFHZtC62Z0LKfy92+YZKLFMNXdlb+n+LcvK/B685m14m7TH5Npl3z4acvcnPd3z5
        qBPtk6RyQeqJ+KyNpqUyIt9d854UyvHNjfKTsG493Ge2SLSsj5VpjTlvSs/yG6ySuvO/PdjY
        x7m+wifArbYy9/9l5rUXPvfE3Io/pRW20U+JpTgj0VCLuag4EQCJ/uJPfAIAAA==
X-CMS-MailID: 20201023075754eucas1p2ee617893ba13493236814235c619bc56
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201023075754eucas1p2ee617893ba13493236814235c619bc56
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201023075754eucas1p2ee617893ba13493236814235c619bc56
References: <CGME20201023075754eucas1p2ee617893ba13493236814235c619bc56@eucas1p2.samsung.com>
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

Best regards,
Marek Szyprowski

v2:
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

 .../bindings/pci/samsung,exynos-pcie.yaml     | 114 ++++++
 .../bindings/pci/samsung,exynos5440-pcie.txt  |  58 ---
 .../bindings/phy/samsung,exynos-pcie-phy.yaml |  51 +++
 .../boot/dts/exynos/exynos5433-pinctrl.dtsi   |   2 +-
 .../dts/exynos/exynos5433-tm2-common.dtsi     |  24 +-
 arch/arm64/boot/dts/exynos/exynos5433.dtsi    |  35 ++
 drivers/pci/controller/dwc/Kconfig            |   3 +-
 drivers/pci/controller/dwc/pci-exynos.c       | 358 +++++++-----------
 drivers/pci/quirks.c                          |   1 +
 drivers/phy/samsung/phy-exynos-pcie.c         | 304 ++++++---------
 10 files changed, 481 insertions(+), 469 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml

-- 
2.17.1

