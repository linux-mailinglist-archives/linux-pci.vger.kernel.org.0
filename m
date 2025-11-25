Return-Path: <linux-pci+bounces-42019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81582C83D69
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 08:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C613B0948
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 07:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094F22FD1D9;
	Tue, 25 Nov 2025 07:56:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2096.outbound.protection.partner.outlook.cn [139.219.17.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E122FC891;
	Tue, 25 Nov 2025 07:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057396; cv=fail; b=LXaF9u9h0rasgBO5E3opXSWxtecdSDtaC4gpB29IQFBlCwT1dEQIBlH8TL1TmMtxMDlXf986kGHDU0ch1aH1dqqhLtXhFhU2NvoWvTRNEFJ9e1E9K1rsQS4uOeKEtlZ7iah4PMS3nx1hjSkeDsWBSZveiHJPtLspX+Jb8XOkBaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057396; c=relaxed/simple;
	bh=bf0NhErlj6iUsXgxcym6u/2907F9t0viesuBgEQJLrA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qieuGcZR0NoyFqTqcrXcNWmQFam8KH/MHZq+sb/BhV3v8NpAxOCRhwUe4DkqBxSHEB68tYA1SuR1jLpIqScMto3gDErzO9Kmz0nYpWGgGD2IJqf3M0mMWRuRTHLPiDyDkLS95JcHHh3ISUdgydneVGjcd6VckLEx/tmALwC0sMI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N5vpb8gTg0A2kt/M1nMQARI1UhB5lj2dyG/ZTpq2ZE44tmqcMCqOWheteVzZ+Jw0QFMe6mPhRM1jnDmaxLUqyxDn/fy5W7u0DaerR2JeuxMg2tV2NBaugU4l73cc/FMf+xILED0+I3Nik4kKmn1SsJz4DoZWgLQRzwtSjY1yFX/9ro+Gvv3nUe+UOZl/WqAUP/NcWxHCtvzQ26alP0SOuyTieWhzUV6kme7pA/ZYwqIFoaZHUwtLTY+IMAMLz3/ACZY36gcrsYeQ9P7MTtwYtU2HJePL0vLiZx4laYsYiXsqkvomed9poXnUGJ22CXhLw+ZXrvQoI13+dNntQLcuBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xc0Cp+iC+KYbYxUDyFyNZfX+6k7hsYUWxS55hV1+4iY=;
 b=g7M6wRy7lhtj2oTnTRkk5Uxnyfth6+zw6QoQvyfPf+7f856JyHGXfFzqhFbropkm6QNtnxsMTEF9NlJireAbK4COeVNX5pCk66ADpljV16JV7Iy1L5Nrb0ZEH0qe3JVdoVmJhwztwDz2xjipuftE2TwMuhTb81f7L4b0ZT1TYkbhFCS04gMuVxz96YpgqWMBA/C3Yk7ZpMBShz6qkqsqW96foIFEvJQQlIffsv0vdzNp9KPfg4zx4eu9LP+TOR76IQgd5KP/6oN3CJrmgV4Nvnnvz8Sb0Gikn2H2BHtzwHSfdnZmXupGOcTaf+RxOH2O2deMvm6DTUcq0pRejIXBdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1241.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Tue, 25 Nov
 2025 07:56:17 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9320.024; Tue, 25 Nov 2025
 07:56:17 +0000
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
Subject: [PATCH v4 3/6] riscv: dts: starfive: jh7110-common: Move out some nodes to the board dts
Date: Tue, 25 Nov 2025 15:56:01 +0800
Message-ID: <20251125075604.69370-4-hal.feng@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: b6891eb4-524d-44af-c0ff-08de2bf81cd5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|41320700013|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	zi/2eDDPyl2JIaFyWAtAhf2B9XWAOKSHZurZVCG4qVInnSOn3k8K6Bw3vC3qk+5zC+xs7nJCBFeiimjd6JHddW9tuYrwiCnlwBduoMrtdt371vQmC34sMzTVL9MfEo+Kk4Q31z1wYQKgU+aS/rAy4+JZG1/uRRyxMXmQfl69gCA0xp5Djjc2cV4ss0K80lXeV1sUQ+M+kOWLdICsK8Hi6EGFNUe0bLKUaMP7eG3pDBvEbEYHM7uoiCfmhZS0V1rBQy7by1lS8OUojCgYPlwhy88cUJ9DcsvZ2fxH1W3obxWDCc0XCOTWiRFbwFBY7VBO+0Xcu3d5QH62Y3nUika9n2xhOYUVeQKtz1lsaMTxdJDM37y8rM0+C0EP4cdi86EYk8vNNwA6myBy4rMGv5VjqWqL0bcRW1o48N4axGj9H+cm+fYe7KUJz6RwGoRcq1Vw4tQ0psVePbiqoXQ91iHN4zEk2BYMT5M7jo9c2cZFJV0w1egHRC7D6iTYZ1aM/3wEiTBKyOzekd9jlFV3tCZmz+IV+uz07MYK2iXYjIvGCMmawfTLiQJawlSN6/oEU7GSRvYQ9SlVZlU8IaYGAgphkRv8pJVxbo5juwIn3wqA+uo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(41320700013)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tkai1i4XCvBtfyzLMnbZcUQlYpD1d+DVKe+zavNcQtaw276OpnUZhwr/WY4h?=
 =?us-ascii?Q?JPNObGz7PE2hhOzTxrMuc0IwJNP4z71/sRrAkcL335CzFPK1Q06V1LHpzrsU?=
 =?us-ascii?Q?dPOCJIq0K5KUkWZEQYL1cZ7a0LQNhT4VGVFLBwnxC5vAUVROrJ5C96vL924p?=
 =?us-ascii?Q?GXUbKM3fk3y+JkLxLNymtu9Yuy1RY+/IC4OorQAgWmED35HlJeWLn5ebgh0u?=
 =?us-ascii?Q?dc0bHEiJXrmEfff2BTzqjTMm8V3vtk0bu2xbExsz5GBFXyNT++r5ugRvfAGC?=
 =?us-ascii?Q?wnXsLIZuPqatRGE44xi0/juB/rlv3TlcbZBwqUd7druyCR/31qRmPXp4vvxa?=
 =?us-ascii?Q?h3cOcapyuEbpV9yMKVlSNvgGDftFj42pPfo7QC5Havd2loOKvHTCYxKffsBV?=
 =?us-ascii?Q?VEZEL/L1YSHdiBO3iEORe3XUN1BEKspWvebYz1GsDEiAUVE7cLZJFjL84ox1?=
 =?us-ascii?Q?ZrJdzhliryZIRlkeqgdJ8HmupGNs1au1ZjkvH7K1BS9CgkQYAV+DxAInFKl5?=
 =?us-ascii?Q?OvcOTcYFeKUwvWpNj7tqvyGB2wMdnH1qIAq+3q+cmhDgrL/5vFGlTcXqzuQR?=
 =?us-ascii?Q?iWMPanSNYV6MHaM/Wk/ag6YhliaGXhh3Ejh5eIeGhCXnKzxSzYTU2tuyEgNG?=
 =?us-ascii?Q?X7OUQPJFDNLiDnu2KToig1koGdccbsVw1b4KIjHk15lniaZRh7hLVEemU594?=
 =?us-ascii?Q?1Yukg3vQoX53HZ7Q+cGaNKH5AkO9Wvx6RC3d//doVp5Qug3J2ne9en6EBbHt?=
 =?us-ascii?Q?MvEV5Hjo301SUQVrmKLpK9qAf8YWeMXu0V77D9cIB0VT2LdWsU1g1zgD+jXu?=
 =?us-ascii?Q?y6+1IOFHuZ7wscdcOn/114mRpoIlWGdbT3G70HP/IscKaOlYAd3fONdUQtQC?=
 =?us-ascii?Q?WEAQV1eSY3U8eo4W9Av/syaVynrUDDlerxZXXFv58urFnBBZuCtxVCu819Wy?=
 =?us-ascii?Q?cSvd0yzV3Hk7BlXTryTjdWmA2vHfE6mdhC0EIyzi2Q91a3uehbI0CdjMIjJV?=
 =?us-ascii?Q?46rZKAoucmTmV2uAMDTCDiyFXrVE1a4O4+wJDIKmsFZSdFPUmNiHAAJxaBAX?=
 =?us-ascii?Q?xF7ON/kTQFhgBvFLNiA3mAR7N92jXkHQ9jLHl4eizNVWx7F7wPEV7LohPxAW?=
 =?us-ascii?Q?NnZ9hYBNVw2biP74BOf+OQKf8vfsAj36AsjGAmhsRDuZmbCMrYFscpFxUOnu?=
 =?us-ascii?Q?qofb+Jx/nN1JHbapg8Ad4SbX/nO4xyjZoSqopds7tro6C40e6wg3XV8re73U?=
 =?us-ascii?Q?ItLRelF0gK/PS5WRqaT0qvQw6Ex3Qi/df3O7d05Y3zHChzd5gukodVWh0evn?=
 =?us-ascii?Q?TjbODNhaivX1Pp6mcNzH+RFQbK1lYCvoqMTAfvBSDwS0sj5YOxDc6TjvKxzO?=
 =?us-ascii?Q?yk/5VNgM/0Xu/PIGus5Mlx7NVMKPNVf+9d7EEJgqxWZtteD9HJvnBynbVduL?=
 =?us-ascii?Q?vLnE7XKQDska73d3PnU4mR8K0fFu+rNnXq9z0BDs9kDMEvTgG0+HrbCHYzUZ?=
 =?us-ascii?Q?xQjNdM2o7BbT30VUmJ4BzGbmWwpt2imVqmBNU2V56TMIaEgny5Mfe9GqnqJz?=
 =?us-ascii?Q?hScm+pdjCO4vGx3VypeaOM2L9bjglADrASgBd8tSY0Q3CjpJMAGQUS7Wlidk?=
 =?us-ascii?Q?tQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b6891eb4-524d-44af-c0ff-08de2bf81cd5
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 07:56:16.9824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ns8dUwkqTXgvIr4a7GRUFZAal3MnsriFP4IO6WXeOx44jpIrsLTWRkyr7G96ID/cvh3yd4dg6GTUTg6mmrQj3PRejHpH9R+kOhI4yiaulJU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1241

Some node in this file are not used by the upcoming VisionFive 2 Lite
board. Move them to the board dts to prepare for adding the new
VisionFive 2 Lite device tree.

Tested-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/jh7110-common.dtsi    |  8 --------
 .../dts/starfive/jh7110-deepcomputing-fml13v01.dts | 14 ++++++++++++++
 arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts | 14 ++++++++++++++
 .../boot/dts/starfive/jh7110-milkv-marscm-emmc.dts |  9 +++++++++
 .../boot/dts/starfive/jh7110-milkv-marscm-lite.dts |  1 +
 .../boot/dts/starfive/jh7110-pine64-star64.dts     | 14 ++++++++++++++
 .../dts/starfive/jh7110-starfive-visionfive-2.dtsi | 11 +++++++++++
 7 files changed, 63 insertions(+), 8 deletions(-)

diff --git a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
index 083ec80b4e44..8cfe8033305d 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-common.dtsi
@@ -281,14 +281,8 @@ &mmc0 {
 	assigned-clock-rates = <50000000>;
 	bus-width = <8>;
 	bootph-pre-ram;
-	cap-mmc-highspeed;
-	mmc-ddr-1_8v;
-	mmc-hs200-1_8v;
-	cap-mmc-hw-reset;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins>;
-	vmmc-supply = <&vcc_3v3>;
-	vqmmc-supply = <&emmc_vdd>;
 	status = "okay";
 };
 
@@ -298,8 +292,6 @@ &mmc1 {
 	assigned-clock-rates = <50000000>;
 	bus-width = <4>;
 	bootph-pre-ram;
-	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
-	disable-wp;
 	cap-sd-highspeed;
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc1_pins>;
diff --git a/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts b/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
index 0243e54a84ed..d8db9ed4474d 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-deepcomputing-fml13v01.dts
@@ -11,6 +11,15 @@ / {
 	compatible = "deepcomputing,fml13v01", "starfive,jh7110";
 };
 
+&mmc0 {
+	cap-mmc-highspeed;
+	cap-mmc-hw-reset;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&emmc_vdd>;
+};
+
 &mmc0_pins {
 	 rst-pins {
 		pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
@@ -24,6 +33,11 @@ GPOEN_ENABLE,
 	};
 };
 
+&mmc1 {
+	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
+	disable-wp;
+};
+
 &pcie1 {
 	perst-gpios = <&sysgpio 21 GPIO_ACTIVE_LOW>;
 	phys = <&pciephy1>;
diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
index 5ca10597dcd9..21873612d993 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-mars.dts
@@ -22,6 +22,15 @@ &i2c0 {
 	status = "okay";
 };
 
+&mmc0 {
+	cap-mmc-highspeed;
+	cap-mmc-hw-reset;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&emmc_vdd>;
+};
+
 &mmc0_pins {
 	 rst-pins {
 		pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
@@ -35,6 +44,11 @@ GPOEN_ENABLE,
 	};
 };
 
+&mmc1 {
+	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
+	disable-wp;
+};
+
 &pcie0 {
 	status = "okay";
 };
diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-emmc.dts b/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-emmc.dts
index e568537af2c4..ce95496263af 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-emmc.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-emmc.dts
@@ -10,3 +10,12 @@ / {
 	model = "Milk-V Mars CM";
 	compatible = "milkv,marscm-emmc", "starfive,jh7110";
 };
+
+&mmc0 {
+	cap-mmc-highspeed;
+	cap-mmc-hw-reset;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&emmc_vdd>;
+};
diff --git a/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-lite.dts b/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-lite.dts
index 6c40d0ec4011..63aa94d65ab5 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-lite.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-milkv-marscm-lite.dts
@@ -14,6 +14,7 @@ / {
 &mmc0 {
 	bus-width = <4>;
 	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
+	disable-wp;
 };
 
 &mmc0_pins {
diff --git a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
index 980e24e3dbc8..aec7ae3d1f5b 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-pine64-star64.dts
@@ -44,6 +44,15 @@ &i2c0 {
 	status = "okay";
 };
 
+&mmc0 {
+	cap-mmc-highspeed;
+	cap-mmc-hw-reset;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&emmc_vdd>;
+};
+
 &mmc0_pins {
 	 rst-pins {
 		pinmux = <GPIOMUX(62, GPOUT_SYS_SDIO0_RST,
@@ -57,6 +66,11 @@ GPOEN_ENABLE,
 	};
 };
 
+&mmc1 {
+	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
+	disable-wp;
+};
+
 &pcie1 {
 	status = "okay";
 };
diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
index 574e128138c2..edc8f4588133 100644
--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2.dtsi
@@ -38,6 +38,12 @@ &i2c0 {
 };
 
 &mmc0 {
+	cap-mmc-highspeed;
+	cap-mmc-hw-reset;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&emmc_vdd>;
 	non-removable;
 };
 
@@ -54,6 +60,11 @@ GPOEN_ENABLE,
 	};
 };
 
+&mmc1 {
+	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_LOW>;
+	disable-wp;
+};
+
 &pcie0 {
 	status = "okay";
 };
-- 
2.43.2


