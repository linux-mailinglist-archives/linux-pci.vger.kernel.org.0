Return-Path: <linux-pci+bounces-2675-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D87E83FBB0
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 02:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1CD81C2168D
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 01:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6898BD515;
	Mon, 29 Jan 2024 01:16:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2063.outbound.protection.partner.outlook.cn [139.219.17.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD72D299;
	Mon, 29 Jan 2024 01:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706491018; cv=fail; b=kdyWdYJt1H/I1E7QvyqiG1PLovH1qCzhYSEud6AeGCPouDVkqBW/sbfJAtQGK/0IHBT6UCuTUxHFI7ELr+AjhPojy3Bojp4jCallKN/ezpfQC3KorPZbyJHc2jRSoxneeOCWDje5Ig2+MjxqRz1Jn8JSwDc6+c2wZUsxErasvvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706491018; c=relaxed/simple;
	bh=6XCwz752cqas94FR5RuhUpZl6UqCr7+eaQv1gJiOKZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UkLSMPuYsKyhGgPhBfIJzEiuADl1sRTXZgSFlWHdgEzIVmoNVmnXWWmIRws+QRGuMbmW7dJa8nB8RXPZSTiEUE16xMDYA7mwtN89j1OUMjCtUp8QGefaoD0wmsTJd2YLSuX6bES5jnjZzvHaCSDeqLy9apcof2xo4McS2/nTwRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chhcm6OOOshjNOw/n502n6RTux7imGKr1es/O5x4EC3zt6XuDAvvlt8o33IsMQiFOCer3KQnl1HhdyWAPIpdz9bsj7XbCw93PAxa86NhQtgg7dy8jG/ovdnNcBGjPq0j2rYVqeKchxaduitXh4+UsxkuZCqbWcsaSabKr+9mtigs9eNI7UP626IyRHkUDzzRnQNq2s2XhNEWSSSVkAOzaqDKtUiIaChId45PdzsEr+PYaB4nifhdh56gMXcSc+66sII15Ri9NGQuxrcS51rKKgEFuAJ2eLiwsSYPZjcd2IdCnh1hpgttf0IiLzPHVoWDTNwHgqPPNupJn64qyL+kjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQxZhsQtPCBTQ2Z4oxeeYTZYEbkQfql9Jw52WhQ5GP8=;
 b=Ex1Pw1CSAMwq733koPIsIuNPnRtOzL44JbWWC2coux65kvv7KBcyJWcXacPt6wqCypgXUnuFSR/tYX3UJstoKSXIbxpaD2JcCewy2XRfK13UFGYtxsO7Qssw2W4L+6ax4lGSdHg12Bn86B5ZKrRuB+9Ce1PGeN7kEEcruUyI90VYl56anrxQXwJJqDXtfTRZRyb2yoaFce6e5PKV7x26KIPIO4EU4EjwaCgT7T6FB2zq5A7byF3OvJPEwK3Oen3rn2xpXpVthbmNPfpNyHtkmwdth6GfieN2waTzJo4CzBjERSNH2o9/yCyRT6OS3kdfsH45Inv8XKsg9M1806i9dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0630.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:14::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.28; Mon, 29 Jan
 2024 01:00:16 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::1ea1:19d5:efef:6fc6]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::1ea1:19d5:efef:6fc6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 01:00:16 +0000
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
Subject: [PATCH v14,RESEND 09/22] PCI: microchip: Move setup functions to pcie-plda-host.c
Date: Mon, 29 Jan 2024 08:59:54 +0800
Message-Id: <20240129005958.3613-8-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240129005958.3613-1-minda.chen@starfivetech.com>
References: <20240129005958.3613-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0010.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::19) To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0630:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eee3529-dd8c-40a5-70d5-08dc2065a7e8
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	z5qbqo1nPmaLXk8LiczpJsV00mkMllK3B7nEo3i9FlupimT2WQaLz4SGUmITUm6Na3y6HUwV53P8TKYZK1P3Fj4fZG5jwxd9uRje3lUaSn4yybl53niUeJaVeUju9Mpsa9ksQttTguddsiXWobcLXc4i4mIXl/+mzA4IjTd78TORaVO517DWL768CbyE00LpFBzs/sv86m/Gj+wTebnAdWSth375aXjWLWt4iMfOo0Q3bZtGhyBeivArGW6UCYV2o1oKNn+jgbnWj5zcIvKqpJtV8K6780o3jjDlfpcnS7cHw4GGwJd33Lwb5jBNFh0VEPl/qf3h1Kjkbjl0F4k5SiReguhUzDpEXaWS7oMMXKD64Hvkcx0y4BHskVK+GJgjM940bkgC+eKYMgPM5UU8kXGW+l1SGgIQqb6SMbMVXMy0sUmz0GIo+aP+KBF8f1s5gilN0CKb5OFubk4J03U0WkqAl+tq4dEFmOY8+sQnDlWzGXvBlNywUd7ot+ATvq6FbSqGYXDPhEgrCl+37Hk8j+9LZZ1F1mEq63q7zExgoCiqAuC90agW5eN9/iiRsjR6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(39830400003)(396003)(346002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(83380400001)(41320700001)(40180700001)(86362001)(40160700002)(36756003)(38350700005)(1076003)(38100700002)(2616005)(26005)(107886003)(2906002)(52116002)(508600001)(6666004)(41300700001)(110136005)(66946007)(66556008)(66476007)(54906003)(5660300002)(8936002)(4326008)(44832011)(8676002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tJ7tY2KIXrQ3yfnMAT2IO89r791J6N9/u4MjvjZJqtatpx0Nb/8MXT9tmGZ4?=
 =?us-ascii?Q?jShyk3uMqHqoeKNjWorL/Do7aBeP76pBI9UhrN7smUxneoN8NXsaYaxcxMHq?=
 =?us-ascii?Q?XimXEv+ChsDjKzSR2G6KUlLv2rngZVVmT4f86aDqOlK/klcBjNsZrhZh/NMn?=
 =?us-ascii?Q?Mq5+YM1qJ85oEpuV29/LYZpCEu5PsOOUQJS73O+O7H3fXOl0r89u0tzAmAic?=
 =?us-ascii?Q?8H3C7ObA467+24q29+IyoWiyB8DXNHysT5z13fvs744uVJMrouTDodqNR4j9?=
 =?us-ascii?Q?0SDEpom5gEAvRrM65Ajl/5H+gGFdyZoyJG1kpeo+RJzZO2OrBrEHgQDEVZ7Q?=
 =?us-ascii?Q?lTpkc83vZas2ijNQhkhGZ/KYmnotDwNHEEsrC18Ut+KEtKEJvKlzKsq1DbZg?=
 =?us-ascii?Q?1hy9pbj9onPp65gX46D4wIYOWy5dFT98tkp7p3KYEzdWzm1jJcwdqTEppJ+x?=
 =?us-ascii?Q?1rmfCd0Xtvk4NLzFELck5I6RIPpwtuWj1JOyCf12XOZ1OLy6Vwm05mvTqF/H?=
 =?us-ascii?Q?1Y2SOu4YkfTF/p18/mzBLhVJoIyRZ5ZnpaemIk7w/ZWYruFGftBEazpKIgum?=
 =?us-ascii?Q?Rwr8vPQks1UNGLPEyGeoFgvCP6zM4jvbE8rNI9kqzt4TM1JGqe9yMBTkKq8N?=
 =?us-ascii?Q?EZYTdPnXGUUHPUwboEs+tcw5mVwxPoqHzoZnhvfkwjhbHN9dYj/D1s3LDSEF?=
 =?us-ascii?Q?wBQ/yDyEYU0GW5atoelTOARiywrNAifntXuai+ZB2OIX8FztFDhY0kg9idLQ?=
 =?us-ascii?Q?wciAF+2TzlZKqZk5USV76rnnOtPZqQ/nH3mJvtoztvj97PoPK5pNk7Jwdndt?=
 =?us-ascii?Q?f/vEBkzcIbwvGYcY3h6Mtav4EXwtD2Rs6uVsVG11sg826zEzHciRWVGj7WQp?=
 =?us-ascii?Q?zvM6Wa73fcoMHbx08Fo5D7/rmP+Av3wiEFY23Uk4MQbigpIPshOrGC03Udlb?=
 =?us-ascii?Q?WTKwAjd/6xZP3famPf1ekT8NrbEjtvPAKSXbAoHYyD6aHvSIDpAvGaBJCCm9?=
 =?us-ascii?Q?jhgBw0Ci/KBzl9jFwtKwqzHu1W9i8xTt76JrP6JNCiOSJnLXLTgCAtelkk67?=
 =?us-ascii?Q?h9/i51bnGR6dwUfTUvAQmCeuY+PbkdBGcuvDjKMZw+bDNpiZZ3vk7GrM+tyo?=
 =?us-ascii?Q?waR3PO66BxDtBBkDbgRG1QD44UkTOJx3ilg9DgRw2gWFYO986NUGUa6NQT1n?=
 =?us-ascii?Q?rzmOp5FJgz4VYlVdENuP0HxDZvJATYLiKF9Nf3dIsqXt2p9h9QKiiU42t5ml?=
 =?us-ascii?Q?M83NMhr9Cf8P2vgvUN8p7XpzE+EXwhj1MalZGQlMLaS3qoCzt4ROWpIyQQ4a?=
 =?us-ascii?Q?IsUs4TX5XBQ9sdwI68M4ANJoMvdWGoS/MHISz1bqo3CCXLxgnXDL75K4EsmD?=
 =?us-ascii?Q?tvq2gJJ5Py924sWx2BiaLEsAhXIfL2zQQ05fMvHrfjO2Ry3wMmYRVUoPncvM?=
 =?us-ascii?Q?VfX8r8PWd217CeFv/O4SDHL5WT2TwDIhvmyrt378Lr/q+Gmi2n8BbunRk3/+?=
 =?us-ascii?Q?m8vIs9Pe67+be3ALYq1/lfvdjxsLUP27D6LeqUisTAnSAchos9D3Nwk2X4ua?=
 =?us-ascii?Q?843lep/mEgAtd9paAQ+mulSgwkZdYQe5cy+uFwLE59f8/lxbIZb7paZTihFu?=
 =?us-ascii?Q?CQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eee3529-dd8c-40a5-70d5-08dc2065a7e8
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 01:00:16.1833
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VNHhy1oH8/v32HTA+VuEYA52IYUpbj6b1ZaL9x9bQDRnSZ2vBSX9VK9Jb9ecg08Jx7rl4uBs9WvEkJf8p6Gm7MM0EFMGPb2BYT/w3/gYRrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0630

Move setup functions to common pcie-plda-host.c. So these two functions
can be re-used.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pci/controller/plda/Kconfig           |  4 +
 drivers/pci/controller/plda/Makefile          |  1 +
 .../pci/controller/plda/pcie-microchip-host.c | 59 ---------------
 drivers/pci/controller/plda/pcie-plda-host.c  | 73 +++++++++++++++++++
 drivers/pci/controller/plda/pcie-plda.h       |  5 ++
 5 files changed, 83 insertions(+), 59 deletions(-)
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
index 000000000000..05ea68baebfb
--- /dev/null
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -0,0 +1,73 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PLDA PCIe XpressRich host controller driver
+ *
+ * Copyright (C) 2023 Microchip Co. Ltd
+ *
+ * Author: Daire McNamara <daire.mcnamara@microchip.com>
+ */
+
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
index 9ca66916c609..e277a5452b5d 100644
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


