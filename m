Return-Path: <linux-pci+bounces-1785-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91EF9826C1C
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 12:07:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17FB01F22634
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 11:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A11A14280;
	Mon,  8 Jan 2024 11:06:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2042.outbound.protection.partner.outlook.cn [139.219.17.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8107314A87;
	Mon,  8 Jan 2024 11:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KJXTxR1SH9bN2hfr1cDTbI932U+AUzGtWDUzmb80+/Bp38FRbhduz6bO+Hpo1ly+WEhHT3fMI5GH/ybKCfFVaqBtCf64yyknM6nDXJsEqnsEodkPincZsIcoSz1RIfEPGoZb9pbxJnyiylgj7pyrm0/Fk0jOn84BmwA4YbngsW1zukrQT+6pv7XjhkSBkarLHbhysXrhzVUpfMw4+gglGXfpzyw4N/phJzFqZPl5LEquopwmxZ8Cps2lXGgTJXc7mAsgcCJBvtN0uflrsgEE6nRSndRQpkwd4msvUfX6hSUQtIEds+AUeCh36zuywWVyJpP53vfAx+BCf5rU3AesXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mDUYi15QkcRDF9tWQLyEsrLGA70ww2ACaNBKCRL7qf0=;
 b=S/DQo4FCMdJExd0h+WKjeG1y6mJH1/HUletr1xDxhXceBlLQ7OxU3VDqnUuyAkEsM3433VIkMqiEpzw2k7HOEkAxzf4UaAiFoqUc1BBmk0TfEEl6vwR4dmdcc6CGtoxRXuQXrw5wlC7BaTeYdZSkXfT++HxUB8fCVygcz2ltAcQGYCubHfx+AsopXBYaqNxS8wsyxACD1416ntKVvXZMainrSJTnuWwxaG0Q7cq0UsBVfBJhPbVHC8I85yIWKDVAvOJm6UkpA0bEdvQH+ftYHeezj7IrBPJGiQnLDoNTvl5xUJv6WQEumVUrAslNCSA9ABa5aDa72+h9tdXG+mA/ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn (10.43.107.79) by
 SHXPR01MB0701.CHNPR01.prod.partner.outlook.cn (10.43.107.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7135.32; Mon, 8 Jan 2024 11:06:26 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::e6aa:baea:fd8c:4cd2]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::e6aa:baea:fd8c:4cd2%7])
 with mapi id 15.20.7135.032; Mon, 8 Jan 2024 11:06:26 +0000
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
Subject: [PATCH v14 02/22] PCI: microchip: Move pcie-microchip-host.c to plda directory
Date: Mon,  8 Jan 2024 19:05:52 +0800
Message-Id: <20240108110612.19048-3-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240108110612.19048-1-minda.chen@starfivetech.com>
References: <20240108110612.19048-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0014.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::19) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0701:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e2ed726-5bdc-4c0c-bab8-08dc1039db8d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GS+Zo01bPiD24/5D/ZOHP9yx9/pHVWwavdKVc9nxwcfthq2+xxRc4Wm0Ass8RhNI5obdKd1o8Vva4a7nnSoHQOGvDfO7raXW48w/pj5fz+1hhA+dykHXLt+X0rKoZZZGAZwf4KWoOMgZsPMJQGAxrf5suJscqYVs9LgJ7hwCAVbFsAXwiaotVGSqG0IO0XauLEcnAfNPANyZq1hAfSIrwogg8StQ50btci7h3CDZxIGPlbMdqZdp+CTklV5JPznwRjpsLkRMMFsUDmopR852Kyji0JME6C3+nSS2Rm8pGwxmv4tlSJa6DGv3OqGhtOvTJ8Hz5iP04BNkclSaPiglghz5h8W5HuThZCcER2s4gNb95crNd0p4ZsxdYJ/yTxbVIxZDPX9OvXCX95hirpFFX9m+ozJngqUt8954no/44CdmpMYYar/t8HXEOIDbHLIfpBiv+AjRaI2IZBqaI5NPh/DSuhyaPWfEF1NlYJR+KuCUyqDV2a/WyCc4g72c2AJfN9ssiUS8Nk0TbVJfT39d9LkmZGzQD44IxtMguKjfHSE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(346002)(366004)(396003)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(7416002)(5660300002)(4326008)(2906002)(44832011)(8676002)(8936002)(54906003)(110136005)(66946007)(66556008)(66476007)(41320700001)(508600001)(38350700005)(6666004)(52116002)(2616005)(36756003)(107886003)(26005)(1076003)(41300700001)(40180700001)(83380400001)(38100700002)(40160700002)(86362001)(45080400002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fvd0XiE30q6lmrX8GndatvpkEtlRRCdBXP4XHfTi/645E88gYXn85yTuDg8V?=
 =?us-ascii?Q?gfqSmx5gtdieFUUa0QOE4GWhEF2H1h/9GfMG3cj9ucFsfcvhb6xjeWD81yNG?=
 =?us-ascii?Q?pKlPgLVD6aoxoXT9SxAU1Irc8xw0WqIfUcAVCouYfPG+i2jTnKU7pNpmbJjX?=
 =?us-ascii?Q?5AknG4N+pIehpFqqR6MyYrDJ+UM2zQhjI44CylW76/oY9Cf3VzFNkCyeOhg/?=
 =?us-ascii?Q?QOdK3eDCqR0+SNvZUX3lz3w2rWa0v2g3Sqh1IZKoLWDl/HrpYUIfGf/LcjgM?=
 =?us-ascii?Q?IaLHJ0gS1hhwSsN1rXgHXqxU4jvMkbN/YRIhOdBiyCXpq8bmbBqyCZHD73uS?=
 =?us-ascii?Q?Om/CT7TVSby6NoJRvmF/Qzz/v5VK66q/JQFpPAZ0u6qebFFQwY5n5NdJC2Qq?=
 =?us-ascii?Q?pZDeSdO1PhrWZbZGaQvb0HLmLE5S4NHfzZ86oYM1tS/DxweDKSpS4B5YW0ST?=
 =?us-ascii?Q?4BxAkMCcsAm2npE3nwgWvUucEk9vc2nyDrVWsZ7ruDJ/wN4Tq4M9iUinxr+e?=
 =?us-ascii?Q?3RxOaiNeik3zIBbr2m5wq9CsV6I1OTgPYLfdG/FAV2lyxIYwyxpd0DNTqyhC?=
 =?us-ascii?Q?dX0RZeeQDj3TPunahU3GeTXKxzTm44kXgsr/h4te8S1I0NwA1Aw71E+RRqns?=
 =?us-ascii?Q?tE7tDjjgEM5UKWar1g2CWg0dUD/WOzAnq+Br5gEul/d+9TD1KCboFm2wsvLG?=
 =?us-ascii?Q?T2mg/sOvDkgYBoVUbArL9ZHscaIg9A0LHbYX2TCgTiOJqHfQFkA/FavBWcEC?=
 =?us-ascii?Q?6BBHAEiCB8wb+WjSSWjAl/+fwl7wKodumV0tQdvWyPO9SzA/sWD7CKspmFkP?=
 =?us-ascii?Q?kM3MsbmWfMPJGej6/ikLYUw4zpGMMuWck++8x8oy1PP9IaNLbxW2ngpOBzxA?=
 =?us-ascii?Q?u7ZcZtMMlUDfIq0TvE72P0hyZfWH84m6ruwpJR85c/I1Bs85YJ0Mf3WT7qXU?=
 =?us-ascii?Q?awoU+7jQTrbnTV99D8Z8v47JX6nzEadgUeEjjD1UWbsjkC7t0XTl9ihbABEG?=
 =?us-ascii?Q?vB0DKkGxbekYRHf/NHeceR35Bev/O27Imx4BvVZDjz8IGj0n2SzIm5vqfCxr?=
 =?us-ascii?Q?OVhoSS+0nz/iEQ42xbKOX23HtJw8yamhgWDx9f6pY17rj3Emt7mwttJsgsy4?=
 =?us-ascii?Q?hH/LqpHbx2qjsGokYx/xeEahXqp571teNOHgqwZVnG1k3D/v0Nk7NoOW95PP?=
 =?us-ascii?Q?tDz9+AoKPN674qjXyC6zkNNb6s4ou4Qwznj05Az/wnl+EYe7eo5MHNrMbNHV?=
 =?us-ascii?Q?AY6/tPBaAvqEae6jARwCtCem0Ay2KgLcuixGnKJg16O4E9SYPAEM0SGB8yap?=
 =?us-ascii?Q?facCBLqqhaDeHPfzny/Gh7+nxCIY4cpzt2RboLpDCVGDijkmCUa0I+gITzwq?=
 =?us-ascii?Q?bdqmkxUmoG1DuCMCITBo3681zacFQqyIZagxja1My89UWSEvqb/Bqrk/6d5Y?=
 =?us-ascii?Q?jxAgpX2+bu8DcQtnhjmvdtlqPxtWHa0M/cY9UzvnpUJeJ2iywoxpWv0cfDjv?=
 =?us-ascii?Q?6JKUdWqD3rstAcgFn23sziv79Yh5YrFZe5MzlT6mM/+cYD3gq7iF5yojAA7G?=
 =?us-ascii?Q?zjnpzYH4r2kWf/EWmPULpA1L9ZAG1Z+cg50VS2gfHA4Aydqd+WTno9H9/MLG?=
 =?us-ascii?Q?6A=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e2ed726-5bdc-4c0c-bab8-08dc1039db8d
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 11:06:26.3834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8pbzYQIymXzdkZ+CUofXY81hYUUI1qvwQJ02K/akrqOIuDpscSiX1yFhWT58MbUQ6nUlyd7+IDAXO9gUwGerEiA58oHx/6oVQPw3Zrn5w34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0701

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
index a7c4cf8201e0..1a2a4d2fab74 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16789,7 +16789,7 @@ M:	Daire McNamara <daire.mcnamara@microchip.com>
 L:	linux-pci@vger.kernel.org
 S:	Supported
 F:	Documentation/devicetree/bindings/pci/microchip*
-F:	drivers/pci/controller/*microchip*
+F:	drivers/pci/controller/plda/*microchip*
 
 PCIE DRIVER FOR QUALCOMM MSM
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
@@ -18587,7 +18587,7 @@ F:	drivers/char/hw_random/mpfs-rng.c
 F:	drivers/clk/microchip/clk-mpfs*.c
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


