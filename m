Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B2AF177488
	for <lists+linux-pci@lfdr.de>; Tue,  3 Mar 2020 11:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728002AbgCCKy1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Mar 2020 05:54:27 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:1693 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727993AbgCCKy1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Mar 2020 05:54:27 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e5e37540000>; Tue, 03 Mar 2020 02:54:12 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 03 Mar 2020 02:54:25 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 03 Mar 2020 02:54:25 -0800
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 3 Mar
 2020 10:54:25 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 3 Mar 2020 10:54:25 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e5e375d0000>; Tue, 03 Mar 2020 02:54:25 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <andrew.murray@arm.com>
CC:     <kishon@ti.com>, <gustavo.pimentel@synopsys.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V4 0/5] Add support for PCIe endpoint mode in Tegra194
Date:   Tue, 3 Mar 2020 16:24:13 +0530
Message-ID: <20200303105418.2840-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1583232852; bh=8y0YHGhTk/Y1j2gYfLsrymHH+lWs6ZRXty08vP08rJw=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=K/md86bq4V+G5yRo+ilbLOZqMgP6P10y9qmE3bs6pjQGn4S+ihUuh5l2M8QTZ0q4D
         7fxmLnd2AzpvQD5RhW8LRSi25/6lAjJBvgK5QtPQA1UvHVB6S2GITBXTv8cndmd5bw
         ZygMyHQ1fcga4ji5/d+s3nMYYs+ULTtCIKkqomH7B5aMKkZ19qMmcusw3H+UP0wGlo
         KFPo35RpQka/eXzSbHLPCqSbqwd0qWZDJzQ/KIdmcM1ax3+WEg5ap1oo74vnX0kl7f
         a/dSzIK7mqxwMLis7wlYllubDVciHOjLmFP6J6xYrtXM7Bhg3zipz+R7dZhKNy2jfa
         kEL/slX4ZwObQ==
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
mode subsystem that are recently accepted.
@ https://patchwork.kernel.org/project/linux-pci/list/?series=202211
which in turn depends on the patch made by Kishon
@ https://patchwork.kernel.org/patch/10975123/
which is also under review.

V4:
* Started using threaded irqs instead of kthreads

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

 .../bindings/pci/nvidia,tegra194-pcie.txt     | 125 +++-
 .../boot/dts/nvidia/tegra194-p2972-0000.dts   |  18 +
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      |  99 +++
 drivers/pci/controller/dwc/Kconfig            |  30 +-
 drivers/pci/controller/dwc/pcie-tegra194.c    | 681 +++++++++++++++++-
 include/soc/tegra/bpmp-abi.h                  |  10 +-
 6 files changed, 918 insertions(+), 45 deletions(-)

-- 
2.17.1

