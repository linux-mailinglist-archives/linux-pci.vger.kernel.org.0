Return-Path: <linux-pci+bounces-42031-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A72C84F86
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 13:32:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F4C33B1E6F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 12:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234EB30DEB0;
	Tue, 25 Nov 2025 12:32:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2090.outbound.protection.partner.outlook.cn [139.219.17.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BDA191F84;
	Tue, 25 Nov 2025 12:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764073936; cv=fail; b=LrbPAI0ho93cg9ZkKOT0PMuqOmdqBbEmuQaEg4Z0LhJmUNjiblNXSsgx4GEQ5eul7x/+diSItg3O/yHDgb/I27mfLtaLLQdV1QrKQlTIL8osIIy6AXre/JuTTVw8otHCoIuyIiUXBjDk5HrJWJ77I4v1xIyysXECCDt7ZTdLJYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764073936; c=relaxed/simple;
	bh=q6ZC1/EZfmEZKqZWYL4lc9kTjjZgV3Y9Ed/wc7+QXeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mn45al4GPD7vVEYrIIwdqKMs3UOBfc31wVSBoOcm8Z1SpYAPa9UFlQvdCyRiyCbPg4cspDWzMJXdKM1+oh4I1qU+GLeafa/0Mnw+sawJipytMqZjhILrtbiLVxdIYR9T1Jao+N0XI+Z2qdwAY10hQX1CQ9mE7cLYvDnc5rHuAS4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jtZ7LmKx7j/gUUJjwj1E2Rv2w2lC+fBVYjVPlp/Gc7Dta2jOkoEicc3k1JasKe+6cM4Zm/lS7EOx6P1lSDs4mTPlc6AHyihTbNN9Kz3EqEQvfhVFkFtm5KBMS79+W4dFF0ZPppD/eHz7eVzIK7VP5VpTDy3ae6i1xNR8ahY6iPJ6s7ua5kezVw5adGfzuWJH+mfmlmQj6NvMGflbrM++4+GMeRqroAKj+PBs2ScOk09WR29GLj3mV7imkYpAzQZ4OzXVtQTvwtXAJGnb1VaBQEsnrJpP8TXiGV/9QS5nBRTzkDwK6x2g64QArH6kpEcp+zZUT1n0qN/ErXUR/gBQ/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evNj6joJBEogcRINIQ1J+qdW3U3zmSVtqfXuA/SZ4HM=;
 b=ZK43LZew2CAHP6MHZ0CMv1q/uc2Hz8KGvzy22u3aDodO9KMn4izryGUxL+eVLNgulis6lIZiZcHch9tta/SxTCU7Uk43d2KPxJDbWbC7YKm7FCRV1viJHCpLl75lx2vNLp9puUh3avMmKgGChzSqF7FeM9l+sGSEC32L/88qJGqiJ8w4nFOfh/xO1N6JNSbCbDq//hStq6o0I2wOcUtfpI6cKd27Xd9srkRGcAnha4NfIUJWx/942ziNqIokCuAGEmT9+7SwiiCznp3dCYfGchpu1oMLoPxaWoTan20yQeB+mAEfLS2T/N+kmwecEJbi+ddNwJH4NK4ugHOxLsvIjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:7::14) by ZQ2PR01MB1241.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:6::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Tue, 25 Nov
 2025 07:56:20 +0000
Received: from ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7]) by ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
 ([fe80::2595:ef4d:fae:37d7%6]) with mapi id 15.20.9320.024; Tue, 25 Nov 2025
 07:56:20 +0000
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
Subject: [PATCH v4 5/6] riscv: dts: starfive: Add VisionFive 2 Lite board device tree
Date: Tue, 25 Nov 2025 15:56:03 +0800
Message-ID: <20251125075604.69370-6-hal.feng@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3f718291-c008-4838-c529-08de2bf81ea3
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|41320700013|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	NBjYnmgSHRvZdcA05NkWFzzAMCEZlkWJ8L/ECGuLaJ8WOVgUqwQn13DHbUSrw88vKb/2alOjJp2ZLP0erGnc2AxD7XnVHtr5p95iJTAmOXJo+RRVnoDM4XPbkRPa0wZPGgaiWc7jluQ8F5C7TIRhEfOCqKoNmZXL251BtGrpTQ8ZvQtpNx/xgHJVtI9UuaVFIx5cyLJnV24F8eNUCsTLb1tEO9Niffx1e1XwuetevnFaOpurRLReWxKspDMzLiSqhjagx8eZv3Yee+ZcULhV5br6ztyMJ07mqxUN7hk67Gv7yuz+Yb6ENb2O2oMQ2Rvgr0UUnhDzA853SkkMwRQefkDNpsZAHFZ20xGyQYLghRntQEpBOBhiqcv1ts/bQxuQYnPcM6Q+OEQQAHEurlowmisoDD9Xrp+T3mqziyavUraolozs/rJYILn2faJVHtgecse+BhxTRq5MDv/3oe/ifM2tbv8MpeEJqndnNtMPeDR3rTaQmwAtEB8PO2wRzT2tH85o38YKBL/xDPqsV8FF2/1iT2fXxbolbdwWy/tkAyHueZd8JBKOHOEDpvtoHuyhFwk//pWsjcUQebTBzSoNHMZ3oKcbI7aUNWvNcvzSzbE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(41320700013)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5LfiJ2sHFCqkjgsQv/Hrx9E9f05Jm91HXv9pAWzyroG9REuQMhxtzNp2MaeW?=
 =?us-ascii?Q?P2WTtPHQ4LvhEBU7ZJ74j+97/abr1jFriFs/iSidsKAsRxCAm81WS0EAz3GI?=
 =?us-ascii?Q?9/UC1sXoKdUpf0chJj9r4HjLkDORrxUKoud+j1n+qTtR7/dC4FMWgVAiU8Wh?=
 =?us-ascii?Q?NpqGJvCs+4Ot2eFluCsn+XGgHQvshG4/8mYAVAVPoApkfAGLiASksVVKhYmp?=
 =?us-ascii?Q?eXnq2TBK1HG+lkYNjP29YP6CBZEFEeIMGVYYyF6b9/OfsvH8ECo58y+mdpDx?=
 =?us-ascii?Q?sAx10w4QRLkCrgNmGMjRaLnCZ6qs9HtD9x/2f+FSPV4v25Tlg2pvhD/z9Bv0?=
 =?us-ascii?Q?mDuXcLslXqri8ySk8IzXSnWQdLhWOuIrx2rNRpxArh7PNhojmyF12okkaEqy?=
 =?us-ascii?Q?/8z/DOrFMn/i8+FhFrI2eHA1dAOVF7htUbBLFckJZ/5vu2J/iH3ikFfn8aRZ?=
 =?us-ascii?Q?l6c4n5Cr1XGZBTFoCPbI6VJv6MY/pa0V08wIczFTerSp+uR7E6ADCXE6dzhm?=
 =?us-ascii?Q?b2tz2KCy/KEbi1FRXRZWTpft5PbNtJzef76U5zoAUKszGShL4wnaKrPqR9ho?=
 =?us-ascii?Q?YosezZ8e3yhfRGWWC2ddI2tV40ZL2cRYIIXtdvXLFTQzMCPoiRfqcbuVlAFI?=
 =?us-ascii?Q?VR8Hfw5C7ZKN7fsLic4K2Aozo5pORB+EUFUjE1WpOXLQIXmWB/DcIPHbH6zZ?=
 =?us-ascii?Q?cgzW+b4ydy1PxKsDEgbOwL+uFs+kJCDp+CC0Ald5624GsofUyxjp0XaqfmvH?=
 =?us-ascii?Q?Fr5OKiAU1cDdmg8CSQGD1nM2TjbOzkpw4tpRpRRGROl2SkXWG+4QSHqW1fR7?=
 =?us-ascii?Q?BqwQdikt4johBrTvyjTcvaegSt3bPqa7Mt/X/0YjZUHqR8lR9hcIMgWkWbuE?=
 =?us-ascii?Q?Pjse5cetG+fHcy7BnZrf4vAllWMmVSB+DiBibumqvY2IvJdGEHTcyPcCBi+y?=
 =?us-ascii?Q?kkSn6fRj8J77GqfJWzGwf0Pmu65i6aUAFwIDCKdY5Z2V6yG1vikVgTzkRxyQ?=
 =?us-ascii?Q?nUdhMcwcXiud8lJammFYoWghmiA9Br+j3zwvPzNAKOD5L+9bcdIp55h1AMJc?=
 =?us-ascii?Q?ozXh4IvyRbtIoqo5Ax2nga5EY30Wld5v8IJlFGRBNdA1/dAjAjhnNRaye7ez?=
 =?us-ascii?Q?QYzRK3Doy5PNEpkrtHaMdIThUjQdfCBbyTzU3Dg4e5ZwH1RgZmFxB0sZcIZh?=
 =?us-ascii?Q?3OyoYC5IErdtcY7WaKtW46hWtsyFjhBlbZS/zDg3KLSozqnatDwMJyzT/+M/?=
 =?us-ascii?Q?As0iDUPPDBNrme64KdR1/c3B8WzWJozuPuMcU4THyguLH8EH2inBP+cOedN7?=
 =?us-ascii?Q?n+matq/jrW7N37YoaIKlQJYgl92OZ3t54gZtPr6ckG/1czmjYh4oUm5DUq1q?=
 =?us-ascii?Q?4xzmoEltF1zYnoY2wqR5HEVipmp+pJOdaMMI7hiDO4Sa/SEIu2AhM7QfU1ym?=
 =?us-ascii?Q?QcZxxOIB4Ex4CTccrWLYXkwBA9JWxiLIxdOtMOQjYNIYlRtyO8lGa4M7qk+R?=
 =?us-ascii?Q?tWtY0MDLtsduHVHIeyJ/5WuRxoCo0Pfq7QTIU/D9Uf0wKpYCf4zZsVaovc3N?=
 =?us-ascii?Q?lVihJ0/QjhAxXRtVWEco9KCOng/IDdqUb3JZf3gd/qvqMj8+mFUCs3lhdM5d?=
 =?us-ascii?Q?Kg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f718291-c008-4838-c529-08de2bf81ea3
