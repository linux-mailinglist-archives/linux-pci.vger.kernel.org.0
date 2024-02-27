Return-Path: <linux-pci+bounces-4113-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9EE2868E70
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 12:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E06931C25171
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 11:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF3313A259;
	Tue, 27 Feb 2024 11:10:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2113.outbound.protection.partner.outlook.cn [139.219.146.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3466613A266;
	Tue, 27 Feb 2024 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709032214; cv=fail; b=R1V2/hjbZYl40uMZ9uaeKrmTCWtuhXWlbMIwYyat+fC9vPo+rocagrH3yobTILOliGFEUGJwy6Tt7DsQOA7xJkS5KQUEbtm8AVlrs3xhiKPNt86nKDdC43G8H9EB8yq/bstso1VJwJz+haSzy6A41wVIw0lck8YC/i4ZcrNbnjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709032214; c=relaxed/simple;
	bh=Zo0vtMDlUQnEv4z3jiAEPsEljhHkUDAsLY+wuNCYIJc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gutwg3TCZMAW5NVdFaEDrCAKTbGSxfQi0xfJwPzx2DKS7UPyQJgoeeEeW4DGgGsiwN/B3hxs7CCyEA/zug7StNO39V6W/8EDVWZnIUBFxrn1B8EnY7IC9ZImTES0XlvxVKmGloRiUdOudERewPIkt7T11K3+szo00w3u5RmqXBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g3YuO4/r2yECX/hnz/NhC3cnRoILptzKcO+nquc1HmnspmoqRdN5PGNxfKBvftGhMA8yMnFD+YH07JRwbgMRD1xu3nk6qLBQSmgoTKUccrQha1n+FrvZZDWQkOyiu0ham5EJI/JKi6lITO6FjVdm/drxvLrjL5uPyJaDInAdG2w7c4A5XRL8hxPj6qaYDFFNJZInIfS6FP6GcuvV5up1w+Z3Y8rK1Jxn0HA8VcyV8vh7ycOnML85UcOiVk7asBcA93olcpvszpvS+Ihwx7LTjcVo8PLUEBeChF25+kj3v98J1TBoQ7THDdfpJoJCrXdQ6S2n1A3BaIMu45ZqKohv7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nN9BSin22ElT+yVAKOhug7/CtveOW/fhCZdvxOLQSOs=;
 b=EqMhUQR9wlhydd4Eh0Ogq3Q9KlVfSQM0dxrD6mAYkz0Lu68sDp3KSwrdqniHkAYfARXIXpCBnBWVrfunkolZmQ5E6kESymMDEAdScjLzkebtKX441m1AomzIvhXCgXvn2CsGm6mp+Bb+TmqPTh2RItJ/b6/c4zFSjOkaKgYiTivGasS+1KcAQDM9OOLkO8KiSSgSdzp9ZzMJIBJlVUADMKe5zBHKU08yGBrqrRoDTBsBFLEt5WIDoVKvurZ+v0XVREhX5qAK/xSAvTs+YwIjU8fNKAO/9M/meQ1KCjAzsoq+HsFt9iHlMPg8YDIyM/iIo/GWO670GEy2GVsmlKdYag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Tue, 27 Feb
 2024 10:35:43 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7270.047; Tue, 27 Feb 2024 10:35:43 +0000
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
Subject: [PATCH v15,RESEND 13/23] PCI: microchip: Add INTx and MSI event num to struct plda_event
Date: Tue, 27 Feb 2024 18:35:12 +0800
Message-Id: <20240227103522.80915-14-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2152881c-70d2-4a6c-a915-08dc377fd9ac
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	96C7lgUenTdtXDu1VUDJrp+gtSQ+Af95j0xrk6DDlN0LhyTTd0s5QH+EiGperC9U18sd9YcwbLbML4uonYW5h/PArVM4W5htKYnDSe98SNLXYWVuHYq6Wg2gb9yGrAM9E3aIAiROHtnx5m4dFQ49ai7ZYgNJ+4ra4KZgxyHwCo+OkCIo1GJXVC+qrAxWDKmiJvuOFNOVKaQ1UX86QVpqIP1u8s7C5jwbg3Dn/dFVDr5hJOqnrHkvWsLhwa2HH24N5LmW4VAwMdtKC1pO8yPEIKfqEg++vwlzZEWm7rhuOyUYnzmynGsPyJhhGoaYjLFouVmpfNg09FpGtcBA2fAHqGCD5vF6qwMw5DZF39uXUJeTpgToZ3ckIwHZk7N0C/s/CBBPEjxoawreFuQOJbKDAF095PuS8doIdii89m+rQt4//VFj77yhmRVF78qOm8PyziICk1/qlUy5AG9I0HRjEHp2EtNDdigErXVF3jr+8kvpQGpjUG75C+W54SgzW8egxlqtALLQA9OF8WyE3GeGDXh3L215p0WvUTFSVuDDEznkWVPNuT6uHOAapEfHAsJ0Z7mAWQ5SfsKVsmgSBAyq+Ct3lGOkM3zDjo/HPuENqY32RgeswSwJqYXaBJ9K7fzh
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IkJs/QEvWhYSayu+zYXuuuq7nJy592eVGrJ7XVuFNCRvPnHCzKOyjc2fYhR5?=
 =?us-ascii?Q?BLjIoBOnB3O8ds8sdNzZYNBk+BvNcx2HXU2mhWurbvIONO4uI6oIkdQr2Sao?=
 =?us-ascii?Q?M1SpxNx7A/l87J/tYi3Hjp8dph6fgEkoNGf8dcKhvfrsUmayBus9GHxbqMv6?=
 =?us-ascii?Q?scsgGzSp9EkFCAJDDzhCxZ6MAxNPPuhSFx5h+DH6grV2Jn+nRBRJbJzEtLPl?=
 =?us-ascii?Q?HvNKWa5Y4m7R8H8yc0y+zvzhJdN86iQXfDFUl9Lm84M39ODfqugDrsTNjF5s?=
 =?us-ascii?Q?sE0QBRcUv9qQssbomnSIFqqbjE1tyhfX5G38tn4kg91KJ5OMrSRpRAVnSnko?=
 =?us-ascii?Q?gXKBpXtLljAxQYI30cB0GInA+qdubyeLa46BEacJOjJVdbsZrVaXzE4yWdzi?=
 =?us-ascii?Q?WuApILBM/TpL5C868OOrTk7ih3nq6PhFYSehuKwC7DAoIqM1picVUQb6wihM?=
 =?us-ascii?Q?pJhKzgZROjwIHb1zlvyqGVmuLJf29VBH28XfW4jMViNIM4sa76BLJX0yhkdQ?=
 =?us-ascii?Q?JFq2OuKxOQ1zIKiL/uNpr69A6/oGp0UI201Vzl0q+9e/eEp9YTYbkBGA0g2D?=
 =?us-ascii?Q?8H7cSFaVuOGz7PSxiU/n4dXxfkoYcafEhkenEqKftD+0y4XzxbIWBahEknB/?=
 =?us-ascii?Q?ND2b2DE+LiBs1pRlUZdd1/12pugSjjfDoDwpcZcMFP/HUD1vuBV5sRtABGg3?=
 =?us-ascii?Q?x3xxztLIAawQfLptTjvKx+IlASljk8p3/rzv92KlQRuaolNb8RTWllEXlqLa?=
 =?us-ascii?Q?8GBqHZCPyNfSCCsF43RAX9aR1oawJmmzN4eW4tkaN74rrH0OXi1luGC8PMI1?=
 =?us-ascii?Q?eGj6U45gmefIhERzlmu/e4NeQEUr25fv1xTlsgKg4xOJu9E9tSGOVsF0Wk81?=
 =?us-ascii?Q?Ci8kZnVeotO+TD0SeMCrgBK1Om1uqHoazC3U61V9pCo/90R9NHLl62aRGM/T?=
 =?us-ascii?Q?Nk0bztTZpbIo0ZqXikx1him04fxYOGiv2dJzIZUNy4RGRUZ3sz5v4Xvjj0ad?=
 =?us-ascii?Q?gd/irnuMpBK22eik078FuUALvxDyjrqQSv8iDVtizfizswbABvfeRN0srTmP?=
 =?us-ascii?Q?fN9Qte1CKTJZfvy8HdBPdIl/R9OjI7LuIDPV6+gKL0ey4URM27zTcyScvE+Q?=
 =?us-ascii?Q?hCjOJUszeMxnKYjVq2WlDKmXALQGnw36mrg5CAiaCpM/hrgQp9ZjWrpJTJG9?=
 =?us-ascii?Q?MCq9xt2JmbATnDlw76unoPLRe/eFhNW73XFqMH0Sq9IPhMgNJAjS0O2eQZ4J?=
 =?us-ascii?Q?GfyUDGZlb32sr6IV4rq4Bc77tUU0Xe8XeUYKqGPfc3YL8Hpie9Unr1BDbkKt?=
 =?us-ascii?Q?ivIMIP9WZ3XUxXZKo9zLch1r1b7IEwGn0qkus2jy4Uu86Fm5YICxpQkFuJdI?=
 =?us-ascii?Q?xOo2auoH1nTSeTkrGSuIDZ2nIIKNFhNcgxxWwOF6UGuRbvDcGIyDpssV5y8D?=
 =?us-ascii?Q?02HU/JIHKQBkDcXC0A1ikSl6fXP5QHJ75I9ECSJajW/seT3kUPzqV9M24UnU?=
 =?us-ascii?Q?9EgJkShlsKkzdqOxZjlaUUO9J+rORjTb+gxUH6RCokMjV0Csu+NF8wEd4X8C?=
 =?us-ascii?Q?uNWmt4nK9sPV7Zus+K1JvisBuDoKbp8f5Nc2T3Udl/YWiJAtrGuz0kxAsMXw?=
 =?us-ascii?Q?YQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2152881c-70d2-4a6c-a915-08dc377fd9ac
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 10:35:43.3181
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bLjmGd2n5R7Kvr+MtyMJBBEN86hZRDXsCkqqsXAMy5l+FCXBqbDGiZbvsZ5CAqyzDFo232+Jfj7GMV7LuasdoQ8eS5UUgW/Jb0TCYp38IyQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0496

The INTx and MSI interrupt event num is different across platforms, so
add two event num fields in struct plda_event.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pci/controller/plda/pcie-microchip-host.c | 6 ++++--
 drivers/pci/controller/plda/pcie-plda.h           | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index bf5ce33ee275..8a51d3aa7e88 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -817,6 +817,8 @@ static int mc_request_event_irq(struct plda_pcie_rp *plda, int event_irq,
 
 static const struct plda_event mc_event = {
 	.request_event_irq = mc_request_event_irq,
+	.intx_event        = EVENT_LOCAL_PM_MSI_INT_INTX,
+	.msi_event         = EVENT_LOCAL_PM_MSI_INT_MSI,
 };
 
 static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
@@ -960,7 +962,7 @@ static int plda_init_interrupts(struct platform_device *pdev,
 	}
 
 	intx_irq = irq_create_mapping(port->event_domain,
-				      EVENT_LOCAL_PM_MSI_INT_INTX);
+				      event->intx_event);
 	if (!intx_irq) {
 		dev_err(dev, "failed to map INTx interrupt\n");
 		return -ENXIO;
@@ -970,7 +972,7 @@ static int plda_init_interrupts(struct platform_device *pdev,
 	irq_set_chained_handler_and_data(intx_irq, plda_handle_intx, port);
 
 	msi_irq = irq_create_mapping(port->event_domain,
-				     EVENT_LOCAL_PM_MSI_INT_MSI);
+				     event->msi_event);
 	if (!msi_irq)
 		return -ENXIO;
 
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index 935686bba837..89172ce18237 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -130,6 +130,8 @@ struct plda_pcie_rp {
 struct plda_event {
 	int (*request_event_irq)(struct plda_pcie_rp *pcie,
 				 int event_irq, int event);
+	int intx_event;
+	int msi_event;
 };
 
 void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
-- 
2.17.1


