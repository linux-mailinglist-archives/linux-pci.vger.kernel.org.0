Return-Path: <linux-pci+bounces-2679-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0600183FC45
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 03:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0563285E25
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 02:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029A7EADC;
	Mon, 29 Jan 2024 02:34:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2081.outbound.protection.partner.outlook.cn [139.219.17.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE261E87C;
	Mon, 29 Jan 2024 02:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706495645; cv=fail; b=Y6iNaGiZQzTGXd3pdOdorVjsArWGdyMpX1H4g941IsAOoSgnp/lECvaZDugKJiFgp3zPc74YL9rI+m4ubTvwmciCky6vKKITNW0nCxWOEBG5Jn+OeyHKd7h+hVGpBbeBlotaN1xPR9zCdadGBKNqb0EPDVceKTGhqq2q1JMMt38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706495645; c=relaxed/simple;
	bh=/4PccNbWjjS+4Uc+iPMog5YcbODT2POYLU9j4TmmDl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=h/BHUMzDyeGIE0sNPFK3mE1WguOubI57M1hWRr3+GfTq1k12VorM7aHRar1XLTNpZSTvj/gVwaRjVmROYk28CkGq49CqoseKxbtxDC9mzTxXqswv22DYirlzsWeqdFqerYTakcn/0GbKUAQ1WPBsMnxl+guQ0gTvlU99mZrWjXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HucYDtINYK9ChABRao0CketMovrFc2tmOwm339JtreyMR93cDou+/+Ga7IG/6PrGc46IbP2MqDGVylv75WeH9qn5piR19S8uOjPZShIJqLWtc6LjFaDEVdPP4BJKbzwzdhp8Y3B4Lv7JlVtA9V/rtgM/47g1/2xZDm7q4Iqq/rcsQL0UYdXWY7Xersy19iwVvJXZoxUn86g0DWpK1e79At2Ppx/bFukc60P6UjhciVzvY7lGWFlXfI31Itb1eVAtApx59mXqua3JYobQV2TTNYv1qUq1oFAXFLm+RjcQt2u/gEgNo9pfG4NEHmxIvisTYLNBLmH2ltS9wVgF4THTVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qiqHj4APLQ+5sb97w44ol5KWqweOs8B8Tg2C7Uqvdm0=;
 b=JHmQKTNruuhI3QDVYpmH+X5fmwz+3nI1mRW0vyi+HH7B8eMRXL4aM7Xls3ZKAyFc/1Uyh9WBD5PoKCWuHHaZu1hWDop2eT0y35/7nQ0W6cjvkWWZQuzW33OXCcMGCsxDQyWHGQuZyP0e9AuiKXhYcNHBajd76MSFZqWL9LiPBePmujQ+V9Okw/AEutMv3tmxbkwinexuMXvA+yW//HPH6PaXWFT79lhxAGXDxSroSa1FsdWDccFFde6E0t+2VRk5BsZoyfWvFre3lFNqA+lQb2OwhExtufxSp8lBPTTgDbUCQWyiTracHfheEKVW37/gNwZH6Y7FWVSoyvHv2k/01Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0552.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:13::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Mon, 29 Jan
 2024 01:00:18 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::1ea1:19d5:efef:6fc6]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::1ea1:19d5:efef:6fc6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 01:00:18 +0000
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
Subject: [PATCH v14,RESEND 11/22] PCI: microchip: Add num_events field to struct plda_pcie_rp
Date: Mon, 29 Jan 2024 08:59:56 +0800
Message-Id: <20240129005958.3613-10-minda.chen@starfivetech.com>
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
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0552:EE_
X-MS-Office365-Filtering-Correlation-Id: f4c5de45-dd09-4554-e05b-08dc2065a984
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AvgVLtwPFIIuqEeqVl65teR8ecWcPxgDn8qo8mm50J7w7APpnLhkrjIdYUlG+gzYckt0OJ5o6LHVn2PrFNA+5yIOVY3IPIduRuQSKmmtKB2Zoptw9MDpwUxu1ZcGfMNJE6tmN3I5KnxYnIS/k2KF23LQcmdTlCX+o1db7euTQVtmWZyBbIYRWwDZkHT6y+JWhPWeeuSxCGWR4UgwwE40mmxnh4aIIEtXmmzDCoFyfXZCBmdaFou74KdRPZ5Gyi3ouhlSQFlrVEUDcoBLMiev+zhLtoJOygfcbTaKxOjFEBhpEvq18fV6DTkZcDg8Fwm4RiAUKOOn/2VwhxhcvxoFbOrLYqyE48kk+Qq0sMBgYIoa9/SwRZilfsv8BV3hm2T+kbBIsy2GjvU+g72fQxQ5USkiR7oWnhJmRHoEwJQ8xGylCrZCiotJfFbyP+xP6vtYyJkPlMt3Q1AeJ0eyMeSHPCIEt7xtKpuFezwk6Gf6azmog7UBiO2yv2vW/3RxH4ifRLbqcLQ0D/1w1VyzSeVXvJWqpehTtUJIRhTlje0bJ2aOc+TUw3fz9svlyhnpSPoo
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39830400003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(107886003)(2616005)(1076003)(41300700001)(26005)(41320700001)(40180700001)(40160700002)(38350700005)(508600001)(6666004)(83380400001)(54906003)(52116002)(36756003)(38100700002)(2906002)(66476007)(5660300002)(8936002)(86362001)(66946007)(110136005)(44832011)(4326008)(7416002)(8676002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QsoC66fd1Y6JRISLmHoOsCJhOYNYs6pteYAnolT/gvDb3+qsownihOAX0bdz?=
 =?us-ascii?Q?3Hm+if+HUZgCC04yg6yPr5Pxyqnv9bL7sNANcYBNgxcj+RU/mlR3geTcLBIx?=
 =?us-ascii?Q?5G6+oLv/aWvp1zDglATY7+tO5KIVZNgsuIBtceujOKxBfal/N5DrvZM5Iyh4?=
 =?us-ascii?Q?KPin/NfcjMs8SXLvgZ5DQOOoFq0a6bwNItXNLec4AmXQUJuMInvmPU8TBVbZ?=
 =?us-ascii?Q?hREQHqbUPG5+OYBX5uInw4e76jOHXUrPqbJNHRjMmQ3msudpcTqtCRTZFdho?=
 =?us-ascii?Q?8Yqp6RGxQIG0fGU7AuuabcyusXOzQDdrev9s8ZCmH0396LoVJwOorToREdw7?=
 =?us-ascii?Q?rYncMBqsG64+sdbxhpNh0rQZyS5NXxz59UzYvu8cXldzbQOJmLDgNFIh+mBO?=
 =?us-ascii?Q?vR3XFljAifJiL043nUFG2FFheuHU45rrQdNEkxWfyMbIBlQyhRdNsWDZGNai?=
 =?us-ascii?Q?T6UMsYdFoUgFV7tMcNcdC+uhQTybdHnahhOk7OyV5vExm0j25Qtl6JGyhTxC?=
 =?us-ascii?Q?Ct2HtClrAMtytvg0zsGaNw4YC15QlXtcC5n/QUai1x/T4iaQjwY5FTm/Kevx?=
 =?us-ascii?Q?8DghFGinJZS/DWhl/32Fb0xNznrzvFxHznupqqYVV6mqjnJVXXNv4QhNb46E?=
 =?us-ascii?Q?0oUF0qf+bqYHvKIdqSkX5NjP39Y6ThyVvTBMRz0BWfSzIIj1hGEC0xFgIw2V?=
 =?us-ascii?Q?rMkK9an/VmuQUxCUNeecaxzyoUV9qh1LY4aLzThPaNxeipL5HD0wU0I4Ckmh?=
 =?us-ascii?Q?ceSqGDyFUxAQZGHQ8MEkYEacB3CKeIKJAw9cPB1A5cf/Tmos0NjthM2Vh1hU?=
 =?us-ascii?Q?LqrAdANTOjTh2Joiq6ghBECyw753pgaVcB4ePDy4BNc5dF5kEjcGXLEa/bR8?=
 =?us-ascii?Q?EXL6xYKfLXjU7gXXlDhFHu/NWnvHHqsdAW35DXgLMHz1IowdIru3tQApmgPl?=
 =?us-ascii?Q?knJtPR9D8BdfpFYU7RAU2r+8lw0MRLZ6tkZoiKV9iDFuC6oudcIc6BfWg8GM?=
 =?us-ascii?Q?hJZ1GdvSWlOj6dOkYrA4WzmajtdBJh4Iy4gb76kInFl/lYXrx+0EXSO6Ecze?=
 =?us-ascii?Q?cvWRuu5q7b0izG63SGdLWR9GGJ9atCzS0P/3lMOVVb+GFJmSWAbuxG+Cyc5l?=
 =?us-ascii?Q?/Clo4opwztsRdlsJckEmzRp4FqaE3aDYVPOWPYN8ULS9W8bbVNT9OmlkngBv?=
 =?us-ascii?Q?xjYTTvCUJcSrYAbQkqanS0Amd3IeNsGvb3KVHRPekmiumTsE/F8D9amSZvrl?=
 =?us-ascii?Q?ObuFERwEA76UAGLw2XcnL7v0pAviGdHGGcVRD96Yk/dOsLNuPnvRqYrp/qM1?=
 =?us-ascii?Q?l69NSBDwtzCGAPEEoBQI2y7IERGIRn9PmAnnBER86MwJ9/tKRB31Hye00TQ8?=
 =?us-ascii?Q?GLvu1Rn0m06/Q4Dm8siDg/suaD2fbjFb12JANXPxapHH3SnLW3f1L0jeg5D3?=
 =?us-ascii?Q?vsTV5biYbrMbrMMzm8b4bbzWiT1EA8EvxEULX5fcHHhEgR8oEVjc5oqmY3XQ?=
 =?us-ascii?Q?+zipKbPPQJO6Lx36S8A/EjmmCpXKWhIOZWFJU8v41ZfuBPmAFJEwH7VhHCUA?=
 =?us-ascii?Q?e+k9pvJifWHF/2/6rul/uWzM5hfvzAcsl/LACoCkYL8dcuBKRYDQVJLKupAT?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4c5de45-dd09-4554-e05b-08dc2065a984
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 01:00:18.8556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aBskbvOvjcgmqP7VmNpV4M1qAE8fElRehYWuECD4bE5YbPsQQUwqB9ioJrosdFxC2gashvX8W6xXBDH1KfliH9+f7bHoeHCU7Dr1QBplZoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0552

The number of events is different across platforms. In order to share
interrupt processing code, add a variable that defines the number of
events so that it can be set per-platform instead of hardcoding it.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pci/controller/plda/pcie-microchip-host.c | 8 +++++---
 drivers/pci/controller/plda/pcie-plda.h           | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index 18bc352db389..0a5cd8b214cd 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -653,7 +653,7 @@ static void plda_handle_event(struct irq_desc *desc)
 
 	events = mc_get_events(port);
 
-	for_each_set_bit(bit, &events, NUM_EVENTS)
+	for_each_set_bit(bit, &events, port->num_events)
 		generic_handle_domain_irq(port->event_domain, bit);
 
 	chained_irq_exit(chip, desc);
@@ -816,7 +816,8 @@ static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
 		return -EINVAL;
 	}
 
