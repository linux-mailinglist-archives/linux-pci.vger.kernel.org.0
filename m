Return-Path: <linux-pci+bounces-1794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3938D826C47
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 12:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1E841F21A19
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 11:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C77714A97;
	Mon,  8 Jan 2024 11:10:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2050.outbound.protection.partner.outlook.cn [139.219.146.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BFC14A93;
	Mon,  8 Jan 2024 11:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RcmS4Xo/vfDZ03V9e6QIYsRrgEOj6ihfmIr7axinSCEj9yGL3ndytWcOiTmkJUYvg1CXJpC8Y5xEyu7l8QvVhSXXPP14HM1iSidgij/3kL37xK5TG0/GLem7mPuBchjTN6VXDQGT0/QFurNtWnOMfIxOlUwL+eHN5bXiunceOFxLCSNNKuY9vOBk3jBKr6Kb7do4WA53EkJv0MY74go2rtZkek8DpgEANCArWJznk9Mr+QecSBDq4CXMtzBqxMkcKyKqkE1z9dOX/JMn0DcLRGV76f0edJiM6y/ZVEqLpZC13bWr5+6iL/HwyA2C29Xqf/aOZwG6G5vDQQd/m1WYNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIXi8JBQnxVNAlvrZCPiLc7iuf6UII3Un7BOHkCInrQ=;
 b=cf8FmjqClcwNqJhrDg/xlOKY3dpJ0Y/g5REAQdXLnrmlu/znev7407nHalyG/mp4HzdyZIrDSLyDTbrd6pv/JKdjfuAeRJZ4A/fFSvlFvfEYrB7l5t1hKtnzAd+0Xj/CI6q2CWqFV49+pDXKmcUiQYE/07CyARxuCmG7HVlNAscMwPaqmFWL+CZrKp2QFH3KRCke7fH2r1erHt6wcb6A72wAmoFGIL1XXyxzq0PZ76tdraI/PlwL8lPi7Y2ARkbRmQntIV2ybzW2GkfxfyopJjA6eXNI6RJFjKOwRtulzQnmc/XCsg/p8IpAYIHiUFAdoKN1SUup31bSZ9BPM21Odw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0797.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.32; Mon, 8 Jan
 2024 11:07:06 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::e6aa:baea:fd8c:4cd2]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::e6aa:baea:fd8c:4cd2%7])
 with mapi id 15.20.7135.032; Mon, 8 Jan 2024 11:07:06 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v14 22/22] riscv: dts: starfive: add PCIe dts configuration for JH7110
