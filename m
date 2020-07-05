Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C689C214B47
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jul 2020 11:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgGEJSR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 5 Jul 2020 05:18:17 -0400
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:46989 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726434AbgGEJSR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 5 Jul 2020 05:18:17 -0400
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 05 Jul 2020 02:18:16 -0700
Received: from sivaprak-linux.qualcomm.com ([10.201.3.202])
  by ironmsg03-sd.qualcomm.com with ESMTP; 05 Jul 2020 02:18:11 -0700
Received: by sivaprak-linux.qualcomm.com (Postfix, from userid 459349)
        id 40AE721355; Sun,  5 Jul 2020 14:48:09 +0530 (IST)
From:   Sivaprakash Murugesan <sivaprak@codeaurora.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org, bhelgaas@google.com,
        robh+dt@kernel.org, kishon@ti.com, vkoul@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, svarbanov@mm-sol.com,
        lorenzo.pieralisi@arm.com, p.zabel@pengutronix.de,
        sivaprak@codeaurora.org, mgautam@codeaurora.org,
        smuthayy@codeaurora.org, varada@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: [PATCH 0/9] Add PCIe support for IPQ8074
Date:   Sun,  5 Jul 2020 14:47:51 +0530
Message-Id: <1593940680-2363-1-git-send-email-sivaprak@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

IPQ8074 has two PCIe ports both are based on synopsis designware PCIe
controller. while it was assumed that PCIe support for IPQ8074 was already
available. PCIe was not functional until now.

This patch series adds support for PCIe ports on IPQ8074.

First PCIe port is of gen2 synposis version is 2_3_2 which has already been
enabled. But it had some problems on phy init and needed dt updates.

Second PCIe port is gen3 synopsis version is 2_9_0. This series adds
support for this PCIe port while fixing dt nodes.

Patch 1 on this series depends on qcom pcie bindings patch
https://lkml.org/lkml/2020/6/24/162

Sivaprakash Murugesan (9):
  dt-bindings: pci: Add ipq8074 gen3 pci compatible
  dt-bindings: phy: qcom,qmp: Add dt-binding for ipq8074 gen3 pcie phy
  clk: qcom: ipq8074: Add missing bindings for pcie
  clk: qcom: ipq8074: Add missing clocks for pcie
  phy: qcom-qmp: use correct values for ipq8074 gen2 pcie phy init
  phy: qcom-qmp: Add compatible for ipq8074 pcie gen3 qmp phy
  pci: dwc: qcom: do phy power on before pcie init
  pci: qcom: Add support for ipq8074 pci controller
  arm64: dts: ipq8074: Fixup pcie dts nodes

 .../devicetree/bindings/pci/qcom,pcie.yaml         |  47 ++++++
 .../devicetree/bindings/phy/qcom,qmp-phy.yaml      |   1 +
 arch/arm64/boot/dts/qcom/ipq8074-hk01.dts          |   8 +-
 arch/arm64/boot/dts/qcom/ipq8074.dtsi              | 109 ++++++++----
 drivers/clk/qcom/gcc-ipq8074.c                     |  60 +++++++
 drivers/pci/controller/dwc/pcie-qcom.c             | 187 +++++++++++++++++++-
 drivers/phy/qualcomm/phy-qcom-pcie3-qmp.h          | 132 +++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.c                | 188 ++++++++++++++++++++-
 drivers/phy/qualcomm/phy-qcom-qmp.h                |   2 +
 include/dt-bindings/clock/qcom,gcc-ipq8074.h       |   4 +
 10 files changed, 683 insertions(+), 55 deletions(-)
 create mode 100644 drivers/phy/qualcomm/phy-qcom-pcie3-qmp.h

-- 
2.7.4

