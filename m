Return-Path: <linux-pci+bounces-5337-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DE288FB95
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 10:33:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71589B23E58
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 09:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CE142A98;
	Thu, 28 Mar 2024 09:33:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2124.outbound.protection.partner.outlook.cn [139.219.17.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F0F535DE;
	Thu, 28 Mar 2024 09:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711618402; cv=fail; b=LqYFc1FVHL2nVpCTilnusQFkQ44FSww1wAvvLu7kfQApyY2SMVC/8Um2JFuWb7Ku94Z6kxOsMDLzOSBlrsJ+hUT7Yjm9dUuxD59mfrvxUwbLcdQijxzn/sHo1CrhNc2iJ0wSuPuHOxkQtULp26vV/qB4vJgroo5FjFiJtFjVRj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711618402; c=relaxed/simple;
	bh=gEit66vODnszpCd0ucr2+f4oEuxPscA1zlwujMHo3ys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O9UB0mmiPqovK8zlqFsImlVtDram0MMz2arzWsGf4DF7ecmJJGWWJ7g3V6dtevdiTUYG9OiF5tI3OgLZ+0SsC0Kyynk8GvZ5M2d3L7Pf3jp0d5B/wXIbxeag+Uk6EKQU+4pzrCNHdfYK9SrYRyNf4NG4RYK7zdnE3kGr7E7V+EI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8a2WrG62mfgKVBRiccgVw0WTfGX8/9tXWs91R2AJoQy4Er4rTsVrER5/h9DZ3Nal9xlkLvkyR8bSExrS8mTLbWffAK+yzTXQliAIbg/Px9/ShIznYgME7AobD9pf500jtGOLdNhOQPIE0BLRz4KdraWtcfT4fugi2Dh9ny3w39hKtyT7OpOIXAlac8UnBS6TWpjY+aIrRwsf35DitGmUctmzywhha1EMNKHOWJtYGobKvpaLu1Sln/p+2+OzgTnAc+2hMZIxF79nOgHsXq5aLegoJ4Zu4vL2XvKCF0TGLLlko+yy75tluPBvqGMpo3I7bwl+Ih0+OqJblEJB8uJJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y0xQ+n7Z9xr/tqKO1GG6+qOqHTvU7sd+8IFwaPvoiPU=;
 b=ggxUDmg/vXjcQ5zJOE+vUbspfloQfwjQ7/zj/9vGAuNtUoipYx394NMXk79l2Tc845wEfRuKuCoAvzXs7pal2fPjHW7m9y2tZiaxu/hHKq3KWbPjnTeev6JLN5hEowwxdUR/8pF87Z8QCnR7xtH0jd3EBdOuE+vp6DiYVQh+AUabBbmdTR1ohFaIURIRjQl9hEw9OI1/e35ptL5TKcukbyDEJFTMVaTf8YEV1pB1tmS4tWv0aInfi3zqsKxI1gkWkW2HeKoS9RBHjHNqSCQk+JOoC2EfTjIUTntRihHQl/eoxqm0KiwiHM+s7vi4FFluBfbi91U6RZqle0G2aQO3VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 09:18:46 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::c738:9e6b:f92e:8bb9]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::c738:9e6b:f92e:8bb9%6])
 with mapi id 15.20.7409.031; Thu, 28 Mar 2024 09:18:46 +0000
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
Subject: [PATCH v16 02/22] PCI: microchip: Move pcie-microchip-host.c to plda directory
Date: Thu, 28 Mar 2024 17:18:15 +0800
Message-Id: <20240328091835.14797-3-minda.chen@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0496:EE_
X-MS-Office365-Filtering-Correlation-Id: fd71faf1-982b-4b89-0c56-08dc4f0811e9
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	680hlDLRwuCT3fowQQIvfcaZ+WsFtzljXdlry5Q9gPRgR0zl+xUNq5/Ww1reV7ublXfrZFV7cSQmnDl+ppdjIsevZoBegVz9K25FbRZzFd0M+vCLBbpP8Yj9zHZ6LKbQhuaXAm3cfBUhDmD8tmEgP4sGsu1dR5RhUtFLAHsjieOstCW/V/qgtt1rYwe4hdAkLZ3qp+pgFO8vjs9KlHB5Nb3CoV8rrQU+h+7ZePxr2EayU+61gJl1GCcB+6eY3mXkBETBkQhHrdpemPyVkXgTX1xLI82IsSpmDuou8w96GsNIxUST8gEi/zuytp8uM9P3ZTTQhO2znPFzQF7B9Z6DbtjHX/XXH8W/13WvvRAcJX2MRBbGxh7xBEM8D5S3pWmJ4IAspVSO29sji372f2g0AjPaTDJ7BVDtkJZl95SnScRIeoR3JbZ6j5aF7zk8S3TOMAtsFYbkmNy2wtAUawKGmXLGtoCkGChwzwPhV1/xysQy1x02lcD/xGN6ZLE+S5tpgKyZIzHypQVdHgNAKVAf67BE5EA1exJhlT4GDLm3i8DxTmBXB2N4c8gx3qhP9xHeypJjY7LUoKTkOqR8UrfY7ehKGujecHLhwtT8N6AulFBDlKvtpQggdtweZiMCh0sM
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(7416005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wrDTMtPcou/msgBhE3arEgQCYw5uq07V82MU0fVkThlSFwQz+Mo/RBnpg47v?=
 =?us-ascii?Q?7AY3j5eF/aYgTCE4KpsX4Eki5SocxOIgKhc0Ed/b/bdoXguvxdjz8On97v5U?=
 =?us-ascii?Q?fRiA28w+bdmPFRVAWsA1aDmALnzuuljafknvKMPbq4ywSvNvzseOsuEzxjt0?=
 =?us-ascii?Q?yBK3WzA718ZtrMz1MGyrBsMXQxpBPApIeqSW8Rp76kLVNE1LjB/tFAn0O9Ix?=
 =?us-ascii?Q?XibC/yx6HYQ5oxkZdkoUYbN/2q8yOEiiJJMA+08082h72yjUciOzy/qMEy0i?=
 =?us-ascii?Q?MjGgn0Pdug0Kd0yuaJ7xJXApahm+DQmNjgdxr9Q18+fhIJ0SiHBMjh6lJj7e?=
 =?us-ascii?Q?xXZJ7OfpCEukjjWWznSf2rjwdG+Wf7xqKOTExyuZKCIyZGGCkL8p/0cPCFmB?=
 =?us-ascii?Q?s4gSawEktouK1gS+4ZqIL67I1EWHjtt0khqZBThdQ6EIauev2dEhd0yLUw7X?=
 =?us-ascii?Q?F4jfdKCYQTPSzR6dMvKkWIO/16mIPTP700uPtj19AH5VscGc2s4KGY0FpbmE?=
 =?us-ascii?Q?Gh2ynaGWk21NFQhe7c14sExcoWll3rfcuStFPAAtHUypTTz1DMvYys8/WJWw?=
 =?us-ascii?Q?AQruIQkoyWzODrKQ24Y6yaOCQVCitB+1S2AzVgyZ3YpZFMPXur+5a5rkbzbv?=
 =?us-ascii?Q?J54ptRECyt18F1eUv4ztUAsrFXKCBMoESU+wjc3YXuPpzrF3C2f7TTfTNFEE?=
 =?us-ascii?Q?fLdluKlEExXB+MaFPsSb+g3VtQC/TkWv/hEydVFJIcFCxnmrTFIL5Ti4QaU0?=
 =?us-ascii?Q?kJg/YKPSbK/r9er8dNDv9ubE9iymED9qeHJHLrM2FWbMS3IebqTmCd9Dz2XK?=
 =?us-ascii?Q?W0xdeupLX85qxj3n2aj0k8hm0m85feblqJYbTA+bexS+h0BMasDz0HZVu4RI?=
 =?us-ascii?Q?KfpI8p6UVuJNv9KJKrVLqqdSUbNmMRY5fsZQjDrZ7nQW9uyG/2kglb9VqVGh?=
 =?us-ascii?Q?MQf0o45KFYrBwlHkRfeDtQWsGNhWeDTSuvR5ZB3FbLs9AO8NfsonS2zxX8iW?=
 =?us-ascii?Q?i0aIwtUIFuMRH3paiqZm/zlEbOMHzZUMQUqIUeMHAPrFyhEwoRRwc8hYlul1?=
 =?us-ascii?Q?S7z62/Kr67UotM6vqFVqXUxJ/JNxzC4Gefj9E/TnjIXdlnT3TyKBMjRnOl2s?=
 =?us-ascii?Q?jOepPdd3bfWXeM2hDn1h4zuzh65KB+4Yzgz9paNTQVgJupmyU53PpRN7EH+5?=
 =?us-ascii?Q?UVj90tSnre3AF+jb+5j5cS9SVBZmrcSrKXCJLdnkzaGx8UtXXhZkP5JAGYEi?=
 =?us-ascii?Q?B4V2qJ4QbPFK5rzBfvjHoo7AK2wk+0Htl3QuClaoVZT+ToibPVSymQ00Ks21?=
 =?us-ascii?Q?uyI9eUvA9on30SXiDG81nFl0h2V5GVBUXYEp3PaD8kihQtakEZzOS1Y4SYfh?=
 =?us-ascii?Q?9zITbYpqEAbCYFrlKT/IS9ZvDR1uury0tLfqYGDrEaXcsyrj0MRXclCQrB4K?=
 =?us-ascii?Q?ENdSudzhlMmef0Woh00NuLpjrWUqU2waWHUhgOTs0bVZ+SWa9W5Om1bV2+/A?=
 =?us-ascii?Q?+hnn+88sJNp8FDg6F2WbKpdQjEsS/L0kSSmQfJxiRBl4bUmw/lM5UPTCEtRL?=
 =?us-ascii?Q?0HjeChY0L77EAR5EgWZ2LO6pithBaDj4vjmioIlaPq1BAUXqsd5w9TDxWBZX?=
 =?us-ascii?Q?oA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd71faf1-982b-4b89-0c56-08dc4f0811e9
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:18:45.9663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTtpTG5maX9EC9DQy4sR7poYi1XZywHrDk2sUdnMMaN/sLSIeOTLb6KRRr605i8rthOsj6A3g7VtM+hUATWGoPi1nycxtesML/eYxWEleks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0496

Since Microchip Polarfire PCIe host is PLDA XpressRich IP, move to
PLDA directory. Prepare for refactoring the codes.

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
index 06278f1db13f..dd158cc7b009 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17183,7 +17183,7 @@ M:	Daire McNamara <daire.mcnamara@microchip.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/microchip*
-F:	drivers/pci/controller/*microchip*
+F:	drivers/pci/controller/plda/*microchip*
 
 PCIE DRIVER FOR QUALCOMM MSM
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
@@ -18963,7 +18963,7 @@ F:	drivers/clk/microchip/clk-mpfs*.c
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


