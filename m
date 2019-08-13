Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5E178B63C
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2019 13:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728673AbfHMLEN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Aug 2019 07:04:13 -0400
Received: from mail-eopbgr40049.outbound.protection.outlook.com ([40.107.4.49]:15278
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728647AbfHMLEN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Aug 2019 07:04:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LwmTKTOKctuqZnwKe6imIoMC6eRuvwzXcA3PZGLLYwlkCcuysbGYhEbbDpohEWV+hkiwFbsj6bsXVVAfWUuilgoflbwV6Uupkm41Ps0tb9cji4BQ703quFcpTW3e4JrZtVjlXhP75veW+xUE2Raft04fjhJsBDMwTn1N1u8wIP8Cp8laFjTdYp49f3s10IBpoE6xKoM+Z663eUx9tE/n06e/JAJLD1WUhZAP8BHgqzqQ2LWzeeomyA49OsUZRZwleBeodow37q9xcBmK/fPa2ak3viOXcjAnDB3gFqOf6KLgxnpxmKZZhNs8vdjOE1JlUpsv5RXlt8VnvbQM2zjIDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wt+r6WWPzWr6T2XW3GvLojGxS6ou+OkBM6YvxYPtBSM=;
 b=UUdrd28PvJO48wBwscxHniatVkqAheyhRflZ3Eop1U5NjHFlol28oNej/O89yMi4G9ANFxG7eGJBq3ueg5qF8C0SgeyYEsrMbYIYoxMsrXLyDz8887ZK7UCogDoPp9vY/Qw9OsX7TpysT3oVnqfHrGfTX27rEslq5hGNLsCFgA9eKmVooYFBwCJoZjZNQzZGwXLMOzF634nvc220GRoEE1nrv/HpE05fOPev1UgdCcViis6qhUwzsFk7QsPKO4MIC2YttwvOqn+r78ceW0AFUl/GIF7Ppr2KqC98szOW+qJdjUgp+FRZpdhHd+6QPVta5x+l2gD3IS/n7fQvyxSpSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wt+r6WWPzWr6T2XW3GvLojGxS6ou+OkBM6YvxYPtBSM=;
 b=AvuWz92pDaExcvWIPcfnHZMAkZFAxznTi4QnyHMFaqX/4OmwLxWC3C7Iz3m1KH/XIuRoGFyZjPOt4ePH/uqivQ12cCG+/po4S2sI5r5VrTvXcDNmmE/CHhOFnqnDX6BW6758BaD/eilMT6aicofaIc/ChdkBrLTB9BsXoc4lyas=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB7035.eurprd04.prod.outlook.com (52.135.61.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.13; Tue, 13 Aug 2019 11:03:57 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb%3]) with mapi id 15.20.2157.015; Tue, 13 Aug 2019
 11:03:57 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "m.karthikeyan@mobiveil.co.in" <m.karthikeyan@mobiveil.co.in>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv8 1/7] PCI: mobiveil: Refactor Mobiveil PCIe Host Bridge IP
 driver
Thread-Topic: [PATCHv8 1/7] PCI: mobiveil: Refactor Mobiveil PCIe Host Bridge
 IP driver
Thread-Index: AQHVUcbNo7pBfmx/EUmJCj7T83ofBQ==
Date:   Tue, 13 Aug 2019 11:03:57 +0000
Message-ID: <20190813110557.45643-2-Zhiqiang.Hou@nxp.com>
References: <20190813110557.45643-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20190813110557.45643-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0199.apcprd02.prod.outlook.com
 (2603:1096:201:20::11) To DB8PR04MB6747.eurprd04.prod.outlook.com
 (2603:10a6:10:10b::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5033452-02df-4329-4624-08d71fddf013
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR04MB7035;
x-ms-traffictypediagnostic: DB8PR04MB7035:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB703533B48F2E1F84742DFF1684D20@DB8PR04MB7035.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(136003)(396003)(376002)(346002)(39860400002)(189003)(199004)(14454004)(36756003)(66446008)(5660300002)(76176011)(81156014)(30864003)(6512007)(3846002)(7416002)(25786009)(6116002)(81166006)(102836004)(478600001)(6436002)(2201001)(2616005)(476003)(8676002)(11346002)(8936002)(99286004)(446003)(2906002)(86362001)(66946007)(66556008)(186003)(64756008)(1076003)(53946003)(66066001)(14444005)(50226002)(256004)(4326008)(316002)(53936002)(486006)(2501003)(305945005)(52116002)(54906003)(26005)(6486002)(71190400001)(386003)(6506007)(110136005)(66476007)(7736002)(71200400001)(5024004)(921003)(1121003)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB7035;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QwAV2rxB01zH5HSS8ujKqtM4jBk6hRS/j6oq2UST0igIIi6eKBX91liDe4nt0fH+Sh+uvJbOMDRk8KycnrVcmtwcHSunMnFtf3oDotvr2x/JAn+7MjfenRnDaT5dvVrIKnS3uSys78B2J7qPlIwIYKBqby290WT7QUihuWgC3koRVRT0f+r43VXB+VkvBAtbDIEStTR1kMYRBo+GpE2dqmu1c31beL1dJPuzhab/uCrO/VZgrbCsqf0sdjj798a3VttOT07GYlGif6pLYqx+LL4s/jfDvzgU4b2cowv1IFQ9O3RNxVmaLsbMuyEOUjjp4BbIHkr5cR80ObaQvOAFMyGDlfQUrD7Ua/sic5rjUOFM5wR2kTGv2ufR9PLCuurQIwcDsbJCNRrHTYhlxNgjzcwctqQcLKSNFTLEwDNIw4Y=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5033452-02df-4329-4624-08d71fddf013
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 11:03:57.6870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0AnnWh4TEcAC07PCZeHnBwIZ92qn8X/tRrmzkOc6hYpHWZPiwTSISNLfrA/qOrMZQYzHBbv7ktWyJN7/6pKo+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7035
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Refactor the Mobiveil PCIe Host Bridge IP driver to make
it easier to add support for both RC and EP mode driver.
This patch moved the Mobiveil driver to an new directory
'drivers/pci/controller/mobiveil' and refactor it according
to the RC and EP abstraction.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Reviewed-by: Minghuan Lian <Minghuan.Lian@nxp.com>
Reviewed-by: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
---
V8:
 - Re-generate the patch on the new code base.

 MAINTAINERS                                   |   2 +-
 drivers/pci/controller/Kconfig                |  11 +-
 drivers/pci/controller/Makefile               |   2 +-
 drivers/pci/controller/mobiveil/Kconfig       |  24 +
 drivers/pci/controller/mobiveil/Makefile      |   4 +
 .../pcie-mobiveil-host.c}                     | 525 +++---------------
 .../controller/mobiveil/pcie-mobiveil-plat.c  |  59 ++
 .../pci/controller/mobiveil/pcie-mobiveil.c   | 227 ++++++++
 .../pci/controller/mobiveil/pcie-mobiveil.h   | 189 +++++++
 9 files changed, 592 insertions(+), 451 deletions(-)
 create mode 100644 drivers/pci/controller/mobiveil/Kconfig
 create mode 100644 drivers/pci/controller/mobiveil/Makefile
 rename drivers/pci/controller/{pcie-mobiveil.c =3D> mobiveil/pcie-mobiveil=
-host.c} (54%)
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.c
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.h

