Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C5E57CD52
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 16:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbiGUOWO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 10:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbiGUOWC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 10:22:02 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 364EF8210B;
        Thu, 21 Jul 2022 07:21:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gx4Ys3TDaKwL9L3Sw+czhMuh+U6q9M+p9V2GxX+DpXVqBRTnv+P389WcJ0Zeq5KV+diB7ZHiXbip6rCGQuYUInHOZXbiUh97uXFpBDJSvrUVgH5jRj+3+51ipHnKDuAL3TRxXJ11/SsgMH87JqRq8bk5d51R8XMFRiyP1+SoHNOMroN8FfqhPqyFqednOLrMUR5u74/yAaESBRLAWKJCYUeDzD13hUZ9hFiHeYkRln3J+YtsnEB5xOUTHv+pvWKrJgRDqWpKrcEZD8+0+gX+dYeYpJEyfxo7WRsc2wje76XK0ttzud1GJcH88L/n60+zaK+l+aqnTH5fm0fahEGcYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6QP0D14f+bLVA34GMgM8U7qIgM/02DhthpDZxKTDx9M=;
 b=Zu0jf9G3q3NAIZfIiKsRCGoJFpK7hGZjk8q/y/8he7g6MtbREoGjYNBtsgOfeCb1OXpQP5eSlxY20sUKkLOGu9L+x7uKoNiSwbYX0qojssJMScBCJyEx6boyl63gTXHxywAGE5YaPw/pprhYqEWVZuueFndElp7vrPauG51v+pNi+pS22jSoBpDOYFGx8yYlBbUBET/Xc7kpsveI00AJ4w0rVA0ZzQYBmW4wrXQalfDLPkZqSffHhJo5+IZs0rowQwHTFoymWISCkXgn1lKwhM9r8GnPi/bClo7deEXaAU+KUmhPIF15HYHlAk1A0zK4o3o7hwByBLH6ye5Qwe1j+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6QP0D14f+bLVA34GMgM8U7qIgM/02DhthpDZxKTDx9M=;
 b=NZeLRc/2epy9CTquWCnVLr5f6DMGC26Rw6xmvkiBrVvb5wCtESXtKfEBmhqbcwJuHkd6+nIgEpZ+j54EuoYv6huhOW0W5+ddogzGqcAg1PeAjwUmMk0JeuYpm0/sd4RhB/UG3IwVmP2TH4wYJvagQNMcTM6TkUClfOwn7pBDHqX2lnTi31QaYuiJbXufMWBwyIfJYmZdEGyeCAasQ0ENeFbWB0TCumaIPmz3jEedaDGo9awozpEGy4Pgaf00tSZ9d/aU6BIilpaLPkyBjT9sy2sohH3AWsXsF08FV02h1r5yQr3GsE3SivW0ukxwd0m72ilmdKJXDsRf6hH/RjOTkA==
