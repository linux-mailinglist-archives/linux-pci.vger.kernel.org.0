Return-Path: <linux-pci+bounces-1800-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F23826C90
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 12:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF5862834BC
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 11:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27DE31429B;
	Mon,  8 Jan 2024 11:24:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2089.outbound.protection.partner.outlook.cn [139.219.146.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EFE29420;
	Mon,  8 Jan 2024 11:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUpjKSJ5IYMiaVgQPn95FCJdHvWUwSAi1QvIk+KEpGiKY/38tUYLyGZjGbUC9yS851VZw4X6YeiaFJHS8OO2QgE/ouOS+foPTq4sGnv0uq/VRMz/z6FJcY/SnCl3IMaZ7T1He59Y3Si01UeiU2g8UzC2hnVA1+c/H/q8sCeHYdRN5o8PyRPF4wVpfi18h2IzGBTHq5OJtQ2lncFIBRUJGhhODg+9ovT5Iwu4izheje4bzTzXRKEvfRwPGG51Nfou64iMWxYMHUrTvtWYvHMItOMK8YiOSgBq7DvjqAoHXTLDgIfAShjc2uvSeq65GhRBdmA4hzlU+tsFfVivwDBwYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mdPM9tc7+aMwCmMjqDwieu4Un85dfZDn1ub7cOMzuk=;
 b=GwXmNlJt8AfQekgn4KSBi14VHJzIL9PtS12yq4BDdVKqhYc/4wf2kCCAuLIoRCzGv39oBxUN+pvYPa/ariBNI8gSytT5hxnSN5A07j68PsR0L6lV2wza1FPI3TtrHHshpG0b9pDqF6lckUrWfrFV8PaJvWTezrXVAcaJ92zny4iygX+AVz0qkRqfUn/V+N3+NmIGwakWdaktng488WMn8nElRQIuMF3He0XPO0gD/iBHEoYA/657+WicbwM1QmhgA7DMkxHHVdBOou6gyOBcHKUB5EWWLaQ04gAOhDbsalS8shWkOHJYdAaVXxOGxnUpPMHbFQNPBdJZ7bgjp7irdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0797.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.32; Mon, 8 Jan
 2024 11:06:57 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::e6aa:baea:fd8c:4cd2]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::e6aa:baea:fd8c:4cd2%7])
 with mapi id 15.20.7135.032; Mon, 8 Jan 2024 11:06:57 +0000
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
Subject: [PATCH v14 18/22] PCI: plda: Add host init/deinit and map bus functions
Date: Mon,  8 Jan 2024 19:06:08 +0800
Message-Id: <20240108110612.19048-19-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: eb1cc44f-580f-49ba-f55a-08dc1039ee47
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hw9IiHkHlQqUYx7KzEOqyyqmRS+oGcf9wM/xlphRm5OAFwU8fazAyyHmgnOX+0OuinXQ7mqosT3WovPDuQTqFBJkapjfxrXGg1K6w1dC2yIdJfJaGdU92WkmX1zUh+di5/Jh0A1AQlF3oKBlWZTOlWrcrFz1/3yfu8FQeTTuetDi2CYBmJ8cMSWk1xU29O72LP8BfY4wca1E30BW63d8lzBQjbnqh4DlPUYO0v1bS8qeGCzriXA6bt4c7IyPNjO6hhUsoshQIJwnQRcb1Wd/w6vn9PByto1H7gwdgSTj897a+H7i6xFOZLMXh/qJOdqUInNZYtfB1Hrvl1/2+tUNEyaRfal5kFdefDUysi/rH4ob76YS1PmEZFo6Ns+FCZANzXk6s//y8JPX40n4g1+LiWXtEF0OyTFCPQTaDaMKUgF9927O5phMoHzokp3OpM8IcGJ3//cqbCiU0wzb+XOlzJ9VHarClzkXMskWIsWXKJa4od3maUeYZ4HWonVYyI9Rcn3RQEr/gWHiuwAKPvqBSbDWKE1YgCmoGEeODLlc73uXf/EdM3GJcCjZxNAKhM7i
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39830400003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8936002)(41320700001)(1076003)(107886003)(26005)(2616005)(83380400001)(44832011)(8676002)(4326008)(86362001)(52116002)(508600001)(66476007)(6666004)(66946007)(66556008)(54906003)(110136005)(40160700002)(38100700002)(38350700005)(2906002)(5660300002)(7416002)(40180700001)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r2kxNW57X/cvEPiU/ixQW9239FgfpWjQ12abueNT4E3riX43NWmCy7wWjpNc?=
 =?us-ascii?Q?7csgSC2xpQb0uuSEPxaNRb0wxSwiB+xN7b4tPamiyQzz42vOh1rd4VDaA8hT?=
 =?us-ascii?Q?xOvngdiZvFzVBUmHnBT8JNSOCmiEhwZiV431NXlPJGk4lbwTyRGvgpVN+qMB?=
 =?us-ascii?Q?kha3dYvlgkoVOfV9kVI9ea9FFSS+6qJG+29NW8WSFX3ITL/d3I8/uiY6DIGk?=
 =?us-ascii?Q?lSRv+ZB2S51YqVNAia0kWWdCs/fZchRu/sOra96dqNlXM2UGzqo2zhk+E3He?=
 =?us-ascii?Q?3oDGF/Wy8lOnCMh5BeOAx+FV0YROVPUccwvvflaWhqcNIKdroFU+fb4XB3Ip?=
 =?us-ascii?Q?xG3T+69pMFWWfd8dUM2mKwriIiFlmFXJ2KjKJwI1jl9CFKeuSbZPq1v63b5Y?=
 =?us-ascii?Q?Uxc+K68cmZdSCLjRJHG7Br7iC3W8KCIwLTfF+PA/DSmzqVtYqznGQlgFGgog?=
 =?us-ascii?Q?bkeCqMbDhzvksm3Y1dlsVQULV+PWIyqdoi0llgpo8LZvihcnN2g/tUihkMw/?=
 =?us-ascii?Q?HDfm33dA46kVoIoFmbhXRZIBWoHDQYHnCeCs51ZsMnj/7qTKXGRidCf+XDTL?=
 =?us-ascii?Q?/VFKZpq+jHUMFoVldNErGs1ko3X09uTK14p7NNrhaZQkRZ+5IAAKjROmw6A1?=
 =?us-ascii?Q?np+pG7hRzNsQJZto54epBMehQ6IfQla+F4rw3CCQEJ8+ds3C4jQcmJ5qfLgn?=
 =?us-ascii?Q?gE7B+K7B7cvAr6ib8r/88qUNhJ/OT955T1AHilL6g3H0ZENvs4do3yvtoeSG?=
 =?us-ascii?Q?WwzO1hfXrkq3HRbc0zIISk+zxcfobOt31L1s8Wm7lN9A1uF3M2f6na2cOPTz?=
 =?us-ascii?Q?ycgFepro/W/9AV2P9t/HKfg0/IUqz7tmgzmGP46X86VM4YW5923PDzDWT8P7?=
 =?us-ascii?Q?R/Xs1f3yG2H+Y5UOLgdN8+Jm6GGCnrqOa2UpmggJ8BPGS3bfk2xTyfAQsuq1?=
 =?us-ascii?Q?Yk8FCvEXqhN0yoDbP7EoHpPSkNrP66TIZy3jts6uapPcapBMbTLuTY3/rCBd?=
 =?us-ascii?Q?wdVq3mkElJyZnwStCfJi8NyOQPSz9DINPYDmYsqkU+W2QuYGdUXrNPH8CT6o?=
 =?us-ascii?Q?QAl7kFOfaL3EyugKAw+2ZoqC8seU1mrGNzxwgS0lpYskRNeJLG+9k6N47HIy?=
 =?us-ascii?Q?NWoLhMUMwGAmLtcdxp2rgM1tj487vARgQSn+rIFU+2pxJ4yjZB7kjvbe/yl2?=
 =?us-ascii?Q?WPTZbx2Kz73kxwmaYNSmgt0epL3MPxjQecn9WfFaSZMDRqsqrMC7nlHIixW8?=
 =?us-ascii?Q?+989zQL8wOw42NLaidDLlPJMAtkwkQHHEQMFQyswQLIdXHRf+N3eEbXdaxm1?=
 =?us-ascii?Q?xOvKY69Y+F6NUgGN3s7b8nZYphAEi315OIXGFnC5PlYusnO1MMaF7YoPVVMf?=
 =?us-ascii?Q?koqDoNgSKDYCVpCAWxBrZ3Hbz9DkRAD8tGmpl9jd6OZKwzwWsClFTgf25ETM?=
 =?us-ascii?Q?aAQ+pidiuyEI5IjNEhxWyJW8C2cQn7LecwcICW86MFDN8o13YLTXYmybcx71?=
 =?us-ascii?Q?NKv7OfXRdAr2AHomQBbQc07Z5UOHuvLoFCBlcZP78lB1Fm7xQ34MdOmLYfXA?=
 =?us-ascii?Q?i1La/Y3rlHVQtX5J7T84dVlRy7+Sx6DzL+yti7TnhrXAHqGK4JTzS/b5KYef?=
 =?us-ascii?Q?Tw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb1cc44f-580f-49ba-f55a-08dc1039ee47
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 11:06:57.8313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: n6Z0EAit9cLTxlbuTR4gdzDjBZmRgy0CV2xt7qA00jGae45hrjh0RU2zESqsOIN65as5uuOBoTPyhytdmN30YHKB5CY3D+umYYNd8WyWhWA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0797

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


