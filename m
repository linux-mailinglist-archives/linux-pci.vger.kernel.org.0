Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3CB45731D7
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 11:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbiGMJB2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 05:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235919AbiGMJBS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 05:01:18 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2048.outbound.protection.outlook.com [40.107.244.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12222ECB8A;
        Wed, 13 Jul 2022 02:01:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bgy0yREln65Gd7QjTxixftFcbqm2kLrgSvY0lEUmvzeGlDA9Lpbf73Ov4AQCiJbdO3yAC+zoljr8AFeFRDvkwjLroNeNCX2dfJ0tTY0EpgplTA+k0Rqjj5hCthy8LjH3bDv8V330VWOaVQFpNy+3z0hSoAMiBwMP31sf8mN1R5hB9t9R1o4HxB3dXCcDINarwSpFHYcgM6WVm4UuezqOYn1Of0Fo40aVry6h1B47MdgQbobI0zqUaOA/3cs9q9me8kKQ1P8by2SfC8j/PHlL+Gjqzl0S7ttlC6HPqH8gp6GZIf1lS9sgkIzu0l/y7X4Tf4fLGblUhfPRpcqGrJNX7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pv4vGuhhxpjSULlnF4DLGWVJuLPKFxYxpHhJoBQMibM=;
 b=WwnG2b5mmULBXRIbh9LCfU14o50iC77D2Qf5sNIHKKmtvCgnOnQP5svnRPVH0OyhKTunbPQFXLRQTngEQk+aPjQi1V/eokzrPUOeYlBVIp8zPg1vAJiRW1jZUjg6A31nqt+AaA9KZZAZ1fLghXvcNFAzuCHsqrF0seSRrKlktJGb6x42Wse5JD1hdwNo1/1PYSXn5zEmmYApCopYM/hQTRuJ51KNlHefJEsLwyXwWBNCxzVlQH2gO/HxSZA9cVJGA5zZqq4a2ETjXLEaBS7W3ebLzEG8OPc0Osm2l0Gdz1GXF9nwuHUe1BPrJNFd69uBr6h0bFWXXYgxnz0ZVzn+dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pv4vGuhhxpjSULlnF4DLGWVJuLPKFxYxpHhJoBQMibM=;
 b=Zx8yyu1rABpJF9DAqaXFL0c16jocEysDOj6DO6JF98jSRC0svkZoq0e67JSnWIQgaCeHG/gBM+5Mi4ltx79EjJKNkDAlgkIFrKb6B+V8ZkkWEzZwkWO0+mJosE70LbPrR0ITh6q4xAXyWQuZrNAgxIPBPjVFeU+1jinEt/i6GZjJTuiEfo2pRVlALNchqf7yr8ZMMGc0GUuvtGpRm5JYj7yDmUw1BvpQ6VNpAEo6lnX8ijFSEO3BcfXNIJ2mHWrXi2TzIzCi/XzXXWtBu2xjhV3blA0655gvD7Q54dIFwh6MSqc+m9llLr7AvSQ+SXrnKArcl5FGwVg0d6pjx6OXng==
Received: from MW4P221CA0028.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::33)
 by BL3PR12MB6641.namprd12.prod.outlook.com (2603:10b6:208:38d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.26; Wed, 13 Jul
 2022 09:01:14 +0000
Received: from CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::7c) by MW4P221CA0028.outlook.office365.com
 (2603:10b6:303:8b::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Wed, 13 Jul 2022 09:01:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT038.mail.protection.outlook.com (10.13.174.231) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 09:01:13 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 13 Jul
 2022 09:00:56 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 13 Jul
 2022 02:00:55 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Wed, 13 Jul 2022 02:00:51 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lpieralisi@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <kw@linux.com>, <kishon@ti.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V5 3/9] dt-bindings: PCI: tegra234: Add schema for tegra234 endpoint mode