diff --git a/MAINTAINERS b/MAINTAINERS
index df85ee4dbdc7..0d88e0d3960b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12367,7 +12367,7 @@ M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/mobiveil-pcie.txt
-F:	drivers/pci/controller/pcie-mobiveil.c
+F:	drivers/pci/controller/mobiveil/pcie-mobiveil*
=20
 PCI DRIVER FOR MVEBU (Marvell Armada 370 and Armada XP SOC support)
 M:	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfi=
g
index fe9f9f13ce11..dec8e038cb17 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -241,16 +241,6 @@ config PCIE_MEDIATEK
 	  Say Y here if you want to enable PCIe controller support on
 	  MediaTek SoCs.
=20
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
@@ -282,4 +272,5 @@ config VMD
 	  module will be called vmd.
=20
 source "drivers/pci/controller/dwc/Kconfig"
+source "drivers/pci/controller/mobiveil/Kconfig"
 endmenu
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makef=
ile
index d56a507495c5..b79a615041a0 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -26,11 +26,11 @@ obj-$(CONFIG_PCIE_ROCKCHIP) +=3D pcie-rockchip.o
 obj-$(CONFIG_PCIE_ROCKCHIP_EP) +=3D pcie-rockchip-ep.o
 obj-$(CONFIG_PCIE_ROCKCHIP_HOST) +=3D pcie-rockchip-host.o
 obj-$(CONFIG_PCIE_MEDIATEK) +=3D pcie-mediatek.o
-obj-$(CONFIG_PCIE_MOBIVEIL) +=3D pcie-mobiveil.o
 obj-$(CONFIG_PCIE_TANGO_SMP8759) +=3D pcie-tango.o
 obj-$(CONFIG_VMD) +=3D vmd.o
 # pcie-hisi.o quirks are needed even without CONFIG_PCIE_DW
 obj-y				+=3D dwc/
+obj-y				+=3D mobiveil/
=20
=20
 # The following drivers are for devices that use the generic ACPI
diff --git a/drivers/pci/controller/mobiveil/Kconfig b/drivers/pci/controll=
er/mobiveil/Kconfig
new file mode 100644
index 000000000000..64343c07bfed
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
+        bool
+	depends on PCI_MSI_IRQ_DOMAIN
+        select PCIE_MOBIVEIL
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
diff --git a/drivers/pci/controller/mobiveil/Makefile b/drivers/pci/control=
ler/mobiveil/Makefile
new file mode 100644
index 000000000000..9fb6d1c6504d
--- /dev/null
+++ b/drivers/pci/controller/mobiveil/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PCIE_MOBIVEIL) +=3D pcie-mobiveil.o
+obj-$(CONFIG_PCIE_MOBIVEIL_HOST) +=3D pcie-mobiveil-host.o
+obj-$(CONFIG_PCIE_MOBIVEIL_PLAT) +=3D pcie-mobiveil-plat.o
diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/mobiveil/pcie-mobiveil-host.c
similarity index 54%
rename from drivers/pci/controller/pcie-mobiveil.c
rename to drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index a45a6447b01d..995487c4f760 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -3,10 +3,12 @@
  * PCIe host controller driver for Mobiveil PCIe Host controller
  *
  * Copyright (c) 2018 Mobiveil Inc.
+ * Copyright 2019 NXP
+ *
  * Author: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
+ * Refactor: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
  */
=20
-#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -23,274 +25,21 @@
 #include <linux/platform_device.h>
 #include <linux/slab.h>
