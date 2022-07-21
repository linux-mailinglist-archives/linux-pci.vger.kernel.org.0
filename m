Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD3B57CD49
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 16:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231328AbiGUOVr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 10:21:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiGUOVo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 10:21:44 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E808B820F5;
        Thu, 21 Jul 2022 07:21:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZOhq6B+tSqMPrujZuVzFzA2ETqmKVvJpVGAY+LNIhbAjDHgzQ2482NASn7r8PTOv7yo36qKOI1SWBifMJDb6eSDEky3EdDEmT1RuM1HnGFkGy7j5D15xsPBFdKrjNE587qkyXuYnUG60yEGk5DdqvxUQLKff8dAJxUnFOmSOuTwYeqMwBTqh+53bqXHRqBvo27aUsS5Dq3u4CtvekJ/rdCHU4Y3cNjT5I6ykcRHQ5J9WffxSsgA+7qu0poC5OYvreA2Tigva+WIBQmfbbhcvElDwlS3QPCDDR5//q1HH2NHEaWJet4E4f0BDvr5NlfRD17DJQRY95XeF0PvFMc6HFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=26TVej4mCdYaqU+a0n7lZWzbwma3caFMCx5yEvSjeMk=;
 b=OBAbEsX7l71pp1uLWO4fLf2axnQ6jt/OdNw9ECTBK45dxp+vZQgOz3SKz41Z8CEUI99JwLmMCjsPae8VbuaLQtUdRFmbbTMplzyn6jUOov1tDAXYfa8Vn5xQObc8Q7dyof6TzH9H5PFbW8rgUEMOXIZpEoFxT1fjNx/r49Sou7g345v3KSuqtK4iD90wcqovO9Zt2SXO1XNRBlGQDV9y6HOgXjowGpJrXVaKrfS2WZ7LupfLxFOiqM6JNUe/GJ18c19EtcthnDCHbSQ34lyT5Gm/imdQyu4T0AjzkRp1alEMD5IEswpYGRHj/kTs3iz8m16GHNpLUuc17klONx2pqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=26TVej4mCdYaqU+a0n7lZWzbwma3caFMCx5yEvSjeMk=;
 b=gqwb/3G8P+6Xr4Pe9Icnltybq2EgMyFBZ5kGW5e+svDi543zF8i6/SwPW7R878cvvyUuDoweALoBWw9MQ8MQsFa60UkkqQww10MzX9zT9jYRolNe1FsnLk3jmXznS/4+AhIl3yezVJ/oGeoUcRZidXLdLXZJ2QWFhPbUeET2VM2uI0AGzGoF8G3FBiXLBNCmFrF8/U4wpzOMc1BSTKRsw1Y00VdNEFpzwL1ojM2CIcF9QCR+h6GxrkCP55+s/9OyorFl3iplIqpbkalXGhbBm03TeFvtgK1zra78Y04RLU5KOBtP/g9FAwGRKuBhGrsOLLPt2xMLUyaSovvRv70xaQ==
Received: from MW2PR16CA0024.namprd16.prod.outlook.com (2603:10b6:907::37) by
 MN2PR12MB3181.namprd12.prod.outlook.com (2603:10b6:208:ae::27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.18; Thu, 21 Jul 2022 14:21:32 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:0:cafe::f0) by MW2PR16CA0024.outlook.office365.com
 (2603:10b6:907::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19 via Frontend
 Transport; Thu, 21 Jul 2022 14:21:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 14:21:32 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL107.nvidia.com (10.27.9.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 21 Jul 2022 14:21:31 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Thu, 21 Jul 2022 07:21:31 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 21 Jul 2022 07:21:26 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lpieralisi@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <kw@linux.com>, <kishon@ti.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V6 03/16] dt-bindings: PCI: tegra234: Add schema for tegra234 endpoint mode
Date:   Thu, 21 Jul 2022 19:50:39 +0530
Message-ID: <20220721142052.25971-4-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220721142052.25971-1-vidyas@nvidia.com>
References: <20220721142052.25971-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ff78528b-0b25-4337-1821-08da6b244f6c
X-MS-TrafficTypeDiagnostic: MN2PR12MB3181:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 50/XK7GsYfQm4E8Rb8sVoEkunf9nKWO9JbuaTMT6R9+2j9j1+mQCHc6FhtE5mVIy0DFLXle+/iD3kPpzc6Pp/CT+mZSG0rLXYpMoZhXOKi/0RTpHzTtpjzwqOGmGf6Ru6YgvPe/mm/nZop/VqC1ljIofnbFn7vNDu2tY2E+8F+6wge80ccy6fdIEq1MzlpCYGlTfgaav5tL6w3+qpyEpik5yq4h7rggT6wkU9+5umi2TQovfTb8BpCuzgRSUvtAjxliCcLjkoKjA+zf5IGqSNEhUdF5QZw/+vTGeVcfm/qNhd87yrrZ8YWegEkbiXUrZTlkWYzvnzcPZy4pyap2eloR+bgQl/IALD0oeojIQ3scaMETCRA2tCPeh7liKTeaVs4QEg/cfADProB41W8wbLz95lYx0luStll537NpqldmB0LV9NzcyDYXOPciGMpt5PIlmkGVkJtlwGX2h0uYtmmDUraytyOV6A8CgcSqDY7mLbbBCN7biWGwwa8KzU4evfC4LTHiUM/6czK0CAY6wEUuNDywiF3q0TH/JUhOxK5FqzvlamL0H/MwhAhrOzA10rXALM5smBLgRX/9jl4S6XL6Ud04WAwhvVi/sV9lIxG8yNZ/JzSW+oNsUWiwPl2XIZjV+V0/pKu3ipkkxvSFnwqjxUbrcrjcw0hHmiKInnQV3aL/u3kPSZZ0bt9QTs+RMmdLrCOnwk25dFhQgIQy37fO75BY73QOb5Y+d1uFb2aymJQXSiL8HvCGFytua9EgBGalyan2e4uVzjWDfdZLl0mC+ooE5lW+cWuk89vYaoXuf0TMJePGQYDoS8Cg4sJ3C/EAuBxMKLuRhPWc+4b9lXX29zegdMi8zFjLJ+V7KJQs=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(346002)(136003)(36840700001)(40470700004)(46966006)(70586007)(36756003)(2616005)(426003)(83380400001)(47076005)(336012)(82310400005)(316002)(186003)(356005)(8676002)(36860700001)(8936002)(5660300002)(40460700003)(1076003)(54906003)(70206006)(4326008)(478600001)(41300700001)(7416002)(7696005)(110136005)(6666004)(2906002)(26005)(86362001)(40480700001)(81166007)(82740400003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 14:21:32.0575
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff78528b-0b25-4337-1821-08da6b244f6c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3181
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for PCIe controllers that operate in the endpoint mode
in tegra234 chipset.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
V6:
* Added 'Reviewed-by: Rob Herring <robh@kernel.org>'

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
2.17.1

