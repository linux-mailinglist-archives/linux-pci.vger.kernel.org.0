Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37015731CE
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 11:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbiGMJBF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 05:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235900AbiGMJBD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 05:01:03 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812FFEBBDF;
        Wed, 13 Jul 2022 02:00:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YqVoKpmoXqGciw0eMZ3k+CeczhAEGHKCzBb1V0fmJqsXK3vZNM0jNeTseI1co9HNhw+UXhZ8ko2JvW6m1x2qZLJ5qB3VM91V4/DcCGlnQm9ARaflf60SPNGQ6egZ5O57dMH8bccZ4OIYek2K9l3sIQqoXX4hPDLXmkKx6Fu6DRxXCIB7gw73N6lO59bKc8QXcVs0lHoBoebhaYlytnfURD8X4xcwvmVsE7tV8qZw9i2a8BxT0PJOhxCmE9DvbMl+2x2SOSkhWi9XFpmGfcj9df06FndSZO2BJOEQ8RPSQhcdUmn3wlj87hBdb8EGyZLLwwa6paKMAzZI4amxrSKP6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZ06RwAD+s7ZOqL3QWP7rVCAhJlBJJNHByCKFySjSVY=;
 b=UCOm9LqtKMfaulOIeBKcbHk5VThh+Q4Hf7y5aDN6P7apyxNYvtI76iwkPQ9oMDICDn0uTYxZ9JKSz1HePt5/vdTAztT3TnOo1U9+EGQXJKPOYkmqZu05HpsrppK+PPK8a3IBf8Hyuz6+i01dXhy67wwFSvOZMHThrG8yXFpkVkrR6ekf/GLYuCGC8bxjRWbKnYbei2+DtTWcoMpYcCTrWbF+SnBqscjwR2NsMbswgYCmS77asKK4RAI4N2Fx0XyGEr3Yqeo8wRJXSaHUUitQ4rmQLBRh7bYsz5Z4bSeou+tC5rjAEHvZBBjCcmbZDKgbh4hXhgJ9cltBTgRnGgOURw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZ06RwAD+s7ZOqL3QWP7rVCAhJlBJJNHByCKFySjSVY=;
 b=itNx8tOvpO2Y6ynDdi3jR1s1kRaAwaDatFpc3vokNUPIOLYxdh1pKn8hpa/sISv4d4YYwK7kL1D+VuJs4poPivDArJc+fm/7BF1lq3xzO4QbYAhUIhCWSBQ4p/WhFR3HwhFiXyr93Ei6n/ctFKq+/9MXWttS9+ej3XA1gsHC/za4/jZGfonTUN2vO6W9pMjhx6Sc/Itif4u4Ig9kW4RTcUVH83Hk/3VrSqFWoxM8Gx71KQkrT7llFEuu2ytdK1BGXEVhQSEVH6wGl2Ci8m/TAxN8kurjvRI1LikJEqjklPajTq6o6SO9gLKKDnZS16E/5Vre8TpwqJKluT1TKZ1WIA==
Received: from MW4P221CA0004.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::9) by
 BYAPR12MB2614.namprd12.prod.outlook.com (2603:10b6:a03:6b::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5395.18; Wed, 13 Jul 2022 09:00:57 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::46) by MW4P221CA0004.outlook.office365.com
 (2603:10b6:303:8b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Wed, 13 Jul 2022 09:00:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 09:00:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 13 Jul
 2022 09:00:50 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 13 Jul
 2022 02:00:50 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Wed, 13 Jul 2022 02:00:45 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lpieralisi@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <kw@linux.com>, <kishon@ti.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V5 2/9] dt-bindings: PCI: tegra234: Add schema for tegra234 rootport mode
