Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81F3010322C
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 04:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfKTDpy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Nov 2019 22:45:54 -0500
Received: from mail-eopbgr70047.outbound.protection.outlook.com ([40.107.7.47]:32480
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727262AbfKTDpy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Nov 2019 22:45:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A7tGrazVeLLHhdkbE+odZAiyWK/BQWRQI8DywnHCxFOzbPOg09ERzAGaSwQ9SU/ntDqvRcgk8LgJkmAk7UnhS8eIwCmg65hwG2BDusGoHDUYVSq4o62odNYc5MRDz8Hnv5v4IzsyGfMLi9YmkGnu4Xya9xKX53rqHQh6yYy/BiLHKih1NGfT+sBrcCp557JJ24utwN0yalbUl30Z4s2ZNr4OVNZ833l37dODJXbBZiLt2392LW5AF0AihDa2QlwCVEEBpEw4+tFNr/6FNf/Gf0g5ypeJoNKrgqG907n4402p7VJWoCzMcOSZOaQzVBQsNCI/M2inmUS/WsGSmIAV2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsCzHdIl3tapHUUcYMnBT15fHim0I0f1B+F6GWVn3XU=;
 b=bclcJbChQZO+k9txM+Nd6mNZztrdK25yGQRTHLUQYf3WdSYUtXNuC1+FBWi+ewYZybuODk1kpu9EJ7WDghDh5nZlRIuSV7Jr5DROYuQ827QosIxc+mkAG1ok0CJxtpBlGzbHEfSo0APiRL2RPSTgJhi+E5OMmrdQOZ1g//GbUDsSxEZ3DyC0n316ruhfahF7Mz5c2DR45gnmVSDd6L4zNlQmlHMsjOSIlY+McJ4kmNWD8jELjdZjuwJ23IRenz1lBVbskY55F7QfFo6l84zYY9XhAx5ZmDh80EBXeTs4Jh4Qw8TupISpAk2BEGbCMmcLegO25Tr2jD1wr0iXJZ1haA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsCzHdIl3tapHUUcYMnBT15fHim0I0f1B+F6GWVn3XU=;
 b=FPhF1KSWSa0K1hfeoxxPcBXrP7PF4PKtLiXSwoH9kCO6r60NvAftTF7beccyL2Q6zf11mfpaTLF3BMgbAcPyvXNR+XA30cHRtEwdzWv+Y2rsmNClIYytOCsvUdoXNDsjNlg79JkTydlLT00vqw2T3qM8W19qApjhRLLxIBlFGGQ=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB5657.eurprd04.prod.outlook.com (20.179.9.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 20 Nov 2019 03:45:44 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::898f:3cd6:c225:7219]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::898f:3cd6:c225:7219%7]) with mapi id 15.20.2451.029; Wed, 20 Nov 2019
 03:45:43 +0000
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
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv9 04/12] PCI: mobiveil: Modularize the Mobiveil PCIe Host
 Bridge IP driver
Thread-Topic: [PATCHv9 04/12] PCI: mobiveil: Modularize the Mobiveil PCIe Host
 Bridge IP driver
