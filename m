Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38FCC15B849
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 05:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729696AbgBMELC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Feb 2020 23:11:02 -0500
Received: from mail-am6eur05on2088.outbound.protection.outlook.com ([40.107.22.88]:23790
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729440AbgBMELC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Feb 2020 23:11:02 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ls7KwsKrc4g1+x7Zp4KEHR4Jn++JlqWboMkMbZHaiuW426llAWDkv0qxeNY1eY5S2DlggirQpJbhozIENt4XD3gMTyVLHO9myfSLI8zulnER/kHj/TACwdqoifFRihl2kAMe1doMEk4XCjdsNoZRDP5PvglgzA4Wcd6fDR8xPH107uzrudrrWc+auzjPNGOKFkHlkLdnyg4vBPm+SAw59G2o9khLexQE8ixDjj6K1dU/BH3wCAwqo+WY+PgOTKswEw1tGqGAYz/FBuC2yDRMbIema/3RPMvlHcbKFOIav/0HrbmrQbQ2utw+Ooo5ks+trVf3ZXOiHBIQ49fDPKbFjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7Prm0Z5iQv4RzXjQxeh7hT4mLCkzIGb9TZYW5shPR4=;
 b=P8IzIujQqO61iI034KeTi/Yh64g369QAjhrQyZKsrV/iK6Hasg1qWPzvjFu0/M3W5Pnln/oPEDvYCz/BA30RzvJrFauacEYc9FKX4aXkY9yaTSuqdvu7PA/ROarZNr2QYKVeIKM6wFIO0ApxGqbnnS7zeRCkpD6hYtoLtnfJPJHBav/wp8ABVIFXGyOvr/A/88zULp/agzvZUgaQT1bgDAPsw0kLPWgc9Rin3bOJvsinZDOuqrqkA3lN6OdaaVeEjj8cQZ/FHemSKg2E+zUaoHFtS/kJhYmUJ/DnLCqb5ruTApRGO1m4CjkDJlrMXkCFm8tMcv/N09x2dq94CrCs0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z7Prm0Z5iQv4RzXjQxeh7hT4mLCkzIGb9TZYW5shPR4=;
 b=lWEXV/Um8SHmcO4TE2kdXqVjZnWvCyhU8MMTkmNTsYA74RRrVAFuOYh9lXvjLRQJB/6cZ9I5haKrLClKt+0QOlqhmsnsHsiyG0OWqs4K+NLElQffrsVd4Vs79L47YGj/a+bIOvN4DSqOpndxCJ1DwurQ8pger+hBTVatMnwubVE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB5660.eurprd04.prod.outlook.com (20.179.9.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22; Thu, 13 Feb 2020 04:10:57 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa%4]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 04:10:57 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, andrew.murray@arm.com,
        arnd@arndb.de, mark.rutland@arm.com, l.subrahmanya@mobiveil.co.in,
        shawnguo@kernel.org, m.karthikeyan@mobiveil.co.in,
        leoyang.li@nxp.com, lorenzo.pieralisi@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com, Xiaowei.Bao@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv10 12/13] arm64: dts: lx2160a: Add PCIe controller DT nodes
Date:   Thu, 13 Feb 2020 12:06:43 +0800
Message-Id: <20200213040644.45858-13-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
References: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0069.apcprd04.prod.outlook.com
 (2603:1096:202:15::13) To DB8PR04MB6747.eurprd04.prod.outlook.com
 (2603:10a6:10:10b::31)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.73) by HK2PR04CA0069.apcprd04.prod.outlook.com (2603:1096:202:15::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24 via Frontend Transport; Thu, 13 Feb 2020 04:10:51 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.73]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d31b7461-1320-4f56-54e9-08d7b03ab9c6
