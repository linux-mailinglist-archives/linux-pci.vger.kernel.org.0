Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E112E569CFA
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jul 2022 10:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235458AbiGGIOP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jul 2022 04:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235459AbiGGINk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Jul 2022 04:13:40 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2042.outbound.protection.outlook.com [40.107.101.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC6D45043;
        Thu,  7 Jul 2022 01:13:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UoQSjTlOExmjT9wdWxfIXQ0u9JyLAJ/ZQBnKHYAXqlcTG4s8200efOhVBgCrMVHFh1LW9FVRlr8fg5LQkBi69XJtVzLweh0dzFfdSdIzcTsd61w5fo8bu8yUmD9flJ/qswBzstDVoWIc4exRgjtvqnygpZRocm58xKlI0HVklSFGmSsTUOlAabpWBCye/zQVYwQYWK7aRB5NqguJUGTtSFENwPEdUMMCqJPQvAzsNtf5hww3cIA0a6OlGZVcvLzILhS6mjsMZ1QgzVE3Qz/pJ+rJ0ZSQGf8vChnjeEGY4xW7pb6llwGIzs6B11lhpTUcfgTonGbxh3ycPMeQzhRVxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dDHkOINWxq4Hn06I0n5g5qU3Fsq6RbZiHcd1wKKPev0=;
 b=C3N7k2kr4lYcLwYqDRcEAw6k/c1HG1633yh+/4TNlb72DPBMTIherLTUWLk5O7VHaugXbVtR0Q+cw8YPGOEs6e+pCGWOSqUpzefEu2xBJmcKensETtQTIQMllb6UQUMABKTwITZSA/Ql2zbYrzhqZwV79MBNVrxmurP/NPpV8tYa5joa10HXFkeSf5G4///81ib4fgbMh38itnPNBN6FXH2HSfPA6CRhbhF272bytNMSDT0AedF/ktIBmINoZk6X2Fi6qJOH2FikD+WbEtle9PLNDoYGKOK4cw1fKTmAJWhop6+iEGeqnQg5AhPbyk7z7Fx2foo9Qx1Rp4aBTmfoLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dDHkOINWxq4Hn06I0n5g5qU3Fsq6RbZiHcd1wKKPev0=;
 b=mBNDjEq48CUryHjvv36Y2gLT+u8P1FBQujVFGpdc9jz7hLb8vkmDzjMiUq7qrLnZwVfN1pRopZdGvu91wWnse3w+hrwuLGw1tK8R8QfCGEkAzp2fyzlr5EYIwx1XWThoTBiwMOrONJiv7vngb8TqWo2PJ2TwtjMqNiQMaOn2hq8DWOaF45bCXVxu8hxvNSS/7xUrgoLvNUf2PwJ55deR37A+rHhzJNpsYEjQrsrncN5FeNw543u9zzcgMgyWcm0PABUZbZfxqbSjSpAQWobu5bBJROHo/l8+YuGNU0cigDvFjwqGLzoh4wgAMn9PU0rnKWYjfebZ/lX0zH/wUPIsSg==
Received: from DM6PR11CA0046.namprd11.prod.outlook.com (2603:10b6:5:14c::23)
 by SN6PR12MB4685.namprd12.prod.outlook.com (2603:10b6:805:b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Thu, 7 Jul
 2022 08:13:35 +0000
Received: from DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:14c:cafe::74) by DM6PR11CA0046.outlook.office365.com
 (2603:10b6:5:14c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.17 via Frontend
 Transport; Thu, 7 Jul 2022 08:13:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT024.mail.protection.outlook.com (10.13.172.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5417.15 via Frontend Transport; Thu, 7 Jul 2022 08:13:35 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 7 Jul
 2022 08:13:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Thu, 7 Jul 2022
 01:13:34 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 7 Jul 2022 01:13:30 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lpieralisi@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <kw@linux.com>, <kishon@ti.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V4 4/9] arm64: tegra: Add regulators required for PCIe
Date:   Thu, 7 Jul 2022 13:42:56 +0530
Message-ID: <20220707081301.29961-5-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220707081301.29961-1-vidyas@nvidia.com>
References: <20220707081301.29961-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b7dee0c-cd4e-46e9-329c-08da5ff0970d
X-MS-TrafficTypeDiagnostic: SN6PR12MB4685:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: o0ZNmyjaENZmS0Kv01OQ33zw7oclL397sO3UDIxAktQ3L0BMUP4RftBeSBxRrTiWC144ekMJm8oY2XzvSkgFmwNaFISu/QTdts+iGqyyY2OrQ+KBdS5M2hBHUVGb2sO07DgZjr9hXQe0VB6ndDUZMtFnPj2vVAAKmzTRB9hRT9VKUD5fCt9Mj6yOK8YgeIB3OggCaAM1cXlVyD5YmAmHcxn1a2Dx1gc+nQjCxy9l08Un5f4Pe/Tvo6+w4RxlNDtBLmDYWQIUS3dYx0Zm65HqkDpjsaOOGa/F0ME6UP1mPZtigeJl53+LjbZngtqPZGt52mJ55julj4ZJGEpK35HYB8C3rs08tZy3DzFfzTscDx1stNeA4jgSvfbR8upvm9lNepHG2mJe4XPlIIyPdxMB4o0BxvojdUeDj3UQ0N0bRNcJcC0/MiHB0xHAy0xc16BnF7+oeWxpMbxzqWda0cli3IlpthIyt/jiUTM7z4o4UDk+Cx0L8e+3mztqUUc8gY/Xi6K4ALyAWde+93BgmHxv+OBZBbA1DGd42ghbIaJRYZdIZLg3XolZhpr8EVnX3QUuqVK18kSdFlxc4a1yMii5BXZl+7Oo7AJgfVT6H3ghtcYWfZYYQhRXiZjAEDR67dZFnjPnVqHSsiig0dbDe1u5Hofs5e+la7LvZeMcGsF50+B2cBsHc/I+RLJWbzWrdbSyrOZlczqY/wTTbW6X3uC99QbEAIARtArdBdCaO/84dQ9SNuhIPdaVQYeDpv0QnkUgPRLhtl6N56RN86BJCNpFMhLV9n3i1Ojnr09+4I4HPIs/x7onRUgPRncW2f1ikDgjK15uKdaFgp8Ccftq6QWbE8aGx8/ybCsNurMnoIo3TRxjmDfY1UqOLGHydJrbJcmL
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(376002)(136003)(39860400002)(36840700001)(46966006)(40470700004)(186003)(70206006)(336012)(47076005)(1076003)(426003)(40480700001)(7416002)(41300700001)(2616005)(70586007)(36860700001)(5660300002)(8676002)(478600001)(26005)(6666004)(82310400005)(4326008)(36756003)(54906003)(316002)(7696005)(2906002)(40460700003)(86362001)(81166007)(110136005)(8936002)(356005)(82740400003)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 08:13:35.6110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b7dee0c-cd4e-46e9-329c-08da5ff0970d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT024.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR12MB4685
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add regulator supplies required for PCIe functionality. The supplies
include 1.8V, 3.3V and 12V.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
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

