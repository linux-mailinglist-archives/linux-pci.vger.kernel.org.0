Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E0FE15B82E
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 05:10:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbgBMEKL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Feb 2020 23:10:11 -0500
Received: from mail-eopbgr150080.outbound.protection.outlook.com ([40.107.15.80]:47330
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729733AbgBMEKK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Feb 2020 23:10:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPdxiiC4M4I+VH86H7V0vCCPe2bLJ0ktY36Fsz4131cFBqEI6FmfK3vh9J+1ZL6mprAN29FSyjiQZiIrfd7fxXfwuN0v9GIs9xQPTjJXGdEeJa/5ADArBCjin6DcczvfTEj1LmvGlPe04Vf+GMRlVsZbK6JUnghN/K5s9VjzdwuV/NgXRgYhnv96QqKfmaAEAxv79SeIrbZMvRm+y0KH0gMBAmTccAYtrqoqxnBybQCTTlp+0iXj6EsYnShiRfjIxd9KeoIA5lKSHx9mWtWpsLKQMZeSaOR66e/Op/Mo8DEdDfOJ9U7KKXTKn8C+9Vv/PDzFlWgqZnxKb/zfXZuPSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrtqYbpSKU0/Ez0terAvYWGs7RjBlrxkvmmZd/T44Rg=;
 b=W2ymXU7fPrKS52RGbzKrVrlTQZ3AQ+WAM9Ck9JwVHAZvIR2b8KM1oNmoQtC33n/EbQdx4ggJqX2Qm1wFqUWfq1DNJL1N1Qmx5/YgQecnmkZFMGIDgNCiAsubGkHnxHft2SJ/0tHlh8GRa3D0GXCtsJ6MJrSuEs1OWHMbnASM0AbbySCDzrb79qPG8Wgh0D9wg6YSQ5VXO8huXMKaOqkSV4V885yTSpTk3kBt/d5QgvG4zOOeT053OWpd2/MuuPSFjouWlRyw8KCzsD6E0ndtdFtweeGFnmpg/WUtePZfgVSLZYlQiLu8wo+Qjz5UgcpiuQL/WycnAERmlG4iwZHGuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OrtqYbpSKU0/Ez0terAvYWGs7RjBlrxkvmmZd/T44Rg=;
 b=FUcmVR2YoL/DvRuY6nmZ87IJ+Cdrv0lLs1HasRzTkMWmNY2Jd44ilcbar8rVqBsuc1xh0og91aRY2GT1XdMuE5tkQ9zrQbc6hRkr9WwL26W2vpuHQHJPVzpujF1SzfyuZ9Kx9GS9RbUXAy9kIg2RXmqyNICrTIcjpr9/50n7W6E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB7084.eurprd04.prod.outlook.com (52.135.63.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Thu, 13 Feb 2020 04:10:06 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa%4]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 04:10:06 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, andrew.murray@arm.com,
        arnd@arndb.de, mark.rutland@arm.com, l.subrahmanya@mobiveil.co.in,
        shawnguo@kernel.org, m.karthikeyan@mobiveil.co.in,
        leoyang.li@nxp.com, lorenzo.pieralisi@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com, Xiaowei.Bao@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv10 04/13] PCI: mobiveil: Modularize the Mobiveil PCIe Host Bridge IP driver
Date:   Thu, 13 Feb 2020 12:06:35 +0800
Message-Id: <20200213040644.45858-5-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
References: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0069.apcprd04.prod.outlook.com
 (2603:1096:202:15::13) To DB8PR04MB6747.eurprd04.prod.outlook.com
 (2603:10a6:10:10b::31)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.73) by HK2PR04CA0069.apcprd04.prod.outlook.com (2603:1096:202:15::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24 via Frontend Transport; Thu, 13 Feb 2020 04:09:59 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.73]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7ef72cde-6e9b-4fcb-bc4a-08d7b03a9b3b
X-MS-TrafficTypeDiagnostic: DB8PR04MB7084:|DB8PR04MB7084:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB7084BDD17FB8DF93151EB2F2841A0@DB8PR04MB7084.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(189003)(199004)(36756003)(6506007)(5660300002)(26005)(66476007)(7416002)(66556008)(66946007)(6512007)(4326008)(52116002)(6666004)(16526019)(86362001)(478600001)(1076003)(2616005)(956004)(6486002)(69590400006)(81156014)(8676002)(81166006)(30864003)(8936002)(186003)(2906002)(316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB7084;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F64ztQVRQnefovibPpuVxxPkWiz837jTH9Mc8zLiXFPXMbWM1p6VClxllFnoCJyfJTQEubLjwcRAHzKFQFaoAvzydDqpU5xbn0H7NW98VgNfzbGlQdFdihusxitxALjrINXm3xqAccsg2vxiXvqS8mCrn3EgHbvANUndCQLlJnNwG4+QdVFP/275VcwLDiSlcsO9SWwaY7rzIiHxbeafGcaHzE7Zvpc6jRGZNIq6ey3N36ioj4+zWt7E3ikfRD3qBUsBrE0M8GKgKsmpLnjiaYK4wPV4DYssu2YjFX1A91rKUzX3LmXTCF6EDIW/guap/Tzj9ApdMjPyPtmh4ujz6JjdM4RsqQ/SLyT6Dz2Diyb3SlycRfEBuGAVN0NggLeHUD9ASahD1/uZz9B5pFps5WqkC1d/RS3DkV3kxosoUj0F91u1oD9cxwYxmAdUsWes1oMX1ZCOwyBHU/pUqgaZkmkAyvv0U7l4a3Wk1r7XLSHRmBljMnPzW5L96SVkrcrFGYtic1U/5RcNbwaXSeykMxyHQiz6rs4XJ0eYXM6Y9f2wFof7v9nOBkk8e6/9QykNWWt9Y7h6Bo94hadLb1h78w==
X-MS-Exchange-AntiSpam-MessageData: RyQAgJHB+iLcHf9BOaglVNl1XL9/kM7+M7a80dYgdlV/X1PZlePWJjbiXAlOxYt6KiIccT6bGlk7mtWIrasUdlWkRazdiUVf+pNHxA9BypLVma9HB0WLAHkx/aFMfwKl/atVZCJSQ7n9vhTr23qF7w==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef72cde-6e9b-4fcb-bc4a-08d7b03a9b3b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 04:10:05.9147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LdHy9s4IeoXvZz7CTF2fPyIFZjsZ70D6MBhUNN79fxHtwhzgv5BTUIjlOUAk2QPWj0mkW5GttIGM9mO+TZCtoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7084
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Modularize the Mobiveil PCIe host driver according to the
abstraction of Root Complex and Endpoint and move it into
a new directory.

Split the RC related routines into pcie-mobiveil-host.c,
and common routines into pcie-mobiveil.c, move the macro
definitions and function declarations into pcie-mobiveil.h,
and the Mobiveil platform reference code into
pcie-mobiveil-plat.c. So that it is easy to reuse the
extracted routines to add a new host driver, which
integrated Mobiveil PCIe GPEX IP.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Andrew Murray <andrew.murray@arm.com>
---
V10:
 - No change

 MAINTAINERS                                   |   2 +-
 drivers/pci/controller/Kconfig                |  11 +-
 drivers/pci/controller/Makefile               |   2 +-
 drivers/pci/controller/mobiveil/Kconfig       |  24 ++
 drivers/pci/controller/mobiveil/Makefile      |   4 +
 .../pcie-mobiveil-host.c}                     | 401 +-----------------
 .../controller/mobiveil/pcie-mobiveil-plat.c  |  61 +++
 .../pci/controller/mobiveil/pcie-mobiveil.c   | 227 ++++++++++
 .../pci/controller/mobiveil/pcie-mobiveil.h   | 178 ++++++++
 9 files changed, 499 insertions(+), 411 deletions(-)
 create mode 100644 drivers/pci/controller/mobiveil/Kconfig
 create mode 100644 drivers/pci/controller/mobiveil/Makefile
 rename drivers/pci/controller/{pcie-mobiveil.c => mobiveil/pcie-mobiveil-host.c} (61%)
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.c
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.h

