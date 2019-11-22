Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC57107030
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2019 12:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbfKVKpP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Nov 2019 05:45:15 -0500
Received: from hqemgate15.nvidia.com ([216.228.121.64]:12042 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728963AbfKVKpO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Nov 2019 05:45:14 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5dd7bc350000>; Fri, 22 Nov 2019 02:45:09 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 22 Nov 2019 02:45:13 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 22 Nov 2019 02:45:13 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 Nov
 2019 10:45:13 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 22 Nov
 2019 10:45:12 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 22 Nov 2019 10:45:12 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.48]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5dd7bc340001>; Fri, 22 Nov 2019 02:45:12 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>
CC:     <kishon@ti.com>, <gustavo.pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH 0/6] Add support for PCIe endpoint mode in Tegra194
Date:   Fri, 22 Nov 2019 16:14:59 +0530
Message-ID: <20191122104505.8986-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1574419509; bh=vATyB0+qpRWIt2ybVc4KqLiFa7LEkPRGlbViOEQbviw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=KqQDAnmlYAl+sJswyU11Z4ld8H/PkEOizunUfmeq2krHgNHVIFw2ZffRQkM1Qq3gE
         rd6ibZCzjQLDwpiYVY8tNdiPvw4Ml5StGxLGXw0oGVScbC7N0IoVbbiEMLdBAiNRH2
         OZgUnAmh8imkitAomhGQkh7YqQeQlujCHxm6OdYAb7OUppy+k1brkmLJB1NphPBke1
         g06oQdCEdy/aOrxQTn39Yi/dwBP4uqkOZTmXmGptNI3RTyFqyxLTimSXpLjpq7RPZY
         7+8dAJ4s5cCun7COd99n0mEphqVZhOqJt45JAsbonDBQKOjCH75aNwC9i0z45Qc/kE
         OxaGzsow64WBQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tegra194 has three (C0, C4 & C5) dual mode PCIe controllers that can operate
either in root port mode or in end point mode but only in one mode at a time.
Platform P2972-0000 supports enabling endpoint mode for C5 controller. This
patch series adds support for PCIe endpoint mode in both the driver as well as
in DT.
This patch series depends on the changes made for Synopsys DesignWare endpoint
mode subsystem that are currently under review
@ https://patchwork.kernel.org/project/linux-pci/list/?series=202211
which in turn depends on the patch made by Kishon
@ https://patchwork.kernel.org/patch/10975123/
which is also under review.

Vidya Sagar (6):
  soc/tegra: bpmp: Update ABI header
  dt-bindings: PCI: tegra: Add DT support for PCIe EP nodes in Tegra194
  PCI: tegra: Add support for PCIe endpoint mode in Tegra194
  arm64: tegra: Add PCIe endpoint controllers nodes for Tegra194
  arm64: tegra: Enable GPIO controllers nodes for P2972-0000 platform
  arm64: tegra: Add support for PCIe endpoint mode in P2972-0000
    platform

 .../bindings/pci/nvidia,tegra194-pcie-ep.txt  | 138 ++++
 .../boot/dts/nvidia/tegra194-p2972-0000.dts   |  37 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  99 +++
 drivers/pci/controller/dwc/Kconfig            |  30 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    | 751 +++++++++++++++++-
 include/soc/tegra/bpmp-abi.h                  |  10 +-
 6 files changed, 1048 insertions(+), 17 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.txt

-- 
2.17.1

