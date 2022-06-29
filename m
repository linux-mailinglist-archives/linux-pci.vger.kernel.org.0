Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24AEA55F633
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 08:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231741AbiF2GFs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 02:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231736AbiF2GFh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 02:05:37 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2086.outbound.protection.outlook.com [40.107.100.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF832AE29;
        Tue, 28 Jun 2022 23:05:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kdUQ8gsIOwmA3ByjsCLPDW2O0723EtGOwrPkOyTskB3UUSskbDn2nPdYg0yquzq5ouzg83acK/LJwehqaWI3/hTCWM8AKrVC2Rr6H2v2lJI1YLGCHUfORV1pGJaYKKXjDEugOYUl3Kqf35cINBtSjP7M0N+RQqCRBLUfvSy8jti0yNdEvBbLkFqMku63Sg2ztpuslPUg3G4xeGxX4OSJiHuf4SzUsP42H4P0pn7F8eLqYukhdWabz5w0IxyWTtRQZtAfB92kBONhHH9yk48RSD7ghkfcqME5UY39nOwlBhagUw28u2ai0Ay13eFC84KciMgzG0EcUitRL09ne9PCCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cU/K6rU3Xbt8vrrok7kgjKbNE/9Cgfw+Nn/sltqT5l0=;
 b=dsfPau/Vs3PFX9INVtq4f1e4SzFwqF12Q1kf56HBtYoPlB8JkfDqiSGetPw5o4K7sW4cMrRSl1SV6oVh8GPaDaei8ju5fmI7LQ7/bksKw6Czlkb7KOpN2Gysf8mU7EvYVvXGy/hxvwhQtnboP0H+M8tU9zpv8DH9UwDYLO7Um58pmASAozcDiW+CgOfA2uaD0tfaqAwSydLHECJj1tfRBzImeVJ07SkffqnfV9U2/k85yW8MDDlznSUF9FK+xebyrGwZ1fUmqAdxf7czQor1jFPYpoXOZgq7IEej+1Au+gv7pko7HS9r7xBVtKokzq7Dekca+O+hhvgxQZpJH4tqpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=ti.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cU/K6rU3Xbt8vrrok7kgjKbNE/9Cgfw+Nn/sltqT5l0=;
 b=EK4PM6hb3ZR8cAP1bhC2psr2AdANtI5kXS3W13OLEx+6TbPuT73OkV0YQMyB/RW7F09IEQjIbEXGPC0braZUuyo4O7EzFXz8V65YR9QJMQnLevodlR8tiZIaAKp3hBE1fKepDVFWq9LgtfDXcfjzWpCS+CkhONTEZQhx7BaOHKUlC80U/nVsCxTh2vEV3HvAO6iTiQWmNpYOhnEfxjB8aMqBlGufUDToKrkVG6fIwQpt/jiu9c1gGdfPFRHI4NB0mRfUD35Qv+zcShqmpQh50FO7Tm8YeXyxRLI5VB4L4CQ3MDSQ/1Own7rSpLiplpl+IeoPYogbjsRtUNh+3Us9Nw==
Received: from DS7PR05CA0070.namprd05.prod.outlook.com (2603:10b6:8:57::28) by
 BYAPR12MB3206.namprd12.prod.outlook.com (2603:10b6:a03:130::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Wed, 29 Jun
 2022 06:05:30 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::c0) by DS7PR05CA0070.outlook.office365.com
 (2603:10b6:8:57::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.6 via Frontend
 Transport; Wed, 29 Jun 2022 06:05:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5373.15 via Frontend Transport; Wed, 29 Jun 2022 06:05:29 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Wed, 29 Jun
 2022 06:05:28 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Tue, 28 Jun
 2022 23:05:28 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Tue, 28 Jun 2022 23:05:23 -0700
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
Subject: [PATCH V3 07/11] arm64: tegra: Enable PCIe slots in P3737-0000 board
Date:   Wed, 29 Jun 2022 11:34:31 +0530
Message-ID: <20220629060435.25297-8-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220629060435.25297-1-vidyas@nvidia.com>
References: <20220629060435.25297-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a339bff-3a94-4a56-e36f-08da59955e7f
X-MS-TrafficTypeDiagnostic: BYAPR12MB3206:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lwI/MhMMJ2epap+w+Ksmcz53rVM79Yk21xYagVBFTWRAA4L6lnd7yy1VjunyGv2uXfgLUCEFRd3N+ED+XwdIRc+Oec1AkNYRa1V9ppPKYKJs3w0YDzQdWLtrCzOit2hlP1C9dYVN0a2wp154jKCCx+waAfD1X0Gcr+IsTbX0r87k8n4h1SuOS61hIc/KBkRsj90u82mJ8H9Tw92RtIPbCafR1WlWq0FfX2JWz4NWhczSL0ymn6QX8PQedmt3Zdolc55V8jlMhFWjdejnrGBxlZZJUnJ4G/c+rQE4DS2xTTIbw7U6u/6qU3grtD3bfoF1TdJXY2Bqt6Ajf5Quaukrg9cTip7p1uCXFAM1iJByUHFlnBNu3pVMhVDIg9PNWD+/vO7iN20WySgYmDwEbjJNR9rByGs2bvs+UwqNinRIo+Aer7rKFT8CTyOZOfEuQltF0xtCdkByKfg3/9AcwQ2FdUzMZ/AeJxmZt3Komq+v1ZrF3hSNxQahH+G6yndi/GVPngb4+FlI3BFeBL6nkdm79hAVwrWM+ZwCHOWTCRpiLGm8O2Yn7JCOZDse42xsNVYC5eW31ItTin7APYcchfoJOJf19ppC3UtxCbWP+fWt9UchlGDTQgfw+o24qKIbLi11vr7Xqmek6dvPVCXVCtpA+ZJN272Hyf/V9tBDmOLLUqIsSMg/YcAq5Q56dcTJrgE9ivIbLYWqMSESDblbBNqaXLjbGaBxzSEvkkLzPhNy023DAZFYBCmRRIEJAWV3NL8Fe8rbbzIcxqi0AfOtBvyrqGHKGIE73/3yHW6EtFP6fvK+bpg2fpqXDV/lC1owBEZdAtIWDJMlILgtMBOANX3khg==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(396003)(39860400002)(346002)(40470700004)(36840700001)(46966006)(356005)(5660300002)(36756003)(82310400005)(186003)(7696005)(8676002)(4326008)(70206006)(83380400001)(478600001)(36860700001)(40480700001)(8936002)(2906002)(86362001)(41300700001)(40460700003)(7416002)(316002)(82740400003)(2616005)(1076003)(426003)(6636002)(70586007)(47076005)(110136005)(26005)(6666004)(81166007)(336012)(54906003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2022 06:05:29.5535
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a339bff-3a94-4a56-e36f-08da59955e7f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3206
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable PCIe controller nodes to enable respective PCIe slots on
P3737-0000 board. Following is the ownership of slots by different
PCIe controllers.
Controller-1 : On-board Broadcom WiFi controller
Controller-4 : M.2 Key-M slot
Controller-5 : CEM form-factor x8 slot

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V3:
* Added 'vddio-pex-ctl-supply' property
* Added a node for C5 controller's EndPoint mode

V2:
* Addressed review comment from Krzysztof

 .../nvidia/tegra234-p3737-0000+p3701-0000.dts | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
index 3f6c399e3371..56bd97ec9ae4 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
@@ -2111,4 +2111,56 @@
 
 		label = "NVIDIA Jetson AGX Orin APE";
 	};
+
+	pcie@14100000 {
+		status = "okay";
+
+		vddio-pex-ctl-supply = <&p3701_vdd_AO_1v8>;
+
+		phys = <&p2u_hsio_3>;
+		phy-names = "p2u-0";
+	};
+
+	pcie@14160000 {
+		status = "okay";
+
+		vddio-pex-ctl-supply = <&p3701_vdd_AO_1v8>;
+
+		phys = <&p2u_hsio_4>, <&p2u_hsio_5>, <&p2u_hsio_6>,
+		       <&p2u_hsio_7>;
+		phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3";
+	};
+
+	pcie@141a0000 {
+		status = "okay";
+
+		vddio-pex-ctl-supply = <&p3701_vdd_1v8_ls>;
+
+		vpcie3v3-supply = <&p3737_vdd_3v3_pcie>;
+		vpcie12v-supply = <&p3737_vdd_12v_pcie>;
+
+		phys = <&p2u_nvhs_0>, <&p2u_nvhs_1>, <&p2u_nvhs_2>,
+		       <&p2u_nvhs_3>, <&p2u_nvhs_4>, <&p2u_nvhs_5>,
+		       <&p2u_nvhs_6>, <&p2u_nvhs_7>;
+		phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3", "p2u-4",
+			    "p2u-5", "p2u-6", "p2u-7";
+	};
+
+	pcie-ep@141a0000 {
+		status = "disabled";
+
+		vddio-pex-ctl-supply = <&p3701_vdd_1v8_ls>;
+
+		reset-gpios = <&gpio TEGRA234_MAIN_GPIO(AF, 1) GPIO_ACTIVE_LOW>;
+
+		nvidia,refclk-select-gpios = <&gpio_aon
+					      TEGRA234_AON_GPIO(AA, 4)
+					      GPIO_ACTIVE_HIGH>;
+
+		phys = <&p2u_nvhs_0>, <&p2u_nvhs_1>, <&p2u_nvhs_2>,
+		       <&p2u_nvhs_3>, <&p2u_nvhs_4>, <&p2u_nvhs_5>,
+		       <&p2u_nvhs_6>, <&p2u_nvhs_7>;
+		phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3", "p2u-4",
+			    "p2u-5", "p2u-6", "p2u-7";
+	};
 };
-- 
2.17.1