-	port->event_domain = irq_domain_add_linear(pcie_intc_node, NUM_EVENTS,
+	port->event_domain = irq_domain_add_linear(pcie_intc_node,
+						   port->num_events,
 						   &plda_event_domain_ops,
 						   port);
 	if (!port->event_domain) {
@@ -920,7 +921,7 @@ static int plda_init_interrupts(struct platform_device *pdev, struct plda_pcie_r
 	if (irq < 0)
 		return -ENODEV;
 
-	for (i = 0; i < NUM_EVENTS; i++) {
+	for (i = 0; i < port->num_events; i++) {
 		event_irq = irq_create_mapping(port->event_domain, i);
 		if (!event_irq) {
 			dev_err(dev, "failed to map hwirq %d\n", i);
@@ -1012,6 +1013,7 @@ static int mc_host_probe(struct platform_device *pdev)
 
 	bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
 	plda->bridge_addr = bridge_base_addr;
+	plda->num_events = NUM_EVENTS;
 
 	/* Allow enabling MSI by disabling MSI-X */
 	val = readl(bridge_base_addr + PCIE_PCI_IRQ_DW0);
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index e277a5452b5d..f7e900b395f8 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -124,6 +124,7 @@ struct plda_pcie_rp {
 	raw_spinlock_t lock;
 	struct plda_msi msi;
 	void __iomem *bridge_addr;
+	int num_events;
 };
 
 void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
-- 
2.17.1


