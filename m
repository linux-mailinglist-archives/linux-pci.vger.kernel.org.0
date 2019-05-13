Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 60A231BC9E
	for <lists+linux-pci@lfdr.de>; Mon, 13 May 2019 20:08:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731476AbfEMSIC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 May 2019 14:08:02 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:3078 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731142AbfEMSIB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 May 2019 14:08:01 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd9b2590000>; Mon, 13 May 2019 11:07:21 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 May 2019 11:08:00 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 May 2019 11:08:00 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 May
 2019 18:08:00 +0000
Received: from manikanta-bm2.nvidia.com (172.20.13.39) by HQMAIL.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server id 15.0.1473.3 via Frontend
 Transport; Mon, 13 May 2019 18:07:57 +0000
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <thierry.reding@gmail.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <jonathanh@nvidia.com>, <lorenzo.pieralisi@arm.com>,
        <vidyas@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH V3 00/29] Enable Tegra PCIe root port features
Date:   Mon, 13 May 2019 23:37:15 +0530
Message-ID: <20190513180744.16493-1-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557770841; bh=kzU1LL7iCVd+b5FKU78RYsffNCyngCHVcWSrqGp30Po=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=VAOQTGUYT3EYHhVlnmNWM/60y44g2be2a42aLHbeNDmn45hBHL4hX4NYrIq//m82H
         1CGKyL7Y0zGJy/dgwwbEg9McHP0hLKeJIPoWXayiHDBV0Qu5MALCl411VGLfUSQYKv
         Qt9dZ6qGvbsS1Eve9MCjnCIOIo68LceWn9loaut8dFmw+a51kglEkthGctgEcSsaR9
         sovus+T+RH32ztDQ4ZEoMJ1NcI7JsCf1y2n6Qte4+SeK2ZjW/KHDS0ysxkfCBgJp3S
         xUF087e3uJfbKv1DZ5hxz2Zut19ZZ+vnEbNXaS0/L8jyktJkuWaJURdzBDDWJ/6k/M
         VyLTCDitytJ5Q==
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

Manikanta Maddireddy (29):
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
  PCI: OF: Add of_pci_get_reset_gpio() to parse reset-gpios from DT
  PCI: tegra: Add support for GPIO based PERST#
  PCI: tegra: Change link retry log level to debug

 .../bindings/pci/nvidia,tegra20-pcie.txt      |   8 +
 Documentation/devicetree/bindings/pci/pci.txt |   3 +
 arch/arm64/boot/dts/nvidia/tegra210.dtsi      |  19 +
 drivers/pci/controller/pci-tegra.c            | 616 +++++++++++++++---
 drivers/pci/of.c                              |  18 +
 drivers/soc/tegra/pmc.c                       |   1 +
 include/linux/of_pci.h                        |  10 +
 7 files changed, 595 insertions(+), 80 deletions(-)

-- 
2.17.1

