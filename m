Return-Path: <linux-pci+bounces-42020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF0DC83D7B
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 09:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D37D3A5916
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 07:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082742F99B0;
	Tue, 25 Nov 2025 07:56:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2096.outbound.protection.partner.outlook.cn [139.219.17.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA132FD69E;
	Tue, 25 Nov 2025 07:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.96
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764057399; cv=fail; b=AJGKnV11EgJ1ykLdyRzrzA6CSe2Ohe9cEsKh6aw87PZgacPKwhT3PjqyacQUXOJGu8t1mlvvs1gtsCP8ap/XahxifH7neUdzBP2IROblGLH++JdAyq4TJVbrt6XdSurRao8m195M/p/uUWTuNNjv7acIulcCkiSLV6C+09jozuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764057399; c=relaxed/simple;
	bh=QDrJOGSOewEYaW736pVuDRdxjABd6r4i8rDvTuKpp8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kUeZDlk5HPZxKofyffZcacEQ9ZXcCDbBk3kb7i4ebwVSXyugc4g+vFl245usqYKxMfrFodSX+EUovDFZWANnarrrHa8OAeJSPyIBmR35OD90nns8EOy2CC5AbIP/gU+Ig+Zay2FNBvt+ahQPkhZK/oDVTq1NmgY0z2ehPoRaaQo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b87NK3mRvIEXU0EMqFs+EpcHDX3IQ6epkSZ1VhkQIUtohtQf0Y3dVsW8L+u9hHzYCdfCcxBNtzPMzWzSvTBKCHHOFxlTVzXP6KxNmuX/QhFKePQCo2wBw4ft9/p96JX0+BeTFDyfVnHfkIA95azjqGnWiDeDDXntp7XLytP4XMplVI/a+R/tpxlQKuob5490zY7jtZbGKme0o562qr1UrN7OGiMdZN9Bd4Jgl0sFdQPteEjpn52Fdr0R23uwY9risg3rLajw33H2lexLTeAdiCpeCpKzLUQw8lzgP6YKirOPbIOBxD/+aTRMV+mzzsMqPswuz7ejGBymt8nnmk7K7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X+HmaGtirQ6clmPxONtMJgCxZv9AvlRi7a4E53AV3Ww=;
 b=Hep1YRYE4+kWqvljFXC0LJWGCFNRIHwpz/z9dVP4bSsLuF07grDzRgtnDlhK1d3ip6hoSRlLQg2wJ3i7dELEV6iiv9X3emsPExU0maLz5ln59azvU9gWUsvkP7L0P9cRkcFMNsGgEEsYh6Nj9PSPF3MLuw36J8p3jzO09/BVGaohXJmXDH03oWXCWOB2EqtIDDQWHquv/sr5ixQMmzXRXmeEGbQ5wnEDTbAlIUY/vxnQElCPtA6/fUBuI17lgs3WTKbkcMCPT4V3jpL5EoI39IFQC39xU8A0Crlwowc6Z4ALWEH1N3c8XzvDhXS3+WyQXoxul8dDBofwwftteEQs/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1241.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Tue, 25 Nov
 2025 07:56:21 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9320.024; Tue, 25 Nov 2025
 07:56:21 +0000
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
Subject: [PATCH v4 6/6] riscv: dts: starfive: Add VisionFive 2 Lite eMMC board device tree
Date: Tue, 25 Nov 2025 15:56:04 +0800
Message-ID: <20251125075604.69370-7-hal.feng@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 08e503df-f2fb-4ff9-00e4-08de2bf81f8f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|41320700013|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	L08m2flTpnr0qbin1QKEor6QKd81yb4kAn0I7AmZx37K2+A+bUloQed7dVvSh0vF+WNu1B4H20HAmyx+BkSaeAHpLxSJwXYnqTz5lU4p4RoEsK/Jd4JaZprDGO8qBxROctt98q1DxzFJkiPMmco/BKiok6beJf7+v+ChlPW2lwDsiQtxBYqv35G08nwN1N9wx4flDfqxRAXzj77wczoq3Ea8InUlrQyVR2REkXq6Nie7XIWgpPCoUj8s/C+7w7GTnaq7pwI0eHsD6hANmn0i9GQ5siPaWhJuof+0huuNdz/LPFjlY/MGHiliSfz6lIu/jT0Z00bebqYBU22VWk2DdHP5JyJdvnQecFtqtLM4E8YxkDziw5tKkuDCIB7X9D+MsnwNQPPiwhMAUPiMDt+IT03G4dYSdTuxA0yg5I1SGVM6Lc3dn1JqC65FQdq0mP2lJsnSQeDPMwvWEoa3hBYJaWgLFtZCysAuj4RoBIfQd4zWGeJuDsxBOop/ODq0mFe+3IlhxSnb9toa8VMLsnx2ONDQqw/UHHk3qd7Z2QMYZrvhofzE7D+tCOchednre9PHph6vaWnuSGiHuwf7FoE77QQa1bert8L22nkbXRpO34g=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(41320700013)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Djltacx1tUXWfaHa7twJfvut2UnrChuiHPZwMYBfupx+Y2XSC1FE8jQKZQNF?=
 =?us-ascii?Q?5vX2iMYwGDK7Vpa/Iu02itKsbDw6smefaN20/i9lXZ3QmrJbUMyUVzRuRNz8?=
 =?us-ascii?Q?nkZL+gZkfNa6+9QN7Xw3xwUtKBZWNcNHnzrT5MDJ9gQaWu3mMpJnuXA4lzOW?=
 =?us-ascii?Q?tapNJ2iH9AjALkfMp+Ma0mTOpaHz0kdJvGtguIuD2B/xsH44PEEyoIy1ehl4?=
 =?us-ascii?Q?VA62O2H+l+nvXLg2ZaZ6t03Ijkb1TI/bcleTEEVFcR1r/rDogSi8zV8oCLLy?=
 =?us-ascii?Q?Ab2OpqfT9Qe6g4H2y6XmKr0JYO4i9r5I1WaLWxEn6c+xPnro8zCwGEGxH17M?=
 =?us-ascii?Q?JwhoXEbROlxwwWguQKxiAmreAVoVj7y6dq10omlvm9H9GoLsp1sFcAuM+4FR?=
 =?us-ascii?Q?bHFWD6hWbhDtETACMV383go6v+NccqBTkToAUaNO4KlcqNuaq91kxDizx9QO?=
 =?us-ascii?Q?WIaGKQEuZQsjHTpoLzqDn3cLDzBNTNLDMSgOu/tcsaL2K6srEinzY7HpFUHx?=
 =?us-ascii?Q?YS2PwxwvG1UzGhyAPDPBiJBWFS1PS1kO1r8ffG9d2w/wvQGTNSFBKKrgq614?=
 =?us-ascii?Q?vPc9doWgJF19wd+cjci4yM4LRAWYfFxDmLgqaP23CsQxH+5MxVcJGgNiRGUy?=
 =?us-ascii?Q?OsVSNuY/t3+Bx/Ite9O8qfhspph2kZ/QO9v0N+289QZIDY3XYLRJT9YrsJjf?=
 =?us-ascii?Q?BKLzjXWDk66ON0oMwtMb4Jk+xiBNZfsr6skFapObiQKdlgYTsqRsSifLQos4?=
 =?us-ascii?Q?k+ndQ1Sqp3Gl7z3kvRWqWlqbPvm1inFfJIlEnhwNCT1SaTAsFr/MLnEhGPCF?=
 =?us-ascii?Q?cZzqT8Jv0uAk9Akl1xMpiJxWG+hs6MFxqCghJrM2qclsGZK69GOeX1wZEblV?=
 =?us-ascii?Q?wco/bZLWAS9f8qBqBePE9eBLsjLrsx27GWkz3YF1DZXNmW3032IjxtQJDmxB?=
 =?us-ascii?Q?k+q5oGiMl34ZNkF7VeX3msuqqt8WZkpi8yCZZgqlgDdXkbbA1C2pHiPUmY+o?=
 =?us-ascii?Q?NfN/zOzS3VmffbfXSGUglhjzgdkbzyMF2TC6z+voI87WNWs0ppoarj0+CtF/?=
 =?us-ascii?Q?Fa09JTO9f7rOmoxL6OPRKK+ceUZPsgPlYWO38tG6hZJZKq1Qu58eeBW/Ss5L?=
 =?us-ascii?Q?C8XxOqcwlo+G2/o9ualm2/zwpm6lW0yQLl+W2zd8/I2cvWGwuiGPMLfGBCXD?=
 =?us-ascii?Q?ezZEmL7U08zfaNcQLhNSbBM2n6aWH6HtMmqLhj65AcWQvW3Ex3KvY+nxLhrC?=
 =?us-ascii?Q?GHpSiFRqvCWuSkZYkyqoK9+cXpLoSop+rkKhbkSwI75CWv+gxpYXfuplimja?=
 =?us-ascii?Q?U2cGgJwaJLOojc5j4MN2kdELM6QFk8JBg/FWTU4YsPiLi3YnN7vP9j9Ntr/0?=
 =?us-ascii?Q?jkmApKB8kmPQ0OOrR+PaI+8n954+5We+1oWxRrNPvdqpwaeOayGx2ByITwzp?=
 =?us-ascii?Q?a6WbNlEvPLWhufFiqwLcfCntK5R32XkMYtpP40rqWvYu1Cpl9GtGgXlk2iqn?=
 =?us-ascii?Q?3k/eBhdyiJP7eNrsTJdLcQUyGhqyhJnssMWsmsxeZMPi1Uc7KHKfNpW95Nit?=
 =?us-ascii?Q?M558BNRfyBEcVdc06FxGRvsjwP/ebpwVb8+c/lC5WTnONhtfn6dqX6KMV9Ym?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08e503df-f2fb-4ff9-00e4-08de2bf81f8f
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 07:56:21.5539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /fim7iZ7j2eKgDWdrssYm0vUzmokzCyB9xYQGs9ONDiu71SrWaulzsTVAIp0Ag0/mYWIrUK+XVmFVPxS2TTVsQC0oMOkNJHnDx/r9rbi070=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1241

VisionFive 2 Lite eMMC board uses a non-removable onboard 64GiB eMMC
instead of the MicroSD slot.

Acked-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Tested-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/Makefile         |  1 +
 ...jh7110-starfive-visionfive-2-lite-emmc.dts | 22 +++++++++++++++++++
 2 files changed, 23 insertions(+)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite-emmc.dts

diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
index 2b1e7fcd6f84..a640ed5dc5a1 100644
--- a/arch/riscv/boot/dts/starfive/Makefile
+++ b/arch/riscv/boot/dts/starfive/Makefile
@@ -14,5 +14,6 @@ dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-marscm-emmc.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-marscm-lite.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-pine64-star64.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-lite.dtb
+dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-lite-emmc.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.2a.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.3b.dtb
diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite-emmc.dts b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite-emmc.dts
new file mode 100644
index 000000000000..e27a662d4022
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite-emmc.dts
@@ -0,0 +1,22 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2025 StarFive Technology Co., Ltd.
+ * Copyright (C) 2025 Hal Feng <hal.feng@starfivetech.com>
+ */
+
+/dts-v1/;
+#include "jh7110-starfive-visionfive-2-lite.dtsi"
+
+/ {
+	model = "StarFive VisionFive 2 Lite eMMC";
+	compatible = "starfive,visionfive-2-lite-emmc", "starfive,jh7110s";
+};
+
+&mmc0 {
+	cap-mmc-highspeed;
+	cap-mmc-hw-reset;
+	mmc-ddr-1_8v;
+	mmc-hs200-1_8v;
+	vmmc-supply = <&vcc_3v3>;
+	vqmmc-supply = <&emmc_vdd>;
+};
-- 
2.43.2


