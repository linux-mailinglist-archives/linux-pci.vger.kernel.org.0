Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3566C569CFB
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 10:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235502AbiGGIOB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 04:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235363AbiGGINf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 04:13:35 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3F5639D;
        Thu,  7 Jul 2022 01:13:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQ4LYmE1Z+STAz95vK5NdCfkPqLfoJntXz1+15ODeT8adN2k2NZzDBjb+WGL9piI6B9PQ5Mz1qtCysy1eOiatyGn8oDp17/SgQI8SMnCBO/KKXVrqsWjZbcsILzCbXJeYQxNW2szPq4hg/RpJC5zrx12uyeeghvdAih6PijRDitzUgAZZFW1rfRUm9xCfASD9qbaH4Z6eab4iWK+qELWYkaRr2Qd5NoHLJcGIRaLWln+NBd3CZhEFPjgOQThhCXceq24eLfpFXWky3azAZNUDYrt0VklirYq+DfbMnfbZPeJWYUbsYwOrUqXpU/jUJEJyfUd/7mRegLXgb6++CGJUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MNMCtX+IG/4f3OLfmhVt2PGMfdTd92pjjkvlrjRZgs=;
 b=fFZJSMRJr+N/nG543SG/x3Hh6CYdwpsfEFQtZ2mn/Z6Ly6f5Smv3Z7lcic4jHhMBV08QgZEliveqGnBuJ66h0NOkS570CNCNZCDXXtKl3L2BomNmQcC0VG7ifGLMVsPpsg+x8NoIpCyezhfcF4XRbvSDod0ljpwmKwxNxKcQwLqZ4et32Bo57DH+FEYV/ewX47XvGkfOpRU83QvfXEK5x38cFXiQsgLRQfq0uZ3ZGDvDHlEyD0rzmgkjQDCBSKb2jXw4SlnjOLhiobaQ5gjthjjGQH4ny/CLYdahmlKgHs7NFuOQDcy8klKvv0nMW0GXa/+NrrxZOA6CRn3O5jTlJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MNMCtX+IG/4f3OLfmhVt2PGMfdTd92pjjkvlrjRZgs=;
 b=JPqq9GVBd9dkDIjTJp+1QRBylsn+KFJIjTr0/oGNZawhPO0BkGhAg/WrZkmOTaoIBQUu1xclPL+MCIXSR4yjROSzSBqJDn5LYbmRhESKFrTr4vinJF2y1JQ5yBgXloMC5j8Q7HlmC+1MJa2YC9VdrZbq8Yeo0DXNCN440IuDm04VBEMfLZXmDrU/eD7REeFGFNMcHyl7esBDy78y0EEM50rB1rVrOX6eAXJllfgQRAqplLuPE3o79WZevMuXcMbLr6jklaHrVR7VkXw7GR2R0VPcbIVrmbDlHwBLKeHfitykq6LBrkNLAF0e4AjIdtwLgwfnN5sfS0EqUmqEQNHMKQ==
Received: from MWHPR03CA0017.namprd03.prod.outlook.com (2603:10b6:300:117::27)
 by BN6PR12MB1409.namprd12.prod.outlook.com (2603:10b6:404:1e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 7 Jul
 2022 08:13:30 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:117:cafe::e7) by MWHPR03CA0017.outlook.office365.com
 (2603:10b6:300:117::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 7 Jul 2022 08:13:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 08:13:29 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 7 Jul
 2022 08:13:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 7 Jul 2022
 01:13:28 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 7 Jul 2022 01:13:24 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lpieralisi@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <kw@linux.com>, <kishon@ti.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V4 3/9] dt-bindings: PCI: tegra234: Add schema for tegra234 endpoint mode
