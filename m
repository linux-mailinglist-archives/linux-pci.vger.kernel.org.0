Return-Path: <linux-pci+bounces-4097-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3AB868DB5
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 11:37:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 406F51F27194
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 10:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C4CF1386BC;
	Tue, 27 Feb 2024 10:36:59 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2118.outbound.protection.partner.outlook.cn [139.219.17.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F6C1386A6;
	Tue, 27 Feb 2024 10:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030219; cv=fail; b=EEam1szrS095jijOk6GuG3bZGQjWEqGqtrG8ebjuTfWCXd/zreRe//1L14HtjgGpCGbZFfsZbGICyapjLWoNFbHbF8zo1CzHk+W3AFJqElBw37x2dzMbOs6PDgNwpQVUx+SdgJxJkTbO3NYbbkMkUjWIq1nr2PQbdxsYpfaNPsg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030219; c=relaxed/simple;
	bh=/4PccNbWjjS+4Uc+iPMog5YcbODT2POYLU9j4TmmDl8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A5ae+iDXuzYidbUsyoivoDD6iJIvdEX1CgQQPt7BnB3dLj5zo133Xz9RgQQCe3Urwn0tgpxUIiq+ld5jPg83goGFHhm1T+eEJmPFOM0sP23C1EeMUp5EzXHDs4jqS2RycnxFy8+17/9f1mS1JqrEMMbzLkUKeeagFEnlT+HNplU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=boQyT5K5Bmn0ekKU5A0jN3aUx7Xn4usH/uRp10ayc54ygO9z4pv6OB8/bRLR8q9QQztE9zdrdad3F7m8Hd1AkjnbzrJC/FRsgxhphzSz74muhIsfZNPWcpXTb4N8Xz6YzZJ+tCHOZjq8jJXOnxz75iHSyN2Tl0BExP95yeUkYmQwH4WSKn8pxBXpB1pY0xeZumicoBqwHTx0GvebiEIbbIlUNmpdD/4X1M6CCi7nsKEDnx3K/bHrNmpOmtlQTm7eWFtkMJ0SD9MbhWFZdAy9CJ2w4MciqPUgm95u0TZRkTPfTycXU8KlRb02JN41LNbf6ylY1rPBXIZy7M3raMG3BQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qiqHj4APLQ+5sb97w44ol5KWqweOs8B8Tg2C7Uqvdm0=;
 b=UF+pzLAv37YKeaSLxLzT3FlEUCHFFXFVSDgoxsDLyuTr62LeoXwgl8stgeEAyAzS18N6KABe0787LdfFzMIJBxDBak/aLKozXYbCWt+tOiGPd5frjcMTEGIIABL6OrxPMfNz5HbVG3zS5jsZFWU4xUoeThrcg1E+nCTauskU6apSEzAcZuSi0YzwPJ74N2FyJPD8gkEG1e/O6s3g3EQHfzOMgKC2dZBe9iVBSfYM86+tR/fQYPuyECt8AZvWQsKvXC2GCUBBiamHO6HMTGFgZ+ffQHvOmVZPN7kEsarrHXRHeRDncpdiLc67xE9rWTV7P3sQY4/ifhwAdueFgGDT+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Tue, 27 Feb
 2024 10:35:41 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7270.047; Tue, 27 Feb 2024 10:35:41 +0000
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
Subject: [PATCH v15,RESEND 11/23] PCI: microchip: Add num_events field to struct plda_pcie_rp
Date: Tue, 27 Feb 2024 18:35:10 +0800
Message-Id: <20240227103522.80915-12-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: dd69a0ee-ec2d-4bed-1fca-08dc377fd879
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qjVOOv4NuKIqsLtuuPEhmvugPu/lDrg4wNaNT1EuQ8ss91hKdadBMUxxDQ5khbuX9+9eXGf1oFNjZNodueaMQf3n3LambjtBA9tf+4fS6P4TAEcx7wC81ZJv9QBy5luYakD+GRMgDEe9hRvQHvV7uS2gHmI2lZY0NxsvBk04UqAc1iXDFJZd/jDh3AuIVstX9N1rEl2u4jxG3TzG9i+r1yHZtnHCgYhkZ0PFQ9QayeKLy6vD2IVouGEIrult987CozgAnZ2inUtBkAEsmRsldHJWPLNUte0w3Px1ZvZHCKSaClzWAC665ebw5S1t2tIoyFDbpT1612jOLqGPYOd6Fuea/NpsQu99FLtMEStYG2Rejz4R/4UJc8Z1M463wZNs9hcfZj9DWIzExfnEgqj5hIcViAVpIwm1ywyLlnXapaoH2JNJaKnD/fpRBgTpRb4wrWqlWrHLhSk7JEIdUZZdRGJS5kQQe2PpE3XX9ARnKbEJ2pyp62vBzpGgiJJVw0OuNGcH65yWKO8mKsOc/Eoo8ChUt0N0Rv+0Mayla+a3x8FyceWvMiDU3gtDjwRyatNFoCxNBWL/LgtiD7MHlcil2+506+HW0Db5BMDFK8F5KwaqV7Yd50RMrHSklHzrNvhm
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9+MV+W9guow5xFEmYx+2p7niOa6bvBespThw0bd53uJXch5BcZ+oZIv8NBYc?=
 =?us-ascii?Q?q8T+rO2gRnDI4y+naI1ZGtWkWUeVNkei9z6Oe2dIS00f4Uv4MZkCqtdDUeQi?=
 =?us-ascii?Q?RvgrydvL0WbX2oR0Xkl5RBHSw2kjGb1EyA5/fqg/EJCHmNGehUZHnBb6ym3q?=
 =?us-ascii?Q?HTDVaRozrrfkSWAHotkGNRlR5kBAyTsgCFSUokixu+MqS6tW4JtIfUTh1g16?=
 =?us-ascii?Q?F+mQ8nToglFtEC+z9vhSvnLwpBhco/7wyhVgHlLz++m1cpen5vCq6wJOu1jA?=
 =?us-ascii?Q?kubZA8FQB7QSVyPVbAA5as3+KrSMX+FX026UuBRVJZDEwWOkPMH1Trl4B0+q?=
 =?us-ascii?Q?yD/iz2/Kp0DSB5AaXT2MH1Aiupdx2YnW6f5CVEvH1TNwUKECc9URwJQuWdIQ?=
 =?us-ascii?Q?u/Os1ZqIu9ol+hs09ruRJ0QVfSfDs/Zn3s+DQcs//vkSfpy1KMqfSLzLADJS?=
 =?us-ascii?Q?64z94dhYlBygUJcBPNjJqrDexV81N3/c38Lzr31c2Te0mhUM8I//59pA5zcC?=
 =?us-ascii?Q?UDDUmpQrjxhtF8b3LkRG1RABzDQ/qU5c41zPVZcFc8z164Z3kRKfOXKM/zfY?=
 =?us-ascii?Q?TpdgY6ou4F/hZC1a5/R8x0O7kRS4WPt0Wl9YIyFTdUwzzXXy/3vHLAe48fV9?=
 =?us-ascii?Q?nnxnkCjesY6zmeckMs0YDvFD3VQ8TrqkZWEe6qY2JrDmf7FED86R/hcYvZO5?=
 =?us-ascii?Q?ksjPolrDe+oNU4Aa3zA+HRRmX3wYzgOD1NKpyVc86PZFrjCQ1oCVBhOebj+U?=
 =?us-ascii?Q?4dNjrMyhUAtoo5BSuZTZ3N7MDd7ig/fSEgBPsZmvfb9FRQ9ZFdmUIr14EvZc?=
 =?us-ascii?Q?TKyIMj6yesz/ovHpQM/W6PDs5W9qmr+Vgk6PJiAsV9iM4mZfse1f1uxRHv6F?=
 =?us-ascii?Q?pCcQaaBT/h2CdgrwFT5GzqRtOGVLoqosg7lfyhkUGLt1iOaw7CA07gBxjgSY?=
 =?us-ascii?Q?paGZBonOGNOmxl/HsB+FnD0asLfnldYTIu63yevohCQyiGIeaDNsuvid61qY?=
 =?us-ascii?Q?UW413L2zaTWBDv0G7lJP01o+JLydLqlXme4Y9fjkE2ZTcgv1wQmBCee2Fu0e?=
 =?us-ascii?Q?huLU7RKBiNENaGZFTKiT6krl0DZsc4zXktx4YQk8p8C9VNqUJ/RRGNr46PX8?=
 =?us-ascii?Q?EGmdZQCnCk/ZztADz+sJ4FHV3tTcwyHHStuS33IvyiL0cSpiRt7x6CENc7Wt?=
 =?us-ascii?Q?S8uTL9UU33UBWIu8Vk5LZx3pq5cV0I9urpGrIjSIWZGLXt3/Z5ThVH1yFU6Y?=
 =?us-ascii?Q?RRSWhhQ9+TpNYVwvfaNAMPHvwYJDhlLpWuZnKlJlnP5Bq600T8J9M19eVPR6?=
 =?us-ascii?Q?O8+7viuQuzJehswyklKLs8XjZlko9/TVbLyqKRI3E4HIvBHuX04Kt7m82Xur?=
 =?us-ascii?Q?PyFe3vEZ78c/h5k9TtAdR8gaq00cdJwwnlcd1pUFTn2zTMaCiiwazuHhqSWJ?=
 =?us-ascii?Q?PRKwNCxtLoq/HTZxDFxTLV/W7iAiYWJaqv8oCM8HmhjGhtcFs/yXIe1Fjzn0?=
 =?us-ascii?Q?nV3VmK6cF8JuVZKJULr3MjL7kurjY9DFhggVuE5PP4W6zfHaFV2yaUe4qjFh?=
 =?us-ascii?Q?E4zEOA7CgS29RVbsTuX1DVCpkHVIJ/WpuLGUttqDrtI2u8PF1L8tLvVm1FaS?=
 =?us-ascii?Q?Vg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd69a0ee-ec2d-4bed-1fca-08dc377fd879
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 10:35:41.3115
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dHQdOu4A37mrbZ96jNLz/IBVpaUCcZEBlxj4078EuRpoUjcXWkUsu9nbGYeZPT1WK+g8362rqkVTsQnsiTvgcv3dwns+o56+Ylo1th02KBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0496

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


