Return-Path: <linux-pci+bounces-4109-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF5D868E61
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 12:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4981F233E4
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 11:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00F71386D8;
	Tue, 27 Feb 2024 11:09:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2116.outbound.protection.partner.outlook.cn [139.219.17.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26E61386B2;
	Tue, 27 Feb 2024 11:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709032177; cv=fail; b=N5Kd06ye7TD58Sj+SM47WQl8HeIBL8dp9/qdqwwMUeqPYaTjuLgoXWPLnczVoH9NmBszgKMCCF7tQPm+b+io/aupa7cnCtyGKp2GKk1kuRUl76diz3LFefCgj7OFMthH3+fRZE6npB7+hkpvBlDBT7eS/k5of7Wet/KXwtxwOys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709032177; c=relaxed/simple;
	bh=v2dst+CQ/q/nF6gN4BRL7a2zRto32r18LAgeV6p4Kyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fOprU+ZAChm5JJ5OT6tzfIp8KlWA9uzyXBezzF7gQUe6uAp0BXftYWDALT2coM+UOvIba/8XWq8r6mAY9tS+ldr8D2Ww5bAAYEXqTn4Z5moxiHG7Syeo6idPdkZWEAHwddeEHbQfAdeyHvwgKjr0DMZ+OgvsLQEzErniKYJ7N3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WD8WZQyaYoYwgUWFOtlDxb2jk449fd7QOhWgBxfDpYkNPYQ3gIQN9fnzjiI1L++05ZSiXY/sSZEWjkcdFgonzyg+AkCbb9FjKKYlVArafxwBB30UGUH6ZBEunB00e6pnXmB7OsMUrKGSNrPoKatwIcW0HseWwA5Y7OH8Gmy8jh5JRsVyofcw6baEUxRy4Ltxd0sYRS9zdRX+XA0uxbLK9J2TgwE98hp08+JiXakAixmLkAmWCEx2KHQODbnZ5U9abDxig0cY31cQuK0gEFWKia8yIigp4tVTSGYYZMZAXefQt//804W9xRLbiOnjt9tKHtB+yx6JMgbgF3KG+Vw+NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8u7rdsaomMzM+dZFYx1cmmLgLtXul9EWiXfeKTQVofQ=;
 b=EsVo1FDtFH3BYo+W2+r5qRJSgMyhK1is+xipKH5P/USyCE3ehx6DQgOcVoh3x8FjSxY1AKplaoXlU4nEGCqnv2CS0v0U8/jifpSIHXCVz423UQPjkFxBVAgivzd/WSQO6Ck3lfxDE0VVTzhKGXMcTzRU0SIeRCi2jJ1lst8eOmUuaiA+j6ipv0x4/d+MtNFJcUC1c8auDiHAjQ+HDC3ZApae+gs2F9Ycb2+Uvd1xf34ffoYQsTz5D4qbGT7oS1a5rm+Q3ocezph92vGO5Qh1YAgCf/y97weTNtwIwp2SpKaJMqLU0EihMGqtUQVRNmK/tkohV2Mwx6ytvijHJfp9KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Tue, 27 Feb
 2024 10:35:31 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7270.047; Tue, 27 Feb 2024 10:35:31 +0000
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
Subject: [PATCH v15,RESEND 02/23] PCI: microchip: Move pcie-microchip-host.c to plda directory
Date: Tue, 27 Feb 2024 18:35:01 +0800
Message-Id: <20240227103522.80915-3-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: e4d539c1-7d02-4b64-56ac-08dc377fd2e0
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+IKcrFNVUE7tDQamkX+H8OSL8BzjYuTHAQUspnkC+1qYjUJ/J0Nnucaix44IDXPe3RP0HRQgSWspQ7qSPmv2msW6nNLEcMjvmjlCBtRxWu8BFpP4bkUUjvpnZH4i7CJdGvtTBQ18iBnZGYEwfiAmgvZn7TLIdmsfLtcMJFS1xu7Hy3aL0vs2wKqWNzOzoV8BSmOJoQZ5leMuQh3aY8TbnlDKFA+zbw1Q38QoJ5snUiWD+uTYf3x445y7WtZP4xtilAFNeuoFp6kWL4L6gVTqw4B7EA8YhpooMUvbNlzEqsDRv5xhgxJVrx/Q9fgIMYgs846zms7d8zvJL4PCn5ov93w1M5N3+ZAFS5NrAJ/aMFLkI+vGE+ti8457eeBQbFRhTB44wBEZotMp1USlvDvAuHWP95Hp1LL8tBdhXg47cud5S3wRGnvDOmLfNMsUHjl0G9EQbd1ReO1En3gmvtojG2+vwdgclshUcIMaER2DB16VIte5nJ50tZpM/joLpJbqxrMhn+VtMU4KhOoiHDZ7GUwoW+aPJe0xscYO8apPFSWHTtjrfNwS1FcjEfKa3tpipeyhvWOA8nBlX5NQn4XByUJz88A9OuMjY7l9m2/MFBzFbajL2iZIs30gaejxhygf
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?af7ESUhxA+DzQLQP/BKpC1bwdFMqDscmoazILiEhBPo/Fow5/fHOskE+0g5q?=
 =?us-ascii?Q?sqeRltDeilViP1Dn62uJBI2CP7LrgwKwJ/Ynq8Zs43a/GkZ55cn1oNX8m6UM?=
 =?us-ascii?Q?MNXyk0HqoXnvVl1jJ2OxBkiDJX7fZGsMMwRPL8Z27Tq0h1XANnRA3KlkoGG7?=
 =?us-ascii?Q?o+0SlvodF84BL4Qg9U2djdyvWSNYkohShqbMAJg4di95oAQ4O3okF6QFvOTq?=
 =?us-ascii?Q?wc56NsBexKFTXh9SS0t4jtJVhjLwwizs/ZF07DtOfXJWS7fypaTk10g5RhlA?=
 =?us-ascii?Q?bDwH0WYnhJOYxMmsJoixu25cn+Ds2P9xeJIwJMeTYzT3DlSa/GUAwUAFjhy0?=
 =?us-ascii?Q?C8xpoCivPh+HN1V4MyfbAqRFmgumZE2pS7RoBkKd17p178exGJkhR0A/lAuC?=
 =?us-ascii?Q?EKiGJEGg/WqXJ5WLDgA0ChpAPvq88BXdjSFrr2ymyKkApVeEEow6OHaReFLS?=
 =?us-ascii?Q?R6qX+bmtmu0bqQ6dXNC403w0sOKHl/ztscCUpNsl9f6TbdcTnkvJcJ+mmXqr?=
 =?us-ascii?Q?cF/P8V9a3otHwAUWK2/voJoD1p27S456kQyp4U0fft+WFTaMdHeI9hPQ9D0c?=
 =?us-ascii?Q?+Us9fnF0rdxMNyko54ItN+kCZOy32M9zh6fGY6NslhmDpXvoltOBdk5EGJkt?=
 =?us-ascii?Q?7Sq1huZT3S+faj0fjrDEP37ErV4P+WVx8j0fo445fL5NxVgmVSclW+eiSh5A?=
 =?us-ascii?Q?tSBP+s/ajleQcPQ5S0HQVPaxUVyH7gfZhccafNJGivdkwP33flLmY9AEHPz6?=
 =?us-ascii?Q?D9jrx+qMqX3ScTAfqkUqL45pclAyZ4Xna/cwbkxt2FYaPlFXSCvH6DIEnVyd?=
 =?us-ascii?Q?r6xZHDLzzLZAgnTR8qpYtxsdMq3v0Q9Nr5oShuQRT1Doj8jRsgC8yxfh1naT?=
 =?us-ascii?Q?kd9+I/vpum9Nwu9TDBuksLkOedez7Dn2q8+XsHBpVvnUJ8UWdrWE0sfrz71i?=
 =?us-ascii?Q?Ewg3oLKQgEAO1joRbTaFnQM2jQzKOxb/n1a8NBfSChZsI/OArB27/JHEBr8o?=
 =?us-ascii?Q?xjYhKCVIGRxAE52jWn4ItuTXpMHmG2L4vNrJx87yEniofvec+2ZXY6F0dvoL?=
 =?us-ascii?Q?1a1LyIOoIpsuOsDdFrk3JtB7fiN7RJkk3rcqpGHWwWtlO8Udt1YCZurSV0ez?=
 =?us-ascii?Q?ZseQkskmOd+hjnAjbfuDHz9FaLLNEE1edZEx2NeLEJE9lyAWFbO6PINieq/G?=
 =?us-ascii?Q?XY25Oj3AvoJi9XZexepfND6jlJZq8DT46iymyYdAxL83Wv+lXDyp9s5Kck7O?=
 =?us-ascii?Q?r3NDwWROiRsbI5blsKDzNfRjyPVX9riAAUcJLVbg5zJfCq4FS2NWJ90bQCzQ?=
 =?us-ascii?Q?twESZrIzqnT6vK7A1LJT3N/yg2ObxBNYdOt60PEmqEIEP0HoucxkXCtMtE+A?=
 =?us-ascii?Q?MRGQbFeABsyIBynKjz0yZL6evuhRzvdp8FQ8QXNTa/zdxaZ/DtTwS7ONaotj?=
 =?us-ascii?Q?dofdrqSuugfu8/lGbV02U7uBLmPBNgBcsutCYoNNz5KKO15wyMyrvqr6mfNb?=
 =?us-ascii?Q?/CDpWIVlPaodakDLGGC1JhY1SvG3h+FQYaIp2xqZP4Njq+hSNYtg6HUB4j1n?=
 =?us-ascii?Q?2S/OR0Kp6/SlfVPqKc+3VWhad9gK1w9K+jSPkayQOI9rGahwCsCrigJcecWL?=
 =?us-ascii?Q?Ug=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e4d539c1-7d02-4b64-56ac-08dc377fd2e0
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 10:35:31.9049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K0O9Xzb7MMEZlcXjItEeTmNaa5CiRLA3iGxMIB6UNEU0E7xc8ysM+O6lZqT7Q7TpAOwxNjyR8gzIi+WjJcEeClPvUzjCPeHVJFgcKPD5Feg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0863

For Microchip Polarfire PCIe host is PLDA XpressRich IP, move to plda
directory. Prepare for refactoring the codes.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 MAINTAINERS                                        |  4 ++--
 drivers/pci/controller/Kconfig                     |  9 +--------
 drivers/pci/controller/Makefile                    |  2 +-
 drivers/pci/controller/plda/Kconfig                | 14 ++++++++++++++
 drivers/pci/controller/plda/Makefile               |  2 ++
 .../controller/{ => plda}/pcie-microchip-host.c    |  2 +-
 6 files changed, 21 insertions(+), 12 deletions(-)
 create mode 100644 drivers/pci/controller/plda/Kconfig
 create mode 100644 drivers/pci/controller/plda/Makefile
 rename drivers/pci/controller/{ => plda}/pcie-microchip-host.c (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2ecaaec6a6bf..9f7e907c8749 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17046,7 +17046,7 @@ M:	Daire McNamara <daire.mcnamara@microchip.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/microchip*
-F:	drivers/pci/controller/*microchip*
+F:	drivers/pci/controller/plda/*microchip*
 
 PCIE DRIVER FOR QUALCOMM MSM
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
@@ -18838,7 +18838,7 @@ F:	drivers/clk/microchip/clk-mpfs*.c
 F:	drivers/firmware/microchip/mpfs-auto-update.c
 F:	drivers/i2c/busses/i2c-microchip-corei2c.c
 F:	drivers/mailbox/mailbox-mpfs.c
-F:	drivers/pci/controller/pcie-microchip-host.c
+F:	drivers/pci/controller/plda/pcie-microchip-host.c
 F:	drivers/pwm/pwm-microchip-core.c
 F:	drivers/reset/reset-mpfs.c
 F:	drivers/rtc/rtc-mpfs.c
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index e534c02ee34f..4d2c188f5835 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -215,14 +215,6 @@ config PCIE_MT7621
 	help
 	  This selects a driver for the MediaTek MT7621 PCIe Controller.
 
-config PCIE_MICROCHIP_HOST
-	tristate "Microchip AXI PCIe controller"
-	depends on PCI_MSI && OF
-	select PCI_HOST_COMMON
-	help
-	  Say Y here if you want kernel to support the Microchip AXI PCIe
-	  Host Bridge driver.
-
 config PCI_HYPERV_INTERFACE
 	tristate "Microsoft Hyper-V PCI Interface"
 	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI
@@ -356,4 +348,5 @@ config PCIE_XILINX_CPM
 source "drivers/pci/controller/cadence/Kconfig"
 source "drivers/pci/controller/dwc/Kconfig"
 source "drivers/pci/controller/mobiveil/Kconfig"
+source "drivers/pci/controller/plda/Kconfig"
 endmenu
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index f2b19e6174af..038ccbd9e3ba 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -33,7 +33,6 @@ obj-$(CONFIG_PCIE_ROCKCHIP_EP) += pcie-rockchip-ep.o
 obj-$(CONFIG_PCIE_ROCKCHIP_HOST) += pcie-rockchip-host.o
 obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
 obj-$(CONFIG_PCIE_MEDIATEK_GEN3) += pcie-mediatek-gen3.o
-obj-$(CONFIG_PCIE_MICROCHIP_HOST) += pcie-microchip-host.o
 obj-$(CONFIG_VMD) += vmd.o
 obj-$(CONFIG_PCIE_BRCMSTB) += pcie-brcmstb.o
 obj-$(CONFIG_PCI_LOONGSON) += pci-loongson.o
@@ -44,6 +43,7 @@ obj-$(CONFIG_PCIE_MT7621) += pcie-mt7621.o
 # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
 obj-y				+= dwc/
 obj-y				+= mobiveil/
+obj-y				+= plda/
 
 
 # The following drivers are for devices that use the generic ACPI
diff --git a/drivers/pci/controller/plda/Kconfig b/drivers/pci/controller/plda/Kconfig
new file mode 100644
index 000000000000..5cb3be4fc98c
--- /dev/null
+++ b/drivers/pci/controller/plda/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menu "PLDA-based PCIe controllers"
+	depends on PCI
+
+config PCIE_MICROCHIP_HOST
+	tristate "Microchip AXI PCIe controller"
+	depends on PCI_MSI && OF
+	select PCI_HOST_COMMON
+	help
+	  Say Y here if you want kernel to support the Microchip AXI PCIe
+	  Host Bridge driver.
+
+endmenu
diff --git a/drivers/pci/controller/plda/Makefile b/drivers/pci/controller/plda/Makefile
new file mode 100644
index 000000000000..e1a265cbf91c
--- /dev/null
+++ b/drivers/pci/controller/plda/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PCIE_MICROCHIP_HOST) += pcie-microchip-host.o
diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
similarity index 99%
rename from drivers/pci/controller/pcie-microchip-host.c
rename to drivers/pci/controller/plda/pcie-microchip-host.c
index 137fb8570ba2..cb09a8137e25 100644
--- a/drivers/pci/controller/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -18,7 +18,7 @@
 #include <linux/pci-ecam.h>
 #include <linux/platform_device.h>
 
-#include "../pci.h"
+#include "../../pci.h"
 
 /* Number of MSI IRQs */
 #define MC_MAX_NUM_MSI_IRQS			32
-- 
2.17.1


