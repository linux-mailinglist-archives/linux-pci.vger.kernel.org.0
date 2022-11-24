Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB4F8637419
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 09:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbiKXIgY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 03:36:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229940AbiKXIgU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 03:36:20 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8405AF241A;
        Thu, 24 Nov 2022 00:36:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgRyjfZvWosYH7ldx6t4NSjaODqLqOis6CaOw5JTMOEkEcS6Uifu7tnlQ1a++K7LGfpT0sk/X6NVoly1E3Qes6iyA8Bm2+8Orl5jwF/E8Gpq/mP1wjidNRmMZzBBj9MsV9ERG8OIrVkmW1aaXq3EuIdc1xMAWaY0XvJCBPq5d4RNVzeStWeG1aZ6SkjS+rtJa2PXhfEdAElVH4eHu4/sKG3IlY3TpgOilCVp7Y8A7y9Qgp1rQCN0zDU4pzbl4BqZEfPW0FGyKwJf3d9XEoDxmQPto4hIzzmxK+HTDquExV82283gp7kK9WeGf3APY0qu77jQVEucgmmuADgF4AYbHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qi2kNenpffnaO+SSPdyB5MFvI8nnyx/vmr5uEmYT3pY=;
 b=IhU4pvOaSw2x67cct/eyb8mepgI+4UZL7ywXuD2rfLrGWQHAap/qzOCA3LgbJxv8tg84aKM3xWGk481DKUA6iLvIC2DOnhJDsN5QZHWX9Ek9oOM/J0pzKXPEQyh97f+3YTEJx8LfJX7eNFmN5VrcwBvy/ftEce5MG5S60tmdGrt6QX8cMI0FDvWgOaxpZo7hyNfmXmB04yz2myAxwHluUpeOt0xuMbJqxHy8VoDDZw7B2R8whP0P3a6lFewUISJqG66zqAGXpmLyoW5LHtKA4ErAYq6ISgbOeWEaUpSy9cE78/qEkqJamOIaZ1vNDdnw3MiLaWqQjpNMBI3xkY6LtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qi2kNenpffnaO+SSPdyB5MFvI8nnyx/vmr5uEmYT3pY=;
 b=E0pewIAeUBL/UELn2TQ5/53haBNY3FtoCXQZiC1DrtfZRkkKRgMrZOs0RLJ95H+KbcRqSKIp0dBUuxyApMe43WxM7VkuTxMqQfzgrBn0frNQFtBoNxzjJ32GqWtt7SBsyEOP8J1NDJFzmBsf8cevJL0sDKa3hUN8HdtVdoAEJlJq7oeLzM1tyA6aYmlCsYr6ezu5LqIcNX5JWzlSTBjvcdPsbZMnrtQYBbQN2yJ2ZY6keMX8oxx1yiz9eOTx717QYNqbJ/yK8GmDr1OFzQp/Dx3zxGdOxGjn/4FeRWnSNKfM82FZZ/UksApQsRMRDqEvMyqOYrRO9RhjXDqWv+kBWQ==