X-MS-Exchange-CrossTenant-AuthSource: ZQ2PR01MB1307.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 07:56:20.0355
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gPBYWhBikr6SCy8DIrAskjW3/zFWKUc3JliJLkzIvvf6g4X42nwAf+0ucbAad3WQ72LYquSGtBwhumktaOc6T6mnKo53s9r/1tTbFDSKNEA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ2PR01MB1241

VisionFive 2 Lite is a mini SBC based on the StarFive JH7110S SoC.

Board features:
- JH7110S SoC
- 4/8 GiB LPDDR4 DRAM
- AXP15060 PMIC
- 40 pin GPIO header
- 1x USB 3.0 host port
- 3x USB 2.0 host port
- 1x M.2 M-Key (size: 2242)
- 1x MicroSD slot (optional non-removable 64GiB eMMC)
- 1x QSPI Flash
- 1x I2C EEPROM
- 1x 1Gbps Ethernet port
- SDIO-based Wi-Fi & UART-based Bluetooth
- 1x HDMI port
- 1x 2-lane DSI
- 1x 2-lane CSI

VisionFive 2 Lite schematics: https://doc-en.rvspace.org/VisionFive2Lite/PDF/VF2_LITE_V1.10_TF_20250818_SCH.pdf
VisionFive 2 Lite Quick Start Guide: https://doc-en.rvspace.org/VisionFive2Lite/VisionFive2LiteQSG/index.html
More documents: https://doc-en.rvspace.org/Doc_Center/visionfive_2_lite.html

