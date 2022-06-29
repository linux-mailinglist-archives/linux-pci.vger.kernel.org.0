Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B790655F610
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 08:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231666AbiF2GFV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 02:05:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231635AbiF2GFO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 02:05:14 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 001CE18E1A;
        Tue, 28 Jun 2022 23:05:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XIV64h2/yi2wN+z8D1snVp7hDPSJqwZf+gNY4himEVnnmjdh2QF0lanYT6hfkPGbmxZ56dc/St9QUex8Ssu2LO7zN5A7FgNHkgLKt73fKO5/NGvolfcUGLXokUkVJjXrkK6bz/R47fkP611gEOAwUO+8Vcw08loC0sN3SQioww90+TZfr4UJ5+lb+3lckU2nnhaSHLbI5Of0QKQIfhoRTKsbMRYJ+scWxtxwxvtIUREht13qNV2i5Za9+fi23r+g9JgJDpTFMuoS8AzUkZv/5oarrxJvdVk3GvAr9jsBJUF5NqMAizSHqpGPg4Vxr1hJjhs5aVdKtbdBu18rP+1qBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=epr4KmtSwTJ1s+soqlOHowBSBQjCBzxEXEoidSDkTuU=;
 b=N5AK1IBcyeGlhl65gG78MAUemi2si6RYYvK9EjMYPw65jIlvEno8J79uuMcXqMrR5EY7IfucFPw/yXG/Vdksoq/uhCAByZ/E9DAPNakjcXq79DLVlC9RIPOVHnfHrgGlPi32PCzAAH4DhzsaPaa7zmS8Kie9M91bT5Mq6S9ThKA2vZi4I6nvV7sQvi7qrwxNDu3d27HoUbQhWckLQreSVVkI4tJ/xKzy8wkOY1uh53JJSy/naBkJUwMOd7eep+juS4meOWuAguf2CO7SnN/nYEFCiuz6MT91xxXb/wJIBwLQ+mOHOtFQzzYEkzKQ37ewQMtoxlY7J1RneYJroi5P4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=ti.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=epr4KmtSwTJ1s+soqlOHowBSBQjCBzxEXEoidSDkTuU=;
 b=XI+LLa+oHPyhjbGF4zH0YPLOI3y6kgU7p57BmM55d6rZCCgQT/6qspSKrvr/YozJPT5op3VKXalfED59vI6XdvkrFMUPCEeyhgFkHcD/tCvDOiOG5hSiHSusY6DMN1dLjldZiFWEiKY9Lx9upzsrm54zVHlRC6ArP9eSv7N29/oJpwlCuEwfgzXI6kqsqgMFwwMoWVBYSPJs+oldQdtTWb01EaWL4JcTOJdzV08tDeUXxwAoGmmtbqdfyRh+wau4u8DiGXtf6c32XkE02WTwP3yYgi6Jw8W7aOEm9sUmbauwIwCVC9l61mj9FQO6v8AUsA8ah7HKvt7gYK21LuBHjQ==
