Return-Path: <linux-pci+bounces-4107-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F6A6868E05
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 11:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB40A1F25458
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 10:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F1B81386D6;
	Tue, 27 Feb 2024 10:51:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2095.outbound.protection.partner.outlook.cn [139.219.17.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F13E1386C1;
	Tue, 27 Feb 2024 10:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.95
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709031100; cv=fail; b=l+NAeBYZPSMvc8jMpMPdTKFAFTDzPUhcTTlpW4IHbS+0iQmRpN99svPLg/VWDyFFD3BX5ev5w9JUGFk1GOsEvVi1lKS8ZMwjBvEzCGOdrYqjyH9lItMJN+3Jx358pCwRVAeviYwUw4i18TqrB4xhVu+WoFm9d59xa6MXKbWQnKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709031100; c=relaxed/simple;
	bh=Wq4Z/mmbsWDKhaXfuZB64deZXyVlxQgOmWnGhLzld0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h7VYnoAUy8DJ+93XdIqgmzglcLQckpoobzW6wOY+I1LgStmMO//1aMBR4HIMlHz8EgOLwTeEEelM+d+I8K/4xMy7jDzhWucm0piy+km74sv/qUYY5no7FyeKul/p9FvVkjKNaRYOSKU1j9tI2y5YGzfFwYz9O9ckBTqwwE5B368=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XRSydzml7PWfEjpxMpP3RVZ6sZy/DS8rmqjmgNtQazRaY93FRJ8T8Y3t9fFHU/BK1RSPRBvOsNbvNqfCopv6JByIslaYzjxX1GrBXg2F4BMOPC3HZJg+SaQS0unPuk32cbEcxhS7Gnk6HpS/QCha/nGwS7V62XfBKQ2PH+Q2KGwVbEin4Clh9QRgjyrH5m/6miWwBA6J3XWuOW2rzN/ZVhyeZGf3GMz2QDggsFRAgOvinDp+BB//CqG7oSF/ysRcePANQvQpoEHRCiF0QDpunoG2FMMnaXE6sCGP0KgQGSs6Zv9jUWLqpCZib8ycDeuwwLeGbz6VwGg67rgKdmPopw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pc2T6SbVvFNGAc7jANlqkHZ/EYw1YXpAsFWAuojjcfk=;
 b=jA/hkyxMQ+lRW+YmqO2nfvazBQP59AQiIAvo7+voTHuP8R8EWC1X6aGRxPh3zKaAuiUWoPOkBo45UBYGcuJ/3aj9OgSPwXDFJ+uHKplLRK2OhoJk64MyyRoVVjPmmpYdQwjEPBrBi0RSVertPF9yuUzxy1Za69YnXYgw3BsSd1/yU9iYUdSra2rFWjQMr/uSJZ5DwrZj875R6+bbVtPuNEDXozytBY+waBF8Y1B6gBvCAKKpHak4o2/UOIe/L214Eedno/q7MohY76h46yZViRlFmDNRPZPu70HGPUaIPc9G+n3SJbXBiEH1qvyyBuOr62uPbLL6WgkLxE5WyMAsNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Tue, 27 Feb
 2024 10:35:36 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7270.047; Tue, 27 Feb 2024 10:35:36 +0000
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
Subject: [PATCH v15,RESEND 07/23] PCI: microchip: Rename two setup functions
Date: Tue, 27 Feb 2024 18:35:06 +0800
Message-Id: <20240227103522.80915-8-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: bd46fcfe-bee5-4f2e-738b-08dc377fd5d6
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zi6rnaXtmRZn/bUwzcxhyVmejHeE/nxK/JqjUCunaB7aIcCMDNmOKtmYzGKM76GxuKPiQMddUIDyDYRi+kCwC9gMhwkOknLd1IpynQazS06RlEUpCBCT8Za/WZKo5YGVo6sPt1cyDR/L1W1TdjVrI/0eKzzuXerIdNrtLnhLDLRAtCgbsIXJJF9zRK1ENQXjDpg7Znh278GV8cjBaGfzNfBfTTUhyMqpAlyMil4Tmy8teFJWEOZeOhQ5VnlDM73GE64rtKjsEOre31vtZTzxHTgDtQM/XCcNvGCrfcBAXHw2niwAZ/6lplU6+2nBKZusV5FOpu9NAUj/SVI2PJLYxi0BtpdJDNcU3rObSuAJydmYMdWU25ietl+dafl2X12osXH+k0yAKTQIyYunpcdfpTimeziBC/TqtlclvkRrSjknLLXkeENBCSTmy7rVQylj2WL2nWCkqjPIcNBhoNavrlAhggfZMLXOl+2Sbk2VEO9LWLMqWubYILc2ZXlKIYGarYLUTh9uLXhzdnwNnG4YCkkpLW4tN1vqk2b8mFwpIwQ4WXK70QTFXiUwWSipnUfNaRCQ+Wv6dgi009yoHuiXIeS33+cNH8im3xl600HgcWyLjXNGlk9vpI/5sVEE8/oc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ojHRq+fYKQpKbt+ldQi3ER3mpnMwjeJCxiV/wezm7uhpwPVMR4OkZ3GzAU3w?=
 =?us-ascii?Q?WTugtehvmwUNmqld0AVgjAe7waLf7phx0wKzML6BSmByTEkXSJAQZQ92wxzG?=
 =?us-ascii?Q?zTGtU5QV1fgu5n6e7x0shd1LnGm93F1y7quXPilHWInjltn57z2dlKcgQpTR?=
 =?us-ascii?Q?Tu9Sdq/c0jTSkTLmHMXlXIoewYEuTNx2CJNcuqSrLjhaBoBmyUHxng9M+L5v?=
 =?us-ascii?Q?msuTYS/SvsmN6+Va1MPemdp+JMRtIpGwY/ShlGFqluUmjvWNpSAqNUrN+2l4?=
 =?us-ascii?Q?DBZxWeSIA/OtGg/jldPmgL3syBcYTf1vPgYWnY7BmoxIMog9QYT1Bl5Kv55/?=
 =?us-ascii?Q?AwNpHqZrjHMeITAt/QltqcV0+3i2snBM7Bdd8yruDOBtet16qVCd35J7zw3x?=
 =?us-ascii?Q?FHS/Qfpk01wFjXgf4PD4IHP6v8gWDZkDIzTggXtKXUwoPzcew5ZynEqnuKBV?=
 =?us-ascii?Q?3qtalSQkvCmoOPAQHd8sVHVTI7NbXMxz9zj3fJPRarehT888tUvFbznfAWrx?=
 =?us-ascii?Q?ZKpnGRKVii9AvhDx935um8gq1OOM1jLv6Gr7T8I773VgTw3rtyKk+g6qqfW1?=
 =?us-ascii?Q?ePo7GpCbjbC913yMCy9W7AMVyeYiuSU9gbpNjguoYNK2315cxDj0UHxfx+kq?=
 =?us-ascii?Q?IQLYlr0VsvBtESIHq+KXy7HXG4gGHtM1R4rnQGz36nyOfAKBoxylxdpL4erV?=
 =?us-ascii?Q?5bTmwBhNc6DZGhpBEJbRGhZdMd2/bOXsf4sIjk7OyZ/mjGBf9BtUpUNQxbAN?=
 =?us-ascii?Q?Ref+YSG/5l2YBSPywF86AXO5gc1rvAhmE0A3Be9ORXIaNB6RnWvf5h6CcIdf?=
 =?us-ascii?Q?AWYRfbxg5+xUt4ua28ZzSJDXJcWa+LEQHH+3pUBtlrEvzYCjUNkExSSTV40T?=
 =?us-ascii?Q?1d8aI2qOa3KfKTQIC6orOeGQ6C4/KkmEbm5J+PDtyb0BnKoL8GaBv7luMuj4?=
 =?us-ascii?Q?JjFtsZG97F6e80P4lv/rEY+BABloTj6rOzqLrsWYprlVPWUe6rJ1k+r4AeZO?=
 =?us-ascii?Q?BxWIkgnmIfiYdRfXOr0DN0IsmSD5j7btCXJqTdWgT77Gi7Yjo/IbJEyXRvTh?=
 =?us-ascii?Q?jMQz5B/VVSFlpQyp/s+fgmaz4JfF1K+7s9roEdObvTAZa/7SShUxtHigivRC?=
 =?us-ascii?Q?tjN27bduTIuoHuxKmPRYC55G9lNBcxlk+xq1TQA5W0C8j73GpGE5QZ6totZP?=
 =?us-ascii?Q?ctNVXmm19LZzzt0WnC3NbrK1i4Kv3qFMwzpwfbnHBDTEzet4uHWJqSluCAfp?=
 =?us-ascii?Q?2k98gTfIszP7YiVmjs1u3wq4HYDKU7LSkoQqNmpGTSycKDB9+or8mPUKFfeO?=
 =?us-ascii?Q?1Db1Mlgn5KZwLSbYMNPE2WIPQXSkTOJRVoVplJSBueYJHwTXdJaDhbySozBY?=
 =?us-ascii?Q?7HCgeqLwtdUOGNK0ToKO6x1WgD/JzVf9IctpZHjgnJZGluoJT5DQ5JUGpv/G?=
 =?us-ascii?Q?vqvf9N/QmeUnUcdzWUxMKaJ55kNeUgq56ltrPUfhRWOvtKOScbf3pZN2odeJ?=
 =?us-ascii?Q?Xv0tB5y5PfHsBOPbKuzT9NGsORtOPUJy6Z8RAnkfhArvidkLa5naXTgmkMKj?=
 =?us-ascii?Q?aBmkbet1FbJ6566OWIMmbW+Sj1AgDZ6sz4w+QiEOWaq4hSccEd6hdgzGLF2r?=
 =?us-ascii?Q?OQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd46fcfe-bee5-4f2e-738b-08dc377fd5d6
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 10:35:36.9075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mf7aF14yOlw4CaQG/wKu1wK0uC7YMgAeCk86xhJsn3rykKmnOgfta5KLX3Vy9dGUQ8LSGiSboNIR/bszC804b5vN7rq9e1kulZQCGahPMtw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0496

Rename two setup functions to plda prefix. Prepare to re-use these two
setup function.

For two setup functions names are similar, rename mc_pcie_setup_windows()
to plda_pcie_setup_iomems().

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../pci/controller/plda/pcie-microchip-host.c | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index a554a56cc0e8..9b367927cd32 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -838,9 +838,9 @@ static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
 	return mc_allocate_msi_domains(port);
 }
 
