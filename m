Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A291B4AAA20
	for <lists+linux-pci@lfdr.de>; Sat,  5 Feb 2022 17:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236337AbiBEQXP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Feb 2022 11:23:15 -0500
Received: from mail-co1nam11on2059.outbound.protection.outlook.com ([40.107.220.59]:56065
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1380423AbiBEQXM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 5 Feb 2022 11:23:12 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPpE8r3NWSx8UyeFtXbxumUR1WaSMbU9xvQTw0+1GjTOvvH4MNuT+75CnC3CM7PSf40W6lznxh98JBzWfx0DXDKhnRq2I356o/Kds9C6wWJXmCkV8sGHwz9ZEV8GeG1VRcMEsIM1OIHtlhn91TcQ8Aqu1V3y61E9uSPaq+7XKS6wKD1r8m1OYCXifyLvOpzHPrZh2Bw+wJ4nNbQlZtkVVzbpsMXYlX170nF1ixsnGhxQjpnXIgKjBaIVP1r/TlpzhEhaNDpL7UV3CM1aq476oLDJd4LiyGz7mzI6mhFQAUVKOBHsAANOPxjNDk8up3PS0UHpkMNhWBamlmCzUpoB6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RdPMZfdG856cFgQDEKBC7JdNKyMFdpq2L+zu7UiDVfY=;
 b=aI4oqx1QWWqXl8iQoHTw6AQN7Cpl24SbG0wBmdAsnraEei5JI1RPd+RXRASw4ZDoi9+xDxyAQDS4h7G2hb7G/Vk2NWxOZk9jfiUpBMVOXDM93N+bcUfB9Wj7PIoUhPCGsdBPsnTO+niBtbYBGJKjkJKTkg/kWHodAP3hstk80lMfUwYeAThqPrXz3bwwgu1uXNfIpg59CZvgwsGXT0M+ezJrm4cmp0Q2OF08IR30R4Z6Wub6O9fsLbHXD3uudDJM3C8fb2Mp1FCROesGCdxs4qhcISZHnt4Y52knp8XEIZyU6dz1K3GwgFuKpusDxjIJxKvx25s6xVBMvJ/84KILQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.238) smtp.rcpttodomain=ti.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RdPMZfdG856cFgQDEKBC7JdNKyMFdpq2L+zu7UiDVfY=;
 b=kMSvRAO8+zoM46fr21OT3MIza5lytcuqNx/buXzft/aXXEkSONCRAjisaXgzGhzZwlN1h4n2Zsk4ngZopygBNyXOJsZRFb1AEPndlxVzprPP8PYeIX5BGAakR/UYrNbqlzH8jUNO2ninLqXioUlpZ7ygusfjOy/0E2gKlh/eM1HonlXiJuM951d1vFoezjfWx7AKb/LDQTO0PYrKewviYzg/cj1xcL5LvHMYXKc58eQP1oPRi8KXW9dNwhMvHbMpTA1u7smjGo326eGfV7qFSoERweQ+Enc8svI9iGA5rgm4HbEDelKVFy6COMs6E62gR3ND7b6sCoYIxbgPeBl6Fg==
