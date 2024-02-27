Return-Path: <linux-pci+bounces-4110-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD507868E63
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 12:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09E91C20E76
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 11:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A596D139594;
	Tue, 27 Feb 2024 11:09:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2116.outbound.protection.partner.outlook.cn [139.219.17.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE02139566;
	Tue, 27 Feb 2024 11:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709032180; cv=fail; b=muvGYDUrYpZDJann9tJ0izjdaa3x5W8wPi6bILOsWAYDz1EVOyJy6qcPLFPXl8rcBzQs1rHaQpb+ufTiIQPltSErIHTXtM4VLUMc3zn3O42yhtGgyMoXrbSReEUDJegZ/RqHsrnjMwk+O6CGSpNoPSVszDcW4o5kKZOcD4s3FqY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709032180; c=relaxed/simple;
	bh=+XR95O94FvOWrP++2cvScYdRO3BZXTL/7OgAr1OBYVI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pmqSxChxuysXD0socX+tPoBsFVFSCHO8eDWGH3kHLs04xcNAmLyQGTmLmkgijLhBQNg3ysvt9BhNf1bintBCmwH7DLOTNEPRmQ0QyzmF2Itl3DL7jhAzyl1JdZaMMvqBLCUDjGGdrNuJ2907oOsd7L7S5TyOrZCMfsXOyhnxFpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TT4GKAgjdhXv9pb/Pu0cbvSs59aczwh+PcdYN8y+pQBKCW+lVN8SzG6XZRGG9cs6RSLRwVGUtmS8CTYjNDjDq+F+e31rzTlZviCXKOxGOSP04vY0iud+vVQZnWD2x0Jwe/i5cw+H5c1/CJGAf8hd7nZVr1DD2+Vk2Wys7XpM4qCxcJlrtuooq0GtMuUxfcHBZ2teN3MwOhqF+UlthivtIFZoW9TWGIA3fSjJ4FbEb0S7qSkpTj20uXMMXT/UeAMbqRH7gzeRnWYfxnhMilQlEXSWr5uaHhblTVhtYwlCJUzph3M95FpxbcdgAgwe/lL2d7wUYqTTWEr658cPKuFOdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIppChXKdfBPnlczcIvPyd3KB2Im4cgmJK8iWQ76edM=;
 b=cGnbCe87wXpLHrAqXjmml5uLEd5uuWAt8L3Trbnng9AQjCkW3rZjP/P3J4Hl7GtXn+AVlFZGV5shsd9GEV8oYMPZs28e2RJaSoDlmPHBq14e9dErNxOBIwdw6QRthcJo3qmdipoUiCwZKnXe2rznYM2aLr2St6bEclSYTa+IqdqhWDV75fMNLEK6R4kKHJG2gbfCMIG0qJLh53Ljlr+Few9OKmNNRbCNopG1bKg8ky8049eWTeC2wYKSa8KRrHy8jeTsHHTbME+FH1RRwsoyOHW2DYXvPiDx9S4ViLQuJu5mY3JPhgj5XB3XzwH5oRUwe8F/xNtFNXh/qrvjYk9lWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Tue, 27 Feb
 2024 10:35:53 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7270.047; Tue, 27 Feb 2024 10:35:53 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Subject: [PATCH v15,RESEND 23/23] riscv: dts: starfive: add PCIe dts configuration for JH7110
Date: Tue, 27 Feb 2024 18:35:22 +0800
Message-Id: <20240227103522.80915-24-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240227103522.80915-1-minda.chen@starfivetech.com>
References: <20240227103522.80915-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::15) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_
X-MS-Office365-Filtering-Correlation-Id: 259c9233-0771-4d6c-6e18-08dc377fdf83
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BKKmxHvXUGKzE0UUn9rsuZzWzi4np8dIAVuhgthQ9U8ytiUbx5WO2uRghE6zLQ/25IKnaIYWoJ/5jzqvQ293tZK/+qTq8NVVODCap2BMZuWKE3afS+Oa9UHx3ey7nrZ6rjRj2a9uMr1auVDWMXe0p6StrHcBDWj+Y+x+hSJsWGQ7rYSUM29YgbrtWp9XliuZVdSBgz5zw7v7ya6bufTpd4RxlNfPTBVj86rLSOalZXI5njGIIuC6yKIAugoeaS0ZMMlO/7o9LgNLalH5N3jveBhlFFqFfz72dXAgzsX4ujeF2ednhR9oT37M98cqOsDFYs39oobCdvpcqbE9JLG4HCwkt2E/9XCx1LgWpXf4F4vnpKoMrVD2lFIuv0N7q9PJZQpckBnbvFWuKib6bp7/va5yOF7Jc5npAEmKmwezJUuMMV57enSqslX+299nzOmEQc/LmPzwhCqFooxh5yFFBWfdMyZhrzykC2NPtzYoXzoY7ZLb/wM623kbP6ashrIZzUAwZXL7wz+vzwqGAbMtzftysr2offKBVYRpfOqrCUsn5Q5nK6kFdRKED8Hbt5swpCJXqP6wAJOsedSUwh85t8E9MKiSr89sIRlIGYaJNzd7MyCBDAvQzCAmyDXVNRSw
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AGoncGn1Q1pwQFiXydEbCqjGkEexop5pjvBeeSWqcucaB9mwxebmQ/JbfRz/?=
 =?us-ascii?Q?KgOGa+Y2nXdzh0dKAXsqV6cJjG1suivxwyLxJpEfim5NwgbUJo+FlkjYNZW4?=
 =?us-ascii?Q?n1HBHPZFTzNZZTMB1b/GM5egJgbX3v00L3D34D/OOlFonR683ZMLXeTk9TFf?=
 =?us-ascii?Q?4mT6XEA7+TIB1voxFyTtTRXKGGGGDLgACdHfMqupRGy5abCAeHiF2hgXvmde?=
 =?us-ascii?Q?Glwm8OV4gi3Q4fj62ohI9SyYbJYAL397FCF/TtUqH1N+41wWguytQLA5/wuh?=
 =?us-ascii?Q?U38zkv+WQ2ypKkMhhbhaXA26mdWLNgGsudMaTmPuEvivnEskOkDfeB2gkrA7?=
 =?us-ascii?Q?LrdZyYyAZLs0qPevRdizwAFhHVMMu93HonbZxc0RyDp/E01WSU7iXh9Qp/Dg?=
 =?us-ascii?Q?0E9iebwvQHUpGxF2n0RrGZrOc4zXbZ3xeUTdDa6AsuaCtjdJlz6PfZDEd/sh?=
 =?us-ascii?Q?9iwAVH6LKeKOTPl8JrOKFn+jRVtqCj1yZNK5A273PMwrHvYydQAN+gi/d1UO?=
 =?us-ascii?Q?hyjzB/3h0VeHYVfpj/MM3mR9oerP2rfpL0NSP9OscvCZlbvb/az2qO014dzu?=
 =?us-ascii?Q?MdCJW4+uNngxE8ZfTxa2h9NpFwfsO6QU9mJsBSQ1XvloUmNxGtA6CfjwqVHQ?=
 =?us-ascii?Q?8RJX1HvJGvvPz3hP9vBUhRWb+rkt607zHI7wMQRdEmTrR9Os6a0GFiFrH3io?=
 =?us-ascii?Q?LCI+vztWPrTsyDUo6X4B4D1YsT6UbwoIl4Z36JwTIqRCmSeLppfHd7bry42h?=
 =?us-ascii?Q?Uv+pUD+QGgdhfekc8Sjz0Dm/Zmd0hQ2SbfzMTSjymaGjanRMDnBYYb8DkbSj?=
 =?us-ascii?Q?12MM1iI+1jYLXje3s92DcRUVVxS/u01HL9A65HUXnoIeMMT5E+yED3wXClip?=
 =?us-ascii?Q?gDw/UFiKGI/Y1rzOPhrz7temFI2T8x7SnNMhzWwFfe0KGR9mHhi3qJwc4rAi?=
 =?us-ascii?Q?smMgvnrD9Q03I7oLfEYLjPcBDvrgQmfQZ6XSx7R2yuaE8VMX/wzBF1TXmSkS?=
 =?us-ascii?Q?/YumJ/mUhdoe7LC/KOQuyt/OofOShnuXLWIkjnwAlXu9jythp2mSsO3f8qMh?=
 =?us-ascii?Q?Ugzw1C17axkfMy3PkTbypfgkxHy5oRZKl0fmN8MAhS6fC7x2APFZb/e2rMch?=
 =?us-ascii?Q?S5XB7XjO5i8fJ1Yx8gGaY+r5uCVjVMoeIZob7n5SzotYnLTTidK0IuCAVskf?=
 =?us-ascii?Q?bMv5uvRodbv9Qch3vtF2GhjJNxgqq74Um/xQuaJ4K1IleLW8YYde2uphOb9G?=
 =?us-ascii?Q?0JziWl4S88Y7EUY0fUFjSDNAvkeWH9LyIoMPik17nERl+txk+JZy4ieC0IrL?=
 =?us-ascii?Q?wG9EqbVFpMXF6aG1863p8IqN1HnzMSgUrDXTvVCDdfClrkhnJ3dsWaP03A7S?=
 =?us-ascii?Q?vI2ZpX2tu31MisVjiy+vHkiKjHD1iOy0Okp+o0UkRo0cCm5VAT7/tynBh772?=
 =?us-ascii?Q?kkr+N7nnagv4l3tPMSkfuW00Y2ZN3B4Cl7uudeuKoCYOMFJG/vv5ZZJEiP+q?=
 =?us-ascii?Q?WB9Wup/AhnF29lNxiFLsJQpeDSj3g2Mv7dBtPDMuADuRoYTQITjDTk6qphDr?=
 =?us-ascii?Q?pKlIhpW9fAb5J869AXU7dlC+0KhZZP8pNhYqAKi2gFAj2Qm0aZZErFprgXO1?=
 =?us-ascii?Q?Jg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 259c9233-0771-4d6c-6e18-08dc377fdf83
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 10:35:53.1447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UEVTDFhv9XXOev/SwjPpgPd+wCsa+bDSmGLNTI47xT1ijO6Jhsgl9dcM1xpH87phkO6aJ0J6hbScjw4GATCfwvtkMPK28rjngbeJILE3AdQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0863

Add PCIe dts configuraion for JH7110 SoC platform.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Hal Feng <hal.feng@starfivetech.com>
---
 .../jh7110-starfive-visionfive-2.dtsi         | 64 ++++++++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 86 +++++++++++++++++++
 2 files changed, 150 insertions(+)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index b89e9791efa7..ff55a66d7603 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -281,6 +281,22 @@
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
@@ -497,6 +513,54 @@
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
index 74ed3b9264d8..db96214fd443 100644
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


