Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577F655F625
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 08:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiF2GFF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 02:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbiF2GFC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 02:05:02 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2048.outbound.protection.outlook.com [40.107.237.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B2017E00;
        Tue, 28 Jun 2022 23:05:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/P1rsoxaxdGzTrg+F+IfbKvSRT04EBsqxdU5hiV4bDN7fQlzyfkryrZNhN1jF3VYP4qu35lQl+tFhy6pJoAffPbFuI/cxNOGaEsrIZcvn/U8ZiaOK1oKVdrleziHHV77C3iuujmIZ7WcjxUkqHaBXkVqHGgRiucxaayWIgjxxWodozHzHHVE1M1H9BszMUbuzo7+8qzRRCB3YPYSKNfI0Nr+9MoaTUo1nF4HrZJGOVtg0Vp7s428gMofmrmSJ5M3VDtVrfOyx+RpWbkl5wnndnAhwGfh5JwN3e7wULIfXPoySzCYlU11BwivHfR0bcjhLbhgxzGpozlvV5dwTrwgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20BYqCeFMsEAFdY0YNtYX7oEuSh/egOPUcYpsJHP/1A=;
 b=UGlLlmM0LZ/GxvX50Gxp/mbfFnhj0sNUGyJNqdXw7kyiM9UldQNREmyZGnHrnbUdKABAbakbzDcCk3ApbpRmm2bvcXyOej8Lvcx15DU1knTcQUNrqInl1x7+3RuQoANQ3K4Pbjllw9GgEcEJr6sFuu1mOIOEhdHH9lftQucDKMkMaRIbWdDpOSHAhu9Y9xyifpKtqCWeEV3ft19GlZjRmWOVMo9ZjcgrNofyUV4h7Z8w6nFNGieGwW0Pmxu5f6r/dmPPFclEqH/gYvVlNr/aw37xMcOFGRqtil8Dw+EMNLcCvKjApIC512i0cJfipjPXf+Jv8NxWjrz7yfTAXkKV+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.235) smtp.rcpttodomain=ti.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20BYqCeFMsEAFdY0YNtYX7oEuSh/egOPUcYpsJHP/1A=;
 b=bvsWxHsYhkWeixaCpGsZbmVXkuHyfaqUSH1dF2sBaRCvuNACUqKsTRVXd/7o+Pxhha+uHkX8OK+ghFZYiLlI/34jbtno8xxlLwgh+8mcujXxyjZjCfgbvEU7fwhG7Nu1ql3aiiXYOx2zDzciyF4UpksnxaYbjsrlwKUbHwjBCizM4qUNd9WSwVSp/uqSQ1tJwZXPNeRBAFGk5bcW2hV+zNcjEJfXo1OgFmjop7DotsbnvEVYho7YATeeFHkQM1h5gv2h/1wEFU50bQbgFvLe5gqWtc29Fga1mam7LhP2gsVdGoT/mnOXUWZK5MpltATnqj7U9PEO/8s7rD+ePBneRA==
Received: from DS7PR05CA0044.namprd05.prod.outlook.com (2603:10b6:8:2f::10) by
 DM5PR12MB1626.namprd12.prod.outlook.com (2603:10b6:4:d::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.18; Wed, 29 Jun 2022 06:04:57 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::8d) by DS7PR05CA0044.outlook.office365.com
 (2603:10b6:8:2f::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.6 via Frontend
 Transport; Wed, 29 Jun 2022 06:04:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.235)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.235 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.235; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.235) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 06:04:57 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 29 Jun
 2022 06:04:57 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 28 Jun
 2022 23:04:55 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Tue, 28 Jun 2022 23:04:50 -0700
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
        <sagar.tv@gmail.com>, "Thierry Reding" <treding@nvidia.com>
