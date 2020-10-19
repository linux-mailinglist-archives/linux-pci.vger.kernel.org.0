Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEFA72924E8
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 11:48:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgJSJsO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 05:48:14 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36229 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgJSJsO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Oct 2020 05:48:14 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20201019094746euoutp0235720fed13a1bb998c8859ec30e88bff~-W76XQsZk2477524775euoutp02O
        for <linux-pci@vger.kernel.org>; Mon, 19 Oct 2020 09:47:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20201019094746euoutp0235720fed13a1bb998c8859ec30e88bff~-W76XQsZk2477524775euoutp02O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1603100866;
        bh=FqxW9f1+LuYbBwoXpPUvT/85NwXSuEJLmmuYl/MBjdE=;
        h=From:To:Cc:Subject:Date:References:From;
        b=aD+OWPvGL4cNwCcD98957LOBUwdcCOHssuJnmS+TkGGajwzxH9rdzWiVgW05J89lz
         z5jlQ77JxNG/d247dJz2O3NKIaKDvMnhATiY/3M7HvRvnEQr0iYC9Jve1B2OrJ0KIN
         4cTGk4Ew2MKgk5UzehKh3GACygnab8xJA755licQ=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20201019094738eucas1p23cbddf92d23c54680e309a7b79345deb~-W7ymcuKb1210912109eucas1p2o;
        Mon, 19 Oct 2020 09:47:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id E6.F2.05997.AB06D8F5; Mon, 19
        Oct 2020 10:47:38 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20201019094737eucas1p283ea94186450c0756442624d95de627f~-W7yQgHmN0748607486eucas1p2w;
        Mon, 19 Oct 2020 09:47:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20201019094737eusmtrp20ee391f9e5011271d49307a44635220b~-W7yPf7fh2596225962eusmtrp2w;
        Mon, 19 Oct 2020 09:47:37 +0000 (GMT)
X-AuditID: cbfec7f4-677ff7000000176d-43-5f8d60ba7de2
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id D8.CB.06017.9B06D8F5; Mon, 19
        Oct 2020 10:47:37 +0100 (BST)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20201019094737eusmtip1050f48de2edf96d119dcc997d9e28bdf~-W7xsOZdg1561015610eusmtip1f;
        Mon, 19 Oct 2020 09:47:37 +0000 (GMT)
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
Subject: [PATCH 0/6] Add DW PCIe support for Exynos5433 SoCs
Date:   Mon, 19 Oct 2020 11:47:09 +0200
Message-Id: <20201019094715.15343-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSa0hTYRju29m5ODxynIIfFgYDjQLdrIhDWlj04xAR/Qghw+Zsp03apm3O
        0h81XElOTRvLdIm3LHVq2RIvk8xsOVG2mQo6VCoq0co/XsJMMreT9u+5vM/3vC98BCIsRyOJ
        DE02q9XIVCJMwO8c/OWNdaSVSCW+MZRuyFfSNU4PSk+tF6B000olTo9+LcZor7cdp8cdVRjt
        rnZhdIW3j0f/+D2P023OWZy+88qJ0z0zQ0gSybRWtwKmxzqLM7V2PWO3FWLMvQ4bYFxTXTxm
        2R51Dk8RJMpZVUYOqxUfTxMoS7sbsKzb1I2liS+oAVhIEwgiIHUY9tu6eCYgIIRUE4DGugWU
        IysATk/YEY4sA2ixe8B2pKTPDDijEcBi9zC2E7nvfcvzT2FUPDQtmrYMgginkuDaKu2fQah6
        BBpKnYGXwqhEOO218P2YT0XD+dlNxI9J6hisGC1Cuba9sKW9P7AGpEpx+H7Yw+OMU7Csbo7P
        4TD4zdWBc3gP3Oyp4XEBI4CfPG04R4oBHM+v+HdEApzxrAfWQ6j98LlDzMknYMuHRdQvQyoE
        Ti2G+mVkC5o7HyKcTMK7BUJuOgZaXc92at+MjiEcZmDLy++B1YRUKmxwlaBlIMr6v6sWABuI
        YPU6tYLVHdSw1+N0MrVOr1HEXc5U28HWbxn541rpBo6N9AFAEUAUTH7MLJYKUVmOLlc9ACCB
        iMLJk+6RS0JSLsvNY7WZUq1exeoGwG6CL4ogD9UvpAophSybvcqyWax22+URQZEGUPnYV/FA
        NE/ajBcmmzVnr72LIZPjzbXKi62ezZBcxmxU+jZ2pYuHkJ+gJ6H7qd1c9Lrqc5BEUihUZpe/
        uCnuaMx70j1sCFEdPRO65DtvnZ6bDE67Ul56ZDz5tLG5T2HvSolG3Pv0arnU0uuObZOnDD7a
        38sXSFbF0bfW3KiIr1PK4g8gWp3sL8Vq8X4pAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDLMWRmVeSWpSXmKPExsVy+t/xu7o7E3rjDTYc1bVY0pRhMf/IOVaL
        G7/aWC1WfJnJbnHhaQ+bxfnzG9gtLu+aw2Zxdt5xNosZ5/cxWbz5/YLdYu2Ru+wWrXuPsFvs
        vHOC2YHXY828NYweO2fdZfdYsKnUY9OqTjaPvi2rGD2O39jO5PF5k1wAe5SeTVF+aUmqQkZ+
        cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpqTmZZapG+XYJeRv+OJWwFLQIVn648YW1g
        nMLbxcjJISFgItG7bxJjFyMXh5DAUkaJ9smfmSESMhInpzWwQtjCEn+udbFBFH1ilNjwYzE7
        SIJNwFCi6y1IgpNDRMBJ4v3ki8wgRcwCa5glGtu6mUASwgI2ErfPT2EBsVkEVCVe3P0PtoFX
        wFZixoVuqA3yEqs3HGCewMizgJFhFaNIamlxbnpusZFecWJucWleul5yfu4mRmBIbzv2c8sO
        xq53wYcYBTgYlXh4H+T3xAuxJpYVV+YeYpTgYFYS4XU6ezpOiDclsbIqtSg/vqg0J7X4EKMp
        0PKJzFKiyfnAeMsriTc0NTS3sDQ0NzY3NrNQEuftEDgYIySQnliSmp2aWpBaBNPHxMEp1cBo
        EHs0hMtkSlwA+2kXj/2v5lxjeWy89dez1SsFt9msUDmQam9azJ7xSryaKTHoiM3dF4m+tZEf
        nQ3vS77I+bpx25667Sc2nf5xTO114RkF54D3tqwb3l5fE3Lpdd/x/6/LPXzmHp+hyT0vrFXX
        2lF/d+yjjUvuJqimdcuWOO5ev+GhhVOfp1+JEktxRqKhFnNRcSIAzuluZH8CAAA=