Date:   Wed, 13 Jul 2022 14:30:23 +0530
Message-ID: <20220713090029.30395-4-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220713090029.30395-1-vidyas@nvidia.com>
References: <20220713090029.30395-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dc2a15ef-b83c-44a7-4031-08da64ae3d34
X-MS-TrafficTypeDiagnostic: BL3PR12MB6641:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Y7/BDc0En/04dza+6m6H4+yPIgAVU1NFE6mtMfTOzBPQX+VWp25+t+LSwRg3RQVmZM6ZzEGBTr0V1qoOeRpOyG6tWaXNcQJ6NBQg9EVEgOspHdduBdHVH4WIKM7NOId881Q1DIr/zAK5Mg98hWpru7Y+5jt5cJmVgWZ4IAaZT6rKuw1KS8pkiQ8pYsk5FG1OHC+1lfuAZZiVbMRgh7Zxuk5TL7AX8vMXWxRALlGaOzacd579gcTrwWbE+AX4W0BgaWuoE7brE2+fiS2LLISwIwf/4yRgnA2EWjr4GlTHHhy+CCbTEjt2u0LIE36EIQ+vKUEf1AJkPT5Vjvoz6knqfGuBM/cRenP8+Der/r9lfyLlRwVQ0/6bsJJ/WLIjCKw4Ll2kibYvs7nNLVzy2cSdOf58pD+FuyYgxSg5WbJOZ0Ys9i1wMv0fxsAUIpsCGAs5F7y7ALUVMaFDs2fbDzvf7SbMBMcfunXXZHb++p9v7shB2Sswo9bwuT6vEAOwL06+Ld/iy+Sn/gD/0iQbIt1KJBFUHDhPTOleoqeu6VKL6r72anGVBclXj5UZvfSU/5q59e4umwg0pzZIJXHyqtRNb3rpMQSWNKRuiM0TbYlmDWNb6HaqySuF2xmLwPItb4stGs89vXco6JLvAI1h2O3s6NEYdFHv7AyeX1AELeoiUo2RwuthAIpgSS2h0Sjm9Ul9BFsOtCQ+A356OkgmlrqFSiZu/8YkllCzRNEgFTGLztDt8sE2/Bg7Usx+JYvbc6B/SyMt6Jmha2XUDqJj5x++HNVoSeACTBBcFiVADtKhjEj91U40yS0H3oHBP0QZT3UQndopUnfqoJupFd7xqy2tiHeGVHbz4kGxytiVUN7wjlUnazEMiPb+nUqpXW3TIFa6
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(376002)(346002)(136003)(46966006)(40470700004)(36840700001)(47076005)(1076003)(336012)(426003)(110136005)(186003)(8676002)(40480700001)(6666004)(70206006)(8936002)(26005)(70586007)(54906003)(36756003)(4326008)(2616005)(83380400001)(7696005)(86362001)(478600001)(2906002)(40460700003)(316002)(82310400005)(36860700001)(41300700001)(5660300002)(7416002)(81166007)(82740400003)(356005)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 09:01:13.9174
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc2a15ef-b83c-44a7-4031-08da64ae3d34
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT038.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6641
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
V5:
* Addressed review comments from Rob

V4:
* Rebased on top of previous patch

V3:
* New patch in this series

 .../bindings/pci/nvidia,tegra194-pcie-ep.yaml | 97 ++++++++++++++++++-
 1 file changed, 95 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
index 89402b43d9b5..cee11c576295 100644
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
@@ -116,17 +119,34 @@ properties:
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
 
   nvidia,aspm-cmrt-us:
     description: Common Mode Restore Time for proper operation of ASPM to be
@@ -146,6 +166,22 @@ properties:
     maxItems: 1
     description: GPIO used to enable REFCLK to controller from the host
 
+  nvidia,enable-ext-refclk:
+    description: |
+      This boolean property needs to be present if the controller is configured
+      to receive Reference Clock from the host.
+      NOTE:- This is applicable only for Tegra234.
+
+    $ref: /schemas/types.yaml#/definitions/flag
+
+  nvidia,enable-srns:
+    description: |
+      This boolean property needs to be present if the controller is configured
+      to operate in SRNS (Separate Reference Clocks with No Spread-Spectrum Clocking).
+      NOTE:- This is applicable only for Tegra234.
+
+    $ref: /schemas/types.yaml#/definitions/flag
+
 allOf:
   - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
 
@@ -223,3 +259,60 @@ examples:
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
2.34.1

