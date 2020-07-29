Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 977762321A2
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jul 2020 17:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgG2Pbe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 11:31:34 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:10005 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726365AbgG2PbG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jul 2020 11:31:06 -0400
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 29 Jul 2020 08:31:04 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg02-sd.qualcomm.com with ESMTP; 29 Jul 2020 08:30:56 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id A89C42114B; Wed, 29 Jul 2020 21:00:54 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        svarbanov@mm-sol.com, lorenzo.pieralisi@arm.com,
        p.zabel@pengutronix.de, sivaprak@codeaurora.org,
        mgautam@codeaurora.org, smuthayy@codeaurora.org,
        varada@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 0/7] Add PCIe support for IPQ8074
Date:   Wed, 29 Jul 2020 21:00:00 +0530
Message-Id: <1596036607-11877-1-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

IPQ8074 has two PCIe ports both are based on synopsis designware PCIe
controller. while it was assumed that PCIe support for IPQ8074 was already
available, it was not functional until now.

This patch series adds support for PCIe ports on IPQ8074.

First PCIe port is of Gen2 synposis version is 2_3_2 which has already been
enabled. But it had some problems on phy init and needed dt updates.

Second PCIe port is Gen3 synopsis version is 2_9_0. This series adds
support for this PCIe port while fixing dt nodes.

Patch 1 on this series depends on qcom PCIe bindings patch
https://lkml.org/lkml/2020/6/24/162

[V2]
 * Fixed commit headers and messages to have PCIe and Gen[2-3]
 * Addressed Vinod's review comments on phy init
 * Patches are rebased on linux-next to resolve dependencies with recent
   PCI patches
 * Patch 1 depends on https://lkml.org/lkml/2020/7/28/1462
 * Dropped clock patches as it has picked up by Stephen

Sivaprakash Murugesan (7):
  dt-bindings: PCI: qcom: Add ipq8074 Gen3 PCIe compatible
  dt-bindings: phy: qcom,qmp: Add ipq8074 PCIe Gen3 phy
  phy: qcom-qmp: Use correct values for ipq8074 PCIe Gen2 PHY init
  phy: qcom-qmp: Add compatible for ipq8074 PCIe Gen3 qmp phy
  PCI: qcom: Do PHY power on before PCIe init
  PCI: qcom: Add ipq8074 PCIe controller support
  arm64: dts: ipq8074: Fixup PCIe dts nodes

 .../devicetree/bindings/pci/qcom,pcie.yaml         |  47 +++++
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      |   1 +
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts          |   8 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              | 109 ++++++++----
 drivers/pci/controller/dwc/pcie-qcom.c             | 189 ++++++++++++++++++++-
 drivers/phy/qualcomm/phy-qcom-pcie3-qmp.h          | 139 +++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 187 +++++++++++++++++++-
 drivers/phy/qualcomm/phy-qcom-qmp.h                |   2 +
 8 files changed, 627 insertions(+), 55 deletions(-)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-pcie3-qmp.h

-- 
2.7.4