Subject: [PATCH V3 02/11] dt-bindings: pci: tegra: Convert to json-schema
Date:   Wed, 29 Jun 2022 11:34:26 +0530
Message-ID: <20220629060435.25297-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220629060435.25297-1-vidyas@nvidia.com>
References: <20220629060435.25297-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b1482cb1-46a3-4780-71ca-08da59954b72
X-MS-TrafficTypeDiagnostic: DM5PR12MB1626:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bjlZi4d/xG8e+wmgTTFjtORh0AHgNlciEeKNbomguC+cKi3RmBhW3Isgp6IS?=
 =?us-ascii?Q?VS4PCJznpd05+JAiUEzLkuCoAX+ipNrI0LBGBx1nrmbZLyHhT1o4SmxS2AU3?=
 =?us-ascii?Q?kSNc6ZL9tGNAIJ/iS1f8mcrO0+hiIw6GUzjfnpMZ6X/jk4KUAk/gMvQV4jUI?=
 =?us-ascii?Q?VM5cLNzXSPDbM7KeE0fPzhMPlgKYJouC21gLBOmM5dX1PdntKrNgbFODNQ1o?=
 =?us-ascii?Q?+uDf/bNWyry4/y0DmaNZFHL7swFgOEcWZze8z8LPZGNdYm5YKUtE64rUBH/j?=
 =?us-ascii?Q?d6aR8XakZ6xW4pTqN+QVO+NMcYifGZVDjSmax0/kYGxKVqfrNR5ZwccsJE8M?=
 =?us-ascii?Q?cXz55P4DkRTXyGhu6aOaqy6lULPu4OeoQUKlkwUBxFyI2MQWs8jjuZO1Yezs?=
 =?us-ascii?Q?brM3X3FNozPQjgTbzjr9TVIVFg0nNMaEE+YcDjKLQHZLcSNkih4CWd0/Jb2l?=
 =?us-ascii?Q?vbRb1PGHVJyKJtGydk/Q1N7vY6tK1DfBCCkEtJCd7pIzSpemfCEaDa29vVQB?=
 =?us-ascii?Q?cSfHLXxZWpgDcKu/ymwNSiX6u2wByYaWzRbxh9UmWdQaf8OsmyTB2j9cZr/j?=
 =?us-ascii?Q?sSu/SXZLAljreJ0OVKYeVBv7VM4xd+jG3vuMtnUHNJ6OWYfrYQxk7XPgwiHN?=
 =?us-ascii?Q?4C1j+MwuxkktCEzW5BW8t4Gn5/jdmE1TFTe1luZxRATFaV8iFhtSpjgs4tQa?=
 =?us-ascii?Q?bDNscFSS38HLUdXbngJPl7UIXyepr9TBN16nqo5Ps+stzbzrZr57Yme6cBm0?=
 =?us-ascii?Q?XfgadWsfvHIQ3X3rghtO5KUIDYARhz2U3fUlVdWEqaQkQ+egtGOVNbZgAvaD?=
 =?us-ascii?Q?tH5bIkupsYyjs3MloAcvkCvxsUMo0Z6EPTBO5S0xN0RyO6/ChzsmlfZZ1QQn?=
 =?us-ascii?Q?w2Baos3nEQmHb/fXtAi5ET4NNrdOoBrZ+mauuYQW025kvtFwjEExoRbhkB+7?=
 =?us-ascii?Q?8+yZ1t6qGs3wBV0KFDrnsg=3D=3D?=
X-Forefront-Antispam-Report: CIP:12.22.5.235;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(346002)(396003)(136003)(39860400002)(376002)(36840700001)(46966006)(40470700004)(8936002)(5660300002)(70206006)(82740400003)(81166007)(7416002)(70586007)(36860700001)(6636002)(110136005)(316002)(54906003)(8676002)(356005)(36756003)(4326008)(1076003)(336012)(6666004)(186003)(426003)(83380400001)(107886003)(7696005)(478600001)(47076005)(966005)(2616005)(41300700001)(2906002)(82310400005)(40460700003)(86362001)(40480700001)(26005)(30864003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 06:04:57.5574
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1482cb1-46a3-4780-71ca-08da59954b72
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.235];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1626
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Convert the Tegra194 PCIe bindings from the free-form text format to
json-schema.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
V3:
* New patch in this series. Added as part of addressing Rob's review
  comment to convert the existing .txt file to .yaml schema

 .../bindings/pci/nvidia,tegra194-pcie-ep.yaml | 239 ++++++++++++++++
 .../bindings/pci/nvidia,tegra194-pcie.txt     | 245 -----------------
 .../bindings/pci/nvidia,tegra194-pcie.yaml    | 254 ++++++++++++++++++
 .../devicetree/bindings/pci/snps,dw-pcie.yaml |   2 +-
 4 files changed, 494 insertions(+), 246 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
 create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