Date:   Thu, 7 Jul 2022 13:42:55 +0530
Message-ID: <20220707081301.29961-4-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220707081301.29961-1-vidyas@nvidia.com>
References: <20220707081301.29961-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 226238ef-8367-4a51-7173-08da5ff0939f
X-MS-TrafficTypeDiagnostic: BN6PR12MB1409:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gd5+LVrcvMQGPBWIg8mU0wmqphKLb3QDb3m23MujyvEhUg13f0m/i6DsbPgeQmETfm155aEC/oUM8gDXo8vLFEb55vZKOpPyjwO7tuhqNQ4nLyAyUc8PnmLkkJ7Ri4DFLNOG1uX2QqfpOM3z5cDTAUgJNe/nWKuMg5ZQCbtkIFoIBCc2LYnKiqNfHXLY+2tCoGrPmvbkYwpkVKH1N+r+ULx7kWQZ8jT6b6L7mGqSW/cElRvTe71qQomZR3klXGuS0gvxeFMq4mZhmP5umQrB2GTva5A0Jzot0kCPQgjIxbaDa6U6bfsV5o1//lyIDVAKsTect4TIRXBxhzQ1EaFGxbQWYSCfuFEN32lmwSTU4t7oWON1z2sAwaSdac5kyb6Oto13Y0M0egpDogp3uPvpaktFNVzNWa5MIJzFbRKXSPCdXcAS/LmazJFrP4+3gM1nrOC3SfG0EOvVIURONSXp1i6IwkeUv84L1fDENuapnEpIY3PuwEsuRGs0kg2AqP3AbobAOsQqnkPQ/Mejn8FexeDZ30IWlMnW7Q1MEA0o2mx7zDwixFGoCUpQKVKpIJ3UZ/1EZGMKyyZa1vBs0zcAg6WXBnTLoZDABpXGSAIO/6FNftVyu+kV9Hry+StO0GL/Agui4LGvMwKbEVtDkQ2Q1NKnkd1iqVLE01HfHCDs5yE42GaEnipiotbm3ETWVKn4s3dUlIXAUnfBFmjcLezYC3nwBvMWidQ6XTqSxPHD5RDmoCQ4xa4+9a+4ULXs0mlPRzCGQmocdAhlO0GlbhOyAUq2L9zUu3UkpAqJKAQhhm0GVO76mW5UjW2lz078qmgLptYDcBPeKeyMsM/7v9xE7qEiUZy9E+3DAIJKqRBCid9iEI33nbR6b7UKG9EV9COp
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(39860400002)(396003)(40470700004)(46966006)(36840700001)(478600001)(2616005)(40480700001)(1076003)(186003)(41300700001)(36756003)(7696005)(110136005)(2906002)(6666004)(316002)(8936002)(7416002)(5660300002)(54906003)(426003)(82740400003)(82310400005)(47076005)(336012)(356005)(26005)(86362001)(70586007)(8676002)(83380400001)(81166007)(70206006)(36860700001)(40460700003)(4326008)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 08:13:29.8586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 226238ef-8367-4a51-7173-08da5ff0939f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1409
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for PCIe controllers that operate in the endpoint mode
in tegra234 chipset.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V4:
* Rebased on top of previous patch

V3:
* New patch in this series

 .../bindings/pci/nvidia,tegra194-pcie-ep.yaml | 123 +++++++++++++++++-
 1 file changed, 117 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
index 98e2d40e876b..cffe8e8bec94 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
@@ -18,6 +18,7 @@ description: |
   in root port mode or endpoint mode but one at a time.
 
   On Tegra194, controllers C0, C4 and C5 support endpoint mode.
+  On Tegra234, controllers C5, C6, C7 and C10 support endpoint mode.
 
   Note: On Tegra194's P2972-0000 platform, only C5 controller can be enabled to
   operate in the endpoint mode because of the way the platform is designed.
@@ -26,6 +27,7 @@ properties:
   compatible:
     enum:
       - nvidia,tegra194-pcie-ep
+      - nvidia,tegra234-pcie-ep
 
   reg:
     items:
@@ -96,7 +98,8 @@ properties:
       A phandle to the node that controls power to the respective PCIe
       controller and a specifier name for the PCIe controller.
 
-      specifiers are defined in "include/dt-bindings/power/tegra194-powergate.h" file.
+      Tegra194 specifiers are defined in "include/dt-bindings/power/tegra194-powergate.h" file.
+      Tegra234 specifiers are defined in "include/dt-bindings/power/tegra234-powergate.h" file.
 
   interconnects:
     items:
