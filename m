Return-Path: <linux-pci+bounces-42030-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D393FC84F6E
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 13:29:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1705334F0FB
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 12:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6919B2DE6E3;
	Tue, 25 Nov 2025 12:29:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2138.outbound.protection.partner.outlook.cn [139.219.17.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BEF283124;
	Tue, 25 Nov 2025 12:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764073758; cv=fail; b=QlnCKo2hYQ1hQQZ6aIg+yMXFaQZT6zEQLgB6t3+59r3mcO0QN/98KQmmH39qnE9bX/sff5CunmE4rR3Z7B0O5lfro28I+i5hXs8osfIYsKHIfLKs3TwGPLKSCxBNWaVQxyuz3M5AcIMYxV0BHST3mt/TQBtaYGovCCpRIEtz1eU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764073758; c=relaxed/simple;
	bh=S6/wJNtNT22BH4Jc8jgD8w+ZyccOutb0z6FicC+eDIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CSo5c+LPHnwqx46N3xnisVhKoKDwR0azCSp7H4lOZD/wLgvgI2hHotM8leabkjDFtOW6aF3/mefGgm6ja/qko+dRekvNQqil8G6OYO+igXEsRxy6A4fXFSBJ38jw5aSao9RW62MQg+ldZtDlL7j/Tq2VZJrfrW5kQ/kk76FMwz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+fRmINZttxRQJaAEiHLkk/mM0B/j9ptPgLrsfkKZODyCsunz3Wra5r1e56DXaWvfmmGOeDPCUL3nrSjQycws/eudyu4hn2AA8ly5o90ZLVGtk8PcL2DhDPN8Gni5NKAlOheblNhbwAdL106ADp80Gqembi6wSJFoylK/NT9H9XaqB6v47Wl6/wc7YYuaCEVxLfeuL+TqVKuNlY3gtZTW1B8wO25YucTTTLlCXxa/sIfXHvq6R35+sM7qYjwTm+NIaOL5jGS5fIKx0A3sDj8rS+H9uUYn77Qg/Vm2akCtNge24NX75oF8OGjO5kp+k26o2e9j4sP89Ci1Dq3tLwrCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDOC+IO6InnVUf1B3LeN2PyenypplnAkg+5vzYqa2Ew=;
 b=KslqGGkcvDztYxOhbBcRnZseHh2VTlBWg98v4Dj7MKGR6eXbfaENKDefd+ZLRPIMQDYLVKRdueHcJx0WbLqm5b8TrKJR3B5plqJOy5lSKl/g8G6Q0oOADjtyXhnU+r9+ZjjgTV20YabsoPjrVqFKaOaLE8D284bWEAW+wbcTmOWieC4Cb6oy8MpD57/Vfqhb60OCrCeu04x/7hWf9yqS+iasIhoHPG4A6hXsudma+ZcIYArCOhXB49v9MtYi4cAhSXvzIRHGRhgxyWos3/DsP1m7Q2z/3rchvRL+nIPsO4WUPTmK9pZujr4O006CXzC5bC/kCweJf6rBD1VQ+4LLEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1241.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Tue, 25 Nov
 2025 07:56:18 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9320.024; Tue, 25 Nov 2025
 07:56:18 +0000
From: Hal Feng <hal.feng@starfivetech.com>
To: Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <pjw@kernel.org>,
	Albert Ou <aou@eecs.berkeley.edu>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
	E Shattow <e@freeshell.de>
Cc: Hal Feng <hal.feng@starfivetech.com>,
	devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/6] riscv: dts: starfive: Add common board dtsi for VisionFive 2 Lite variants
