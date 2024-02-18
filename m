Return-Path: <linux-pci+bounces-3693-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35DB68596C6
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 12:56:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542841C208DD
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 11:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241F363407;
	Sun, 18 Feb 2024 11:56:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2122.outbound.protection.partner.outlook.cn [139.219.17.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8482421D;
	Sun, 18 Feb 2024 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708257360; cv=fail; b=SgYxCcOdFMwjeqpD9E/5sJxdYmJXkrtFKQeLqXlPJeslpUX8TME8JVSe9APhQA4KShCsKY8uD4WtX3mo5uQfLxosc4sCAHk2WGJsjkGD+00yKyZjBFfgpgsAOscnesnyRCezlwWFlBaI6tqgRVN33eDoFw+zIVCIItpaTn2yb24=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708257360; c=relaxed/simple;
	bh=CK38PTJKcJcw90VpcidRxBv9FWVT/PDLFLiHaWgmHaU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JMUZm6TgaT+ZPbUm8HiXRv+P5TpSBiE5dCv9vb685zDHeeXpN+t9g8uNKiWJHHviUJWRWJERDwjXEqgWg9g4Suub2at65q9ImeRsW9g76zz24meyBXProw+d7vqLqg1V+bfWxHxRTSIIB4NdKjWIDfqr4BumTeDyVEeQ5QP7/UI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lHX1YfWLgeFDZVellxphoJhD0Zv0OtHO9Z9M5FK7BsYebN6+eXgcLjCJXVESGoJCQUS0A5RUVREJY5fHJaLUgdEfrV7+GILKCNHV9AmT7DYPDuODT1daADIoQyoywOcfRkpvipA4xYW+KSdKGAfW2Qa2pY4sW5dHAxlNM+EO9EOHFlVbnANFn4FGlAXCNKGYTzoQbHJZ3TrDU2AU5piTpDXcDOS7HOzkiYEWUqULfHG9y+wqxHYio/La2MlVac/WEaAd/TXw1aVBpnWqFHomqOZUse9T/BEH8xV3mCYyPg58YZGUlzWkaCg7ReVNbafyn2LFGKvZ+DQjNvk7VL43eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w95He89+nS3O0/n7azFj8FLXOgq0kCSQDRtJPpzHt7I=;
 b=VjlmLOXN+es9mIpnxrZMD+GH1aSC8K/EgcKgOpxGqFDKhyi/YE9qPT+3myHZS/ZVkUsPSoexeLzLEqSYM2chqhE4d9ak8/JQB6Fxq17oGC1vEihmGecF2sH4yF7DNbKSx34oUyNdMnJ9FkQFUlhNYtNpDk51qblyEg4UlaqaMSAz4iFdB8PNetxEW1KiiI/yXt+jpHEh7sDIUz7+YzGbHcPCc0xfdQJ+yIcUahw25tO+Vl7csEkxr4V7gT7pza4zkpndnuL/KCCAbxDQw0ZP/ClhkWcHNXJOzhFwEMb931hPRmsAHWJSP/YFYlXCYMKMnxVpX+587Ow6uZHjjvh23Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0765.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.46; Sun, 18 Feb
 2024 10:17:47 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7249.051; Sun, 18 Feb 2024 10:17:47 +0000
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
Subject: [PATCH v15 12/23] PCI: microchip: Add request_event_irq() callback function
Date: Sun, 18 Feb 2024 18:17:31 +0800
Message-Id: <20240218101732.113397-11-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240218101732.113397-1-minda.chen@starfivetech.com>
References: <20240218101732.113397-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0022.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::31) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0765:EE_
X-MS-Office365-Filtering-Correlation-Id: f893e8e6-f9fa-4c3e-919d-08dc306ada62
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2/7NSP8p8AGumkkx1vcAFVXmzbdjhtL+RHgBE3LAH/t0PEiQ3VhfYl9vFnZyXVnOrZmeSq9Sjw6j1YZYHBZs8/LkEMYgHV0flKhfseoILuQy2mWJjC6pSjgsUWh0IkEEaytzluubgCfU4CpZT15/apRBlvaOEubkSynlfLu2j7QC+NPQRQUWoSQZldhwINa/EH43gdwiSNin0rnWq/bV/QI7PW4/Qrd/tFrUJ17k/Rb6gtRjC7xHmWS8WIFFPCVGNkNJm/L9JBP9+2x7C5dIP3d1J4xwAcfc6KgVkvtd47ce8h1M85VmRABjD7yoR/jYQW8XRRUWs20dRFr+G16/wWO4Crf/YCzZRUyyJDRnH3ecgBMoFeEz/3us/X3IygiUH+QnlpVVgpEUEA7TeAL7zRNXNvQLBeJVCsyBYqp2ECNxLYBRjJ/tXQiUvM4O5cdu7HNyT5/Lfi+03I/eT68llF/aY4hy4PDhLx4bEKK2Ia8rB/I4IEiVE3wC6yivDzhTIIFA9LaUZwhis6MChrH8B5ZO9QAhOcDndJWUiBHg5v+DG+tgQKLH7QzfpcCRa81y
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39830400003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2906002)(5660300002)(7416002)(44832011)(41320700001)(26005)(1076003)(6666004)(8936002)(66556008)(66476007)(4326008)(66946007)(107886003)(41300700001)(2616005)(83380400001)(8676002)(40180700001)(38350700005)(52116002)(508600001)(110136005)(54906003)(38100700002)(86362001)(36756003)(40160700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?EVHreCZGcovroKnqowry16R7yUT3pmiYyxNoFuwmWb018uyYTa+VlB9uhQjP?=
 =?us-ascii?Q?bi48NnpYixLhyUFZkwwAqAVaLWyQNXDuHRbqWYOlFZU6j2Uh3yQETDNtschd?=
 =?us-ascii?Q?HcKJKYKS4VjXF0a0/LIx6Cz8goM7shcQ6IPaCU2Ijsz1CmLLvu7rARCEY1uv?=
 =?us-ascii?Q?N2a4P78JVkaFQcdxzt2up/1TcaKpZU28uyQhTwMw5QJbBsNIkp95+YM9+Beh?=
 =?us-ascii?Q?491T+rYkbBTdCyoTD0FxW4Y5JecwRklftm1ulvTj4OMCVaMqOOkOk6NqdPFu?=
 =?us-ascii?Q?LUi5FzT1uPquRmfMdeM4HBjusbPnyXsehyc7u3GRY7Iksn3aTg5Ut7Ic0uPS?=
 =?us-ascii?Q?icoBhKmAgi+5tyC275/gNXljgNd6PHqB52QvSEzvN1mH23FM3WhJsvn7RL6+?=
 =?us-ascii?Q?WOyF67dTLZHm0Bb3il29dVJOepDzDlkPSK12C0KO/cJ+CScZBo3nkwcum72s?=
 =?us-ascii?Q?M1+Mrqybm2Wbtut1nZYAAAPXlbsJDdCjjtHpwjd5PGAn87R7CmcSPZRVD3l5?=
 =?us-ascii?Q?JTTnEo8aES35DQRj6t6qlzv0nK6m36kGlRfoOSiUiC6Ul0ZPxPC49Ksejyde?=
 =?us-ascii?Q?5omm6J5t+peuO11bGmpy/X4jSxu4KwjNcigHtbXFeLsZ/f3/85Vx2Ddd+eqW?=
 =?us-ascii?Q?sWefQYqnni8zNkBeik2h34clNpuA4VdXvz2UsvyO4T8aSozeIUZ2nLsLU7Ck?=
 =?us-ascii?Q?0bTwhahRxxA/8OqpQChISNi2UmjogMXyCNjklcRWLRNf9IWZZ59ypvSyq3hA?=
 =?us-ascii?Q?q7wPMylqsZY/RWQr4VBdx2Nph8NUCCb6TLup2LwALOnVdFHhy8Rj61yOR8Mm?=
 =?us-ascii?Q?d1XtpmSsUOoOXwZYVAmGGT/QBuLtFvf49ThswlUHqcxFS19er9/DPmJ0M4lg?=
 =?us-ascii?Q?BWV9FIqYw97OeikLBPNiNWdYs7+kRm9pQD2Yv6dfRVclxGnWZF8Zb6VwKNKC?=
 =?us-ascii?Q?WTMIVq76dWWu1P4wEa6yyeaFc06Be+65ZxNKx/eZaiL7jRGfk1ExGdtmxtIH?=
 =?us-ascii?Q?8gODaoxIy1rL6hq86YoS1QIIqBY/RhFNBjUzWtt/KrcgpooQPzKNpNM9h6ig?=
 =?us-ascii?Q?y8fso0GhEwVFF9/H5wQx2nur/ChT8gmhQsmu7K6/bxD3pFmdaMgoCxlnEzvw?=
 =?us-ascii?Q?gzN/vInBY2BfUsIn6fb53umtKgNPBDdh3PQvAb+Ucy/u4oVHAJwWUbz7hCsk?=
 =?us-ascii?Q?93wuM+utaX7vzkNzZtPPHEWJM2sSyPgZvRx5Etdkr11rxD/EVS8Yvcvv19R4?=
 =?us-ascii?Q?qNr/yHy/FtXYXxUc0KflNFw100v64EGsxSkn1es5iUjHR+aFq1sZI2M4Htvi?=
 =?us-ascii?Q?oLTOFPlN3ET1U++2o/tXkiWaaVxrvVyyQ61kRbG/NFChWQ2T+ZOhm20Mli7k?=
 =?us-ascii?Q?DWTN5ecbMWN5A3zXIQXTfsZCyOYsN9CXK17jPi+Fer/6KRErcgmS3nbM2thc?=
 =?us-ascii?Q?j3rdLpboPZcH/lksxg2Chgs/3/u9Ifr+f1zWi8pXwWGi4GH+MetIZ6lb8V3a?=
 =?us-ascii?Q?+pWyzTntxnCX9huq86YtW2tYzh1vLLdwINlFMbGfCAPeYe/GQYaqP82fn1i1?=
 =?us-ascii?Q?6oE8QUQZ3Uuq9Y8xXvYwspW/KkmaqgVeVhUKHZI/exNEij+G9+R6AtYrzrPd?=
 =?us-ascii?Q?Og=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f893e8e6-f9fa-4c3e-919d-08dc306ada62
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 10:17:46.9723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zkm6DRXfVFLxJ2iKWdxQUArjQe0ufdlo+XXUA19kLmwq/CyjbbUouqL9cqjthOmAG6oAO4Y0h+ARuqhrpuTnKhUblqpIHTGapxADBHAdSRY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0765

As PLDA dts binding doc(Documentation/devicetree/bindings/pci/
plda,xpressrich3-axi-common.yaml) showed, PLDA PCIe contains an interrupt
controller. Microchip Polarfire PCIe add some PCIe interrupts base on
PLDA IP interrupt controller.

Microchip Polarfire PCIe additional intrerrupts:
EVENT_PCIE_L2_EXIT
EVENT_PCIE_HOTRST_EXIT
EVENT_PCIE_DLUP_EXIT
EVENT_SEC_TX_RAM_SEC_ERR
EVENT_SEC_RX_RAM_SEC_ERR
....

Both codes of request interrupts and mc_event_handler() contain
additional interrupts symbol names, these can not be re-used. So add a
new plda_event_handler() functions, which implements PLDA interrupt
defalt handler, add request_event_irq() callback function to compat
Microchip Polorfire PCIe additional interrupts.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../pci/controller/plda/pcie-microchip-host.c | 31 ++++++++++++++++---
 drivers/pci/controller/plda/pcie-plda.h       |  5 +++
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index 0a5cd8b214cd..bf5ce33ee275 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -642,6 +642,11 @@ static irqreturn_t mc_event_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t plda_event_handler(int irq, void *dev_id)
+{
+	return IRQ_HANDLED;
+}
+
 static void plda_handle_event(struct irq_desc *desc)
 {
 	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
@@ -803,6 +808,17 @@ static int mc_pcie_init_clks(struct device *dev)
 	return 0;
 }
 
+static int mc_request_event_irq(struct plda_pcie_rp *plda, int event_irq,
+				int event)
+{
+	return devm_request_irq(plda->dev, event_irq, mc_event_handler,
+				0, event_cause[event].sym, plda);
+}
+
+static const struct plda_event mc_event = {
+	.request_event_irq = mc_request_event_irq,
+};
+
 static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
 {
 	struct device *dev = port->dev;
@@ -904,7 +920,9 @@ static void mc_disable_interrupts(struct mc_pcie *port)
 	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
 }
 
-static int plda_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp *port)
+static int plda_init_interrupts(struct platform_device *pdev,
+				struct plda_pcie_rp *port,
+				const struct plda_event *event)
 {
 	struct device *dev = &pdev->dev;
 	int irq;
@@ -928,8 +946,13 @@ static int plda_init_interrupts(struct platform_device *pdev, struct plda_pcie_r
 			return -ENXIO;
 		}
 
-		ret = devm_request_irq(dev, event_irq, mc_event_handler,
-				       0, event_cause[i].sym, port);
+		if (event->request_event_irq)
+			ret = event->request_event_irq(port, event_irq, i);
+		else
+			ret = devm_request_irq(dev, event_irq,
+					       plda_event_handler,
+					       0, NULL, port);
+
 		if (ret) {
 			dev_err(dev, "failed to request IRQ %d\n", event_irq);
 			return ret;
@@ -983,7 +1006,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
 		return ret;
 
 	/* Address translation is up; safe to enable interrupts */
-	ret = plda_init_interrupts(pdev, &port->plda);
+	ret = plda_init_interrupts(pdev, &port->plda, &mc_event);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index f7e900b395f8..935686bba837 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -127,6 +127,11 @@ struct plda_pcie_rp {
 	int num_events;
 };
 
+struct plda_event {
+	int (*request_event_irq)(struct plda_pcie_rp *pcie,
+				 int event_irq, int event);
+};
+
 void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 			    phys_addr_t axi_addr, phys_addr_t pci_addr,
 			    size_t size);
-- 
2.17.1