-static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
-				 phys_addr_t axi_addr, phys_addr_t pci_addr,
-				 size_t size)
+static void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
+				   phys_addr_t axi_addr, phys_addr_t pci_addr,
+				   size_t size)
 {
 	u32 atr_sz = ilog2(size) - 1;
 	u32 val;
@@ -876,8 +876,8 @@ static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);
 }
 
-static int mc_pcie_setup_windows(struct platform_device *pdev,
-				 struct plda_pcie_rp *port)
+static int plda_pcie_setup_iomems(struct platform_device *pdev,
+				  struct plda_pcie_rp *port)
 {
 	void __iomem *bridge_base_addr = port->bridge_addr;
 	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
@@ -888,9 +888,9 @@ static int mc_pcie_setup_windows(struct platform_device *pdev,
 	resource_list_for_each_entry(entry, &bridge->windows) {
 		if (resource_type(entry->res) == IORESOURCE_MEM) {
 			pci_addr = entry->res->start - entry->offset;
-			mc_pcie_setup_window(bridge_base_addr, index,
-					     entry->res->start, pci_addr,
-					     resource_size(entry->res));
+			plda_pcie_setup_window(bridge_base_addr, index,
+					       entry->res->start, pci_addr,
+					       resource_size(entry->res));
 			index++;
 		}
 	}
@@ -1023,15 +1023,15 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	int ret;
 
 	/* Configure address translation table 0 for PCIe config space */
-	mc_pcie_setup_window(bridge_base_addr, 0, cfg->res.start,
-			     cfg->res.start,
-			     resource_size(&cfg->res));
+	plda_pcie_setup_window(bridge_base_addr, 0, cfg->res.start,
+			       cfg->res.start,
+			       resource_size(&cfg->res));
 
 	/* Need some fixups in config space */
 	mc_pcie_enable_msi(port, cfg->win);
 
 	/* Configure non-config space outbound ranges */
-	ret = mc_pcie_setup_windows(pdev, &port->plda);
+	ret = plda_pcie_setup_iomems(pdev, &port->plda);
 	if (ret)
 		return ret;
 
-- 
2.17.1