Acked-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
Tested-by: Matthias Brugger <mbrugger@suse.com>
Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
---
 arch/riscv/boot/dts/starfive/Makefile         |  1 +
 .../jh7110-starfive-visionfive-2-lite.dts     | 20 +++++++++++++++++++
 2 files changed, 21 insertions(+)
 create mode 100644 arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dts

diff --git a/arch/riscv/boot/dts/starfive/Makefile b/arch/riscv/boot/dts/starfive/Makefile
index 62b659f89ba7..2b1e7fcd6f84 100644
--- a/arch/riscv/boot/dts/starfive/Makefile
+++ b/arch/riscv/boot/dts/starfive/Makefile
@@ -13,5 +13,6 @@ dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-mars.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-marscm-emmc.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-milkv-marscm-lite.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-pine64-star64.dtb
+dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-lite.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.2a.dtb
 dtb-$(CONFIG_ARCH_STARFIVE) += jh7110-starfive-visionfive-2-v1.3b.dtb
diff --git a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dts b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dts
new file mode 100644
index 000000000000..b96eea4fa7d5
--- /dev/null
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-lite.dts
@@ -0,0 +1,20 @@
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
+	model = "StarFive VisionFive 2 Lite";
+	compatible = "starfive,visionfive-2-lite", "starfive,jh7110s";
+};
+
+&mmc0 {
+	bus-width = <4>;
+	cd-gpios = <&sysgpio 41 GPIO_ACTIVE_HIGH>;
+	disable-wp;
+	cap-sd-highspeed;
+};
-- 
2.43.2


