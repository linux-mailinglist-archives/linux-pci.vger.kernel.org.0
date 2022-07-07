Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC744569CFF
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 10:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbiGGINq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 04:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbiGGIN2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 04:13:28 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA6C310D2;
        Thu,  7 Jul 2022 01:13:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LeuYKww/1dS3U7I9YZVu+BEGrGvVexT9DZA54z7aaYJU3f2tG6YgsOqXTvrtQgHVOsg+zhGri0QQECt8anWNfiYylvBxFIq6V4ZSsEUHTCQyeUu6gD1UtJ04WwvwtIES+6vzqP6/0eoxJSYF84RcYtck2qsuXzU/c+ahdKQUNFGk5yP2hIQFzGNg86NP/t1nk12P0nfHsMeawL+izUJy2KFHUXK7WuD2KAxTL8fwY2GwYkgC2uMEbrg5gQzAIxIqixkGT6CiFRSdKYHm1UqebIWV6hhXDxwGm2cA5akVid6D3gvGEl2aRuwsJKJ5tG1nmBt7fIvAmsBhb4yx9ONGKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZmQ7YlctGvCUkVALqb+lmt/kDE9s1gpwdwweXASrRU=;
 b=EBw/4sf4U6LF8gaG7mWgDdvBkrD4hMbTHtzh/xMTi7niEHn6Du0QRGZ2F8+JyVqsYjz4gzLPgBvzkrfnLlOfG40Km0XNjshjDuDeiYDALJRlMTSo5TgxOprtMRBDu1K1Z63liF6+b6bwYibcpt1Ao3KtMFZgfUPH9cNGeScHKsMs5OwlTiScYdGVAS9q/owfhxg5v+SqNJ9bYajc9dkBR+DuNES9pJ5JlcTkJqA4XVpqkAtkat64JEI21H0eQK8037Serja1AUrJW9HyXtLUi0sV0dSkTdF/g2SFAPa9XYA2kjLSwSxIJYE6yQb/ksgFq3NjF17GvQwP1etaBK/tPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZmQ7YlctGvCUkVALqb+lmt/kDE9s1gpwdwweXASrRU=;
 b=sHaFrwjPFAUE51v0jhtZ1HvsVLAoNsW9NqM/iOAU6nG6WuhNUDajv/Xyu/KU4xu9Ykv9ybPXUpmFsMlSAfBCRGHdYEROG5ZevuR6vGXvku4Yb2WIDEmvJ0NieImAJB9FE3SwHLxhXqQXxWC4LM8kj53UxtwO74SHn34rawy8QtRftWsI8faHLJP0qpMimX6OuXbH2UnMwuKfVYKUQ+NzxqfG9qw0SM5fA4bDxddMAhY/5eoBq5CqOTvxfX0aPCsp27KTwqaydk+z/q0kYztiVIvQvprAe1S/Sm/aywc2omt2pRv9qdkO8WeuVxWnirOQ8C67ov0ww6SaCHKA+hj4VQ==
Received: from MWHPR21CA0063.namprd21.prod.outlook.com (2603:10b6:300:db::25)
 by BN8PR12MB3042.namprd12.prod.outlook.com (2603:10b6:408:63::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.21; Thu, 7 Jul
 2022 08:13:24 +0000
Received: from CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:db:cafe::65) by MWHPR21CA0063.outlook.office365.com
 (2603:10b6:300:db::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.4 via Frontend
 Transport; Thu, 7 Jul 2022 08:13:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 CO1NAM11FT040.mail.protection.outlook.com (10.13.174.140) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 08:13:24 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 7 Jul
 2022 08:13:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 7 Jul 2022
 01:13:23 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 7 Jul 2022 01:13:18 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lpieralisi@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <kw@linux.com>, <kishon@ti.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V4 2/9] dt-bindings: PCI: tegra234: Add schema for tegra234 rootport mode