Date:   Wed, 13 Jul 2022 14:30:22 +0530
Message-ID: <20220713090029.30395-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220713090029.30395-1-vidyas@nvidia.com>
References: <20220713090029.30395-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e61a2a51-eac3-494b-68df-08da64ae32f3
X-MS-TrafficTypeDiagnostic: BYAPR12MB2614:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YhIYBhJ1qO2dF3ShMEp4IB1USFsOlmiEayhrbLGxP4YvapxY7+6s7fCsSm2GYYhdI+zjRwUaRms0BCOA63uGAbq5OJ8bi6p/kwGlMOITg8zytk6B6cFg+2Gqclw0x4uemCHhuiSrKzXBbO/Vw5upYI4w8hqAtnhwKCUXwhENP6VKF9HYFAov+krvLtd/Ak2JAzwjr9kvSreAI6oMT8cnEB+axy0vIMSJNha6hz966d0/11hPft/9iYnx5qrY/MZqz4B+vdrkURX/Z8qXWfOfGJlc9iAfdvtXDCe/9/CMyG7/a8EtRb84hocLq/eUuLjrEheTnjS3fWVDFZ53mDsuEqhA2uUfiSOzY7ui7W2jTO5aYDmg1v3Kb9ijFA3GDkoXGNH2GijWuOQtH2zdZeck39MRik0Kt3humIJS77akpZav9XUHsoBO+dJ/xl5/zqzXvIojeZLyWYx2CAo9uTNtIjZhfFAaM/m8N7VDrirnrDsHJH6lAkNNtEEaJ2N60WjinihkqX71MH9xI/bLjpvnmXS9d4023Z0Uu1TMDB4GmS9L03piuIpbUT+6acy1ByMJKraN/rj68FkYOf7S3SJi7RieanMOZD9XCzXgtc3Jd55ZMmKDcNA/uVwphuTYQw0Uf9VcQexZCCVz2gjwwbljVP0T6DQgIkKdYfsi25hKYRdoEekY34Hc53C4YHmfrCExV49QHmT+cJllG07/zjYIOCzi4I+Sx0AVu49qDg28UpCSRO7EZCj1+q5RlDdKy+pLS1REmCafwL1VF6JFtya6UHZQffezIODk3wrEaYYS97B4/tuZ4JIusbOJBfpy4aPH4rYuJfOacY0872XUAV4jGeuyuh0IeTukUH6RyIfRF5mydnw9C8myFmRkBYNRRmV1
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(346002)(376002)(136003)(46966006)(36840700001)(40470700004)(70206006)(47076005)(36756003)(7416002)(5660300002)(86362001)(2906002)(82310400005)(54906003)(8676002)(8936002)(4326008)(40480700001)(40460700003)(110136005)(336012)(316002)(26005)(83380400001)(1076003)(70586007)(2616005)(7696005)(6666004)(356005)(478600001)(36860700001)(82740400003)(41300700001)(81166007)(186003)(426003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 09:00:56.7152
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e61a2a51-eac3-494b-68df-08da64ae32f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2614
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for PCIe controllers that operate in the rootport mode
in tegra234 chipset.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V5:
* Addressed review comments from Rob

V4:
* Rebased on top of previous patch

V3:
* New patch in this series

 .../bindings/pci/nvidia,tegra194-pcie.yaml    | 102 +++++++++++++++++-
 1 file changed, 100 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
index abbaafe98fd4..1e2274b2ba0b 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
@@ -24,6 +24,7 @@ properties:
   compatible:
     enum:
       - nvidia,tegra194-pcie
+      - nvidia,tegra234-pcie
 
   reg:
     items:
@@ -92,7 +93,8 @@ properties:
       A phandle to the node that controls power to the respective PCIe
       controller and a specifier name for the PCIe controller.
 
-      specifiers are defined in "include/dt-bindings/power/tegra194-powergate.h" file.
+      Tegra194 specifiers are defined in "include/dt-bindings/power/tegra194-powergate.h" file.
+      Tegra234 specifiers are defined in "include/dt-bindings/power/tegra234-powergate.h" file.
 
   interconnects:
     items:
@@ -112,17 +114,34 @@ properties:
       Must contain a pair of phandle to BPMP controller node followed by
       controller ID. Following are the controller IDs for each controller:
 
+      Tegra194
+
         0: C0
         1: C1
         2: C2
         3: C3
         4: C4
         5: C5
+
+      Tegra234
+
+        0 : C0
+        1 : C1
+        2 : C2
+        3 : C3
+        4 : C4
+        5 : C5
+        6 : C6
+        7 : C7
+        8 : C8
+        9 : C9
+        10: C10
+
     items:
       - items:
           - description: phandle to BPMP controller node
           - description: PCIe controller ID
-            maximum: 5
+            maximum: 10
 
   nvidia,update-fc-fixup:
     description: |
@@ -131,6 +150,8 @@ properties:
       of the following conditions thereby enabling root port to exchange
       optimum number of FC (Flow Control) credits with downstream devices:
 
+      NOTE:- This is applicable only for Tegra194.
+
         1. If C0/C4/C5 run at x1/x2 link widths (irrespective of speed and MPS)
         2. If C0/C1/C2/C3/C4/C5 operate at their respective max link widths and
           a) speed is Gen-2 and MPS is 256B
