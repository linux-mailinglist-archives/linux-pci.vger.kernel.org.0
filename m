Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6317150CA1F
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 14:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbiDWMwU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Apr 2022 08:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbiDWMwT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Apr 2022 08:52:19 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2085.outbound.protection.outlook.com [40.107.212.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F3F1A802;
        Sat, 23 Apr 2022 05:49:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ee4PnwRVW6MOOHb2Mf9DqTv0++DZC9kgut2Ijpj/Euhval5lvnhg5IbA9du0VQOixVK8r1cuquZbFCss/u6FRBg1qJBFu7+IDFYzsMleq2XcMvP6LYqntSWCH7z53cLl0jlWYmoQeWWRV+0pbRpt45FaCdI+sLW0P0yO8qjI7uSc6aTZn+JyU1wPJBeOoQWS32S3SSu8kKbarnWvAOrr1tnxu1nljnSiEEhvddqoDxhrv524rvt1xiCd3VCie1Su5pSzCn0Tcg34uLd4m2WryqpidMPYNd6j4Jg2spvB1q50xKUdhEWvg/34BwHaUxz55fgXKkigZInpqaitJLlfMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQWYRi+pD1iP591Df7OEMKS9E1OtN26GXtf/HTO/3Cc=;
 b=IOO79/zic9YTuQUMdVcgWG0hzpiyMsJUdvqhjhXw5Wv+fbB4YLecfTcjjV7mG2BFNlMIZ4Kj9GUY+PxIjtcVfGAOg/s7wf9i7P2bsj3IQ81XfTrIbFIjhtxHAMz2jXQ/k9aTNChLsI9q7mIwSmqKkg6AFQKMHwASE1c4E8NE4FDcdssRoosCIa7nLsFaQdMbRvntd2MrSeEXye/RdKjtob/xydtQf1IpeNCmoHQY9T8I33fAo0Usa/pw3GELbO8DMw+Zw0dXtA5beWHp5DNXzK6iiJQJmp+hCIFjwRzp1zMDSU+fODiw4wqWUpsgCUcEBXR3+xUb6+jM1oNj0UT89g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=ti.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQWYRi+pD1iP591Df7OEMKS9E1OtN26GXtf/HTO/3Cc=;
 b=tNDGRrxiGreOmxJFSBGB2Vpv2d8RFWJGEQZsl1FYaijWa21hvVvsVeNtee3rnjz2h9Tkny2uVg/NCcOOJqFjXTBMzm7HpNwwP0zYz4MygtoVtLue9tmAX87Hrv8Kcyt+rNROqB12PQ6XEQ0QW1vKyNn45QjoSmOhte17GjNzAX30gVdXhxAl1rDW+gMs1WXMFSjbhikoHcoRcQs8FayzFjGpkqrVeFY9mkUq758CgcwBBlN8jgN6hV7mZ3Gg5JgyXKK0i3Ob3Nk1C15YJBp/YW824mI4pOf6t1y6SBK+j/p+oSIRrjITwfHLOsgvJN1v2GVRY2ieZ8U6K7VIBCkHIg==
Received: from BN9PR03CA0945.namprd03.prod.outlook.com (2603:10b6:408:108::20)
 by BN6PR12MB1698.namprd12.prod.outlook.com (2603:10b6:404:106::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Sat, 23 Apr
 2022 12:49:19 +0000
Received: from BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::48) by BN9PR03CA0945.outlook.office365.com
 (2603:10b6:408:108::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Sat, 23 Apr 2022 12:49:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 BN8NAM11FT030.mail.protection.outlook.com (10.13.177.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Sat, 23 Apr 2022 12:49:19 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Sat, 23 Apr 2022 12:49:18 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 23 Apr 2022 05:49:17 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Sat, 23 Apr 2022 05:49:13 -0700
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
Subject: [PATCH V2 2/8] dt-bindings: PCI: tegra: Add device tree support for Tegra234
Date:   Sat, 23 Apr 2022 18:18:52 +0530
Message-ID: <20220423124858.25946-3-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220423124858.25946-1-vidyas@nvidia.com>
References: <20220423124858.25946-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 364afa4e-90ae-4603-1b4f-08da2527aefc
X-MS-TrafficTypeDiagnostic: BN6PR12MB1698:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1698586920069D9D38DBF984B8F69@BN6PR12MB1698.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +9WTIg5qExU527Aqn4pL8fkWf0TqJYlj/0J78JmOaMh+cbJr6TBNm8yqIFjRbK0m0iSr1ENdDVK6RghgWSlQIbXg7rPxT3Xvfdd9Y+ezF/tj4/w2pdOBa3qStAp+10PJTQvor+ppo7+JoJ0PkrWibk20dI1NIkmJ17MEP3+VTbkeIjWrqEkqjFU49B0BCbLoTXZpGXxLlmZbRJkrpB1BQLqg4i3LNddKwoz88f2F6a2PJ1d4RiW+Yj0kj73ALccsn29Hm2u4gZ09Xe5gn3qL/RgZvyJB16SFF69DsByytEfsWtbEqt5PWxN3f5CcB9Z17T5HfPom3DnHvytbLTAx03uycTmyzRC6hpiKsee8a0WsZbucf5hKwKHSdpQ9VIW17ksMcK+bvlaiUN32qB80INk8PqLBGGmBXo3ABRP8tkVPw2JEbm6buKHzHLn/G0hmFEmK+I8/a1EnYo9j4NqoWmCvikk2xlLLH1JIWfFyRQx1pDvFj/d1X4nCa8VK02ZGa9rSXk3Pjkp+TkTTR51+Bo1MmYjxxkLfilstr7r65ctTtdENBSs1Wmqrm+FB+frCAyTgAQgzNz/Nl5bFkVIU3GP6CNvvr5FLnJqB/0haHGwAx/f+YsIO5mciWY1X6S4IgcEnfj94Vg1htluY5k74bHrbaPr06U4OGT4a6W2tyJ9XYgNs0tl6PJQeQ6Cba4qhXmXqFKQC5J47Jz0j4DyAyg==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(110136005)(336012)(426003)(2906002)(82310400005)(6636002)(47076005)(86362001)(8676002)(4326008)(36860700001)(70586007)(186003)(54906003)(70206006)(2616005)(81166007)(8936002)(36756003)(26005)(5660300002)(508600001)(83380400001)(7416002)(1076003)(40460700003)(356005)(6666004)(7696005)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2022 12:49:19.4337
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 364afa4e-90ae-4603-1b4f-08da2527aefc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT030.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1698
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for Tegra234 PCIe controllers. These controllers are based
on Synopsys DesignWare core IP.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V2:
* Addressed review comment from Rob

 .../bindings/pci/nvidia,tegra194-pcie.txt     | 104 +++++++++++++++++-
 1 file changed, 101 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
index 8e4f9bfb316d..d6f4ea783b00 100644
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
@@ -10,6 +10,8 @@ Required properties:
 - power-domains: A phandle to the node that controls power to the respective
   PCIe controller and a specifier name for the PCIe controller. Following are
   the specifiers for the different PCIe controllers
+  Tegra194:
+  ---------
     TEGRA194_POWER_DOMAIN_PCIEX8B: C0
     TEGRA194_POWER_DOMAIN_PCIEX1A: C1
     TEGRA194_POWER_DOMAIN_PCIEX1A: C2
@@ -18,6 +20,21 @@ Required properties:
     TEGRA194_POWER_DOMAIN_PCIEX8A: C5
   these specifiers are defined in
   "include/dt-bindings/power/tegra194-powergate.h" file.
+  Tegra234:
+  ---------
+    TEGRA234_POWER_DOMAIN_PCIEX4BA: C0
+    TEGRA234_POWER_DOMAIN_PCIEX1A : C1
+    TEGRA234_POWER_DOMAIN_PCIEX1A : C2
+    TEGRA234_POWER_DOMAIN_PCIEX1A : C3
+    TEGRA234_POWER_DOMAIN_PCIEX4BB: C4
+    TEGRA234_POWER_DOMAIN_PCIEX8A : C5
+    TEGRA234_POWER_DOMAIN_PCIEX4A : C6
+    TEGRA234_POWER_DOMAIN_PCIEX8B : C7
+    TEGRA234_POWER_DOMAIN_PCIEX4CA: C8
+    TEGRA234_POWER_DOMAIN_PCIEX4CB: C9
+    TEGRA234_POWER_DOMAIN_PCIEX4CC: C10
+  these specifiers are defined in
+  "include/dt-bindings/power/tegra234-powergate.h" file.
 - reg: A list of physical base address and length pairs for each set of
   controller registers. Must contain an entry for each entry in the reg-names
   property.
@@ -47,16 +64,33 @@ Required properties:
   "p2u-N": where N ranges from 0 to one less than the total number of lanes
 - nvidia,bpmp: Must contain a pair of phandle to BPMP controller node followed
   by controller-id. Following are the controller ids for each controller.
+  Tegra194:
+  ---------
     0: C0
     1: C1
     2: C2
     3: C3
     4: C4
     5: C5
+  Tegra194:
+  ---------
+    0 : C0
+    1 : C1
+    2 : C2
+    3 : C3
+    4 : C4
+    5 : C5
+    6 : C6
+    7 : C7
+    8 : C8
+    9 : C9
+    10: C10
 - vddio-pex-ctl-supply: Regulator supply for PCIe side band signals
 
 RC mode:
-- compatible: Tegra19x must contain  "nvidia,tegra194-pcie"
+- compatible: Must be
+  - "nvidia,tegra194-pcie" for Tegra194
+  - "nvidia,tegra234-pcie" for Tegra234
 - device_type: Must be "pci" for RC mode
 - interrupt-names: Must include the following entries:
   "msi": The Tegra interrupt that is asserted when an MSI is received
@@ -99,7 +133,8 @@ In Tegra194, Only controllers C0, C4 & C5 support EP mode.
 
 Optional properties:
 - pinctrl-names: A list of pinctrl state names.
-  It is mandatory for C5 controller and optional for other controllers.
+  It is mandatory for C5 controller in Tegra194 and optional for other
+  controllers.
   - "default": Configures PCIe I/O for proper operation.
 - pinctrl-0: phandle for the 'default' state of pin configuration.
   It is mandatory for C5 controller and optional for other controllers.
@@ -108,7 +143,7 @@ Optional properties:
     improve performance when a platform is designed in such a way that it
     satisfies at least one of the following conditions thereby enabling root
     port to exchange optimum number of FC (Flow Control) credits with
-    downstream devices
+    downstream devices. This is applicable for only Tegra194.
     1. If C0/C4/C5 run at x1/x2 link widths (irrespective of speed and MPS)
     2. If C0/C1/C2/C3/C4/C5 operate at their respective max link widths and
        a) speed is Gen-2 and MPS is 256B
@@ -119,6 +154,9 @@ Optional properties:
    specified in microseconds
 - nvidia,aspm-l0s-entrance-latency-us: ASPM L0s entrance latency to be
    specified in microseconds
+- nvidia,enable-srns: This boolean property needs to be present if the
+   controller is configured to operate in SRNS (Separate Reference Clocks with
+   No Spread-Spectrum Clocking). This is applicable only for Tegra234.
 
 RC mode:
 - vpcie3v3-supply: A phandle to the regulator node that supplies 3.3V to the slot
@@ -127,6 +165,9 @@ RC mode:
 - vpcie12v-supply: A phandle to the regulator node that supplies 12V to the slot
   if the platform has one such slot. (Ex:- x16 slot owned by C5 controller
   in p2972-0000 platform).
+- nvidia,enable-ext-refclk: This boolean property needs to be present if the
+  controller is configured to use the reference clocking coming in from an
+  external clock source instead of using the internal clock source.
 
 EP mode:
 - nvidia,refclk-select-gpios: Must contain a phandle to a GPIO controller
@@ -243,3 +284,60 @@ Tegra194 EP mode:
 		phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3", "p2u-4",
 			    "p2u-5", "p2u-6", "p2u-7";
 	};
+
+Tegra234 RP mode:
+-----------------
+
+	pcie@141a0000 {
+		compatible = "nvidia,tegra234-pcie";
+		power-domains = <&bpmp TEGRA234_POWER_DOMAIN_PCIEX8A>;
+		reg = <0x00 0x141a0000 0x0 0x00020000>, /* appl registers (128K)      */
+		      <0x00 0x3a000000 0x0 0x00040000>, /* configuration space (256K) */
+		      <0x00 0x3a040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
+		      <0x00 0x3a080000 0x0 0x00040000>; /* DBI reg space (256K)       */
+		reg-names = "appl", "config", "atu_dma", "dbi";
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		num-lanes = <8>;
+		num-viewport = <8>;
+		linux,pci-domain = <5>;
+
+		clocks = <&bpmp TEGRA234_CLK_PEX1_C5_CORE>;
+		clock-names = "core";
+
+		resets = <&bpmp TEGRA234_RESET_PEX1_CORE_5_APB>,
+			 <&bpmp TEGRA234_RESET_PEX1_CORE_5>;
+		reset-names = "apb", "core";
+
+		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
+			     <GIC_SPI 54 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
+		interrupt-names = "intr", "msi";
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;
+
+		nvidia,bpmp = <&bpmp 5>;
+
+		nvidia,aspm-cmrt-us = <60>;
+		nvidia,aspm-pwr-on-t-us = <20>;
+		nvidia,aspm-l0s-entrance-latency-us = <3>;
+
+		bus-range = <0x0 0xff>;
+
+		ranges = <0x43000000 0x27 0x40000000 0x27 0x40000000 0x3 0xe8000000>, /* prefetchable memory (16000 MB) */
+			 <0x02000000 0x0  0x40000000 0x2b 0x28000000 0x0 0x08000000>, /* non-prefetchable memory (128 MB) */
+			 <0x01000000 0x0  0x3a100000 0x00 0x3a100000 0x0 0x00100000>; /* downstream I/O (1 MB) */
+
+		interconnects = <&mc TEGRA234_MEMORY_CLIENT_PCIE5R &emc>,
+				<&mc TEGRA234_MEMORY_CLIENT_PCIE5W &emc>;
+		interconnect-names = "dma-mem", "write";
+
+                phys = <&p2u_nvhs_0>, <&p2u_nvhs_1>, <&p2u_nvhs_2>,
+                       <&p2u_nvhs_3>, <&p2u_nvhs_4>, <&p2u_nvhs_5>,
+                       <&p2u_nvhs_6>, <&p2u_nvhs_7>;
+                phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3", "p2u-4",
+                            "p2u-5", "p2u-6", "p2u-7";
+	};
-- 
2.17.1

