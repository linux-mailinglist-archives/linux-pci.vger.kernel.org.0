Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DA14AAA01
	for <lists+linux-pci@lfdr.de>; Sat,  5 Feb 2022 17:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380260AbiBEQWq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Feb 2022 11:22:46 -0500
Received: from mail-bn8nam11on2055.outbound.protection.outlook.com ([40.107.236.55]:39703
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1378458AbiBEQWn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 5 Feb 2022 11:22:43 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JJN4KjMy6XJfcqK2tkEkl7yGMINEJU/exkeRfkcnHe43ex8SeLQQWetpCUMIeKEmRNr+yoZFrM6zFQY3uX7Pw8rBaqqoJkipK/lyEIbiqi8IfRM0+WUs7KOHhKziqTBXfrDVaiBnqnqoTCoI0uoxMEShh4t7XcZK7QeExtjKGkURIgx5sg4kDXaQWfXNHXrA35WJVLEP91vkWlqpFpJDP30zHZnfzLQtzTpzwqXMVfRFIF/+G/w7/i5nk87G18rFCEDOEyeUuqreHXDMW1qZdYABAny958Y3h7xN4vt0HskdA9SQ+AwjkkXjeeGY/myEAtClzpNmEQsln3Yxb1XPmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OqRwC/J6Jp/3rbK63SV//aaUdd98FmBmDjuz/83c1UU=;
 b=PqsBc8nMOHd+7VwAOIbrsO2Zf6774nuNLk3tavVVCyRi/LV+njy5IWyVFbOcmG6vAKZ+XRoYKdFDY79ZvhXFiYY1QkLU/SnRBusF07eMuX9o9YOyRShaC7tbSzCstGmnR/ATvmsmPgpZb+DpNpykaXaqoEgX7vJbMiv+2l/Ih6URQJp+2ij0qPr45oyL049XEYXvH/+Lhq1XcCEKEy/F8riKMGETmHUfuLpbwXobC/7dLYdAyg6+0EvrAQokqug+hCByKkQg+mMyj4xrezgg3DgDpt1paS9kJNW2JeI0xj3ieWCY24cpMqKU9xdjh6CNf8UIoAkWhCr63Eflg5gm6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=ti.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OqRwC/J6Jp/3rbK63SV//aaUdd98FmBmDjuz/83c1UU=;
 b=LwgV/t+HUGDrzwgKlSiaIMXubWg9SUrqxgq7+dR4S6zMAsNNnqbPIAoo5url5k+GTzVd188yg3v9Tipm8kEduHqcWWJI5Ab9P8fe6ZmjeNPmC3kpV/u2rxsOoZu8LKTHmgYLvVudxHAPZfH6uAbH0UFsbBYdAIFRzJv4vNadZI2JhtZS0Kq6898HUtdDoUDD+WxgVYt9bIKGlIBIe3/D1I2q8jlzBXDz0vutEx+3lTuRtjFloGl8U5BXwr5Y2jQRKrSQj/GHgyBvT24FmaCm/Kla0p6Ez8OAQJvcMkwQd/tYy4kGrkNNmyfiKGNUtjH5iHe6j6bzhRsM6+YaNszHHw==
Received: from MWHPR07CA0002.namprd07.prod.outlook.com (2603:10b6:300:116::12)
 by BN6PR12MB1505.namprd12.prod.outlook.com (2603:10b6:405:5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Sat, 5 Feb
 2022 16:22:41 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:116:cafe::55) by MWHPR07CA0002.outlook.office365.com
 (2603:10b6:300:116::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.11 via Frontend
 Transport; Sat, 5 Feb 2022 16:22:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 16:22:39 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL109.nvidia.com
 (10.27.9.19) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sat, 5 Feb
 2022 16:22:39 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Sat, 5 Feb 2022
 08:22:38 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Sat, 5 Feb 2022 08:22:33 -0800
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lorenzo.pieralisi@arm.com>,
        <robh+dt@kernel.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <kishon@ti.com>, <vkoul@kernel.org>, <kw@linux.com>,
        <krzysztof.kozlowski@canonical.com>, <p.zabel@pengutronix.de>,
        <mperttunen@nvidia.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <kthota@nvidia.com>, <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>,
        <sagar.tv@gmail.com>
Subject: [PATCH V1 05/10] dt-bindings: PCI: tegra: Add device tree support for Tegra234
Date:   Sat, 5 Feb 2022 21:51:39 +0530
Message-ID: <20220205162144.30240-6-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220205162144.30240-1-vidyas@nvidia.com>
References: <20220205162144.30240-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8074b172-4a96-4c32-823b-08d9e8c3baad
X-MS-TrafficTypeDiagnostic: BN6PR12MB1505:EE_
X-Microsoft-Antispam-PRVS: <BN6PR12MB1505DBD486DB126EFDE54CDFB82A9@BN6PR12MB1505.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JA9ZzVM4KeZR52S3/SDzjORS9m4v9NxAgMRdJdpctIemKNyLM/OjIwJGreS37OjxYhytbi1HhJiPVEGXZACrDKqVQpozbxOMqF1W+xVZphDj0apJfZCVdbGHhfovhWaHz50vC3SdedhcFh8MuVhDdZJRxcKoY83YNSsh8DBEocscakNvmyxKvrsY0zmnL+gZfY1uN+vrhvrqkqgwP+ACy9OmmedsC5k4TOzrv45Rh7pGgDMA9Pg4Eu62G2rsaCg8dH30BuWdVeoxJuIp2aI4G/4vMdcH9XQ5fhYsHnt+NjZ/f8qKAMoX0H5acWrvkLTaY01Cv0xxBz920FZFpUuC7OHj8/wKUSBLF5NFhSxylczmnCO0CJ1uxwGCqwlevgZ8y9CNLeDzUfDBCSS6iA5KzhQvw2xXRCZqx+Bfn6rKh+vxlgjJ3NCw1iTLfR57tK7cpPYqvqoRzad7LcgF1N7c1ICZBq9InzR8uvSijYs1bmxLuFraE+cR4XFX5Wt/fOmK4kydeiJkTmCZjp8S+6LqCUYt7VoiA5N9WD8UuwA9fl0Svv9R6q53GqVh+7/BNrbxUHOiIYwlb32IPY/+8AxrhDfCwezWLqTZgJwKfenAzjbRQh8nWWVyQxvu5eenX1ApfU48d0H1yDdQB3ohWhMOTtaMb+7kA30/AYYESZtHYAheZUN85FyPs77wTQT1Jr8eMR38ElyC4rd8fdGQVc62Ww==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(47076005)(6636002)(36860700001)(86362001)(40460700003)(82310400004)(81166007)(356005)(316002)(70586007)(70206006)(2906002)(5660300002)(7416002)(4326008)(26005)(8936002)(8676002)(2616005)(83380400001)(1076003)(186003)(336012)(426003)(36756003)(7696005)(508600001)(110136005)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 16:22:39.6585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8074b172-4a96-4c32-823b-08d9e8c3baad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1505
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for Tegra234 PCIe controllers. These controllers are based
on Synopsys DesignWare core IP.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
 .../bindings/pci/nvidia,tegra194-pcie.txt     | 106 +++++++++++++++++-
 1 file changed, 103 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra194-pcie.txt
index 8e4f9bfb316d..ae9555a50fb0 100644
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
@@ -243,3 +284,62 @@ Tegra194 EP mode:
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
+		status = "disabled";
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

