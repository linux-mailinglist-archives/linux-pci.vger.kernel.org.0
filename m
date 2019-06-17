Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 86BA748A52
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 19:40:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfFQRkA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 13:40:00 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11855 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfFQRkA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 13:40:00 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d07d06f0000>; Mon, 17 Jun 2019 10:39:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 17 Jun 2019 10:39:59 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 17 Jun 2019 10:39:59 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 17 Jun
 2019 17:39:59 +0000
Received: from manikanta-bm2.nvidia.com (10.124.1.5) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 17 Jun 2019 17:39:56 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V5 00/27] Enable Tegra PCIe root port features
Date:   Mon, 17 Jun 2019 23:09:25 +0530
Message-ID: <20190617173952.29363-1-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1560793199; bh=AFwexSjyhhn7GVD5rx+PHy1hmiAibOJXCELueKHRenQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=hYOk7/u4si46nz0U/crFDgAcKTrACcWGUVANNC+3TvpWfUhu8Z2AKYRvjJOEXRFxS
         MaGNaT9zZk2ZJFFY9/gmq39q2QPdYaDnc4q6zKWmjlqJJP1ckm8e02brRd/EexxhpM
         3jYkRcTYC4/4gvp2Fj0Q/cliN+DlEWhztPnhqRvCs4JVrnKYT4MbljPnvM5JIlrMDt
         wCFeOu00VFmwQ14hlzengisorloBCJVwVAfDVzsy8AmdKntIUwsdlqmPcrsSofW1I9
         pVyGXURLiXE26JIDzK7THYDDbgOsJBsSXtJhMow65Cs36Nx3oIPk9t8OMYIULrbBGp
         06GMTc118MsFA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This series of patches adds,
- Tegra root port features like Gen2, AER, etc
- Power and perf optimizations
- Fixes like "power up sequence", "dev_err prints", etc

This series of patches are tested on Tegra186 based Jetson-TX2, Tegra210
based Jetson-TX1, T124 based Jetson-TK1, Tegra20 and Tegra30 platforms.

Changes from v4 to v5:
 - Patch [V4, 4/28]: Added blank line before block style comment
 - Patch [V4, 22/28]: "Access endpoint config only if PCIe link is up"
patch is dropped
 - Patch [V4, 27/28]:
* Updated reset gpio toggle logic to reflect active low usage
* Replaced kasprintf() with devm_kasprintf()
* Updated commit message with more information.

Changes from v3 to v4:
 - Patch [V3,27/29] is dropped
 - Patch [V3,28/29]: devm_gpiod_get_from_of_node() is directly used in
   pci-tegra driver instead of of_get_pci* wrapper function defined in
   Patch [V3,27/29].

Manikanta Maddireddy (27):
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
  dt-bindings: pci: tegra: Document PCIe DPD pinctrl optional prop
  arm64: tegra: Add PEX DPD states as pinctrl properties
  PCI: tegra: Put PEX CLK & BIAS pads in DPD mode
  PCI: Add DT binding for "reset-gpios" property
  PCI: tegra: Add support for GPIO based PERST#
  PCI: tegra: Change link retry log level to debug

 .../bindings/pci/nvidia,tegra20-pcie.txt      |   8 +
 Documentation/devicetree/bindings/pci/pci.txt |   3 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  19 +
 drivers/pci/controller/pci-tegra.c            | 582 +++++++++++++++---
 drivers/soc/tegra/pmc.c                       |   1 +
 5 files changed, 533 insertions(+), 80 deletions(-)

-- 
2.17.1