diff --git a/MAINTAINERS b/MAINTAINERS
index b8c01ad52bd3..60b4c93914cb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12815,7 +12815,7 @@ M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
-F:	drivers/pci/controller/pcie-mobiveil.c
+F:	drivers/pci/controller/mobiveil/pcie-mobiveil*
 
 PCI DRIVER FOR MVEBU (Marvell Armada 370 and Armada XP SOC support)
 M:	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 20bf00f587bd..91bfdb784829 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -213,16 +213,6 @@ config PCIE_MEDIATEK
 	  Say Y here if you want to enable PCIe controller support on
 	  MediaTek SoCs.
 
-config PCIE_MOBIVEIL
-	bool "Mobiveil AXI PCIe controller"
-	depends on ARCH_ZYNQMP || COMPILE_TEST
-	depends on OF
-	depends on PCI_MSI_IRQ_DOMAIN
-	help
-	  Say Y here if you want to enable support for the Mobiveil AXI PCIe
-	  Soft IP. It has up to 8 outbound and inbound windows
-	  for address translation and it is a PCIe Gen4 IP.
-
 config PCIE_TANGO_SMP8759
 	bool "Tango SMP8759 PCIe controller (DANGEROUS)"
 	depends on ARCH_TANGO && PCI_MSI && OF
@@ -269,5 +259,6 @@ config PCI_HYPERV_INTERFACE
 	  have a common interface with the Hyper-V PCI frontend driver.
 
 source "drivers/pci/controller/dwc/Kconfig"
+source "drivers/pci/controller/mobiveil/Kconfig"
 source "drivers/pci/controller/cadence/Kconfig"
 endmenu
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index 01b2502a5323..158c59771824 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -25,12 +25,12 @@ obj-$(CONFIG_PCIE_ROCKCHIP) += pcie-rockchip.o
 obj-$(CONFIG_PCIE_ROCKCHIP_EP) += pcie-rockchip-ep.o
 obj-$(CONFIG_PCIE_ROCKCHIP_HOST) += pcie-rockchip-host.o
 obj-$(CONFIG_PCIE_MEDIATEK) += pcie-mediatek.o
-obj-$(CONFIG_PCIE_MOBIVEIL) += pcie-mobiveil.o
 obj-$(CONFIG_PCIE_TANGO_SMP8759) += pcie-tango.o
 obj-$(CONFIG_VMD) += vmd.o
 obj-$(CONFIG_PCIE_BRCMSTB) += pcie-brcmstb.o
 # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
 obj-y				+= dwc/
+obj-y				+= mobiveil/
 
 
 # The following drivers are for devices that use the generic ACPI
diff --git a/drivers/pci/controller/mobiveil/Kconfig b/drivers/pci/controller/mobiveil/Kconfig
new file mode 100644
index 000000000000..54161d4ddb11
--- /dev/null
+++ b/drivers/pci/controller/mobiveil/Kconfig
@@ -0,0 +1,24 @@
+# SPDX-License-Identifier: GPL-2.0
+
+menu "Mobiveil PCIe Core Support"
+	depends on PCI
+
+config PCIE_MOBIVEIL
+	bool
+
+config PCIE_MOBIVEIL_HOST
+	bool
+	depends on PCI_MSI_IRQ_DOMAIN
+	select PCIE_MOBIVEIL
+
+config PCIE_MOBIVEIL_PLAT
+	bool "Mobiveil AXI PCIe controller"
+	depends on ARCH_ZYNQMP || COMPILE_TEST
+	depends on OF
+	select PCIE_MOBIVEIL_HOST
+	help
+	  Say Y here if you want to enable support for the Mobiveil AXI PCIe
+	  Soft IP. It has up to 8 outbound and inbound windows
+	  for address translation and it is a PCIe Gen4 IP.
+
+endmenu
diff --git a/drivers/pci/controller/mobiveil/Makefile b/drivers/pci/controller/mobiveil/Makefile
new file mode 100644
index 000000000000..9fb6d1c6504d
--- /dev/null
+++ b/drivers/pci/controller/mobiveil/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PCIE_MOBIVEIL) += pcie-mobiveil.o
+obj-$(CONFIG_PCIE_MOBIVEIL_HOST) += pcie-mobiveil-host.o
+obj-$(CONFIG_PCIE_MOBIVEIL_PLAT) += pcie-mobiveil-plat.o
diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
similarity index 61%
rename from drivers/pci/controller/pcie-mobiveil.c
rename to drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index 9449528bb14f..ea90d2f8692e 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -9,7 +9,6 @@
  *	   Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
  */
 