=20
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
-struct mobiveil_pcie {
-	struct platform_device *pdev;
-	struct list_head resources;
-	void __iomem *config_axi_slave_base;	/* endpoint config base */
-	void __iomem *csr_axi_slave_base;	/* root port config base */
-	void __iomem *apb_csr_base;	/* MSI register base */
-	phys_addr_t pcie_reg_base;	/* Physical PCIe Controller Base */
-	struct irq_domain *intx_domain;
-	raw_spinlock_t intx_mask_lock;
-	int irq;
-	int apio_wins;
-	int ppio_wins;
-	int ob_wins_configured;		/* configured outbound windows */
-	int ib_wins_configured;		/* configured inbound windows */
-	struct resource *ob_io_res;
-	char root_bus_nr;
-	struct mobiveil_msi msi;
-};
-
-/*
- * mobiveil_pcie_sel_page - routine to access paged register
- *
- * Registers whose address greater than PAGED_ADDR_BNDRY (0xc00) are paged=
,
- * for this scheme to work extracted higher 6 bits of the offset will be
- * written to pg_sel field of PAB_CTRL register and rest of the lower 10
- * bits enabled with PAGED_ADDR_BNDRY are used as offset of the register.
- */
-static void mobiveil_pcie_sel_page(struct mobiveil_pcie *pcie, u8 pg_idx)
-{
-	u32 val;
-
-	val =3D readl(pcie->csr_axi_slave_base + PAB_CTRL);
-	val &=3D ~(PAGE_SEL_MASK << PAGE_SEL_SHIFT);
-	val |=3D (pg_idx & PAGE_SEL_MASK) << PAGE_SEL_SHIFT;
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
-		*val =3D 0;
-		return PCIBIOS_BAD_REGISTER_NUMBER;
-	}
-
-	switch (size) {
-	case 4:
-		*val =3D readl(addr);
-		break;
-	case 2:
-		*val =3D readw(addr);
-		break;
-	case 1:
-		*val =3D readb(addr);
-		break;
-	default:
-		*val =3D 0;
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
-static u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
-{
-	void *addr;
-	u32 val;
-	int ret;
-
-	addr =3D mobiveil_pcie_comp_addr(pcie, off);
-
-	ret =3D mobiveil_pcie_read(addr, size, &val);
-	if (ret)
-		dev_err(&pcie->pdev->dev, "read CSR address failed\n");
-
-	return val;
-}
-
-static void csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t=
 size)
-{
-	void *addr;
-	int ret;
-
-	addr =3D mobiveil_pcie_comp_addr(pcie, off);
-
-	ret =3D mobiveil_pcie_write(addr, size, val);
-	if (ret)
-		dev_err(&pcie->pdev->dev, "write CSR address failed\n");
-}
-
-static u32 csr_readl(struct mobiveil_pcie *pcie, u32 off)
-{
-	return csr_read(pcie, off, 0x4);
-}
-
-static void csr_writel(struct mobiveil_pcie *pcie, u32 val, u32 off)
-{
-	csr_write(pcie, val, off, 0x4);
-}
-
-static bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie)
-{
-	return (csr_readl(pcie, LTSSM_STATUS) &
-		LTSSM_STATUS_L0_MASK) =3D=3D LTSSM_STATUS_L0;
-}
+#include "pcie-mobiveil.h"
=20
 static bool mobiveil_pcie_valid_device(struct pci_bus *bus, unsigned int d=
evfn)
 {
 	struct mobiveil_pcie *pcie =3D bus->sysdata;
=20
 	/* Only one device down on each root port */
-	if ((bus->number =3D=3D pcie->root_bus_nr) && (devfn > 0))
+	if ((bus->number =3D=3D pcie->rp.root_bus_nr) && (devfn > 0))
 		return false;
=20
 	/*
 	 * Do not read more than one device on the bus directly
 	 * attached to RC
 	 */
-	if ((bus->primary =3D=3D pcie->root_bus_nr) && (PCI_SLOT(devfn) > 0))
+	if ((bus->primary =3D=3D pcie->rp.root_bus_nr) && (PCI_SLOT(devfn) > 0))
 		return false;
=20
 	return true;
@@ -310,7 +59,7 @@ static void __iomem *mobiveil_pcie_map_bus(struct pci_bu=
s *bus,
 		return NULL;
=20
 	/* RC config access */
-	if (bus->number =3D=3D pcie->root_bus_nr)
+	if (bus->number =3D=3D pcie->rp.root_bus_nr)
 		return pcie->csr_axi_slave_base + where;
=20
 	/*
@@ -325,7 +74,7 @@ static void __iomem *mobiveil_pcie_map_bus(struct pci_bu=
s *bus,
=20
 	csr_writel(pcie, value, PAB_AXI_AMAP_PEX_WIN_L(WIN_NUM_0));
=20
-	return pcie->config_axi_slave_base + where;
+	return pcie->rp.config_axi_slave_base + where;
 }
=20
 static struct pci_ops mobiveil_pcie_ops =3D {
@@ -339,7 +88,7 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
 	struct irq_chip *chip =3D irq_desc_get_chip(desc);
 	struct mobiveil_pcie *pcie =3D irq_desc_get_handler_data(desc);
 	struct device *dev =3D &pcie->pdev->dev;
-	struct mobiveil_msi *msi =3D &pcie->msi;
+	struct mobiveil_msi *msi =3D &pcie->rp.msi;
 	u32 msi_data, msi_addr_lo, msi_addr_hi;
 	u32 intr_status, msi_status;
 	unsigned long shifted_status;
@@ -364,7 +113,7 @@ static void mobiveil_pcie_isr(struct irq_desc *desc)
 		shifted_status >>=3D PAB_INTX_START;
 		do {
 			for_each_set_bit(bit, &shifted_status, PCI_NUM_INTX) {
-				virq =3D irq_find_mapping(pcie->intx_domain,
+				virq =3D irq_find_mapping(pcie->rp.intx_domain,
 							bit + 1);
 				if (virq)
 					generic_handle_irq(virq);
@@ -427,10 +176,10 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pci=
e *pcie)
 	/* map config resource */
 	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
 					   "config_axi_slave");
-	pcie->config_axi_slave_base =3D devm_pci_remap_cfg_resource(dev, res);
-	if (IS_ERR(pcie->config_axi_slave_base))
-		return PTR_ERR(pcie->config_axi_slave_base);
-	pcie->ob_io_res =3D res;
+	pcie->rp.config_axi_slave_base =3D devm_pci_remap_cfg_resource(dev, res);
+	if (IS_ERR(pcie->rp.config_axi_slave_base))
+		return PTR_ERR(pcie->rp.config_axi_slave_base);
+	pcie->rp.ob_io_res =3D res;
=20
 	/* map csr resource */
 	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM,
@@ -440,12 +189,6 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie=
 *pcie)
 		return PTR_ERR(pcie->csr_axi_slave_base);
 	pcie->pcie_reg_base =3D res->start;
