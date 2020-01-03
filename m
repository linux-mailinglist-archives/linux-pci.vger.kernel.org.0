Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7356F12F859
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2020 13:44:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbgACMoN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jan 2020 07:44:13 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:18120 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727494AbgACMoN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Jan 2020 07:44:13 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e0f370d0000>; Fri, 03 Jan 2020 04:43:57 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 03 Jan 2020 04:44:12 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 03 Jan 2020 04:44:12 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 3 Jan
 2020 12:44:12 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 3 Jan 2020 12:44:12 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.48]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e0f37180001>; Fri, 03 Jan 2020 04:44:11 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>
CC:     <kishon@ti.com>, <gustavo.pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V2 0/5] Add support for PCIe endpoint mode in Tegra194
Date:   Fri, 3 Jan 2020 18:13:59 +0530
Message-ID: <20200103124404.20662-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578055437; bh=av4maRAzw0Y30U4hvGLMR0lUrFrmERz6SpyIVwF8MaU=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=kOnlSzPmwzAb6pUqs88wdbOW2ZUWJV4ffBY0mTwnSRoFzNfI92gDKcMp0aGCFFESp
         +ijP5z3Zo2uIew/Z9CzVcqe1X+PbgCNhk7E79XQmb14L9ftLnySjW08XIxEZQJExGw
         B09zwgUHj6fxtAbmgqRK8lS4baD3z88Uu3bUuZJdBfyScXIdDgG5FB+8kFVBItEam/
         hpk9//f8C0+5sQytRKzY2IBEhVfho0VLJZDH93Le7Un8TyDgftAlq6UYebmtPfwaBU
         nk84UsVsW783Lmv11vSjGg1RWmVkZeOSrLMdAfT6OzxUdqDfaTsN1XJ+bTO3hTBNGG
         VRlPMhnw5xbgw==
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

V2:
* Addressed Thierry & Bjorn's review comments
* Added EP mode specific binding documentation to already existing binding documentation file
* Removed patch that enables GPIO controller nodes explicitly as they are enabled already

Vidya Sagar (5):
  soc/tegra: bpmp: Update ABI header
  dt-bindings: PCI: tegra: Add DT support for PCIe EP nodes in Tegra194
  PCI: tegra: Add support for PCIe endpoint mode in Tegra194
  arm64: tegra: Add PCIe endpoint controllers nodes for Tegra194
  arm64: tegra: Add support for PCIe endpoint mode in P2972-0000
    platform

 .../bindings/pci/nvidia,tegra194-pcie.txt     | 125 ++-
 .../boot/dts/nvidia/tegra194-p2972-0000.dts   |  18 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  99 +++
 drivers/pci/controller/dwc/Kconfig            |  30 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    | 782 +++++++++++++++++-
 include/soc/tegra/bpmp-abi.h                  |  10 +-
 6 files changed, 1021 insertions(+), 43 deletions(-)

-- 
2.17.1

