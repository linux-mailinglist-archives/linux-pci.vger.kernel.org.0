Return-Path: <linux-pci+bounces-2665-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 821FD83FB8B
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 02:02:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 379662840B0
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 01:02:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 231FFD2EE;
	Mon, 29 Jan 2024 01:02:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2063.outbound.protection.partner.outlook.cn [139.219.17.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8A3C2D6;
	Mon, 29 Jan 2024 01:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706490125; cv=fail; b=Fyiypyc+wSKJs5h9vnfR6kz7ej3noOfv8JQzyqVftsjZ3uF3bBQ4sGCa3GP1fYMcGi4tT5a5T98NTAeWatimbOmhRpVlcMqu5g5DSazAM50OJvHCAb5uybrf+7/+t4ljsk93zPMnHqzxrf+1OwAurlsSFGE+jDb+88feOQ6Y3Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706490125; c=relaxed/simple;
	bh=aetGwQfCj81DGzrZQokscKBANT6NK6uQQaYIaEMk9io=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C9YawmtgGBrvYPO9PIE5Gpre2WuBD6VUoIC76QuoiQOqt/m4yjzLldlM0Jn5UxFk1u/WgfoZ9QQnR6N2yb623LJRsAP3sNjnPYblow5a1rIQsUsLiFjcvzqhGr4/UQGNhwJB+mkT08TVrfhP0gM5Vv4AVnKZH2S5RUS9G+KwEUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l1S9bqUSQxH5L4n3bSt1bHOVo67jpH01dStrCgD06HZB+1mq5/6FkKfCa2jAM5q0mt1A4ZKoU1zsdgNEvhMeq4lxSsxz0dv8aMEkqkOn1nvNqvyewHjsJ3tTNRUvoDQXIGJuyyusNT7Vlxcv64jwyDvzu3qE/lVwhmTz8lmqYT3nlYbN5y3pJGmtS2Cp/Wm6l4modc3Rv/U1mGF9sbSiWkX38Nvitw7VsFhUPoOwHmxkt9ejEKlhjf+FOcJZSPkuJBJSQ9SP+2Zp4vrA630hcexti4HcmVmXTfcxAM9YOeNtL674IHakY1w8E9NtrZzz1WuyuikEMLktVPtxM9SFGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mdPM9tc7+aMwCmMjqDwieu4Un85dfZDn1ub7cOMzuk=;
 b=EzCFWgd60E+HsBPIuOk1ST80dahBVtNQ/WIr6iEhgFTLAHVaIYGfVOGezS4JSkpiGK/+TFG1yZkSTv3iHk4kTDPAR1muX6hytD8/QlBzdOJKCsBfizAFZNN4W+VwgMCoKf1bNa3jVCGGzYEoweXS+defEggKmzcPJW8zBQTOAs9KA8brpEKlFpJwUmJwwkA55ySNaomM/Ms31p+5qWwVM3LnC0nhx/fAvJHWJo/z5pUBlziPkBAKDmpbcaKohwivpAzUQHngkdI2Hko0GwjGiCLXbCvrAX6Bc229tmsv/CM1L9rF66N1c7FNUt+RhMBu0YfgUcm0vBJj5fzzE7YFLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0552.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:13::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Mon, 29 Jan
 2024 01:01:54 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::1ea1:19d5:efef:6fc6]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::1ea1:19d5:efef:6fc6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 01:01:54 +0000
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
Subject: [PATCH v14,RESEND 18/22] PCI: plda: Add host init/deinit and map bus functions
Date: Mon, 29 Jan 2024 09:01:38 +0800
Message-Id: <20240129010142.3732-3-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240129010142.3732-1-minda.chen@starfivetech.com>
References: <20240129010142.3732-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0003.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::15) To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0552:EE_
X-MS-Office365-Filtering-Correlation-Id: bd972af7-7ac2-4dcd-35f6-08dc2065e24c
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	gqez4Z91gt1vO0cFkvW2kJC8RhKRzd6gi+a92PZ5NixjCued2zdawKvQ4tZ8/z0gCufgvy8sSVWNWNuzy4m1pKXcte7aE0V/j3JdtEsd9VgSoYQuK6UL8yZPQLpZ20Ud2tClM0sVnJK21Ya5Muc5nVMAHMBQA8Aar8K0Ym9eqGPrhdXU6jZ0vrnURpoZ5bJUl3Wie9ELMT8lWezRKW7b8PB+22+qmmUVUR0AvhJjD6TsC31QyDte+ge3u0hK+7llezPXkznatnBqWIwAo2G/DbZkL4zdYSCVyShNUy9tYol+++Bsg/dRr9EMQ3g1vKT6xVwtLke9x+NbzJO1TKJ+3r9WmX0LaSCS/3zb1B1U0vZqafBsbaWWdVUAVbUxf3MoZw54gHbHrsBOLZk99LE9hEP2sF6DFUj28aLSr80lBOVWANlga9DZOglnvxUcQgZrL1l2T9iMftKH9HehL8jXWzmaUIPbcS5cT2DQRqkBalqflw7AtmYLFbGsau4k9wMcgXmwA+ong+1HPqUq2kVSacaNzU9bIf74ItIqtWKXgWkWqNDw9aLAOx5fK1pv9Vmp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39830400003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(107886003)(2616005)(1076003)(41300700001)(26005)(41320700001)(40180700001)(40160700002)(38350700005)(508600001)(6666004)(83380400001)(54906003)(52116002)(36756003)(38100700002)(2906002)(66476007)(5660300002)(8936002)(86362001)(66946007)(110136005)(44832011)(4326008)(7416002)(8676002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?l+pZrWumIDBOrVFOxTlTG0hzphBMeG3tqvm+IV4fZDZ0EsDISDTORnsMKLw1?=
 =?us-ascii?Q?mxTfXKrW2ezGejaO2MKoel3fU7fAanoLWqZ3Sbk8TX61KQOulkX0Fe2FOXUJ?=
 =?us-ascii?Q?aeUzMABTJJgJI0SjS8k9hu5CRVFzaAZK+Qajcl2Ox7MvKdJGKhkCKwjM1n9i?=
 =?us-ascii?Q?RBaEfosufntgKzp8CiUABaYhQE3aBkYcxQvi/oMEPsXfTGixR6r+1X8sFS1g?=
 =?us-ascii?Q?/8NlGx5CmB8PqC9WfphoIFmZCJbSm3ijYpYLHSWT+6IkdPnnkvrBymOp/qJy?=
 =?us-ascii?Q?IEZsKj3gcCB1Crb6YfMx0L6eLsJslFgW0ohureWxW6J0dZkCvihbwxX7Heoj?=
 =?us-ascii?Q?AHcIHIFOamimwKU4/ZEeCkUUNlbbM0UqKtXsjsVJY8XSv5JxtDgcK1/llwT9?=
 =?us-ascii?Q?L2jXa2n8J3gYmEo3Dn2YGKAB/AYKGNqWjW/xj2n5wdv1v2X4oE2kx1bTCCRO?=
 =?us-ascii?Q?ASY0VlyGd5uU2sdC42NL6IYKR2pgf8rLuhIIv6gxxS9Gf2yLFpGoNUnajSc9?=
 =?us-ascii?Q?raJHzbrARBJe8rjl9yT3AG1rukziYKeGbAufGIPAh0ufqzgzvOBfuSi2IHRU?=
 =?us-ascii?Q?RA+iQASVjPLAACeC6afch2lLKhAgbXcRIDRroFVn3SJmBnPnAtrygsNhW/lQ?=
 =?us-ascii?Q?+DryrGEbvHRFYvLzSsSk4LKHsg2FZwiayzDLQndcEAuMwRkbjko+iYQbB9tZ?=
 =?us-ascii?Q?pliYlr9Jhwg0StljC6gqycKw8qxBvpM8QykTOIAR0VxqINyPA9SdNZ4x2tZ/?=
 =?us-ascii?Q?VoAypYdXyCALgtaoTy7LRNOdKHOwF0FlKgn71QXNFn+XnJwowzfFSU4jMc2J?=
 =?us-ascii?Q?xbcrBHxAlg5n2Z90h6OYSCKbMFDjpmcJtBRKczfzu8o5N3R1ONG2wEZqCkBy?=
 =?us-ascii?Q?Ecn1xOu7lvOxSEncQ04U7JNt9h80oT7Um8ZBh2pUkDgXrZ6br0hF58844oDI?=
 =?us-ascii?Q?bdwLCe8IyLSTuy/wD603W4vbF5xhQdj4ltrs0fjFCaZCoWQmguSiz+W2NcVN?=
 =?us-ascii?Q?Xb2rM7X1BUqbucIRobyzVCVCpPgeFGyA2DD0RzbDSqGvIMmJkoYzv2cTnPgj?=
 =?us-ascii?Q?g50NT9FlOZwVkc5ZNLFx/bMdbu6jx7H/Uoz47CcZBw3P2x4sPZQ3qfIZ+egT?=
 =?us-ascii?Q?zzOGI20mWqoUVXSHU6eIm4oEOxqAlHNDn2Lyg0o7jcgrWfzZs5cTCMfkg/FS?=
 =?us-ascii?Q?LGREDRdQzWk4fujtGZP09mDw5ySzAxcb2mK8aQHVLUkyVNH6yR2vT6Ilxpvu?=
 =?us-ascii?Q?jf5CfWAxN0xZa+Y+7ln5juegWOXB6ZJ/c0/aQl6AlPWUu1sf1muzpC6CrtdP?=
 =?us-ascii?Q?wkLlSo/LF3CpuJDGRJ53a1oDT/pRJXaDw4SR1emTlXna4CN12VT7SCkmGExr?=
 =?us-ascii?Q?d6jBlMjiAN1Izo7sck6vNI/B/PUXTsep+FSNrULYHgqPVWEuNt2Q8+JW4XHy?=
 =?us-ascii?Q?rz9YHrvKbr4iss3FMjZvvxlzz86L5UqQ4ZFKXyOh2xBcwdCromTK1OX5AY3Q?=
 =?us-ascii?Q?SHZeeH+xuUow6PGMiWsG7vrYJqYUAZCsGFAAFcWvKFR3QHhL1QOTSBIUqQ7N?=
 =?us-ascii?Q?O99L3xC1Zb7hFZGoojKTaPlU4R/XbcPDk6GQ51Rxee+kXriG/hd3RojiH1r6?=
 =?us-ascii?Q?2A=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd972af7-7ac2-4dcd-35f6-08dc2065e24c
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 01:01:54.1270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V/FK9t72sCKtizRANn7ZiY78Q26a5g0YSDz2YJnJ37yenFz2eN/cyYzNUwh+PPsvDo9RNOb5exYi0CXDZt8c6dwXNvQnsKdcDcDe/vDiAf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0552

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