@@ -162,6 +183,22 @@ properties:
       if the platform has one such slot. (Ex:- x16 slot owned by C5 controller
       in p2972-0000 platform).
 
+  nvidia,enable-srns:
+    description: |
+      This boolean property needs to be present if the controller is configured
+      to operate in SRNS (Separate Reference Clocks with No Spread-Spectrum Clocking).
+      NOTE:- This is applicable only for Tegra234.
+
+    $ref: /schemas/types.yaml#/definitions/flag
+
+  nvidia,enable-ext-refclk:
+    description: |
+      This boolean property needs to be present if the controller is configured
+      to use the reference clocking coming in from an external clock source instead of
+      using the internal clock source.
+
+    $ref: /schemas/types.yaml#/definitions/flag
+
 allOf:
   - $ref: /schemas/pci/snps,dw-pcie.yaml#
 
@@ -249,3 +286,64 @@ examples:
             phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3";
         };
     };
+
+  - |
+    #include <dt-bindings/clock/tegra234-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/tegra234-powergate.h>
+    #include <dt-bindings/reset/tegra234-reset.h>
+
+    bus@0 {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        ranges = <0x0 0x0 0x0 0x8 0x0>;
+
+        pcie@14160000 {
+            compatible = "nvidia,tegra234-pcie";
+            power-domains = <&bpmp TEGRA234_POWER_DOMAIN_PCIEX4BB>;
+            reg = <0x00 0x14160000 0x0 0x00020000>, /* appl registers (128K)      */
+                  <0x00 0x36000000 0x0 0x00040000>, /* configuration space (256K) */
+                  <0x00 0x36040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
+                  <0x00 0x36080000 0x0 0x00040000>; /* DBI reg space (256K)       */
+            reg-names = "appl", "config", "atu_dma", "dbi";
+
+            #address-cells = <3>;
+            #size-cells = <2>;
+            device_type = "pci";
+            num-lanes = <4>;
+            num-viewport = <8>;
+            linux,pci-domain = <4>;
+
+            clocks = <&bpmp TEGRA234_CLK_PEX0_C4_CORE>;
+            clock-names = "core";
+
+            resets = <&bpmp TEGRA234_RESET_PEX0_CORE_4_APB>,
+                     <&bpmp TEGRA234_RESET_PEX0_CORE_4>;
+            reset-names = "apb", "core";
+
+            interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
+                         <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
+            interrupt-names = "intr", "msi";
+
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0>;
+            interrupt-map = <0 0 0 0 &gic GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+
+            nvidia,bpmp = <&bpmp 4>;
+
+            nvidia,aspm-cmrt-us = <60>;
+            nvidia,aspm-pwr-on-t-us = <20>;
+            nvidia,aspm-l0s-entrance-latency-us = <3>;
+
+            bus-range = <0x0 0xff>;
+            ranges = <0x43000000 0x21 0x40000000 0x21 0x40000000 0x2 0xe8000000>, /* prefetchable */
+                     <0x02000000 0x0  0x40000000 0x24 0x28000000 0x0 0x08000000>, /* non-prefetchable */
+                     <0x01000000 0x0  0x36100000 0x00 0x36100000 0x0 0x00100000>; /* downstream I/O */
+
+            vddio-pex-ctl-supply = <&p3701_vdd_AO_1v8>;
+
+            phys = <&p2u_hsio_4>, <&p2u_hsio_5>, <&p2u_hsio_6>,
+                   <&p2u_hsio_7>;
+            phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3";
+        };
+    };
-- 
2.34.1

