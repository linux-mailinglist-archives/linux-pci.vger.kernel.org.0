Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E44BF5731E2
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jul 2022 11:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbiGMJBe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Jul 2022 05:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbiGMJBX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 13 Jul 2022 05:01:23 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46889E6802;
        Wed, 13 Jul 2022 02:01:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GTr/b3F/GEAEX7e36eVf0x/w8tUhVoYDo81J1PztufdSfdDsZoWQtDtNg0GpuVSMflqbagLr1cX4qZWmj7lxM1/ftzHnEHXO1Hra0H2EQVe3qUPOTWa0rSCvkIbEX2MuCDSx94ltWWp4z/a/WCmwwMFpPVGLW41BGwhbdn61kvlXpbkqeLkP0d4DR1Raff/XReUkr02A4w8+6aVyiBcUzXUTY4Z+a86QItEPssPjuzfTszOXFKrJv/PMzPrJY5J5X++oOudZ6oTbMANjEHZkLqmMq/Iv/tOtCQmm8EtbQ9fRYPSbbYnvx2CGIRnxO4QeLm63rPsb3E8i7MLgzgirjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vM3WpLVsyyWWLhAplbZ44zgduNVkVCtHEQAoL0dE3ME=;
 b=SadSMDD+wyVxK7LhoFxMAmrdA1EL5G2VGr5hY2ZBGULGHeA89YK9W7Qj+2AZG4jKqEDd4rGLYq+ylfaHlRpavmuE0rP91htnXaDA+Jadn9soXl+yYEbGU6JtRIltnCY1HHgDQq1fyebduKt3Dq8Sc50DH8rsHERe7FRbtXe037TiTMz+ozewIwkonL4HaPs4Z7hXoiMZuQJ47JqubbFdyIhGB6b1Wn0EDsvTJNvuKU253pUe2ozFLIAuoX9g5aRv1dFYsNqi957Rc+sD2RuXU2xUO2dZrLNIhU/aMH7V0liMM8QT62mpSuri65AqiZsk13u9qXl+WunbrzDx1I81SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vM3WpLVsyyWWLhAplbZ44zgduNVkVCtHEQAoL0dE3ME=;
 b=i2FlvJZf/Wv5kWsa3c/JNARvmk+IDKHgEDggmwkLmpvA3ChBYTFaLflAQVR3REjp29dKMmCWebglbZG/CypjRyQ5vjA2ydQUGuDWAD7Z+1Iox3GDbJUf6CVD54iovRv5Ot7/ADd7Fa5Zxxz0nTL4LtDhhpujR1YyECF3IH4VBTmibH7z/tTaJ0LAY+W0kwn/xoUziNVZz35CncTBDv0eLNBIvVrbWplAfeadv4yBCfQk9TCgk0fu+HqAVHhnIJ1la2omxVh6hcya/xtXaLJ6E9JTzjsdKhGhqopYgbUivoR2PNgjHknzjYG7WX84QYKHQ/hAgZTmdmU+DlSC43yIxg==
Received: from BN0PR04CA0184.namprd04.prod.outlook.com (2603:10b6:408:e9::9)
 by SN6PR12MB2784.namprd12.prod.outlook.com (2603:10b6:805:68::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Wed, 13 Jul
 2022 09:01:20 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e9:cafe::a0) by BN0PR04CA0184.outlook.office365.com
 (2603:10b6:408:e9::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Wed, 13 Jul 2022 09:01:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5438.12 via Frontend Transport; Wed, 13 Jul 2022 09:01:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 13 Jul
 2022 09:01:02 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 13 Jul
 2022 02:01:02 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Wed, 13 Jul 2022 02:00:57 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lpieralisi@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <kw@linux.com>, <kishon@ti.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V5 4/9] arm64: tegra: Add regulators required for PCIe
