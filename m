Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5D457CD46
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 16:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiGUOVa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 10:21:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230325AbiGUOV0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 10:21:26 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587987BE1D;
        Thu, 21 Jul 2022 07:21:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dJWFswS2Hy8MLJSGt0WwjU0XCgVocZXTw4KPFzHIxLJxX4F6jh844EyckYeNxEfV19eOQPdqkA/DUnaIV//9pXYjCdPU/2YQh37uZW6rjX4+CL/HukNFO1N8gfdiSjiOmZJITNblLx3VURwgVMIooirLoldgi68bgh9t7OpvY73E/o0ZrZImZnWSTeotAWqN+q1uMUnZdKiUl2fqavHw6Q6avpFwRHGG68OHUxbyiJOWtWc5plFQnWdg3JYQWDrvb4AWC9MQgwUto1VADzpziWX1W1mawVD7KWInJI1WCEXtv5zo0XrseSJMPKSacmh/YdB0tkD1NjEBZLVyfgw5oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Aj0rpDC3Q5O7ZMsOSKbNu0+VlX0LGmCAI99r3vgsJ4=;
 b=eOBz7olSzzG+tk6jDqhZAuS806XYDYouEDc6XYgQa6MI2gT8gFQOz6UUDFBLrwVaL6nQfVzp/KWhEPimei7h9suweBsGK9+IAt0khF6Gsmx9NcVbMIGCp8jWZ2h5qYodSC7qkUwdgeKVoXjpTp+xnss44mzuG/fex3njBS5k113ZfwixIPXfiwznvHUEvFGFYv0MQ+aXWX2fW52VVWM5kH64QwBcP6wA0UT1q3Ox2XLkiOlINic+RJX2RlIUSLBcenNKp72coSjvEmdlavogI3QK8JNRlSGcEzGXfE5CDkYSEib/tBkVivvG3leyy2S0dYN1oSrb6LDZoygC8yPWBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Aj0rpDC3Q5O7ZMsOSKbNu0+VlX0LGmCAI99r3vgsJ4=;
 b=kUc/4Qk294RgIftQrLS1jn/Ycp2HEHpP1eKK6woJiPlL+GA+PJUad3Sx02th4rZ+gkf1dX18qhI08lgewfEEu6+xlIq0z3S+xf4wyFOEayzeTR6E//W51NN5YJsuZRmxlt33MWMkODiSLEelLfzHAkh4Doc5fmJD+fvFc0gS5tiSLcNGCrwSTGqEOzUhrf1NvbmmJxGx3c+5n/ImgFR9gQfjb3IuVXWJPwdiDSOzE4Y03UkYcx83pnPC4tLtrP0P0iEvJQI8W/9NRTaPOHsrGc2CWJcRvP63pCFaI2XbZV5M/UhZ5y10Jz48z4K0DGt0Ay2OIImvUndk+GJRaKnPTQ==