-#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -26,265 +25,7 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
 
-#include "../pci.h"
-
-/* register offsets and bit positions */
-
-/*
- * translation tables are grouped into windows, each window registers are
- * grouped into blocks of 4 or 16 registers each
- */
-#define PAB_REG_BLOCK_SIZE		16
-#define PAB_EXT_REG_BLOCK_SIZE		4
-
-#define PAB_REG_ADDR(offset, win)	\
-	(offset + (win * PAB_REG_BLOCK_SIZE))
-#define PAB_EXT_REG_ADDR(offset, win)	\
-	(offset + (win * PAB_EXT_REG_BLOCK_SIZE))
-
-#define LTSSM_STATUS			0x0404
-#define  LTSSM_STATUS_L0_MASK		0x3f
-#define  LTSSM_STATUS_L0		0x2d
-
-#define PAB_CTRL			0x0808
-#define  AMBA_PIO_ENABLE_SHIFT		0
-#define  PEX_PIO_ENABLE_SHIFT		1
-#define  PAGE_SEL_SHIFT			13
-#define  PAGE_SEL_MASK			0x3f
-#define  PAGE_LO_MASK			0x3ff
-#define  PAGE_SEL_OFFSET_SHIFT		10
-
-#define PAB_AXI_PIO_CTRL		0x0840
-#define  APIO_EN_MASK			0xf
-
-#define PAB_PEX_PIO_CTRL		0x08c0
-#define  PIO_ENABLE_SHIFT		0
-
-#define PAB_INTP_AMBA_MISC_ENB		0x0b0c
-#define PAB_INTP_AMBA_MISC_STAT		0x0b1c
-#define  PAB_INTP_INTX_MASK		0x01e0
-#define  PAB_INTP_MSI_MASK		0x8
-
-#define PAB_AXI_AMAP_CTRL(win)		PAB_REG_ADDR(0x0ba0, win)
-#define  WIN_ENABLE_SHIFT		0
-#define  WIN_TYPE_SHIFT			1
-#define  WIN_TYPE_MASK			0x3
-#define  WIN_SIZE_MASK			0xfffffc00
-
-#define PAB_EXT_AXI_AMAP_SIZE(win)	PAB_EXT_REG_ADDR(0xbaf0, win)
-
-#define PAB_EXT_AXI_AMAP_AXI_WIN(win)	PAB_EXT_REG_ADDR(0x80a0, win)
-#define PAB_AXI_AMAP_AXI_WIN(win)	PAB_REG_ADDR(0x0ba4, win)
-#define  AXI_WINDOW_ALIGN_MASK		3
-
-#define PAB_AXI_AMAP_PEX_WIN_L(win)	PAB_REG_ADDR(0x0ba8, win)
-#define  PAB_BUS_SHIFT			24
-#define  PAB_DEVICE_SHIFT		19
-#define  PAB_FUNCTION_SHIFT		16
-
-#define PAB_AXI_AMAP_PEX_WIN_H(win)	PAB_REG_ADDR(0x0bac, win)
-#define PAB_INTP_AXI_PIO_CLASS		0x474
-
-#define PAB_PEX_AMAP_CTRL(win)		PAB_REG_ADDR(0x4ba0, win)
-#define  AMAP_CTRL_EN_SHIFT		0
-#define  AMAP_CTRL_TYPE_SHIFT		1
-#define  AMAP_CTRL_TYPE_MASK		3
-
-#define PAB_EXT_PEX_AMAP_SIZEN(win)	PAB_EXT_REG_ADDR(0xbef0, win)
-#define PAB_EXT_PEX_AMAP_AXI_WIN(win)	PAB_EXT_REG_ADDR(0xb4a0, win)
-#define PAB_PEX_AMAP_AXI_WIN(win)	PAB_REG_ADDR(0x4ba4, win)
-#define PAB_PEX_AMAP_PEX_WIN_L(win)	PAB_REG_ADDR(0x4ba8, win)
-#define PAB_PEX_AMAP_PEX_WIN_H(win)	PAB_REG_ADDR(0x4bac, win)
-
-/* starting offset of INTX bits in status register */
-#define PAB_INTX_START			5
-
-/* supported number of MSI interrupts */
-#define PCI_NUM_MSI			16
-
-/* MSI registers */
-#define MSI_BASE_LO_OFFSET		0x04
-#define MSI_BASE_HI_OFFSET		0x08
-#define MSI_SIZE_OFFSET			0x0c
-#define MSI_ENABLE_OFFSET		0x14
-#define MSI_STATUS_OFFSET		0x18
-#define MSI_DATA_OFFSET			0x20
-#define MSI_ADDR_L_OFFSET		0x24
-#define MSI_ADDR_H_OFFSET		0x28
-
-/* outbound and inbound window definitions */
-#define WIN_NUM_0			0
-#define WIN_NUM_1			1
-#define CFG_WINDOW_TYPE			0
-#define IO_WINDOW_TYPE			1
-#define MEM_WINDOW_TYPE			2
-#define IB_WIN_SIZE			((u64)256 * 1024 * 1024 * 1024)
-#define MAX_PIO_WINDOWS			8
-
-/* Parameters for the waiting for link up routine */
-#define LINK_WAIT_MAX_RETRIES		10
-#define LINK_WAIT_MIN			90000
-#define LINK_WAIT_MAX			100000
-
-#define PAGED_ADDR_BNDRY		0xc00
-#define OFFSET_TO_PAGE_ADDR(off)	\
-	((off & PAGE_LO_MASK) | PAGED_ADDR_BNDRY)
-#define OFFSET_TO_PAGE_IDX(off)		\
-	((off >> PAGE_SEL_OFFSET_SHIFT) & PAGE_SEL_MASK)
-
-struct mobiveil_msi {			/* MSI information */
-	struct mutex lock;		/* protect bitmap variable */
-	struct irq_domain *msi_domain;
-	struct irq_domain *dev_domain;
-	phys_addr_t msi_pages_phys;
-	int num_of_vectors;
-	DECLARE_BITMAP(msi_irq_in_use, PCI_NUM_MSI);
-};
-
-struct mobiveil_root_port {
-	char root_bus_nr;
-	void __iomem *config_axi_slave_base;	/* endpoint config base */
-	struct resource *ob_io_res;
-	int irq;
-	raw_spinlock_t intx_mask_lock;
-	struct irq_domain *intx_domain;
-	struct mobiveil_msi msi;
-	struct pci_host_bridge *bridge;
-};
-
-struct mobiveil_pcie {
-	struct platform_device *pdev;
-	void __iomem *csr_axi_slave_base;	/* root port config base */
-	void __iomem *apb_csr_base;	/* MSI register base */
-	phys_addr_t pcie_reg_base;	/* Physical PCIe Controller Base */
-	int apio_wins;
-	int ppio_wins;
-	int ob_wins_configured;		/* configured outbound windows */
-	int ib_wins_configured;		/* configured inbound windows */
-	struct mobiveil_root_port rp;
-};
-
-/*
- * mobiveil_pcie_sel_page - routine to access paged register
- *
- * Registers whose address greater than PAGED_ADDR_BNDRY (0xc00) are paged,
- * for this scheme to work extracted higher 6 bits of the offset will be
- * written to pg_sel field of PAB_CTRL register and rest of the lower 10
- * bits enabled with PAGED_ADDR_BNDRY are used as offset of the register.
- */
-static void mobiveil_pcie_sel_page(struct mobiveil_pcie *pcie, u8 pg_idx)
-{
-	u32 val;
-
-	val = readl(pcie->csr_axi_slave_base + PAB_CTRL);
-	val &= ~(PAGE_SEL_MASK << PAGE_SEL_SHIFT);
-	val |= (pg_idx & PAGE_SEL_MASK) << PAGE_SEL_SHIFT;
-
-	writel(val, pcie->csr_axi_slave_base + PAB_CTRL);
-}
-
-static void *mobiveil_pcie_comp_addr(struct mobiveil_pcie *pcie, u32 off)
-{
-	if (off < PAGED_ADDR_BNDRY) {
-		/* For directly accessed registers, clear the pg_sel field */
-		mobiveil_pcie_sel_page(pcie, 0);
-		return pcie->csr_axi_slave_base + off;
-	}
-
-	mobiveil_pcie_sel_page(pcie, OFFSET_TO_PAGE_IDX(off));
-	return pcie->csr_axi_slave_base + OFFSET_TO_PAGE_ADDR(off);
-}
-
-static int mobiveil_pcie_read(void __iomem *addr, int size, u32 *val)
-{
-	if ((uintptr_t)addr & (size - 1)) {
-		*val = 0;
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-	}
-
-	switch (size) {
-	case 4:
-		*val = readl(addr);
-		break;
-	case 2:
-		*val = readw(addr);
-		break;
-	case 1:
-		*val = readb(addr);
-		break;
-	default:
-		*val = 0;
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-	}
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static int mobiveil_pcie_write(void __iomem *addr, int size, u32 val)
-{
-	if ((uintptr_t)addr & (size - 1))
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-
-	switch (size) {
-	case 4:
-		writel(val, addr);
-		break;
-	case 2:
-		writew(val, addr);
-		break;
-	case 1:
-		writeb(val, addr);
-		break;
-	default:
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-	}
-
-	return PCIBIOS_SUCCESSFUL;
-}
-
-static u32 mobiveil_csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
-{
-	void *addr;
-	u32 val;
-	int ret;
-
-	addr = mobiveil_pcie_comp_addr(pcie, off);
-
-	ret = mobiveil_pcie_read(addr, size, &val);
-	if (ret)
-		dev_err(&pcie->pdev->dev, "read CSR address failed\n");
-
-	return val;
-}
-
-static void mobiveil_csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off,
-			       size_t size)
-{
-	void *addr;
-	int ret;
-
-	addr = mobiveil_pcie_comp_addr(pcie, off);
-
-	ret = mobiveil_pcie_write(addr, size, val);
-	if (ret)
-		dev_err(&pcie->pdev->dev, "write CSR address failed\n");
-}
-
-static u32 mobiveil_csr_readl(struct mobiveil_pcie *pcie, u32 off)
-{
-	return mobiveil_csr_read(pcie, off, 0x4);
-}
-
-static void mobiveil_csr_writel(struct mobiveil_pcie *pcie, u32 val, u32 off)
-{
-	mobiveil_csr_write(pcie, val, off, 0x4);
-}
-
-static bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie)
-{
-	return (mobiveil_csr_readl(pcie, LTSSM_STATUS) &
-		LTSSM_STATUS_L0_MASK) == LTSSM_STATUS_L0;
-}
+#include "pcie-mobiveil.h"
 
 static bool mobiveil_pcie_valid_device(struct pci_bus *bus, unsigned int devfn)
 {
@@ -464,103 +205,6 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
 	return 0;
 }
 