X-MS-TrafficTypeDiagnostic: DB8PR04MB5660:|DB8PR04MB5660:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB56609EC9F826A941615E7D35841A0@DB8PR04MB5660.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:363;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(396003)(346002)(136003)(376002)(366004)(39860400002)(189003)(199004)(6666004)(81156014)(5660300002)(69590400006)(478600001)(81166006)(8936002)(66476007)(4326008)(66556008)(8676002)(316002)(2616005)(86362001)(6512007)(2906002)(6486002)(7416002)(6506007)(1076003)(16526019)(26005)(36756003)(186003)(66946007)(52116002)(956004)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB5660;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /IRFUINYRHdDW82tBAnOlWrIWfimiWWxJ9Dpam23P0qz0peU6SAqXM0sei4bYKNHN3rQgs9wx+VOgWHQOf93F6mlD6CuoDCB6PCURWZEUzE+kzrm2sbTW57w8wVSSX3hPRk5eFzOPb2nu3AW6rj1hjMx670fnagl3ydoqam1K63Hhf1TISOUnQRBa3fc1QiQiXpjGGxvvHftApEq1Fl9M8spWG9uofVrogujLMY9BcA4ae8jEGuSDz9jI1n6XJ70Cwbua3A+ghiOnspgV+lF23rb+m6bWhOXzmniCEqkyN1hLi4EqQkMAOni58DoGRjTRUCiVFeSDyXYh8n9/rb3hp53OK8RauyNy4LvtPgDVjQZtY2zYf4hMhEnXqsifQ5NIfDmsum+7d0vJElcv0rksaBjFZGGOBIrwf65hiIOE45YOWh1qO45I3ZDIqvtJ1BTm2xVZ3ZSo1dwVtF7wxsFkKt6pjcWDWHSd2hVOjUdGHZ5rqVXhYcb8aDhdjPtF8ayJEw0YQSI2ASBp14O7l2Txe0mG0EA52C25ulZaWG2Ssh5Hd0m8KNVU/ouMKLAt9OrnZKI0Z4WPyBOAoeHjVjAtg==
X-MS-Exchange-AntiSpam-MessageData: G6QYZ8nx848HDE0YqgYvWMVno5pFlC7NFZ3vPgK8B+5mwpHDZferr5bTt4cXWpCCA3hdHloOCMxqCkXVW3zmAMSfejgxnqO+/AQSddNrBvdkmrKyphRyWW8ENBwPAfpAjZKZ0tUopn+RGhw6utDcgw==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d31b7461-1320-4f56-54e9-08d7b03ab9c6
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 04:10:56.9887
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DKHKF0Fn45z37D1+fGzNkyIhcKG2JhIBl3af9iTV6JIZzSZJIKQ9XqQGUzwv9ZzWDKdjZ4gQbCQhnJ9NGl0Nmw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5660
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

The LX2160A integrated 6 PCIe Gen4 controllers.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
---
V10:
 - No change

 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 163 ++++++++++++++++++
 1 file changed, 163 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index e5ee5591e52b..aee2810d91cc 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1076,5 +1076,168 @@
 				};
 			};
 		};
