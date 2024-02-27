Return-Path: <linux-pci+bounces-4099-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C8EA868DBD
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 11:37:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E704728EB66
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 10:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B5D139597;
	Tue, 27 Feb 2024 10:37:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2118.outbound.protection.partner.outlook.cn [139.219.17.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A805F139584;
	Tue, 27 Feb 2024 10:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030223; cv=fail; b=JNyre780PquKQPj8+6zWlXupCfnValoIR3KnwnOr2ih1ho0yF2l+W0qUpe59yW0mzrk/wLJzqRrMMK1KD8i96TYoDEj5FgKVhf/5Xo8STaYaYc1Vx6+fN6HeUu9m3eZdb/G0ieKTxVpB0nge91CZ5zzlPf6omGKhPJlP9edBVvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030223; c=relaxed/simple;
	bh=9HFoWB89oSWytU6cFushowRyme5a5vBdtDh7hRmVzsU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fCuqRLfThIHjgolZqXxTb1oP0Vwe43d4mzNjP1YIsMF0KSdxsOYRDeEF8GPqtYdwpg8rQOdNTfFd7W4/4wOTzh795OSsfYinxI1yEI7tt0eCgRwSiO7rM95Eyr/Kn3Fin2USyZkpI4sPDnVdgsvwhB/ypA1CeSXal7H6RAPL3po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+SrNVy1Z0uP7f7TXvQ0QwrfI7I5XKfZD09eF7ta3BWWe0ReQTRhLRvSqAqvv2S3NCLRrzOz+quvXLHzV4jE7hdczRnbz7ZxnLsqvkeCxyQ0/p9/vrL10NqoGKlrwmd8wF+KvJxdaHfwPpWrypjo0xN9zg3mSh8Z3qXpuQOENJbi6AlUl3ED4RlckpW6WUJgIIniEdKaMgVc7MtdoIB7D4HQl1afbiP79YYBp7P4VwHO58JARSIf5TxuxEd20PrxQy7n/sP2AOxjthGUoc6hggv5JPgM++Sotu2cFBmD1FET15z+JdIMynTQFr+qpJIEQijYhiyEaLszwR/GgrdGfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4MD2usSBbRdsd/hhE4tw5xP1KyGga5Ecw5HSB56sQQ=;
 b=TzTETRpQMa079TmKuQBWTg/Pkah1/LrNdWrtFZG6H37BLfz5DTd4mZbFsL3v6h5jWCC1WDm/EuAYLJdu5d5yzg7VGxhQeS3mqQvIhuYcLPyOIU9tfUtW9V7RNCzRtcB2Qboco8YXf8CBnQvwCSG08Va0j2yp5/z7oAqFk3zfoRdeiSUpVW7HdpLqByBw94h7dkSBLH+JZyPR7ALJTjpx2iKbDen9jKCdOrFhudPowa9TvYQl67bC9SPej9Um/6oz1D4LIKJHAGx5WKEdSMidSR/oyX5XvEMlW53mtEsaleEesfwtINbIW+XDOcyqsAeOMDy8Wues2v8ynhJPHIt6qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Tue, 27 Feb
 2024 10:35:47 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7270.047; Tue, 27 Feb 2024 10:35:47 +0000
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
Subject: [PATCH v15,RESEND 17/23] PCI: plda: Add event bitmap field to struct plda_pcie_rp
Date: Tue, 27 Feb 2024 18:35:16 +0800
Message-Id: <20240227103522.80915-18-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: d076303f-2adc-4838-6de0-08dc377fdc05
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	d96OcOzQxRPLm3QwUcdBxAezXVvVlrGoTWGnxuHvWUH16KizlOhMBljlcm4I2fgzofS3rEAkDompBWqHd3pjkMS6Gq4i4Y0yg4SNTA4k0Z4hikeMBCU7h+tEP2f4KzxTht4b0CgEHqxu7t9PsjgUkL1O/fl5N1spYxvzOEwr759jPgrgjNhQt02KUuRHgIiXqqwsFQm51kZg+CCrUwQdziTDCKUwkG6LjSPSby3U/Iw7/sQ8Q9SakDQ7dvNNRXepVx1IsSLDH0rKAVS8WfX0dqvsZXW7kJUGtW933ixmoDkdiOrZLkj/+VHQC5F/O60m9AzxqQ4Q7p52BdQnCleeeYaTMNl3l7XZX3+VYL10K8XpFCZnTEsM6uGjJR9flANSlIWg0BloCALxRp65F7egxlbuNB50Vh1GQgb8WeVP7fU5k9wXl1pnj6WOfBpPtLjjLkaWTp/MJIADtTEWTH+X2whNL12RfF/tcSova0W34BACTYqdQ3PCdscYi7T6Glzb0DaT3U8QuzMM++4f0CP9Hz2L8YWOE9abNPTzBi+lCgSljbMxnyxPmDjmmdrDl1i6uJBlDa8vS0O0wZYlTdtsnE9E0ylg5nf2gVl5cXK+T6Hq/ZBhkISU7bitPyh3Oh23
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TlHnzMaZA9a4RnMCudKzByi4vhbbY1NaYEGw78KivlLLLja0RTz55ws0qTCF?=
 =?us-ascii?Q?sZp/XBaYmUpsKRdzY3JQBTPTbUk7UrL6EfGZEbkN475CvHiyb2d7vbDZ/Dll?=
 =?us-ascii?Q?Zn+xigsvmYNWkJfgsMQAkOpKjSnjDxKpMCFYknx7T+RMNMPtEWwi43QMLzxg?=
 =?us-ascii?Q?vCawhtQm8DCcTMQMGMtScslmOIhnOo1zG9MkfrnZFCLr6v/hGriSJN+yX65g?=
 =?us-ascii?Q?hNaB4pzImztxHE7e2Up3ce69l9UvhvzJj7gBWjA9SiWtcuqQxeq0PquvNgyw?=
 =?us-ascii?Q?kLibCujoqfKTkYV01k2tuvm5pNno4NDhKe8n69Zfz6anWP79yq8fkNyU/yt2?=
 =?us-ascii?Q?ZF5w4qALlYWZKYOjLMvbW1YV0yY/y7+cj0zawNTT4C1wew9RXRw5fY0VjlSX?=
 =?us-ascii?Q?xMvl8eOr8kolcB4B3S8+UWdiOw7z2cQBaWwLuvHOaYmNouWngbPb5IZdGn5C?=
 =?us-ascii?Q?zrZPDAlyC0Q3aiQLHFzkT0ZmI2gH/Lg/virrK00QFAeiEmhPtaZbZO0yHC+K?=
 =?us-ascii?Q?Xrr7Aq/9TrrvduiXJlp2gZAhvLV8rt1nAK/5jZLi6EOXTaKX8fFcA43YLGlK?=
 =?us-ascii?Q?gGPJlsYMgwLadKMofmiRl2oFvwiJFAqJW6bAfT03Nd8cVXjdAAnoNIr7chOc?=
 =?us-ascii?Q?4LhkiLV8vvoJchufiIMWbd8miRdfC0hvT8DeHVjC+NqZVoovZxrYuhKI7Cad?=
 =?us-ascii?Q?f0/DQ+qrY0F4ExiWygxgMa4uYF4QXjv/Vpu3gVhKhK81mhNQvlidfA0j4YB6?=
 =?us-ascii?Q?9VaPs0pC3ypxy0Yvea03OdKeFRGKVvU9lxKg8CJ1+UGxZhU0Z/uJdmi57T9g?=
 =?us-ascii?Q?U2bEwwPTelKu6ZB5ewFM91jB61X85MP3ONEZQaugX2It0nsgGPfx5hnArnPp?=
 =?us-ascii?Q?uj2lq1rwATljByx/c5P6EF+jU2/ygDnfpNlpSrjo1qSBVGipqBQcKspRy+nC?=
 =?us-ascii?Q?HlgbwMb4PR1U33KZi0x1vZGpBd/UIElDvyGhkbjLTF4WWIrYs93m6OjTMenA?=
 =?us-ascii?Q?IiiXkaJA9zS4+M8ddmCIfJo3BCFKRiRzZmA8ueErKaOyVzxTkpS7J23wDEfP?=
 =?us-ascii?Q?9k9G5xDcST98gAuJTEr6DqWUNqB8q93dVRkbgOvYI1MdvNaewr52cvKaLpR/?=
 =?us-ascii?Q?laM4BO+zrDiHwp+GWAcOsN4sB0WeF2w/Qx41dfpPvl6UKcZlKWP8QtjvODSu?=
 =?us-ascii?Q?qy2EankB2eBuSFTrGWJvvsCiNBEVEibzHip+q0Qui7oIvUcQ75yeYYyCe0n6?=
 =?us-ascii?Q?jx/BiLedWQkdmhcG3gMejkzMVMnCLHy8Im7tIdvwqCy/oYMqJ60LHXquPDbS?=
 =?us-ascii?Q?ScJlNxphYJcxghljaRbW/do+WCtUTENpVy6MUROT+osoYfYHXValRBdo34nU?=
 =?us-ascii?Q?WkjYm8paglbJkZzrWxIeIM90BVtSoYhQWyavTDu+//CyQDeBfZmZNTHapg/J?=
 =?us-ascii?Q?hQ8uwp/PeesAg38jyTyrAiGFEDtiCDnCj38Ein3H8t5Q1P4PnAQ8/U8wlXOU?=
 =?us-ascii?Q?ptFkZopEKSViu/+rHy/f0BrAAoxXeLW7S9j6ubc8otZBxjdwXgmztoilMic0?=
 =?us-ascii?Q?ouYWw6FhloXL6gKO3pXAaq3hhnSq8KGQ6fwaTWrV2MobXF8JHHJXnFwm9i1r?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d076303f-2adc-4838-6de0-08dc377fdc05
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 10:35:47.2709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: McO7w5cJtbY2M5zaoKRIMUGBieUJwGAkvrkoIY0RulirscCasRzLqss9kSVOKhnHdP+Fyp12V6cODvaKd4eEExXMMjOf6HblH8PDq1vC5fA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0496

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