Date: Mon,  8 Jan 2024 19:06:12 +0800
Message-Id: <20240108110612.19048-23-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240108110612.19048-1-minda.chen@starfivetech.com>
References: <20240108110612.19048-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0014.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::19) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0797:EE_
X-MS-Office365-Filtering-Correlation-Id: de845b7b-d4b4-42f9-f18d-08dc1039f32d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Au/8Vz0+INYcsoJuhF4WP5xN6C5UqtSNGgbhPwxRWBnURCef0OLthtRM1vX0J5hRWmEIn4/T5C4gLFdsVqgrTyH+rc/mTq5cWIDM1pgIDyCMBur5BYV2MGrfNKKULSKJwmYYdZH1fz2kPQdeqZa1peP1OFXW4wxMa8cbEiVgCzTtsdmGfNE+2WJH0J4yIVws9VqYTDBk0g5h35kqz03pWQCUdQjSkfNa/esl3VGTdIqGQd3vOfQNoMfIO/rGS2RNeVVWheB+SiKtyiCUuse2ISv6Bo/EA7TuMmiATPgshRmGi7QFSbo1Pjs2tXveRPx7i8+Q7YSmjCEmIHyG59ttKTZxdmk63s63m0+cKrC6N6m9ozfomZ6qaPobG/XnE077ia24Aw14UBhLVwKds1RdIMQ+ODVksKkZDboGNjqO7v2+Xuu7p/DblWQok06V+2TILvnMFCbD6231PaS4IhhMQvZqAnTynEnh/wvs2Tvc9WPuWU719I/PiPEMs+dGEAJ57a9Ai1A7WSOifZRjqyqoCJD3GPh2qd5YPG79gp96Thl9E6MjlxoGT9DHbZk4j0g0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39830400003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8936002)(41320700001)(1076003)(107886003)(26005)(2616005)(83380400001)(44832011)(8676002)(4326008)(86362001)(52116002)(508600001)(66476007)(6666004)(66946007)(66556008)(54906003)(110136005)(40160700002)(38100700002)(38350700005)(2906002)(5660300002)(7416002)(40180700001)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CjjHs1FY8r5RTSAc1V1pOA7pkaAFV+TrtEVv0KzF6wkbV1tMq1Lg0OXyykjt?=
 =?us-ascii?Q?W60DP7rQusT67dXF1B3OwqmXH2MsY4tv46KKauTDks+aNw5y44aSwe6jLsPN?=
 =?us-ascii?Q?4N5yYb6cYXr9+Ik/jzG5Ioga3Dlz/HmRrIsdAMwb496M6hxETKqj+2sCnbFA?=
 =?us-ascii?Q?GlMEgxFeSgAjWv+BPY9mXavXjXCPb9iH1H3q0tfvk/U3Sxk/25Cf+rstykFd?=
 =?us-ascii?Q?Byb2mAtJO2iqOLj7VfGFaSzwcPrlY/36xYTPLDuobMxdyVrten0zqSqVgi6X?=
 =?us-ascii?Q?0PKeZ22AjbXS2MQk4zicHUoFSVYib5F+76jld3uq3Xj1CnMPHdfzziVWH91v?=
 =?us-ascii?Q?Q0TRNhPqyfC5COVyaheL+vnK1LmUoB9CDvWpVoZevt/8BB7prRj8cvdv+hPf?=
 =?us-ascii?Q?3Wd2Tp5MNROOnEezFxHiV/28vcCLjxDgY6qaj+0l36/CShjFv02+gYF5ie0A?=
 =?us-ascii?Q?e8CJZdSaACBRqWCFoZnTohSQ5qr0Wwh+dsHU672xMffi3CmEqdeFjDhyw5If?=
 =?us-ascii?Q?5jK7SOL56bdOlxA80jHQcvD/7bYNLkJFppHnpDUsi1N1FysqykERL3ipT49K?=
 =?us-ascii?Q?Kr088/mtaHhR0Fr0e2qf5RQP+I/oN+ufnov3dXqmTHThUbeULgetJmd7xQ7O?=
 =?us-ascii?Q?bT4TSLN2WO37gwimqPbP+Iqv29swzctXs704xoyDnm4jAhwWJLhUgO60QfIJ?=
 =?us-ascii?Q?raTg4S6sBJ6xZY1NxgAa31i97xQBcWTIcDLvwRYuY5T+flddmkdfT5cj3KDQ?=
 =?us-ascii?Q?MZqvC8boKrMvOMvJReV6VgbH7+GpPdNi6oHEraSmEHKpnEkn101QzaiS9QPK?=
 =?us-ascii?Q?fAfJ++JLrnKrzI6y/qaZKIMoNn9Y0bmxfscgBL/tSY3p1kLBPFk7xR+jb1zM?=
 =?us-ascii?Q?SkDf6/oT+IH4T0CEeAeJcSBND7LAU2jH/1yiS24Ybnij828Du/yDmmif1HLR?=
 =?us-ascii?Q?3h6zZrFJPtqu2246sc1/sZpas2oKco4bm4fonxXWBeIxCXhRo3ePVUmMB5P6?=
 =?us-ascii?Q?YfoGDZcSdKvaemVa1vNsZLTIinHIIt5pA7AQ74Hz4UtbqzCOxtpyXMh/9ArL?=
 =?us-ascii?Q?/HUiPGsL5v1T9cOUBU+4vDqk2z0yMxKWF57ReaTzEfSBZMXWnLGaeWJ0lFpL?=
 =?us-ascii?Q?sHL71etoj0h/YX/fdIdDHVbC7mxJp1wqnjsu/tC6sdF7a4hLTbSFWScGPixY?=
 =?us-ascii?Q?spWPv+URgq45sFs8OA9m1Y7KsFAnCi/rTlLVNXooNABeeNA/ePiQIgjPvWzf?=
 =?us-ascii?Q?F9ODdPirWCTxZqzucpSQjbBn03cEpfe9h20VrJOrieqLT4oobW+I4yDSZNcx?=
 =?us-ascii?Q?DiCFzP7Bb2KhFdRjhnwka/X1iDPcfgE1pUm50gvRABrVRQdptdeFcwWzO1c0?=
 =?us-ascii?Q?nbCJnwO7pzYE9R5StU4UcYjI67m+oPe4Y7iBmQat1udrKT45CkzuchB2wYdR?=
 =?us-ascii?Q?dwzPw7yz9PEuXntI4U0VWwWBXcA8InXy03NT9TXJxZkrixzdcqI1nTgNXGht?=
 =?us-ascii?Q?Es79lXtbT7dDRSMXphhwWQKR5pnyz4CzkGP5iGwlzpm2B4Is+guEjraGWxf+?=
 =?us-ascii?Q?E9/Yd8E0PB364pw/xECS1Nik1pdiejVDQ6sT3yTjR3qiKT3e9ULQJXCZ+olc?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de845b7b-d4b4-42f9-f18d-08dc1039f32d
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 11:07:06.0221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2CeAkd7su+36H9bEo1LJ28pvECYhwOwPfDOknYCI16hpLPfH77nx79b14S30urmZG2P4lSKBtBwCYe+AVZXP9MgmDZZyQcpikxvikMmLnGQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0797