-static void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
-			       u64 cpu_addr, u64 pci_addr, u32 type, u64 size)
-{
-	u32 value;
-	u64 size64 = ~(size - 1);
-
-	if (win_num >= pcie->ppio_wins) {
-		dev_err(&pcie->pdev->dev,
-			"ERROR: max inbound windows reached !\n");
-		return;
-	}
-
-	value = mobiveil_csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
-	value &= ~(AMAP_CTRL_TYPE_MASK << AMAP_CTRL_TYPE_SHIFT | WIN_SIZE_MASK);
-	value |= type << AMAP_CTRL_TYPE_SHIFT | 1 << AMAP_CTRL_EN_SHIFT |
-		 (lower_32_bits(size64) & WIN_SIZE_MASK);
-	mobiveil_csr_writel(pcie, value, PAB_PEX_AMAP_CTRL(win_num));
-
-	mobiveil_csr_writel(pcie, upper_32_bits(size64),
-			    PAB_EXT_PEX_AMAP_SIZEN(win_num));
-
-	mobiveil_csr_writel(pcie, lower_32_bits(cpu_addr),
-			    PAB_PEX_AMAP_AXI_WIN(win_num));
-	mobiveil_csr_writel(pcie, upper_32_bits(cpu_addr),
-			    PAB_EXT_PEX_AMAP_AXI_WIN(win_num));
-
-	mobiveil_csr_writel(pcie, lower_32_bits(pci_addr),
-			    PAB_PEX_AMAP_PEX_WIN_L(win_num));
-	mobiveil_csr_writel(pcie, upper_32_bits(pci_addr),
-			    PAB_PEX_AMAP_PEX_WIN_H(win_num));
-
-	pcie->ib_wins_configured++;
-}
-
-/*
- * routine to program the outbound windows
- */
-static void program_ob_windows(struct mobiveil_pcie *pcie, int win_num,
-			       u64 cpu_addr, u64 pci_addr, u32 type, u64 size)
-{
-	u32 value;
-	u64 size64 = ~(size - 1);
-
-	if (win_num >= pcie->apio_wins) {
-		dev_err(&pcie->pdev->dev,
-			"ERROR: max outbound windows reached !\n");
-		return;
-	}
-
-	/*
-	 * program Enable Bit to 1, Type Bit to (00) base 2, AXI Window Size Bit
-	 * to 4 KB in PAB_AXI_AMAP_CTRL register
-	 */
-	value = mobiveil_csr_readl(pcie, PAB_AXI_AMAP_CTRL(win_num));
-	value &= ~(WIN_TYPE_MASK << WIN_TYPE_SHIFT | WIN_SIZE_MASK);
-	value |= 1 << WIN_ENABLE_SHIFT | type << WIN_TYPE_SHIFT |
-		 (lower_32_bits(size64) & WIN_SIZE_MASK);
-	mobiveil_csr_writel(pcie, value, PAB_AXI_AMAP_CTRL(win_num));
-
-	mobiveil_csr_writel(pcie, upper_32_bits(size64),
-			    PAB_EXT_AXI_AMAP_SIZE(win_num));
-
-	/*
-	 * program AXI window base with appropriate value in
-	 * PAB_AXI_AMAP_AXI_WIN0 register
-	 */
-	mobiveil_csr_writel(pcie,
-			    lower_32_bits(cpu_addr) & (~AXI_WINDOW_ALIGN_MASK),
-			    PAB_AXI_AMAP_AXI_WIN(win_num));
-	mobiveil_csr_writel(pcie, upper_32_bits(cpu_addr),
-			    PAB_EXT_AXI_AMAP_AXI_WIN(win_num));
-
-	mobiveil_csr_writel(pcie, lower_32_bits(pci_addr),
-			    PAB_AXI_AMAP_PEX_WIN_L(win_num));
-	mobiveil_csr_writel(pcie, upper_32_bits(pci_addr),
-			    PAB_AXI_AMAP_PEX_WIN_H(win_num));
-
-	pcie->ob_wins_configured++;
-}
-
-static int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
-{
-	int retries;
-
-	/* check if the link is up or not */
-	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
-		if (mobiveil_pcie_link_up(pcie))
-			return 0;
-
-		usleep_range(LINK_WAIT_MIN, LINK_WAIT_MAX);
-	}
-
-	dev_err(&pcie->pdev->dev, "link never came up\n");
-
-	return -ETIMEDOUT;
-}
-
 static void mobiveil_pcie_enable_msi(struct mobiveil_pcie *pcie)
 {
 	phys_addr_t msg_addr = pcie->pcie_reg_base;
@@ -895,7 +539,7 @@ static int mobiveil_pcie_interrupt_init(struct mobiveil_pcie *pcie)
 	return 0;
 }
 