Thread-Index: AQHVn1T8aFb5mY+RykmposxdjKSlyQ==
Date:   Wed, 20 Nov 2019 03:45:43 +0000
Message-ID: <20191120034451.30102-5-Zhiqiang.Hou@nxp.com>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
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
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 75702674-786d-4f85-7a4e-08d76d6c1ea5
x-ms-traffictypediagnostic: DB8PR04MB5657:|DB8PR04MB5657:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB565744276A6C66EC61EA565B844F0@DB8PR04MB5657.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(199004)(189003)(2201001)(54906003)(86362001)(36756003)(256004)(7736002)(305945005)(6116002)(66066001)(3846002)(110136005)(316002)(71190400001)(7416002)(1076003)(71200400001)(14444005)(30864003)(52116002)(2501003)(4326008)(5660300002)(66476007)(476003)(64756008)(66556008)(11346002)(446003)(76176011)(2616005)(66946007)(6512007)(66446008)(8676002)(386003)(6506007)(2906002)(99286004)(102836004)(6486002)(81166006)(81156014)(8936002)(50226002)(186003)(26005)(478600001)(14454004)(486006)(6436002)(25786009)(921003)(1121003)(559001)(579004)(569006);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB5657;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7irDRbPT5ozFV4ctLgAmHbyQK9B0Z3Yk6lncSeFQt8GD52mJqdq8QBy4RVszpOOoTFDFXi40Yibt6vk/2CT7lEkvy96DTLV354WAkNaXCQxnA6+3HZdNlNOrw0XCFUuWbz80p3G9oRd8CCXKGI9C0dVTxPbxlKS+62f8h6k+dwYDYWEgDTgV73J4a7Fq0LmuRa7X39FVNvVIzqE6xYktf18u0LpuM8qmxK59gySt0Kga+uskOl01RLu4jM4VWQxihP5dO4da3sO1VaG//B5E5nxd3LMTSKAtIjqbzcVVlvIfCLtKzzbNIAiZSWMxAhaMWghAAZiG2g/lQ39AZLUYMl9yi2KDgQNPME9E7+iplF9SQabyqCpe4g8pkG5U4J+57i+HX1bneuA2C8uJT4hCFAiP96eyJq9r0Nvbl0BBiyzleAd0cnliJfzSO/TK+/wr
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75702674-786d-4f85-7a4e-08d76d6c1ea5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 03:45:43.8339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pIt/v1xrF8i6lYu1JmCPMIVNYrHhBhE3oLR3HSU8yqrLOhnB99e3KjQBWEnxBAbglOLAjPk+SwjJHD9roMtlGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5657
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
---
V9:
 - New patch splited from the #1 of V8 patches to make it easy to review.

 MAINTAINERS                                   |   2 +-
 drivers/pci/controller/Kconfig                |  11 +-
 drivers/pci/controller/Makefile               |   2 +-
 drivers/pci/controller/mobiveil/Kconfig       |  24 ++
 drivers/pci/controller/mobiveil/Makefile      |   4 +
 .../pcie-mobiveil-host.c}                     | 398 +-----------------
 .../controller/mobiveil/pcie-mobiveil-plat.c  |  60 +++
 .../pci/controller/mobiveil/pcie-mobiveil.c   | 227 ++++++++++
 .../pci/controller/mobiveil/pcie-mobiveil.h   | 178 ++++++++
 9 files changed, 497 insertions(+), 409 deletions(-)
 create mode 100644 drivers/pci/controller/mobiveil/Kconfig
 create mode 100644 drivers/pci/controller/mobiveil/Makefile
 rename drivers/pci/controller/{pcie-mobiveil.c =3D> mobiveil/pcie-mobiveil=
-host.c} (61%)
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.c
 create mode 100644 drivers/pci/controller/mobiveil/pcie-mobiveil.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 3f7f8cdbc471..a4ad99619e53 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12612,7 +12612,7 @@ M:	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
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
index f5de9119e8d3..74fd332755ae 100644
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
@@ -289,4 +279,5 @@ config PCI_HYPERV_INTERFACE
 	  have a common interface with the Hyper-V PCI frontend driver.
=20
 source "drivers/pci/controller/dwc/Kconfig"
+source "drivers/pci/controller/mobiveil/Kconfig"
 endmenu
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makef=
ile
index a2a22c9d91af..44414cfd45ea 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -27,11 +27,11 @@ obj-$(CONFIG_PCIE_ROCKCHIP) +=3D pcie-rockchip.o
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
similarity index 61%
rename from drivers/pci/controller/pcie-mobiveil.c
rename to drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index 512b27a0536e..2cc424e78d33 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -9,7 +9,6 @@
  * Recode: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
  */
