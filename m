Return-Path: <linux-pci+bounces-3686-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1BE0859677
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 11:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BD721C20A19
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 10:54:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C24184F;
	Sun, 18 Feb 2024 10:54:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2106.outbound.protection.partner.outlook.cn [139.219.17.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139B14F1F9;
	Sun, 18 Feb 2024 10:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708253640; cv=fail; b=iJYPermGlrEu+/yGYV6ElSBJvZS2+/ACObPU1KVa+xIjC/BN+aWiDWjazwACes1nUUrg+8wNXwg64aCUDBdJNpA1XU1XVAoIDaroRf2zE0+TM1PpwCKQU8DSqy5sXGD6aRf/VR5vPod/T77b4q3eTRTEwEu2dVUqKhJY+/yYArY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708253640; c=relaxed/simple;
	bh=S2lDL0gD7pPak+dReXlI6JFdBr+tBRJUw89XXRjBFG4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ODm/JKt0CUmv3XiBcdJcP+yBxGW86fHUuB0XuC160kmIjTrlMoUGjEXgQ8oxogeJ0rdr6+MEFarMeUbqHQKWdxyEaXsz/5B3MVQFhdycRjY7Bvu9abyKw4+rxHaRBNA8zh/mHtNNHyLaaIa60qKcgefTVFfecFmmNKTxeT1A+w0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lznK5zPla0ZKQ12N58BbgApBsMrrW0MCAHyKgJ0wn0sQ75v2/FTLN28Rz8x1iX3wbTADJQTM9aYdhcwe5vK0lEHG+hfpZn12Ew32GClc+hKzWXHAYaVPRxsrx6oyPPgkhHesUEK3FxaqAYRkh4xf2OLVR2zQO6h7J7OAdBx8xpsZWuEHK7Ji/gb3JRWybk5VKasq2/ytcrB8Z2EGB+VC4DbLeLVHRgmZDA56IjXStc3N4qw5Ef4Fy6e+63orDjOLzD8nd1FTSFKlfho7Lvjk81xVvrikSAo8BeW9LZ+upcku77MrFTR8eqFfHXlLtKhUqXlIKb87RkpxK9UMTmO27g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nIXi8JBQnxVNAlvrZCPiLc7iuf6UII3Un7BOHkCInrQ=;
 b=GYNYAZrLB+dBrXkhLWB1l3/THGdK2+KMIfI30niLbJ8yz35+g/F6RS8xj68C/5d2JPsXwqRSf2ZKbergKCUQ4/J/IgKtpOFkFTvUai36m1rdEop27JSIqIk/obb+bcKnqHRhpeFxZYAG8WDW1exQHYiCQ3H7YGM7h43MfPELKEPOQGk8I7HJzm+8xB7mebDN6gDaZeRY0/Pf6GsI1wCGvrU5sSCO4zp36u6DXNxo9Y7ZlMOF9rdcbjxtUGutfgGdAUkp9Yk5X515dqLPZjOy7EsMlo7XqrqC4JEzWQ33I9/Q6TjAF8aBbwOkJ2YNejV07lYXScPR39NOj3mSR1Gp7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0464.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.50; Sun, 18 Feb
 2024 10:19:36 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7249.051; Sun, 18 Feb 2024 10:19:36 +0000
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
Subject: [PATCH v15 23/23] riscv: dts: starfive: add PCIe dts configuration for JH7110
Date: Sun, 18 Feb 2024 18:19:21 +0800
Message-Id: <20240218101921.113528-8-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240218101921.113528-1-minda.chen@starfivetech.com>
References: <20240218101921.113528-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0010.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::21) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0464:EE_
X-MS-Office365-Filtering-Correlation-Id: 0558dd7e-d6ab-4cc9-6da0-08dc306b1baa
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MOAQkIELSbAMHGT0owiz/gK9IKtDDZAPN7J8/H73JaAg3ijSubEWdlg6lV9pgSc7iPt4Dl1dwdfz43fY8WSVIlDhRyAJWmoMJEdTzX2tMHmTZczlJ/NifvG6QBxTmD9LiAFSO41L1WAgfj1e2cmhOaRK/XXSG6nSi6cRE6omX3/+PPgwkZoZOzzmCCyKOtQuRK6WNwVfTKR1rNnR2CU3EAIx4eBuEvU2GLZN0UKyrvKwO1/93eJ3M2rkniHwg5rJAtWOHplvs18rOBvMYhZ1GyJG1hMqOITLvQt0m/2LIkbAOjPE3Vvr1FMfyymk9vtdx+dwGTAeg/oMcTbzbKdKZDcmNTWrDVZLmgFnkVNR4GEyTSnKETzazGMF+bLN+NRuPKT+IPCe+LPCwnWeHs2bKh3sUZJSyV4NhA6gOl6mpfbdVO5AbJPReTMwQr9C5YbNdqSpfH5uYJamvYhU+7yfOiNy88POzzwEMxj4YwemuffrL2tX+jcwJaXT483xiFBmZSN6jFb3EGH7baafndmLJwLLdKwIGxmeSkrHw84NQmbYYYFxsicpuTKFogeSBVdR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(346002)(136003)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(86362001)(83380400001)(40180700001)(40160700002)(38100700002)(36756003)(5660300002)(41320700001)(38350700005)(7416002)(2906002)(66946007)(4326008)(44832011)(54906003)(66476007)(41300700001)(8936002)(66556008)(8676002)(6666004)(52116002)(26005)(508600001)(110136005)(1076003)(107886003)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HR2TBmIz3ksq6Xpzb3etWIVfnIrrAEDrRnG67+w4E7MuO3QkEHFcaUOh6Wiw?=
 =?us-ascii?Q?ZW1SJCLmYkX/nJRRrodKagI6UnebcFtGuFIqP0vDmoQuVOQK/lRb9F2YtJV6?=
 =?us-ascii?Q?CY9FGorSlcKNE3i60dIDhoU+jMs4gaAyTrbKA/s7KnuMgJW3W5i3HK/cxQoQ?=
 =?us-ascii?Q?yPRiU8Ymg6MZgE+GFCXUauXKexf6thWOlrgHmf/zjPMqAiE6C+aEy8sJbkbE?=
 =?us-ascii?Q?PuPponsoZLW+fscHRZbosqf/H7bWXlFLbYFlL7bb4Z8YQEKbj5RExTHwZRtx?=
 =?us-ascii?Q?mSMo8ydQPElmX1UeChG2l6hc+RybLtuwjLvXEMJpG+MSY9JaadBuF76TVkQ0?=
 =?us-ascii?Q?Rd5UJ6VFxPBDKOe79N24kWJ8NzhoeMpcat+zZzabajhg+6t1MMUShoXcS70d?=
 =?us-ascii?Q?49a16tSVA4Udg+21bm7g86Z8LT7xrIUJftPvBkr72A6SRO5iKVabTOgzXlnf?=
 =?us-ascii?Q?9Vw9RXiZkJ38/JQ9xLZpdkxW44tL+G/EEGjwDFSWdMakmOcMFpOY0ze7Fsa4?=
 =?us-ascii?Q?VuxIS/izgDyXyiIgF0X2eIqQR59hFCI0+Tce+p+eyJtBBT94rwUwuvPqaSYw?=
 =?us-ascii?Q?3GAPrd86eY7YFDVyqFvaOG9BUeUWaAIcaOyQI7itA6luDrWrYDr46INbFPhJ?=
 =?us-ascii?Q?0PVxqZjy2hWR205cUcHPZsYgKhROohG1ZnFts0CwpUWachtJzhQ/DXbBeGC2?=
 =?us-ascii?Q?HkvLY5igWPubgR4kb0hAWtLxrugZ47UvHS/VM+K4fjjf8VgqvaSDCsBNlCOp?=
 =?us-ascii?Q?6PeFW10hh55KrQ2oqeU7nkyX0YoP2d6Dd6wo/Md9JRmiIHPAt2Tmt4OQUAS1?=
 =?us-ascii?Q?1LtfnFNkxXJRTTKZ1y5kVC3n82CUoAjXnUlhly3e5oHAmwBJy2iQk3KI/ike?=
 =?us-ascii?Q?Ml0LPUkWooSGWe7G2F6CtsKlMQBsMpGrm7kGIC2680Ot6anwXqgpym80HDBs?=
 =?us-ascii?Q?2MFEOKAc7WMDpll4yPOZcbKbMRt1UzoESuAKw2gckWRl8YOLfxRr6nlNoD8p?=
 =?us-ascii?Q?nwoHSxBqFQsIqW0BlCxoA8oZxq5judbNcM4hGfkFLPVYHhYSvcrttzHrxrMR?=
 =?us-ascii?Q?+sDQmqY/qv+vo2V3EzANnnmtdvp/CivRyLYw9i1QZuM9IlOgU65JO6UiJ4ep?=
 =?us-ascii?Q?tAsWx0cp6rZZljBxJh16ZoMZR32J588/GbbFxLMdKkMLO6BN8hx3IWHWdCDd?=
 =?us-ascii?Q?g3q2Jf+AdQyrbk5FrIXIKeIXUHvwpOkZ6AaxYEIltG71pMhaUDUo8L8nTwiz?=
 =?us-ascii?Q?3Q9lVxvloNgcp8VE/Giykq96zp0Y4FV3EqBGBjxKVjt2KdalcCqInShZUvei?=
 =?us-ascii?Q?hVvGJtX0bHhwwNdjHPY3bvDTfLEEE5tDQkGp/gsX8+9G1FtA1hW1/rbTuBsC?=
 =?us-ascii?Q?uY863dVwu0ZzaVYug3NJS+hlq0o1tKpoeg12ibx+BjvY1+FFFRTTB1jZJiSA?=
 =?us-ascii?Q?cWNAp2WXA+krniar+c9M/UrA/CfIVzQW3Za7+Jk2tD5/spcBAd0IM8A0Jebt?=
 =?us-ascii?Q?52VbNaj97gY5IAT4HoEB4QtwLdg54SA6kEd+Bf/PAj637zwNuSS1yEFEJpNM?=
 =?us-ascii?Q?HkfWo4fhxNGhcrrIouyDPYua9EVSHA8FASrEg1txa9pEqjipr+p2xC91iFSU?=
 =?us-ascii?Q?1w=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0558dd7e-d6ab-4cc9-6da0-08dc306b1baa
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 10:19:36.4495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KsW73v2vWNgeoR1QaMnWRpzzJ+626+HK9+InQ5NcW9enDD+QO1u7MSXll9nabcwpZk7fLDjhvnFU1os75EaPskKQqqemxtFVfsIAsTSmN/Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0464

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


