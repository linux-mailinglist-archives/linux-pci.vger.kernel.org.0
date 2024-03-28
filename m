Return-Path: <linux-pci+bounces-5335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E2888FB32
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 10:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98D1729BFBD
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 09:23:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 677CD81216;
	Thu, 28 Mar 2024 09:19:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2136.outbound.protection.partner.outlook.cn [139.219.146.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414BB8004E;
	Thu, 28 Mar 2024 09:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617560; cv=fail; b=vDisLAbBAdOgOymsGiJwAtprE8LAnkv19fpJmK7UiBaB0B97gk7StCrhICR1zVY5JXRhCQHzh5GlCmMHNG6KBsJbL6wtJpyvTLsXJ8Isz+dMNAqRoeblI9EFE69cpQ2ow76b2FRI/IxLs9I9LEuNC6Hbyh//yeDuOJxcX6ad7MA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617560; c=relaxed/simple;
	bh=ZyD24i8noIBDmnnBmAwavR7YdKQ0KFBFYr4lkj9qpsw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O4LrVbjI1muX/+HafWFPnLCHtukJ+MrrFt5pRewmRFZ/I+rm6NeUNRcsAGDXaXP9XRjflvj3hAiiWOZ020CP1Gthv/rSekYfqM7FU4RAqugcrzccKmI/QJW50O6HYuT7XN5UQ0yIJGdGt5Pce6X6uSIilIT7U5V75bSgNC9CUlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g6ZL1qdptdWnC3bAdep9MEHpCsjda2xSYQXWWFXxvMak/Ht9yVKEeUjWP38CDGg8tYiBW8uZbM4fm57GJFn/mES4YNbUufDWvtky3wZB6ilhffZIEPKjWwixSRWtUJ2Pa+RN+92quL6V3ghoY2fBhSOMjanXlRNnlnl6RKIzdM/2vdjys5OPi70w6TeofopIw1V3DpblFgabOcDCvVfSwfYSeRw+f8ZYWG9Qb1373dv1llrwP7qGaq5uRJGPBF3pg5Nnoy0YlqxjfO59CJjFXkh3i6tf6i2hjM6uQdeLOTf2znE0J/cQ7RXG7ffzv9/N5i8CKjRBSuiTqa9cIQ6A6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8l6vXchax9xswsBoSNeWzV2bcXMCqP+LE45edi0JlmA=;
 b=XcYD6CrXm3d7OofrtImmMXhbGrn+Q7atEPM3LGVjbvpCF9+vWHE3FBjXNg/lvnukF8OY0RuUV1+U0qneBl4v9tpZwn3kk/e60AoE7qQXHoi4e1QlOJlHkjdyI4hnKWgZhiyx7qsGdNDZ8p09P3I8xCuNTM+mBDclFSwdZmClto7hwjQvPJibcVY8vz2IVIKRqSr5XH/qszCD+0AGW5O7iVJq+JNFd40gpMl6ZqpIsUXJ5XJp5dW6TCT4yVlrp2+r1Kr7gF+2S7OzuxgEsQgG5af7IeTGg0fNjr9W1aWN3CyHXVc6yKO12wNh5FdIMBFAryZnFeAaWGHqNHwbA1fH2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0559.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 09:19:06 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::c738:9e6b:f92e:8bb9]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::c738:9e6b:f92e:8bb9%6])
 with mapi id 15.20.7409.031; Thu, 28 Mar 2024 09:19:06 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
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
Subject: [PATCH v16 22/22] riscv: dts: starfive: add PCIe dts configuration for JH7110
Date: Thu, 28 Mar 2024 17:18:35 +0800
Message-Id: <20240328091835.14797-23-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240328091835.14797-1-minda.chen@starfivetech.com>
References: <20240328091835.14797-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0020.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::16) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0559:EE_
X-MS-Office365-Filtering-Correlation-Id: 804246d0-148f-4758-744a-08dc4f081de8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z7fcDM8MOXQTFSBXfR1eFiTPaKLY9WfZK3mmBQKDTG2uaa/WIPkTLpx6lnyqlEEfoeYJf12lOOcMD0PDfD99y2vAsD41uvsRCub6q4C1kgKOQaHgiIcCWAwIponb8xAgQzATIW3iq8x46aRjVpeoCdgSol0SqOSpKRV7Oax/KoT9gz/5Sw+oJjS03kZl34NR/sjupGoKVYzDq89JYSEODEhljm4fevpukhN2el+e+IaGccw2C/P9AEj8gTK7+cOM2mJm92BfSiF5aoDem/lLgJRjIZaX7A+4hIIPA0RoiCjatjQDq1OlaHaUHv7vLASO877NG+WxWTOI/s+So0eT7MJH25loSZGG4ik2HVnHqeHYhz1Wltr3YW6VM+dWwu/1JP4e/K+cMkS55PGNaXxVbuMhN6Ih4DKkqU+2aJF6vIoVkf+TQ9CLQpiHeMswL04Z+Lldyii+nrllz4v+5RpVlCTgDSlXW2TbTq46fsHATNb6tQ1yyAI+QVSw/43KyyOBpYtCSCicEc6CnBJhNzZEC9ZMP3fDK65RQIbS0yS1642nUGqXbA3/QYzmzMWJizgd3vc/Wcfq+c8R2QfP9hstmZ29V3cjSrmvL70iCPFJI20MWTmO87vv4jwVH1UftZWW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0y8kVUYWIgVZqWuLZZfcg9Gb4KHOagVGqFacR0BvCU68aVdxHf6FJaXAowt/?=
 =?us-ascii?Q?E3rKjkURlErmRZ94lMSnSydAHlbi6f6aQrOvI3m+kKvnVqqnQd3EN/nfUHdT?=
 =?us-ascii?Q?GCTWqwN4CAyEPMd3/0Lgch1PIz9JDD1VJOS8HaBtNFYxhiyza4qOy3Kmtswd?=
 =?us-ascii?Q?pv/gFnFQE9Fl++tMlw+D76+7ZDK+YF9acHgq/yURUJm/HTa87Seqpfuqrt3u?=
 =?us-ascii?Q?g5WN8alfutSrlLQRWT8CI0qd47mwb2uPnE4+2SsmIc9vNYyx/xWKyKXWs5Id?=
 =?us-ascii?Q?z3Ecknj8NFTtuo+h+aDKHBmpXYZX/HXLq2ieMEQa2HbZVkIZHmRQM2wuCR7t?=
 =?us-ascii?Q?MEp/E+50xerpDdKtIm2rtm+tQ3S1jB6dbSo0uqO0zPIp1c76wFc0p4ewUH89?=
 =?us-ascii?Q?pyndHeHP2kC3YkL/InyM3moPahAb+UtOv7olicKeOd1EXxVcgBeL/HUtlVaa?=
 =?us-ascii?Q?OE0g7LECoEW4hhvbTm1gymFIIMvuIwbPvzFYDXQ6rGSuPAAAUJpcnoGs9P71?=
 =?us-ascii?Q?aGZg1kbpRUjuc6LgFLraL7mIbEK52vdtAXrABiDzHIiq5gk5iOyEWVD9zMux?=
 =?us-ascii?Q?LWLutLZ5frPXfX2iITFCMi6tAAEsaTq2oa6tD5ICMYTiZfGbrMrJ/2HWLXOc?=
 =?us-ascii?Q?9i4s8WahoLsfgD0tBe/QSsDGVrxegWEASvqldEPI+l6WWZ5QX99E9IYxV/qI?=
 =?us-ascii?Q?BJV0e30qaj4bLWIo8xE7jcGD2adhP5MYYIXePUpKiPQVYHE/BtJ5VIcqvQ9r?=
 =?us-ascii?Q?1/zbe+tghOoGxT3DGHgpJQ7QdIcMvBX3xxQN/Rj7ySIvUAv3SDjp9DogNZol?=
 =?us-ascii?Q?sj0HuR3M8fwWYMLQrpW3BpQCZwa1/sOQ8VMZ7AnaNSouF7bA+jpPif0R6hta?=
 =?us-ascii?Q?i+Ui5KIu011+AZe37/EPE4w5yF9QMYF3pEQwMYBNPTT7yWn0uRd5dp1ZS8Tt?=
 =?us-ascii?Q?6DQhaeI6IrAnPwx3yPYnkxWqSam9NYR0hi0pY33p+euLZljUIJczMFAHDhXU?=
 =?us-ascii?Q?Ohs86vWCVRT6KHN3lIVg2BBGOuU4wY/e3lsrzybnMW3r/s+7loPU5iJMOL2j?=
 =?us-ascii?Q?FZcuZ3jKF1/vJYJ7SyBp/3S0A5Q9r8zHVRfoVMBpLFa7UClSGiLg/LRfGVd7?=
 =?us-ascii?Q?RUTZPQQTrXG1d98XqxvCIsveRKOPAGlhcZKAFHbZmn8GKAuP92hiMSMUoxVe?=
 =?us-ascii?Q?b3NGQwvs4o6rZWes22P6ykx+nXZX8mHElct5o/x8GGEWWoksNo9uELefcNvK?=
 =?us-ascii?Q?p00z0gHMPx2YCPlIkPIgFUjHXaeS8okA0k9ws6Sdnq2Chv154U2qH6qvTRtY?=
 =?us-ascii?Q?6bVKM4H6oLwg7j+YL7FPy0a1xZ0Y8YbmpcxbR5DQvClz2i+Fk8pINDJtbRnC?=
 =?us-ascii?Q?GnTEmPlI8cD2g2dt6IxzGzzIzI9m4dpXDxLRc4oUNZX80i4+gTH/3yJdyQrN?=
 =?us-ascii?Q?JqIAG5HijdL3DVYhNikPQ2wVgGzgSppCAT34OMcAlYfCYbJMKwWnixxrXXOm?=
 =?us-ascii?Q?PHNW6LnbsP/+GR8vpO7lSWsdEetgNLQF9Ul22KcaKuJZnGns2rLJrGT62rJM?=
 =?us-ascii?Q?oQja4VooPS79uSkj4JemWPfPUWzTXO0rqVD86DJKprbKZkK91EUZUbK0/s8N?=
 =?us-ascii?Q?kg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 804246d0-148f-4758-744a-08dc4f081de8
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:19:06.0941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YVAdtL2ONi/JmZ17M0+SgRiy+kO2KgwMaKQdcqdxT6OQeP0oLG6BEB/LjWGKUAsKa0eRYcrHmfSl3CRP5p1DQrNeB3bvt6x0Mf47UfRHs6Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0559

Add PCIe dts configuraion for JH7110 SoC platform.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 .../jh7110-starfive-visionfive-2.dtsi         | 64 ++++++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 86 +++++++++++++++++++
 2 files changed, 150 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index 45b58b6f3df8..de95e330a93c 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -330,6 +330,22 @@
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
 &pwmdac {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pwmdac_pins>;
@@ -552,6 +568,54 @@
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
 	pwmdac_pins: pwmdac-0 {
 		pwmdac-pins {
 			pinmux = <GPIOMUX(33, GPOUT_SYS_PWMDAC_LEFT,
diff --git a/arch/riscv/boot/dts/starfive/jh7110.dtsi b/arch/riscv/boot/dts/starfive/jh7110.dtsi
index 4a5708f7fcf7..f906b1ec8518 100644
--- a/arch/riscv/boot/dts/starfive/jh7110.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110.dtsi
@@ -1214,5 +1214,91 @@
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