Received: from DS7PR03CA0134.namprd03.prod.outlook.com (2603:10b6:5:3b4::19)
 by PH7PR12MB5654.namprd12.prod.outlook.com (2603:10b6:510:137::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Sat, 5 Feb
 2022 16:23:09 +0000
Received: from DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b4:cafe::ce) by DS7PR03CA0134.outlook.office365.com
 (2603:10b6:5:3b4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Sat, 5 Feb 2022 16:23:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.238)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.238 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.238; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.238) by
 DM6NAM11FT042.mail.protection.outlook.com (10.13.173.165) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4951.12 via Frontend Transport; Sat, 5 Feb 2022 16:23:08 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by DRHQMAIL105.nvidia.com
 (10.27.9.14) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Sat, 5 Feb
 2022 16:23:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.9; Sat, 5 Feb 2022
 08:23:07 -0800
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.9 via Frontend
 Transport; Sat, 5 Feb 2022 08:23:02 -0800
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
Subject: [PATCH V1 07/10] arm64: tegra: Enable PCIe slots in P3737-0000 board
Date:   Sat, 5 Feb 2022 21:51:41 +0530
Message-ID: <20220205162144.30240-8-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220205162144.30240-1-vidyas@nvidia.com>
References: <20220205162144.30240-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5123f117-5f87-480c-1c22-08d9e8c3cbe4
X-MS-TrafficTypeDiagnostic: PH7PR12MB5654:EE_
X-Microsoft-Antispam-PRVS: <PH7PR12MB5654E103ECF55C407483DDA6B82A9@PH7PR12MB5654.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1060;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HOsQOLdfEA4P0UgHO6Ts4LAIMV3gn2W0d8AUDYGLeCr5LVDJN0wNkMDcvC5SBiD9QHC2Q1ND3sz/Xs3c6hFSipTgfSmeAylcM8+wDVX5QeD0fFoHwneaV8fzMBbQjQzlUwfZDOXtoRBK6QL9tqgFkdqcTmAVgM7/jy3FUvba9RBAbWJHku363/TYOPaLXcNtyDTJOeL5Tgi1vKpsp58Dqq1ehwbgwl6h7mY6QwPOOfcpV1y09qzhDqON3x4k7xORLXZcAC2ygRwR+qIs7VY0bFnlEIPeSC+WhHZzo00wXWvwoYE1RP+RheLHAIHIl7eHFoBhn5ok+33x6LYAlD30gx9MCGUWkdW6yZ1ie/aEsZy+b4i6Ll1fFo2Umn7vWzsSgKIi5sQ4oTAMOzOWtPInSO1htYAGScG7DB4YfmNrytRC7GmbTxpJSqMSFwR2UZtV0Q7JMPa1WW1uYm+ypF6EYr9BK5upOwpHjDSfb3xegMBxidjL+SSRlMdA8N37IIioAc+ZWkh2dT5LFbo1XDGWMQe3rLZdvrY7paTZDa10p8bKaTtTVQkAqxGyNhiVVIcgm1VgwVvlO4hRnH/kr+JZwGC9ALF86Dzvyvq4XvtHzmolsTJZTlmRd/9gkhLvlTP7BKHkswu3vUN/UqgB0CLk7lMDS2sNsl5HqU4w1X3Iwjm7wbf0G4GE9dr5Sk7oc2XYjNQB+nk6seXLYz9Nv9gscg==
X-Forefront-Antispam-Report: CIP:12.22.5.238;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(36756003)(70586007)(70206006)(4326008)(8936002)(8676002)(7416002)(110136005)(508600001)(54906003)(40460700003)(86362001)(356005)(81166007)(36860700001)(26005)(426003)(2616005)(336012)(186003)(82310400004)(1076003)(6636002)(316002)(5660300002)(47076005)(6666004)(7696005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2022 16:23:08.5533
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5123f117-5f87-480c-1c22-08d9e8c3cbe4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.238];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5654
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
 .../nvidia/tegra234-p3737-0000+p3701-0000.dts | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
index efbbb878ba5a..b819e1133bc4 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra234-p3737-0000+p3701-0000.dts
@@ -21,4 +21,30 @@
 	serial {
 		status = "okay";
 	};
+
+	pcie@14100000 {
+		status = "okay";
+
+		phys = <&p2u_hsio_3>;
+		phy-names = "p2u-0";
+	};
+
+	pcie@14160000 {
+		status = "okay";
+
+		phys = <&p2u_hsio_4>, <&p2u_hsio_5>, <&p2u_hsio_6>,
+		       <&p2u_hsio_7>;
+		phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3";
+	};
+
+	pcie@141a0000 {
+		status = "okay";
+
+		phys = <&p2u_nvhs_0>, <&p2u_nvhs_1>, <&p2u_nvhs_2>,
+		       <&p2u_nvhs_3>, <&p2u_nvhs_4>, <&p2u_nvhs_5>,
+		       <&p2u_nvhs_6>, <&p2u_nvhs_7>;
+		phy-names = "p2u-0", "p2u-1", "p2u-2", "p2u-3", "p2u-4",
+			    "p2u-5", "p2u-6", "p2u-7";
+	};
+
 };
-- 
2.17.1

