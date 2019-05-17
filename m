Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1AEF2185F
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2019 14:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbfEQMkK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 May 2019 08:40:10 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:18979 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728244AbfEQMkJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 17 May 2019 08:40:09 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cdeaba40000>; Fri, 17 May 2019 05:40:04 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 17 May 2019 05:40:08 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 17 May 2019 05:40:08 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 May
 2019 12:40:08 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 17 May
 2019 12:40:08 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 17 May 2019 12:40:08 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5cdeaba20000>; Fri, 17 May 2019 05:40:07 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <kishon@ti.com>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V7 06/15] dt-bindings: PCI: designware: Add binding for CDM register check
Date:   Fri, 17 May 2019 18:08:37 +0530
Message-ID: <20190517123846.3708-7-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190517123846.3708-1-vidyas@nvidia.com>
References: <20190517123846.3708-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1558096804; bh=46Qz0EZjVWXnp1mfvq4rI09Z5mbJDbo602/Sd61F2sA=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=mPlCTapakqSB9NkPQcMq4kdg80LIsLXz+cX8aS5NR7rDk5NkK6bPa21gH4r5Pts5+
         KQ9mv+bHADmrgDfUmJYtQ2hfe66rB9tQh0ZxISDzMOrStjVLYtEP3SLDoWySw5FAdJ
         6kcxi0VX9Wnl4HMM4KwHbF9gR3QlDRMhi3YHg3+YwMR/mvcWVIsyJr49NwtiwW39rY
         sY4rgX1DwO+tW179s7qLUZqr0rfJB+7q+gdAy+LO5Ga8Wf2XcNajHlvCNzUMU7Nn+Z
         D9tqOCK9uImOYAxZCLef4Ypi2LfbM6MmYhzqjuS7iDA0OmWVNs6CnSGTstC39UX73g
         joa2NZD33u8Tg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support to enable CDM (Configuration Dependent Module) registers check
for any data corruption. CDM registers include standard PCIe configuration
space registers, Port Logic registers and iATU and DMA registers.
Refer Section S.4 of Synopsys DesignWare Cores PCI Express Controller Databook
Version 4.90a

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
Changes since [v6]:
* Changed "enable-cdm-check" to "snps,enable-cdm-check"

Changes since [v5]:
* None

Changes since [v4]:
* None

Changes since [v3]:
* None

Changes since [v2]:
* Changed flag name from 'cdm-check' to 'enable-cdm-check'
* Added info about Port Logic and DMA registers being part of CDM

Changes since [v1]:
* This is a new patch in v2 series

 Documentation/devicetree/bindings/pci/designware-pcie.txt | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/designware-pcie.txt b/Documentation/devicetree/bindings/pci/designware-pcie.txt
index 5561a1c060d0..3fba04da6a59 100644
--- a/Documentation/devicetree/bindings/pci/designware-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/designware-pcie.txt
@@ -34,6 +34,11 @@ Optional properties:
 - clock-names: Must include the following entries:
 	- "pcie"
 	- "pcie_bus"
+- snps,enable-cdm-check: This is a boolean property and if present enables
+   automatic checking of CDM (Configuration Dependent Module) registers
+   for data corruption. CDM registers include standard PCIe configuration
+   space registers, Port Logic registers, DMA and iATU (internal Address
+   Translation Unit) registers.
 RC mode:
 - num-viewport: number of view ports configured in hardware. If a platform
   does not specify it, the driver assumes 2.
-- 
2.17.1