new file mode 100644
index 000000000000..4f7cb7fe378e
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie-ep.yaml
@@ -0,0 +1,239 @@
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
+  This PCIe controller is based on the Synopsis Designware PCIe IP and thus inherits all the common
+  properties defined in snps,dw-pcie-ep.yaml. Some of the controller instances are dual mode where
+  in they can work either in root port mode or endpoint mode but one at a time.
+
+  On Tegra194, controllers C0, C4 and C5 support endpoint mode.
+
+  Note: On Tegra194's P2972-0000 platform, only C5 controller can be enabled to operate in the
+  endpoint mode because of the way the platform is designed.
+
+properties:
+  compatible:
+    enum:
+      - nvidia,tegra194-pcie-ep
+
+  reg:
+    items:
+      - description: controller's application logic registers
+      - description: iATU and DMA registers. This is where the iATU (internal Address Translation
+          Unit) registers of the PCIe core are made available for software access.
+      - description: The aperture where the root port's own configuration registers are available.
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
+    description: Must contain a phandle to a GPIO controller followed by GPIO that is being used as
+      PERST input signal. Please refer to pci.txt document.
+
+  phys:
+    minItems: 1
+    maxItems: 16
+
+  phy-names:
+    minItems: 1
+    maxItems: 16
+    items:
+      pattern: "^p2u-[0-9]+$"
+
+  power-domains:
+    description: |
+      A phandle to the node that controls power to the respective PCIe controller and a specifier
+      name for the PCIe controller. Following are the specifiers for the different PCIe
+      controllers:
+
+        - TEGRA194_POWER_DOMAIN_PCIEX8B: C0
+        - TEGRA194_POWER_DOMAIN_PCIEX1A: C1
+        - TEGRA194_POWER_DOMAIN_PCIEX1A: C2
+        - TEGRA194_POWER_DOMAIN_PCIEX1A: C3
+        - TEGRA194_POWER_DOMAIN_PCIEX4A: C4
+        - TEGRA194_POWER_DOMAIN_PCIEX8A: C5
+
+      these specifiers are defined in "include/dt-bindings/power/tegra194-powergate.h" file.
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
+  num-ib-windows:
+    description: number of inbound address translation windows
+    maxItems: 1
+    deprecated: true
+
+  num-ob-windows:
+    description: number of outbound address translation windows
+    maxItems: 1
+    deprecated: true
+
+  nvidia,bpmp:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: |
+      Must contain a pair of phandle to BPMP controller node followed by controller ID. Following
+      are the controller IDs for each controller:
+
+        0: C0
+        1: C1
+        2: C2
+        3: C3
+        4: C4
+        5: C5
+    items:
+      - items:
+          - minimum: 0
+            maximum: 0xffffffff
+          - enum: [ 0, 1, 2, 3, 4, 5 ]
+
+  nvidia,aspm-cmrt-us:
+    description: Common Mode Restore Time for proper operation of ASPM to be specified in
+      microseconds
+
+  nvidia,aspm-pwr-on-t-us:
+    description: Power On time for proper operation of ASPM to be specified in microseconds
+
+  nvidia,aspm-l0s-entrance-latency-us:
+    description: ASPM L0s entrance latency to be specified in microseconds
+
+  vddio-pex-ctl-supply:
+    description: A phandle to the regulator supply for PCIe side band signals.
+
+  nvidia,refclk-select-gpios:
+    description: Must contain a phandle to a GPIO controller followed by GPIO that is being used to
+      enable REFCLK to controller from host
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+
+allOf:
+  - $ref: "/schemas/pci/pci-ep.yaml#"
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - num-ib-windows
+  - num-ob-windows
+  - interrupts
+  - interrupt-names
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - power-domains
+  - reset-gpios
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
index 000000000000..4a49dddf33bb
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.yaml
@@ -0,0 +1,254 @@
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
+  This PCIe controller is based on the Synopsis Designware PCIe IP and thus inherits all the common
+  properties defined in snps,dw-pcie.yaml. Some of the controller instances are dual mode where in
+  they can work either in root port mode or endpoint mode but one at a time.
+
+  See nvidia,tegra194-pcie-ep.yaml for details on the endpoint mode device tree bindings.
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
+      - description: iATU and DMA registers. This is where the iATU (internal Address Translation
+          Unit) registers of the PCIe core are made available for software access.
+      - description: The aperture where the root port's own configuration registers are available.
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
+    maxItems: 16
+
+  phy-names:
+    minItems: 1
+    maxItems: 16
+    items:
+      pattern: "^p2u-[0-9]+$"
+
+  power-domains:
+    description: |
+      A phandle to the node that controls power to the respective PCIe controller and a specifier
+      name for the PCIe controller. Following are the specifiers for the different PCIe
+      controllers:
+
+        - TEGRA194_POWER_DOMAIN_PCIEX8B: C0
+        - TEGRA194_POWER_DOMAIN_PCIEX1A: C1
+        - TEGRA194_POWER_DOMAIN_PCIEX1A: C2
+        - TEGRA194_POWER_DOMAIN_PCIEX1A: C3
+        - TEGRA194_POWER_DOMAIN_PCIEX4A: C4
+        - TEGRA194_POWER_DOMAIN_PCIEX8A: C5
+
+      these specifiers are defined in "include/dt-bindings/power/tegra194-powergate.h" file.
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
+  supports-clkreq:
+    description: see pci.txt for details
+
+  nvidia,bpmp:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: |
+      Must contain a pair of phandle to BPMP controller node followed by controller ID. Following
+      are the controller IDs for each controller:
+
+        0: C0
+        1: C1
+        2: C2
+        3: C3
+        4: C4
+        5: C5
+    items:
+      - items:
+          - minimum: 0
+            maximum: 0xffffffff
+          - enum: [ 0, 1, 2, 3, 4, 5 ]
+
+  nvidia,update-fc-fixup:
+    description: |
+      This is a boolean property and needs to be present to improve performance when a platform is
+      designed in such a way that it satisfies at least one of the following conditions thereby
+      enabling root port to exchange optimum number of FC (Flow Control) credits with downstream
+      devices:
+
+        1. If C0/C4/C5 run at x1/x2 link widths (irrespective of speed and MPS)
+        2. If C0/C1/C2/C3/C4/C5 operate at their respective max link widths and
+          a) speed is Gen-2 and MPS is 256B
+          b) speed is >= Gen-3 with any MPS
+
+    $ref: /schemas/types.yaml#/definitions/flag
+
+  nvidia,aspm-cmrt-us:
+    description: Common Mode Restore Time for proper operation of ASPM to be specified in
+      microseconds
+
+  nvidia,aspm-pwr-on-t-us:
+    description: Power On time for proper operation of ASPM to be specified in microseconds
+
+  nvidia,aspm-l0s-entrance-latency-us:
+    description: ASPM L0s entrance latency to be specified in microseconds
+
+  vddio-pex-ctl-supply:
+    description: A phandle to the regulator supply for PCIe side band signals.
+
+  vpcie3v3-supply:
+    description: A phandle to the regulator node that supplies 3.3V to the slot if the platform has
+      one such slot. (Ex:- x16 slot owned by C5 controller in p2972-0000 platform).
+
+  vpcie12v-supply:
+    description: A phandle to the regulator node that supplies 12V to the slot if the platform has
+      one such slot. (Ex:- x16 slot owned by C5 controller in p2972-0000 platform).
+
+allOf:
+  - $ref: "/schemas/pci/pci-bus.yaml#"
+  - $ref: "/schemas/pci/snps,dw-pcie.yaml#"
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - interrupt-names
+  - interrupt-map
+  - interrupt-map-mask
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - power-domains
+  - bus-range
+  - ranges
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
index c90e5e2d25f6..7e0bf941fbfe 100644
--- a/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml
@@ -35,7 +35,7 @@ properties:
     maxItems: 5
     items:
       enum: [ dbi, dbi2, config, atu, app, elbi, mgmt, ctrl, parf, cfg, link,
-              ulreg, smu, mpu, apb, phy ]
+              ulreg, smu, mpu, apb, phy, appl, atu_dma ]
 
   num-lanes:
     description: |
-- 
2.17.1

