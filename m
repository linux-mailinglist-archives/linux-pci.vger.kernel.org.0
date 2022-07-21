Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93DA957CD4E
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 16:22:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbiGUOWB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 10:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbiGUOVq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 10:21:46 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DAE983200;
        Thu, 21 Jul 2022 07:21:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYZPUmxwSYfDVHYsBVh8q46JzY1NTL9qEqsqKFTTGwFdz/bx4sN6XKZyHXqFqumTjAGmzkt3vucWV7zsh7v2RKLx0D/ln51gAzSquVe92KaAyfs3lDausDWHN135e0uM0yBtvSW0BqA3Y5L9WU+Z1gGnM3Q/VWRSs2tAsnI+n07IqXpJBMIwDmI124pPIn5I0h5thNAxGW4Zia56O8KvphdSIGQ6etSK5dek/Tl+5UaHdJwTeQEZ862tIlwytJYGj8s3NKosWFAi/OMqMVlO9uKrkdsE4tcKAyKoio8HHLb4nMQ17ypDlrIUwTvoU6Ft/7g8OZXLpvauwXdROqVLLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSS3r5wGmO7DisUJRQegTcAnpiJ+G8UtfGW4vTvhe00=;
 b=ARsWefcXF4JnkXoyjrC/G4F2I0usmEy/w4S7hp9rrWUchYQFlFFjQSQljL+GiNGCayot7vTNe0IZmS7y80PQCjLE40e4yYFDctD4yP+nUQT+jdAMLTersvLaTFRHGDSiK8jLnzG6GVUclaK+4bwjpp/wBlqC0hSCvzwpeK+V6kN+GS/ErfJjfjk00aQ+QGkAJ7CK5hQIu9NWh7Jv7R3DBAe28brZbR0JLOjIbAEcxKc9/6vripK1IuJiN6RVLsTAPfMceDlrF9QN43aGsmmbd4Rb4ZP4ivhbCbQ74nFOyYL3oOTjedSnOmpo/KJ/CDDzrbTPVZprJGiufGI/i3HAtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSS3r5wGmO7DisUJRQegTcAnpiJ+G8UtfGW4vTvhe00=;
 b=kr7L3ENhcY0pg9LDg/gLp7QPUmAFhcHyjSxzN/lRSLfn6nxjduDVxowZPcXI0rlBqNL83uFDm7KU2SG7pnRHnZv13mJY7YQNBf9FpxltZWLhfiXFqoiT1JJg6F81zJ/qTPuUi1U3ykm8l+A1tCjTLGHq/117e2AOv4r7f/VC3ToWN1s0+ClJuoSe3qA++h8u1VIZ2QN4sx2CY7EKTwxEfnEwOQT2N3OEUw9Xai/zXKa4y+EWBXU3HOL1uA243lUSUA+8QE5PMn6LSXLW31LPfYeBnXim/kx4i3v3NsWITE6SrH0TMvi9CO0pNenLie2iiE94U8cSJeP4iTCVjA4ZMA==
Received: from DM5PR08CA0060.namprd08.prod.outlook.com (2603:10b6:4:60::49) by
 MWHPR12MB1936.namprd12.prod.outlook.com (2603:10b6:300:114::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19; Thu, 21 Jul
 2022 14:21:38 +0000
Received: from DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::2) by DM5PR08CA0060.outlook.office365.com
 (2603:10b6:4:60::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19 via Frontend
 Transport; Thu, 21 Jul 2022 14:21:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT065.mail.protection.outlook.com (10.13.172.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 14:21:37 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL105.nvidia.com (10.27.9.14) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 21 Jul 2022 14:21:37 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Thu, 21 Jul 2022 07:21:36 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 21 Jul 2022 07:21:32 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lpieralisi@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <kw@linux.com>, <kishon@ti.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V6 04/16] arm64: tegra: Add regulators required for PCIe
Date:   Thu, 21 Jul 2022 19:50:40 +0530
Message-ID: <20220721142052.25971-5-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220721142052.25971-1-vidyas@nvidia.com>
References: <20220721142052.25971-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 32dd9615-a369-4b17-fee7-08da6b2452e7
X-MS-TrafficTypeDiagnostic: MWHPR12MB1936:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: V9WMixk3yGw1SNqL7e417JAadoryc3WIxVBgwYkpf0NLSvHQZTAa52Se2QoEV4EsNoYwniQ1+vpawYsBShn++z+zYIKYUotsG1wUjZLFLucZsCjfWCQF7qzvQ2Ylyx+VlTjXPU5Mnw2SlAL96b0nRrQCRQ8ZOTxGUeCL7IYeGyFYhjkOoaosGd4njbddz5IE8/JahV0boopyFyItFDAVAK7mVc74GnG1JTOolZBBCtHm1Np8lkULyJHs5Nq5/nydMbDrNR9FcjWXAuRuzk3JbTJ4S1If8Yg0CXtEKtqkwkw+TyDCyW14rJCoLRdvYliT3BWnhmK09QHQTTVSGkCoO++hQb0AMTwUMW60rMcunR96bpkGdwSellNOxB67r8/NoTqPdSwEz6KGJpc6hmHsUBlXvePFB0g2I5WA3IYFFk47RkxH4NPVM+nTyQrkVLTQrwIWc6jQYYFN04M2aQBMR6byMgEvTVzW8JxxWOvcElUC+jtvt2d/R1pEocAjnX4dikqXwmTaJ/A8sitpGNQgBxDPvJRlvbitajTZuMN+OkZ8SEqD6GOCygDw7KW87NBOYDOz7wLcX+1ZSG0QL+j2LMui48qwpfJyNm1GawXFHlZ5JELsAMRAGBLC8rQMC7e+OTKNUc4Rd1iyJf9inFcmJRgKbTXb/OBOIaQXbmg/DNRE5v/2eUA6A8Ij/6K8E3qtuM6Xux0DPXmAk15Yws2oLsiSt1a7psg1eJAQiKFgLSdXxiJhNHiq9Fpz7XxxV3PB2Xz7KlzUq7lk1jSgNu49FRKsAUjY2BfaiD4CesgrQierUQN4qnLSvXrnAJea81VZVNKLy+vipU/PGCmFoyAC/8IgY0KFDgvftf6K8mDyZi4=
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(136003)(346002)(39860400002)(36840700001)(46966006)(40470700004)(40480700001)(70206006)(8676002)(7416002)(1076003)(2906002)(82740400003)(4326008)(81166007)(5660300002)(336012)(47076005)(8936002)(426003)(186003)(478600001)(86362001)(356005)(316002)(7696005)(36860700001)(2616005)(6666004)(110136005)(54906003)(70586007)(82310400005)(41300700001)(26005)(40460700003)(36756003)(2101003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 14:21:37.9027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32dd9615-a369-4b17-fee7-08da6b2452e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT065.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1936
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add regulator supplies required for PCIe functionality. The supplies
include 1.8V, 3.3V and 12V.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V6:
* None

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
@@ -6,6 +6,42 @@
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
2.17.1

