Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE074139878
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2020 19:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgAMSOU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 13:14:20 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18561 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726435AbgAMSOU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jan 2020 13:14:20 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1cb3450003>; Mon, 13 Jan 2020 10:13:25 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 Jan 2020 10:14:19 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 Jan 2020 10:14:19 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jan
 2020 18:14:19 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 13 Jan 2020 18:14:18 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.48]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e1cb3760001>; Mon, 13 Jan 2020 10:14:18 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>
CC:     <kishon@ti.com>, <gustavo.pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V3 0/5] Add support for PCIe endpoint mode in Tegra194
Date:   Mon, 13 Jan 2020 23:44:06 +0530
Message-ID: <20200113181411.32743-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578939205; bh=ukCPDfBJa97Io32ATEdGsPQLo4kSyt3NvEM1waEU2A0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=JeN7eDjmvZEFDBfpvZ0RK/dOgo0664heFWC872xxJrwaHfr3M8qD+jIelKvMjm1hG
         sXkfRISI7h5pfcUFshGKYtJzPWN6Ccu+ig/B8zt/nBQ8WCUjatsEdL1uiL7pYXuO5Q
         LTjZpySBKIYK56GKKJH2NnnPc/kGIBDEGJ7OwLX8kCg71FLgBgELTWRk4Q/W6nyt4K
         r9i+zXUWn9EEhyZe8f/7B+ubPaSzTNAlpioof2NVW0UblEbwILre9IYQrERhufTvZa
         8Ugp7XYBOZB0PZHMGT5Jholn9NTAXD82cmO60ycnO1M2XtUsSjH/0oa3dr8JpyAYRG
         enf/kxX4BIFjg==
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

V3:
* Re-ordered patches in the series to make the driver change as the last patch
* Took care of Thierry's review comments

V2:
* Addressed Thierry & Bjorn's review comments
* Added EP mode specific binding documentation to already existing binding documentation file
* Removed patch that enables GPIO controller nodes explicitly as they are enabled already

Vidya Sagar (5):
  soc/tegra: bpmp: Update ABI header
  dt-bindings: PCI: tegra: Add DT support for PCIe EP nodes in Tegra194
  arm64: tegra: Add PCIe endpoint controllers nodes for Tegra194
  arm64: tegra: Add support for PCIe endpoint mode in P2972-0000
    platform
  PCI: tegra: Add support for PCIe endpoint mode in Tegra194

 .../bindings/pci/nvidia,tegra194-pcie.txt     | 125 ++-
 .../boot/dts/nvidia/tegra194-p2972-0000.dts   |  18 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  99 +++
 drivers/pci/controller/dwc/Kconfig            |  30 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    | 770 +++++++++++++++++-
 include/soc/tegra/bpmp-abi.h                  |  10 +-
 6 files changed, 1007 insertions(+), 45 deletions(-)

-- 
2.17.1