Date: Tue, 25 Nov 2025 15:56:02 +0800
Message-ID: <20251125075604.69370-5-hal.feng@starfivetech.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20251125075604.69370-1-hal.feng@starfivetech.com>
References: <20251125075604.69370-1-hal.feng@starfivetech.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0018.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::30) To ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZQ2PR01MB1307:EE_|ZQ2PR01MB1241:EE_
X-MS-Office365-Filtering-Correlation-Id: 15f678c9-7401-4f7b-a23f-08de2bf81dbb
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|41320700013|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	7ptlm/Nz9ghBEx4ai591WCokyl8LbYcZz1kKB7jMGITtiKWAByj3w13juGXSgBy52X0ks1s1JZG0AiVmJx34dyxiMCo40sjETHD5vg2FanpHkU4tVO6turcQt6rlN74wSWaQDn6iNvAQl3WaqO0Pf2b49A2DF9FMRyQLtEPeu0rqmGXyY/14eqKsaKo2FO1nHHWmKqHP+adcwoaJD/IVIunkHPTEYl1UJLLI0yJfP71TGE79oNkMMMYnSrZvqFd/BcEouRkJd+f6kl+rsl234Y9RgEGbcycFLjA2PHKmZ99Ulupit2bRBOwMPGjmr7GVfc7fDn8ruIh4UQAPA/gWBRt/ozLoaf53Y4iLp5zN/aKTQ+ZgISh4uzQf0LsnvzlVXZdF7w8GFLgiljg8mgq+mp3udUYayrx+gYwuQrjdP1fqhRasbrHQPY64RNXQNEuTWDruaw/yOEPZS+UlVojKG2mZ+ua9Bba2NGe0Bx3i9v6yh9RiRMLM7WWfoILpU/aeojOCQyrvvhUQYOgDdnvzO/liBcTQTW2kCwwfMnQJNOB3A4KcqXB+ZHvwRKFQVpjrvpdPoifYYbl/5LGjjz7E/v1RpKM3TcNrHD7gqdt9l+U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(41320700013)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?u6AtdLEWm77xJrJI1HUTQPhwXfWes8Y0lM8gOg/FbD6dGhxEIQGz7h09skmp?=
 =?us-ascii?Q?uluCeFH3B32QUTEl74NbC3qOLr4qhihr258Wovi63aB9K5vmczn8XiO7kAyV?=
 =?us-ascii?Q?Xz2yvTNxqhDASfrDKP+unfGSGqxJVJ91nb+W2Ia5SNYbu1Z2dzV1p1XHLlRG?=
 =?us-ascii?Q?WS3dwYkkH6hVe4TyDGs8cAKI285XsWkfzCocuoeiGqoXQwSrg2wk4qsF0j+X?=
 =?us-ascii?Q?4YIwu3kTDItO8iakElU8ujXFEaEmEcwoC6730yA8IirIbCzXPHvg8WZlQet2?=
 =?us-ascii?Q?TLBjmeEK1c5uODKxIgpPru52WrwVGQpSvptp6OHPzplhifni2qsFcbgw9FSD?=
 =?us-ascii?Q?MbLFvENerb7LlIYUFNK9Ou3387CcvfMeeT/EKObcGX/XDLnLe0yUuzII0Rs5?=
 =?us-ascii?Q?TKivG7hTxBYwV1D2VnUW5DcEuO/Y+t1FesF1FMjIo0dR57EwJFVJUqN0hIK7?=
 =?us-ascii?Q?r3/iHFMr44xTQLN8Bzt8ypPUTZRUKgB+8corBnKok4DBZzuUAAmpYpQjEKmi?=
 =?us-ascii?Q?BhDTWZIT9oPbCAc1wvGhfoTIPl7gDoKRzsrpnsxXZxn+zKYWwGm2A3KxaHOq?=
 =?us-ascii?Q?RZyxGPsS02+l0Xjbi8ucmTiheU48Kum54KPIC+fauB/vwnNJCK86y2pNVDrw?=
 =?us-ascii?Q?NmVCCqoqKreifGg4WhCTQSc5HExs5/sjzeiau2Gqvu+RXEHndXN32U355nEt?=
 =?us-ascii?Q?NXXsFKH1vJwFkMgepmOc8/MCRP1ptXXV3aRd/UiyYG+Hk1HwWE7m/2gilJRP?=
 =?us-ascii?Q?yiUU5MPoS4FmDifM/uq1Yyj0Q2x1I0/usSA89JJTH8rGbwdG7XdYe8h/gK3G?=
 =?us-ascii?Q?+hpiPSlJM1IdIBqj7rktPn7NYX5vZ/CG6Pnx378sNgbPkciHdgNaDQiNLY6O?=
 =?us-ascii?Q?YzbjYWqOfh5mDUik2gphO0sIuarfyTqNFug+BHOLpfzx7VT/fec1TttDghz2?=
 =?us-ascii?Q?QOQw5VujX0BhEuhDE6gnnU30lD91MDTs+HDY8cHXsFxMZSQtWRZkn9MC5lra?=
 =?us-ascii?Q?MzUoKRIdNyd4aTo7vMSYNwk0g+fg9pYG0OPE5KkUxSNfm1xziCFXccuEPFZ6?=
 =?us-ascii?Q?S6mDSr0P92h3fwkTVVAAlvLwcCy4C7604RT/qyJvY3r5yxqSDlMRJnbGRX3g?=
 =?us-ascii?Q?r09W04eN6kkGD6sMm0/In8VmRY0uQUy/rFcsDHuRUdglxS+jsgJMJYyotEfu?=
 =?us-ascii?Q?CCMztG1i6en6LE3ojlH5aXtIyUjQHp6NA5RDThAyy9NSkkyI4byB+gE3tJoL?=
 =?us-ascii?Q?Y9cjINbVq99bIwLA+ZxX+F/QSQ5yATIFVxkzcLeAtwYkhl23gLopct+DvtYo?=
 =?us-ascii?Q?jWmMD2X8SU9dpgcofVDiaCfYiHvK0PLZv5XXjkKFxjJ3T+ZJDGZN7kBayhHw?=
 =?us-ascii?Q?396L7LiZbJOqAyL0WR6aHw7ZcA08GnrFBws1DRpVwT9vTNO9YY6UDti4+2MS?=
 =?us-ascii?Q?VDaz86jdKvVQVHCLDH5VOXmc7xwyRAzjsm7QrQI1S5aOdI2QFgAdV6e3TFXT?=
 =?us-ascii?Q?BSDFv0EjyihxPQsFthnFrGGv9NpSDOCqS/DZgRv6sxsN9KH2PtK2giEwjYyC?=
 =?us-ascii?Q?xqab0n3xpw4GIGLs6xTIF8zTELE9rfUyYqffS0o9NRocBRKxBg1OWovaJiPi?=
 =?us-ascii?Q?QA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15f678c9-7401-4f7b-a23f-08de2bf81dbb
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 07:56:18.4928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYuEBxrHS4NFMkZZpZ3o2f8D4eiWlCLOeM2Wq6v3Kf4S2hAFX9+b7e3kZw5A9ABooaDjWF52rJfQAGWHFT+duhJtUMcOt+M9qCTYVnumxmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1241