-static int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
+int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
 {
 	struct mobiveil_root_port *rp = &pcie->rp;
 	struct pci_host_bridge *bridge = rp->bridge;
@@ -962,44 +606,3 @@ static int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
 
 	return 0;
 }
-
-static int mobiveil_pcie_probe(struct platform_device *pdev)
-{
-	struct mobiveil_pcie *pcie;
-	struct pci_host_bridge *bridge;
-	struct device *dev = &pdev->dev;
-
-	/* allocate the PCIe port */
-	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
-	if (!bridge)
-		return -ENOMEM;
-
-	pcie = pci_host_bridge_priv(bridge);
-	pcie->rp.bridge = bridge;
-
-	pcie->pdev = pdev;
-
-	return mobiveil_pcie_host_probe(pcie);
-}
-
-static const struct of_device_id mobiveil_pcie_of_match[] = {
-	{.compatible = "mbvl,gpex40-pcie",},
-	{},
-};
-
-MODULE_DEVICE_TABLE(of, mobiveil_pcie_of_match);
-
-static struct platform_driver mobiveil_pcie_driver = {
-	.probe = mobiveil_pcie_probe,
-	.driver = {
-		.name = "mobiveil-pcie",
-		.of_match_table = mobiveil_pcie_of_match,
-		.suppress_bind_attrs = true,
-	},
-};
-
-builtin_platform_driver(mobiveil_pcie_driver);
-
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("Mobiveil PCIe host controller driver");
-MODULE_AUTHOR("Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>");
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
new file mode 100644
index 000000000000..f6ede66783e7
--- /dev/null
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe host controller driver for Mobiveil PCIe Host controller
+ *
+ * Copyright (c) 2018 Mobiveil Inc.
+ * Copyright 2019 NXP
+ *
+ * Author: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
+ *	   Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_pci.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "pcie-mobiveil.h"
+
+static int mobiveil_pcie_probe(struct platform_device *pdev)
+{
+	struct mobiveil_pcie *pcie;
+	struct pci_host_bridge *bridge;
+	struct device *dev = &pdev->dev;
+
+	/* allocate the PCIe port */
+	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
+	if (!bridge)
+		return -ENOMEM;
+
+	pcie = pci_host_bridge_priv(bridge);
+	pcie->rp.bridge = bridge;
+
+	pcie->pdev = pdev;
+
+	return mobiveil_pcie_host_probe(pcie);
+}
+
+static const struct of_device_id mobiveil_pcie_of_match[] = {
+	{.compatible = "mbvl,gpex40-pcie",},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, mobiveil_pcie_of_match);
+
+static struct platform_driver mobiveil_pcie_driver = {
+	.probe = mobiveil_pcie_probe,
+	.driver = {
+		.name = "mobiveil-pcie",
+		.of_match_table = mobiveil_pcie_of_match,
+		.suppress_bind_attrs = true,
+	},
+};
+
+builtin_platform_driver(mobiveil_pcie_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Mobiveil PCIe host controller driver");
+MODULE_AUTHOR("Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>");
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.c b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
new file mode 100644
index 000000000000..2773f823c9ea
--- /dev/null
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.c
@@ -0,0 +1,227 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe host controller driver for Mobiveil PCIe Host controller
+ *
+ * Copyright (c) 2018 Mobiveil Inc.
+ * Copyright 2019 NXP
+ *
+ * Author: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
+ *	   Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
+ */
+
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+
+#include "pcie-mobiveil.h"
+
+/*
+ * mobiveil_pcie_sel_page - routine to access paged register
+ *
+ * Registers whose address greater than PAGED_ADDR_BNDRY (0xc00) are paged,
+ * for this scheme to work extracted higher 6 bits of the offset will be
+ * written to pg_sel field of PAB_CTRL register and rest of the lower 10
+ * bits enabled with PAGED_ADDR_BNDRY are used as offset of the register.
+ */
+static void mobiveil_pcie_sel_page(struct mobiveil_pcie *pcie, u8 pg_idx)
+{
+	u32 val;
+
+	val = readl(pcie->csr_axi_slave_base + PAB_CTRL);
+	val &= ~(PAGE_SEL_MASK << PAGE_SEL_SHIFT);
+	val |= (pg_idx & PAGE_SEL_MASK) << PAGE_SEL_SHIFT;
+
+	writel(val, pcie->csr_axi_slave_base + PAB_CTRL);
+}
+
+static void *mobiveil_pcie_comp_addr(struct mobiveil_pcie *pcie, u32 off)
+{
+	if (off < PAGED_ADDR_BNDRY) {
+		/* For directly accessed registers, clear the pg_sel field */
+		mobiveil_pcie_sel_page(pcie, 0);
+		return pcie->csr_axi_slave_base + off;
+	}
+
+	mobiveil_pcie_sel_page(pcie, OFFSET_TO_PAGE_IDX(off));
+	return pcie->csr_axi_slave_base + OFFSET_TO_PAGE_ADDR(off);
+}
+
+static int mobiveil_pcie_read(void __iomem *addr, int size, u32 *val)
+{
+	if ((uintptr_t)addr & (size - 1)) {
+		*val = 0;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+
+	switch (size) {
+	case 4:
+		*val = readl(addr);
+		break;
+	case 2:
+		*val = readw(addr);
+		break;
+	case 1:
+		*val = readb(addr);
+		break;
+	default:
+		*val = 0;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+static int mobiveil_pcie_write(void __iomem *addr, int size, u32 val)
+{
+	if ((uintptr_t)addr & (size - 1))
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+
+	switch (size) {
+	case 4:
+		writel(val, addr);
+		break;
+	case 2:
+		writew(val, addr);
+		break;
+	case 1:
+		writeb(val, addr);
+		break;
+	default:
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+
+	return PCIBIOS_SUCCESSFUL;
+}
+
+u32 mobiveil_csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
+{
+	void *addr;
+	u32 val;
+	int ret;
+
+	addr = mobiveil_pcie_comp_addr(pcie, off);
+
+	ret = mobiveil_pcie_read(addr, size, &val);
+	if (ret)
+		dev_err(&pcie->pdev->dev, "read CSR address failed\n");
+
+	return val;
+}
+
+void mobiveil_csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off,
+			       size_t size)
+{
+	void *addr;
+	int ret;
+
+	addr = mobiveil_pcie_comp_addr(pcie, off);
+
+	ret = mobiveil_pcie_write(addr, size, val);
+	if (ret)
+		dev_err(&pcie->pdev->dev, "write CSR address failed\n");
+}
+
+bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie)
+{
+	return (mobiveil_csr_readl(pcie, LTSSM_STATUS) &
+		LTSSM_STATUS_L0_MASK) == LTSSM_STATUS_L0;
+}
+
+void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
+			u64 cpu_addr, u64 pci_addr, u32 type, u64 size)
+{
+	u32 value;
+	u64 size64 = ~(size - 1);
+
+	if (win_num >= pcie->ppio_wins) {
+		dev_err(&pcie->pdev->dev,
+			"ERROR: max inbound windows reached !\n");
+		return;
+	}
+
+	value = mobiveil_csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
+	value &= ~(AMAP_CTRL_TYPE_MASK << AMAP_CTRL_TYPE_SHIFT | WIN_SIZE_MASK);
+	value |= type << AMAP_CTRL_TYPE_SHIFT | 1 << AMAP_CTRL_EN_SHIFT |
+		 (lower_32_bits(size64) & WIN_SIZE_MASK);
+	mobiveil_csr_writel(pcie, value, PAB_PEX_AMAP_CTRL(win_num));
+
+	mobiveil_csr_writel(pcie, upper_32_bits(size64),
+			    PAB_EXT_PEX_AMAP_SIZEN(win_num));
+
+	mobiveil_csr_writel(pcie, lower_32_bits(cpu_addr),
+			    PAB_PEX_AMAP_AXI_WIN(win_num));
+	mobiveil_csr_writel(pcie, upper_32_bits(cpu_addr),
+			    PAB_EXT_PEX_AMAP_AXI_WIN(win_num));
+
+	mobiveil_csr_writel(pcie, lower_32_bits(pci_addr),
+			    PAB_PEX_AMAP_PEX_WIN_L(win_num));
+	mobiveil_csr_writel(pcie, upper_32_bits(pci_addr),
+			    PAB_PEX_AMAP_PEX_WIN_H(win_num));
+
+	pcie->ib_wins_configured++;
+}
+
+/*
+ * routine to program the outbound windows
+ */
+void program_ob_windows(struct mobiveil_pcie *pcie, int win_num,
+			u64 cpu_addr, u64 pci_addr, u32 type, u64 size)
+{
+	u32 value;
+	u64 size64 = ~(size - 1);
+
+	if (win_num >= pcie->apio_wins) {
+		dev_err(&pcie->pdev->dev,
+			"ERROR: max outbound windows reached !\n");
+		return;
+	}
+
+	/*
+	 * program Enable Bit to 1, Type Bit to (00) base 2, AXI Window Size Bit
+	 * to 4 KB in PAB_AXI_AMAP_CTRL register
+	 */
+	value = mobiveil_csr_readl(pcie, PAB_AXI_AMAP_CTRL(win_num));
+	value &= ~(WIN_TYPE_MASK << WIN_TYPE_SHIFT | WIN_SIZE_MASK);
+	value |= 1 << WIN_ENABLE_SHIFT | type << WIN_TYPE_SHIFT |
+		 (lower_32_bits(size64) & WIN_SIZE_MASK);
+	mobiveil_csr_writel(pcie, value, PAB_AXI_AMAP_CTRL(win_num));
+
+	mobiveil_csr_writel(pcie, upper_32_bits(size64),
+			    PAB_EXT_AXI_AMAP_SIZE(win_num));
+
+	/*
+	 * program AXI window base with appropriate value in
+	 * PAB_AXI_AMAP_AXI_WIN0 register
+	 */
+	mobiveil_csr_writel(pcie,
+			    lower_32_bits(cpu_addr) & (~AXI_WINDOW_ALIGN_MASK),
+			    PAB_AXI_AMAP_AXI_WIN(win_num));
+	mobiveil_csr_writel(pcie, upper_32_bits(cpu_addr),
+			    PAB_EXT_AXI_AMAP_AXI_WIN(win_num));
+
+	mobiveil_csr_writel(pcie, lower_32_bits(pci_addr),
+			    PAB_AXI_AMAP_PEX_WIN_L(win_num));
+	mobiveil_csr_writel(pcie, upper_32_bits(pci_addr),
+			    PAB_AXI_AMAP_PEX_WIN_H(win_num));
+
+	pcie->ob_wins_configured++;
+}
+
+int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
+{
+	int retries;
+
+	/* check if the link is up or not */
+	for (retries = 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
+		if (mobiveil_pcie_link_up(pcie))
+			return 0;
+
+		usleep_range(LINK_WAIT_MIN, LINK_WAIT_MAX);
+	}
+
+	dev_err(&pcie->pdev->dev, "link never came up\n");
+
+	return -ETIMEDOUT;
+}
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
new file mode 100644
index 000000000000..81ffbbd48c08
--- /dev/null
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -0,0 +1,178 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PCIe host controller driver for Mobiveil PCIe Host controller
+ *
+ * Copyright (c) 2018 Mobiveil Inc.
+ * Copyright 2019 NXP
+ *
+ * Author: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
+ *	   Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
+ */
+
+#ifndef _PCIE_MOBIVEIL_H
+#define _PCIE_MOBIVEIL_H
+
+#include <linux/pci.h>
+#include <linux/irq.h>
+#include <linux/msi.h>
+#include "../../pci.h"
+
+/* register offsets and bit positions */
+
+/*
+ * translation tables are grouped into windows, each window registers are
+ * grouped into blocks of 4 or 16 registers each
+ */
+#define PAB_REG_BLOCK_SIZE		16
+#define PAB_EXT_REG_BLOCK_SIZE		4
+
+#define PAB_REG_ADDR(offset, win)	\
+	(offset + (win * PAB_REG_BLOCK_SIZE))
+#define PAB_EXT_REG_ADDR(offset, win)	\
+	(offset + (win * PAB_EXT_REG_BLOCK_SIZE))
+
+#define LTSSM_STATUS			0x0404
+#define  LTSSM_STATUS_L0_MASK		0x3f
+#define  LTSSM_STATUS_L0		0x2d
+
+#define PAB_CTRL			0x0808
+#define  AMBA_PIO_ENABLE_SHIFT		0
+#define  PEX_PIO_ENABLE_SHIFT		1
+#define  PAGE_SEL_SHIFT			13
+#define  PAGE_SEL_MASK			0x3f
+#define  PAGE_LO_MASK			0x3ff
+#define  PAGE_SEL_OFFSET_SHIFT		10
+
+#define PAB_AXI_PIO_CTRL		0x0840
+#define  APIO_EN_MASK			0xf
+
+#define PAB_PEX_PIO_CTRL		0x08c0
+#define  PIO_ENABLE_SHIFT		0
+
+#define PAB_INTP_AMBA_MISC_ENB		0x0b0c
+#define PAB_INTP_AMBA_MISC_STAT		0x0b1c
+#define  PAB_INTP_INTX_MASK		0x01e0
+#define  PAB_INTP_MSI_MASK		0x8
+
+#define PAB_AXI_AMAP_CTRL(win)		PAB_REG_ADDR(0x0ba0, win)
+#define  WIN_ENABLE_SHIFT		0
+#define  WIN_TYPE_SHIFT			1
+#define  WIN_TYPE_MASK			0x3
+#define  WIN_SIZE_MASK			0xfffffc00
+
+#define PAB_EXT_AXI_AMAP_SIZE(win)	PAB_EXT_REG_ADDR(0xbaf0, win)
+
+#define PAB_EXT_AXI_AMAP_AXI_WIN(win)	PAB_EXT_REG_ADDR(0x80a0, win)
+#define PAB_AXI_AMAP_AXI_WIN(win)	PAB_REG_ADDR(0x0ba4, win)
+#define  AXI_WINDOW_ALIGN_MASK		3
+
+#define PAB_AXI_AMAP_PEX_WIN_L(win)	PAB_REG_ADDR(0x0ba8, win)
+#define  PAB_BUS_SHIFT			24
+#define  PAB_DEVICE_SHIFT		19
+#define  PAB_FUNCTION_SHIFT		16
+
+#define PAB_AXI_AMAP_PEX_WIN_H(win)	PAB_REG_ADDR(0x0bac, win)
+#define PAB_INTP_AXI_PIO_CLASS		0x474
+
+#define PAB_PEX_AMAP_CTRL(win)		PAB_REG_ADDR(0x4ba0, win)
+#define  AMAP_CTRL_EN_SHIFT		0
+#define  AMAP_CTRL_TYPE_SHIFT		1
+#define  AMAP_CTRL_TYPE_MASK		3
+
+#define PAB_EXT_PEX_AMAP_SIZEN(win)	PAB_EXT_REG_ADDR(0xbef0, win)
+#define PAB_EXT_PEX_AMAP_AXI_WIN(win)	PAB_EXT_REG_ADDR(0xb4a0, win)
+#define PAB_PEX_AMAP_AXI_WIN(win)	PAB_REG_ADDR(0x4ba4, win)
+#define PAB_PEX_AMAP_PEX_WIN_L(win)	PAB_REG_ADDR(0x4ba8, win)
+#define PAB_PEX_AMAP_PEX_WIN_H(win)	PAB_REG_ADDR(0x4bac, win)
+
+/* starting offset of INTX bits in status register */
+#define PAB_INTX_START			5
+
+/* supported number of MSI interrupts */
+#define PCI_NUM_MSI			16
+
+/* MSI registers */
+#define MSI_BASE_LO_OFFSET		0x04
+#define MSI_BASE_HI_OFFSET		0x08
+#define MSI_SIZE_OFFSET			0x0c
+#define MSI_ENABLE_OFFSET		0x14
+#define MSI_STATUS_OFFSET		0x18
+#define MSI_DATA_OFFSET			0x20
+#define MSI_ADDR_L_OFFSET		0x24
+#define MSI_ADDR_H_OFFSET		0x28
+
+/* outbound and inbound window definitions */
+#define WIN_NUM_0			0
+#define WIN_NUM_1			1
+#define CFG_WINDOW_TYPE			0
+#define IO_WINDOW_TYPE			1
+#define MEM_WINDOW_TYPE			2
+#define IB_WIN_SIZE			((u64)256 * 1024 * 1024 * 1024)
+#define MAX_PIO_WINDOWS			8
+
+/* Parameters for the waiting for link up routine */
+#define LINK_WAIT_MAX_RETRIES		10
+#define LINK_WAIT_MIN			90000
+#define LINK_WAIT_MAX			100000
+
+#define PAGED_ADDR_BNDRY		0xc00
+#define OFFSET_TO_PAGE_ADDR(off)	\
+	((off & PAGE_LO_MASK) | PAGED_ADDR_BNDRY)
+#define OFFSET_TO_PAGE_IDX(off)		\
+	((off >> PAGE_SEL_OFFSET_SHIFT) & PAGE_SEL_MASK)
+
+struct mobiveil_msi {			/* MSI information */
+	struct mutex lock;		/* protect bitmap variable */
+	struct irq_domain *msi_domain;
+	struct irq_domain *dev_domain;
+	phys_addr_t msi_pages_phys;
+	int num_of_vectors;
+	DECLARE_BITMAP(msi_irq_in_use, PCI_NUM_MSI);
+};
+
+struct mobiveil_root_port {
+	char root_bus_nr;
+	void __iomem *config_axi_slave_base;	/* endpoint config base */
+	struct resource *ob_io_res;
+	int irq;
+	raw_spinlock_t intx_mask_lock;
+	struct irq_domain *intx_domain;
+	struct mobiveil_msi msi;
+	struct pci_host_bridge *bridge;
+};
+
+struct mobiveil_pcie {
+	struct platform_device *pdev;
+	void __iomem *csr_axi_slave_base;	/* root port config base */
+	void __iomem *apb_csr_base;	/* MSI register base */
+	phys_addr_t pcie_reg_base;	/* Physical PCIe Controller Base */
+	int apio_wins;
+	int ppio_wins;
+	int ob_wins_configured;		/* configured outbound windows */
+	int ib_wins_configured;		/* configured inbound windows */
+	struct mobiveil_root_port rp;
+};
+
+int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie);
+bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie);
+int mobiveil_bringup_link(struct mobiveil_pcie *pcie);
+void program_ob_windows(struct mobiveil_pcie *pcie, int win_num, u64 cpu_addr,
+			u64 pci_addr, u32 type, u64 size);
+void program_ib_windows(struct mobiveil_pcie *pcie, int win_num, u64 cpu_addr,
+			u64 pci_addr, u32 type, u64 size);
+u32 mobiveil_csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size);
+void mobiveil_csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off,
+			size_t size);
+
+static inline u32 mobiveil_csr_readl(struct mobiveil_pcie *pcie, u32 off)
+{
+	return mobiveil_csr_read(pcie, off, 0x4);
+}
+
+static inline void mobiveil_csr_writel(struct mobiveil_pcie *pcie, u32 val,
+				       u32 off)
+{
+	mobiveil_csr_write(pcie, val, off, 0x4);
+}
+
+#endif /* _PCIE_MOBIVEIL_H */
-- 
2.17.1

