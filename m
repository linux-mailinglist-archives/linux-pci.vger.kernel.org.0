Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35A56870F9
	for <lists+linux-pci@lfdr.de>; Fri,  9 Aug 2019 06:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405562AbfHIEre (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Aug 2019 00:47:34 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:5638 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405555AbfHIErb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Aug 2019 00:47:31 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d4cfaec0001>; Thu, 08 Aug 2019 21:47:40 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 08 Aug 2019 21:47:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 08 Aug 2019 21:47:30 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 9 Aug
 2019 04:47:29 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 9 Aug 2019 04:47:29 +0000
Received: from vidyas-desktop.nvidia.com (Not Verified[10.24.37.38]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d4cfadc0001>; Thu, 08 Aug 2019 21:47:29 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <kishon@ti.com>, <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <digetx@gmail.com>, <mperttunen@nvidia.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V15 11/13] dt-bindings: PHY: P2U: Add Tegra194 P2U block
Date:   Fri, 9 Aug 2019 10:16:07 +0530
Message-ID: <20190809044609.20401-12-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190809044609.20401-1-vidyas@nvidia.com>
References: <20190809044609.20401-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565326060; bh=0X+smhF2gtUG8r3MJH5Je2OrG2LH1jP6q58RC/R8Jmc=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=KVuLUTLgTzb98nWbpNLrdxDXFG6PUAT1tODXWFKufbyTbyA+izKkqje2B8iU6jP97
         28gelsN8Bb+jAbWwRHIOOq597+cE5ptD5CHS2D/9Oml5HO0tr677jVSBlr8G5zmz2m
         l6TBORy6xMxYRV1/HJcWHrh+jJhnpn9acYUFGVP5Oz9BGPsZOrPJrEA5AZBrHUu9lx
         6v8D5bK7HDacCZsGM7oxWukgUK2caLz7oidM39UZgW2T3QN+/Av0DK1kEYLxyeevwL
         zeSyJjYfV1dWCcxvPbzbjvyxPDHy04Yq+EBi9Fc8rUJMBJsOtvtKMNA/xXzu+3ZoE+
         IJrC3pCzMzykg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for Tegra194 P2U (PIPE to UPHY) module block which is a glue
module instantiated one for each PCIe lane between Synopsys DesignWare core
based PCIe IP and Universal PHY block.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Thierry Reding <treding@nvidia.com>
Acked-by: Kishon Vijay Abraham I <kishon@ti.com>
---
V15:
* None

V14:
* None

V13:
* None

V12:
* None

V11:
* None

V10:
* None

V9:
* None

V8:
* None

V7:
* None

V6:
* Added Sob
* Changed node name from "p2u@xxxxxxxx" to "phy@xxxxxxxx"

V5:
* None

V4:
* None

V3:
* Changed node label to reflect new format that includes either 'hsio' or
  'nvhs' in its name to reflect which UPHY brick they belong to

V2:
* This is a new patch in v2 series

 .../bindings/phy/phy-tegra194-p2u.txt         | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt

diff --git a/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
new file mode 100644
index 000000000000..d23ff90baad5
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/phy-tegra194-p2u.txt
@@ -0,0 +1,28 @@
+NVIDIA Tegra194 P2U binding
+
+Tegra194 has two PHY bricks namely HSIO (High Speed IO) and NVHS (NVIDIA High
+Speed) each interfacing with 12 and 8 P2U instances respectively.
+A P2U instance is a glue logic between Synopsys DesignWare Core PCIe IP's PIPE
+interface and PHY of HSIO/NVHS bricks. Each P2U instance represents one PCIe
+lane.
+
+Required properties:
+- compatible: For Tegra19x, must contain "nvidia,tegra194-p2u".
+- reg: Should be the physical address space and length of respective each P2U
+       instance.
+- reg-names: Must include the entry "ctl".
+
+Required properties for PHY port node:
+- #phy-cells: Defined by generic PHY bindings.  Must be 0.
+
+Refer to phy/phy-bindings.txt for the generic PHY binding properties.
+
+Example:
+
+p2u_hsio_0: phy@3e10000 {
+	compatible = "nvidia,tegra194-p2u";
+	reg = <0x03e10000 0x10000>;
+	reg-names = "ctl";
+
+	#phy-cells = <0>;
+};
-- 
2.17.1

