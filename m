Return-Path: <linux-pci+bounces-4102-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 123F5868DC6
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 11:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34AC91C234B0
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 10:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C5613A892;
	Tue, 27 Feb 2024 10:37:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2118.outbound.protection.partner.outlook.cn [139.219.17.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715C513A86E;
	Tue, 27 Feb 2024 10:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030231; cv=fail; b=krcSmxG6Mbmv9gbHGKAjktgj4H8FfJDe4BlXkI/fRIKDEkWMXYzszO03Cm3sY83y8FYPXRnM9vD4IZAQQklv3lQNbvZiw0bBTYfjsJ5gg23jECxv+hg1GUnwEnOYmQKTZbjTsNtC0hmxRMgITFCKRdSDeSY0Jh36kLul3LOdGww=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030231; c=relaxed/simple;
	bh=aetGwQfCj81DGzrZQokscKBANT6NK6uQQaYIaEMk9io=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fznea+6egGVPLzWq6WfeAOmMefgLlDDKx/v7c7atmyrlsQDASV5wxV4tx1xmFMTob9pwOFxKQIThRv8Slgcf8ISJ2OoszGcJt7XWd1KmEm5lFY47g70qec6UK77ELBRSBP1f46OnLVJwwdNJqDKJCvxbGFoO4lBksrlwhw39jfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fKwT3AfrxxDcA25/2OW4w6MYI+I4TdcJZTtA78SUjxqYUOdMP+uwqlKDWV1BEtghCDjqHUU1dsGO/bBd7mZczS2Js9yYqRjMoL53YOOcfp63OD4T5EfpA3UN+oDlo3FSo/nXfTnV/qveBZehbPHDJTBJBgpBej8cOKnqJ7VUff/ouBE6x57Om8vBaBWuCgUpkCmbiZOfgE8NBbB5m2k2Z2oR3euP+FIIvRQ2f2tpz+T73ER3BQUOsN6WPUfmUPcEYAcrIg998oWfceCTw2GtFi65BtMYoQjUAJgdeHtz1OI//6X9MIyCgyEov7DxL4coFv/Pk4EJM1gwEBYcCZRwAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mdPM9tc7+aMwCmMjqDwieu4Un85dfZDn1ub7cOMzuk=;
 b=S5lAlH33lbQN4ZDKSKnRXk2I1CsWkrzYvwPrZWLHP/U1IXR8c10s/auTslhxbjcNXxrErMgy01sYMhGcKJ3qm/f3VQno+f7YAmC6hTAM5/W6J86dBpowiWAoVBPYMm2BeNqbIp47wFH2tIEDJ9143HQ1WdgLOfUigKBjnvqPdSioAZ6WD6zh2i5P2qPxtaEX2BvIVXqwrU83C0X5TwNVLXLVe28xP5wvG/nw+IpEjkV5lPVIcRWH3IxQlwr5JW3/UnTPjkXfLFeONeFGvZyDvMERa7O1+RZy9AGsB606bpcoIul/pE5jdsvPL3hE3PQn16Qnszz8dzqywth5uGvYvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Tue, 27 Feb
 2024 10:35:48 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7270.047; Tue, 27 Feb 2024 10:35:48 +0000
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
Subject: [PATCH v15,RESEND 18/23] PCI: plda: Add host init/deinit and map bus functions
Date: Tue, 27 Feb 2024 18:35:17 +0800
Message-Id: <20240227103522.80915-19-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 38ae8c97-a33a-41eb-da72-08dc377fdc96
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	dRfzohwbBgj7lJog3cYUI2RQBK4xMJefWTdbk32rTr0Mn2EdxuoxrpgiPPGlDZ3hEPjRm3qXk55+c0QjpajXHgJLuF4JFyquxsjJFsB/V6zD4QfhQRVQJN/6gijIoGz3S5adbtEsTK3KGD4sgy3xIJcVilpF6RtDWF0lGJLffo6wTrXA6NeY0NpNXsQsQtIcTZodAyEVOHxttTcTFA1wQs4kqVC47JnuZFKLar9zm/zHP1p/Dja3J5m/HomrpTtHrK6YfOeO7QdYRj+CKSWTmURUmmASO7ucJNI0ukDh5olApjBjqNQ12du45TejwIVRY8Qe4etmTkGbPyFY7mbTdBhTyYaym9dq4JCy52unQPdPkfPFnbTO24o+xiILjD8Be+aF3aEoHhaYljjmwHXc7MsX6cvhpl3cRB74zDtB+yVugjb68uvWuagLeesHRCmKyrwed5YmEjV6BFhXS5UIv3PzPhGcZApVRVrEHe/hnCRdeC0vDSoPVIu8aQX6Ko5dG2O9vnhNTVM6hvTrNHmdXO5SAdyd/mDJNrs7Mo7UCbKCqG7H9aNABti267QlyVetbCVWJMqmrffSUsHGZgBunLe+IHnOn/MhfmaOLWt4rLaU8W+3YQm9N0D8Q9LS84C1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?C8g9OvAkMrolTclxrpVRHw5PlsqRDzTT4lVso1mjPYd6keLdzJKxBvHRDKKj?=
 =?us-ascii?Q?40BaeThIASPA3DwzwxXinqtw4L6St2/ogH8TZa4yzK/1GGAuuS1D7I4DNdz/?=
 =?us-ascii?Q?Ot2adqUkZQkT3eKFa6BK50aLoh9oE/PHS0Xgi2zxW88h+R2RaZWn05JdK6aN?=
 =?us-ascii?Q?+j/A9o5D8EPriWs1hu1osk2BP+j1fnaqCOz6Gf+0AHS8xb4t3rbpP1insZ5o?=
 =?us-ascii?Q?sY/Mm/xaCMPwDWktq9NcHd/xnBhw6QJSFFCrdN6QGYaoKMCimI+F/Sc6AsAi?=
 =?us-ascii?Q?3H2UpD4AekG6Ug7ty3HzoSQeRFPtceB7ai5u5Ie62Ss+XN5VcnRwBdYfdyhw?=
 =?us-ascii?Q?EoqkDJCxQaNsUmpokN7nRUYQxQJBDexDu+OoGHxqq4SrQZ48s9z2P4sHiA9H?=
 =?us-ascii?Q?fjg1V19w7W5W8GnUIiL1yGkoPwcCBX+nr4omo/ESX7XVVebVGSlL3x1QRVAL?=
 =?us-ascii?Q?/0Ge4dDe2HKpiZhOngXSbQwkna80pYDudnZy4UbPVbUsvcavGLVFWysmROFw?=
 =?us-ascii?Q?WxI5Ka5HHohnD827Tv2qESCqxWc9SOg6t0ospwCLfabQIUS7ScmDn8P/ujSP?=
 =?us-ascii?Q?n79T6Fb549ho9MPGxOwlvDXT2KYfdXUkKmWDC8H0u3Q5q8D5nB/XGj/rqdZ5?=
 =?us-ascii?Q?CwW9baoFUOLu5tCuN1w9kAEBTQfiqA3JgREXP9lq73Wt5i0TYN5hsL03L2jl?=
 =?us-ascii?Q?sGb2qj/glq/WPFc6nJidEPUJg/NyeyYnJuQG7otPmbub3fhd5umipJE4j9bE?=
 =?us-ascii?Q?2hQCJCC2MvxrUcQ+oyv0lh7O6I4gJtkCnZLq7OQ/4a+l1Puly0ws2H349CG8?=
 =?us-ascii?Q?dFxm2fmS9lJEoW30f2eNlbAiOZHiAM/+Xby6U4s2RP8POwnduLUw1inKMHFJ?=
 =?us-ascii?Q?lQnpoC+Ma1WgbYtThxk3ZO7q7u9b/BSIAVFRaGzU6BX4oc38/q6iwiyqKMGH?=
 =?us-ascii?Q?RWGAJoNxwqCLLK5MhtQsKTEQRJvDXH281ccf/ZFotG8kgVAHg19Eec0LwQA/?=
 =?us-ascii?Q?nMo6O25AivVy9/NQuHcO7iVPmksLGFcwumMwTwbt7AeI9D/0V1G55i1krZCB?=
 =?us-ascii?Q?IlXQi+Ft0yreSzuqM+jbm6MRnasad9l9MaYPf3ApLFsnLGAv75cG9YWz8fXz?=
 =?us-ascii?Q?DfmUe2Q1rbOVJLo3vz49DCOqnDZSWw8m8XZRtKPPpiB7KRQCiQAa2KuBjpGj?=
 =?us-ascii?Q?arzWBIwz7kRZwWGvXHtA4Rv3JPsUwqcUQyUtTEGiERRzF6sydswONGo09+oT?=
 =?us-ascii?Q?AB6QWjNtf/Thop7G066T/NCZQCa76DLTkafGTHMq7MCzgMo6Od0okBax6qZK?=
 =?us-ascii?Q?dByUFr6t4dlAQ9TTDShkuJaFw/GvBsgcDV3kcdnhIfsWqSK89T2IwzsxuSol?=
 =?us-ascii?Q?gosyAJ7EsxhZNz6tWgleB48/Gmm98SzxE74FFKnEleTA6oZCRSlsiledsEXr?=
 =?us-ascii?Q?erLw8FPMWiHlwWD7/L+SfiLjUt2iZQ65oGvot/4QMJaWFobR13WXU3DbdS12?=
 =?us-ascii?Q?oeVlXFXxMXfX77os/kLZX51rmaId45yuIuvRyWeIAKsbv3ck1lLDC78OiI2Y?=
 =?us-ascii?Q?E+x8QWiICCU+7hyhzUOTTFNW2Zra9Em/0oMrLgboJZaz+mNiUMJoaUQF4pBc?=
 =?us-ascii?Q?HQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38ae8c97-a33a-41eb-da72-08dc377fdc96
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 10:35:48.2296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vOtaIWH/PzCljbUISj/oGlvOK6tL48NeHbO61woRkjRZXtGx5Ow8tlLz8Y07ZXL3CPpO0A4BowyGUDZAjF3ljoASwXJunORnitcwJbYcHXw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0496

Add PLDA host plda_pcie_host_init()/plda_pcie_host_deinit() and map bus
function. So vendor can use it to init PLDA PCIe host core.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Mason Huo <mason.huo@starfivetech.com>
---
 drivers/pci/controller/plda/pcie-plda-host.c | 131 +++++++++++++++++--
 drivers/pci/controller/plda/pcie-plda.h      |  22 ++++
 2 files changed, 139 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
index a040e7e5492f..a18923d7cea6 100644
--- a/drivers/pci/controller/plda/pcie-plda-host.c
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -3,6 +3,7 @@
  * PLDA PCIe XpressRich host controller driver
  *
  * Copyright (C) 2023 Microchip Co. Ltd
+ *		      StarFive Co. Ltd
  *
  * Author: Daire McNamara <daire.mcnamara@microchip.com>
  */
@@ -15,6 +16,15 @@
 
 #include "pcie-plda.h"
 
+void __iomem *plda_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
+				int where)
+{
+	struct plda_pcie_rp *pcie = bus->sysdata;
+
+	return pcie->config_base + PCIE_ECAM_OFFSET(bus->number, devfn, where);
+}
+EXPORT_SYMBOL_GPL(plda_pcie_map_bus);
+
 static void plda_handle_msi(struct irq_desc *desc)
 {
 	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
@@ -420,9 +430,7 @@ int plda_init_interrupts(struct platform_device *pdev,
 			 const struct plda_event *event)
 {
 	struct device *dev = &pdev->dev;
-	int irq;
-	int intx_irq, msi_irq, event_irq;
-	int ret;
+	int event_irq, ret;
 	u32 i;
 
 	if (!port->event_ops)
@@ -437,8 +445,8 @@ int plda_init_interrupts(struct platform_device *pdev,
 		return ret;
 	}
 
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
+	port->irq = platform_get_irq(pdev, 0);
+	if (port->irq < 0)
 		return -ENODEV;
 
 	for_each_set_bit(i, &port->events_bitmap, port->num_events) {
@@ -461,26 +469,26 @@ int plda_init_interrupts(struct platform_device *pdev,
 		}
 	}
 
-	intx_irq = irq_create_mapping(port->event_domain,
-				      event->intx_event);
-	if (!intx_irq) {
+	port->intx_irq = irq_create_mapping(port->event_domain,
+					    event->intx_event);
+	if (!port->intx_irq) {
 		dev_err(dev, "failed to map INTx interrupt\n");
 		return -ENXIO;
 	}
 
 	/* Plug the INTx chained handler */
-	irq_set_chained_handler_and_data(intx_irq, plda_handle_intx, port);
+	irq_set_chained_handler_and_data(port->intx_irq, plda_handle_intx, port);
 
-	msi_irq = irq_create_mapping(port->event_domain,
-				     event->msi_event);
-	if (!msi_irq)
+	port->msi_irq = irq_create_mapping(port->event_domain,
+					   event->msi_event);
+	if (!port->msi_irq)
 		return -ENXIO;
 
 	/* Plug the MSI chained handler */
-	irq_set_chained_handler_and_data(msi_irq, plda_handle_msi, port);
+	irq_set_chained_handler_and_data(port->msi_irq, plda_handle_msi, port);
 
 	/* Plug the main event chained handler */
-	irq_set_chained_handler_and_data(irq, plda_handle_event, port);
+	irq_set_chained_handler_and_data(port->irq, plda_handle_event, port);
 
 	return 0;
 }
@@ -546,3 +554,98 @@ int plda_pcie_setup_iomems(struct pci_host_bridge *bridge,
 	return 0;
 }
 EXPORT_SYMBOL_GPL(plda_pcie_setup_iomems);
+
+static void plda_pcie_irq_domain_deinit(struct plda_pcie_rp *pcie)
+{
+	irq_set_chained_handler_and_data(pcie->irq, NULL, NULL);
+	irq_set_chained_handler_and_data(pcie->msi_irq, NULL, NULL);
+	irq_set_chained_handler_and_data(pcie->intx_irq, NULL, NULL);
+
+	irq_domain_remove(pcie->msi.msi_domain);
+	irq_domain_remove(pcie->msi.dev_domain);
+
+	irq_domain_remove(pcie->intx_domain);
+	irq_domain_remove(pcie->event_domain);
+}
+
+int plda_pcie_host_init(struct plda_pcie_rp *port, struct pci_ops *ops,
+			const struct plda_event *plda_event)
+{
+	struct device *dev = port->dev;
+	struct pci_host_bridge *bridge;
+	struct platform_device *pdev = to_platform_device(dev);
+	struct resource *cfg_res;
+	int ret;
+
+	pdev = to_platform_device(dev);
+
+	port->bridge_addr =
+		devm_platform_ioremap_resource_byname(pdev, "apb");
+
+	if (IS_ERR(port->bridge_addr))
+		return dev_err_probe(dev, PTR_ERR(port->bridge_addr),
+				     "failed to map reg memory\n");
+
+	cfg_res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "cfg");
+	if (!cfg_res)
+		return dev_err_probe(dev, -ENODEV,
+				     "failed to get config memory\n");
+
+	port->config_base = devm_ioremap_resource(dev, cfg_res);
+	if (IS_ERR(port->config_base))
+		return dev_err_probe(dev, PTR_ERR(port->config_base),
+				     "failed to map config memory\n");
+
+	bridge = devm_pci_alloc_host_bridge(dev, 0);
+	if (!bridge)
+		return dev_err_probe(dev, -ENOMEM,
+				     "failed to alloc bridge\n");
+
+	if (port->host_ops && port->host_ops->host_init) {
+		ret = port->host_ops->host_init(port);
+		if (ret)
+			return ret;
+	}
+
+	port->bridge = bridge;
+	plda_pcie_setup_window(port->bridge_addr, 0, cfg_res->start, 0,
+			       resource_size(cfg_res));
+	plda_pcie_setup_iomems(bridge, port);
+	plda_set_default_msi(&port->msi);
+	ret = plda_init_interrupts(pdev, port, plda_event);
+	if (ret)
+		goto err_host;
+
+	/* Set default bus ops */
+	bridge->ops = ops;
+	bridge->sysdata = port;
+
+	ret = pci_host_probe(bridge);
+	if (ret < 0) {
+		dev_err_probe(dev, ret, "failed to probe pci host\n");
+		goto err_probe;
+	}
+
+	return ret;
+
+err_probe:
+	plda_pcie_irq_domain_deinit(port);
+err_host:
+	if (port->host_ops && port->host_ops->host_deinit)
+		port->host_ops->host_deinit(port);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(plda_pcie_host_init);
+
+void plda_pcie_host_deinit(struct plda_pcie_rp *port)
+{
+	pci_stop_root_bus(port->bridge->bus);
+	pci_remove_root_bus(port->bridge->bus);
+
+	plda_pcie_irq_domain_deinit(port);
+
+	if (port->host_ops && port->host_ops->host_deinit)
+		port->host_ops->host_deinit(port);
+}
+EXPORT_SYMBOL_GPL(plda_pcie_host_deinit);
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index 443109d04d59..7b69891700a4 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -141,6 +141,11 @@ struct plda_event_ops {
 	u32 (*get_events)(struct plda_pcie_rp *pcie);
 };
 
+struct plda_pcie_host_ops {
+	int (*host_init)(struct plda_pcie_rp *pcie);
+	void (*host_deinit)(struct plda_pcie_rp *pcie);
+};
+
 struct plda_msi {
 	struct mutex lock;		/* Protect used bitmap */
 	struct irq_domain *msi_domain;
@@ -152,14 +157,20 @@ struct plda_msi {
 
 struct plda_pcie_rp {
 	struct device *dev;
+	struct pci_host_bridge *bridge;
 	struct irq_domain *intx_domain;
 	struct irq_domain *event_domain;
 	raw_spinlock_t lock;
 	struct plda_msi msi;
 	const struct plda_event_ops *event_ops;
 	const struct irq_chip *event_irq_chip;
+	const struct plda_pcie_host_ops *host_ops;
 	void __iomem *bridge_addr;
+	void __iomem *config_base;
 	unsigned long events_bitmap;
+	int irq;
+	int msi_irq;
+	int intx_irq;
 	int num_events;
 };
 
@@ -170,6 +181,8 @@ struct plda_event {
 	int msi_event;
 };
 
+void __iomem *plda_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
+				int where);
 int plda_init_interrupts(struct platform_device *pdev,
 			 struct plda_pcie_rp *port,
 			 const struct plda_event *event);
@@ -178,4 +191,13 @@ void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 			    size_t size);
 int plda_pcie_setup_iomems(struct pci_host_bridge *bridge,
 			   struct plda_pcie_rp *port);
+int plda_pcie_host_init(struct plda_pcie_rp *port, struct pci_ops *ops,
+			const struct plda_event *plda_event);
+void plda_pcie_host_deinit(struct plda_pcie_rp *pcie);
+
+static inline void plda_set_default_msi(struct plda_msi *msi)
+{
+	msi->vector_phy = IMSI_ADDR;
+	msi->num_vectors = PLDA_MAX_NUM_MSI_IRQS;
+}
 #endif
-- 
2.17.1