+
+		pcie@3400000 {
+			compatible = "fsl,lx2160a-pcie";
+			reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
+			       0x80 0x00000000 0x0 0x00001000>; /* configuration space */
+			reg-names = "csr_axi_slave", "config_axi_slave";
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
+				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
+				     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupt-names = "aer", "pme", "intr";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			dma-coherent;
+			apio-wins = <8>;
+			ppio-wins = <8>;
+			bus-range = <0x0 0xff>;
+			ranges = <0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			msi-parent = <&its>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 2 &gic 0 0 GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic 0 0 GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic 0 0 GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		pcie@3500000 {
+			compatible = "fsl,lx2160a-pcie";
+			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
+			       0x88 0x00000000 0x0 0x00001000>; /* configuration space */
+			reg-names = "csr_axi_slave", "config_axi_slave";
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
+				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
+				     <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupt-names = "aer", "pme", "intr";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			dma-coherent;
+			apio-wins = <8>;
+			ppio-wins = <8>;
+			bus-range = <0x0 0xff>;
+			ranges = <0x82000000 0x0 0x40000000 0x88 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			msi-parent = <&its>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 114 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 2 &gic 0 0 GIC_SPI 115 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic 0 0 GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic 0 0 GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		pcie@3600000 {
+			compatible = "fsl,lx2160a-pcie";
+			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
+			       0x90 0x00000000 0x0 0x00001000>; /* configuration space */
+			reg-names = "csr_axi_slave", "config_axi_slave";
+			interrupts = <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupt-names = "aer", "pme", "intr";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			dma-coherent;
+			apio-wins = <256>;
+			ppio-wins = <24>;
+			bus-range = <0x0 0xff>;
+			ranges = <0x82000000 0x0 0x40000000 0x90 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			msi-parent = <&its>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 119 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 2 &gic 0 0 GIC_SPI 120 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic 0 0 GIC_SPI 121 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic 0 0 GIC_SPI 122 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		pcie@3700000 {
+			compatible = "fsl,lx2160a-pcie";
+			reg = <0x00 0x03700000 0x0 0x00100000   /* controller registers */
+			       0x98 0x00000000 0x0 0x00001000>; /* configuration space */
+			reg-names = "csr_axi_slave", "config_axi_slave";
+			interrupts = <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
+				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
+				     <GIC_SPI 123 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupt-names = "aer", "pme", "intr";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			dma-coherent;
+			apio-wins = <8>;
+			ppio-wins = <8>;
+			bus-range = <0x0 0xff>;
+			ranges = <0x82000000 0x0 0x40000000 0x98 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			msi-parent = <&its>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 2 &gic 0 0 GIC_SPI 125 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic 0 0 GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic 0 0 GIC_SPI 127 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		pcie@3800000 {
+			compatible = "fsl,lx2160a-pcie";
+			reg = <0x00 0x03800000 0x0 0x00100000   /* controller registers */
+			       0xa0 0x00000000 0x0 0x00001000>; /* configuration space */
+			reg-names = "csr_axi_slave", "config_axi_slave";
+			interrupts = <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
+				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
+				     <GIC_SPI 128 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupt-names = "aer", "pme", "intr";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			dma-coherent;
+			apio-wins = <256>;
+			ppio-wins = <24>;
+			bus-range = <0x0 0xff>;
+			ranges = <0x82000000 0x0 0x40000000 0xa0 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			msi-parent = <&its>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 129 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 2 &gic 0 0 GIC_SPI 130 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic 0 0 GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic 0 0 GIC_SPI 132 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
+		pcie@3900000 {
+			compatible = "fsl,lx2160a-pcie";
+			reg = <0x00 0x03900000 0x0 0x00100000   /* controller registers */
+			       0xa8 0x00000000 0x0 0x00001000>; /* configuration space */
+			reg-names = "csr_axi_slave", "config_axi_slave";
+			interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
+				     <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+			interrupt-names = "aer", "pme", "intr";
+			#address-cells = <3>;
+			#size-cells = <2>;
+			device_type = "pci";
+			dma-coherent;
+			apio-wins = <8>;
+			ppio-wins = <8>;
+			bus-range = <0x0 0xff>;
+			ranges = <0x82000000 0x0 0x40000000 0xa8 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+			msi-parent = <&its>;
+			#interrupt-cells = <1>;
+			interrupt-map-mask = <0 0 0 7>;
+			interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 104 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 2 &gic 0 0 GIC_SPI 105 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 3 &gic 0 0 GIC_SPI 106 IRQ_TYPE_LEVEL_HIGH>,
+					<0000 0 0 4 &gic 0 0 GIC_SPI 107 IRQ_TYPE_LEVEL_HIGH>;
+			status = "disabled";
+		};
+
 	};
 };
-- 
2.17.1

