Return-Path: <linux-pci+bounces-1790-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F70826C2D
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 12:08:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8294D1F2273C
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 11:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62A21429B;
	Mon,  8 Jan 2024 11:07:57 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2049.outbound.protection.partner.outlook.cn [139.219.146.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B837114263;
	Mon,  8 Jan 2024 11:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M/LjQvFQ2W6Ev7KkfMvU0SALTc4j3CmkfsezL7hxWyEZNkhjOHK8Kw50UlADKD8ReQy+bptrw8paj2/bHYANnKR0XDhhrKLdd9tnEEN7A1NMiESGNRXmn8UPAzM8TALCKFJWaHj53D0+oiNL4YkGKAB7j+eCnZhMyMVdiH44b40E8n13sBYqbXLu4RTvqB32B6JLtoczXpo4ELkjAjqfQu02qBc0zCeqr5wK23VNjgIeBxrfw6hjLGFMMSqhs03nw+kk7hDFdOsDDdJVffQvhQLToSB7delhNWg8ErcYLBswWZ4pInxvHHpjU6Zk+6lXFnv7Imr/GDBozdpgwUNrFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7fiHB4G130fEUHhYUU/w/UrdOiZUj/Jzca9amchxDU8=;
 b=VdVRWoipy4FUCuTTHJyJj0bOS79iLyZZguSzLW5i1LYcf2Ghi29ZHn8OoB/8Xk2FQ0SStEGuhjU9ZqjspDBCz6XY1OW3pzkiDKM7Jo3722aKL/pFmR+w6hI2VVhVSf6ESmjKQhiuYM9VznyqDZVerd/ivQAPe4pStHqR5jRd+h0HjTBgJdT0KhVlJj1D7duBApKDzcyceIqNLtRHt4fuYp83fo/rgvjCf5imLQRVPb5szc5qodznoGDZyBV2qkNi3zpa0SKCbHEzqUsZNzaeLB/OGd4YXXjmlHv5rPTXG2gFwMflL4w65glj24/FLt+jrk+isQv5iGn4RD48NxAWDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0797.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.32; Mon, 8 Jan
 2024 11:06:40 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::e6aa:baea:fd8c:4cd2]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::e6aa:baea:fd8c:4cd2%7])
 with mapi id 15.20.7135.032; Mon, 8 Jan 2024 11:06:40 +0000
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
Subject: [PATCH v14 09/22] PCI: microchip: Move setup functions to pcie-plda-host.c
Date: Mon,  8 Jan 2024 19:05:59 +0800
Message-Id: <20240108110612.19048-10-minda.chen@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0797:EE_
X-MS-Office365-Filtering-Correlation-Id: a32ed29d-ab97-4a85-1d99-08dc1039e3b6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WQFBbXVYm2FzURzMN4QUEE+k+SWzNzIs9FnZ70Ev+ljIEekgDjsycFPz4niyznyQgQFkINGivx1dpMd4LiHDs3SDrrYPjIngjmi2n/VI4on6l9XrffdvDDjHXUuTIDEXbYh1jpsuUJ5gNgeEc6GMVsGviivpkK5BFsgrbu5rH+59vQ7mWixeflUw5KwIioLkiv5bjGk9HVuDZE5ywYz+4D2puxKqFkgxnqq691bmKOha6aTlVNq2W9V2pjM+Qyc+yILUecvIM7omfx5KnahDdxPBKjyoImgJJdwwpvy6knXFhR8wjFPyUacFXhrCdFICMzmygG39bQhrRbm0T7MBLEJtemAVV4+7b6YOpUlyDKN0HRC8pD12W3/rLe/rgdFxtI50CrwPZAgXScw3x+OwFqF9ZSUiq7bl6pslfEVjjyx/5g0JDePqukcjgtwwJFZbD8oQ4E8t6W2n+xxo26uC0CRkesYrkZg2oWIBCcJxLVHBHTlx7FY1TYtLyuA/9HsuZixejEpcN7rxd2rkaWLErMxVPFCDI+DYoTHotfa/LU2rp4EhjDDEFbLD9eALl6sG
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39830400003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8936002)(41320700001)(1076003)(107886003)(26005)(2616005)(83380400001)(44832011)(8676002)(4326008)(86362001)(52116002)(508600001)(66476007)(6666004)(66946007)(66556008)(54906003)(110136005)(40160700002)(38100700002)(38350700005)(2906002)(5660300002)(7416002)(40180700001)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?CKOdCXYWe1EENvl3oMQLB4vvX+re0J/rv5l7IXydvlEpZX0YMurZrQy2PRab?=
 =?us-ascii?Q?9ySIDEJKRUiuZd5LvvauhRmgQb3zcyO5Qwn2pQhz9zYrbPkNLYqmm4kkDP3x?=
 =?us-ascii?Q?hhrqturEwmJoPOjQUUBy/r5k7WmX8vs6UglICEYEr95GFOUuFaWRpdar+tZs?=
 =?us-ascii?Q?XB+LmqCxXkFTfFO85skcL6tivWfJ6A/Qh2MsFn+mdXtzDySZFiqXcR5oXSba?=
 =?us-ascii?Q?zfl+DdpApfAo9Bqu1OrkeunOfgx5u4FZEsE4400Joz2kUPKHx9dJf8utUjNP?=
 =?us-ascii?Q?XVCvCukmDkNkoOtE4GqYM8G80v/I0UdDd45qm+qOgfxLVBz/+r4EzBfzU2lz?=
 =?us-ascii?Q?HIJpsC14o/kRdylOJ4bv+urVMmjdaWvi/R4vfSx3i8DOd+bu3wLS++oWpJtO?=
 =?us-ascii?Q?zG9gYyW2RK/GHJOOqw8WT+O+2+VdZ5JEHSrB4LZTVVDzLfzW7lRe818GvoGy?=
 =?us-ascii?Q?PPMjI4/k3HYi3gKQW5es9qdSJDNr3HjQ6BgEaGaBdTsDvbxwaRkHsl/fJPu+?=
 =?us-ascii?Q?C5NkrsJVYshHonQ+gXYpN+0lGwVHGxoYp9IfL3a1Ob9qz8nFt+YJbO3wBkVm?=
 =?us-ascii?Q?uOaeNdkDyQgEFTIfUo1g8dI6UK3o5EO0z5agT8anAIuOfy7zP6tq9aF1a8F8?=
 =?us-ascii?Q?ov176+VC3h1Gkte+YeQfQXTcCPe55YQ+p2zvHwotjO5WdXS2eMGhInx6Ef5H?=
 =?us-ascii?Q?lQesiQbLdKLFIM0GtERtSs7SsmXda/8zKl34Dlxi/41/zR+Z07CXFbuV1jw3?=
 =?us-ascii?Q?r7dbcu2TrUAmPRZowhvl9b/KDHI3dUQ/Gc3cjANOLd7dV6vYsPqwx4pEaeXR?=
 =?us-ascii?Q?og7unHIhnsTrYkqtf/sI1LHbPE0jC9X+p6qAI+m1vpTohyvV9sLrXDaM2N7p?=
 =?us-ascii?Q?Y/6wIOMcCtUwhH1gGNp8Ffm0pheRFiwZ8xUHbYgHirakYVBD3Qs3GBg8mKIE?=
 =?us-ascii?Q?RZiqelR1rjcoGk6/NxK5Far5Hkb2VOlPPB6kv4lPWrqEGFGerMa2CtbPhD6I?=
 =?us-ascii?Q?hZtPVKM8hfOZSiU78Vfb67Wpvk8I7+zsjKlgLeyOmeKkXTMpnjF/TCItc6Ur?=
 =?us-ascii?Q?nAeMn56GG9StnOBQvarw+pFpY7jhAyDfXsf+CVp7884kDXeJHKuxif9hDPwz?=
 =?us-ascii?Q?thX8wIojcZeBcDEqg4hajbL9jdBgoo3t+j9jqmHFKredVTsGYR8RRuar3NSN?=
 =?us-ascii?Q?kzoksZkXQMUe+82xI9qGDc46mnZkKNT07lurc2Yp+PCs2l3qJVJooTg6jc3V?=
 =?us-ascii?Q?a35M/iEHKJP77FqPkv8vkOjaefUrs+WC+cTu6YSeWw8/W6pU6DKeaxDkZZys?=
 =?us-ascii?Q?19wLt8XuQb2DUhz9j7f+xT/EuQXOzIUtxwl1EHxffvACTfK0BLwK0J6fApEi?=
 =?us-ascii?Q?X6b5v1yyjhf+8tJdh/ECPCoIUVGdex8YovBqJQhqrMcKlFOfz+WB2yMsGXGE?=
 =?us-ascii?Q?Rfcd/153Hh1dCB+BULbA4hI2AFY+oi4SlBZP+D+bMFXbPeZj5zNAH6l5DDuK?=
 =?us-ascii?Q?TGtqf12P/O0njxoiXK98cCxX9zEHSqAIlrUiBJmeasP1p0u1vXl1gJKR//0R?=
 =?us-ascii?Q?RMzytA5YwpLofyXG8TqAqhYMu5l2nvSiLhrjjxw8FCLdyEepdXvy1LYpRha3?=
 =?us-ascii?Q?Tw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a32ed29d-ab97-4a85-1d99-08dc1039e3b6
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 11:06:40.0934
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XYIfJx2ibJuSR3MczOcZmkw/nJm1fenZzfIwodFTHgH9igMcFqbc0ekVH6QLAuy0zkGxeNuWGP+ScXtKYaLWD43MI/gxeU1Ach31j+mcnVE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0797