Add a common board dtsi for use by VisionFive 2 Lite and
VisionFive 2 Lite eMMC.

Acked-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Tested-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../jh7110-starfive-visionfive-2-lite.dtsi    | 161 ++++++++++++++++++
 1 file changed, 161 insertions(+)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dtsi

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dtsi
new file mode 100644
index 000000000000..f8797a666dbf
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dtsi
@@ -0,0 +1,161 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2025 StarFive Technology Co., Ltd.
+ * Copyright (C) 2025 Hal Feng <hal.feng@starfivetech.com>
+ */
+
+/dts-v1/;
+#include "jh7110-common.dtsi"
+
+/ {
+	vcc_3v3_pcie: regulator-vcc-3v3-pcie {
+		compatible = "regulator-fixed";
+		enable-active-high;
+		gpio = <&sysgpio 27 GPIO_ACTIVE_HIGH>;
+		regulator-name = "vcc_3v3_pcie";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+};
+
+&cpu_opp {
+	/delete-node/ opp-375000000;
+	/delete-node/ opp-500000000;
+	/delete-node/ opp-750000000;
+	/delete-node/ opp-1500000000;
+
+	opp-312500000 {
+		opp-hz = /bits/ 64 <312500000>;
+		opp-microvolt = <800000>;
+	};
+	opp-417000000 {
+		opp-hz = /bits/ 64 <417000000>;
+		opp-microvolt = <800000>;
+	};
+	opp-625000000 {
+		opp-hz = /bits/ 64 <625000000>;
+		opp-microvolt = <800000>;
+	};
+	opp-1250000000 {
+		opp-hz = /bits/ 64 <1250000000>;
+		opp-microvolt = <1000000>;
+	};
+};
+
+&gmac0 {
+	starfive,tx-use-rgmii-clk;
+	assigned-clocks = <&aoncrg JH7110_AONCLK_GMAC0_TX>;
+	assigned-clock-parents = <&aoncrg JH7110_AONCLK_GMAC0_RMII_RTX>;
+	status = "okay";
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&mmc1 {
+	max-frequency = <50000000>;
+	keep-power-in-suspend;
+	non-removable;
+};
+
+&pcie1 {
+	vpcie3v3-supply = <&vcc_3v3_pcie>;
+	status = "okay";
+};
+
+&phy0 {
+	motorcomm,tx-clk-adj-enabled;
+	motorcomm,tx-clk-100-inverted;
+	motorcomm,tx-clk-1000-inverted;
+	motorcomm,rx-clk-drv-microamp = <3970>;
+	motorcomm,rx-data-drv-microamp = <2910>;
+	rx-internal-delay-ps = <1500>;
+	tx-internal-delay-ps = <1500>;
+};
+
+&pwm {
+	status = "okay";
+};
+
+&spi0 {
+	status = "okay";
+};
+
+&syscrg {
+	assigned-clock-rates = <0>, <0>, <0>, <0>, <500000000>, <1250000000>;
+};
+
+&sysgpio {
+	uart1_pins: uart1-0 {
+		tx-pins {
+			pinmux = <GPIOMUX(22, GPOUT_SYS_UART1_TX,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			bias-disable;
+			drive-strength = <12>;
+			input-disable;
+			input-schmitt-disable;
+			slew-rate = <0>;
+		};
+
+		rx-pins {
+			pinmux = <GPIOMUX(23, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_SYS_UART1_RX)>;
+			bias-pull-up;
+			drive-strength = <2>;
+			input-enable;
+			input-schmitt-enable;
+			slew-rate = <0>;
+		};
+
+		cts-pins {
+			pinmux = <GPIOMUX(24, GPOUT_LOW,
+					      GPOEN_DISABLE,
+					      GPI_SYS_UART1_CTS)>;
+			input-enable;
+		};
+
+		rts-pins {
+			pinmux = <GPIOMUX(25, GPOUT_SYS_UART1_RTS,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			input-enable;
+		};
+	};
+
+	usb0_pins: usb0-0 {
+		power-pins {
+			pinmux = <GPIOMUX(26, GPOUT_HIGH,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			input-disable;
+		};
+
+		switch-pins {
+			pinmux = <GPIOMUX(62, GPOUT_LOW,
+					      GPOEN_ENABLE,
+					      GPI_NONE)>;
+			input-disable;
+		};
+	};
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+	status = "okay";
+};
+
+&usb0 {
+	dr_mode = "host";
+	pinctrl-names = "default";
+	pinctrl-0 = <&usb0_pins>;
+	status = "okay";
+};
+
+&usb_cdns3 {
+	phys = <&usbphy0>, <&pciephy0>;
+	phy-names = "cdns3,usb2-phy", "cdns3,usb3-phy";
+};
-- 
2.43.2


