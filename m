Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D7430D3B7
	for <lists+linux-pci@lfdr.de>; Wed,  3 Feb 2021 08:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231522AbhBCHDt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Feb 2021 02:03:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:35528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232023AbhBCHD0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Feb 2021 02:03:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A6FAB64F69;
        Wed,  3 Feb 2021 07:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612335720;
        bh=H8e8UvRVRIeJRBMFLtr0H3UUm6rcx/88jqoabLKu+dk=;
        h=From:To:Cc:Subject:Date:From;
        b=aS9UcuGjtxyieyW+HARPPO1G4YNg5vmzsvSepSa3s2Cbv+6GEGc2iRzlg7UEhPdb1
         4LYDPyafbn/BEe/OhxzSqAZ7XfVWhQS9SwYyN2kDspIKm5Gryk/1k6maAfOhS5D4+2
         B26dshHhKf+1VYMSqO3kU4Hf6U9aRXTE2BmGxB/nimAAYxb2uTlaE/1dW0DJ/MwnzY
         yYJUckv8WIuBX0nYKvh81NRSvrDBD+w8fduDxVbuvhzVuHVORa+eVV1vHeqLuBf086
         urFLbMPclo4U354gRiGNlLc7vaui3rVC74Offis3Bttg9MKIQ4lmHYNV9H0Ym44l+b
         2N0uIemGk5rEg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l7CAn-001CAO-UU; Wed, 03 Feb 2021 08:01:57 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jaehoon Chung <jh80.chung@samsung.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Mark Brown <broonie@kernel.org>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 00/11] Add support for Hikey 970 PCIe
Date:   Wed,  3 Feb 2021 08:01:44 +0100
Message-Id: <cover.1612335031.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series add PCIe support for Kirin 970 SoC.

Patch 1 converts the Synopsys DesignWare PCIe binding documentation to
the DT schema;

Patch 2 converts the pcie-kirin DT binding to the DT schema;

Patch 3 adds some extra configuration needed to support Kirin 970.

Patch 4 were imported from Manivannan's HiKey 970 96boards tree:

   https://git.linaro.org/people/manivannan.sadhasivam/96b-common.git/commit/?h=hikey970_pcie&id=4917380ad023c62960aa0f876bd4f23cefc8729e

It contains the original port made by Linaro.

The remaining patches contain several cleanups applied on the top of
Manivann's work.

They cleanup the code and change it to use the DT bindings defined on
patch 3.

---

v2:
- DTS bindings dropped, as they depend on other DTS changes that will be
   happening at staging and ARM trees;
- Use regulator_get() for Kirin 970, instead of regulator_get_optional();
- The power supply was renamed to "pcie_vdd", in order to better match the
  schematics;
- The patch descriptions were renamed in order to match the terms used
  by other PCI patches;
- dts patches removed from this series, as they depend on other patches
  being merged via other trees.

Manivannan Sadhasivam (1):
  PCI: dwc: pcie-kirin: add support for Kirin 970 PCIe controller

Mauro Carvalho Chehab (10):
  doc: bindings: PCI: designware-pcie.txt: convert it to YAML
  doc: bindings: kirin-pcie.txt: convert it to YAML
  doc: bindings: add new parameters used by Kirin 970
  PCI: dwc: pcie-kirin: simplify error handling logic
  PCI: dwc: pcie-kirin: simplify Kirin 970 get resource logic
  PCI: dwc: pcie-kirin: place common init code altogether
  PCI: dwc: pcie-kirin: add support for a regulator
  PCI: dwc: pcie-kirin: allow using multiple reset GPIOs
  PCI: dwc: pcie-kirin: add support for clkreq GPIOs
  pci: dwc: pcie-kirin: cleanup kirin970_pcie_get_eyeparam()

 .../bindings/pci/amlogic,meson-pcie.txt       |   4 +-
 .../bindings/pci/axis,artpec6-pcie.txt        |   2 +-
 .../bindings/pci/designware-pcie.txt          |  77 --
 .../bindings/pci/fsl,imx6q-pcie.txt           |   2 +-
 .../bindings/pci/hisilicon,kirin-pcie.yaml    | 144 ++++
 .../bindings/pci/hisilicon-histb-pcie.txt     |   2 +-
 .../bindings/pci/hisilicon-pcie.txt           |   2 +-
 .../devicetree/bindings/pci/kirin-pcie.txt    |  50 --
 .../bindings/pci/layerscape-pci.txt           |   2 +-
 .../bindings/pci/nvidia,tegra194-pcie.txt     |   4 +-
 .../devicetree/bindings/pci/pci-armada8k.txt  |   2 +-
 .../devicetree/bindings/pci/pci-keystone.txt  |  10 +-
 .../devicetree/bindings/pci/pcie-al.txt       |   2 +-
 .../devicetree/bindings/pci/qcom,pcie.txt     |  14 +-
 .../bindings/pci/samsung,exynos-pcie.yaml     |   2 +-
 .../devicetree/bindings/pci/snps,pcie.yaml    | 139 ++++
 .../pci/socionext,uniphier-pcie-ep.yaml       |   2 +-
 .../devicetree/bindings/pci/ti-pci.txt        |   4 +-
 .../devicetree/bindings/pci/uniphier-pcie.txt |   2 +-
 MAINTAINERS                                   |   4 +-
 drivers/pci/controller/dwc/pcie-kirin.c       | 749 +++++++++++++++++-
 21 files changed, 1033 insertions(+), 186 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/designware-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/kirin-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/snps,pcie.yaml

-- 
2.29.2