X-CMS-MailID: 20201019094737eucas1p283ea94186450c0756442624d95de627f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20201019094737eucas1p283ea94186450c0756442624d95de627f
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20201019094737eucas1p283ea94186450c0756442624d95de627f
References: <CGME20201019094737eucas1p283ea94186450c0756442624d95de627f@eucas1p2.samsung.com>
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


Patch summary:

Jaehoon Chung (5):
  Documetation: dt-bindings: add the samsung,exynos-pcie binding
  Documetation: dt-bindings: add the samsung,exynos-pcie-phy binding
  phy: samsung: phy-exynos-pcie: rework driver to support Exynos5433
    PCIe PHY
  pci: dwc: pci-exynos: rework the driver to support Exynos5433 variant
  arm64: dts: exynos: add the WiFi/PCIe support to TM2(e) boards

Marek Szyprowski (1):
  Documetation: dt-bindings: drop samsung,exynos5440-pcie binding

 .../bindings/pci/samsung,exynos-pcie.yaml     | 104 ++++++
 .../bindings/pci/samsung,exynos5440-pcie.txt  |  58 ---
 .../bindings/phy/samsung,exynos-pcie-phy.yaml |  51 +++
 .../boot/dts/exynos/exynos5433-pinctrl.dtsi   |   2 +-
 .../dts/exynos/exynos5433-tm2-common.dtsi     |  24 +-
 arch/arm64/boot/dts/exynos/exynos5433.dtsi    |  36 ++
 drivers/pci/controller/dwc/Kconfig            |   3 +-
 drivers/pci/controller/dwc/pci-exynos.c       | 358 +++++++-----------
 drivers/pci/quirks.c                          |   1 +
 drivers/phy/samsung/phy-exynos-pcie.c         | 304 ++++++---------
 10 files changed, 472 insertions(+), 469 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/samsung,exynos5440-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/phy/samsung,exynos-pcie-phy.yaml

-- 
2.17.1

