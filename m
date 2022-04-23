Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E14A50CA30
	for <lists+linux-pci@lfdr.de>; Sat, 23 Apr 2022 14:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235703AbiDWMxH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 23 Apr 2022 08:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235544AbiDWMw0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 23 Apr 2022 08:52:26 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2063.outbound.protection.outlook.com [40.107.93.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7181A802;
        Sat, 23 Apr 2022 05:49:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OLO3eRdS6MI/xourt82A4j1fYzXWEfpsvu3pu7Ah9gPsNm+10pmrv8g41cIilTlxlVgPOTv4Dc1r67gpekJW9aoi1WHWE54GQr+XDXZkmpxzunHhAcfM1V5/E3Ro7uq4jxs30DTeYgXnani7PHrWQo6hXrzKA+8gdGyhxD587xJD2CxsgZXGjDrHNqwYZLO/gJN18Cns3tF0DcvSrGoU3QEF06ZqHFuGGXbY8HTNB6i7feYECh8OHVyP6u+eho0YW/NgDNYNytYZYhh+T4KtGlu1x+n/nS1hSVchVvhaw3ek5/fC8RnEdcVz1Nw6uQilS8dUZcngraSBvH4NN9pVrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LWhPZYgkoiK+ydOAFm+mA2yDdrMN1twr0T2FRHNvVyw=;
 b=Weeoa6MuN3/bYBwvatraOFQSUIXtPwofv/RF9mjQjvXYnr/mMX4vlwgcjfeWAWpYv26J7CQ5AZaf+7+4RrwcMk77r8ujJXJiXxSeasj5S+nP8qwj1GX7H+sgWGw8j+FO6bAwi9pb40DOvIc6IaDE4RWZDsB7AlFwqDWED5YAMQGE0Cc5kBxEPjuqeCxl8oNqbBIj/vwN6O7fjZuRtAZ9aeGipdFWxwcD/+G2f2z07htNJLRchxU9b/qic+QdEnTYqQsOePIg3v/t9hAOz/Zcpow7eympTQQ9zIRT5VBAyN7PhUYWsPvNZZr67p5t0RU7k52r9i3Iohn5yHv6O2bFaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.236) smtp.rcpttodomain=ti.com smtp.mailfrom=nvidia.com; dmarc=pass
 (p=reject sp=reject pct=100) action=none header.from=nvidia.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LWhPZYgkoiK+ydOAFm+mA2yDdrMN1twr0T2FRHNvVyw=;
 b=rAySap46HPUf7SarJ2MXT6cBYV+jDjhQSB7+aK3m/Oe+Xp2aw3fFEkRgEXz3xufUKhvNrkpbVdU7JOnbxxs+KE8JRX+qesTqeYE+ljWTbN9S3IVIuxetCx2/yegXi8m0bulfTp9+QztbroU8uD4H2yxjKLYZn4dfWJXwA7Qq8rF/WjtfBVtDaJkwVzm6UFEefOa2/xssVJ8gWHMJUdDFWL3bO+bDw47RT1e77vjVI/8QX0BbPvDAouwEJQ9AqgVdxhIOKklZ1rohO3dLIcpTegmtUMHP7hn2ccf+l/+5iUQiCjfVBcatW27fbOOVUJTauTpcpfNcpIKiXO8AHNBd1Q==
Received: from BN8PR15CA0012.namprd15.prod.outlook.com (2603:10b6:408:c0::25)
 by MN2PR12MB3024.namprd12.prod.outlook.com (2603:10b6:208:cb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Sat, 23 Apr
 2022 12:49:26 +0000
Received: from BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:c0:cafe::3b) by BN8PR15CA0012.outlook.office365.com
 (2603:10b6:408:c0::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Sat, 23 Apr 2022 12:49:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.236)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.236 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.236; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.236) by
 BN8NAM11FT032.mail.protection.outlook.com (10.13.177.88) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5186.14 via Frontend Transport; Sat, 23 Apr 2022 12:49:26 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 DRHQMAIL109.nvidia.com (10.27.9.19) with Microsoft SMTP Server (TLS) id
 15.0.1497.32; Sat, 23 Apr 2022 12:49:25 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 23 Apr 2022 05:49:24 -0700
