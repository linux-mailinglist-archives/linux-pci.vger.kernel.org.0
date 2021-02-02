Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8919B30BFB2
	for <lists+linux-pci@lfdr.de>; Tue,  2 Feb 2021 14:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhBBNjW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Feb 2021 08:39:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:59606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229514AbhBBNba (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Feb 2021 08:31:30 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2EEB764F7B;
        Tue,  2 Feb 2021 13:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612272602;
        bh=9D7RURM2JxS7qUzT8CayBMlStaKkCkiMbZwsrnGaQCo=;
        h=From:To:Cc:Subject:Date:From;
        b=PQrTP3tIhNzqa5zVo1AOWI+wPETJ61DSKiKgzA+vs38unwkC9i8KDCyYpbZZV/frV
         cwJwhQQMHfHYykVeyG9iJubrGxWtaC2i8hKOzt8ObJQpOvwOn+9lyRJlySo3F27aaX
         3vlBIPzGd4G9PWZ0ltVOdnqe7ZqCE9mT0c9Wp+H1ICKHr1GorqhQGx32rLwtIdGu6c
         GpAC7ACnL3RXPhW0a249qRiUW6HxV6MMUg1cZ0SSnJiP8ZhZ8O7+HXzzZjccvwluiJ
         qyd83TUVFGqP80Qx8Cc5jx2RzaL0ixBbCSKMuXJVIrMx6rZhELjCqA8tuDimOlgYNz
         QdBU3BiiPeYMA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l6vkl-0011yl-Bo; Tue, 02 Feb 2021 14:29:59 +0100
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
        Wei Xu <xuwei5@hisilicon.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        devicetree@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@axis.com, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH 00/13] Add support for Hikey 970 PCIe
Date:   Tue,  2 Feb 2021 14:29:45 +0100
Message-Id: <cover.1612271903.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series add support for Kirin 970 and for the Hikey 970
board at the already-existing  driver.

patches 1-3 were previously submitted as RFC:

- Patch 1 converts the Synopsys Designware PCIe binding
  documentation to the DT schema;
- Patch 2 converts the pcie-kirin DT binding to the DT schema;
- Patch 3 adds some extra configuration needed by
  Kirin 970.

Patches 4-5 were imported from Manivannan's Hikey 970
tree:

   https://git.linaro.org/people/manivannan.sadhasivam/96b-common.git/commit/?h=hikey970_pcie&id=4917380ad023c62960aa0f876bd4f23cefc8729e

It contains the original port made by Linaro.

patches 6 to 12 contains several cleanups applied on the
top of Manivann's work, in order to simplify the extra data
that would be required at DT, and to ensure that the power
regulator needed to enable the PCI support on Hikey970
will be enabled before trying to power it on, as otherwise,
PCI resource allocation will fail.

-

patch 13 is here mostly as an example about what is needed
in order for PCIe (and Ethernet) to start working on Hikey 970.

It won't apply cleanly, as it depends on another patch series,
adding the needed regulator drivers.

I'll re-submit patch 13 after the pending stuff gets merged
upstream.

Manivannan Sadhasivam (2):
  pci: dwc: pcie-kirin: add HI3670 PCI-E controller support
  arm64: dts: hisilicon: Add HI3670 PCI-E controller support

Mauro Carvalho Chehab (11):
  doc: bindings: pci: designware-pcie.txt: convert it to yaml
  doc: bindings: kirin-pcie.txt: convert it to yaml
  doc: bindings: add new parameters used by Hikey 970
  pci: dwc: pcie-kirin: simplify error handling logic
  pci: dwc: pcie-kirin: simplify kirin 970 get resource logic
  pci: dwc: pcie-kirin: place common init code altogether
  pci: dwc: pcie-kirin: allow to optionally require a regulator
  pci: dwc: pcie-kirin: allow using multiple reset GPIOs
  pci: dwc: pcie-kirin: add support for clkreq GPIOs
  pci: dwc: pcie-kirin: cleanup kirin970_pcie_get_eyeparam()
  arm64: dts: hisilicon: cleanup Hikey 970 PCI schema

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
 arch/arm64/boot/dts/hisilicon/hi3670.dtsi     |  64 ++
 .../boot/dts/hisilicon/hikey970-pmic.dtsi     |   1 -
 drivers/pci/controller/dwc/pcie-kirin.c       | 736 +++++++++++++++++-
 23 files changed, 1084 insertions(+), 187 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/designware-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/hisilicon,kirin-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/kirin-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/snps,pcie.yaml

-- 
2.29.2


