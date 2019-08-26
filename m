Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B22279CA78
	for <lists+linux-pci@lfdr.de>; Mon, 26 Aug 2019 09:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbfHZHbx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Aug 2019 03:31:53 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:10924 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbfHZHbw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Aug 2019 03:31:52 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d638ae80000>; Mon, 26 Aug 2019 00:31:52 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 26 Aug 2019 00:31:51 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 26 Aug 2019 00:31:51 -0700
Received: from HQMAIL105.nvidia.com (172.20.187.12) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 26 Aug
 2019 07:31:51 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 26 Aug 2019 07:31:51 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d638ae20000>; Mon, 26 Aug 2019 00:31:50 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <kishon@ti.com>, <gustavo.pimentel@synopsys.com>,
        <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH 0/6] PCI: tegra: Enable PCIe C5 controller of Tegra194 in p2972-0000 platform
Date:   Mon, 26 Aug 2019 13:01:37 +0530
Message-ID: <20190826073143.4582-1-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1566804712; bh=6X+WlnCVjo8MVsTv4k2C3wR1RSTOieIbLP/dETqEQcY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=pnk2JHxEr/a4/h6s3DweEVnws1WizOX0AchEjwIVii7n/xtMDFwvWuWBv45I8sZXZ
         e+zZc9xBOzuZbKPTxoyxQrhmInwePOxOAZR5LvJQMofH7QfKDdxVAR1Jrs1gGNO689
         XAT0ynAAzGHNW14RM02EAoKH9asEUZq3ojs1/xNBGZnppHqmqmVVmJOqEsmETyTOud
         BEO8fV9dCnns8qfQ+hdZLmUCwv6FvVHUg09OBAfQTO5WwVF4rV8YLs80dYPpTHK1t6
         eM6OmH0OgKcB0KT5dIab9w3r668INC/A52moZAmmLhYwH6CvMyYmDR9/9pHnOKobj3
         dqB1UBKw0NZcQ==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch series enables Tegra194's C5 controller which owns x16 slot in
p2972-0000 platform. C5 controller's PERST# and CLKREQ# are not configured as
output and bi-directional signals by default and hence they need to be
configured explicitly. Also, x16 slot's 3.3V and 12V supplies are controlled
through GPIOs and hence they need to be enabled through regulator framework.
This patch series adds required infrastructural support to address both the
aforementioned requirements.
Testing done on p2972-0000 platform
- Able to enumerate devices connected to x16 slot (owned by C5 controller)
- Enumerated device's functionality verified
- Suspend-Resume sequence is verified with device connected to x16 slot

Vidya Sagar (6):
  dt-bindings: PCI: tegra: Add sideband pins configuration entries
  arm64: tegra: Add configuration for PCIe C5 sideband signals
  PCI: tegra: Add support to configure sideband pins
  dt-bindings: PCI: tegra: Add PCIe slot supplies regulator entries
  arm64: tegra: Add PCIe slot supply information in p2972-0000 platform
  PCI: tegra: Add support to enable slot regulators

 .../bindings/pci/nvidia,tegra194-pcie.txt     | 16 +++++
 .../arm64/boot/dts/nvidia/tegra194-p2888.dtsi | 24 +++++++
 .../boot/dts/nvidia/tegra194-p2972-0000.dts   |  4 +-
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      | 38 +++++++++-
 drivers/pci/controller/dwc/pcie-tegra194.c    | 71 +++++++++++++++++++
 5 files changed, 151 insertions(+), 2 deletions(-)

-- 
2.17.1