Received: from DM6PR08CA0043.namprd08.prod.outlook.com (2603:10b6:5:1e0::17)
 by DM4PR12MB5087.namprd12.prod.outlook.com (2603:10b6:5:38a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19; Thu, 24 Nov
 2022 08:36:17 +0000
Received: from DM6NAM11FT106.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1e0:cafe::94) by DM6PR08CA0043.outlook.office365.com
 (2603:10b6:5:1e0::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.19 via Frontend
 Transport; Thu, 24 Nov 2022 08:36:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DM6NAM11FT106.mail.protection.outlook.com (10.13.172.229) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.18 via Frontend Transport; Thu, 24 Nov 2022 08:36:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 24 Nov
 2022 00:36:06 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.36; Thu, 24 Nov
 2022 00:36:05 -0800
Received: from mmaddireddy-ubuntu.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.36 via Frontend
 Transport; Thu, 24 Nov 2022 00:36:01 -0800
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
To:     <vkoul@kernel.org>, <kishon@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <vidyas@nvidia.com>
CC:     <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <nkristam@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>
Subject: [PATCH 2/3] arm64: tegra: Add uphy lane number and intr in p2u nodes
Date:   Thu, 24 Nov 2022 14:05:09 +0530
Message-ID: <20221124083510.3008139-3-mmaddireddy@nvidia.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221124083510.3008139-1-mmaddireddy@nvidia.com>
References: <20221124083510.3008139-1-mmaddireddy@nvidia.com>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT106:EE_|DM4PR12MB5087:EE_
X-MS-Office365-Filtering-Correlation-Id: 39f04390-7b88-4dc3-c13e-08dacdf6f4b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MzjgdzBoX6yhjWPH73T25RLK+YLd8t0DE2KWl2U/XjoP2d0xWZgYxbEAi7fpj39GWUzuns2H4/dYEFUBfuVFbAgK+ZqaZ+KPZoPbq7/sI2inLOd5RWArzVn7Ck1rBr+Dir2HZmZ4lSlvui1IDBP7oSxuBnMXPV0w0Ia8im8wcHI7bCZphRERbPUTOjhm1PB7ysfnbAVmh2WuhUa3STp4bC3k3xqWIdv82JO0axoe/3o2c5vTBbRERa2p3IH5PuOw9v5bkvAtcnkb5CxoSKmuiZ2uqF0d1Xl13u7h+9j3CniDlC9jDRVirFn/XL88Nd8rdjmMD8SnesH9VL67XW+raBZmDeMst/z/F4AgA1L7U10iYYdUapL4975iNMzFAW9INxECpEA+bndVe2hPJm1tl4SvFcrngDAOQbkBIYa9jpInk8QHujz7jBTDSwsAJyAXkCNhlWpWxXEVriFu9svxrRYrn7tHP1FAUobgSX8IVs4UolT0y6yzuYJJi1C5YY8x7YTlkqnCi7jrsKGDIfPXjYfD/yzQ8yiCVmp6quDx2+Rn5gOUMkTXYGsb/l+j8+e6L99BvmIk76VeIrs/kG5BRLSKun3Xsbw+wLbH/u2I7aPaIoXfb3R0bi/OB9bnvkAJzj7rjd0PgeeRISzpuvxC8JZgzDqLEr7znsjV+LZ03C3v/L1tFOJFTDGPtQ6HKlNS9GYOHAJJcKZjt3s9LL8Vfcwv5PqUV+/t4bKlT8A6SC0=
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(7416002)(5660300002)(2906002)(36756003)(356005)(7636003)(70206006)(70586007)(4326008)(8676002)(110136005)(6636002)(86362001)(54906003)(316002)(8936002)(41300700001)(82310400005)(478600001)(7696005)(26005)(107886003)(40480700001)(426003)(47076005)(36860700001)(2616005)(336012)(186003)(1076003)(40460700003)(82740400003)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 08:36:17.6050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39f04390-7b88-4dc3-c13e-08dacdf6f4b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT106.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5087
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

UPHY lane number is required to exchange lane margin data between P2U
and UPHY. Add uphy lane number in p2u device tree nodes.

Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 120 +++++++++++++++++++++++
 1 file changed, 120 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index eaf05ee9acd1..ec8a28a9d380 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -1109,6 +1109,11 @@ p2u_hsio_0: phy@3e00000 {
 			reg = <0x03e00000 0x10000>;
 			reg-names = "ctl";
 
+			interrupts = <0 336 0x04>;
+			interrupt-names = "intr";
+
+			nvidia,bpmp = <&bpmp 0>;
+
 			#phy-cells = <0>;
 		};
 
@@ -1117,6 +1122,11 @@ p2u_hsio_1: phy@3e10000 {
 			reg = <0x03e10000 0x10000>;
 			reg-names = "ctl";
 
+			interrupts = <0 337 0x04>;
+			interrupt-names = "intr";
+
+			nvidia,bpmp = <&bpmp 1>;
+
 			#phy-cells = <0>;
 		};
 
@@ -1125,6 +1135,11 @@ p2u_hsio_2: phy@3e20000 {
 			reg = <0x03e20000 0x10000>;
 			reg-names = "ctl";
 
+			interrupts = <0 338 0x04>;
+			interrupt-names = "intr";
+
+			nvidia,bpmp = <&bpmp 2>;
+
 			#phy-cells = <0>;
 		};
 
@@ -1133,6 +1148,11 @@ p2u_hsio_3: phy@3e30000 {
 			reg = <0x03e30000 0x10000>;
 			reg-names = "ctl";
 
+			interrupts = <0 339 0x04>;
+			interrupt-names = "intr";
+
+			nvidia,bpmp = <&bpmp 3>;
+
 			#phy-cells = <0>;
 		};
 
@@ -1141,6 +1161,11 @@ p2u_hsio_4: phy@3e40000 {
 			reg = <0x03e40000 0x10000>;
 			reg-names = "ctl";
 
+			interrupts = <0 340 0x04>;
+			interrupt-names = "intr";
+
+			nvidia,bpmp = <&bpmp 4>;
+
 			#phy-cells = <0>;
 		};
 
@@ -1149,6 +1174,11 @@ p2u_hsio_5: phy@3e50000 {
 			reg = <0x03e50000 0x10000>;
 			reg-names = "ctl";
 
+			interrupts = <0 341 0x04>;
+			interrupt-names = "intr";
+
+			nvidia,bpmp = <&bpmp 5>;
+
 			#phy-cells = <0>;
 		};
 
@@ -1157,6 +1187,11 @@ p2u_hsio_6: phy@3e60000 {
 			reg = <0x03e60000 0x10000>;
 			reg-names = "ctl";
 
+			interrupts = <0 342 0x04>;
+			interrupt-names = "intr";
+
+			nvidia,bpmp = <&bpmp 6>;
+
 			#phy-cells = <0>;
 		};
 
@@ -1165,6 +1200,11 @@ p2u_hsio_7: phy@3e70000 {
 			reg = <0x03e70000 0x10000>;
 			reg-names = "ctl";
 
+			interrupts = <0 343 0x04>;
+			interrupt-names = "intr";
+
+			nvidia,bpmp = <&bpmp 7>;
+
 			#phy-cells = <0>;
 		};
 
@@ -1173,6 +1213,11 @@ p2u_nvhs_0: phy@3e90000 {
 			reg = <0x03e90000 0x10000>;
 			reg-names = "ctl";
 
+			interrupts = <0 344 0x04>;
+			interrupt-names = "intr";
+
+			nvidia,bpmp = <&bpmp 8>;
+
 			#phy-cells = <0>;
 		};
 
@@ -1181,6 +1226,11 @@ p2u_nvhs_1: phy@3ea0000 {
 			reg = <0x03ea0000 0x10000>;
 			reg-names = "ctl";
 
+			interrupts = <0 345 0x04>;
+			interrupt-names = "intr";
+
+			nvidia,bpmp = <&bpmp 9>;
+
 			#phy-cells = <0>;
 		};
 
@@ -1189,6 +1239,11 @@ p2u_nvhs_2: phy@3eb0000 {
 			reg = <0x03eb0000 0x10000>;
 			reg-names = "ctl";
 
+			interrupts = <0 346 0x04>;
+			interrupt-names = "intr";
+
+			nvidia,bpmp = <&bpmp 10>;
+
 			#phy-cells = <0>;
 		};
 
@@ -1197,6 +1252,11 @@ p2u_nvhs_3: phy@3ec0000 {
 			reg = <0x03ec0000 0x10000>;
 			reg-names = "ctl";
 
+			interrupts = <0 347 0x04>;
+			interrupt-names = "intr";
+
+			nvidia,bpmp = <&bpmp 11>;
+
 			#phy-cells = <0>;
 		};
 
@@ -1205,6 +1265,11 @@ p2u_nvhs_4: phy@3ed0000 {
 			reg = <0x03ed0000 0x10000>;
 			reg-names = "ctl";
 
+			interrupts = <0 348 0x04>;
+			interrupt-names = "intr";
+
+			nvidia,bpmp = <&bpmp 12>;
+
 			#phy-cells = <0>;
 		};
 
@@ -1213,6 +1278,11 @@ p2u_nvhs_5: phy@3ee0000 {
 			reg = <0x03ee0000 0x10000>;
 			reg-names = "ctl";
 
+			interrupts = <0 349 0x04>;
+			interrupt-names = "intr";
+
+			nvidia,bpmp = <&bpmp 13>;
+
 			#phy-cells = <0>;
 		};
 
@@ -1221,6 +1291,11 @@ p2u_nvhs_6: phy@3ef0000 {
 			reg = <0x03ef0000 0x10000>;
 			reg-names = "ctl";
 
+			interrupts = <0 350 0x04>;
+			interrupt-names = "intr";
+
+			nvidia,bpmp = <&bpmp 14>;
+
 			#phy-cells = <0>;
 		};
 
@@ -1229,6 +1304,11 @@ p2u_nvhs_7: phy@3f00000 {
 			reg = <0x03f00000 0x10000>;
 			reg-names = "ctl";
 
+			interrupts = <0 351 0x04>;
+			interrupt-names = "intr";
+
+			nvidia,bpmp = <&bpmp 15>;
+
 			#phy-cells = <0>;
 		};
 
@@ -1237,6 +1317,11 @@ p2u_gbe_0: phy@3f20000 {
 			reg = <0x03f20000 0x10000>;
 			reg-names = "ctl";
 
+			interrupts = <0 203 0x04>;
+			interrupt-names = "intr";
+
+			nvidia,bpmp = <&bpmp 16>;
+
 			#phy-cells = <0>;
 		};
 
@@ -1245,6 +1330,11 @@ p2u_gbe_1: phy@3f30000 {
 			reg = <0x03f30000 0x10000>;
 			reg-names = "ctl";
 
+			interrupts = <0 220 0x04>;
+			interrupt-names = "intr";
+
+			nvidia,bpmp = <&bpmp 17>;
+
 			#phy-cells = <0>;
 		};
 
@@ -1253,6 +1343,11 @@ p2u_gbe_2: phy@3f40000 {
 			reg = <0x03f40000 0x10000>;
 			reg-names = "ctl";
 
+			interrupts = <0 221 0x04>;
+			interrupt-names = "intr";
+
+			nvidia,bpmp = <&bpmp 18>;
+
 			#phy-cells = <0>;
 		};
 
@@ -1261,6 +1356,11 @@ p2u_gbe_3: phy@3f50000 {
 			reg = <0x03f50000 0x10000>;
 			reg-names = "ctl";
 
+			interrupts = <0 222 0x04>;
+			interrupt-names = "intr";
+
+			nvidia,bpmp = <&bpmp 19>;
+
 			#phy-cells = <0>;
 		};
 
@@ -1269,6 +1369,11 @@ p2u_gbe_4: phy@3f60000 {
 			reg = <0x03f60000 0x10000>;
 			reg-names = "ctl";
 
+			interrupts = <0 108 0x04>;
+			interrupt-names = "intr";
+
+			nvidia,bpmp = <&bpmp 20>;
+
 			#phy-cells = <0>;
 		};
 
@@ -1277,6 +1382,11 @@ p2u_gbe_5: phy@3f70000 {
 			reg = <0x03f70000 0x10000>;
 			reg-names = "ctl";
 
+			interrupts = <0 109 0x04>;
+			interrupt-names = "intr";
+
+			nvidia,bpmp = <&bpmp 21>;
+
 			#phy-cells = <0>;
 		};
 
@@ -1285,6 +1395,11 @@ p2u_gbe_6: phy@3f80000 {
 			reg = <0x03f80000 0x10000>;
 			reg-names = "ctl";
 
+			interrupts = <0 110 0x04>;
+			interrupt-names = "intr";
+
+			nvidia,bpmp = <&bpmp 22>;
+
 			#phy-cells = <0>;
 		};
 
@@ -1293,6 +1408,11 @@ p2u_gbe_7: phy@3f90000 {
 			reg = <0x03f90000 0x10000>;
 			reg-names = "ctl";
 
+			interrupts = <0 111 0x04>;
+			interrupt-names = "intr";
+
+			nvidia,bpmp = <&bpmp 23>;
+
 			#phy-cells = <0>;
 		};
 
-- 
2.25.1

