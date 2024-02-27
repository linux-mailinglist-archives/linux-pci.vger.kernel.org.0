Return-Path: <linux-pci+bounces-4111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D714868E67
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 12:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 803BE1C21C47
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 11:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F1E13A25C;
	Tue, 27 Feb 2024 11:09:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2115.outbound.protection.partner.outlook.cn [139.219.146.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99813139593;
	Tue, 27 Feb 2024 11:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709032183; cv=fail; b=Y1lqTp3aFHkpsat0uKsdt/krLtZN7NWcaLM8CLNOeYO4z7zcrhSSiuYXlNeF5k0n2CfY2H2FjkbYCrB8zCRGyaGLOXLsyrF9TwvP+x3VOJq4WgY+iMjpV2nsYT3CnPiafqfF1x6cpifQ7HDKA6aRTb8pZxZ9Q0aSrFaa2DigoVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709032183; c=relaxed/simple;
	bh=6XCwz752cqas94FR5RuhUpZl6UqCr7+eaQv1gJiOKZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dNialXBy2GYfPEZbEIRFfTy0NCIGqBiojxR3OKeiQChM1h5uM8I7z3WgOz3LNJIBOA6liUvkRimcoKKQgQpbo8pfHxbcXm+FbaNRWWPW1nVauM7LVPyGZq2LPj3Ep2SUFIa36jN+GjYZyiZFm91/g2aO0vonzhg2W4er6iZMQUs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iGHWwm9Ecij1VUBpYSFSEooXB5S4XF2uXyIH7TgLyJzmYdy3jgGsDLLRqunaEvE4tAgBykq7PLUNZgrgjVk/6uMJHc+92eMFVHbjDzELaeBVWIBAz0cUMHg8ceoGg2TfthAsUIV3qlYFesLtAzKf10jfmH5VV94xqZj9X+RlldsON6I1m7hVS+sqRIk6p49a3U68e5SuLhE4y8WVhRC3SGhGBY5cILgpImFhbp9AAPhaCxT4aL4kITtuzsMUlteAkh2HZuE1aswrHgGa8SX6DSGYZTLMfzphOTEQIXg0dpJ2sJtWWe7Ak+y58Vz+x/mvG6cxPYNE2gPJ4B3G9Re3nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQxZhsQtPCBTQ2Z4oxeeYTZYEbkQfql9Jw52WhQ5GP8=;
 b=mdRa3hYlDCR6baHsxNpAWLYtkT4epo2clWFSRA6s3+DBtbohaJT77C8YvMkWr/zwNVS9QsZxmR8uvRiDEFVgBNdm6VbR+DFpM/bDgizoqpelEN/xrcQVj8YptjIqb5uhoUEqAC40o9ENamvi7qIERND7/SAczbgkNg3lFlO1sYMEZKLdPV3VjRo45vUZjzLLfY7WS8hGg7A1r37N9T+ZkBE2WuLYQ9qHh4j3gFauLBrlz0lp1MpvYcjJfPZQSIRy9ILSHvmppy7PKIffThjTcoq2FG0PNJnsUA2RJOu/XnqDUE/ZiroMByzwhRK/z/cFOjcW0ux/BiAXl2NfDToWyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Tue, 27 Feb
 2024 10:35:39 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7270.047; Tue, 27 Feb 2024 10:35:39 +0000
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
Subject: [PATCH v15,RESEND 09/23] PCI: microchip: Move setup functions to pcie-plda-host.c
Date: Tue, 27 Feb 2024 18:35:08 +0800
Message-Id: <20240227103522.80915-10-minda.chen@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0496:EE_
X-MS-Office365-Filtering-Correlation-Id: 346a13a4-9cde-413d-c17c-08dc377fd70e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6+xmE/y128KLPuTOFPyj53E+NR7UcihNHmq2+BUoerGUObnaaSqrY58zuENPSstMuN6zs2m3bJCE825H2FF8IaDNsW+5w9zKFFg81WLwgvdnqO/6rVBr9u/xnsKBGYU15bNvmHPfoBiGI1S2CDI1vMMHiVFlyZgwkWvStU5xsc3YMVWWLOIoTqLIipaGY+M6dGHRGYIVHGnLjrPeRm2VCoEYiEfcJ+6Waf8oIbAwaMKDfpbkdNcY1fQOtOdj1QuRiOap6SnX9rXz7+W6HzrPmHahvEAdXMEaBY9/QFASGAcaMOr1bb0BtIrCsU56gOBTVEx9Nlu+WpUyHwpnbIVnSoZKgLqO2Y8osjO+0fRfr8DcRB4lMidNzYr719LtMFKBN8+PnfjorS4d8TLsLnGc6t1Baw1oY17TOa89gAtt2Bbka3WWfppqK5Z5g6iXR5LE8WA3sgKIEXiHOmWsw37CIHUcyauuHwtsJg23Xota0PBWxOhzZPu35lI2Xoj/SSfGZQHuarosTbEAq0MyoF+oaDomgBVrfx1Wts+oTLSvNF4sU2X7tFDnZiez2jLTphL3RqmRjvjhAw/94fE+YPZFY27WP8Xsc2781URiLrFT0Q8ceE2JUee9KGs2hveFHZNO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HaYP6XyWaaHOsN+W78zHSDqGGCp9RHuaTNQD2Bj+BaG7hNHZ4duPtol6HvBp?=
 =?us-ascii?Q?XAVhrcB6f9N4+dmoHjWk2paM3VsjHQqqzIotgIQ/m6XUig6hot2sxIIVEhMw?=
 =?us-ascii?Q?9W9uzSwskRZTnjgrVoAyLooS1rLeh086qHcZp+/ZvWRBuq/wQ3A4rhEd1HNo?=
 =?us-ascii?Q?hg1doAmz6PhiJX8nRrp1t51LW/0702ixBlpPSSSNqoPjo7wRsM4HzP+y148w?=
 =?us-ascii?Q?uCbwvibCCXHBv00j7kEYT6vVZ9B+ysu/wYbhAGiEPD0bxdxy5r5g/UkPXIWx?=
 =?us-ascii?Q?SJ6CzYFP8y2ebhVXwlyerIKxYO2Rvi7+5B56i9v9rZRx0T71zNUDKfR4Rl67?=
 =?us-ascii?Q?bilfUaXoPgUFii2L3XYvoUiCnYJCnstOezMj515CY5PPZI845SuRxunlitL8?=
 =?us-ascii?Q?o9ytfMYmcTAJzpT2F1NBhXhccXGZzwa6kv3iVQSQmSeC1tA5RH6YWtcdfnyw?=
 =?us-ascii?Q?fP79gG20YQ1D1UpNc/JRex7BKlRcw8oPdgZNcwDeIWYd5Dc+Fe3NOv81Fwhb?=
 =?us-ascii?Q?RzU16dX2MegReq9A1ZG48AIOC7E88jXZRjLHTl3Y6GUi9F9SC9hwQG0+uCH3?=
 =?us-ascii?Q?OLiIhzX+bADTn2oo5uiQ2uxOzPrwzN/Fi0g/7SrM8E0wtlX+A3JwtcCLOlEo?=
 =?us-ascii?Q?n9sV3cXTR8z/etr4t0k8TVr6/+5VO2QD3MWZ0xeK0IOegEDaDl6zqU07iqb1?=
 =?us-ascii?Q?HahgMbcdCYuxrGkncZb8j2Hvu9dBwcWHtegqf0jIRuesq0Bi91RCmrftcZP4?=
 =?us-ascii?Q?ZtM3DdFgnhY6PuIwZnuURzE1YI1jvYPQIcSh5iUyuQDt6EaWhFB2BHA0M+IP?=
 =?us-ascii?Q?M69BqzHA99H7xR3J5N6LIUjN8keEjt9IQ+u3ofXNOKTnn+DvBdFfmWX/kjWv?=
 =?us-ascii?Q?Ai6T+sXkq62N+hAYelIRViURtQHUJpR7A+b/m711sSGjfshBBd0gI+bxbtNG?=
 =?us-ascii?Q?4WrdbLX2lsJ+rFT9cZdAglmGzxzNxr+OWEZJKTA5gksl/wsl2mW6zsE/m4lS?=
 =?us-ascii?Q?bJ3NQgIs7fVOzmTI8C1u6Jtqj7XwiAgwpkYAwdl647P48IH/9Px77Uvarat8?=
 =?us-ascii?Q?AVi8+2l3E3yCGppzivxYCW9uk/mK6aqIX+kfV1ojwF+oxSM7207Mz+Q4N1NQ?=
 =?us-ascii?Q?OU3kFoY/0RwxC5h3JyyUq5SMd3S6rFhoQTiO+eLXEzHLZ+FLejwLJt/TBmn2?=
 =?us-ascii?Q?/qVj3/nZi/TGNiFMBVsEPHpniBUxKAp4PDw8YgMwYVw73F/VjhUrvc4mCtyy?=
 =?us-ascii?Q?Q+85I6/6QI4iVYQddAKyE3QAOTBo9lvQX43edQznMxyygAMT8EXXLzFZdlWm?=
 =?us-ascii?Q?fJxPscpmfpv+cQ5ybafytjHqwU7ZAeUrCt8D+rCcSpPkx4Si55UvFQjn037w?=
 =?us-ascii?Q?EaBbcp5wAyFO51h1aFnIzwJ0VrK6Ejzz9s27eW6IK4th+XhYH1YLIKSLimK8?=
 =?us-ascii?Q?mkxkfwAoT8BZLEr6CEbUjWie4ZZgMIqRN8kK/b+P/sfnfC5uSnRg/KQcjrja?=
 =?us-ascii?Q?VZpt7M55RWNP5lxQ/LwuWihrSBxGTI8JufYqduRX92sFTp+Bb5q/WHO+9eFx?=
 =?us-ascii?Q?/UvyAjro+MYhU3g75bGWepALz62ONm0ng6kDXZtTw9uPdYsF3Ll9MaY3U7T8?=
 =?us-ascii?Q?5w=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 346a13a4-9cde-413d-c17c-08dc377fd70e
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 10:35:38.9466
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5onbbw73aWqhHBpXKfUCA0CmzdmWHcMAVqIwTA9Iy9K19tx+FJPrgr+aRrmt+kOXhcopzAmRD9nMSgTotHPLej5oPbogbVcuFjogsOECkvk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0496

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