@@ -116,17 +119,30 @@ properties:
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
-    items:
-      - items:
-          - description: phandle to BPMP controller node
-          - description: PCIe controller ID
-            maximum: 5
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
+      Platform constraints are described later
 
   nvidia,aspm-cmrt-us:
     description: Common Mode Restore Time for proper operation of ASPM to be
@@ -146,9 +162,47 @@ properties:
     maxItems: 1
     description: GPIO used to enable REFCLK to controller from the host
 
+  nvidia,enable-srns:
+    description: |
+      This boolean property needs to be present if the controller is configured
+      to operate in SRNS (Separate Reference Clocks with No Spread-Spectrum Clocking).
+      NOTE:- This is applicable only for Tegra234.
+
+    $ref: /schemas/types.yaml#/definitions/flag
+
 allOf:
   - $ref: /schemas/pci/pci-ep.yaml#
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra194-pcie
+    then:
+      properties:
+        nvidia,bpmp:
+          items:
+            - items:
+                - description: phandle to BPMP controller node
+                - description: PCIe controller ID
+                  maximum: 5
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra234-pcie
+    then:
+      properties:
+        nvidia,bpmp:
+          items:
+            - items:
+                - description: phandle to BPMP controller node
+                - description: PCIe controller ID
+                  maximum: 10
+
 unevaluatedProperties: false
 
 required:
@@ -226,3 +280,60 @@ examples:
                         "p2u-5", "p2u-6", "p2u-7";
         };
     };
+
+  - |
+    #include <dt-bindings/clock/tegra234-clock.h>
+    #include <dt-bindings/gpio/tegra234-gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/tegra234-powergate.h>
+    #include <dt-bindings/reset/tegra234-reset.h>
+
+    bus@0 {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        ranges = <0x0 0x0 0x0 0x8 0x0>;
+
+        pcie-ep@141a0000 {
+            compatible = "nvidia,tegra234-pcie-ep";
+            power-domains = <&bpmp TEGRA234_POWER_DOMAIN_PCIEX8A>;
+            reg = <0x00 0x141a0000 0x0 0x00020000>, /* appl registers (128K)      */
+                  <0x00 0x3a040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
+                  <0x00 0x3a080000 0x0 0x00040000>, /* DBI reg space (256K)       */
+                  <0x27 0x40000000 0x4 0x00000000>; /* Address Space (16G)        */
+            reg-names = "appl", "atu_dma", "dbi", "addr_space";
+
+            interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+            interrupt-names = "intr";
+
+            clocks = <&bpmp TEGRA234_CLK_PEX1_C5_CORE>;
+            clock-names = "core";
+
+            resets = <&bpmp TEGRA234_RESET_PEX1_CORE_5_APB>,
+                     <&bpmp TEGRA234_RESET_PEX1_CORE_5>;
+            reset-names = "apb", "core";
+
+            nvidia,bpmp = <&bpmp 5>;
+
+            nvidia,enable-ext-refclk;
+            nvidia,aspm-cmrt-us = <60>;
+            nvidia,aspm-pwr-on-t-us = <20>;
+            nvidia,aspm-l0s-entrance-latency-us = <3>;
+
+            vddio-pex-ctl-supply = <&p3701_vdd_1v8_ls>;
+
+            reset-gpios = <&gpio TEGRA234_MAIN_GPIO(AF, 1) GPIO_ACTIVE_LOW>;
+
+            nvidia,refclk-select-gpios = <&gpio_aon
+                                          TEGRA234_AON_GPIO(AA, 4)
+                                          GPIO_ACTIVE_HIGH>;
+
+            num-lanes = <8>;
+
+            phys = <&p2u_nvhs_0>, <&p2u_nvhs_1>, <&p2u_nvhs_2>,
+                   <&p2u_nvhs_3>, <&p2u_nvhs_4>, <&p2u_nvhs_5>,
+                   <&p2u_nvhs_6>, <&p2u_nvhs_7>;
+
+            phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3", "p2u-4",
+                        "p2u-5", "p2u-6", "p2u-7";
+        };
+    };
-- 
2.17.1

