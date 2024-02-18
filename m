Return-Path: <linux-pci+bounces-3679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5174F85965D
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 11:36:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2C6C1F2288D
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 10:36:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828D83527A;
	Sun, 18 Feb 2024 10:36:38 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2135.outbound.protection.partner.outlook.cn [139.219.17.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2220C210E7;
	Sun, 18 Feb 2024 10:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708252598; cv=fail; b=hzPMr2FPcpFaapo6vSX7wmZ9n3jxyhzPpKrPTDvisiMjVWPf8nM5vxub3bS9AjVvsZdIFz8saYnw9/NL+J5IaiW3hWvbT/Fg7OMUxnm7KVLOJziLs2B1vjtzSJ0LAYC5LisfNKzwTfkq2SkOhIM5BXGiEbeJrzw6uFYbLS2m/vU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708252598; c=relaxed/simple;
	bh=eMXulEIdcFeZNVPJXZ9a+bqdjedikrB3PLgnFZguxSQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mTv6+og3+vsuVM0XMozAnWkbMflyY/EBPVeQyNDMr4R9g4jUjbcDOiediLPKulve7tLVhp01QoHo+ErSO9Gw5y4vkvxAm5ntT05Nx8MgVIGkAcH3ATkQ92bwTmB2aQ50IIuJfqJ09LgHvs0sr4PHFACrYVWZFV3jdTQKks3xzMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D6du/Nw94005xpKcvc370t+YikyKSoj/1Ut6DnSztz4TAszZjzujSlCM1xXbToA0Hd25XRkvz4EjoGamLw2kqBQjXS+XXKadcAPmxdXDCrTULaTqA/I9OC02JM1Dd6dmvBT99cExmvhoWKOBMLk+72Zl/rZQUUEWuvc7OBJDOeGPnXD1jjZs6wmleMVah9cdoRxcnPx5hsVupmT9RIyVh02Ur6YboW1Z3wO5fb5UPEy04nFn+Pz4y+crVpzHABdC23qtRR3zRpaWJYSdt8o4wOQ2mpVOudmcS0lBxrFPwkeTOVwZOBFn/fy9kQzRIiMSXRvroV7fzL900NWYcK7T8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRrm21BRcALG/c3V+O6g+r9icHsk85hPZnWqZkhA7Z8=;
 b=aTqnpUtTLdHU8zmG8QD3GkHA3JiLgN77gFbULAEoeyCF12Z+O+wWseTLIfipuzd4dPt/BWCDtL7vdolVEnxD7Lo1dzc/akiSug4VB/tUykxqykRFTzSjwG7Ey377GlfKUVfD7mBRAjlfjHPPxc2KPxLMVNYmLn5X/mT4g8cSHBXwaayu97I3/MApwzjzozdXXlNrp+t6J21IfyvuGVk3Jz07qHHdCh2jWZoiEKNjEOT87rY+T/XKFjT1SSvxWPFfXxgMudhiDHH4nHkwQ0ZWo1ZMHHEfTErIuctBhPZEU7Yk1r8qDHihajGr70012LoCXq0e0Dg51Jak5Bspun6k4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0464.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.50; Sun, 18 Feb
 2024 10:19:35 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7249.051; Sun, 18 Feb 2024 10:19:35 +0000
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
Subject: [PATCH v15 22/23] PCI: starfive: Offload the NVMe timeout workaround to host drivers.
Date: Sun, 18 Feb 2024 18:19:20 +0800
Message-Id: <20240218101921.113528-7-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240218101921.113528-1-minda.chen@starfivetech.com>
References: <20240218101921.113528-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0010.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::21) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0464:EE_
X-MS-Office365-Filtering-Correlation-Id: 229af3de-c65b-41b8-da21-08dc306b1b11
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v8ckrRPtX0j2XF7tx1lI2RQrqqWrNHT3i70bEguRg1HOYKuoQyjTO27EwKElXlZcvXgoGvzmYUPWpXNy2fICRdvGNjzVYyLD04QEfMRLIAegnCAQhUDOxGbsKHhxkFWXLRrF2t+0o05f+P5LBOdW1JE05uUhn4AlxgBA1vArEhjUwUrAf+w3NHEF6gIJeR/fknGRdeKURzsM5G9Ftz1dxDWs37RjpLUB+bYN4TdLW/9Bo/eTjIeztWCM9Ej6ngXYeItwn8qiN5pLxKeTfRJWEVIRPXmd+vqY2PLZE5zDifx8KrBzA4Ke0CoGt31Sb7bZEVfuwwnipbJI51H4Bt3mkQ3J6ofXDOehK8q1A5YZLK3EUhkcYYBILwjg8wD2NdjxTIFH1t0qsk6vTdmIk9+iZt2eHaOnXgeJUsTV7zTZTDyQMv+qgdwtIx2n8kGJ4rYNCBgIXMM2TFk0Yu5klOua//Cp7UAIM/DAphMisEC31iijT2BSHDABuyx6QItE5NmiAZlEhhGjn+Wfqh/fiYKS8+3oVzNPgO5DyJvYWiOy6dPeNFe0JxLZ9zAOqJoIWrdz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(346002)(136003)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(86362001)(83380400001)(40180700001)(40160700002)(38100700002)(36756003)(5660300002)(41320700001)(38350700005)(7416002)(2906002)(66946007)(4326008)(44832011)(54906003)(66476007)(41300700001)(8936002)(66556008)(8676002)(6666004)(52116002)(26005)(508600001)(110136005)(1076003)(107886003)(2616005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l4Pfh5CYzOcdzvU/kbIlWK2VZ497ITSpBQH7wV0T1CUtRUbIdE6qKEGCLyfM?=
 =?us-ascii?Q?H4jiB+5pdFSJEO5KjTCqGRKLooxDZTBBCtxtXcbkJLyoZ00NVzQ0DYvmkuaK?=
 =?us-ascii?Q?KWx9Ky/nb3PfNCZgD56nwfT3jTEbQYMtJWlFBPfq18xcehqfs33MAFqCEcFZ?=
 =?us-ascii?Q?WDJNZQTXhFSTZIGSB0+/6Wf3+aw35cyJk6tO0W5f7TXtmOpWzX1dVdn+GwSU?=
 =?us-ascii?Q?Jvn3YAk2GgROPZdLt+kTIK1ilD2Hz3E9oBZ8su7vzynXo6MLCG1K/1unYKFQ?=
 =?us-ascii?Q?1Fc5U81MoWRekzBtCFvYIYXDr44tAPlJTK67FN4Yz61avAABL5evBLsNcnHI?=
 =?us-ascii?Q?EIuXPLgjETD6ctxM6QM+NAGspNzYrko0t+welvo4CQzUBDH8x4Z3ps1hhtPI?=
 =?us-ascii?Q?g7Bb495bzGiHVBFVSXXYdE222X1/lH+XBtsVH9Rnf+NI/QwpLa1K4efWJwjC?=
 =?us-ascii?Q?5nNqJb5dI57wIMsxeo3dNrlr8s4v/1w1oASbEdZQvyhr+GQ/2YHWbDJ44fqB?=
 =?us-ascii?Q?49Q1Yz//Ap8OI2D4pDfZKf5/Pj0BqH2q/psuGl7kEG1lBwrizvlNIpsPlDBP?=
 =?us-ascii?Q?md9SFvTXJilvPjUmyZ7h7liv1xqqGso2ce5KCEv0tFjKwk+FbjXfzUNHTD7z?=
 =?us-ascii?Q?plykmLIlRUZTzp+hvymMsTW8kRTHwmp+FKnSHlexku3DPNsLU/Qji6/2n+ky?=
 =?us-ascii?Q?sjZzxZ49+HmMh2kNoFEhFbX8eWe01atiNnbXdGqcGmQGm7WEDkraIl2EDI4c?=
 =?us-ascii?Q?VTunZXzHiMXB2QFFyJ9+eQalrclPgQE/e7KAk91Z4Iz0voM+5whTCLet56lf?=
 =?us-ascii?Q?vmHB9DOezUlkn5S0YCqezzzfKU+bNDirMtoYCZd9gHhJLq5lwZq2PZ7kJZN4?=
 =?us-ascii?Q?gInxsA8HvIIpVoHBgDS8iuEiYXmSMcwu5fWrg6Z/YZF7tbV88AkV3BP9h9lo?=
 =?us-ascii?Q?W/vOcwYtZtxpQDpUb52gqsIkNPZUdckFMDMgZU5zs7COEgP9LuHCDC4RwGoA?=
 =?us-ascii?Q?EvJlJe1JAZ9aZOULyfRotbC/AciV76zWKNiMYd5blsj7XnWcCTgKrZgS3O7S?=
 =?us-ascii?Q?Ue5AJJ2ZWpsmC5zf1zssnvH59Xyusufo4RUkXDa1oi0WaFtwklOC64GKUg78?=
 =?us-ascii?Q?7J2u1rZ9sLYI9PTTzsCF1T6PGYavUkO/qnnNJ9ZITHwrrv7NckwN1X/pUrJP?=
 =?us-ascii?Q?XtHjLq010ZFv5hvEm6BWgSznlPTjgfouH77+YdUW/Y2G0wad02pyMpag/BUr?=
 =?us-ascii?Q?dnXZIY15LJqJMB1n7yovLRdSWhUVlmnJHFyrL/9GTyk2Y32C35WHBHp51vu/?=
 =?us-ascii?Q?GAucP2kSa3N1KRA2UD9huTFhddQ+/ZVytTDl8nz8PMWfkFkGIRY+W2/9D1am?=
 =?us-ascii?Q?w62gnOxPvIzt81mvaEGw4Pa91I6S+24aRWkK3Up4egX3Dsie8Z/T5CA/6bV7?=
 =?us-ascii?Q?5vPktfAvMfbga4pU+hpXkFLCWkr17UfxCE1/exylpYaqeVzFh4uCId/sGvL/?=
 =?us-ascii?Q?HyO7V9Zmgosukrrj0elD+C0fEi4WbvBaE20MYL/7iOY8IXgggL9LW9PWGxNZ?=
 =?us-ascii?Q?QDlnPcDx7RtewuVmeDL0QqAkI1+4kl9rntwucgGvyScPa9Ppe7xshzgGoQov?=
 =?us-ascii?Q?eQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 229af3de-c65b-41b8-da21-08dc306b1b11
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 10:19:35.4870
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tdYZqh+6A87vzTOJOUzH45BN/7aqqEd/E0S2tBpqIrmIPzdmahOTGdBSWeyf3ZWXPYcxp8arXX+C+TxmubeqhD0tHqgscQOBdXApSDHSXDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0464

