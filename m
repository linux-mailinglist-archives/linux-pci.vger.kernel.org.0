Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8639F5731D0
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 11:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235820AbiGMJAz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 05:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiGMJAu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 05:00:50 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2054.outbound.protection.outlook.com [40.107.94.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702DEE6331;
        Wed, 13 Jul 2022 02:00:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQcOIafUOm85XT9IMgLPKVk8OS+63dpdmjCzDEwNwXRd5HVyBCipNxObgUXbv/bWyaqb76i17mdSj6xW/uoMAlSIAOu4A8XDvXZHGVbVACqcENDFFdOiQ7lyHGlfuP3Bo5v2dOCMEqbfa0t/L4+VNd/mVGqyatf3w/wkCTumPAON4n+FkLyZnQl/lw3ZS4kJ5f0XZL1aza5GYL3p7ZpxBH6uyJ/Dx4u8FTazuQkj+8B0eyWgAmChTlRPxVyvd7v0v6dhLdtU1+5wgdf9K6P9WBmNNjmxzgLjKitLhHioZy2nwcJhY1IdIdjgCC1na0bdeNK0xL1B42jjRtIuWn6ADA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2i9d7cbsL5FTmf84WWv3V6vsG1Xlb7Y81BidzJ4KGug=;
 b=kAcf9MXNFdVHBhMtFGySxDpHA7SOuIuj7wBxtbvIrm2s7rQSPewTZjeT4FuN/OLuzJS0KZk9JWCB5b8/AohUC2xuOD250E3XvAnMZauLnEMTSZWqrc2zDfWhaHS8bQ+ErzveJXWQSakkgeYOmH/NkV1uSSi8/NpKrWsFzVJ/uc1J5obY/n+Wkt+45AtBcbaJHhukVVi2SPyF949bK+XdaPiSmVqY7qmEE+KEqIbM1qX1pzycvJeeBpGiAptAHYa0zY9maEtXQQstJW8uYn7GeDZHDInoqO5UICED83yrRlIFkAWzFlks1L0puxvsJgPZp+oILp8SFOzRR+a0xRbFbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2i9d7cbsL5FTmf84WWv3V6vsG1Xlb7Y81BidzJ4KGug=;
 b=GchNsEhJXGUtDLXyCAQFZpK07yHN9hEocEwp4GJmToAhvWz/c9BF9Esh8ZamQyyDdlj6i0swZ2H93j9NRoEfOmoojsoExFc3dpdHiWqXQQ4Up7GJaJyR8mmDc4SCxF1CK2hEWiMVgyJjL0vq9bNJdJjhpe607W3tbnCw7Av75AcDnc5trfWqrwLHH944af1EBXuDmGPe481n/LwwHA/MukJXNJzfintIYwQcFCwBzPjTSo1miuEuhXLtEPY9+llzD8blEToAHuv8+ZoRHri/Dy+1M5RPnahToz3WE5sVUzp/NreF7D7BdfDaDjwpjzFzbHvmvOiWJVtLN740M6uu1A==
Received: from BN6PR14CA0008.namprd14.prod.outlook.com (2603:10b6:404:79::18)
 by SN6PR12MB2734.namprd12.prod.outlook.com (2603:10b6:805:76::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Wed, 13 Jul
 2022 09:00:46 +0000
Received: from BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:79:cafe::e0) by BN6PR14CA0008.outlook.office365.com
 (2603:10b6:404:79::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Wed, 13 Jul 2022 09:00:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT014.mail.protection.outlook.com (10.13.177.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 09:00:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 13 Jul
 2022 09:00:44 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 13 Jul
 2022 02:00:43 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Wed, 13 Jul 2022 02:00:38 -0700
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
Subject: [PATCH V5 1/9] dt-bindings: pci: tegra: Convert to json-schema
Date:   Wed, 13 Jul 2022 14:30:21 +0530
Message-ID: <20220713090029.30395-2-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220713090029.30395-1-vidyas@nvidia.com>
References: <20220713090029.30395-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7faf6d7c-c7c6-48bb-bed1-08da64ae2c78
X-MS-TrafficTypeDiagnostic: SN6PR12MB2734:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aSvUwys5ptfzrHBnFB5hkPINCpFqFg/3uQ6J3uBP/2PAQnEVeS9fpqghmLxA?=
 =?us-ascii?Q?efbSHrh6YccEOwK6suT63s+pOjbZ4CRSBVu3yItXDMQPyMKa9VClciw6fRWU?=
 =?us-ascii?Q?Ipt30b0w10fHaNLNAK+9M7UWbGZqOJqr9Foles578stA/rrDVtrnLSId6ibH?=
 =?us-ascii?Q?0YaKi1XIKmfctCkE0Wjr8vwtKMN3ioSv2wkx6g0IgYQLvOtmECKHVju5lnNP?=
 =?us-ascii?Q?Gm4AW8cjOy0FE70LFAAboDCtvA2p5ZZLtv5NcD4RPS8ixqByd+pepFnc2q0N?=
 =?us-ascii?Q?sZmA862MAIBBf+jYP7GkjpDGo6LpMKuDFka8RhM57B38VVGFXqVt4ypjP88W?=
 =?us-ascii?Q?OucMfJKciOpE5r7qCxinNMHcgnjqD3KRpTI+PvjSp6RsGckd+PxCnSPlp1u4?=
 =?us-ascii?Q?jsWk2fORF6mDfXKO77VBgDeCtzsOQkLzypPEu8nFvcgt570FSd1k+Jc4Lts+?=
 =?us-ascii?Q?ZSbzQSWTW4so1XLm5dvtXcW8Ucfupf0y9jFBE5YKXNLybXwMAguznrnUgiH3?=
 =?us-ascii?Q?HcQAVfG36Jex49xaLCs0JNzPARdsE1bIKGdvaEsRYlVu+/JYmmTXA550Npte?=
 =?us-ascii?Q?gyjkGvnvQ8lsqW3bp2y7eH3AiSpxi7hRgAUDSjcL5MZvnOXXLvhZVSjjvKe2?=
 =?us-ascii?Q?mM97Z+TTV7LYBkUUCPYlKUzOafz+b/iPSLuJ7uOVwIWybT8gh28DUtJ90ETy?=
 =?us-ascii?Q?T0Bjp0xKGJb5CSfgWIal8ER7NQc+DM8eqBa8b/MD5ABtM3pwpNHOKKOAU/Se?=
 =?us-ascii?Q?Jxoz19sAPK/+761myQVaXr+D8aPqJSzHqtNA8AiBolR9YfIY3w9ZURJqobpd?=
 =?us-ascii?Q?BKjOeU6xngu+ijSRU4D9z/7XAy6iTnjefRAEQQ+g+hQwzMcec/57n6uOj4so?=
 =?us-ascii?Q?1EZdLKRf+t8GVRvm3XNGJircf7dQkOFtQecejHfYPWkw3mVqBInyeKjAdlHC?=
 =?us-ascii?Q?r2cCmhdjqtvvbJunmrBi6H+P9u5Y5B/BnJgsPjWij3gtW6wXtsM7xMrbBiM7?=
 =?us-ascii?Q?n2a0?=
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(376002)(39860400002)(396003)(346002)(136003)(36840700001)(40470700004)(46966006)(336012)(70586007)(6666004)(4326008)(70206006)(82310400005)(107886003)(47076005)(8676002)(26005)(82740400003)(86362001)(316002)(7696005)(426003)(186003)(110136005)(2616005)(356005)(41300700001)(40480700001)(30864003)(966005)(2906002)(54906003)(1076003)(81166007)(8936002)(36756003)(40460700003)(83380400001)(5660300002)(7416002)(36860700001)(478600001)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 09:00:45.7200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7faf6d7c-c7c6-48bb-bed1-08da64ae2c78
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2734
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
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
2.34.1