Move setup functions to common pcie-plda-host.c. So these two functions
can be re-used.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pci/controller/plda/Kconfig           |  4 +
 drivers/pci/controller/plda/Makefile          |  1 +
 .../pci/controller/plda/pcie-microchip-host.c | 59 ---------------
 drivers/pci/controller/plda/pcie-plda-host.c  | 74 +++++++++++++++++++
 drivers/pci/controller/plda/pcie-plda.h       |  5 ++
 5 files changed, 84 insertions(+), 59 deletions(-)
 create mode 100644 drivers/pci/controller/plda/pcie-plda-host.c

diff --git a/drivers/pci/controller/plda/Kconfig b/drivers/pci/controller/plda/Kconfig
index 5cb3be4fc98c..e54a82ee94f5 100644
--- a/drivers/pci/controller/plda/Kconfig
+++ b/drivers/pci/controller/plda/Kconfig
@@ -3,10 +3,14 @@
 menu "PLDA-based PCIe controllers"
 	depends on PCI
 
+config PCIE_PLDA_HOST
+	bool
+
 config PCIE_MICROCHIP_HOST
 	tristate "Microchip AXI PCIe controller"
 	depends on PCI_MSI && OF
 	select PCI_HOST_COMMON
+	select PCIE_PLDA_HOST
 	help
 	  Say Y here if you want kernel to support the Microchip AXI PCIe
 	  Host Bridge driver.
