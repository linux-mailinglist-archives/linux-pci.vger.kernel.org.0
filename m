Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCE5B55F605
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 08:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiF2GFY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 02:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbiF2GFV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 02:05:21 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2087.outbound.protection.outlook.com [40.107.96.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C581CFD9;
        Tue, 28 Jun 2022 23:05:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBxL+GRJ4n1yQuEAfpvbpG2xzzbviZ0YhgV6yWZmlWT/c921eJS4eltZI4MFr/BrKzM7rKj8cHwTupClBLiM6U5EFjf07J+FabMX0FVGHGdbIaIazLOFz1kLpXW8ShK3XhwxjbptPzMRUCbtCD8OW8iLO3aCMmfsKW3mjmHR5EoYIcKbWjX4vri55eXcCUIOBEPg3c2KtlSL0XfugSPPc8QfLb263D3ljJ1fPhnHQRhPn+/r9dMgGa/YXuJIVzNUCQP8+WVHCmicV+v5ytfVOf02Ygcl3119JtXplbChc4qK/5cus4KjLbXMG5S5Dyay8cxW5THBlH87HCc2y5+rFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AN1skqib+xD3Yc7aZGIaZn3nuxKppngaWrJKKIOjOGA=;
 b=CYeBz2qJwfIHTbY2sFr/Tt7K0g3c1dElQUxhxSSumlt9Ek0kR2IyWoqy2814dbFJ+brJKjzJsTi3wWa3SbjUldbu1Gtu3Q+tPnxB6aUNJetTOrWa+TjgIE4wKF9J8t5xIfMmDQxMFpk0pqJvaPQgmuzONIA+j7+Iiz6ONBfMyiZu3VpQAMT055jAacyOrURim+3374ULO4vz9OaoVrewflDsxpMh335vHWCK+7Yc+H1ovesTM/KjKvZDolZ4DSJRY8InwXUCnvawyHmJlrLY5DwDLTT3CxZLK762iniG86nb/ASUs7eb/XpdrLrKqyuDwQ5KiG5ZsyNJEtZLUkFamw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=ti.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AN1skqib+xD3Yc7aZGIaZn3nuxKppngaWrJKKIOjOGA=;
 b=MLIj5ZMgQ1mhGY6eYCu4xeWKGmEF0Ul8zyPXp43OF/+bIU39wl4l8qz4XW22B/3fF28AAPMCyYpyk39E0nDCa5hTTJr4Vd2BBLSIAjvhZV3icBikrHKogsyd/6twBkrsMnIqUcdPsqtneNVu54r8c9BsD/vLFg5YJZdo83AtxDnpVGi56pJUgrwX9ZRZROHgOEebPydUOWDjwc+xx0uvuV7rH4RomSGVyQHfFeIYUxy5eZY3sSOk6L9mk0FOLVb+tUf2sDtubuztXM1HvO70L4xltQlmUyFKiJTnlyU0/HWHnzpwJ1tklAbaleDEw/UI+pcCNX1OlJA9DFzNrU5oYQ==
Received: from DM6PR02CA0115.namprd02.prod.outlook.com (2603:10b6:5:1b4::17)
 by BL0PR12MB4690.namprd12.prod.outlook.com (2603:10b6:208:8e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Wed, 29 Jun
 2022 06:05:16 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b4:cafe::eb) by DM6PR02CA0115.outlook.office365.com
 (2603:10b6:5:1b4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16 via Frontend
 Transport; Wed, 29 Jun 2022 06:05:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 06:05:16 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 29 Jun
 2022 06:05:15 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 28 Jun
 2022 23:05:15 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Tue, 28 Jun 2022 23:05:10 -0700
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
Subject: [PATCH V3 05/11] arm64: tegra: Add regulators required for PCIe
Date:   Wed, 29 Jun 2022 11:34:29 +0530
Message-ID: <20220629060435.25297-6-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220629060435.25297-1-vidyas@nvidia.com>
References: <20220629060435.25297-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 851b2c36-408c-4841-93e4-08da599556ad
X-MS-TrafficTypeDiagnostic: BL0PR12MB4690:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8eXyDI9Hiw/iW2XfxNkN4E3QVCsdIyQpsb4T170nd9JRMmVcsNv30ea2+c1ICUKV20hjZsY9Qmgj3tQdUBstl0vjNrZ+5WEX6QfjPIZmLmOHI0+NtRQ/4LvURbjhrQT1KLtXRUtKVAv4dhhDHIdnGcm4O1C5iR8P47L9Y3LOgj4D97W3yPr4f2pNiQvrafT6qZuXC1DRNXrfklcWL57lIriyKvXDAuFhRvLm5T+XPdAE069cfaL2Pcm++WBdsqbnrlAerghd7xOU/PPUaJoa27jdAWh4eM+sZgS9q8wVzmRPb/P6TWzQ6pQgGh9fMV6nGDlxrOkYn/jyCMUIOvfm0WKOtPSiVxUxpm3zY6Cobg69UU+BiA1SniHT0p5Jc6JnzwB/S6jRtZ/L5tlcgsrxBU2YRaLCja8erbM9KligWt2u6xO2OK01AD4pwzeJfAyRainED0HffSbhzAAIJ4DyxwViwqUd4OYjf2ogeneRcvUZaNzlw5ipH65PDSkUQZewiOQTmt5UZHUSjL7KcP7n15wXgFMH2BtigyT+KiQrTDO2Em+DPNiYT3p3JqlIFjBDfA07Qbkdkixp3NsJm21JzvVvINk+BKzn3HkFlWdzuOyQ3bPJugaPIvKqAO0NMfNypy3vbXXY1KWCMoPUdoHWCJ3ksoH23y9xwsOOpDx/nyJ5vY9HtyOr8BuZFNSM+AWJ2fQowO3bEdor8FV3yoXOAg71/9cQ6luB4eqB61V7JaQmrR2IVOX+GX4m8sIJ9BWDCfk+OoSwPa5VWMuzB1kYGEZZc1PMSJhm42oOAZ2KPPTjgdXOZj6rLI2Cgg1/bbS5FojbLKiF/G9ieMjGBuIVsg==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(346002)(396003)(36840700001)(40470700004)(46966006)(1076003)(7416002)(47076005)(36860700001)(186003)(426003)(336012)(40480700001)(86362001)(356005)(2906002)(36756003)(5660300002)(110136005)(6636002)(6666004)(8936002)(40460700003)(8676002)(41300700001)(7696005)(26005)(81166007)(82740400003)(54906003)(2616005)(70586007)(70206006)(82310400005)(4326008)(316002)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 06:05:16.4311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 851b2c36-408c-4841-93e4-08da599556ad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4690
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add regulator supplies required for PCIe functionality. The supplies
include 1.8V, 3.3V and 12V.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* New patch in this series

 .../boot/dts/nvidia/tegra234-p3701-0000.dtsi  | 24 +++++++++++++++++++
 .../boot/dts/nvidia/tegra234-p3737-0000.dtsi  | 23 ++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
index 798de9226ba5..d53901ba45f6 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
@@ -6,6 +6,30 @@
 	model = "NVIDIA Jetson AGX Orin";
 	compatible = "nvidia,p3701-0000", "nvidia,tegra234";
 
+	fixed-regulators {
+		compatible = "simple-bus";
+		device_type = "fixed-regulators";
+		#address-cells = <0x1>;
+		#size-cells = <0x0>;
+
+		p3701_vdd_1v8_ls: regulator@3 {
+			compatible = "regulator-fixed";
+			reg = <3>;
+			regulator-name = "vdd-1v8-ls-sw5";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+		p3701_vdd_AO_1v8: regulator@5 {
+			compatible = "regulator-fixed";
+			reg = <5>;
+			regulator-name = "vdd-AO-1v8-sw2";
+			regulator-min-microvolt = <1800000>;
+			regulator-max-microvolt = <1800000>;
+			regulator-always-on;
+		};
+	};
+
 	bus@0 {
 		spi@3270000 {
 			status = "okay";
diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi
index a85993c85e45..bb503643dd38 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000.dtsi
@@ -2,4 +2,27 @@
 
 / {
 	compatible = "nvidia,p3737-0000";
+
+	fixed-regulators {
+		p3737_vdd_3v3_pcie: regulator@105 {
+			compatible = "regulator-fixed";
+			reg = <105>;
+			regulator-name = "vdd-3v3-pcie";
+			regulator-min-microvolt = <3300000>;
+			regulator-max-microvolt = <3300000>;
+			gpio = <&gpio TEGRA234_MAIN_GPIO(Z, 2) 0>;
+			enable-active-high;
+			regulator-boot-on;
+		};
+		p3737_vdd_12v_pcie: regulator@114 {
+			compatible = "regulator-fixed";
+			reg = <114>;
+			regulator-name = "vdd-12v-pcie";
+			regulator-min-microvolt = <12000000>;
+			regulator-max-microvolt = <12000000>;
+			gpio = <&gpio TEGRA234_MAIN_GPIO(A, 1) 1>;
+			regulator-boot-on;
+			enable-active-low;
+		};
+	};
 };
-- 
2.17.1