Date:   Wed, 13 Jul 2022 14:30:24 +0530
Message-ID: <20220713090029.30395-5-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220713090029.30395-1-vidyas@nvidia.com>
References: <20220713090029.30395-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b8a44b7-146e-4783-18ce-08da64ae409a
X-MS-TrafficTypeDiagnostic: SN6PR12MB2784:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3vFY4FVpjrQIdB4OwgE5QwVL+6NERGUHfKF1A/w446FnLJ7BcfCGHuvFzygWiXa7MSmH4XYouIpXGilA04DMLpWWw/khHT1l775/8oMn5fOiNRLCzew/U9hvM3FKk9kd1D0DmcZ8WCJgASJmWydTEMq+bcRw4OdEmOBcDOuLcnRMPaC3K5wgRWDyJW5fV1ZpiTwjHgLm9syQ3mhZ20rwbBJPZ7nf3hqsF4H40iMKnRBFV35U90GSI3cQu+AOpRnQ61FxjrsGAGkuZdkeT+HPpVIaX/O3Yf+Ijl5oNPLq5HVmhIr6EnjFSsnvd+g3Fv525BA+TIYPlSwwXG0AzDirZzYUCeC3Q1rylEts7TksUFQqG0fhMQWAjdGHHwevtGLvj9tkT06clvuYoL8NF6LR+cZpqqY/sCwa/V8q5EC2xg2fwEeSfLyXsrrim+oSNEbj8LGhZM2appK3dlZgiyFLPFs+kiw8R8sT5BE26sArY66zbV8/GJmx8hmZXoNKqspBz6sF+NwmMysYRrRwKsG2A3PBw1VQ++Sp+jC2tw+oQXaG75w/EJ7u69dqIVsBjyku9UTostmQ8DctdqMCUS7RCU05XdKHq/2Lu/zL5WCa36BDVGMIuNnv+PWBrogs8VGfSpTZR2L5YOcs0lU5oxKuwAwiBQ6dsnWqSxlAJIO+wzsiazm6u7CpVUwQRFdGSlAUtDDr/phyVvkjL68wVtt/Q9wWJhGBOA9HYbqb6vzBSPkQCAPcK905NfjMn1wRiuMV2fQkv0CvVTypr7cWf1q08gQqacy6n9GY3qK4huj0bUIEjCFwjxtYN0tpTtF8xNFFBawxhsY1yPs9a6jyyZLhXEpw3DLwBD9EQrCoAnpXX5GWK1WFX/CSZ0t/Gnu7jQgJ
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(346002)(39860400002)(396003)(40470700004)(36840700001)(46966006)(86362001)(6666004)(41300700001)(40460700003)(2906002)(82310400005)(478600001)(26005)(40480700001)(1076003)(8936002)(7696005)(7416002)(5660300002)(426003)(110136005)(81166007)(336012)(47076005)(36860700001)(70206006)(356005)(82740400003)(70586007)(54906003)(4326008)(36756003)(186003)(8676002)(2616005)(316002)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2022 09:01:19.5555
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b8a44b7-146e-4783-18ce-08da64ae409a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB2784
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
V5:
* None

V4:
* Addressed review comments from Krzysztof
* Moved all regulator definitions to tegra234-p3701-0000.dtsi file

V3:
* New patch in this series

 .../boot/dts/nvidia/tegra234-p3701-0000.dtsi  | 36 +++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi b/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
index 798de9226ba5..9e4d72cfa69f 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3701-0000.dtsi
@@ -6,6 +6,42 @@ / {
 	model = "NVIDIA Jetson AGX Orin";
 	compatible = "nvidia,p3701-0000", "nvidia,tegra234";
 
+	vdd_1v8_ls: regulator-vdd-1v8-ls {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_1V8_LS";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	vdd_1v8_ao: regulator-vdd-1v8-ao {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_1V8_AO";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
+	vdd_3v3_pcie: regulator-vdd-3v3-pcie {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_3V3_PCIE";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		gpio = <&gpio TEGRA234_MAIN_GPIO(Z, 2) GPIO_ACTIVE_HIGH>;
+		regulator-boot-on;
+		enable-active-high;
+	};
+
+	vdd_12v_pcie: regulator-vdd-12v-pcie {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_12V_PCIE";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		gpio = <&gpio TEGRA234_MAIN_GPIO(A, 1) GPIO_ACTIVE_LOW>;
+		regulator-boot-on;
+		enable-active-low;
+	};
+
 	bus@0 {
 		spi@3270000 {
 			status = "okay";
-- 
2.34.1

