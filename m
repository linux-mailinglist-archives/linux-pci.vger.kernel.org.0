Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69463736F2
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 11:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232283AbhEEJTl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 May 2021 05:19:41 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:52449 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232184AbhEEJTl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 May 2021 05:19:41 -0400
Received: from tarshish.tkos.co.il (unknown [10.0.8.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id EC4B74407F0;
        Wed,  5 May 2021 12:18:35 +0300 (IDT)
From:   Baruch Siach <baruch@tkos.co.il>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Baruch Siach <baruch@tkos.co.il>,
        Selvam Sathappan Periakaruppan <speriaka@codeaurora.org>,
        Kathiravan T <kathirav@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Robert Marko <robert.marko@sartura.hr>,
        devicetree@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 0/6] arm64: IPQ6018 PCIe support
Date:   Wed,  5 May 2021 12:18:28 +0300
Message-Id: <cover.1620203062.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series adds support for the single PCIe lane on IPQ6018 SoCs. The code is 
ported from downstream Codeaurora v5.4 kernel. The main difference from 
downstream code is the split of PCIe registers configuration from .init to 
.post_init, since it requires phy_power_on().

Tested on IPQ6010 based hardware.

Changes in v2:

  * Add patch moving GEN3_RELATED macros to a common header

  * Drop ATU configuration from pcie-qcom

  * Remove local definition of common registers

  * Use bulk clk and reset APIs

  * Remove msi-parent from device-tree

Baruch Siach (3):
  PCI: dwc: tegra: move GEN3_RELATED DBI register to common header
  dt-bindings: phy: qcom,qmp: Add IPQ60xx PCIe PHY bindings
  dt-bindings: pci: qcom: Document PCIe bindings for IPQ6018 SoC

Selvam Sathappan Periakaruppan (3):
  PCI: qcom: add support for IPQ60xx PCIe controller
  phy: qcom-qmp: add QMP V2 PCIe PHY support for ipq60xx
  arm64: dts: ipq6018: Add pcie support

 .../devicetree/bindings/pci/qcom,pcie.txt     |  24 +++
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml |  25 +++
 arch/arm64/boot/dts/qcom/ipq6018.dtsi         |  99 ++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h  |   7 +
 drivers/pci/controller/dwc/pcie-qcom.c        | 150 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-tegra194.c    |   6 -
 drivers/phy/qualcomm/phy-qcom-qmp.c           | 147 +++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h           | 132 +++++++++++++++
 8 files changed, 584 insertions(+), 6 deletions(-)

-- 
2.30.2