Received: from vidyas-desktop.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Sat, 23 Apr 2022 05:49:19 -0700
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
Subject: [PATCH V2 3/8] arm64: tegra: Add P2U and PCIe controller nodes to Tegra234 DT
Date:   Sat, 23 Apr 2022 18:18:53 +0530
Message-ID: <20220423124858.25946-4-vidyas@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220423124858.25946-1-vidyas@nvidia.com>
References: <20220423124858.25946-1-vidyas@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3a4a03f-a8c7-4ae6-f3f8-08da2527b2fb
X-MS-TrafficTypeDiagnostic: MN2PR12MB3024:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB302402594FB4668E934224CFB8F69@MN2PR12MB3024.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eZKbsUZw3RMrNzK/hrEKIdA8zqvgRG84VJp39yoSsHpp9vnTTZQNdCWeUn8jk3DYq227ilD+g1SHNtK4KbH9Hl8LyXI/B770N845hx84j5EqHNOOx7UDy37gN6ZNPRkPCMjq3ne/HFzHAp3VROhV98Rip1fqlGE1EM2/FGuDYAsNWffGiK0Dv2LiwVH4dj5egUq5dKr7feHXBOhym8zAPpxSalTg3h3kRcYom0BvyeMRkb2HBwf4ulRvWkhYJ9anm0P0TK7WCttEkIevNW8Eq1L8C19J/b0HedVKHgRkkYFm+Sbe4QY0fFQSGN0wcTkU0inwKroE/oME4JgvSzlakQmKKxHQZvVPoMQs4PFOwNPoisxkCaq2qM7OyS+ZJuMfuhbNUkxL4Gmw8hT2bQqI1JkUN1NuSD0G5bP+s6ErrjZC7LWx4VXIPsvvE3eotK91Vk/fr5vYjgtPkfU83ReYYQBR0c1VIHQ90noNGlJNAmKj3Z5nL/I7UtACoWPWQne8fjXQRgDpdXQjT2MeozS8mzEsrZPwRGNPMcCgpTPRI+HpbIcbnXmvlrWOaB/D187nvDukw3zkiBe8leu106XGyHXwiignSAsGGG7JOIr1Atucvsrxu0Mg/KPh2E5JmvBEMvWTBGRwYek4g6DXvjsoTEBG6Bo4aoz3cJmFc4Z302UDIowu9uAF2IyOw1qjDG7G8gDXp8dohgmoXT8cctb21w==
X-Forefront-Antispam-Report: CIP:12.22.5.236;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(186003)(1076003)(2906002)(508600001)(6666004)(4326008)(8676002)(86362001)(70206006)(5660300002)(70586007)(110136005)(36756003)(26005)(36860700001)(82310400005)(426003)(336012)(47076005)(2616005)(7696005)(30864003)(40460700003)(6636002)(7416002)(8936002)(356005)(316002)(83380400001)(54906003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2022 12:49:26.0655
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3a4a03f-a8c7-4ae6-f3f8-08da2527b2fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.236];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3024
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
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
V2:
* Added 'iommu-map', 'iommu-map-mask' and 'dma-coherent' entries for each
  PCIe controller node

 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 775 +++++++++++++++++++++++
 1 file changed, 775 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index 8767dbe2d066..c9200d2c1241 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -907,6 +907,198 @@
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
@@ -1293,6 +1485,589 @@
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
+		status = "disabled";
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
+		status = "disabled";
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
+		status = "disabled";
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
+		status = "disabled";
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
+		status = "disabled";
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
+		status = "disabled";
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
+		status = "disabled";
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
+		status = "disabled";
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
+		iommu-map = <0x0 &smmu_niso0 TEGRA234_SID_PCIE5 0x1000>;
+		iommu-map-mask = <0x0>;
+		dma-coherent;
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
+		status = "disabled";
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
+		status = "disabled";
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
+	};
+
 	sram@40000000 {
 		compatible = "nvidia,tegra234-sysram", "mmio-sram";
 		reg = <0x0 0x40000000 0x0 0x80000>;
-- 
2.17.1

