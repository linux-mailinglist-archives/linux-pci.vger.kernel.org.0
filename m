Return-Path: <linux-pci+bounces-1798-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4895D826C89
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 12:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E18FA2834DC
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 11:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C832514AA5;
	Mon,  8 Jan 2024 11:23:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2054.outbound.protection.partner.outlook.cn [139.219.146.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5958210F2;
	Mon,  8 Jan 2024 11:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/0N8jo5K2ZhRC0mR5xHTeYBV9vdKnP6T+0lpBuf6yS0yrnHegIvlLsl/UYkepVWYzhQTUrI4fVE0nepMBfENlqvgHhmUNY/Lv7SjNv/Kll/3HmWqrihTsnHwEy8tgswOem8MfPTJukzJHa4XgCGwPjWj8UozIhA+7Qwm3JALzWncPuDOZAvobc+aLOLrGPyjiJE99hEruNNEpUpopsj2045iSBbpbxaFAloEEn3zXFD/eTOQR3vIOs3pOHzxZy7Wwfj6S815NsTdGN2rpQVjBkpmhIBDiLi9KeAbW60LdeRxymUHfgCTxUKdwuF9YLjSEV3rpT69RLujWD8GR6Gow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QeVe7oJD2XTht38gIbXLRqOFThq4NByQNjE9LHlCG6o=;
 b=b+FAS0ahMWTYuq1/qjLgMF/06Y99TW7Sbbs4suko4xnMDrY5EBBDn3SjTM2O2h3UZgmHIaukqmAY6l+K7tFk1F18wAn3t7vAjykShy42pL7XE5axliYlgLhrcHW5ON7luiby+4pQQqOx/4yjIKzsC0Y4M6xFDobqbcj54ACjyFL4obcvYjtCPDWhNkzX8Unt+7EjyUSqtGjybYxAAaoCYHUXO1DEE4fQwuyAvlSYYtExguEEEotJDMMJrZ3qa1CvoKQoW3nTMBH25jKQ3xL9BHgvlBRyGXLaa8tu284JVKjKwK2Jf0/R8q1GEYRKs6OZhfmz6uugvKd1iMQ/UX66Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0797.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.32; Mon, 8 Jan
 2024 11:06:44 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::e6aa:baea:fd8c:4cd2]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::e6aa:baea:fd8c:4cd2%7])
 with mapi id 15.20.7135.032; Mon, 8 Jan 2024 11:06:44 +0000
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
Subject: [PATCH v14 11/22] PCI: microchip: Add num_events field to struct plda_pcie_rp
Date: Mon,  8 Jan 2024 19:06:01 +0800
Message-Id: <20240108110612.19048-12-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: f5f32a3a-5eae-4af6-a6f2-08dc1039e613
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	flP+ZoALSXL+w2SLhXW0RW5IUVtloT07IU2kEt/CBFA621/3eZ+7wTDcjnTnkjpe296Qvnd9a2Hsft2OLYQC19QM3ORUfiagGz+F2sruXQuqBHiVIwvRJBgYvpqxa2PNJDhV8NyJJUYqnklWvcDHnHYejj3TU9vn3e0ptbTvg1us9zgzKNAB+6xhhDdQB+XR3RVDtpRhzKj8AqKDNJYbJO6jlXWjQLSpFHqGeXJP+OvfKvHsyiLwyUu1PQuEggQ9Od9OFdT96G2pGWdloOJdVpTxqt61eq45Im+o+uaXlT7ZIJItPAoNtnYYLquFZpt4uzuKxRoswsR14lWR5GtQ2pGNWhHoAuuM0xNy8blYpxxExwYQaLgPKHGJQaaAyswwOhUoNycqgsx2RCZe8t1/fWaQ4MndW+1VU+69oqKIjZRi4NZJJ7jd7zd9WtXQNGDkNFdP/yJ8Sx4rGqrVLMxFYGqWdhulnSLnK3fg7nGLLMBra5U0Z6jnNE2e0F6WWKdEzJkN5Swq+NwBcgPnUoWBbXxklYxgseK2ghBn3QkQ4xym5PUWSEaWdQST6rrGmekV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39830400003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8936002)(41320700001)(1076003)(107886003)(26005)(2616005)(83380400001)(44832011)(8676002)(4326008)(86362001)(52116002)(508600001)(66476007)(6666004)(66946007)(66556008)(54906003)(110136005)(40160700002)(38100700002)(38350700005)(2906002)(5660300002)(7416002)(40180700001)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RClnib4o5ffBpZNjimNWGoMVx7b19IExxsno42+S+zZbN2z77veIXHpRKZbv?=
 =?us-ascii?Q?U+xxYgkBXkqyOdpHz2u6b5HV6gCeMuUNaPUdbl3Eq4t5WDCZD11spOzNrwWP?=
 =?us-ascii?Q?GFxkwXQSEF5fa9o/WTYonAGOYm3DurdkJhHvlzW9byHnAfXnzRHPLyz6tSi8?=
 =?us-ascii?Q?zK7oM9AypdCwTP0dJgDByJxJyMn9Ukk4DlBjT8Ntz7c8SGmBPY4WUWWxxiAn?=
 =?us-ascii?Q?XYp9/jSr3SmUjZwkTU67isacXVPEjnQFGeMc8o6Qb8nsvMHkVTjNdGGjz+2S?=
 =?us-ascii?Q?wfy3zN4Yfa09ztlLCTACsYGeik9lhuGuPEXfDyNW5f0U2jFjqdSygWSkt6JK?=
 =?us-ascii?Q?skpOCQBQEsVQ0cTFK2R5VJD8MGVwy9mlfLChVRLdQmZpo3MZz/LbXyBPF5/S?=
 =?us-ascii?Q?2iuvt8Np3ypyiDATGDMoCBZWwympy5+2ShEcQm2hxuM8tpRayx5rFQp3/3L0?=
 =?us-ascii?Q?Y7S7HOC2q8Qv6EsXFzRjYQ+Skalx9nB0DBQiYE89R/1HlQSeDAq7R3xi1whN?=
 =?us-ascii?Q?5xEk8ISs98CUomv8GKSd1fQyJnBWWUg4rdcyyEKLxiTOILomu125LHEox8BG?=
 =?us-ascii?Q?c2qO5eDpgyGdAg3ttHQ5T/y/IlhGVRHKHzvQqtaOhiH/lYGY5NFuIAj55zX+?=
 =?us-ascii?Q?Lxd8e9dndpq5kKU6bi6CBZB7zNE0uoFev0ziPrpIf8Tsbl+P+iEKwxnZvMnk?=
 =?us-ascii?Q?UADkOx/fvpG/yJyruvRQMFh7osZXoEJ5XxKDj43PN8o67GjXk1uuz+4b40f8?=
 =?us-ascii?Q?fwsvG2sBJyV1LrwQ0XlGAXfPX0aG8subccTE7infD+zY61UuUzUi6APzLtjM?=
 =?us-ascii?Q?0URwqOyAEgxow8WFVuygAZKvaRK7Ojnel9H7NYVeQkWICWZsjXXQBk+VWJ0u?=
 =?us-ascii?Q?RMwdR/YCWzu+tNv0NeN8o/lICi3KPDVZO8idAnF+o/RrDbCd+JfpEYCytxGz?=
 =?us-ascii?Q?PFes4eWgTsITf5NFOnX3UHCTzumEdvinnwMj5zLLw4cRC9tZs+NRmnBLwn7y?=
 =?us-ascii?Q?yOsqtCwoYXv39XcELy+gC734v8QbceitUFg//MOfZnTkm44LiygIkHolCSqM?=
 =?us-ascii?Q?pBbZMJqmF9EK1XUQaPzf9msnhZ5Hd5DzjoqUzJZUAVWBp+83GiqJbb3YROqE?=
 =?us-ascii?Q?zwbRCed8SeV0uUr7bR5Mh0qlbie7ITi8b+dJM1XwFMQu/ae10PKqieG7JB8S?=
 =?us-ascii?Q?3Hh+LHBEvRTGBh4zA6ljY8s4SLT56EErfVmUg0xzAqu7cPrV+RLBWj+yMJFb?=
 =?us-ascii?Q?sn5dQtBsX2bZPYZnH5/xMyaeZoDkyERx8shm+MQfwxCM7Lin20uopKjt8QXn?=
 =?us-ascii?Q?RDrcmZ9qs6hjyRWtwp5GcCKi/TYvvRcULhL3VAsJEeB03x/7dT5a2IhLKT2m?=
 =?us-ascii?Q?h5sw7uqOdE0RCl9pKLuTE50l8Y4dpnAqB/qy3g/eFXHGgaY26/Zl/wRuqVN3?=
 =?us-ascii?Q?jhdp3UEPPV2JgEPF22VljrTi9AUTv1zqBFe4MX9ENxFo4nMgjInaRCbU8SxD?=
 =?us-ascii?Q?ETPV/KZKBFreomk3Fra1HZHt2lxG0RpSl+KgwabBnUJ6CUbBo2CniQP7t+f0?=
 =?us-ascii?Q?qyr6f31lPcwbiJX4fhT1Qr3PRGMVsuIAM+NKb36QsK2swpeBcVGWH2hyUpEC?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f32a3a-5eae-4af6-a6f2-08dc1039e613
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 11:06:44.0404
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: twOnW1d8IQmB+s+hGMoMgt5apTt0jgnEhzJUMXdNIzuAsrLXfKTv7GpEigSZZf3YG/8cGL2z3RwDom0CdPjuRXTTqx9GkTO8clOJ7dzwBog=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0797

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
index 3a17d8ab5bb2..adfca9f28458 100644
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