Received: from MW4P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:303:115::20)
 by CY4PR12MB1798.namprd12.prod.outlook.com (2603:10b6:903:11a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.20; Thu, 21 Jul
 2022 14:21:20 +0000
Received: from CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:115:cafe::81) by MW4P220CA0015.outlook.office365.com
 (2603:10b6:303:115::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23 via Frontend
 Transport; Thu, 21 Jul 2022 14:21:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT037.mail.protection.outlook.com (10.13.174.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 14:21:20 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 21 Jul 2022 14:21:20 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Thu, 21 Jul 2022 07:21:19 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 21 Jul 2022 07:21:14 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lpieralisi@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <kw@linux.com>, <kishon@ti.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>, "Thierry Reding" <treding@nvidia.com>
Subject: [PATCH V6 01/16] dt-bindings: pci: tegra: Convert to json-schema
Date:   Thu, 21 Jul 2022 19:50:37 +0530
Message-ID: <20220721142052.25971-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220721142052.25971-1-vidyas@nvidia.com>
References: <20220721142052.25971-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9525cfa9-6da2-41d3-35c7-08da6b244883
X-MS-TrafficTypeDiagnostic: CY4PR12MB1798:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fphnC6rZd9qbLTgOMcoLdHZSHJvKDuGAWrTuoEgitNAEIjH59f3Vg9XZHXID?=
 =?us-ascii?Q?pD0UDeh6BGivnOeG4cM+bXjffFvluudRbA19Ddgx0Lwj+mYBiLy2IeUcCixA?=
 =?us-ascii?Q?V8hULL4EzObBnmawcoa+WT4YsIZkWqwVpiiNcwxLSy9JmBxuZ6sJqNeh51Hr?=
 =?us-ascii?Q?83aewBp7wRerlSEZ8SM9V0ZgeOx/lzLgzH+bZSu6yEpm++nqJ/wUy0v4xbvr?=
 =?us-ascii?Q?n6stgigwq8/IUdMNpYH+OGML3idzdpD1PlDMF3lg0Oel6BwMNtTcjqYBB176?=
 =?us-ascii?Q?KR1ED8cqbaMlu1A5d6nCALmXx/QwMD4vP6Y9Ua1KKVfMArArKGoQOvi1zad4?=
 =?us-ascii?Q?RqkzlEcd13stY+l4xkVD/dbRzJPK1RgzSkoJXVQUUiqMZBoLv6TqhGrSSm/v?=
 =?us-ascii?Q?Poho/YpbMCGjuIEh1xj7GBSDbfCzZvT5YzMQ6NY0MAQU7bU1UoYHicfdJUVn?=
 =?us-ascii?Q?OLYS2ParGOw8ymv+m1SUFgss5wuC3gsm6jazKh3wSY9lkv9KJiLQ10twRlRQ?=
 =?us-ascii?Q?DlyBADfOzq/hmS5JUib52dsc3nUdsaFANydgyVfQMbGtkTELMJh9JE3iNC+q?=
 =?us-ascii?Q?yD4VZvJEq1ZQTizCj2MQkJPB/JNsE9d67LKssP3+7Dm/1j4aZ7mcgDZN8VwQ?=
 =?us-ascii?Q?kqInMkeOh9DBrbndhYSm4cuYtD/6wqvKJQFo1IC5p0maWU9TBAAgUDIF0ccD?=
 =?us-ascii?Q?1BQk7+4rMTwjog3MOWA019LpvRhtXVJdtKYHjq4OFbvLpSFWE4DI0jhYmuBy?=
 =?us-ascii?Q?ZyrKpz/itSZ5xwSPY7JYmruAKUuMdiCCpqVRHnG/hG0QWHOnnawCAXPVvpui?=
 =?us-ascii?Q?wRXouPpitEDQZyVKqlQeYhXuOdtHyr2qnCQdhGRjQ9VZyKxRiJZ+mpJr3HjU?=
 =?us-ascii?Q?BTvypFNKkmEU+woqTXO+07HOFK4rcZ4vGgbu13Iqcqu0jEylVc6j3FOdPhEp?=
 =?us-ascii?Q?KtJLiP5GGO3+qOA3AEagsrnrf3tFlVEYu9IW4iZtmC8=3D?=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(346002)(136003)(396003)(40470700004)(36840700001)(46966006)(1076003)(82310400005)(82740400003)(83380400001)(2906002)(7416002)(86362001)(30864003)(36860700001)(26005)(81166007)(47076005)(186003)(356005)(107886003)(336012)(70586007)(966005)(8676002)(316002)(54906003)(70206006)(2616005)(40460700003)(36756003)(6666004)(110136005)(8936002)(5660300002)(426003)(40480700001)(478600001)(4326008)(7696005)(41300700001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 14:21:20.4649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9525cfa9-6da2-41d3-35c7-08da6b244883
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT037.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1798
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert the Tegra194 PCIe bindings from the free-form text format to
json-schema.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
V6:
* None

V5:
* Addressed review comments from Rob
* Added 'Reviewed-by: Rob Herring <robh@kernel.org>'

V4:
* Addressed review comments from Krzysztof and Rob

V3:
* New patch in this series. Added as part of addressing Rob's review
  comment to convert the existing .txt file to .yaml schema

 .../bindings/pci/nvidia,tegra194-pcie-ep.yaml | 225 ++++++++++++++++
 .../bindings/pci/nvidia,tegra194-pcie.txt     | 245 -----------------
 .../bindings/pci/nvidia,tegra194-pcie.yaml    | 251 ++++++++++++++++++
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   4 +-
 4 files changed, 478 insertions(+), 247 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
new file mode 100644
index 000000000000..89402b43d9b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
@@ -0,0 +1,225 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/nvidia,tegra194-pcie-ep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra194 (and later) PCIe endpoint controller (Synopsys DesignWare Core based)
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Vidya Sagar <vidyas@nvidia.com>
+
+description: |
+  This PCIe controller is based on the Synopsis Designware PCIe IP and thus
+  inherits all the common properties defined in snps,dw-pcie-ep.yaml.
+  Some of the controller instances are dual mode where in they can work either
+  in root port mode or endpoint mode but one at a time.
+
+  On Tegra194, controllers C0, C4 and C5 support endpoint mode.
+
+  Note: On Tegra194's P2972-0000 platform, only C5 controller can be enabled to
+  operate in the endpoint mode because of the way the platform is designed.
+
+properties:
+  compatible:
+    enum:
+      - nvidia,tegra194-pcie-ep
+
+  reg:
+    items:
+      - description: controller's application logic registers
+      - description: iATU and DMA registers. This is where the iATU (internal
+          Address Translation Unit) registers of the PCIe core are made
+          available for software access.
+      - description: The aperture where the root port's own configuration
+          registers are available.
+      - description: Aperture used to map the remote root-complex' address space.
+
+  reg-names:
+    items:
+      - const: appl
+      - const: atu_dma
+      - const: dbi
+      - const: addr_space
+
+  interrupts:
+    items:
+      - description: controller interrupt
+
+  interrupt-names:
+    items:
+      - const: intr
+
+  clocks:
+    items:
+      - description: module clock
+
+  clock-names:
+    items:
+      - const: core
+
+  resets:
+    items:
+      - description: APB bus interface reset
+      - description: module reset
+
+  reset-names:
+    items:
+      - const: apb
+      - const: core
+
+  reset-gpios:
+    description: Must contain a phandle to a GPIO controller followed by GPIO
+      that is being used as PERST input signal. Please refer to pci.txt document.
+
+  phys:
+    minItems: 1
+    maxItems: 8
+
+  phy-names:
+    minItems: 1
+    items:
+      - const: p2u-0
+      - const: p2u-1
+      - const: p2u-2
+      - const: p2u-3
+      - const: p2u-4
+      - const: p2u-5
+      - const: p2u-6
+      - const: p2u-7
+
+  power-domains:
+    maxItems: 1
+    description: |
+      A phandle to the node that controls power to the respective PCIe
+      controller and a specifier name for the PCIe controller.
+
+      specifiers are defined in "include/dt-bindings/power/tegra194-powergate.h" file.
+
+  interconnects:
+    items:
+      - description: memory read client
+      - description: memory write client
+
+  interconnect-names:
+    items:
+      - const: dma-mem # read
+      - const: write
+
+  dma-coherent: true
+
+  nvidia,bpmp:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: |
+      Must contain a pair of phandle to BPMP controller node followed by
+      controller ID. Following are the controller IDs for each controller:
+
+        0: C0
+        1: C1
+        2: C2
+        3: C3
+        4: C4
+        5: C5
+    items:
+      - items:
+          - description: phandle to BPMP controller node
+          - description: PCIe controller ID
+            maximum: 5
+
+  nvidia,aspm-cmrt-us:
+    description: Common Mode Restore Time for proper operation of ASPM to be
+      specified in microseconds
+
+  nvidia,aspm-pwr-on-t-us:
+    description: Power On time for proper operation of ASPM to be specified in
+      microseconds
+
+  nvidia,aspm-l0s-entrance-latency-us:
+    description: ASPM L0s entrance latency to be specified in microseconds
+
+  vddio-pex-ctl-supply:
+    description: A phandle to the regulator supply for PCIe side band signals.
+
+  nvidia,refclk-select-gpios:
+    maxItems: 1
+    description: GPIO used to enable REFCLK to controller from the host
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
+
+unevaluatedProperties: false
+
+required:
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - power-domains
+  - reset-gpios
+  - vddio-pex-ctl-supply
+  - num-lanes
+  - phys
+  - phy-names
+  - nvidia,bpmp
+
+examples:
+  - |
+    #include <dt-bindings/clock/tegra194-clock.h>
+    #include <dt-bindings/gpio/tegra194-gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/tegra194-powergate.h>
+    #include <dt-bindings/reset/tegra194-reset.h>
+
+    bus@0 {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        ranges = <0x0 0x0 0x0 0x8 0x0>;
+
+        pcie-ep@141a0000 {
+            compatible = "nvidia,tegra194-pcie-ep";
+            reg = <0x00 0x141a0000 0x0 0x00020000>, /* appl registers (128K)      */
+                  <0x00 0x3a040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
+                  <0x00 0x3a080000 0x0 0x00040000>, /* DBI reg space (256K)       */
+                  <0x1c 0x00000000 0x4 0x00000000>; /* Address Space (16G)        */
+            reg-names = "appl", "atu_dma", "dbi", "addr_space";
+            interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+            interrupt-names = "intr";
+
+            clocks = <&bpmp TEGRA194_CLK_PEX1_CORE_5>;
+            clock-names = "core";
+
+            resets = <&bpmp TEGRA194_RESET_PEX1_CORE_5_APB>,
+                     <&bpmp TEGRA194_RESET_PEX1_CORE_5>;
+            reset-names = "apb", "core";
+
+            power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8A>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&clkreq_c5_bi_dir_state>;
+
+            nvidia,bpmp = <&bpmp 5>;
+
+            nvidia,aspm-cmrt-us = <60>;
+            nvidia,aspm-pwr-on-t-us = <20>;
+            nvidia,aspm-l0s-entrance-latency-us = <3>;
+
+            vddio-pex-ctl-supply = <&vdd_1v8ao>;
+
+            reset-gpios = <&gpio TEGRA194_MAIN_GPIO(GG, 1) GPIO_ACTIVE_LOW>;
+
+            nvidia,refclk-select-gpios = <&gpio_aon TEGRA194_AON_GPIO(AA, 5)
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
diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
deleted file mode 100644
index 8e4f9bfb316d..000000000000
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
+++ /dev/null
@@ -1,245 +0,0 @@
-NVIDIA Tegra PCIe controller (Synopsys DesignWare Core based)
-
-This PCIe controller is based on the Synopsis Designware PCIe IP
-and thus inherits all the common properties defined in snps,dw-pcie.yaml and
-snps,dw-pcie-ep.yaml.
-Some of the controller instances are dual mode where in they can work either
-in root port mode or endpoint mode but one at a time.
-
-Required properties:
-- power-domains: A phandle to the node that controls power to the respective
-  PCIe controller and a specifier name for the PCIe controller. Following are
-  the specifiers for the different PCIe controllers
-    TEGRA194_POWER_DOMAIN_PCIEX8B: C0
-    TEGRA194_POWER_DOMAIN_PCIEX1A: C1
-    TEGRA194_POWER_DOMAIN_PCIEX1A: C2
-    TEGRA194_POWER_DOMAIN_PCIEX1A: C3
-    TEGRA194_POWER_DOMAIN_PCIEX4A: C4
-    TEGRA194_POWER_DOMAIN_PCIEX8A: C5
-  these specifiers are defined in
-  "include/dt-bindings/power/tegra194-powergate.h" file.
-- reg: A list of physical base address and length pairs for each set of
-  controller registers. Must contain an entry for each entry in the reg-names
-  property.
-- reg-names: Must include the following entries:
-  "appl": Controller's application logic registers
-  "config": As per the definition in snps,dw-pcie.yaml
-  "atu_dma": iATU and DMA registers. This is where the iATU (internal Address
-             Translation Unit) registers of the PCIe core are made available
-             for SW access.
-  "dbi": The aperture where root port's own configuration registers are
-         available
-- interrupts: A list of interrupt outputs of the controller. Must contain an
-  entry for each entry in the interrupt-names property.
-- interrupt-names: Must include the following entries:
-  "intr": The Tegra interrupt that is asserted for controller interrupts
-- clocks: Must contain an entry for each entry in clock-names.
-  See ../clocks/clock-bindings.txt for details.
-- clock-names: Must include the following entries:
-  - core
-- resets: Must contain an entry for each entry in reset-names.
-  See ../reset/reset.txt for details.
-- reset-names: Must include the following entries:
-  - apb
-  - core
-- phys: Must contain a phandle to P2U PHY for each entry in phy-names.
-- phy-names: Must include an entry for each active lane.
-  "p2u-N": where N ranges from 0 to one less than the total number of lanes
-- nvidia,bpmp: Must contain a pair of phandle to BPMP controller node followed
-  by controller-id. Following are the controller ids for each controller.
-    0: C0
-    1: C1
-    2: C2
-    3: C3
-    4: C4
-    5: C5
-- vddio-pex-ctl-supply: Regulator supply for PCIe side band signals
-
-RC mode:
-- compatible: Tegra19x must contain  "nvidia,tegra194-pcie"
-- device_type: Must be "pci" for RC mode
-- interrupt-names: Must include the following entries:
-  "msi": The Tegra interrupt that is asserted when an MSI is received
-- bus-range: Range of bus numbers associated with this controller
-- #address-cells: Address representation for root ports (must be 3)
-  - cell 0 specifies the bus and device numbers of the root port:
-    [23:16]: bus number
-    [15:11]: device number
-  - cell 1 denotes the upper 32 address bits and should be 0
-  - cell 2 contains the lower 32 address bits and is used to translate to the
-    CPU address space
-- #size-cells: Size representation for root ports (must be 2)
-- ranges: Describes the translation of addresses for root ports and standard
-  PCI regions. The entries must be 7 cells each, where the first three cells
-  correspond to the address as described for the #address-cells property
-  above, the fourth and fifth cells are for the physical CPU address to
-  translate to and the sixth and seventh cells are as described for the
-  #size-cells property above.
-  - Entries setup the mapping for the standard I/O, memory and
-    prefetchable PCI regions. The first cell determines the type of region
-    that is setup:
-    - 0x81000000: I/O memory region
-    - 0x82000000: non-prefetchable memory region
-    - 0xc2000000: prefetchable memory region
-  Please refer to the standard PCI bus binding document for a more detailed
-  explanation.
-- #interrupt-cells: Size representation for interrupts (must be 1)
-- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping properties
-  Please refer to the standard PCI bus binding document for a more detailed
-  explanation.
-
-EP mode:
-In Tegra194, Only controllers C0, C4 & C5 support EP mode.
-- compatible: Tegra19x must contain "nvidia,tegra194-pcie-ep"
-- reg-names: Must include the following entries:
-  "addr_space": Used to map remote RC address space
-- reset-gpios: Must contain a phandle to a GPIO controller followed by
-  GPIO that is being used as PERST input signal. Please refer to pci.txt
-  document.
-
-Optional properties:
-- pinctrl-names: A list of pinctrl state names.
-  It is mandatory for C5 controller and optional for other controllers.
-  - "default": Configures PCIe I/O for proper operation.
-- pinctrl-0: phandle for the 'default' state of pin configuration.
-  It is mandatory for C5 controller and optional for other controllers.
-- supports-clkreq: Refer to Documentation/devicetree/bindings/pci/pci.txt
-- nvidia,update-fc-fixup: This is a boolean property and needs to be present to
-    improve performance when a platform is designed in such a way that it
-    satisfies at least one of the following conditions thereby enabling root
-    port to exchange optimum number of FC (Flow Control) credits with
-    downstream devices
-    1. If C0/C4/C5 run at x1/x2 link widths (irrespective of speed and MPS)
-    2. If C0/C1/C2/C3/C4/C5 operate at their respective max link widths and
-       a) speed is Gen-2 and MPS is 256B
-       b) speed is >= Gen-3 with any MPS
-- nvidia,aspm-cmrt-us: Common Mode Restore Time for proper operation of ASPM
-   to be specified in microseconds
-- nvidia,aspm-pwr-on-t-us: Power On time for proper operation of ASPM to be
-   specified in microseconds
-- nvidia,aspm-l0s-entrance-latency-us: ASPM L0s entrance latency to be
-   specified in microseconds
-
-RC mode:
-- vpcie3v3-supply: A phandle to the regulator node that supplies 3.3V to the slot
-  if the platform has one such slot. (Ex:- x16 slot owned by C5 controller
-  in p2972-0000 platform).
-- vpcie12v-supply: A phandle to the regulator node that supplies 12V to the slot
-  if the platform has one such slot. (Ex:- x16 slot owned by C5 controller
-  in p2972-0000 platform).
-
-EP mode:
-- nvidia,refclk-select-gpios: Must contain a phandle to a GPIO controller
-  followed by GPIO that is being used to enable REFCLK to controller from host
-
-NOTE:- On Tegra194's P2972-0000 platform, only C5 controller can be enabled to
-operate in the endpoint mode because of the way the platform is designed.
-
-Examples:
-=========
-
-Tegra194 RC mode:
------------------
-
-	pcie@14180000 {
-		compatible = "nvidia,tegra194-pcie";
-		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8B>;
-		reg = <0x00 0x14180000 0x0 0x00020000   /* appl registers (128K)      */
-		       0x00 0x38000000 0x0 0x00040000   /* configuration space (256K) */
-		       0x00 0x38040000 0x0 0x00040000>; /* iATU_DMA reg space (256K)  */
-		reg-names = "appl", "config", "atu_dma";
-
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		num-lanes = <8>;
-		linux,pci-domain = <0>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&pex_rst_c5_out_state>, <&clkreq_c5_bi_dir_state>;
-
-		clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_0>;
-		clock-names = "core";
-
-		resets = <&bpmp TEGRA194_RESET_PEX0_CORE_0_APB>,
-			 <&bpmp TEGRA194_RESET_PEX0_CORE_0>;
-		reset-names = "apb", "core";
-
-		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,	/* controller interrupt */
-			     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;	/* MSI interrupt */
-		interrupt-names = "intr", "msi";
-
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
-
-		nvidia,bpmp = <&bpmp 0>;
-
-		supports-clkreq;
-		nvidia,aspm-cmrt-us = <60>;
-		nvidia,aspm-pwr-on-t-us = <20>;
-		nvidia,aspm-l0s-entrance-latency-us = <3>;
-
-		bus-range = <0x0 0xff>;
-		ranges = <0x81000000 0x0  0x38100000 0x0  0x38100000 0x0 0x00100000    /* downstream I/O (1MB) */
-			  0x82000000 0x0  0x38200000 0x0  0x38200000 0x0 0x01E00000    /* non-prefetchable memory (30MB) */
-			  0xc2000000 0x18 0x00000000 0x18 0x00000000 0x4 0x00000000>;  /* prefetchable memory (16GB) */
-
-		vddio-pex-ctl-supply = <&vdd_1v8ao>;
-		vpcie3v3-supply = <&vdd_3v3_pcie>;
-		vpcie12v-supply = <&vdd_12v_pcie>;
-
-		phys = <&p2u_hsio_2>, <&p2u_hsio_3>, <&p2u_hsio_4>,
-		       <&p2u_hsio_5>;
-		phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3";
-	};
-
-Tegra194 EP mode:
------------------
-
-	pcie-ep@141a0000 {
-		compatible = "nvidia,tegra194-pcie-ep", "snps,dw-pcie-ep";
-		power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8A>;
-		reg = <0x00 0x141a0000 0x0 0x00020000   /* appl registers (128K)      */
-		       0x00 0x3a040000 0x0 0x00040000   /* iATU_DMA reg space (256K)  */
-		       0x00 0x3a080000 0x0 0x00040000   /* DBI reg space (256K)       */
-		       0x1c 0x00000000 0x4 0x00000000>; /* Address Space (16G)        */
-		reg-names = "appl", "atu_dma", "dbi", "addr_space";
-
-		num-lanes = <8>;
-		num-ib-windows = <2>;
-		num-ob-windows = <8>;
-
-		pinctrl-names = "default";
-		pinctrl-0 = <&clkreq_c5_bi_dir_state>;
-
-		clocks = <&bpmp TEGRA194_CLK_PEX1_CORE_5>;
-		clock-names = "core";
-
-		resets = <&bpmp TEGRA194_RESET_PEX1_CORE_5_APB>,
-			 <&bpmp TEGRA194_RESET_PEX1_CORE_5>;
-		reset-names = "apb", "core";
-
-		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;	/* controller interrupt */
-		interrupt-names = "intr";
-
-		nvidia,bpmp = <&bpmp 5>;
-
-		nvidia,aspm-cmrt-us = <60>;
-		nvidia,aspm-pwr-on-t-us = <20>;
-		nvidia,aspm-l0s-entrance-latency-us = <3>;
-
-		vddio-pex-ctl-supply = <&vdd_1v8ao>;
-
-		reset-gpios = <&gpio TEGRA194_MAIN_GPIO(GG, 1) GPIO_ACTIVE_LOW>;
-
-		nvidia,refclk-select-gpios = <&gpio_aon TEGRA194_AON_GPIO(AA, 5)
-					      GPIO_ACTIVE_HIGH>;
-
-		phys = <&p2u_nvhs_0>, <&p2u_nvhs_1>, <&p2u_nvhs_2>,
-		       <&p2u_nvhs_3>, <&p2u_nvhs_4>, <&p2u_nvhs_5>,
-		       <&p2u_nvhs_6>, <&p2u_nvhs_7>;
-
-		phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3", "p2u-4",
-			    "p2u-5", "p2u-6", "p2u-7";
-	};
diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
new file mode 100644
index 000000000000..abbaafe98fd4
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
@@ -0,0 +1,251 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/nvidia,tegra194-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra194 (and later) PCIe controller (Synopsys DesignWare Core based)
+
+maintainers:
+  - Thierry Reding <thierry.reding@gmail.com>
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Vidya Sagar <vidyas@nvidia.com>
+
+description: |
+  This PCIe controller is based on the Synopsis Designware PCIe IP and thus
+  inherits all the common properties defined in snps,dw-pcie.yaml. Some of the
+  controller instances are dual mode where in they can work either in root port
+  mode or endpoint mode but one at a time.
+
+  see nvidia,tegra194-pcie-ep.yaml for details on the endpoint mode device tree
+  bindings.
+
+properties:
+  compatible:
+    enum:
+      - nvidia,tegra194-pcie
+
+  reg:
+    items:
+      - description: controller's application logic registers
+      - description: configuration registers
+      - description: iATU and DMA registers. This is where the iATU (internal
+          Address Translation Unit) registers of the PCIe core are made
+          available for software access.
+      - description: The aperture where the root port's own configuration
+          registers are available.
+
+  reg-names:
+    items:
+      - const: appl
+      - const: config
+      - const: atu_dma
+      - const: dbi
+
+  interrupts:
+    items:
+      - description: controller interrupt
+      - description: MSI interrupt
+
+  interrupt-names:
+    items:
+      - const: intr
+      - const: msi
+
+  clocks:
+    items:
+      - description: module clock
+
+  clock-names:
+    items:
+      - const: core
+
+  resets:
+    items:
+      - description: APB bus interface reset
+      - description: module reset
+
+  reset-names:
+    items:
+      - const: apb
+      - const: core
+
+  phys:
+    minItems: 1
+    maxItems: 8
+
+  phy-names:
+    minItems: 1
+    items:
+      - const: p2u-0
+      - const: p2u-1
+      - const: p2u-2
+      - const: p2u-3
+      - const: p2u-4
+      - const: p2u-5
+      - const: p2u-6
+      - const: p2u-7
+
+  power-domains:
+    maxItems: 1
+    description: |
+      A phandle to the node that controls power to the respective PCIe
+      controller and a specifier name for the PCIe controller.
+
+      specifiers are defined in "include/dt-bindings/power/tegra194-powergate.h" file.
+
+  interconnects:
+    items:
+      - description: memory read client
+      - description: memory write client
+
+  interconnect-names:
+    items:
+      - const: dma-mem # read
+      - const: write
+
+  dma-coherent: true
+
+  nvidia,bpmp:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: |
+      Must contain a pair of phandle to BPMP controller node followed by
+      controller ID. Following are the controller IDs for each controller:
+
+        0: C0
+        1: C1
+        2: C2
+        3: C3
+        4: C4
+        5: C5
+    items:
+      - items:
+          - description: phandle to BPMP controller node
+          - description: PCIe controller ID
+            maximum: 5
+
+  nvidia,update-fc-fixup:
+    description: |
+      This is a boolean property and needs to be present to improve performance
+      when a platform is designed in such a way that it satisfies at least one
+      of the following conditions thereby enabling root port to exchange
+      optimum number of FC (Flow Control) credits with downstream devices:
+
+        1. If C0/C4/C5 run at x1/x2 link widths (irrespective of speed and MPS)
+        2. If C0/C1/C2/C3/C4/C5 operate at their respective max link widths and
+          a) speed is Gen-2 and MPS is 256B
+          b) speed is >= Gen-3 with any MPS
+
+    $ref: /schemas/types.yaml#/definitions/flag
+
+  nvidia,aspm-cmrt-us:
+    description: Common Mode Restore Time for proper operation of ASPM to be
+      specified in microseconds
+
+  nvidia,aspm-pwr-on-t-us:
+    description: Power On time for proper operation of ASPM to be specified in
+      microseconds
+
+  nvidia,aspm-l0s-entrance-latency-us:
+    description: ASPM L0s entrance latency to be specified in microseconds
+
+  vddio-pex-ctl-supply:
+    description: A phandle to the regulator supply for PCIe side band signals.
+
+  vpcie3v3-supply:
+    description: A phandle to the regulator node that supplies 3.3V to the slot
+      if the platform has one such slot. (Ex:- x16 slot owned by C5 controller
+      in p2972-0000 platform).
+
+  vpcie12v-supply:
+    description: A phandle to the regulator node that supplies 12V to the slot
+      if the platform has one such slot. (Ex:- x16 slot owned by C5 controller
+      in p2972-0000 platform).
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+
+unevaluatedProperties: false
+
+required:
+  - interrupts
+  - interrupt-names
+  - interrupt-map
+  - interrupt-map-mask
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - power-domains
+  - vddio-pex-ctl-supply
+  - num-lanes
+  - phys
+  - phy-names
+  - nvidia,bpmp
+
+examples:
+  - |
+    #include <dt-bindings/clock/tegra194-clock.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/tegra194-powergate.h>
+    #include <dt-bindings/reset/tegra194-reset.h>
+
+    bus@0 {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        ranges = <0x0 0x0 0x0 0x8 0x0>;
+
+        pcie@14180000 {
+            compatible = "nvidia,tegra194-pcie";
+            power-domains = <&bpmp TEGRA194_POWER_DOMAIN_PCIEX8B>;
+            reg = <0x0 0x14180000 0x0 0x00020000>, /* appl registers (128K)      */
+                  <0x0 0x38000000 0x0 0x00040000>, /* configuration space (256K) */
+                  <0x0 0x38040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
+                  <0x0 0x38080000 0x0 0x00040000>; /* DBI reg space (256K)       */
+            reg-names = "appl", "config", "atu_dma", "dbi";
+
+            #address-cells = <3>;
+            #size-cells = <2>;
+            device_type = "pci";
+            num-lanes = <8>;
+            linux,pci-domain = <0>;
+
+            pinctrl-names = "default";
+            pinctrl-0 = <&pex_rst_c5_out_state>, <&clkreq_c5_bi_dir_state>;
+
+            clocks = <&bpmp TEGRA194_CLK_PEX0_CORE_0>;
+            clock-names = "core";
+
+            resets = <&bpmp TEGRA194_RESET_PEX0_CORE_0_APB>,
+                     <&bpmp TEGRA194_RESET_PEX0_CORE_0>;
+            reset-names = "apb", "core";
+
+            interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
+                         <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
+            interrupt-names = "intr", "msi";
+
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0>;
+            interrupt-map = <0 0 0 0 &gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+
+            nvidia,bpmp = <&bpmp 0>;
+
+            supports-clkreq;
+            nvidia,aspm-cmrt-us = <60>;
+            nvidia,aspm-pwr-on-t-us = <20>;
+            nvidia,aspm-l0s-entrance-latency-us = <3>;
+
+            bus-range = <0x0 0xff>;
+            ranges = <0x81000000 0x0  0x38100000 0x0  0x38100000 0x0 0x00100000>, /* downstream I/O */
+                     <0x82000000 0x0  0x38200000 0x0  0x38200000 0x0 0x01e00000>, /* non-prefetch memory */
+                     <0xc2000000 0x18 0x00000000 0x18 0x00000000 0x4 0x00000000>; /* prefetchable memory */
+
+            vddio-pex-ctl-supply = <&vdd_1v8ao>;
+            vpcie3v3-supply = <&vdd_3v3_pcie>;
+            vpcie12v-supply = <&vdd_12v_pcie>;
+
+            phys = <&p2u_hsio_2>, <&p2u_hsio_3>, <&p2u_hsio_4>,
+                   <&p2u_hsio_5>;
+            phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3";
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
index c90e5e2d25f6..7287d395e1b6 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -34,8 +34,8 @@ properties:
     minItems: 2
     maxItems: 5
     items:
-      enum: [ dbi, dbi2, config, atu, app, elbi, mgmt, ctrl, parf, cfg, link,
-              ulreg, smu, mpu, apb, phy ]
+      enum: [ dbi, dbi2, config, atu, atu_dma, app, appl, elbi, mgmt, ctrl,
+              parf, cfg, link, ulreg, smu, mpu, apb, phy ]
 
   num-lanes:
     description: |
-- 
2.17.1

