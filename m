Return-Path: <linux-pci+bounces-5332-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C103F88FB27
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 10:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E490F1C22D2D
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 09:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 419C07F7F6;
	Thu, 28 Mar 2024 09:19:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2136.outbound.protection.partner.outlook.cn [139.219.146.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD837F480;
	Thu, 28 Mar 2024 09:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617556; cv=fail; b=D5uxSQ39svhzHB5/M/71KI5jR2rg4ojitaRHOVUNykKowTVwmt6YThnOgGwSrv4i8do0dbOQoc91mCQTvIXRKht0qTzDfsl3007Sdq4n5eHFXW0iHKJ2pdjhr3a4MsTaBx/EjkcGVjpoA47pD+WpX0jJ+xbokwwfHn7HRCZzvOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617556; c=relaxed/simple;
	bh=4PvAHjWntMoBOFhRfRhHPiK+FmKDVaOOAV6t0L+67Hk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aa0V33+jSZ5CDGUtkoLSIzoEZD24CZuNJ/gUL4Pa5YBgAbDxREe12EmRvJrIqEfqND1x+rTASe2z+5K7eOjYhqUL5ruQCe3AOWtCHiTYv1TCvW9s1fPEh7NQFkG+jQq22HnVOb93eMyvYc0YwhShV7lbrDuz8jEdiU4x+jc+TfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QO7388Tx/8AWBjlPwDNb3P0t2Fcq2Hv4VA4W43hO+Olczp79yR494P9k0iA8yIlMZyJdxRH1QUVMiaF4q+a7EIyZMLknbTfSBRbzxGXzovP/ITNlDIKafsENHZXzr5bD+kzrztICCqrtrL5eaduP2TDOnrf3BghtJ6eAVwUGU8k7oOsRaIwADk/TGEgZeJ+KgQP9Uic7IJU7f15RFrP6AcN7ckpSXOt8Ga8jEbqkTPXMIqbmMJhOEVb4Z2mj6YuFUP3hicjZl1PwVtgCZhXMHUvm69Jscyi8IbVqIxrB6LyfGwJyHK75g9GEXwVMoOJBOZsTRaK238g7Nu9J7lqOvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ncDs6jP9pGy8jGxNbXXrSMdY1MZC4+bmB0C9FDghPh0=;
 b=lfaFWmgJyG2lg8zy+DuKMev9hV+xGwxSHXmwKGnEwgBfDlRLBmVkREn+6ryZ6A8xll6Du7MFU0SEbXSkOvG4um64GwllXr7Ht7Rzls26zPORy9GAT6yOT9r1DqC6x6op0gtS/zeBFIlwhNxz6TZe3IXwXQwd9xzBrHAfb8ok/V5dKOzVQZlTrtivE+KqUpDV5vC1oeloYkMY1m4U2bsDOymlRvO77oYlqb2DrDfo+3lSwxrz3CaOWEtg0BGUjgkbdOjdjbTvUv6rRhF8bIqnRWv703U51sVM7iN3ZEq+6u/Vz2HEh9nB/5B+QBvg/E4gFF0y8WZChPQ2azaAKjXwEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0559.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 09:19:02 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::c738:9e6b:f92e:8bb9]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::c738:9e6b:f92e:8bb9%6])
 with mapi id 15.20.7409.031; Thu, 28 Mar 2024 09:19:02 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
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
Subject: [PATCH v16 18/22] PCI: plda: Add host init/deinit and map bus functions
Date: Thu, 28 Mar 2024 17:18:31 +0800
Message-Id: <20240328091835.14797-19-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240328091835.14797-1-minda.chen@starfivetech.com>
References: <20240328091835.14797-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0020.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510:c::16) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0559:EE_
X-MS-Office365-Filtering-Correlation-Id: d7da7d95-9afe-4239-7ab1-08dc4f081b7f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	B3G1EKcr8VSaCv6hSy8kNA0wGDd9amSBukaIbZ1QZJYrnCTLDrIbV1Z9a8izb2aN8Bwh9Ywm4ztsucuwtFDlXvxh2dqIpcm52DIbV/O9ABaNemHgk/xvGRW22JHv9dWoXDtWoKd0+B+Y5U6VsjBcMmh7Q/XvYiP0C6XamcxT+ooOnP6N+QsKUzDb2ZnVEd2/6Rr8igwGvyQTyMP6CyBUt00fj6XvqweGO2LqjhBzoXWlrDTHR9gpS9DCPSLJji0H7xUNremTQPz+UfVg81UgHHW/rtNg1zDJmab0HJ7voUpfhngawZETVsX29GH+YeD8jTi1GEMRFQ52NmWSG6mGyY8sphV0L+lR8BlcyYTJIpYK54uA8uPAOcjARb+cQW2A2zXhnPpFCR+n5CEg5Shl2NGLOlCEUdyPJTT9N3+fjndgZqEKlJrBfF+cY6QbDkBjkc5+586Yf1HAKTktIWNENxmPBwzJI/BmRxEufXxeShbafXiHNal1CXtZYHeVXqc4SRExqygDYuqGSZNGrfn6LtXgJPUaJJNnCF79XTs1tVAxVquW20PmyDKFXbc5C4MJ3fB1ZOl/7JPlkKpHSeT2inHP6n56dBkKWzX9NRESjrSzKgBCLMHZW/uOGlT51UZR
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7NJQfKq9jLscQxaZjnE8LbDdIFEt6a3okjdqCYLWJ8e1z1b1ybKYrLQgsKdx?=
 =?us-ascii?Q?ZmPSlSffIFM1XFDwHzj+Dn8tNGONqf9taeme0wJFeSa76pYN4064cbdvIUjb?=
 =?us-ascii?Q?L/gGs0j+F/Wg1Smcipsk+xuj6ze00hzAQJELE9Wso1Q/wQQFQvYkByk6irnf?=
 =?us-ascii?Q?S2yO+vLVVf6O+NqUx4ibknbqBu28lR58VTJV34PKdL3sVrFwgLWXvRMKXQ2V?=
 =?us-ascii?Q?+lWlCxGgTcLHn5l+b7jVGvMI92T7exYl9jvVfL13hjNy4+DuhfySOOeOCh5G?=
 =?us-ascii?Q?w7JauHGvlda61GoD1J/iekfBXq+Iv9gE+hfrjE5g7jgEATcrZk+2wgSNRAus?=
 =?us-ascii?Q?XP07oPqk06A5W90wRzrUA09STsVbXdVACLUPBrYhVDbXVh7tEcoeTdtDIa4F?=
 =?us-ascii?Q?7sjFiFF4PHKm0zrDX64JrpogsYo2L4mYhoB7tIWLLfUrHuwrEZrg36vXECJN?=
 =?us-ascii?Q?midxh+Nzye+ahHNZ+xUVk5EGYQ7qBD/+jwZgxO247EefpNhXioCHj8AhCzkK?=
 =?us-ascii?Q?zcpHcefHK/yMm/oVGsQpDXHjz6JHYzXVYolFvyDO3/QyQ7I458Nl7xKWclvt?=
 =?us-ascii?Q?PQ234lZt5m9v/5jpntS5x/bCe9BrZu0ES+PgBAcbqrkayj6vmd58SsTUu3KW?=
 =?us-ascii?Q?1vo9BLD0GHHHxrbG6ZFYp9YwCB+LvIr0Xl4XzkNUMeWk9ROq/BdIJw4Cw3yO?=
 =?us-ascii?Q?aXo2+WpV4Uvvf8gOew/hLN8anfK67mCcIHX7g3Ol+5kSGrOqVKoCCYa/XHiW?=
 =?us-ascii?Q?TTm5vOZ1B+FW9kRryGN83pKCKHDQ7yczhaDd8Kfl/eYukzhoBi9uE7xEhQ9j?=
 =?us-ascii?Q?WRax98A+qPMrIBBaJ69orrEx8XJSrvKEkxaBiaDNjiYwME6xib9VRzeLgfXK?=
 =?us-ascii?Q?ZKgnZlnlzVNe2w4cL5v/GeW3SwZB0IOhoKb+4D5q4K0G+SerUW7axYkjat2b?=
 =?us-ascii?Q?sEfqMN8hNdiuz9tb8gxorm+BAg9CRz8iJM0QlZUo0tvWSlfFeeSuc6Efbo5H?=
 =?us-ascii?Q?nhdBOi47F7GsEGhki6/l6dzhcXiU29Jq6bluvKYSFviC9AwT1+hM3b+Tyrpc?=
 =?us-ascii?Q?n4JyAGK9lVaUvhoYc39THt2ruI8K+t6E+F0zMBVaCta8eeO2tSSYnHnSaLD/?=
 =?us-ascii?Q?k29PThdTZmH3QCcECFk7uyhWivqrgFevNqkllTO9nfNvt8H4jnZEkyfY3WK/?=
 =?us-ascii?Q?I7mKDFUeWxKTkrepQEUGCnlVZ/FudvwCdllp55orwWuDlPPt8PUjdaezac/C?=
 =?us-ascii?Q?3ioATBWmfEZUPlXW2Ca0zZFqGOHmUYIWzP9Wlb5SjavzP0nGHvn0BQL64/cX?=
 =?us-ascii?Q?dojS7epRnYPldFKJCVHH0aw10bhwgOjl9EzfEOUenySbm0gHUzkNvZZX9TZy?=
 =?us-ascii?Q?sZ+nzeEG/zHXeGi/t6qIaC2pZDPPRZqHbKuudbT1zVopdJ7ueEtKQ5daX3Au?=
 =?us-ascii?Q?pTdPTbWiizRQWXLCUZ9PkeNYm8OJRJwSAxjqsDp4cJUirCNXPKIpaEWx4Vpo?=
 =?us-ascii?Q?xlRr+iAHp5IURSBBO5wwqIHQOqnCwEfpQiLNCIbO9jqrGZGL5MUab5XZ6YXD?=
 =?us-ascii?Q?/a/kGJQ9NJryKDzgPOdV1N2pPHeDpWxirVHqRFS9Pxpp0H9VtJss4MOfj307?=
 =?us-ascii?Q?1g=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7da7d95-9afe-4239-7ab1-08dc4f081b7f
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:19:02.0429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 49e1BovqeCOzyg8RkRI1BRrtGRyfNR51YwfHWPMnzEJvbJoNR8R9o+NCl2vYnY/UcVxhT1QX88JWWUjbqjNZtZPAeAkgCp1jpAMDMLW8UHU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0559

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
index c3d8c141e44d..52f4cacf7917 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -142,6 +142,11 @@ struct plda_event_ops {
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
@@ -153,14 +158,20 @@ struct plda_msi {
 
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
 
@@ -171,6 +182,8 @@ struct plda_event {
 	int msi_event;
 };
 
+void __iomem *plda_pcie_map_bus(struct pci_bus *bus, unsigned int devfn,
+				int where);
 int plda_init_interrupts(struct platform_device *pdev,
 			 struct plda_pcie_rp *port,
 			 const struct plda_event *event);
@@ -179,4 +192,13 @@ void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
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


