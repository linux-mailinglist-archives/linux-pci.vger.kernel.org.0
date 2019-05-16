Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29EA31FEE6
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2019 07:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbfEPFxQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 May 2019 01:53:16 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:19723 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbfEPFxP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 May 2019 01:53:15 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdcfaa10000>; Wed, 15 May 2019 22:52:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 15 May 2019 22:53:14 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 15 May 2019 22:53:14 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 16 May
 2019 05:53:14 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Thu, 16 May 2019 05:53:11 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V4 00/28] Enable Tegra PCIe root port features
Date:   Thu, 16 May 2019 11:22:39 +0530
Message-ID: <20190516055307.25737-1-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557985953; bh=hAuYDUXZ1q9af++JkNxJ4RQxWEZz+pn39ijht/uOncw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=iI4p71F+JiF6ogYKDvXX9ssTZibb40kjSplzG1fVms7JM0UynJFPbs5eM0SONosCX
         R28s4m2Hy0PL0ZP42kOfUuqgVYtM8QMgMO88Qd1RZTRjsNviRcgat9ikBFYPWsewrc
         fWWkSkUjdcwKogfo8CbGILB+97LrCYAcIHW+rQkM8mtIsMlYRoSwKQ7YsLkggaSVs3
         o1NPrFd+B0NuNIAY0MA11/gPZmGbVw+W+fzXcV4LJTPWISWPb19vN/upKNP2/L3UZj
         owZrJhgHmvcCkfPktgfQeQZzsVpoVOkKtUkhlf7daw7VPUcOuwEagL+WndNEYKbfk5
         YCC47BL+jNMCg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series of patches adds,
- Tegra root port features like Gen2, AER, etc
- Power and perf optimizations
- Fixes like "power up sequence", "dev_err prints", etc

This series of patches are tested on Tegra186 based Jetson-TX2, Tegra210
based Jetson-TX1, T124 based Jetson-TK1 platforms, Tegra20 and Tegra30
platforms.

Manikanta Maddireddy (28):
  soc/tegra: pmc: Export tegra_powergate_power_on()
  PCI: tegra: Handle failure cases in tegra_pcie_power_on()
  PCI: tegra: Rearrange Tegra PCIe driver functions
  PCI: tegra: Mask AFI_INTR in runtime suspend
  PCI: tegra: Fix PCIe host power up sequence
  PCI: tegra: Add PCIe Gen2 link speed support
  PCI: tegra: Advertise PCIe Advanced Error Reporting (AER) capability
  PCI: tegra: Program UPHY electrical settings for Tegra210
  PCI: tegra: Enable opportunistic UpdateFC and ACK
  PCI: tegra: Disable AFI dynamic clock gating
  PCI: tegra: Process pending DLL transactions before entering L1 or L2
  PCI: tegra: Enable PCIe xclk clock clamping
  PCI: tegra: Increase the deskew retry time
  PCI: tegra: Add SW fixup for RAW violations
  PCI: tegra: Update flow control timer frequency in Tegra210
  PCI: tegra: Set target speed as Gen1 before starting LTSSM
  PCI: tegra: Fix PLLE power down issue due to CLKREQ# signal
  PCI: tegra: Program AFI_CACHE* registers only for Tegra20
  PCI: tegra: Change PRSNT_SENSE IRQ log to debug
  PCI: tegra: Use legacy IRQ for port service drivers
  PCI: tegra: Add AFI_PEX2_CTRL reg offset as part of soc struct
  PCI: tegra: Access endpoint config only if PCIe link is up
  dt-bindings: pci: tegra: Document PCIe DPD pinctrl optional prop
  arm64: tegra: Add PEX DPD states as pinctrl properties
  PCI: tegra: Put PEX CLK & BIAS pads in DPD mode
  PCI: Add DT binding for "reset-gpios" property
  PCI: tegra: Add support for GPIO based PERST#
  PCI: tegra: Change link retry log level to debug

 .../bindings/pci/nvidia,tegra20-pcie.txt      |   8 +
 Documentation/devicetree/bindings/pci/pci.txt |   3 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  19 +
 drivers/pci/controller/pci-tegra.c            | 615 +++++++++++++++---
 drivers/soc/tegra/pmc.c                       |   1 +
 5 files changed, 566 insertions(+), 80 deletions(-)

-- 
2.17.1