From: Kevin Xie <kevin.xie@starfivetech.com>

As the Starfive JH7110 hardware can't keep two inbound post write in
order all the time, such as MSI messages and NVMe completions. If the
NVMe completion update later than the MSI, an NVMe IRQ handle will miss.

As a workaround, we will wait a while before going to the generic handle
here.

Verified with NVMe SSD, USB SSD, R8169 NIC.
The performance are stable and even higher after this patch.

Signed-off-by: Kevin Xie <kevin.xie@starfivetech.com>
Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/pci/controller/plda/pcie-plda-host.c | 12 ++++++++++++
 drivers/pci/controller/plda/pcie-plda.h      |  1 +
 drivers/pci/controller/plda/pcie-starfive.c  |  1 +
 3 files changed, 14 insertions(+)

diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
index a18923d7cea6..9e077ddf45c0 100644
--- a/drivers/pci/controller/plda/pcie-plda-host.c
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -13,6 +13,7 @@
 #include <linux/msi.h>
 #include <linux/pci_regs.h>
 #include <linux/pci-ecam.h>
+#include <linux/delay.h>
 
 #include "pcie-plda.h"
 
@@ -44,6 +45,17 @@ static void plda_handle_msi(struct irq_desc *desc)
 			       bridge_base_addr + ISTATUS_LOCAL);
 		status = readl_relaxed(bridge_base_addr + ISTATUS_MSI);
 		for_each_set_bit(bit, &status, msi->num_vectors) {
+			/*
+			 * As the Starfive JH7110 hardware can't keep two
+			 * inbound post write in order all the time, such as
+			 * MSI messages and NVMe completions.
+			 * If the NVMe completion update later than the MSI,
+			 * an NVMe IRQ handle will miss.
+			 * As a workaround, we will wait a while before
+			 * going to the generic handle here.
+			 */
+			if (port->msi_quirk_delay_us)
+				udelay(port->msi_quirk_delay_us);
 			ret = generic_handle_domain_irq(msi->dev_domain, bit);
 			if (ret)
 				dev_err_ratelimited(dev, "bad MSI IRQ %d\n",
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index 04e385758a2f..feccf285dfe8 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -186,6 +186,7 @@ struct plda_pcie_rp {
 	int msi_irq;
 	int intx_irq;
 	int num_events;
+	u16 msi_quirk_delay_us;
 };
 
 struct plda_event {
diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
index 9bb9f0e29565..5cfc30572b7f 100644
--- a/drivers/pci/controller/plda/pcie-starfive.c
+++ b/drivers/pci/controller/plda/pcie-starfive.c
@@ -391,6 +391,7 @@ static int starfive_pcie_probe(struct platform_device *pdev)
 
 	plda->host_ops = &sf_host_ops;
 	plda->num_events = PLDA_MAX_EVENT_NUM;
+	plda->msi_quirk_delay_us = 1;
 	/* mask doorbell event */
 	plda->events_bitmap = GENMASK(PLDA_INT_EVENT_NUM - 1, 0)
 			     & ~BIT(PLDA_AXI_DOORBELL)
-- 
2.17.1


