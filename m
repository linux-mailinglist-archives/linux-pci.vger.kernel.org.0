Return-Path: <linux-pci+bounces-2678-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9B583FBDF
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 02:36:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C9FD1F21F61
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 01:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A03D528;
	Mon, 29 Jan 2024 01:35:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2068.outbound.protection.partner.outlook.cn [139.219.17.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB4ADF58;
	Mon, 29 Jan 2024 01:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706492149; cv=fail; b=f+MEZRbEvIScwkkPHu4QznZIX7+wD/iAllVEvOQCt89eeFmOYahFtueFWQ7DxqCETe3FQ2Y7Ss+X3Awcc4tJfe4KePLPuD5gz6ixEkIAVmY6KZezIn0L3EnLFh/JbSMqdu9t/N4n6JZP5shLZs8m47WmIKa1TLENinRLDmzacxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706492149; c=relaxed/simple;
	bh=9HFoWB89oSWytU6cFushowRyme5a5vBdtDh7hRmVzsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dVsSWVtPiy3KG84mEp/7shFSOIqSrFhcbKZpYD3MDiNCnj1ydxn6GZY4SiKX3Vc56UFMvP0nXxGfYln/ZT4dzaK9IlW1oE//v3sd1y4P3dcSqbn6tnwnC5jQ9Ed/zi7jlfDj88JYUicgwOK+7WtFOij1Anx7NV8WuW4S0mHwZB4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RtFkqp1/ZI+JsXJ46kVPnq7qZdOgHk1Mcysd7JH+E//14DmHpXUpQjCadMI7LcItk07z9+ezBcbeRwRqL9LfJZb8NHrKAepLuVO5DLkBOPOIzoW5fa87yPJ6gDklCMJO3ysm4ZoYWTKH5nMmhmdxB5jDsWEwwSeiuo5wFVNmjYU3WLSJYrgFMC1neE+Q68tuqoNLiuRazbV+ROPHr/zqjl8DzBgi393GfOe6NjGeTK+YDEq4KV4NFHEN29mpJnnB9hfbAQgdaDl5rBYXFvTfr6IpA7aOKZYvGB9TsUnIFJPA2XzfWpAfCtZjDJxNI7HpPfGojQAXlxPm5UyEbn/Oqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4MD2usSBbRdsd/hhE4tw5xP1KyGga5Ecw5HSB56sQQ=;
 b=GwGhQceEMCZyl+DbKD8B3JXg/HGzJIuadAZXispaLnsX0jDVXBmsNicL7QuqSA5W3/AELiDDq+EU1nIo7HOg3jJbDWiRFj8f/O9ezJIfPJgckFioNUu4zDmYJCsjQOes94AZDt5ikLw7Da1PHx6ZEkROz3rdgSSNH6yChUPr3znmWXooh/NUxt+1BB8PBOBvu9Nn1p/Y517/BwjjANUCBetIG4RqKWiwy3N8cQxasMHEW8kSR5sN/K6kuuAVCXM6biQrVtoJK5mn4ug6D+dfoeSvudVBfTmebyOOvxgz1SGQ/9Z+8FrEbWIbyWJ6vtJLR43VipdbZjTGl04uSLvz3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0552.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:13::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Mon, 29 Jan
 2024 01:01:52 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::1ea1:19d5:efef:6fc6]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::1ea1:19d5:efef:6fc6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 01:01:52 +0000
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
Subject: [PATCH v14,RESEND 17/22] PCI: plda: Add event bitmap field to struct plda_pcie_rp
Date: Mon, 29 Jan 2024 09:01:37 +0800
Message-Id: <20240129010142.3732-2-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: fac92d76-dcf0-424f-1f0c-08dc2065e14d
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NYsKG2CaR+he7j91waYA4jemf+grVBhBSQdeSkYt4oK64EJ4zWaPOu7qjQGZ304xCiw4FbjKxV1+AV4b6RKBFn2g8mqdi+sFjWlPrqCnpnuYSMXUarw6CEQMbBrFTAVGny16kQvryRFiqD7gIx0QXlUOP+pyMNIU0R3RaiBTaKfthDGGrGSwHFEWxf7F0Sx6q+fnwMemCVYGhAqnOIew4NPYzWXOTp/fH73nI8ztkJYoiBouOmqYFaHylR4T08bVZNygl1nbT3kShpDsksWqjQ2Melsy4hlEutAFioySGu2cjLeAFAZrfcXekEvX/pt7sFrHx/MSd+0tMt09GU5DgPwUka8JQD5P7XEyryjy3xI1sCb1i44ghKGyLi6BzC8iW9xCQ32JuzTbP/EypeWxs+hkbo+WMfHqLIkFtpon17eygmhK0bNmUDTq8xyWragoZWBgowQLPVa/Q0tY5QKpFV1bhTYHMQ3RV1lS78RgL6t8g9fPBw8Wzp4nVDjHmQRA7Jmk7bxjRHk8ytGEWYaLEZ6GLnfOyVpnhkiwfFG2J84pv/9n2uGidfRv0DUz0pZc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39830400003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(107886003)(2616005)(1076003)(41300700001)(26005)(41320700001)(40180700001)(40160700002)(38350700005)(508600001)(6666004)(83380400001)(54906003)(52116002)(36756003)(38100700002)(2906002)(66476007)(5660300002)(8936002)(86362001)(66946007)(110136005)(44832011)(4326008)(7416002)(8676002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7Bv9/OkLiCIGLlxfFgC1iV/g91KWp0qBlYD/3meqIAOOu0Uo8sBEIh+ZQMjj?=
 =?us-ascii?Q?0AKAAb2VBcNKaJ7arqMFqDzqubmEei9h6gNEtjYz/6+5zI3Lqjz+jVclJozy?=
 =?us-ascii?Q?BFtlWlL3tWEJdpxsvJ1GClWg1e/qljypXLiUd340FivWjEnvjgghy5bsKopn?=
 =?us-ascii?Q?8abdLWZPbLJztGQkc95lEgQxogEjXuCWp/F2Ps6Dv1BEOqFeMu8OtQ1VpzyT?=
 =?us-ascii?Q?FtQdpLmYMyIcUFyPVbLhQt4j0azKwGZXUlf6LPvS+orgR8jaFRHg1gJsGoOV?=
 =?us-ascii?Q?Y4PvhVXULqabYm8WoW77nxo2sDkaURTUdVydViyZzRKmsyXe395RPp45OLcn?=
 =?us-ascii?Q?YXvUMr08Y2aPYPWUgpH7dhqwjdPF4jrYDqdW9M028KxH4yU6KSxHEaZO/huN?=
 =?us-ascii?Q?s00X4+bL8lEM5Z4z+1QFN/zK56gljdjiJlBee20WL+Pfi0PefDvbIIR9lcjq?=
 =?us-ascii?Q?3LnbAWCFf1B6n2FMy6VefvG2ovf92dGWkMEjNHNQ9l0a2OWQ5le3ARTF+2xk?=
 =?us-ascii?Q?rE3GFpapWHLLol+8Ki8Ugeu1UG5wNrc+UhHVTm1F1U6GU0qmWLD2qGa+oGOb?=
 =?us-ascii?Q?lbIzW6TpGTbhHfvmIazzSXJSYHWPA6jrZrbWDMXLidHbi36f+UP6W8dBldrP?=
 =?us-ascii?Q?aRKg0Z7afqaE/bSjW1Y8Z+SaOARG1UYY1/RRFnBRF2tx8ySKOZLasccY/drl?=
 =?us-ascii?Q?Zj2NThGNU+HM1GUEZCaS7V9BGH7DT/SnN2LtXWQL5Ciumh2/AbUzW08weAO5?=
 =?us-ascii?Q?cBPA4hQr6UEr1L4RmnWXUwsMdIFoSzelovqXxqPwxCWg0YgLJQ19a/RBbDg3?=
 =?us-ascii?Q?kbj8QwAv2MERhPorl6x0PBy0E8OpRmIk/0QCUkydU17lE8aiEJe90kFo7EYq?=
 =?us-ascii?Q?4HFuwmLHIEduijbGSxSU4rlXbAU3a9Xngls7vEYDFhW1eA+1pCekPZVF2SXl?=
 =?us-ascii?Q?K+r/95I6BSYokNyeP7Y7Hcuj4RyrNdMZu+3eyNQFcA2z8VmLzjDakmvlLOmq?=
 =?us-ascii?Q?ng5IPLXpUquSVcObItcQ6qVXx/y/ygkBgecQxDOjtDF21q6OSShhn5VZ5lvR?=
 =?us-ascii?Q?/LL8BFa0vqEzbQPEEqPW7eqY3PmtCUZYHqYUO7zMYe/UwDOPk0TuK/YvfRPR?=
 =?us-ascii?Q?vXwmsA0xkLau7wwm04Bz+SqMnR3mRazxrV0Pl7gbLw7Lb6rXccx8904j0Wjf?=
 =?us-ascii?Q?wzWn50b6A7g0R7vn0qWsRH9cMifK8xVSJRNbd7RNU2kIW+vsy9EzzHqU67JL?=
 =?us-ascii?Q?gwdDu24sfWO8V6GodTn+e9auI9Nmabh8jPXbzwSw2qzW9Q1WFx7yRu7vzOJK?=
 =?us-ascii?Q?NwDc2wO/q60ZP013uNHIL7SDSxvK1Lilm4a1qh34zY83kPRC4c/OlJDElB7v?=
 =?us-ascii?Q?N+DUoPVwhkwZ6KmV+lS1J/IkB0b4wWmHGSQ/DBPYMvatm19miguQFljISO8x?=
 =?us-ascii?Q?w0Crc1w+xTw3Sug9Uor2+olu5SbZ64whkn/gqut+5PY0iTYL0KwSzALxkKqz?=
 =?us-ascii?Q?3Vf/J9JiwBC04bWp8aD642o4TExEFhsUkdVLM16kxZikRXht0R3gyHcBeOdg?=
 =?us-ascii?Q?DrmW4Di1WYM3QOip5MTCz0DMRUV47p0NM1kQ9A0hMleJJ1KgqsQrHRXGJvly?=
 =?us-ascii?Q?4Q=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fac92d76-dcf0-424f-1f0c-08dc2065e14d
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 01:01:52.4844
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lbozE4B/Ei0z7NIgNRqQBPE05ylyq+Oh/pGt0tcAB1Jz8CL+ID4/YgphqCwrJvI5LAqQKcXh3tFJPgWsCdHX4WZMruo2DWfOgAY0lfK8oe8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0552

For PLDA DMA interrupts are not all implemented. The non-implemented
interrupts should be masked. So add a bitmap field to mask the non-
implemented interrupts.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/pci/controller/plda/pcie-microchip-host.c | 1 +
 drivers/pci/controller/plda/pcie-plda-host.c      | 6 ++++--
 drivers/pci/controller/plda/pcie-plda.h           | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index 105964306b71..48f60a04b740 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -636,6 +636,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
 
 	port->plda.event_ops = &mc_event_ops;
 	port->plda.event_irq_chip = &mc_event_irq_chip;
+	port->plda.events_bitmap = GENMASK(NUM_EVENTS - 1, 0);
 
 	/* Address translation is up; safe to enable interrupts */
 	ret = plda_init_interrupts(pdev, &port->plda, &mc_event);
diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
index 98c51e594efe..a040e7e5492f 100644
--- a/drivers/pci/controller/plda/pcie-plda-host.c
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -290,6 +290,7 @@ static void plda_handle_event(struct irq_desc *desc)
 
 	events = port->event_ops->get_events(port);
 
+	events &= port->events_bitmap;
 	for_each_set_bit(bit, &events, port->num_events)
 		generic_handle_domain_irq(port->event_domain, bit);
 
@@ -420,8 +421,9 @@ int plda_init_interrupts(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	int irq;
-	int i, intx_irq, msi_irq, event_irq;
+	int intx_irq, msi_irq, event_irq;
 	int ret;
+	u32 i;
 
 	if (!port->event_ops)
 		port->event_ops = &plda_event_ops;
@@ -439,7 +441,7 @@ int plda_init_interrupts(struct platform_device *pdev,
 	if (irq < 0)
 		return -ENODEV;
 
-	for (i = 0; i < port->num_events; i++) {
+	for_each_set_bit(i, &port->events_bitmap, port->num_events) {
 		event_irq = irq_create_mapping(port->event_domain, i);
 		if (!event_irq) {
 			dev_err(dev, "failed to map hwirq %d\n", i);
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index 6672a231a4bc..443109d04d59 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -159,6 +159,7 @@ struct plda_pcie_rp {
 	const struct plda_event_ops *event_ops;
 	const struct irq_chip *event_irq_chip;
 	void __iomem *bridge_addr;
+	unsigned long events_bitmap;
 	int num_events;
 };
 
-- 
2.17.1


