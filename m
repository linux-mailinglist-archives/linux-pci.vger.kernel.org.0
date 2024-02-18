Return-Path: <linux-pci+bounces-3684-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85235859672
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 11:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55DE6B21221
	for <lists+linux-pci@lfdr.de>; Sun, 18 Feb 2024 10:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2EEC4EB2B;
	Sun, 18 Feb 2024 10:53:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2101.outbound.protection.partner.outlook.cn [139.219.17.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5A2184F;
	Sun, 18 Feb 2024 10:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708253603; cv=fail; b=E8tg2xVddbOLv4HMzqJuTsPpe4RgBgb8iyMwLcI+KbTv4pw72ym/CSpm5j+TyJdDvJTO5JWPPm+f0g7W6KUYyDy5ztg5ZkF9RH+MvPXbd78qh/7L4CyGAj+nFeyafZtmbxaaa61/0lumSAcc9sX93lVUvN6xLsMZOHrs5xBmpdQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708253603; c=relaxed/simple;
	bh=9HFoWB89oSWytU6cFushowRyme5a5vBdtDh7hRmVzsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CwiGtmrf9mkXdpY3vBL+Db8jNXsfN4H4FHFGcTkxoIhiv4lSi2cvieBzje4kB/y6tEfvAsVoVgd6l3/HJbuZYFQVFsmPygN4GC61gq4yETFdN/BOvb54FfUz5rih243DEKSqTglwXmGActSzb7PQiMIA7Kvlvq6EfCYrPTVhjRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dDOhIvZ5mnD5elmE4SGYm/AfwzXMevLGClZ/1bowXqwztT6NHhcRtU5jErUudyAneIy8QWk9ixofIZhBDqc4M5d8JxUAqjuVnfCvAPH+Xk7UVbeNC5Zbrz+8wlsomRKWzQEE69pW1VVkz60rT8fF7k9T9qrcAllrp6W/B2jWwqKg4ofqHOtKDjCvShRYec6sumDCberQi6dd2WT/iUDRDuVGB8NlUse8GJTIc+FHkiJQ0lXJGLSkWoNYOG5929m4B7ZPD3LhzXlNTAAiQPU2Q3anTIQWDhjXtAYWkCz1O2EnK4dORPHJD6K9cko8VAOI9uPqekiEHdj2FHJhMkQ6ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4MD2usSBbRdsd/hhE4tw5xP1KyGga5Ecw5HSB56sQQ=;
 b=az25ZjnnQPWeAN1um1AQZySc7IxymulZ/4nqgfZel0bW4izVx8j3pMp0sNuHjq1KXPTPE5S0dAVK4qCpzdd6DZl5IqIU4KyBvmYkGWtAVFg3H37n6wx0iJX5jc6LEtWKffwjzb5MFbdDnjEwOWoTh6rrLE+ydlpKLURy524kr/BtT30r7ZPE4O+2xHemIyVL8YMnkB+RY5RK572FQbT1eb6edt44hGvwoVizLm+HXPpOQPGwfUVfk64ZhMM5o1umH6VfWUqhq1sWIrUYjnOlL3anFl5uKTS0/lsHMJPjHGGyBycczuRgDOAcolI8PL5Sziis1OUdoviUTSHduAS1lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0765.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.46; Sun, 18 Feb
 2024 10:19:30 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7249.051; Sun, 18 Feb 2024 10:19:30 +0000
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
Subject: [PATCH v15 17/23] PCI: plda: Add event bitmap field to struct plda_pcie_rp
Date: Sun, 18 Feb 2024 18:19:15 +0800
Message-Id: <20240218101921.113528-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240218101921.113528-1-minda.chen@starfivetech.com>
References: <20240218101921.113528-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: NT0PR01CA0010.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c510::21) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0765:EE_
X-MS-Office365-Filtering-Correlation-Id: 864ff645-3dee-47a9-f499-08dc306b1854
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z0zdOSrEdQrWAMwtsP7xDMigKcf2jXSKSWpnG3TVKOTSdfjX5xFrbgx/H5m3iWvfqpTyeGdykydC7LUrbVC0GabnQC7uaHqVx3tfzwwDckYqmnizlnPtJhPpe7U92kdZf2FRdeezvD1aMhWromwPKH0d+3v0XkorFS/NZP8aXQoVxFsVF0FY3sNkYoO/+GIT5xvxAYVmbAISlJYBc0GxxfbYoPHPu2UVWCsmh4ZGec1j9dzi9nhI5YVq8lS93A6+QHvlcCsKX4m/86us4w7ZwghGcytFdTBnfn/U403t9M9KURymewJOFg/eAUJjaRxRXOvJFL0mslMwwWh5KUNT/hdXbsfJOyK2fqU5NDQfU8KPcR5QcY8Zrmr6LrCU3mTHvMm9CqV/rymHprog59e6Ndj71f34o0oAJfKLXno2KX5oBBBJxiZR5RgyRaytKK4OftQeFzOBAJQ7B+gS17mTG+3C4ZP5fszZZ/QsomNQXzbU5NtRdN1Wq/9aLj45o4JBD35D3PPoxFtjOxA5rnKDTFvxQCF9WkTfjc61y96KTJwdKjyKsq4Fr56BZQFWMEvp
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(346002)(39830400003)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(2906002)(5660300002)(7416002)(44832011)(41320700001)(26005)(1076003)(6666004)(8936002)(66556008)(66476007)(4326008)(66946007)(107886003)(41300700001)(2616005)(83380400001)(8676002)(40180700001)(38350700005)(52116002)(508600001)(110136005)(54906003)(38100700002)(86362001)(36756003)(40160700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XOEJd14lEyl9HkE8VF+JAd8UtitRLa45GDVycR2yMRDBkr6yOHi8MaMq+208?=
 =?us-ascii?Q?idoUMjFfMk0y7xUfN8LiWZs3Rf+SjvZRg2IN3jsUCu3YLlhOoeDfSY03CNhD?=
 =?us-ascii?Q?xgdQXOTiBynCu23kASlmGIC9U1joUxLmEk2JHrtpnamKos6phha0b+e5I5V7?=
 =?us-ascii?Q?FrrTJ51yIQSOWgkeP3D1HdrLQXtZ897Bcm7ShuxVYjh1oZIoW5kmKTHLhfBH?=
 =?us-ascii?Q?IZD/YNRn1Baf2z8sM4U/5khZ+O7Xth0mYbIqJ6USW5d70wkaFOxV2hAdZ0Zn?=
 =?us-ascii?Q?cx3pPVm0aRDZJOR9HRtpWqxP/AB4rfCzGnCySsK5/jw24iyBpBerK6OYsmWS?=
 =?us-ascii?Q?crtapYD0lpmx5J3cxG1ScI3hZyxvmrReYf9O5NljhQucRIToAiu4UmnFw3OK?=
 =?us-ascii?Q?AidIxq4jOaTe+beZwBNTsA7iJEvvCH/37CNxShuUGSwSbBmmx5BE5XWKNpHg?=
 =?us-ascii?Q?e+q7T4daGxwsPkjUC9yjGdwKVyYRUoXwtjWxjXdXGQKj05tIVItCWGlMzF0S?=
 =?us-ascii?Q?9K3u6Ld601WCrzwYcdiQf0BEAIZwosTtn9k4VQA9SUXTn/gli15F3ZB8pEfn?=
 =?us-ascii?Q?AO0Zf/vyTbQFnnnv/fkkE7oBuKkgjsFdsvg3rSH2gErZgDDMPtrLoD+tNF+6?=
 =?us-ascii?Q?EXPaJdogmgUWXUqucax8+rz0/emVzxneL096n2HUGtf/ohH9kFfoEc2SFzym?=
 =?us-ascii?Q?7xxD7zWbevyjRxub4so7yhX+D/e1yx7Ieo64qJqFRtEjEHkIWZVlp+TYjD0h?=
 =?us-ascii?Q?r1WG03Swyw7jII2/ibW0EI1eqxClGYo0PCthDNFojzkdsXr4V3ivD6z0sSMB?=
 =?us-ascii?Q?otli9kIgfeHmV0+ayQWlwlK4JZsHEBrH6nhnM9fBczLqm7mDKGpbnSh7hx9p?=
 =?us-ascii?Q?5AEBIuGSi1TnGUi3YrjUrw1rquuRRy4Mu6ZCkrnd1q145SPEsdbgx0pxzAfz?=
 =?us-ascii?Q?suDRkvYMgNZWcV8cscnGj7T4HbZsbiBmjd1bZR0AnhWfSKiGgtRKzNMmoe82?=
 =?us-ascii?Q?j0vJdJnAUSg88kqL2H2xd2KPWQ6Qb1FtFsLBsGVJ5rg9iXVIENSc+HcTWP9b?=
 =?us-ascii?Q?aUpsD6fPDqUae7KzOysRFbqlHMsE34REF9qcu3gQZnfOJmc+LOYnFKJskjBw?=
 =?us-ascii?Q?PvULUK4FMpZjbKUumkEoIUln+TtCIgOnGyIEONOitxSi5xW2Ix31D7n/NgYT?=
 =?us-ascii?Q?/ZSiMx8oMyVGM6UTnO/Bdao+cBARaQw7mJJiydtDO6x73aOgOzrATs8tFj0G?=
 =?us-ascii?Q?lVe+Fwj0EUPH67hsx+zAnKh3g31SYXumihEB1qKek+OtNYanNmtnqNn3RV1I?=
 =?us-ascii?Q?4PLY+imb1m371ZG6ZwWmvapx6+d9Cd144xG6+9TQbvkwwersEz3yLDFLeoAD?=
 =?us-ascii?Q?HGvaOIII3gKGj6H9hYPyUpF8BuMhrDUi9vXONYDyzaInp9N9ySQfbxYwdvaD?=
 =?us-ascii?Q?CAcp/eqfc+a3YLRFQkb2OpxIy3aNfYQGe89NgDTsOngy+Lqw9SGnH+uIkcAv?=
 =?us-ascii?Q?cmgyhuRY08B8ei6sGUOnfNt9rJoBRKfrNQ7M3Zti2/PAAsgpJQ+pSoh1fMKO?=
 =?us-ascii?Q?k9kNrOKUBbI6AxTHvLLizZDvfz7lXEWySH3RHa5yatS0cVBk3DOsHUjSwHHX?=
 =?us-ascii?Q?IQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 864ff645-3dee-47a9-f499-08dc306b1854
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2024 10:19:30.8802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K+prY6aUblIjYQeUtX80NzWE1T3LB4w1rBF49HHHIptjtWfc/FrQuR5mvB1Z0y7xedQbsm1aFpRSHJPrHsytuSkQ5l3hwLFmifEUnKDsx+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0765

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