diff --git a/drivers/pci/controller/plda/Makefile b/drivers/pci/controller/plda/Makefile
index e1a265cbf91c..4340ab007f44 100644
--- a/drivers/pci/controller/plda/Makefile
+++ b/drivers/pci/controller/plda/Makefile
@@ -1,2 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_PCIE_PLDA_HOST) += pcie-plda-host.o
 obj-$(CONFIG_PCIE_MICROCHIP_HOST) += pcie-microchip-host.o
diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index 805870aed61d..573ad31c578a 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -838,65 +838,6 @@ static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
 	return mc_allocate_msi_domains(port);
 }
 
-static void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
-				   phys_addr_t axi_addr, phys_addr_t pci_addr,
-				   size_t size)
-{
-	u32 atr_sz = ilog2(size) - 1;
-	u32 val;
-
-	if (index == 0)
-		val = PCIE_CONFIG_INTERFACE;
-	else
-		val = PCIE_TX_RX_INTERFACE;
-
-	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
-	       ATR0_AXI4_SLV0_TRSL_PARAM);
-
-	val = lower_32_bits(axi_addr) | (atr_sz << ATR_SIZE_SHIFT) |
-			    ATR_IMPL_ENABLE;
-	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
-	       ATR0_AXI4_SLV0_SRCADDR_PARAM);
-
-	val = upper_32_bits(axi_addr);
-	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
-	       ATR0_AXI4_SLV0_SRC_ADDR);
-
-	val = lower_32_bits(pci_addr);
-	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
-	       ATR0_AXI4_SLV0_TRSL_ADDR_LSB);
-
-	val = upper_32_bits(pci_addr);
-	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
-	       ATR0_AXI4_SLV0_TRSL_ADDR_UDW);
-
-	val = readl(bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
-	val |= (ATR0_PCIE_ATR_SIZE << ATR0_PCIE_ATR_SIZE_SHIFT);
-	writel(val, bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
-	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);
-}
-
-static int plda_pcie_setup_iomems(struct pci_host_bridge *bridge,
-				  struct plda_pcie_rp *port)
-{
-	void __iomem *bridge_base_addr = port->bridge_addr;
-	struct resource_entry *entry;
-	u64 pci_addr;
-	u32 index = 1;
-
-	resource_list_for_each_entry(entry, &bridge->windows) {
-		if (resource_type(entry->res) == IORESOURCE_MEM) {
-			pci_addr = entry->res->start - entry->offset;
-			plda_pcie_setup_window(bridge_base_addr, index,
-					       entry->res->start, pci_addr,
-					       resource_size(entry->res));
-			index++;
-		}
-	}
-
-	return 0;
-}
-
 static inline void mc_clear_secs(struct mc_pcie *port)
 {
 	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
new file mode 100644
index 000000000000..40139d998568
--- /dev/null
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -0,0 +1,74 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PLDA PCIe XpressRich host controller driver
+ *
+ * Copyright (C) 2023 Microchip Co. Ltd
+ *
+ * Author: Daire McNamara <daire.mcnamara@microchip.com>
+ */
+
+#include <linux/pci_regs.h>
+#include <linux/pci-ecam.h>
+
+#include "pcie-plda.h"
+
+void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
+			    phys_addr_t axi_addr, phys_addr_t pci_addr,
+			    size_t size)
+{
+	u32 atr_sz = ilog2(size) - 1;
+	u32 val;
+
+	if (index == 0)
+		val = PCIE_CONFIG_INTERFACE;
+	else
+		val = PCIE_TX_RX_INTERFACE;
+
+	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
+	       ATR0_AXI4_SLV0_TRSL_PARAM);
+
+	val = lower_32_bits(axi_addr) | (atr_sz << ATR_SIZE_SHIFT) |
+			    ATR_IMPL_ENABLE;
+	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
+	       ATR0_AXI4_SLV0_SRCADDR_PARAM);
+
+	val = upper_32_bits(axi_addr);
+	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
+	       ATR0_AXI4_SLV0_SRC_ADDR);
+
+	val = lower_32_bits(pci_addr);
+	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
+	       ATR0_AXI4_SLV0_TRSL_ADDR_LSB);
+
+	val = upper_32_bits(pci_addr);
+	writel(val, bridge_base_addr + (index * ATR_ENTRY_SIZE) +
+	       ATR0_AXI4_SLV0_TRSL_ADDR_UDW);
+
+	val = readl(bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
+	val |= (ATR0_PCIE_ATR_SIZE << ATR0_PCIE_ATR_SIZE_SHIFT);
+	writel(val, bridge_base_addr + ATR0_PCIE_WIN0_SRCADDR_PARAM);
+	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);
+}
+EXPORT_SYMBOL_GPL(plda_pcie_setup_window);
+
+int plda_pcie_setup_iomems(struct pci_host_bridge *bridge,
+			   struct plda_pcie_rp *port)
+{
+	void __iomem *bridge_base_addr = port->bridge_addr;
+	struct resource_entry *entry;
+	u64 pci_addr;
+	u32 index = 1;
+
+	resource_list_for_each_entry(entry, &bridge->windows) {
+		if (resource_type(entry->res) == IORESOURCE_MEM) {
+			pci_addr = entry->res->start - entry->offset;
+			plda_pcie_setup_window(bridge_base_addr, index,
+					       entry->res->start, pci_addr,
+					       resource_size(entry->res));
+			index++;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(plda_pcie_setup_iomems);
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index 7bec6a470758..3a17d8ab5bb2 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -126,4 +126,9 @@ struct plda_pcie_rp {
 	void __iomem *bridge_addr;
 };
 
+void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
+			    phys_addr_t axi_addr, phys_addr_t pci_addr,
+			    size_t size);
+int plda_pcie_setup_iomems(struct pci_host_bridge *bridge,
+			   struct plda_pcie_rp *port);
 #endif
-- 
2.17.1