Received: from MW4PR04CA0100.namprd04.prod.outlook.com (2603:10b6:303:83::15)
 by MW2PR12MB2505.namprd12.prod.outlook.com (2603:10b6:907:4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Thu, 21 Jul
 2022 14:21:44 +0000
Received: from CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::ba) by MW4PR04CA0100.outlook.office365.com
 (2603:10b6:303:83::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Thu, 21 Jul 2022 14:21:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (12.22.5.234) by
 CO1NAM11FT020.mail.protection.outlook.com (10.13.174.149) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5458.17 via Frontend Transport; Thu, 21 Jul 2022 14:21:43 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 DRHQMAIL101.nvidia.com (10.27.9.10) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Thu, 21 Jul 2022 14:21:43 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Thu, 21 Jul 2022 07:21:42 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.26 via Frontend
 Transport; Thu, 21 Jul 2022 07:21:38 -0700
From:   Vidya Sagar <vidyas@nvidia.com>
To:     <bhelgaas@google.com>, <lpieralisi@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>
CC:     <kw@linux.com>, <kishon@ti.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kthota@nvidia.com>,
        <mmaddireddy@nvidia.com>, <vidyas@nvidia.com>, <sagar.tv@gmail.com>
Subject: [PATCH V6 05/16] arm64: tegra: Add P2U and PCIe controller nodes to Tegra234 DT
Date:   Thu, 21 Jul 2022 19:50:41 +0530
Message-ID: <20220721142052.25971-6-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220721142052.25971-1-vidyas@nvidia.com>
References: <20220721142052.25971-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3ff49c0-816c-462a-1962-08da6b245685
X-MS-TrafficTypeDiagnostic: MW2PR12MB2505:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TPfPf743E5m5zy2QfmfoswZYYKSNsP+d3UvvZLCH+V5RCW8B58kv9Hko5j4vOyP/dyGG3tS34VrUdr/kugfL1ZGti+kyv6YcQDFekQtKiTbTfTowoscTnQaxy7hIvDD1n3hdjlMrzoeeB01ia/rvnHEieInJpOBK5zjAbJSg9KeyJhdbTEADC6/jjf0sUgmaMPqFH8IsFousDsnPRc2aUXwgW4zEG3qXLkkDcVgFP4YibBc/4UFvlOAOUPEPSqTr1ugxZIK7I9+tTCRqGLNasMiLMEC+BIlZyIAZOzZ8KBsXqRQXzXcm/vguHm+HuhAJXZ3ZpMHaXaOhb4K1TK9U0kRTQC2TwTLyayXN6DHd0lwCpW1g1QAHMPpiYtDC4WzMxdtxXfG6bb2KcOQpeZcCYNlMBM31z0JChaXgt9dUlF2IYuLaKsPS3cQ2ntgKDL7H8fGOhj/fC1ZmTBbHtIUIBr3pGFd3pEtF4tvruONivNKdm4lKcP+kW27P67WCCFBJBDqu6mvl8mYdOC9C3DtflOfSIKAqM2F5/d60Is1MYJbEh2a/Rpsy4mXaNUDYKomeBUndlGwOM7vsI7ewfjiI70p8Y7rRGetLSsFQGgDYFfHByUBnb2hdrJgI9tSzAa8lFx2aBr45RpewPC+xshLDgQ8vrhsy56p5yXwgpUpwV/U5kuVBuShty1VfiItHtewsHcQgTqDW4HixNFYp7OsIitwSajDFn41Js75syjwnUJk+7+ailkKO9pIzjPtL2MFjueBCqbvO9OexjKp/jTmlgUteZZDYr+Cn9ZUJhdetvASOkzDOSFiPvli+gatDUJNZkNy0in+EHDdhHPYooblLoxMMJJQpEGG+vNvRV/DD5kg=
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(136003)(346002)(396003)(36840700001)(46966006)(40470700004)(26005)(1076003)(36860700001)(7696005)(83380400001)(2616005)(40480700001)(36756003)(82310400005)(6666004)(30864003)(41300700001)(2906002)(8936002)(356005)(54906003)(7416002)(81166007)(110136005)(82740400003)(478600001)(5660300002)(4326008)(8676002)(70206006)(70586007)(186003)(336012)(426003)(47076005)(40460700003)(316002)(86362001)(36900700001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2022 14:21:43.9498
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ff49c0-816c-462a-1962-08da6b245685
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT020.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2505
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add P2U (PIPE to UPHY) and PCIe controller nodes to device tree.
The Tegra234 SoC contains 10 PCIe controllers and 24 P2U instances
grouped into three different PHY bricks namely High-Speed IO (HSIO-8 P2Us)
NVIDIA High Speed (NVHS-8 P2Us) and Gigabit Ethernet (GBE-8 P2Us)
respectively.

Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
---
V6:
* None

V5:
* None

V4:
* Addressed review comments from Krzysztof
*   Moved 'status' property to the end
*   Removed 'num-ib-windows' and 'num-ob-windows' as they are deprecated

V3:
* Added entries for all controllers that can operate in EndPoint mode

V2:
* Added 'iommu-map', 'iommu-map-mask' and 'dma-coherent' entries for each
  PCIe controller node

 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 927 +++++++++++++++++++++++
 1 file changed, 927 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index cf611eff7f6b..e8d9663b007c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -998,6 +998,198 @@
 			status = "okay";
 		};
 
+		p2u_hsio_0: phy@3e00000 {
+			compatible = "nvidia,tegra234-p2u";
+			reg = <0x03e00000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_hsio_1: phy@3e10000 {
+			compatible = "nvidia,tegra234-p2u";
+			reg = <0x03e10000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_hsio_2: phy@3e20000 {
+			compatible = "nvidia,tegra234-p2u";
+			reg = <0x03e20000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_hsio_3: phy@3e30000 {
+			compatible = "nvidia,tegra234-p2u";
+			reg = <0x03e30000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_hsio_4: phy@3e40000 {
+			compatible = "nvidia,tegra234-p2u";
+			reg = <0x03e40000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_hsio_5: phy@3e50000 {
+			compatible = "nvidia,tegra234-p2u";
+			reg = <0x03e50000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_hsio_6: phy@3e60000 {
+			compatible = "nvidia,tegra234-p2u";
+			reg = <0x03e60000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_hsio_7: phy@3e70000 {
+			compatible = "nvidia,tegra234-p2u";
+			reg = <0x03e70000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_nvhs_0: phy@3e90000 {
+			compatible = "nvidia,tegra234-p2u";
+			reg = <0x03e90000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_nvhs_1: phy@3ea0000 {
+			compatible = "nvidia,tegra234-p2u";
+			reg = <0x03ea0000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_nvhs_2: phy@3eb0000 {
+			compatible = "nvidia,tegra234-p2u";
+			reg = <0x03eb0000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_nvhs_3: phy@3ec0000 {
+			compatible = "nvidia,tegra234-p2u";
+			reg = <0x03ec0000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_nvhs_4: phy@3ed0000 {
+			compatible = "nvidia,tegra234-p2u";
+			reg = <0x03ed0000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_nvhs_5: phy@3ee0000 {
+			compatible = "nvidia,tegra234-p2u";
+			reg = <0x03ee0000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_nvhs_6: phy@3ef0000 {
+			compatible = "nvidia,tegra234-p2u";
+			reg = <0x03ef0000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_nvhs_7: phy@3f00000 {
+			compatible = "nvidia,tegra234-p2u";
+			reg = <0x03f00000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_gbe_0: phy@3f20000 {
+			compatible = "nvidia,tegra234-p2u";
+			reg = <0x03f20000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_gbe_1: phy@3f30000 {
+			compatible = "nvidia,tegra234-p2u";
+			reg = <0x03f30000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_gbe_2: phy@3f40000 {
+			compatible = "nvidia,tegra234-p2u";
+			reg = <0x03f40000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_gbe_3: phy@3f50000 {
+			compatible = "nvidia,tegra234-p2u";
+			reg = <0x03f50000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_gbe_4: phy@3f60000 {
+			compatible = "nvidia,tegra234-p2u";
+			reg = <0x03f60000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_gbe_5: phy@3f70000 {
+			compatible = "nvidia,tegra234-p2u";
+			reg = <0x03f70000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_gbe_6: phy@3f80000 {
+			compatible = "nvidia,tegra234-p2u";
+			reg = <0x03f80000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
+		p2u_gbe_7: phy@3f90000 {
+			compatible = "nvidia,tegra234-p2u";
+			reg = <0x03f90000 0x10000>;
+			reg-names = "ctl";
+
+			#phy-cells = <0>;
+		};
+
 		hsp_aon: hsp@c150000 {
 			compatible = "nvidia,tegra234-hsp", "nvidia,tegra194-hsp";
 			reg = <0x0c150000 0x90000>;
@@ -1384,6 +1576,741 @@
 		status = "okay";
 	};
 
+	pcie@140a0000 {
+		compatible = "nvidia,tegra234-pcie";
+		power-domains = <&bpmp TEGRA234_POWER_DOMAIN_PCIEX4CA>;
+		reg = <0x00 0x140a0000 0x0 0x00020000>, /* appl registers (128K)      */
+		      <0x00 0x2a000000 0x0 0x00040000>, /* configuration space (256K) */
+		      <0x00 0x2a040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
+		      <0x00 0x2a080000 0x0 0x00040000>; /* DBI reg space (256K)       */
+		reg-names = "appl", "config", "atu_dma", "dbi";
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		num-lanes = <4>;
+		num-viewport = <8>;
+		linux,pci-domain = <8>;
+
+		clocks = <&bpmp TEGRA234_CLK_PEX2_C8_CORE>;
+		clock-names = "core";
+
+		resets = <&bpmp TEGRA234_RESET_PEX2_CORE_8_APB>,
+			 <&bpmp TEGRA234_RESET_PEX2_CORE_8>;
+		reset-names = "apb", "core";
+
+		interrupts = <GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
+			     <GIC_SPI 357 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
+		interrupt-names = "intr", "msi";
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 356 IRQ_TYPE_LEVEL_HIGH>;
+
+		nvidia,bpmp = <&bpmp 8>;
+
+		nvidia,aspm-cmrt-us = <60>;
+		nvidia,aspm-pwr-on-t-us = <20>;
+		nvidia,aspm-l0s-entrance-latency-us = <3>;
+
+		bus-range = <0x0 0xff>;
+
+		ranges = <0x43000000 0x32 0x40000000 0x32 0x40000000 0x2 0xe8000000>, /* prefetchable memory (11904 MB) */
+			 <0x02000000 0x0  0x40000000 0x35 0x28000000 0x0 0x08000000>, /* non-prefetchable memory (128 MB) */
+			 <0x01000000 0x0  0x2a100000 0x00 0x2a100000 0x0 0x00100000>; /* downstream I/O (1 MB) */
+
+		interconnects = <&mc TEGRA234_MEMORY_CLIENT_PCIE8AR &emc>,
+				<&mc TEGRA234_MEMORY_CLIENT_PCIE8AW &emc>;
+		interconnect-names = "dma-mem", "write";
+		iommu-map = <0x0 &smmu_niso1 TEGRA234_SID_PCIE8 0x1000>;
+		iommu-map-mask = <0x0>;
+		dma-coherent;
+
+		status = "disabled";
+	};
+
+	pcie@140c0000 {
+		compatible = "nvidia,tegra234-pcie";
+		power-domains = <&bpmp TEGRA234_POWER_DOMAIN_PCIEX4CB>;
+		reg = <0x00 0x140c0000 0x0 0x00020000>, /* appl registers (128K)      */
+		      <0x00 0x2c000000 0x0 0x00040000>, /* configuration space (256K) */
+		      <0x00 0x2c040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
+		      <0x00 0x2c080000 0x0 0x00040000>; /* DBI reg space (256K)       */
+		reg-names = "appl", "config", "atu_dma", "dbi";
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		num-lanes = <4>;
+		num-viewport = <8>;
+		linux,pci-domain = <9>;
+
+		clocks = <&bpmp TEGRA234_CLK_PEX2_C9_CORE>;
+		clock-names = "core";
+
+		resets = <&bpmp TEGRA234_RESET_PEX2_CORE_9_APB>,
+			 <&bpmp TEGRA234_RESET_PEX2_CORE_9>;
+		reset-names = "apb", "core";
+
+		interrupts = <GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
+			     <GIC_SPI 359 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
+		interrupt-names = "intr", "msi";
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 358 IRQ_TYPE_LEVEL_HIGH>;
+
+		nvidia,bpmp = <&bpmp 9>;
+
+		nvidia,aspm-cmrt-us = <60>;
+		nvidia,aspm-pwr-on-t-us = <20>;
+		nvidia,aspm-l0s-entrance-latency-us = <3>;
+
+		bus-range = <0x0 0xff>;
+
+		ranges = <0x43000000 0x35 0x40000000 0x35 0x40000000 0x2 0xe8000000>, /* prefetchable memory (11904 MB) */
+			 <0x02000000 0x0  0x40000000 0x38 0x28000000 0x0 0x08000000>, /* non-prefetchable memory (128 MB) */
+			 <0x01000000 0x0  0x2c100000 0x00 0x2c100000 0x0 0x00100000>; /* downstream I/O (1 MB) */
+
+		interconnects = <&mc TEGRA234_MEMORY_CLIENT_PCIE9AR &emc>,
+				<&mc TEGRA234_MEMORY_CLIENT_PCIE9AW &emc>;
+		interconnect-names = "dma-mem", "write";
+		iommu-map = <0x0 &smmu_niso0 TEGRA234_SID_PCIE9 0x1000>;
+		iommu-map-mask = <0x0>;
+		dma-coherent;
+
+		status = "disabled";
+	};
+
+	pcie@140e0000 {
+		compatible = "nvidia,tegra234-pcie";
+		power-domains = <&bpmp TEGRA234_POWER_DOMAIN_PCIEX4CC>;
+		reg = <0x00 0x140e0000 0x0 0x00020000>, /* appl registers (128K)      */
+		      <0x00 0x2e000000 0x0 0x00040000>, /* configuration space (256K) */
+		      <0x00 0x2e040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
+		      <0x00 0x2e080000 0x0 0x00040000>; /* DBI reg space (256K)       */
+		reg-names = "appl", "config", "atu_dma", "dbi";
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		num-lanes = <4>;
+		num-viewport = <8>;
+		linux,pci-domain = <10>;
+
+		clocks = <&bpmp TEGRA234_CLK_PEX2_C10_CORE>;
+		clock-names = "core";
+
+		resets = <&bpmp TEGRA234_RESET_PEX2_CORE_10_APB>,
+			 <&bpmp TEGRA234_RESET_PEX2_CORE_10>;
+		reset-names = "apb", "core";
+
+		interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
+			     <GIC_SPI 361 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
+		interrupt-names = "intr", "msi";
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;
+
+		nvidia,bpmp = <&bpmp 10>;
+
+		nvidia,aspm-cmrt-us = <60>;
+		nvidia,aspm-pwr-on-t-us = <20>;
+		nvidia,aspm-l0s-entrance-latency-us = <3>;
+
+		bus-range = <0x0 0xff>;
+
+		ranges = <0x43000000 0x38 0x40000000 0x38 0x40000000 0x2 0xe8000000>, /* prefetchable memory (11904 MB) */
+			 <0x02000000 0x0  0x40000000 0x3b 0x28000000 0x0 0x08000000>, /* non-prefetchable memory (128 MB) */
+			 <0x01000000 0x0  0x2e100000 0x00 0x2e100000 0x0 0x00100000>; /* downstream I/O (1 MB) */
+
+		interconnects = <&mc TEGRA234_MEMORY_CLIENT_PCIE10AR &emc>,
+				<&mc TEGRA234_MEMORY_CLIENT_PCIE10AW &emc>;
+		interconnect-names = "dma-mem", "write";
+		iommu-map = <0x0 &smmu_niso1 TEGRA234_SID_PCIE10 0x1000>;
+		iommu-map-mask = <0x0>;
+		dma-coherent;
+
+		status = "disabled";
+	};
+
+	pcie@14100000 {
+		compatible = "nvidia,tegra234-pcie";
+		power-domains = <&bpmp TEGRA234_POWER_DOMAIN_PCIEX1A>;
+		reg = <0x00 0x14100000 0x0 0x00020000>, /* appl registers (128K)      */
+		      <0x00 0x30000000 0x0 0x00040000>, /* configuration space (256K) */
+		      <0x00 0x30040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
+		      <0x00 0x30080000 0x0 0x00040000>; /* DBI reg space (256K)       */
+		reg-names = "appl", "config", "atu_dma", "dbi";
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		num-lanes = <1>;
+		num-viewport = <8>;
+		linux,pci-domain = <1>;
+
+		clocks = <&bpmp TEGRA234_CLK_PEX0_C1_CORE>;
+		clock-names = "core";
+
+		resets = <&bpmp TEGRA234_RESET_PEX0_CORE_1_APB>,
+			 <&bpmp TEGRA234_RESET_PEX0_CORE_1>;
+		reset-names = "apb", "core";
+
+		interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
+			     <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
+		interrupt-names = "intr", "msi";
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+
+		nvidia,bpmp = <&bpmp 1>;
+
+		nvidia,aspm-cmrt-us = <60>;
+		nvidia,aspm-pwr-on-t-us = <20>;
+		nvidia,aspm-l0s-entrance-latency-us = <3>;
+
+		bus-range = <0x0 0xff>;
+
+		ranges = <0x43000000 0x20 0x80000000 0x20 0x80000000 0x0 0x28000000>, /* prefetchable memory (640 MB) */
+			 <0x02000000 0x0  0x40000000 0x20 0xa8000000 0x0 0x08000000>, /* non-prefetchable memory (128 MB) */
+			 <0x01000000 0x0  0x30100000 0x00 0x30100000 0x0 0x00100000>; /* downstream I/O (1 MB) */
+
+		interconnects = <&mc TEGRA234_MEMORY_CLIENT_PCIE1R &emc>,
+				<&mc TEGRA234_MEMORY_CLIENT_PCIE1W &emc>;
+		interconnect-names = "dma-mem", "write";
+		iommu-map = <0x0 &smmu_niso1 TEGRA234_SID_PCIE1 0x1000>;
+		iommu-map-mask = <0x0>;
+		dma-coherent;
+
+		status = "disabled";
+	};
+
+	pcie@14120000 {
+		compatible = "nvidia,tegra234-pcie";
+		power-domains = <&bpmp TEGRA234_POWER_DOMAIN_PCIEX1A>;
+		reg = <0x00 0x14120000 0x0 0x00020000>, /* appl registers (128K)      */
+		      <0x00 0x32000000 0x0 0x00040000>, /* configuration space (256K) */
+		      <0x00 0x32040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
+		      <0x00 0x32080000 0x0 0x00040000>; /* DBI reg space (256K)       */
+		reg-names = "appl", "config", "atu_dma", "dbi";
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		num-lanes = <1>;
+		num-viewport = <8>;
+		linux,pci-domain = <2>;
+
+		clocks = <&bpmp TEGRA234_CLK_PEX0_C2_CORE>;
+		clock-names = "core";
+
+		resets = <&bpmp TEGRA234_RESET_PEX0_CORE_2_APB>,
+			 <&bpmp TEGRA234_RESET_PEX0_CORE_2>;
+		reset-names = "apb", "core";
+
+		interrupts = <GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
+			     <GIC_SPI 48 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
+		interrupt-names = "intr", "msi";
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 47 IRQ_TYPE_LEVEL_HIGH>;
+
+		nvidia,bpmp = <&bpmp 2>;
+
+		nvidia,aspm-cmrt-us = <60>;
+		nvidia,aspm-pwr-on-t-us = <20>;
+		nvidia,aspm-l0s-entrance-latency-us = <3>;
+
+		bus-range = <0x0 0xff>;
+
+		ranges = <0x43000000 0x20 0xc0000000 0x20 0xc0000000 0x0 0x28000000>, /* prefetchable memory (640 MB) */
+			 <0x02000000 0x0  0x40000000 0x20 0xe8000000 0x0 0x08000000>, /* non-prefetchable memory (128 MB) */
+			 <0x01000000 0x0  0x32100000 0x00 0x32100000 0x0 0x00100000>; /* downstream I/O (1 MB) */
+
+		interconnects = <&mc TEGRA234_MEMORY_CLIENT_PCIE2AR &emc>,
+				<&mc TEGRA234_MEMORY_CLIENT_PCIE2AW &emc>;
+		interconnect-names = "dma-mem", "write";
+		iommu-map = <0x0 &smmu_niso1 TEGRA234_SID_PCIE2 0x1000>;
+		iommu-map-mask = <0x0>;
+		dma-coherent;
+
+		status = "disabled";
+	};
+
+	pcie@14140000 {
+		compatible = "nvidia,tegra234-pcie";
+		power-domains = <&bpmp TEGRA234_POWER_DOMAIN_PCIEX1A>;
+		reg = <0x00 0x14140000 0x0 0x00020000>, /* appl registers (128K)      */
+		      <0x00 0x34000000 0x0 0x00040000>, /* configuration space (256K) */
+		      <0x00 0x34040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
+		      <0x00 0x34080000 0x0 0x00040000>; /* DBI reg space (256K)       */
+		reg-names = "appl", "config", "atu_dma", "dbi";
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		num-lanes = <1>;
+		num-viewport = <8>;
+		linux,pci-domain = <3>;
+
+		clocks = <&bpmp TEGRA234_CLK_PEX0_C3_CORE>;
+		clock-names = "core";
+
+		resets = <&bpmp TEGRA234_RESET_PEX0_CORE_3_APB>,
+			 <&bpmp TEGRA234_RESET_PEX0_CORE_3>;
+		reset-names = "apb", "core";
+
+		interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
+			     <GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
+		interrupt-names = "intr", "msi";
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+
+		nvidia,bpmp = <&bpmp 3>;
+
+		nvidia,aspm-cmrt-us = <60>;
+		nvidia,aspm-pwr-on-t-us = <20>;
+		nvidia,aspm-l0s-entrance-latency-us = <3>;
+
+		bus-range = <0x0 0xff>;
+
+		ranges = <0x43000000 0x21 0x00000000 0x21 0x00000000 0x0 0x28000000>, /* prefetchable memory (640 MB) */
+			 <0x02000000 0x0  0x40000000 0x21 0xe8000000 0x0 0x08000000>, /* non-prefetchable memory (128 MB) */
+			 <0x01000000 0x0  0x34100000 0x00 0x34100000 0x0 0x00100000>; /* downstream I/O (1 MB) */
+
+		interconnects = <&mc TEGRA234_MEMORY_CLIENT_PCIE3R &emc>,
+				<&mc TEGRA234_MEMORY_CLIENT_PCIE3W &emc>;
+		interconnect-names = "dma-mem", "write";
+		iommu-map = <0x0 &smmu_niso1 TEGRA234_SID_PCIE3 0x1000>;
+		iommu-map-mask = <0x0>;
+		dma-coherent;
+
+		status = "disabled";
+	};
+
+	pcie@14160000 {
+		compatible = "nvidia,tegra234-pcie";
+		power-domains = <&bpmp TEGRA234_POWER_DOMAIN_PCIEX4BB>;
+		reg = <0x00 0x14160000 0x0 0x00020000>, /* appl registers (128K)      */
+		      <0x00 0x36000000 0x0 0x00040000>, /* configuration space (256K) */
+		      <0x00 0x36040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
+		      <0x00 0x36080000 0x0 0x00040000>; /* DBI reg space (256K)       */
+		reg-names = "appl", "config", "atu_dma", "dbi";
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		num-lanes = <4>;
+		num-viewport = <8>;
+		linux,pci-domain = <4>;
+
+		clocks = <&bpmp TEGRA234_CLK_PEX0_C4_CORE>;
+		clock-names = "core";
+
+		resets = <&bpmp TEGRA234_RESET_PEX0_CORE_4_APB>,
+			 <&bpmp TEGRA234_RESET_PEX0_CORE_4>;
+		reset-names = "apb", "core";
+
+		interrupts = <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
+			     <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
+		interrupt-names = "intr", "msi";
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+
+		nvidia,bpmp = <&bpmp 4>;
+
+		nvidia,aspm-cmrt-us = <60>;
+		nvidia,aspm-pwr-on-t-us = <20>;
+		nvidia,aspm-l0s-entrance-latency-us = <3>;
+
+		bus-range = <0x0 0xff>;
+
+		ranges = <0x43000000 0x21 0x40000000 0x21 0x40000000 0x2 0xe8000000>, /* prefetchable memory (11904 MB) */
+			 <0x02000000 0x0  0x40000000 0x24 0x28000000 0x0 0x08000000>, /* non-prefetchable memory (128 MB) */
+			 <0x01000000 0x0  0x36100000 0x00 0x36100000 0x0 0x00100000>; /* downstream I/O (1 MB) */
+
+		interconnects = <&mc TEGRA234_MEMORY_CLIENT_PCIE4R &emc>,
+				<&mc TEGRA234_MEMORY_CLIENT_PCIE4W &emc>;
+		interconnect-names = "dma-mem", "write";
+		iommu-map = <0x0 &smmu_niso0 TEGRA234_SID_PCIE4 0x1000>;
+		iommu-map-mask = <0x0>;
+		dma-coherent;
+
+		status = "disabled";
+	};
+
+	pcie@14180000 {
+		compatible = "nvidia,tegra234-pcie";
+		power-domains = <&bpmp TEGRA234_POWER_DOMAIN_PCIEX4BA>;
+		reg = <0x00 0x14180000 0x0 0x00020000>, /* appl registers (128K)      */
+		      <0x00 0x38000000 0x0 0x00040000>, /* configuration space (256K) */
+		      <0x00 0x38040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
+		      <0x00 0x38080000 0x0 0x00040000>; /* DBI reg space (256K)       */
+		reg-names = "appl", "config", "atu_dma", "dbi";
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		num-lanes = <4>;
+		num-viewport = <8>;
+		linux,pci-domain = <0>;
+
+		clocks = <&bpmp TEGRA234_CLK_PEX0_C0_CORE>;
+		clock-names = "core";
+
+		resets = <&bpmp TEGRA234_RESET_PEX0_CORE_0_APB>,
+			 <&bpmp TEGRA234_RESET_PEX0_CORE_0>;
+		reset-names = "apb", "core";
+
+		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
+			     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
+		interrupt-names = "intr", "msi";
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
+
+		nvidia,bpmp = <&bpmp 0>;
+
+		nvidia,aspm-cmrt-us = <60>;
+		nvidia,aspm-pwr-on-t-us = <20>;
+		nvidia,aspm-l0s-entrance-latency-us = <3>;
+
+		bus-range = <0x0 0xff>;
+
+		ranges = <0x43000000 0x24 0x40000000 0x24 0x40000000 0x2 0xe8000000>, /* prefetchable memory (11904 MB) */
+			 <0x02000000 0x0  0x40000000 0x27 0x28000000 0x0 0x08000000>, /* non-prefetchable memory (128 MB) */
+			 <0x01000000 0x0  0x38100000 0x00 0x38100000 0x0 0x00100000>; /* downstream I/O (1 MB) */
+
+		interconnects = <&mc TEGRA234_MEMORY_CLIENT_PCIE0R &emc>,
+				<&mc TEGRA234_MEMORY_CLIENT_PCIE0W &emc>;
+		interconnect-names = "dma-mem", "write";
+		iommu-map = <0x0 &smmu_niso0 TEGRA234_SID_PCIE0 0x1000>;
+		iommu-map-mask = <0x0>;
+		dma-coherent;
+
+		status = "disabled";
+	};
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
+		iommu-map = <0x0 &smmu_niso0 TEGRA234_SID_PCIE5 0x1000>;
+		iommu-map-mask = <0x0>;
+		dma-coherent;
+
+		status = "disabled";
+	};
+
+	pcie@141c0000 {
+		compatible = "nvidia,tegra234-pcie";
+		power-domains = <&bpmp TEGRA234_POWER_DOMAIN_PCIEX4A>;
+		reg = <0x00 0x141c0000 0x0 0x00020000>, /* appl registers (128K)      */
+		      <0x00 0x3c000000 0x0 0x00040000>, /* configuration space (256K) */
+		      <0x00 0x3c040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
+		      <0x00 0x3c080000 0x0 0x00040000>; /* DBI reg space (256K)       */
+		reg-names = "appl", "config", "atu_dma", "dbi";
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		num-lanes = <4>;
+		num-viewport = <8>;
+		linux,pci-domain = <6>;
+
+		clocks = <&bpmp TEGRA234_CLK_PEX1_C6_CORE>;
+		clock-names = "core";
+
+		resets = <&bpmp TEGRA234_RESET_PEX1_CORE_6_APB>,
+			 <&bpmp TEGRA234_RESET_PEX1_CORE_6>;
+		reset-names = "apb", "core";
+
+		interrupts = <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
+			     <GIC_SPI 353 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
+		interrupt-names = "intr", "msi";
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>;
+
+		nvidia,bpmp = <&bpmp 6>;
+
+		nvidia,aspm-cmrt-us = <60>;
+		nvidia,aspm-pwr-on-t-us = <20>;
+		nvidia,aspm-l0s-entrance-latency-us = <3>;
+
+		bus-range = <0x0 0xff>;
+
+		ranges = <0x43000000 0x2b 0x40000000 0x2b 0x40000000 0x2 0xe8000000>, /* prefetchable memory (11904 MB) */
+			 <0x02000000 0x0  0x40000000 0x2e 0x28000000 0x0 0x08000000>, /* non-prefetchable memory (128 MB) */
+			 <0x01000000 0x0  0x3c100000 0x00 0x3c100000 0x0 0x00100000>; /* downstream I/O (1 MB) */
+
+		interconnects = <&mc TEGRA234_MEMORY_CLIENT_PCIE6AR &emc>,
+				<&mc TEGRA234_MEMORY_CLIENT_PCIE6AW &emc>;
+		interconnect-names = "dma-mem", "write";
+		iommu-map = <0x0 &smmu_niso0 TEGRA234_SID_PCIE6 0x1000>;
+		iommu-map-mask = <0x0>;
+		dma-coherent;
+
+		status = "disabled";
+	};
+
+	pcie@141e0000 {
+		compatible = "nvidia,tegra234-pcie";
+		power-domains = <&bpmp TEGRA234_POWER_DOMAIN_PCIEX8B>;
+		reg = <0x00 0x141e0000 0x0 0x00020000>, /* appl registers (128K)      */
+		      <0x00 0x3e000000 0x0 0x00040000>, /* configuration space (256K) */
+		      <0x00 0x3e040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
+		      <0x00 0x3e080000 0x0 0x00040000>; /* DBI reg space (256K)       */
+		reg-names = "appl", "config", "atu_dma", "dbi";
+
+		#address-cells = <3>;
+		#size-cells = <2>;
+		device_type = "pci";
+		num-lanes = <8>;
+		num-viewport = <8>;
+		linux,pci-domain = <7>;
+
+		clocks = <&bpmp TEGRA234_CLK_PEX2_C7_CORE>;
+		clock-names = "core";
+
+		resets = <&bpmp TEGRA234_RESET_PEX2_CORE_7_APB>,
+			 <&bpmp TEGRA234_RESET_PEX2_CORE_7>;
+		reset-names = "apb", "core";
+
+		interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
+			     <GIC_SPI 355 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
+		interrupt-names = "intr", "msi";
+
+		#interrupt-cells = <1>;
+		interrupt-map-mask = <0 0 0 0>;
+		interrupt-map = <0 0 0 0 &gic GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;
+
+		nvidia,bpmp = <&bpmp 7>;
+
+		nvidia,aspm-cmrt-us = <60>;
+		nvidia,aspm-pwr-on-t-us = <20>;
+		nvidia,aspm-l0s-entrance-latency-us = <3>;
+
+		bus-range = <0x0 0xff>;
+
+		ranges = <0x43000000 0x2e 0x40000000 0x2e 0x40000000 0x3 0xe8000000>, /* prefetchable memory (16000 MB) */
+			 <0x02000000 0x0  0x40000000 0x32 0x28000000 0x0 0x08000000>, /* non-prefetchable memory (128 MB) */
+			 <0x01000000 0x0  0x3e100000 0x00 0x3e100000 0x0 0x00100000>; /* downstream I/O (1 MB) */
+
+		interconnects = <&mc TEGRA234_MEMORY_CLIENT_PCIE7AR &emc>,
+				<&mc TEGRA234_MEMORY_CLIENT_PCIE7AW &emc>;
+		interconnect-names = "dma-mem", "write";
+		iommu-map = <0x0 &smmu_niso1 TEGRA234_SID_PCIE7 0x1000>;
+		iommu-map-mask = <0x0>;
+		dma-coherent;
+
+		status = "disabled";
+	};
+
+	pcie-ep@141a0000 {
+		compatible = "nvidia,tegra234-pcie-ep";
+		power-domains = <&bpmp TEGRA234_POWER_DOMAIN_PCIEX8A>;
+		reg = <0x00 0x141a0000 0x0 0x00020000>, /* appl registers (128K)      */
+		      <0x00 0x3a040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
+		      <0x00 0x3a080000 0x0 0x00040000>, /* DBI reg space (256K)       */
+		      <0x27 0x40000000 0x4 0x00000000>; /* Address Space (16G)        */
+		reg-names = "appl", "atu_dma", "dbi", "addr_space";
+
+		num-lanes = <8>;
+
+		clocks = <&bpmp TEGRA234_CLK_PEX1_C5_CORE>;
+		clock-names = "core";
+
+		resets = <&bpmp TEGRA234_RESET_PEX1_CORE_5_APB>,
+			 <&bpmp TEGRA234_RESET_PEX1_CORE_5>;
+		reset-names = "apb", "core";
+
+		interrupts = <GIC_SPI 53 IRQ_TYPE_LEVEL_HIGH>;	/* controller interrupt */
+		interrupt-names = "intr";
+
+		nvidia,bpmp = <&bpmp 5>;
+
+		nvidia,enable-ext-refclk;
+		nvidia,aspm-cmrt-us = <60>;
+		nvidia,aspm-pwr-on-t-us = <20>;
+		nvidia,aspm-l0s-entrance-latency-us = <3>;
+
+		interconnects = <&mc TEGRA234_MEMORY_CLIENT_PCIE5R &emc>,
+				<&mc TEGRA234_MEMORY_CLIENT_PCIE5W &emc>;
+		interconnect-names = "dma-mem", "write";
+		iommu-map = <0x0 &smmu_niso0 TEGRA234_SID_PCIE5 0x1000>;
+		iommu-map-mask = <0x0>;
+		dma-coherent;
+
+		status = "disabled";
+	};
+
+	pcie-ep@141c0000{
+		compatible = "nvidia,tegra234-pcie-ep";
+		power-domains = <&bpmp TEGRA234_POWER_DOMAIN_PCIEX4A>;
+		reg = <0x00 0x141c0000 0x0 0x00020000>, /* appl registers (128K)      */
+		      <0x00 0x3c040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
+		      <0x00 0x3c080000 0x0 0x00040000>, /* DBI space (256K)           */
+		      <0x2b 0x40000000 0x3 0x00000000>; /* Address Space (12G)        */
+		reg-names = "appl", "atu_dma", "dbi", "addr_space";
+
+		num-lanes = <4>;
+
+		clocks = <&bpmp TEGRA234_CLK_PEX1_C6_CORE>;
+		clock-names = "core";
+
+		resets = <&bpmp TEGRA234_RESET_PEX1_CORE_6_APB>,
+			 <&bpmp TEGRA234_RESET_PEX1_CORE_6>;
+		reset-names = "apb", "core";
+
+		interrupts = <GIC_SPI 352 IRQ_TYPE_LEVEL_HIGH>;	/* controller interrupt */
+		interrupt-names = "intr";
+
+		nvidia,bpmp = <&bpmp 6>;
+
+		nvidia,enable-ext-refclk;
+		nvidia,aspm-cmrt-us = <60>;
+		nvidia,aspm-pwr-on-t-us = <20>;
+		nvidia,aspm-l0s-entrance-latency-us = <3>;
+
+		interconnects = <&mc TEGRA234_MEMORY_CLIENT_PCIE6AR &emc>,
+				<&mc TEGRA234_MEMORY_CLIENT_PCIE6AW &emc>;
+		interconnect-names = "dma-mem", "write";
+		iommu-map = <0x0 &smmu_niso0 TEGRA234_SID_PCIE6 0x1000>;
+		iommu-map-mask = <0x0>;
+		dma-coherent;
+
+		status = "disabled";
+	};
+
+	pcie-ep@141e0000{
+		compatible = "nvidia,tegra234-pcie-ep";
+		power-domains = <&bpmp TEGRA234_POWER_DOMAIN_PCIEX8B>;
+		reg = <0x00 0x141e0000 0x0 0x00020000>, /* appl registers (128K)      */
+		      <0x00 0x3e040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
+		      <0x00 0x3e080000 0x0 0x00040000>, /* DBI space (256K)           */
+		      <0x2e 0x40000000 0x4 0x00000000>; /* Address Space (16G)        */
+		reg-names = "appl", "atu_dma", "dbi", "addr_space";
+
+		num-lanes = <8>;
+
+		clocks = <&bpmp TEGRA234_CLK_PEX2_C7_CORE>;
+		clock-names = "core";
+
+		resets = <&bpmp TEGRA234_RESET_PEX2_CORE_7_APB>,
+			 <&bpmp TEGRA234_RESET_PEX2_CORE_7>;
+		reset-names = "apb", "core";
+
+		interrupts = <GIC_SPI 354 IRQ_TYPE_LEVEL_HIGH>;	/* controller interrupt */
+		interrupt-names = "intr";
+
+		nvidia,bpmp = <&bpmp 7>;
+
+		nvidia,enable-ext-refclk;
+		nvidia,aspm-cmrt-us = <60>;
+		nvidia,aspm-pwr-on-t-us = <20>;
+		nvidia,aspm-l0s-entrance-latency-us = <3>;
+
+		interconnects = <&mc TEGRA234_MEMORY_CLIENT_PCIE7AR &emc>,
+				<&mc TEGRA234_MEMORY_CLIENT_PCIE7AW &emc>;
+		interconnect-names = "dma-mem", "write";
+		iommu-map = <0x0 &smmu_niso1 TEGRA234_SID_PCIE7 0x1000>;
+		iommu-map-mask = <0x0>;
+		dma-coherent;
+
+		status = "disabled";
+	};
+
+	pcie-ep@140e0000{
+		compatible = "nvidia,tegra234-pcie-ep";
+		power-domains = <&bpmp TEGRA234_POWER_DOMAIN_PCIEX4CC>;
+		reg = <0x00 0x140e0000 0x0 0x00020000>, /* appl registers (128K)      */
+		      <0x00 0x2e040000 0x0 0x00040000>, /* iATU_DMA reg space (256K)  */
+		      <0x00 0x2e080000 0x0 0x00040000>, /* DBI space (256K)           */
+		      <0x38 0x40000000 0x3 0x00000000>; /* Address Space (12G)        */
+		reg-names = "appl", "atu_dma", "dbi", "addr_space";
+
+		num-lanes = <4>;
+
+		clocks = <&bpmp TEGRA234_CLK_PEX2_C10_CORE>;
+		clock-names = "core";
+
+		resets = <&bpmp TEGRA234_RESET_PEX2_CORE_10_APB>,
+			 <&bpmp TEGRA234_RESET_PEX2_CORE_10>;
+		reset-names = "apb", "core";
+
+		interrupts = <GIC_SPI 360 IRQ_TYPE_LEVEL_HIGH>;	/* controller interrupt */
+		interrupt-names = "intr";
+
+		nvidia,bpmp = <&bpmp 10>;
+
+		nvidia,enable-ext-refclk;
+		nvidia,aspm-cmrt-us = <60>;
+		nvidia,aspm-pwr-on-t-us = <20>;
+		nvidia,aspm-l0s-entrance-latency-us = <3>;
+
+		interconnects = <&mc TEGRA234_MEMORY_CLIENT_PCIE10AR &emc>,
+				<&mc TEGRA234_MEMORY_CLIENT_PCIE10AW &emc>;
+		interconnect-names = "dma-mem", "write";
+		iommu-map = <0x0 &smmu_niso1 TEGRA234_SID_PCIE10 0x1000>;
+		iommu-map-mask = <0x0>;
+		dma-coherent;
+
+		status = "disabled";
+	};
+
 	sram@40000000 {
 		compatible = "nvidia,tegra234-sysram", "mmio-sram";
 		reg = <0x0 0x40000000 0x0 0x80000>;
-- 
2.17.1