Add PCIe dts configuraion for JH7110 SoC platform.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../jh7110-starfive-visionfive-2.dtsi         | 64 ++++++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 86 +++++++++++++++++++
 2 files changed, 150 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index b89e9791efa7..2f8056d6f817 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -287,6 +287,22 @@
 	status = "okay";
 };
 
+&pcie0 {
+	perst-gpios = <&sysgpio 26 GPIO_ACTIVE_LOW>;
+	phys = <&pciephy0>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie0_pins>;
+	status = "okay";
+};
+
+&pcie1 {
+	perst-gpios = <&sysgpio 28 GPIO_ACTIVE_LOW>;
+	phys = <&pciephy1>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pcie1_pins>;
+	status = "okay";
+};
+
 &qspi {
 	#address-cells = <1>;
 	#size-cells = <0>;
@@ -513,6 +529,54 @@
 		};
 	};
 
+	pcie0_pins: pcie0-0 {
+		clkreq-pins {
+			pinmux = <GPIOMUX(27, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_NONE)>;
+			bias-pull-down;
+			drive-strength = <2>;
+			input-enable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+
+		wake-pins {
+			pinmux = <GPIOMUX(32, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_NONE)>;
+			bias-pull-up;
+			drive-strength = <2>;
+			input-enable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+
+	pcie1_pins: pcie1-0 {
+		clkreq-pins {
+			pinmux = <GPIOMUX(29, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_NONE)>;
+			bias-pull-down;
+			drive-strength = <2>;
+			input-enable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+
+		wake-pins {
+			pinmux = <GPIOMUX(21, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_NONE)>;
+			bias-pull-up;
+			drive-strength = <2>;
+			input-enable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+	};
+
 	spi0_pins: spi0-0 {
 		mosi-pins {
 			pinmux = <GPIOMUX(52, GPOUT_SYS_SPI0_TXD,
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 45213cdf50dc..dfa2f94ed5b2 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -1138,5 +1138,91 @@
 			#reset-cells = <1>;
 			power-domains = <&pwrc JH7110_PD_VOUT>;
 		};
+
+		pcie0: pcie@940000000 {
+			compatible = "starfive,jh7110-pcie";
+			reg = <0x9 0x40000000 0x0 0x1000000>,
+			      <0x0 0x2b000000 0x0 0x100000>;
+			reg-names = "cfg", "apb";
+			linux,pci-domain = <0>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			ranges = <0x82000000  0x0 0x30000000  0x0 0x30000000 0x0 0x08000000>,
+				 <0xc3000000  0x9 0x00000000  0x9 0x00000000 0x0 0x40000000>;
+			interrupts = <56>;
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+			interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc0 0x1>,
+					<0x0 0x0 0x0 0x2 &pcie_intc0 0x2>,
+					<0x0 0x0 0x0 0x3 &pcie_intc0 0x3>,
+					<0x0 0x0 0x0 0x4 &pcie_intc0 0x4>;
+			msi-controller;
+			device_type = "pci";
+			starfive,stg-syscon = <&stg_syscon>;
+			bus-range = <0x0 0xff>;
+			clocks = <&syscrg JH7110_SYSCLK_NOC_BUS_STG_AXI>,
+				 <&stgcrg JH7110_STGCLK_PCIE0_TL>,
+				 <&stgcrg JH7110_STGCLK_PCIE0_AXI_MST0>,
+				 <&stgcrg JH7110_STGCLK_PCIE0_APB>;
+			clock-names = "noc", "tl", "axi_mst0", "apb";
+			resets = <&stgcrg JH7110_STGRST_PCIE0_AXI_MST0>,
+				 <&stgcrg JH7110_STGRST_PCIE0_AXI_SLV0>,
+				 <&stgcrg JH7110_STGRST_PCIE0_AXI_SLV>,
+				 <&stgcrg JH7110_STGRST_PCIE0_BRG>,
+				 <&stgcrg JH7110_STGRST_PCIE0_CORE>,
+				 <&stgcrg JH7110_STGRST_PCIE0_APB>;
+			reset-names = "mst0", "slv0", "slv", "brg",
+				      "core", "apb";
+			status = "disabled";
+
+			pcie_intc0: interrupt-controller {
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
+
+		pcie1: pcie@9c0000000 {
+			compatible = "starfive,jh7110-pcie";
+			reg = <0x9 0xc0000000 0x0 0x1000000>,
+			      <0x0 0x2c000000 0x0 0x100000>;
+			reg-names = "cfg", "apb";
+			linux,pci-domain = <1>;
+			#address-cells = <3>;
+			#size-cells = <2>;
+			#interrupt-cells = <1>;
+			ranges = <0x82000000  0x0 0x38000000  0x0 0x38000000 0x0 0x08000000>,
+				 <0xc3000000  0x9 0x80000000  0x9 0x80000000 0x0 0x40000000>;
+			interrupts = <57>;
+			interrupt-map-mask = <0x0 0x0 0x0 0x7>;
+			interrupt-map = <0x0 0x0 0x0 0x1 &pcie_intc1 0x1>,
+					<0x0 0x0 0x0 0x2 &pcie_intc1 0x2>,
+					<0x0 0x0 0x0 0x3 &pcie_intc1 0x3>,
+					<0x0 0x0 0x0 0x4 &pcie_intc1 0x4>;
+			msi-controller;
+			device_type = "pci";
+			starfive,stg-syscon = <&stg_syscon>;
+			bus-range = <0x0 0xff>;
+			clocks = <&syscrg JH7110_SYSCLK_NOC_BUS_STG_AXI>,
+				 <&stgcrg JH7110_STGCLK_PCIE1_TL>,
+				 <&stgcrg JH7110_STGCLK_PCIE1_AXI_MST0>,
+				 <&stgcrg JH7110_STGCLK_PCIE1_APB>;
+			clock-names = "noc", "tl", "axi_mst0", "apb";
+			resets = <&stgcrg JH7110_STGRST_PCIE1_AXI_MST0>,
+				 <&stgcrg JH7110_STGRST_PCIE1_AXI_SLV0>,
+				 <&stgcrg JH7110_STGRST_PCIE1_AXI_SLV>,
+				 <&stgcrg JH7110_STGRST_PCIE1_BRG>,
+				 <&stgcrg JH7110_STGRST_PCIE1_CORE>,
+				 <&stgcrg JH7110_STGRST_PCIE1_APB>;
+			reset-names = "mst0", "slv0", "slv", "brg",
+				      "core", "apb";
+			status = "disabled";
+
+			pcie_intc1: interrupt-controller {
+				#address-cells = <0>;
+				#interrupt-cells = <1>;
+				interrupt-controller;
+			};
+		};
 	};
 };
-- 
2.17.1