Date:   Thu, 7 Jul 2022 13:42:54 +0530
Message-ID: <20220707081301.29961-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220707081301.29961-1-vidyas@nvidia.com>
References: <20220707081301.29961-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d0f9861-c07d-4857-1b79-08da5ff09026
X-MS-TrafficTypeDiagnostic: BN8PR12MB3042:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C1SD9Kk1KNczowrmDg+88VTzkm1nVLibBIpdUYhL3T0VFqIeYSl+aYNHz3oCNRS/yQMu1v9d+KHH8MphQ9FAjAVxfFfTdBOArmnM4LSJzft4cBej9r7teVcv1ZhUPa3mRYVvYh55Blc909BnFA8fitPAXY77Ov9JNHviEtZ4Ku0nlFXh5THLj1bOlNfxvP1/pzgv4L8YvZeuwkluLIaO2FYbKlBjRP3V6RaHuKllV8djEnQxmiZdvkJheunsRvVP8Ym1ZzMV1mdwITDgeCkvjzK+4Lx+wwClWgvGfQEkOwH3xZ6DHDCumjZZ0ErvRT9/VVBOo4W3FyYetrQqxDlEVXq3strE35mORQidE7SfrHYWMv2yo+e8zq/xBiI5EfxcDJPhWQuVCf9ygpJecVWWleaXg94SivsVnY/wRTMd7NfeVc/Z9FWFE93TsCr0pRCXdtjRZlhAX1SgGrpJt6HljY4qKj/zxLR8KQO+qkTErb6CjsusBcOhYNu2qISMI+g14B6EjxkPFw1/1XdZbFRpHwRYBF0ETWFarGdUOtN53YOx/MDkJrV2oHuI5okF75+0QxSU48uPDhAStRSS1tDtsGyiJTVQj0D75n8uKnSzrEjn+XcWzd+WhS3FeQTFhp3WioaW0OmtwSIn87mtwqXVSBpqXIHQBsRHPy51IwXFYDv1+TdhsthrCP2IWK+kHLYNL7VsLLQUIIuHsCoKSn59S+8AMxvzI6+IrKR+84EOGD8Og6FFAtWZpxz8z2Q4gRdtRYRSmYFjR2GoWRqTSjsRrNQkbDuBqv66pbqVaYIsdcV9DYsE4iczVmzjRe5kw+f/nW/Ks+MDfA6fxxHuf8DXsTiMN8ARESR06+JTdLIi1tfswjOI+YKOHPSrzZ9YcM8u
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(376002)(396003)(39860400002)(46966006)(36840700001)(40470700004)(41300700001)(2906002)(356005)(40460700003)(40480700001)(5660300002)(336012)(7416002)(36756003)(8936002)(36860700001)(83380400001)(8676002)(82310400005)(478600001)(4326008)(54906003)(186003)(82740400003)(47076005)(86362001)(426003)(110136005)(316002)(6666004)(70586007)(7696005)(2616005)(81166007)(1076003)(70206006)(26005)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 08:13:24.0459
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0f9861-c07d-4857-1b79-08da5ff09026
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3042
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for PCIe controllers that operate in the rootport mode
in tegra234 chipset.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V4:
* Rebased on top of previous patch

V3:
* New patch in this series

 .../bindings/pci/nvidia,tegra194-pcie.yaml    | 136 +++++++++++++++++-
 1 file changed, 130 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
index 5d7cb56c86a2..c0dfe2e01112 100644
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
@@ -112,17 +114,30 @@ properties:
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
 
   nvidia,update-fc-fixup:
     description: |
@@ -131,6 +146,8 @@ properties:
       of the following conditions thereby enabling root port to exchange
       optimum number of FC (Flow Control) credits with downstream devices:
 
+      NOTE:- This is applicable only for Tegra194.
+
         1. If C0/C4/C5 run at x1/x2 link widths (irrespective of speed and MPS)
         2. If C0/C1/C2/C3/C4/C5 operate at their respective max link widths and
           a) speed is Gen-2 and MPS is 256B
@@ -162,10 +179,56 @@ properties:
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
   - $ref: /schemas/pci/pci-bus.yaml#
   - $ref: /schemas/pci/snps,dw-pcie.yaml#
 
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
@@ -255,3 +318,64 @@ examples:
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

