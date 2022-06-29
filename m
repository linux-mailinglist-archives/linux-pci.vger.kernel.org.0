Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0863A55F636
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 08:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbiF2GFJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 02:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231555AbiF2GFH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 02:05:07 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2073.outbound.protection.outlook.com [40.107.223.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD01167D5;
        Tue, 28 Jun 2022 23:05:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUPan3WTFjCoyVwTFOyduteJwCuS9Y080y0iCQ60pXIYDb3BSEfv4GeCrXsfjj27Fk2sZKXUGkbKT8LNeQ9xY+wrP13I21nLq2lAMhlrR3SLZ+tadv32e5koZ4JGdpwy3XS+Z9WhRSxqDZut2TdmxLz1ezaQ6LeEU5HTRKMp91K9tW7J5fgKi78DFvk2pwMuZmZOHAwfBD5II9gyZI5SYolbPD/v+N4FmoGJ3UdHn4dILhgklfeApUZjxJ7ej8Nr3aztbxCHK/7DX+ohmsjc76izfrG9JyN55aCtuzqYyLhrK+cHt/B+V1y60cSJrjzF+0zwJReG4BcFVQd35GEAPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IFSZTh+cC1LXybu5/8NHTPPJRbnaTGBwIucAID/3FB8=;
 b=heF6qPSsCAZl0eiq8FaTkotPc5kO+nyNpf0lcZQzPsIEiPhfOg3PYd4xjWzlX2dy9RW+UUWmUBNUIGQl6oS04HyoXS0VxqwDrz+fC7XNQC8PjNMgnHw4HFhA9OljdL2YUzbhbCrcfdG2UXLn7s34O1uu4OTcokURpNXZpMYXg6/2v/GNT5D9tGI2UwIUOy2a8WZtmevpgZcVLLJM3SUohjvPsbmH0nd/xeQ7j7O5xcEH81gVUVbE53H+AH2sGMDgxgRE4URp/tCquy10JaMvMmfvsnoA2QHuIcBzjWyMSafExrz4uFAy5jwG2+oYnPi+SwrRBedXvK5J7ZFXGpX83g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=ti.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IFSZTh+cC1LXybu5/8NHTPPJRbnaTGBwIucAID/3FB8=;
 b=P79e2ilZZiPTCEauZXKQDOOcZk70ZBJ5zUXUMfKy/zmXTFlw8jR3Mu357s1sSrA+myNa8t3W/XLAesoEmDJnFODFIX1jRJmGUInT6NIaNbduQzzagpvlHWVTU6KKJ0HD8Ugi6abSLVPal59hi4fi/kWu3cKGtsCNUOjGjyqPUU9S/RH07UhIp1QDBTcc0Nw/J/S/jsOIa6NAYvPUoeaA/R0r1zFq0ZatK71sPAslqcx4F2gFTHJ6+wAwFTqME2wiRm3F4RtTnQfrRgkkE3WafDcq4BCPMbBNPMc4GB0iIdsEozMg/zjX8917ai2VtghtkImEyyWFT/thn9YaVZR3wQ==
Received: from DM6PR11CA0052.namprd11.prod.outlook.com (2603:10b6:5:14c::29)
 by CY4PR1201MB0248.namprd12.prod.outlook.com (2603:10b6:910:18::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 06:05:04 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::2c) by DM6PR11CA0052.outlook.office365.com
 (2603:10b6:5:14c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16 via Frontend
 Transport; Wed, 29 Jun 2022 06:05:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 06:05:03 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 29 Jun
 2022 06:05:03 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 28 Jun
 2022 23:05:02 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Tue, 28 Jun 2022 23:04:57 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <kishon@ti.com>, <vkoul@kernel.org>, <kw@linux.com>,
        <krzk@kernel.org>, <p.zabel@pengutronix.de>,
        <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V3 03/11] dt-bindings: PCI: tegra234: Add schema for tegra234 rootport mode
Date:   Wed, 29 Jun 2022 11:34:27 +0530
Message-ID: <20220629060435.25297-4-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220629060435.25297-1-vidyas@nvidia.com>
References: <20220629060435.25297-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed50d204-e084-472b-03ab-08da59954f19
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0248:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7nT3HIDtddalsgxO2UIdFe7eDWOfcu/2BYZdscFlZlsQ1yFoQiBIhrXSMVUotksU4Nz0XLziGExs+i3P7hSfCwWHi7JFbCBqTGenOBe7MN7lWIMaxM9/ilzRaVSUvFDMAk9XuS0u2iRczmZXNaTiEVyZcCX9lYJIcPi9/gUNxHUv8NUA/ks1z3h3aTmoZ7mloW/xW6Z7Ss18RWV9LgkZe3MR8u8X+q4IX+/XfPltA9UOZDRIatCb28eHRZJIKLlMTu/ccgxhlSnt+ODKuuhPlPJ3kVB4oBAukeFvHp7ZBsNQEeuP1GejnG1c6Fse7gvdjQsUJdIRnhkQFi1FZ2SUOb6BP1LfC80F4DUW8jsxgHx76fShu/0WckBIzPAoZtMQ09+jacbIxoa06UEQyyHv/ALJE78i9Mo+UiqWoxNTJMMDju/ebctn33wRkjLnfqaJa1CfJet6w3byimueXNU4lJ09i/O4SVJcWweSaBTJTtJgsz12dir8FsIiK7c6n5obqsQBU3fc74oxm9mx3UFaI9Jbh/Bc2O6Rv4+xyU4e5coixtWWpcvTRKBcI1hewX0sRliK3OQpxLoTlvdUWNpX+Z4sEidj20zxH/jGmVQ657cmi7DW+e7fIinoAM9FtkYFNWGtJLT/98/kdNs02BUaD+ikg3fCdTcwTf3jul7eobNKStgf3BxvovRpupJOzAiHOq+7LIIUE14N4HvWAJuOln0soIkXqiNTSGTQngVAx5rMMecXNtad8Lej5w1LlEB7D9Q6rJU3waYUIA+GlEGgDp9uwrlQqEc/WM7cw8zrsBfj1JOda2aFSAudJngTrTRKlXYRVa39myOOdKTYVNXj0w==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(39860400002)(376002)(40470700004)(36840700001)(46966006)(426003)(82740400003)(478600001)(26005)(41300700001)(47076005)(336012)(7696005)(316002)(5660300002)(81166007)(2906002)(2616005)(8936002)(7416002)(356005)(40480700001)(82310400005)(8676002)(70586007)(86362001)(36860700001)(36756003)(6666004)(40460700003)(83380400001)(4326008)(1076003)(110136005)(54906003)(70206006)(186003)(6636002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 06:05:03.7291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed50d204-e084-472b-03ab-08da59954f19
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0248
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
V3:
* New patch in this series

 .../bindings/pci/nvidia,tegra194-pcie.yaml    | 151 +++++++++++++++++-
 1 file changed, 146 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
index 4a49dddf33bb..ede53baa1d71 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
@@ -22,6 +22,7 @@ properties:
   compatible:
     enum:
       - nvidia,tegra194-pcie
+      - nvidia,tegra234-pcie
 
   reg:
     items:
@@ -82,6 +83,8 @@ properties:
       name for the PCIe controller. Following are the specifiers for the different PCIe
       controllers:
 
+      Tegra194
+
         - TEGRA194_POWER_DOMAIN_PCIEX8B: C0
         - TEGRA194_POWER_DOMAIN_PCIEX1A: C1
         - TEGRA194_POWER_DOMAIN_PCIEX1A: C2
@@ -91,6 +94,22 @@ properties:
 
       these specifiers are defined in "include/dt-bindings/power/tegra194-powergate.h" file.
 
+      Tegra234
+
+        - TEGRA234_POWER_DOMAIN_PCIEX4BA: C0
+        - TEGRA234_POWER_DOMAIN_PCIEX1A : C1
+        - TEGRA234_POWER_DOMAIN_PCIEX1A : C2
+        - TEGRA234_POWER_DOMAIN_PCIEX1A : C3
+        - TEGRA234_POWER_DOMAIN_PCIEX4BB: C4
+        - TEGRA234_POWER_DOMAIN_PCIEX8A : C5
+        - TEGRA234_POWER_DOMAIN_PCIEX4A : C6
+        - TEGRA234_POWER_DOMAIN_PCIEX8B : C7
+        - TEGRA234_POWER_DOMAIN_PCIEX4CA: C8
+        - TEGRA234_POWER_DOMAIN_PCIEX4CB: C9
+        - TEGRA234_POWER_DOMAIN_PCIEX4CC: C10
+
+      these specifiers are defined in "include/dt-bindings/power/tegra234-powergate.h" file.
+
   interconnects:
     items:
       - description: memory read client
@@ -112,17 +131,30 @@ properties:
       Must contain a pair of phandle to BPMP controller node followed by controller ID. Following
       are the controller IDs for each controller:
 
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
-          - minimum: 0
-            maximum: 0xffffffff
-          - enum: [ 0, 1, 2, 3, 4, 5 ]
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
 
   nvidia,update-fc-fixup:
     description: |
@@ -131,6 +163,8 @@ properties:
       enabling root port to exchange optimum number of FC (Flow Control) credits with downstream
       devices:
 
+      NOTE:- This is applicable only for Tegra194.
+
         1. If C0/C4/C5 run at x1/x2 link widths (irrespective of speed and MPS)
         2. If C0/C1/C2/C3/C4/C5 operate at their respective max link widths and
           a) speed is Gen-2 and MPS is 256B
@@ -159,10 +193,56 @@ properties:
     description: A phandle to the regulator node that supplies 12V to the slot if the platform has
       one such slot. (Ex:- x16 slot owned by C5 controller in p2972-0000 platform).
 
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
   - $ref: "/schemas/pci/pci-bus.yaml#"
   - $ref: "/schemas/pci/snps,dw-pcie.yaml#"
 
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
+                - minimum: 0
+                  maximum: 0xffffffff
+                - enum: [ 0, 1, 2, 3, 4, 5 ]
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
+                - minimum: 0
+                  maximum: 0xffffffff
+                - enum: [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]
+
 unevaluatedProperties: false
 
 required:
@@ -252,3 +332,64 @@ examples:
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
2.17.1