=20
-#include <linux/delay.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
@@ -26,265 +25,7 @@
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
-struct root_port {
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
-	struct root_port rp;
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
-static u32 mobiveil_csr_read(struct mobiveil_pcie *pcie, u32 off, size_t s=
ize)
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
-static void mobiveil_csr_write(struct mobiveil_pcie *pcie, u32 val, u32 of=
f,
-			       size_t size)
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
-static u32 mobiveil_csr_readl(struct mobiveil_pcie *pcie, u32 off)
-{
-	return mobiveil_csr_read(pcie, off, 0x4);
-}
-
-static void mobiveil_csr_writel(struct mobiveil_pcie *pcie, u32 val, u32 o=
ff)
-{
-	mobiveil_csr_write(pcie, val, off, 0x4);
-}
-
-static bool mobiveil_pcie_link_up(struct mobiveil_pcie *pcie)
-{
-	return (mobiveil_csr_readl(pcie, LTSSM_STATUS) &
-		LTSSM_STATUS_L0_MASK) =3D=3D LTSSM_STATUS_L0;
-}
+#include "pcie-mobiveil.h"
=20
 static bool mobiveil_pcie_valid_device(struct pci_bus *bus, unsigned int d=
evfn)
 {
@@ -464,103 +205,6 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pci=
e *pcie)
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
-	value =3D mobiveil_csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
-	value &=3D ~(AMAP_CTRL_TYPE_MASK << AMAP_CTRL_TYPE_SHIFT | WIN_SIZE_MASK)=
;
-	value |=3D type << AMAP_CTRL_TYPE_SHIFT | 1 << AMAP_CTRL_EN_SHIFT |
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
-	value =3D mobiveil_csr_readl(pcie, PAB_AXI_AMAP_CTRL(win_num));
-	value &=3D ~(WIN_TYPE_MASK << WIN_TYPE_SHIFT | WIN_SIZE_MASK);
-	value |=3D 1 << WIN_ENABLE_SHIFT | type << WIN_TYPE_SHIFT |
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
@@ -962,43 +606,3 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pci=
e)
=20
 	return 0;
 }
-
-static int mobiveil_pcie_probe(struct platform_device *pdev)
-{
-	struct mobiveil_pcie *pcie;
-	struct pci_host_bridge *bridge;
-	struct device *dev =3D &pdev->dev;
-
-	bridge =3D devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
-	if (!bridge)
-		return -ENOMEM;
-
-	pcie =3D pci_host_bridge_priv(bridge);
-	pcie->rp.bridge =3D bridge;
-
-	pcie->pdev =3D pdev;
-
-	return mobiveil_pcie_host_probe(pcie);
-}
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
index 000000000000..64c85f852869
--- /dev/null
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-plat.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCIe host controller driver for Mobiveil PCIe Host controller
+ *
+ * Copyright (c) 2018 Mobiveil Inc.
+ * Copyright 2019 NXP
+ *
+ * Author: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
+ * Recode: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
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
+	pcie->rp.bridge =3D bridge;
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
+ * Recode: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
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
+u32 mobiveil_csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size)
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
+void mobiveil_csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off,
+			       size_t size)
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
+	return (mobiveil_csr_readl(pcie, LTSSM_STATUS) &
+		LTSSM_STATUS_L0_MASK) =3D=3D LTSSM_STATUS_L0;
+}
+
+void program_ib_windows(struct mobiveil_pcie *pcie, int win_num,
+			u64 cpu_addr, u64 pci_addr, u32 type, u64 size)
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
+	value =3D mobiveil_csr_readl(pcie, PAB_PEX_AMAP_CTRL(win_num));
+	value &=3D ~(AMAP_CTRL_TYPE_MASK << AMAP_CTRL_TYPE_SHIFT | WIN_SIZE_MASK)=
;
+	value |=3D type << AMAP_CTRL_TYPE_SHIFT | 1 << AMAP_CTRL_EN_SHIFT |
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
+	value =3D mobiveil_csr_readl(pcie, PAB_AXI_AMAP_CTRL(win_num));
+	value &=3D ~(WIN_TYPE_MASK << WIN_TYPE_SHIFT | WIN_SIZE_MASK);
+	value |=3D 1 << WIN_ENABLE_SHIFT | type << WIN_TYPE_SHIFT |
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
index 000000000000..e3148078e9dd
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
+ * Recode: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
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
+struct root_port {
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
+	struct root_port rp;
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
+u32 mobiveil_csr_read(struct mobiveil_pcie *pcie, u32 off, size_t size);
+void mobiveil_csr_write(struct mobiveil_pcie *pcie, u32 val, u32 off,
+			size_t size);
+
+static inline u32 mobiveil_csr_readl(struct mobiveil_pcie *pcie, u32 off)
+{
+	return mobiveil_csr_read(pcie, off, 0x4);
+}
+
+static inline void mobiveil_csr_writel(struct mobiveil_pcie *pcie, u32 val=
,
+				       u32 off)
+{
+	mobiveil_csr_write(pcie, val, off, 0x4);
+}
+
+#endif /* _PCIE_MOBIVEIL_H */
--=20
2.17.1