Received: from BN9PR03CA0734.namprd03.prod.outlook.com (2603:10b6:408:110::19)
 by BYAPR12MB3527.namprd12.prod.outlook.com (2603:10b6:a03:13c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Wed, 29 Jun
 2022 06:05:10 +0000
Received: from BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::48) by BN9PR03CA0734.outlook.office365.com
 (2603:10b6:408:110::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Wed, 29 Jun 2022 06:05:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT028.mail.protection.outlook.com (10.13.176.225) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 06:05:10 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 29 Jun
 2022 06:05:09 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 28 Jun
 2022 23:05:08 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Tue, 28 Jun 2022 23:05:04 -0700
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
Subject: [PATCH V3 04/11] dt-bindings: PCI: tegra234: Add schema for tegra234 endpoint mode
Date:   Wed, 29 Jun 2022 11:34:28 +0530
Message-ID: <20220629060435.25297-5-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220629060435.25297-1-vidyas@nvidia.com>
References: <20220629060435.25297-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25d30f1b-83e9-41b0-0596-08da5995530f
X-MS-TrafficTypeDiagnostic: BYAPR12MB3527:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6OZ33K5AYMGa+9AYy+YKu1C+YocXoEC9i8mV9l9jBr8YYrIaTfaZorw6ZSulJhimCBcdf5xRikxLCP6HecqOs6mTb523QY+pE3HyQCj/jCXc5ibnDS9ALue53p8V24BIeovmbL+X8DY1qO4FF4XvSoYU621gg12KauBKbeuXCEylLkw72hosKmDmd+TcW4R1cefMHsT7dsV9dTFBkk5ki6LvB+ikacQSdWvWF9sQmRRUg8Y06DTN1eya/5NqpfRuIPBwdTtZ1ux0cGRefW+ghr++1TNdBWQJtaFQfEiAn8RnAAAK/DcsVOc8fCGu0IrtJO3RllFxs4FnEyBOBgckw/1E4CNBRlXIG51dLgNVQxVscQLkpOldq1UrjxwdY18spd5errjrjbVtvd8kSh1JYXS38soc9okZ4Z6+Iy4OKSD9+FraKQ1Yy/GHPlPayIXNPwSHpJ+3HQ/QZwfZqgEuDd6PQ3yVgfWKtNheyViZFgfQss9e+rAZcekoBqYjFXoxnUMXNyfgMNzyrTrf0urHMUtKD+zU3V2DfasnE0kJoFi2DDbpqwZhXzPPFLAMViloeqId3RsaM5BmLNKKEK9NJ7NAfdOIY/CguzYjpnMjYNj+dNsfxZD8DqUvXOrV8GvIpK+VkRcxt05bitRSxBDvIdCszCGCDRZtrRrfwzFr/WIWgbjUxvWdb1dSrP1z9DF+sNGLSze72pMPGdqkfv9JfHv2btRh++tsmmqfUVhXrYMPdVbPAMkiSlyjSF24z0IAOfj2nt1l/2khSciD5NDNsRFrrmdJU9o9IiTtFAROLbprJxZic3i+18N/CNhob5dpFjDGpc9vRHTMVhZEUn0GgA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(346002)(136003)(39860400002)(36840700001)(46966006)(40470700004)(2906002)(5660300002)(36756003)(82310400005)(6666004)(1076003)(186003)(110136005)(8936002)(7416002)(6636002)(316002)(82740400003)(54906003)(41300700001)(2616005)(86362001)(40480700001)(426003)(81166007)(7696005)(83380400001)(70586007)(40460700003)(47076005)(336012)(36860700001)(26005)(8676002)(478600001)(356005)(70206006)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 06:05:10.3276
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25d30f1b-83e9-41b0-0596-08da5995530f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3527
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for PCIe controllers that operate in the endpoint mode
in tegra234 chipset.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* New patch in this series

 .../bindings/pci/nvidia,tegra194-pcie-ep.yaml | 141 +++++++++++++++++-
 1 file changed, 136 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
index 4f7cb7fe378e..11778eb92c47 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
@@ -17,6 +17,7 @@ description: |
   in they can work either in root port mode or endpoint mode but one at a time.
 
   On Tegra194, controllers C0, C4 and C5 support endpoint mode.
+  On Tegra234, controllers C5, C6, C7 and C10 support endpoint mode.
 
   Note: On Tegra194's P2972-0000 platform, only C5 controller can be enabled to operate in the
   endpoint mode because of the way the platform is designed.
@@ -25,6 +26,7 @@ properties:
   compatible:
     enum:
       - nvidia,tegra194-pcie-ep
+      - nvidia,tegra234-pcie-ep
 
   reg:
     items:
@@ -87,6 +89,8 @@ properties:
       name for the PCIe controller. Following are the specifiers for the different PCIe
       controllers:
 
+      Tegra194
+
         - TEGRA194_POWER_DOMAIN_PCIEX8B: C0
         - TEGRA194_POWER_DOMAIN_PCIEX1A: C1
         - TEGRA194_POWER_DOMAIN_PCIEX1A: C2
@@ -96,6 +100,22 @@ properties:
 
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
@@ -124,17 +144,30 @@ properties:
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
 
   nvidia,aspm-cmrt-us:
     description: Common Mode Restore Time for proper operation of ASPM to be specified in
@@ -154,9 +187,47 @@ properties:
       enable REFCLK to controller from host
     $ref: /schemas/types.yaml#/definitions/phandle-array
 
+  nvidia,enable-srns:
+    description: |
+      This boolean property needs to be present if the controller is configured
+      to operate in SRNS (Separate Reference Clocks with No Spread-Spectrum Clocking).
+      NOTE:- This is applicable only for Tegra234.
+
+    $ref: /schemas/types.yaml#/definitions/flag
+
 allOf:
   - $ref: "/schemas/pci/pci-ep.yaml#"
 
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
@@ -174,6 +245,7 @@ required:
   - power-domains
   - reset-gpios
   - num-lanes
+  - vddio-pex-ctl-supply
   - phys
   - phy-names
   - nvidia,bpmp
@@ -237,3 +309,62 @@ examples:
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
+            num-ib-windows = <2>;
+            num-ob-windows = <8>;
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