=20
-	/* map MSI config resource */
-	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "apb_csr");
-	pcie->apb_csr_base =3D devm_pci_remap_cfg_resource(dev, res);
-	if (IS_ERR(pcie->apb_csr_base))
-		return PTR_ERR(pcie->apb_csr_base);
-
 	/* read the number of windows requested */
 	if (of_property_read_u32(node, "apio-wins", &pcie->apio_wins))
 		pcie->apio_wins =3D MAX_PIO_WINDOWS;
@@ -453,116 +196,15 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pc=
ie *pcie)
 	if (of_property_read_u32(node, "ppio-wins", &pcie->ppio_wins))
 		pcie->ppio_wins =3D MAX_PIO_WINDOWS;
=20
-	pcie->irq =3D platform_get_irq(pdev, 0);
-	if (pcie->irq <=3D 0) {
-		dev_err(dev, "failed to map IRQ: %d\n", pcie->irq);
-		return -ENODEV;
-	}
-
 	return 0;
 }
=20
-static void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
-			       u64 cpu_addr, u64 pci_addr, u32 type, u64 size)
-{
-	u32 value;
-	u64 size64 =3D ~(size - 1);
-
-	if (win_num >=3D pcie->ppio_wins) {
-		dev_err(&pcie->pdev->dev,
-			"ERROR: max inbound windows reached !\n");
-		return;
-	}
-
-	value =3D csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
-	value &=3D ~(AMAP_CTRL_TYPE_MASK << AMAP_CTRL_TYPE_SHIFT | WIN_SIZE_MASK)=
;
-	value |=3D type << AMAP_CTRL_TYPE_SHIFT | 1 << AMAP_CTRL_EN_SHIFT |
-		 (lower_32_bits(size64) & WIN_SIZE_MASK);
-	csr_writel(pcie, value, PAB_PEX_AMAP_CTRL(win_num));
-
-	csr_writel(pcie, upper_32_bits(size64),
-		   PAB_EXT_PEX_AMAP_SIZEN(win_num));
-
-	csr_writel(pcie, lower_32_bits(cpu_addr),
-		   PAB_PEX_AMAP_AXI_WIN(win_num));
-	csr_writel(pcie, upper_32_bits(cpu_addr),
-		   PAB_EXT_PEX_AMAP_AXI_WIN(win_num));
-
-	csr_writel(pcie, lower_32_bits(pci_addr),
-		   PAB_PEX_AMAP_PEX_WIN_L(win_num));
-	csr_writel(pcie, upper_32_bits(pci_addr),
-		   PAB_PEX_AMAP_PEX_WIN_H(win_num));
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
-	u64 size64 =3D ~(size - 1);
-
-	if (win_num >=3D pcie->apio_wins) {
-		dev_err(&pcie->pdev->dev,
-			"ERROR: max outbound windows reached !\n");
-		return;
-	}
-
-	/*
-	 * program Enable Bit to 1, Type Bit to (00) base 2, AXI Window Size Bit
-	 * to 4 KB in PAB_AXI_AMAP_CTRL register
-	 */
-	value =3D csr_readl(pcie, PAB_AXI_AMAP_CTRL(win_num));
-	value &=3D ~(WIN_TYPE_MASK << WIN_TYPE_SHIFT | WIN_SIZE_MASK);
-	value |=3D 1 << WIN_ENABLE_SHIFT | type << WIN_TYPE_SHIFT |
-		 (lower_32_bits(size64) & WIN_SIZE_MASK);
-	csr_writel(pcie, value, PAB_AXI_AMAP_CTRL(win_num));
-
-	csr_writel(pcie, upper_32_bits(size64), PAB_EXT_AXI_AMAP_SIZE(win_num));
-
-	/*
-	 * program AXI window base with appropriate value in
-	 * PAB_AXI_AMAP_AXI_WIN0 register
-	 */
-	csr_writel(pcie, lower_32_bits(cpu_addr) & (~AXI_WINDOW_ALIGN_MASK),
-		   PAB_AXI_AMAP_AXI_WIN(win_num));
-	csr_writel(pcie, upper_32_bits(cpu_addr),
-		   PAB_EXT_AXI_AMAP_AXI_WIN(win_num));
-
-	csr_writel(pcie, lower_32_bits(pci_addr),
-		   PAB_AXI_AMAP_PEX_WIN_L(win_num));
-	csr_writel(pcie, upper_32_bits(pci_addr),
-		   PAB_AXI_AMAP_PEX_WIN_H(win_num));
-
-	pcie->ob_wins_configured++;
-}
-
-static int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
-{
-	int retries;
-
-	/* check if the link is up or not */
-	for (retries =3D 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
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
 	phys_addr_t msg_addr =3D pcie->pcie_reg_base;
-	struct mobiveil_msi *msi =3D &pcie->msi;
+	struct mobiveil_msi *msi =3D &pcie->rp.msi;
=20
-	pcie->msi.num_of_vectors =3D PCI_NUM_MSI;
+	msi->num_of_vectors =3D PCI_NUM_MSI;
 	msi->msi_pages_phys =3D (phys_addr_t)msg_addr;
=20
 	writel_relaxed(lower_32_bits(msg_addr),
@@ -600,9 +242,6 @@ static int mobiveil_host_init(struct mobiveil_pcie *pci=
e)
 	pab_ctrl |=3D (1 << AMBA_PIO_ENABLE_SHIFT) | (1 << PEX_PIO_ENABLE_SHIFT);
 	csr_writel(pcie, pab_ctrl, PAB_CTRL);
=20
-	csr_writel(pcie, (PAB_INTP_INTX_MASK | PAB_INTP_MSI_MASK),
-		   PAB_INTP_AMBA_MISC_ENB);
-
 	/*
 	 * program PIO Enable Bit to 1 and Config Window Enable Bit to 1 in
 	 * PAB_AXI_PIO_CTRL Register
@@ -624,20 +263,24 @@ static int mobiveil_host_init(struct mobiveil_pcie *p=
cie)
 	 */
=20
 	/* config outbound translation window */
-	program_ob_windows(pcie, WIN_NUM_0, pcie->ob_io_res->start, 0,
-			   CFG_WINDOW_TYPE, resource_size(pcie->ob_io_res));
+	program_ob_windows(pcie, WIN_NUM_0, pcie->rp.ob_io_res->start, 0,
+			   CFG_WINDOW_TYPE, resource_size(pcie->rp.ob_io_res));
=20
 	/* memory inbound translation window */
 	program_ib_windows(pcie, WIN_NUM_0, 0, 0, MEM_WINDOW_TYPE, IB_WIN_SIZE);
=20
 	/* Get the I/O and memory ranges from DT */
 	resource_list_for_each_entry(win, &pcie->resources) {
-		if (resource_type(win->res) =3D=3D IORESOURCE_MEM)
+		if (resource_type(win->res) =3D=3D IORESOURCE_MEM) {
 			type =3D MEM_WINDOW_TYPE;
-		else if (resource_type(win->res) =3D=3D IORESOURCE_IO)
+		} else if (resource_type(win->res) =3D=3D IORESOURCE_IO) {
 			type =3D IO_WINDOW_TYPE;
-		else
+		} else if (resource_type(win->res) =3D=3D IORESOURCE_BUS) {
+			pcie->rp.root_bus_nr =3D win->res->start;
 			continue;
+		} else {
+			continue;
+		}
=20
 		/* configure outbound translation window */
 		program_ob_windows(pcie, pcie->ob_wins_configured,
@@ -652,9 +295,6 @@ static int mobiveil_host_init(struct mobiveil_pcie *pci=
e)
 	value |=3D (PCI_CLASS_BRIDGE_PCI << 16);
 	csr_writel(pcie, value, PAB_INTP_AXI_PIO_CLASS);
=20
-	/* setup MSI hardware registers */
-	mobiveil_pcie_enable_msi(pcie);
-
 	return 0;
 }
=20
@@ -667,11 +307,11 @@ static void mobiveil_mask_intx_irq(struct irq_data *d=
ata)
=20
 	pcie =3D irq_desc_get_chip_data(desc);
 	mask =3D 1 << ((data->hwirq + PAB_INTX_START) - 1);
-	raw_spin_lock_irqsave(&pcie->intx_mask_lock, flags);
+	raw_spin_lock_irqsave(&pcie->rp.intx_mask_lock, flags);
 	shifted_val =3D csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
 	shifted_val &=3D ~mask;
 	csr_writel(pcie, shifted_val, PAB_INTP_AMBA_MISC_ENB);
-	raw_spin_unlock_irqrestore(&pcie->intx_mask_lock, flags);
+	raw_spin_unlock_irqrestore(&pcie->rp.intx_mask_lock, flags);
 }
=20
 static void mobiveil_unmask_intx_irq(struct irq_data *data)
@@ -683,11 +323,11 @@ static void mobiveil_unmask_intx_irq(struct irq_data =
*data)
=20
 	pcie =3D irq_desc_get_chip_data(desc);
 	mask =3D 1 << ((data->hwirq + PAB_INTX_START) - 1);
-	raw_spin_lock_irqsave(&pcie->intx_mask_lock, flags);
+	raw_spin_lock_irqsave(&pcie->rp.intx_mask_lock, flags);
 	shifted_val =3D csr_readl(pcie, PAB_INTP_AMBA_MISC_ENB);
 	shifted_val |=3D mask;
 	csr_writel(pcie, shifted_val, PAB_INTP_AMBA_MISC_ENB);
-	raw_spin_unlock_irqrestore(&pcie->intx_mask_lock, flags);
+	raw_spin_unlock_irqrestore(&pcie->rp.intx_mask_lock, flags);
 }
=20
 static struct irq_chip intx_irq_chip =3D {
@@ -755,7 +395,7 @@ static int mobiveil_irq_msi_domain_alloc(struct irq_dom=
ain *domain,
 					 unsigned int nr_irqs, void *args)
 {
 	struct mobiveil_pcie *pcie =3D domain->host_data;
-	struct mobiveil_msi *msi =3D &pcie->msi;
+	struct mobiveil_msi *msi =3D &pcie->rp.msi;
 	unsigned long bit;
=20
 	WARN_ON(nr_irqs !=3D 1);
@@ -782,7 +422,7 @@ static void mobiveil_irq_msi_domain_free(struct irq_dom=
ain *domain,
 {
 	struct irq_data *d =3D irq_domain_get_irq_data(domain, virq);
 	struct mobiveil_pcie *pcie =3D irq_data_get_irq_chip_data(d);
-	struct mobiveil_msi *msi =3D &pcie->msi;
+	struct mobiveil_msi *msi =3D &pcie->rp.msi;
=20
 	mutex_lock(&msi->lock);
=20
@@ -803,9 +443,9 @@ static int mobiveil_allocate_msi_domains(struct mobivei=
l_pcie *pcie)
 {
 	struct device *dev =3D &pcie->pdev->dev;
 	struct fwnode_handle *fwnode =3D of_node_to_fwnode(dev->of_node);
-	struct mobiveil_msi *msi =3D &pcie->msi;
+	struct mobiveil_msi *msi =3D &pcie->rp.msi;
=20
-	mutex_init(&pcie->msi.lock);
+	mutex_init(&msi->lock);
 	msi->dev_domain =3D irq_domain_add_linear(NULL, msi->num_of_vectors,
 						&msi_domain_ops, pcie);
 	if (!msi->dev_domain) {
@@ -832,15 +472,15 @@ static int mobiveil_pcie_init_irq_domain(struct mobiv=
eil_pcie *pcie)
 	int ret;
=20
 	/* setup INTx */
-	pcie->intx_domain =3D irq_domain_add_linear(node, PCI_NUM_INTX,
-						  &intx_domain_ops, pcie);
+	pcie->rp.intx_domain =3D irq_domain_add_linear(node, PCI_NUM_INTX,
+						     &intx_domain_ops, pcie);
=20
-	if (!pcie->intx_domain) {
+	if (!pcie->rp.intx_domain) {
 		dev_err(dev, "Failed to get a INTx IRQ domain\n");
 		return -ENOMEM;
 	}
=20
-	raw_spin_lock_init(&pcie->intx_mask_lock);
+	raw_spin_lock_init(&pcie->rp.intx_mask_lock);
=20
 	/* setup MSI */
 	ret =3D mobiveil_allocate_msi_domains(pcie);
@@ -850,24 +490,58 @@ static int mobiveil_pcie_init_irq_domain(struct mobiv=
eil_pcie *pcie)
 	return 0;
 }
=20
-static int mobiveil_pcie_probe(struct platform_device *pdev)
+static int mobiveil_pcie_interrupt_init(struct mobiveil_pcie *pcie)
+{
+	struct device *dev =3D &pcie->pdev->dev;
+	struct resource *res;
+	int ret;
+
+	if (pcie->rp.ops->interrupt_init)
+		return pcie->rp.ops->interrupt_init(pcie);
+
+	/* map MSI config resource */
+	res =3D platform_get_resource_byname(pcie->pdev, IORESOURCE_MEM,
+					   "apb_csr");
+	pcie->apb_csr_base =3D devm_pci_remap_cfg_resource(dev, res);
+	if (IS_ERR(pcie->apb_csr_base))
+		return PTR_ERR(pcie->apb_csr_base);
+
+	/* setup MSI hardware registers */
+	mobiveil_pcie_enable_msi(pcie);
+
+	pcie->rp.irq =3D platform_get_irq(pcie->pdev, 0);
+	if (pcie->rp.irq <=3D 0) {
+		dev_err(dev, "failed to map IRQ: %d\n", pcie->rp.irq);
+		return -ENODEV;
+	}
+
+	/* initialize the IRQ domains */
+	ret =3D mobiveil_pcie_init_irq_domain(pcie);
+	if (ret) {
+		dev_err(dev, "Failed creating IRQ Domain\n");
+		return ret;
+	}
+
+	irq_set_chained_handler_and_data(pcie->rp.irq,
+					 mobiveil_pcie_isr, pcie);
+
+	/* Enable interrupts */
+	csr_writel(pcie, (PAB_INTP_INTX_MASK | PAB_INTP_MSI_MASK),
+		   PAB_INTP_AMBA_MISC_ENB);
+
+	return 0;
+}
+
+int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
 {
-	struct mobiveil_pcie *pcie;
 	struct pci_bus *bus;
 	struct pci_bus *child;
-	struct pci_host_bridge *bridge;
-	struct device *dev =3D &pdev->dev;
+	struct pci_host_bridge *bridge =3D pcie->bridge;
+	struct device *dev =3D &pcie->pdev->dev;
 	resource_size_t iobase;
 	int ret;
=20
-	/* allocate the PCIe port */
-	bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
-	if (!bridge)
-		return -ENOMEM;
-
-	pcie =3D pci_host_bridge_priv(bridge);
-
-	pcie->pdev =3D pdev;
+	INIT_LIST_HEAD(&pcie->resources);
=20
 	ret =3D mobiveil_pcie_parse_dt(pcie);
 	if (ret) {
@@ -875,8 +549,6 @@ static int mobiveil_pcie_probe(struct platform_device *=
pdev)
 		return ret;
 	}
=20
-	INIT_LIST_HEAD(&pcie->resources);
-
 	/* parse the host bridge base addresses from the device tree file */
 	ret =3D devm_of_pci_get_host_bridge_resources(dev, 0, 0xff,
 						    &pcie->resources, &iobase);
@@ -895,15 +567,12 @@ static int mobiveil_pcie_probe(struct platform_device=
 *pdev)
 		goto error;
 	}
=20
-	/* initialize the IRQ domains */
-	ret =3D mobiveil_pcie_init_irq_domain(pcie);
+	ret =3D mobiveil_pcie_interrupt_init(pcie);
 	if (ret) {
-		dev_err(dev, "Failed creating IRQ Domain\n");
+		dev_err(dev, "Interrupt init failed\n");
 		goto error;
 	}
=20
-	irq_set_chained_handler_and_data(pcie->irq, mobiveil_pcie_isr, pcie);
-
 	ret =3D devm_request_pci_bus_resources(dev, &pcie->resources);
 	if (ret)
 		goto error;
@@ -912,7 +581,7 @@ static int mobiveil_pcie_probe(struct platform_device *=
pdev)
 	list_splice_init(&pcie->resources, &bridge->windows);
 	bridge->dev.parent =3D dev;
 	bridge->sysdata =3D pcie;
-	bridge->busnr =3D pcie->root_bus_nr;
+	bridge->busnr =3D pcie->rp.root_bus_nr;
 	bridge->ops =3D &mobiveil_pcie_ops;
 	bridge->map_irq =3D of_irq_parse_and_map_pci;
 	bridge->swizzle_irq =3D pci_common_swizzle;
@@ -940,25 +609,3 @@ static int mobiveil_pcie_probe(struct platform_device =
*pdev)
 	pci_free_resource_list(&pcie->resources);
 	return ret;
 }
-
-static const struct of_device_id mobiveil_pcie_of_match[] =3D {
-	{.compatible =3D "mbvl,gpex40-pcie",},
-	{},
-};
-
-MODULE_DEVICE_TABLE(of, mobiveil_pcie_of_match);
-
-static struct platform_driver mobiveil_pcie_driver =3D {
-	.probe =3D mobiveil_pcie_probe,
-	.driver =3D {
-		.name =3D "mobiveil-pcie",
-		.of_match_table =3D mobiveil_pcie_of_match,
-		.suppress_bind_attrs =3D true,
-	},
-};
-
-builtin_platform_driver(mobiveil_pcie_driver);
-
-MODULE_LICENSE("GPL v2");
-MODULE_DESCRIPTION("Mobiveil PCIe host controller driver");
-MODULE_AUTHOR("Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>");
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c b/drivers=
/pci/controller/mobiveil/pcie-mobiveil-plat.c
new file mode 100644
index 000000000000..9c62fc58530c
--- /dev/null
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe host controller driver for Mobiveil PCIe Host controller
+ *
+ * Copyright (c) 2018 Mobiveil Inc.
+ * Copyright 2019 NXP
+ *
+ * Author: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
+ * Refactor: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
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
+	struct device *dev =3D &pdev->dev;
+
+	bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
+	if (!bridge)
+		return -ENOMEM;
+
+	pcie =3D pci_host_bridge_priv(bridge);
+
+	pcie->pdev =3D pdev;
+
+	return mobiveil_pcie_host_probe(pcie);
+}
+
+static const struct of_device_id mobiveil_pcie_of_match[] =3D {
+	{.compatible =3D "mbvl,gpex40-pcie",},
+	{},
+};
+
+MODULE_DEVICE_TABLE(of, mobiveil_pcie_of_match);
+
+static struct platform_driver mobiveil_pcie_driver =3D {
+	.probe =3D mobiveil_pcie_probe,
+	.driver =3D {
+		.name =3D "mobiveil-pcie",
+		.of_match_table =3D mobiveil_pcie_of_match,
+		.suppress_bind_attrs =3D true,
+	},
+};
+
+builtin_platform_driver(mobiveil_pcie_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Mobiveil PCIe host controller driver");
+MODULE_AUTHOR("Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>");
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.c b/drivers/pci/=
controller/mobiveil/pcie-mobiveil.c
new file mode 100644
index 000000000000..94b23be1a06f
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
+ * Refactor: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
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
+ * Registers whose address greater than PAGED_ADDR_BNDRY (0xc00) are paged=
,
+ * for this scheme to work extracted higher 6 bits of the offset will be
+ * written to pg_sel field of PAB_CTRL register and rest of the lower 10
+ * bits enabled with PAGED_ADDR_BNDRY are used as offset of the register.
+ */
+static void mobiveil_pcie_sel_page(struct mobiveil_pcie *pcie, u8 pg_idx)
+{
+	u32 val;
+
+	val =3D readl(pcie->csr_axi_slave_base + PAB_CTRL);
+	val &=3D ~(PAGE_SEL_MASK << PAGE_SEL_SHIFT);
+	val |=3D (pg_idx & PAGE_SEL_MASK) << PAGE_SEL_SHIFT;
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
+		*val =3D 0;
+		return PCIBIOS_BAD_REGISTER_NUMBER;
+	}
+
+	switch (size) {
+	case 4:
+		*val =3D readl(addr);
+		break;
+	case 2:
+		*val =3D readw(addr);
+		break;
+	case 1:
+		*val =3D readb(addr);
+		break;
+	default:
+		*val =3D 0;
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
+u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
+{
+	void *addr;
+	u32 val;
+	int ret;
+
+	addr =3D mobiveil_pcie_comp_addr(pcie, off);
+
+	ret =3D mobiveil_pcie_read(addr, size, &val);
+	if (ret)
+		dev_err(&pcie->pdev->dev, "read CSR address failed\n");
+
+	return val;
+}
+
+void csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t size)
+{
+	void *addr;
+	int ret;
+
+	addr =3D mobiveil_pcie_comp_addr(pcie, off);
+
+	ret =3D mobiveil_pcie_write(addr, size, val);
+	if (ret)
+		dev_err(&pcie->pdev->dev, "write CSR address failed\n");
+}
+
+bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie)
+{
+	if (pcie->ops->link_up)
+		return pcie->ops->link_up(pcie);
+
+	return (csr_readl(pcie, LTSSM_STATUS) &
+		LTSSM_STATUS_L0_MASK) =3D=3D LTSSM_STATUS_L0;
+}
+
+void program_ib_windows(struct mobiveil_pcie *pcie, int win_num, u64 cpu_a=
ddr,
+			u64 pci_addr, u32 type, u64 size)
+{
+	u32 value;
+	u64 size64 =3D ~(size - 1);
+
+	if (win_num >=3D pcie->ppio_wins) {
+		dev_err(&pcie->pdev->dev,
+			"ERROR: max inbound windows reached !\n");
+		return;
+	}
+
+	value =3D csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
+	value &=3D ~(AMAP_CTRL_TYPE_MASK << AMAP_CTRL_TYPE_SHIFT | WIN_SIZE_MASK)=
;
+	value |=3D type << AMAP_CTRL_TYPE_SHIFT | 1 << AMAP_CTRL_EN_SHIFT |
+		 (lower_32_bits(size64) & WIN_SIZE_MASK);
+	csr_writel(pcie, value, PAB_PEX_AMAP_CTRL(win_num));
+
+	csr_writel(pcie, upper_32_bits(size64),
+		   PAB_EXT_PEX_AMAP_SIZEN(win_num));
+
+	csr_writel(pcie, lower_32_bits(cpu_addr),
+		   PAB_PEX_AMAP_AXI_WIN(win_num));
+	csr_writel(pcie, upper_32_bits(cpu_addr),
+		   PAB_EXT_PEX_AMAP_AXI_WIN(win_num));
+
+	csr_writel(pcie, lower_32_bits(pci_addr),
+		   PAB_PEX_AMAP_PEX_WIN_L(win_num));
+	csr_writel(pcie, upper_32_bits(pci_addr),
+		   PAB_PEX_AMAP_PEX_WIN_H(win_num));
+
+	pcie->ib_wins_configured++;
+}
+
+/*
+ * routine to program the outbound windows
+ */
+void program_ob_windows(struct mobiveil_pcie *pcie, int win_num, u64 cpu_a=
ddr,
+			u64 pci_addr, u32 type, u64 size)
+{
+	u32 value;
+	u64 size64 =3D ~(size - 1);
+
+	if (win_num >=3D pcie->apio_wins) {
+		dev_err(&pcie->pdev->dev,
+			"ERROR: max outbound windows reached !\n");
+		return;
+	}
+
+	/*
+	 * program Enable Bit to 1, Type Bit to (00) base 2, AXI Window Size Bit
+	 * to 4 KB in PAB_AXI_AMAP_CTRL register
+	 */
+	value =3D csr_readl(pcie, PAB_AXI_AMAP_CTRL(win_num));
+	value &=3D ~(WIN_TYPE_MASK << WIN_TYPE_SHIFT | WIN_SIZE_MASK);
+	value |=3D 1 << WIN_ENABLE_SHIFT | type << WIN_TYPE_SHIFT |
+		 (lower_32_bits(size64) & WIN_SIZE_MASK);
+	csr_writel(pcie, value, PAB_AXI_AMAP_CTRL(win_num));
+
+	csr_writel(pcie, upper_32_bits(size64), PAB_EXT_AXI_AMAP_SIZE(win_num));
+
+	/*
+	 * program AXI window base with appropriate value in
+	 * PAB_AXI_AMAP_AXI_WIN0 register
+	 */
+	csr_writel(pcie, lower_32_bits(cpu_addr) & (~AXI_WINDOW_ALIGN_MASK),
+		   PAB_AXI_AMAP_AXI_WIN(win_num));
+	csr_writel(pcie, upper_32_bits(cpu_addr),
+		   PAB_EXT_AXI_AMAP_AXI_WIN(win_num));
+
+	csr_writel(pcie, lower_32_bits(pci_addr),
+		   PAB_AXI_AMAP_PEX_WIN_L(win_num));
+	csr_writel(pcie, upper_32_bits(pci_addr),
+		   PAB_AXI_AMAP_PEX_WIN_H(win_num));
+
+	pcie->ob_wins_configured++;
+}
+
+int mobiveil_bringup_link(struct mobiveil_pcie *pcie)
+{
+	int retries;
+
+	/* check if the link is up or not */
+	for (retries =3D 0; retries < LINK_WAIT_MAX_RETRIES; retries++) {
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
diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil.h b/drivers/pci/=
controller/mobiveil/pcie-mobiveil.h
new file mode 100644
index 000000000000..4825e30030cd
--- /dev/null
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil.h
@@ -0,0 +1,189 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * PCIe host controller driver for Mobiveil PCIe Host controller
+ *
+ * Copyright (c) 2018 Mobiveil Inc.
+ * Copyright 2019 NXP
+ *
+ * Author: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
+ * Refactor: Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
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
+struct mobiveil_pcie;
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
+struct mobiveil_rp_ops {
+	int (*interrupt_init)(struct mobiveil_pcie *pcie);
+};
+
+struct root_port {
+	u8 root_bus_nr;
+	void __iomem *config_axi_slave_base;	/* endpoint config base */
+	struct resource *ob_io_res;
+	struct mobiveil_rp_ops *ops;
+	int irq;
+	raw_spinlock_t intx_mask_lock;
+	struct irq_domain *intx_domain;
+	struct mobiveil_msi msi;
+};
+
+struct mobiveil_pab_ops {
+	int (*link_up)(struct mobiveil_pcie *pcie);
+};
+
+struct mobiveil_pcie {
+	struct platform_device *pdev;
+	struct list_head resources;
+	void __iomem *csr_axi_slave_base;	/* PAB registers base */
+	phys_addr_t pcie_reg_base;	/* Physical PCIe Controller Base */
+	void __iomem *apb_csr_base;	/* MSI register base */
+	u32 apio_wins;
+	u32 ppio_wins;
+	u32 ob_wins_configured;		/* configured outbound windows */
+	u32 ib_wins_configured;		/* configured inbound windows */
+	const struct mobiveil_pab_ops *ops;
+	struct root_port rp;
+	struct pci_host_bridge *bridge;
+};
+
+int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie);
+bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie);
+int mobiveil_bringup_link(struct mobiveil_pcie *pcie);
+void program_ob_windows(struct mobiveil_pcie *pcie, int win_num, u64 cpu_a=
ddr,
+			u64 pci_addr, u32 type, u64 size);
+void program_ib_windows(struct mobiveil_pcie *pcie, int win_num, u64 cpu_a=
ddr,
+			u64 pci_addr, u32 type, u64 size);
+u32 csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size);
+void csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off, size_t size);
+
+static inline u32 csr_readl(struct mobiveil_pcie *pcie, u32 off)
+{
+	return csr_read(pcie, off, 0x4);
+}
+
+static inline void csr_writel(struct mobiveil_pcie *pcie, u32 val, u32 off=
)
+{
+	csr_write(pcie, val, off, 0x4);
+}
+
+#endif /* _PCIE_MOBIVEIL_H */
--=20
2.17.1

