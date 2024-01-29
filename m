Return-Path: <linux-pci+bounces-2664-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 695D383FB89
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 02:02:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C45741F221AA
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 01:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34CD08F5B;
	Mon, 29 Jan 2024 01:02:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2063.outbound.protection.partner.outlook.cn [139.219.17.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCD5EEB1;
	Mon, 29 Jan 2024 01:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706490123; cv=fail; b=bwo01aXByz6ViQh8T7421YhXjppDj1kPiVUpN4ZDAfy/dUwx0I7Wop41h+VeQaKnj7s7DhWVNE78tS3L1GehwkWS1Fc9knPwXKHPCI/U7QcTLIMbLAQ3aW2x0fcH93OUvdtOjzUCpIV/QBZgGn5Lz5ourIc+DrGIasG4iifkdp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706490123; c=relaxed/simple;
	bh=ggawvIbzZ+PVOvsxbzkoIgKBxmy45+7ZS0uM5XtO8PE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Y1Vo8hyOx9jhAAyQKEyRt3/bDLs3pccuWsnpEDUhXN/xML/P86xi27uGZWg5njeQBb/jJyzwpv/LHt/audgoc5r9yXckQCrlSuSvVF4Rj6V6uLvDXXSHRReWTw+gYfNvjJKHzjyVxmdlqn34J5vLj+iBgk2OSEFaTZYxH8XGkbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B4PlyDaEoJMOEH9PiZcJBrshrMc/tlApWroFzX41ri2Z6m4CRSXjAHFEM5qx/aLw2PnghthMTY19ahrg1Eq5zl1ncdy6qiiYIH0rCOrjQFFZIGhCJmPEpSYVqheQw48lMeTUHjzwLs9P0ipYfuA/lFoKhA9+FmdYR3Dv0NovpdcvCwP9yZIe44nEpk6KvmwssTTNi2X9/DXwzI6+9rT1at+FL47djHKh6pdiRBkb0DjHKdg/USVxc5QdlMXHujAtreiNQwJIHm2YNxwsIXryrxHGaJwYezVkkEDNdYRHuR36cHIPSk6VnAIz+Hv9VMWMxv5/DXceuL6wFipnSA/ZBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUkOg1G/JyezYceJLyKECcz3PCvNZXhK6wSQeUoGtK0=;
 b=Ipj/8Hkr5WHC99Yl019pmbpK3veAdxAE9FBnTzT2y4mOtIEWFrNdb2HxKexN1fhbH1jc1GSN/TFB6RE4n93zzkEVEIYOWPSjpPzeGoTz609gPSW1bPfMo2ZJbDSoaQ5y893dKK+rrwxcbqRZqERakS6nWukfHzez6b6ux7zhnX/WKaPMAL71Kj49mZMGRoixCXM2Yg+PWoirvdrvcQl9jclGEJeHdLxRPFGfOlQwXTNXYad3hj0eM74zHs2BByyZL0PUMC4Fbr4At8c45sdiNjc8BPiHfKH57LTmMALEYgaodc6XNa7GYX+brkPLTsDKMNvgVRB0T/rFDfeNmbXc+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0552.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:13::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Mon, 29 Jan
 2024 01:01:50 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::1ea1:19d5:efef:6fc6]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::1ea1:19d5:efef:6fc6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 01:01:50 +0000
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
Subject: [PATCH v14,RESEND 16/22] PCI: microchip: Move IRQ functions to pcie-plda-host.c
Date: Mon, 29 Jan 2024 09:01:36 +0800
Message-Id: <20240129010142.3732-1-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-Office365-Filtering-Correlation-Id: 2840ae97-17b0-416c-1c9b-08dc2065e042
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VKkM/yDVtvewTg/4i3MuYF/NZHUCisA8v1ZurZA4QApIpkSE9kSN3fsM+2pqKkCzo5hGqLqt/GSfvpiBi10i3plKuDFTFoJ+uhnqZADW1JhKoxUIqfWAC9l7ktOXQv0GwA57t/bUnf6HG1tIIIjVDeD0iNfuK5o4r2MHNZhklKf38pjVBeBkIu31Y3xoMf7aL8rsaO0PwdF7oy50ZYq3psWO/8GeiO4GTA3fC/8DdAw8rttqhgyIaOoayOX7sEttMwqIU3R1ge2Hk3y88jthl7QtENeYObdf1nQu2FEjDgoapt0EpUb1VTySOVF/o7DbvLlwW+NK9gFEQoHhRRcdcBGCFHl5s+X9aJpp6+wSeUioNSXJXtmxfec6pbH6Rkga5jf2nVza5jB4PrZcLcB6XbShSQWlWc2jH66gvN9FbvoH1CzAcJxkA9gE8zfRr+9K/GM2SHW336Y2+py1fWObo7A75+MMrG64p+jkGuZgju3zczy6YQu8N95XAqZFxHaEngITANwrwXM7sSYdARvLwgCmwby0ohFnnrNljMQOB9mqc0kYrFGvd/KXhyMo6bW1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39830400003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(107886003)(2616005)(1076003)(41300700001)(26005)(41320700001)(40180700001)(40160700002)(38350700005)(508600001)(6666004)(83380400001)(54906003)(52116002)(36756003)(38100700002)(2906002)(66476007)(5660300002)(8936002)(86362001)(66946007)(30864003)(110136005)(44832011)(4326008)(7416002)(8676002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7oqOjzw8D0NXDEWWqUB51X1WMnmWdconaHd50guWMCWk/J4gmeEc9DxoS6o6?=
 =?us-ascii?Q?FgIUu7ZdlHPe5siC+oZAEGzEFyzZ8VQxcDT5ODi8gcxUHgfLe9gjSrnsiGcG?=
 =?us-ascii?Q?WAggziYu82eEw9SGGQRtKSNAdOkh0oxk2ETL+H0P2dcW7euZV+9ZoNYfA8Qx?=
 =?us-ascii?Q?LbFlfCaIsCqstcKmo1ftd9+Ug2pvzneiM/7e3JQInEiJJZcpl0vtChSIEV9Z?=
 =?us-ascii?Q?0gmPI2sH1vrR011sCCNwkqG4LGwRSxD8li5A5bTh7ZVfBjkHE54rk9EJV0eW?=
 =?us-ascii?Q?RFUurUqcSoEkj4VB3E5kGB1QGvtPZlEK/TarQpm0SDyr9RSb8ukzowL3Kr7B?=
 =?us-ascii?Q?bTakFCa3nnS6rEqGKProWoKin6igJKGcV+Z0+65UOpDFDxnONrHx1d15cbRp?=
 =?us-ascii?Q?wwiQEGmVYJU1KD3uSTa0B9RcJXqHKfBBUZNd0wAcIuGsm/JtL95HXpZd/xXb?=
 =?us-ascii?Q?dEIZL0oNiGt5AVyZHcLVbws9kylae8xHP7/QeeSK6CZNej9t9jIFyHH7Qjxy?=
 =?us-ascii?Q?5y+/7DWYkXThp5mzh+GKAPCaxEp1IqDAf/oGFu67FaXyk/lkYCYxkcwG45Fw?=
 =?us-ascii?Q?erBKcf3DENRr+7ps3A0YBlzjNxcNrhtwEkwWa+3nQYhDDjJSbI3uT5NQp35u?=
 =?us-ascii?Q?JEBDT1gkGGAthm3ekn1DM3a3RmREufNfaSpcO+RW9pl+kLQ0A4N/KhfaRZN9?=
 =?us-ascii?Q?tmjn4YEFsDB3xy1SeRcDo9mCN+8vZA85lrfCMafbbtDkBzQ3uMhvprUk2KqV?=
 =?us-ascii?Q?ZwBelfiFPPqh3mHcRsWFFjhc1xx6tqGjByf0KMlbHEQYXg/wYznidoOJuNEF?=
 =?us-ascii?Q?v4Db/LSVlUjMB2yCUElHQBj+B+jdEi6o17npSJza8QXPSwNkQ/AViKS77YPK?=
 =?us-ascii?Q?wiCfDRhuXGgF/weBn/wHLhoiVO2emKhHlUd9ZzqrjteY5TatlobDo/froARc?=
 =?us-ascii?Q?gaKT7vzrmeJApRergFxBbz2+7UyQQDhRzXJ7IBnr6d+njwp0P09E4+mfLoDB?=
 =?us-ascii?Q?MveXz+Utfvl5OnhcVGr7En+iac18aGRDVnyY5hv1oOgU72Q84YGXDfs0mgAS?=
 =?us-ascii?Q?XgJ/XxUg5vPNvUQfm8GRRlyCjaJm93UYJm32Kl+rCmpNuPF98EZTi+NsiZc+?=
 =?us-ascii?Q?Gd08zMSXEBq9jtGXu7HbCPT97EsckT19Gi+LyjA0LjkeeAGuq3KqCpX8muxw?=
 =?us-ascii?Q?iaKLtqTjSGPAb7FHMeawI6enADNDnCjgGfJc3fv9nr5HRbHTNv2d137T6Jtr?=
 =?us-ascii?Q?lQizOVeVtoJZ9ujfUoIh9r7yslE+7c5YR4kRJieEDURB1HQH8S4dPLJhwXqJ?=
 =?us-ascii?Q?BQbtOMu3rZQFRlLEncmbRxi61uI2+WR/ahUMhIUzL8fvp+DbtJL/kd4isfqJ?=
 =?us-ascii?Q?ImYuTFMismEzLbWK4DsV0wZcR716xb8yg+hxVnYBpmW3G1IE8yEDvzuE2tJw?=
 =?us-ascii?Q?DLcVCSyoAt8jqiVVBA102pLOnsJVybaDQtd3GsdGl7Plmc6bdyvAvtQ7qgMg?=
 =?us-ascii?Q?w9kEvT6GZdL63NHnti2XJM16D6BL711wFV4kLu8uu1jlQr0MFd7NjmSUCvi7?=
 =?us-ascii?Q?BZLesJkpUB5/oQknfwCzxZm17yJFQEBIXBFWTaOBb6focHiHXx1jngKEWSvn?=
 =?us-ascii?Q?xw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2840ae97-17b0-416c-1c9b-08dc2065e042
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 01:01:50.8138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wg7N44OHdT7oQX7uTu0uL/BZ7w2mBQjj9K3F6/iea9tEyb45tyanhvai8Eji79YB/bOi3KPIxdCBNrumNFdUTrLFOBIkNkXASaIvHuYZa0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0552

Move IRQ related functions to pcie-plda-host.c for re-use these codes.

The re-use code including MSI, INTx, event interrupts and IRQ init
functions.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../pci/controller/plda/pcie-microchip-host.c | 467 -----------------
 drivers/pci/controller/plda/pcie-plda-host.c  | 473 ++++++++++++++++++
 drivers/pci/controller/plda/pcie-plda.h       |   3 +
 3 files changed, 476 insertions(+), 467 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index beaf5c27da84..105964306b71 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -318,244 +318,6 @@ static void mc_pcie_enable_msi(struct mc_pcie *port, void __iomem *ecam)
 		       ecam + MC_MSI_CAP_CTRL_OFFSET + PCI_MSI_ADDRESS_HI);
 }
 
-static void plda_handle_msi(struct irq_desc *desc)
-{
-	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct device *dev = port->dev;
-	struct plda_msi *msi = &port->msi;
-	void __iomem *bridge_base_addr = port->bridge_addr;
-	unsigned long status;
-	u32 bit;
-	int ret;
-
-	chained_irq_enter(chip, desc);
-
-	status = readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
-	if (status & PM_MSI_INT_MSI_MASK) {
-		writel_relaxed(status & PM_MSI_INT_MSI_MASK, bridge_base_addr + ISTATUS_LOCAL);
-		status = readl_relaxed(bridge_base_addr + ISTATUS_MSI);
-		for_each_set_bit(bit, &status, msi->num_vectors) {
-			ret = generic_handle_domain_irq(msi->dev_domain, bit);
-			if (ret)
-				dev_err_ratelimited(dev, "bad MSI IRQ %d\n",
-						    bit);
-		}
-	}
-
-	chained_irq_exit(chip, desc);
-}
-
-static void plda_msi_bottom_irq_ack(struct irq_data *data)
-{
-	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
-	void __iomem *bridge_base_addr = port->bridge_addr;
-	u32 bitpos = data->hwirq;
-
-	writel_relaxed(BIT(bitpos), bridge_base_addr + ISTATUS_MSI);
-}
-
-static void plda_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
-{
-	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
-	phys_addr_t addr = port->msi.vector_phy;
-
-	msg->address_lo = lower_32_bits(addr);
-	msg->address_hi = upper_32_bits(addr);
-	msg->data = data->hwirq;
-
-	dev_dbg(port->dev, "msi#%x address_hi %#x address_lo %#x\n",
-		(int)data->hwirq, msg->address_hi, msg->address_lo);
-}
-
-static int plda_msi_set_affinity(struct irq_data *irq_data,
-				 const struct cpumask *mask, bool force)
-{
-	return -EINVAL;
-}
-
-static struct irq_chip plda_msi_bottom_irq_chip = {
-	.name = "PLDA MSI",
-	.irq_ack = plda_msi_bottom_irq_ack,
-	.irq_compose_msi_msg = plda_compose_msi_msg,
-	.irq_set_affinity = plda_msi_set_affinity,
-};
-
-static int plda_irq_msi_domain_alloc(struct irq_domain *domain,
-				     unsigned int virq,
-				     unsigned int nr_irqs,
-				     void *args)
-{
-	struct plda_pcie_rp *port = domain->host_data;
-	struct plda_msi *msi = &port->msi;
-	unsigned long bit;
-
-	mutex_lock(&msi->lock);
-	bit = find_first_zero_bit(msi->used, msi->num_vectors);
-	if (bit >= msi->num_vectors) {
-		mutex_unlock(&msi->lock);
-		return -ENOSPC;
-	}
-
-	set_bit(bit, msi->used);
-
-	irq_domain_set_info(domain, virq, bit, &plda_msi_bottom_irq_chip,
-			    domain->host_data, handle_edge_irq, NULL, NULL);
-
-	mutex_unlock(&msi->lock);
-
-	return 0;
-}
-
-static void plda_irq_msi_domain_free(struct irq_domain *domain,
-				     unsigned int virq,
-				     unsigned int nr_irqs)
-{
-	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
-	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(d);
-	struct plda_msi *msi = &port->msi;
-
-	mutex_lock(&msi->lock);
-
-	if (test_bit(d->hwirq, msi->used))
-		__clear_bit(d->hwirq, msi->used);
-	else
-		dev_err(port->dev, "trying to free unused MSI%lu\n", d->hwirq);
-
-	mutex_unlock(&msi->lock);
-}
-
-static const struct irq_domain_ops msi_domain_ops = {
-	.alloc	= plda_irq_msi_domain_alloc,
-	.free	= plda_irq_msi_domain_free,
-};
-
-static struct irq_chip plda_msi_irq_chip = {
-	.name = "PLDA PCIe MSI",
-	.irq_ack = irq_chip_ack_parent,
-	.irq_mask = pci_msi_mask_irq,
-	.irq_unmask = pci_msi_unmask_irq,
-};
-
-static struct msi_domain_info plda_msi_domain_info = {
-	.flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		  MSI_FLAG_PCI_MSIX),
-	.chip = &plda_msi_irq_chip,
-};
-
-static int plda_allocate_msi_domains(struct plda_pcie_rp *port)
-{
-	struct device *dev = port->dev;
-	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
-	struct plda_msi *msi = &port->msi;
-
-	mutex_init(&port->msi.lock);
-
-	msi->dev_domain = irq_domain_add_linear(NULL, msi->num_vectors,
-						&msi_domain_ops, port);
-	if (!msi->dev_domain) {
-		dev_err(dev, "failed to create IRQ domain\n");
-		return -ENOMEM;
-	}
-
-	msi->msi_domain = pci_msi_create_irq_domain(fwnode,
-						    &plda_msi_domain_info,
-						    msi->dev_domain);
-	if (!msi->msi_domain) {
-		dev_err(dev, "failed to create MSI domain\n");
-		irq_domain_remove(msi->dev_domain);
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-static void plda_handle_intx(struct irq_desc *desc)
-{
-	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct device *dev = port->dev;
-	void __iomem *bridge_base_addr = port->bridge_addr;
-	unsigned long status;
-	u32 bit;
-	int ret;
-
-	chained_irq_enter(chip, desc);
-
-	status = readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
-	if (status & PM_MSI_INT_INTX_MASK) {
-		status &= PM_MSI_INT_INTX_MASK;
-		status >>= PM_MSI_INT_INTX_SHIFT;
-		for_each_set_bit(bit, &status, PCI_NUM_INTX) {
-			ret = generic_handle_domain_irq(port->intx_domain, bit);
-			if (ret)
-				dev_err_ratelimited(dev, "bad INTx IRQ %d\n",
-						    bit);
-		}
-	}
-
-	chained_irq_exit(chip, desc);
-}
-
-static void plda_ack_intx_irq(struct irq_data *data)
-{
-	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
-	void __iomem *bridge_base_addr = port->bridge_addr;
-	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
-
-	writel_relaxed(mask, bridge_base_addr + ISTATUS_LOCAL);
-}
-
-static void plda_mask_intx_irq(struct irq_data *data)
-{
-	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
-	void __iomem *bridge_base_addr = port->bridge_addr;
-	unsigned long flags;
-	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
-	u32 val;
-
-	raw_spin_lock_irqsave(&port->lock, flags);
-	val = readl_relaxed(bridge_base_addr + IMASK_LOCAL);
-	val &= ~mask;
-	writel_relaxed(val, bridge_base_addr + IMASK_LOCAL);
-	raw_spin_unlock_irqrestore(&port->lock, flags);
-}
-
-static void plda_unmask_intx_irq(struct irq_data *data)
-{
-	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
-	void __iomem *bridge_base_addr = port->bridge_addr;
-	unsigned long flags;
-	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
-	u32 val;
-
-	raw_spin_lock_irqsave(&port->lock, flags);
-	val = readl_relaxed(bridge_base_addr + IMASK_LOCAL);
-	val |= mask;
-	writel_relaxed(val, bridge_base_addr + IMASK_LOCAL);
-	raw_spin_unlock_irqrestore(&port->lock, flags);
-}
-
-static struct irq_chip plda_intx_irq_chip = {
-	.name = "PLDA PCIe INTx",
-	.irq_ack = plda_ack_intx_irq,
-	.irq_mask = plda_mask_intx_irq,
-	.irq_unmask = plda_unmask_intx_irq,
-};
-
-static int plda_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
-			      irq_hw_number_t hwirq)
-{
-	irq_set_chip_and_handler(irq, &plda_intx_irq_chip, handle_level_irq);
-	irq_set_chip_data(irq, domain->host_data);
-
-	return 0;
-}
-
-static const struct irq_domain_ops intx_domain_ops = {
-	.map = plda_pcie_intx_map,
-};
-
 static inline u32 reg_to_event(u32 reg, struct event_map field)
 {
 	return (reg & field.reg_mask) ? BIT(field.event_bit) : 0;
@@ -626,26 +388,6 @@ static u32 mc_get_events(struct plda_pcie_rp *port)
 	return events;
 }
 
-static u32 plda_get_events(struct plda_pcie_rp *port)
-{
-	u32 events, val, origin;
-
-	origin = readl_relaxed(port->bridge_addr + ISTATUS_LOCAL);
-
-	/* MSI event and sys events */
-	val = (origin & SYS_AND_MSI_MASK) >> PM_MSI_INT_MSI_SHIFT;
-	events = val << (PM_MSI_INT_MSI_SHIFT - PCI_NUM_INTX + 1);
-
-	/* INTx events */
-	if (origin & PM_MSI_INT_INTX_MASK)
-		events |= BIT(PM_MSI_INT_INTX_SHIFT);
-
-	/* remains are same with register */
-	events |= origin & GENMASK(P_ATR_EVT_DOORBELL_SHIFT, 0);
-
-	return events;
-}
-
 static irqreturn_t mc_event_handler(int irq, void *dev_id)
 {
 	struct plda_pcie_rp *port = dev_id;
@@ -662,28 +404,6 @@ static irqreturn_t mc_event_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-static irqreturn_t plda_event_handler(int irq, void *dev_id)
-{
-	return IRQ_HANDLED;
-}
-
-static void plda_handle_event(struct irq_desc *desc)
-{
-	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
-	unsigned long events;
-	u32 bit;
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-
-	chained_irq_enter(chip, desc);
-
-	events = port->event_ops->get_events(port);
-
-	for_each_set_bit(bit, &events, port->num_events)
-		generic_handle_domain_irq(port->event_domain, bit);
-
-	chained_irq_exit(chip, desc);
-}
-
 static void mc_ack_event_irq(struct irq_data *data)
 {
 	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
@@ -770,83 +490,6 @@ static struct irq_chip mc_event_irq_chip = {
 	.irq_unmask = mc_unmask_event_irq,
 };
 
-static u32 plda_hwirq_to_mask(int hwirq)
-{
-	u32 mask;
-
-	/* hwirq 23 - 0 are the same with register */
-	if (hwirq < EVENT_PM_MSI_INT_INTX)
-		mask = BIT(hwirq);
-	else if (hwirq == EVENT_PM_MSI_INT_INTX)
-		mask = PM_MSI_INT_INTX_MASK;
-	else
-		mask = BIT(hwirq + PCI_NUM_INTX - 1);
-
-	return mask;
-}
-
-static void plda_ack_event_irq(struct irq_data *data)
-{
-	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
-
-	writel_relaxed(plda_hwirq_to_mask(data->hwirq),
-		       port->bridge_addr + ISTATUS_LOCAL);
-}
-
-static void plda_mask_event_irq(struct irq_data *data)
-{
-	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
-	u32 mask, val;
-
-	mask = plda_hwirq_to_mask(data->hwirq);
-
-	raw_spin_lock(&port->lock);
-	val = readl_relaxed(port->bridge_addr + IMASK_LOCAL);
-	val &= ~mask;
-	writel_relaxed(val, port->bridge_addr + IMASK_LOCAL);
-	raw_spin_unlock(&port->lock);
-}
-
-static void plda_unmask_event_irq(struct irq_data *data)
-{
-	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
-	u32 mask, val;
-
-	mask = plda_hwirq_to_mask(data->hwirq);
-
-	raw_spin_lock(&port->lock);
-	val = readl_relaxed(port->bridge_addr + IMASK_LOCAL);
-	val |= mask;
-	writel_relaxed(val, port->bridge_addr + IMASK_LOCAL);
-	raw_spin_unlock(&port->lock);
-}
-
-static struct irq_chip plda_event_irq_chip = {
-	.name = "PLDA PCIe EVENT",
-	.irq_ack = plda_ack_event_irq,
-	.irq_mask = plda_mask_event_irq,
-	.irq_unmask = plda_unmask_event_irq,
-};
-
-static const struct plda_event_ops plda_event_ops = {
-	.get_events = plda_get_events,
-};
-
-static int plda_pcie_event_map(struct irq_domain *domain, unsigned int irq,
-			       irq_hw_number_t hwirq)
-{
-	struct plda_pcie_rp *port = (void *)domain->host_data;
-
-	irq_set_chip_and_handler(irq, port->event_irq_chip, handle_level_irq);
-	irq_set_chip_data(irq, domain->host_data);
-
-	return 0;
-}
-
-static const struct irq_domain_ops plda_event_domain_ops = {
-	.map = plda_pcie_event_map,
-};
-
 static inline void mc_pcie_deinit_clk(void *data)
 {
 	struct clk *clk = data;
@@ -909,47 +552,6 @@ static const struct plda_event mc_event = {
 	.msi_event         = EVENT_LOCAL_PM_MSI_INT_MSI,
 };
 
-static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
-{
-	struct device *dev = port->dev;
-	struct device_node *node = dev->of_node;
-	struct device_node *pcie_intc_node;
-
-	/* Setup INTx */
-	pcie_intc_node = of_get_next_child(node, NULL);
-	if (!pcie_intc_node) {
-		dev_err(dev, "failed to find PCIe Intc node\n");
-		return -EINVAL;
-	}
-
-	port->event_domain = irq_domain_add_linear(pcie_intc_node,
-						   port->num_events,
-						   &plda_event_domain_ops,
-						   port);
-	if (!port->event_domain) {
-		dev_err(dev, "failed to get event domain\n");
-		of_node_put(pcie_intc_node);
-		return -ENOMEM;
-	}
-
-	irq_domain_update_bus_token(port->event_domain, DOMAIN_BUS_NEXUS);
-
-	port->intx_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
-						  &intx_domain_ops, port);
-	if (!port->intx_domain) {
-		dev_err(dev, "failed to get an INTx IRQ domain\n");
-		of_node_put(pcie_intc_node);
-		return -ENOMEM;
-	}
-
-	irq_domain_update_bus_token(port->intx_domain, DOMAIN_BUS_WIRED);
-
-	of_node_put(pcie_intc_node);
-	raw_spin_lock_init(&port->lock);
-
-	return plda_allocate_msi_domains(port);
-}
-
 static inline void mc_clear_secs(struct mc_pcie *port)
 {
 	void __iomem *ctrl_base_addr = port->axi_base_addr + MC_PCIE_CTRL_ADDR;
@@ -1010,75 +612,6 @@ static void mc_disable_interrupts(struct mc_pcie *port)
 	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
 }
 
-static int plda_init_interrupts(struct platform_device *pdev,
-				struct plda_pcie_rp *port,
-				const struct plda_event *event)
-{
-	struct device *dev = &pdev->dev;
-	int irq;
-	int i, intx_irq, msi_irq, event_irq;
-	int ret;
-
-	if (!port->event_ops)
-		port->event_ops = &plda_event_ops;
-
-	if (!port->event_irq_chip)
-		port->event_irq_chip = &plda_event_irq_chip;
-
-	ret = plda_pcie_init_irq_domains(port);
-	if (ret) {
-		dev_err(dev, "failed creating IRQ domains\n");
-		return ret;
-	}
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq < 0)
-		return -ENODEV;
-
-	for (i = 0; i < port->num_events; i++) {
-		event_irq = irq_create_mapping(port->event_domain, i);
-		if (!event_irq) {
-			dev_err(dev, "failed to map hwirq %d\n", i);
-			return -ENXIO;
-		}
-
-		if (event->request_event_irq)
-			ret = event->request_event_irq(port, event_irq, i);
-		else
-			ret = devm_request_irq(dev, event_irq,
-					       plda_event_handler,
-					       0, NULL, port);
-
-		if (ret) {
-			dev_err(dev, "failed to request IRQ %d\n", event_irq);
-			return ret;
-		}
-	}
-
-	intx_irq = irq_create_mapping(port->event_domain,
-				      event->intx_event);
-	if (!intx_irq) {
-		dev_err(dev, "failed to map INTx interrupt\n");
-		return -ENXIO;
-	}
-
-	/* Plug the INTx chained handler */
-	irq_set_chained_handler_and_data(intx_irq, plda_handle_intx, port);
-
-	msi_irq = irq_create_mapping(port->event_domain,
-				     event->msi_event);
-	if (!msi_irq)
-		return -ENXIO;
-
-	/* Plug the MSI chained handler */
-	irq_set_chained_handler_and_data(msi_irq, plda_handle_msi, port);
-
-	/* Plug the main event chained handler */
-	irq_set_chained_handler_and_data(irq, plda_handle_event, port);
-
-	return 0;
-}
-
 static int mc_platform_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
index 05ea68baebfb..98c51e594efe 100644
--- a/drivers/pci/controller/plda/pcie-plda-host.c
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -7,10 +7,483 @@
  * Author: Daire McNamara <daire.mcnamara@microchip.com>
  */
 
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/msi.h>
+#include <linux/pci_regs.h>
 #include <linux/pci-ecam.h>
 
 #include "pcie-plda.h"
 
+static void plda_handle_msi(struct irq_desc *desc)
+{
+	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct device *dev = port->dev;
+	struct plda_msi *msi = &port->msi;
+	void __iomem *bridge_base_addr = port->bridge_addr;
+	unsigned long status;
+	u32 bit;
+	int ret;
+
+	chained_irq_enter(chip, desc);
+
+	status = readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
+	if (status & PM_MSI_INT_MSI_MASK) {
+		writel_relaxed(status & PM_MSI_INT_MSI_MASK,
+			       bridge_base_addr + ISTATUS_LOCAL);
+		status = readl_relaxed(bridge_base_addr + ISTATUS_MSI);
+		for_each_set_bit(bit, &status, msi->num_vectors) {
+			ret = generic_handle_domain_irq(msi->dev_domain, bit);
+			if (ret)
+				dev_err_ratelimited(dev, "bad MSI IRQ %d\n",
+						    bit);
+		}
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void plda_msi_bottom_irq_ack(struct irq_data *data)
+{
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+	void __iomem *bridge_base_addr = port->bridge_addr;
+	u32 bitpos = data->hwirq;
+
+	writel_relaxed(BIT(bitpos), bridge_base_addr + ISTATUS_MSI);
+}
+
+static void plda_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
+{
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+	phys_addr_t addr = port->msi.vector_phy;
+
+	msg->address_lo = lower_32_bits(addr);
+	msg->address_hi = upper_32_bits(addr);
+	msg->data = data->hwirq;
+
+	dev_dbg(port->dev, "msi#%x address_hi %#x address_lo %#x\n",
+		(int)data->hwirq, msg->address_hi, msg->address_lo);
+}
+
+static int plda_msi_set_affinity(struct irq_data *irq_data,
+				 const struct cpumask *mask, bool force)
+{
+	return -EINVAL;
+}
+
+static struct irq_chip plda_msi_bottom_irq_chip = {
+	.name = "PLDA MSI",
+	.irq_ack = plda_msi_bottom_irq_ack,
+	.irq_compose_msi_msg = plda_compose_msi_msg,
+	.irq_set_affinity = plda_msi_set_affinity,
+};
+
+static int plda_irq_msi_domain_alloc(struct irq_domain *domain,
+				     unsigned int virq,
+				     unsigned int nr_irqs,
+				     void *args)
+{
+	struct plda_pcie_rp *port = domain->host_data;
+	struct plda_msi *msi = &port->msi;
+	unsigned long bit;
+
+	mutex_lock(&msi->lock);
+	bit = find_first_zero_bit(msi->used, msi->num_vectors);
+	if (bit >= msi->num_vectors) {
+		mutex_unlock(&msi->lock);
+		return -ENOSPC;
+	}
+
+	set_bit(bit, msi->used);
+
+	irq_domain_set_info(domain, virq, bit, &plda_msi_bottom_irq_chip,
+			    domain->host_data, handle_edge_irq, NULL, NULL);
+
+	mutex_unlock(&msi->lock);
+
+	return 0;
+}
+
+static void plda_irq_msi_domain_free(struct irq_domain *domain,
+				     unsigned int virq,
+				     unsigned int nr_irqs)
+{
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(d);
+	struct plda_msi *msi = &port->msi;
+
+	mutex_lock(&msi->lock);
+
+	if (test_bit(d->hwirq, msi->used))
+		__clear_bit(d->hwirq, msi->used);
+	else
+		dev_err(port->dev, "trying to free unused MSI%lu\n", d->hwirq);
+
+	mutex_unlock(&msi->lock);
+}
+
+static const struct irq_domain_ops msi_domain_ops = {
+	.alloc	= plda_irq_msi_domain_alloc,
+	.free	= plda_irq_msi_domain_free,
+};
+
+static struct irq_chip plda_msi_irq_chip = {
+	.name = "PLDA PCIe MSI",
+	.irq_ack = irq_chip_ack_parent,
+	.irq_mask = pci_msi_mask_irq,
+	.irq_unmask = pci_msi_unmask_irq,
+};
+
+static struct msi_domain_info plda_msi_domain_info = {
+	.flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		  MSI_FLAG_PCI_MSIX),
+	.chip = &plda_msi_irq_chip,
+};
+
+static int plda_allocate_msi_domains(struct plda_pcie_rp *port)
+{
+	struct device *dev = port->dev;
+	struct fwnode_handle *fwnode = of_node_to_fwnode(dev->of_node);
+	struct plda_msi *msi = &port->msi;
+
+	mutex_init(&port->msi.lock);
+
+	msi->dev_domain = irq_domain_add_linear(NULL, msi->num_vectors,
+						&msi_domain_ops, port);
+	if (!msi->dev_domain) {
+		dev_err(dev, "failed to create IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	msi->msi_domain = pci_msi_create_irq_domain(fwnode,
+						    &plda_msi_domain_info,
+						    msi->dev_domain);
+	if (!msi->msi_domain) {
+		dev_err(dev, "failed to create MSI domain\n");
+		irq_domain_remove(msi->dev_domain);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void plda_handle_intx(struct irq_desc *desc)
+{
+	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct device *dev = port->dev;
+	void __iomem *bridge_base_addr = port->bridge_addr;
+	unsigned long status;
+	u32 bit;
+	int ret;
+
+	chained_irq_enter(chip, desc);
+
+	status = readl_relaxed(bridge_base_addr + ISTATUS_LOCAL);
+	if (status & PM_MSI_INT_INTX_MASK) {
+		status &= PM_MSI_INT_INTX_MASK;
+		status >>= PM_MSI_INT_INTX_SHIFT;
+		for_each_set_bit(bit, &status, PCI_NUM_INTX) {
+			ret = generic_handle_domain_irq(port->intx_domain, bit);
+			if (ret)
+				dev_err_ratelimited(dev, "bad INTx IRQ %d\n",
+						    bit);
+		}
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
+static void plda_ack_intx_irq(struct irq_data *data)
+{
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+	void __iomem *bridge_base_addr = port->bridge_addr;
+	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
+
+	writel_relaxed(mask, bridge_base_addr + ISTATUS_LOCAL);
+}
+
+static void plda_mask_intx_irq(struct irq_data *data)
+{
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+	void __iomem *bridge_base_addr = port->bridge_addr;
+	unsigned long flags;
+	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
+	u32 val;
+
+	raw_spin_lock_irqsave(&port->lock, flags);
+	val = readl_relaxed(bridge_base_addr + IMASK_LOCAL);
+	val &= ~mask;
+	writel_relaxed(val, bridge_base_addr + IMASK_LOCAL);
+	raw_spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static void plda_unmask_intx_irq(struct irq_data *data)
+{
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+	void __iomem *bridge_base_addr = port->bridge_addr;
+	unsigned long flags;
+	u32 mask = BIT(data->hwirq + PM_MSI_INT_INTX_SHIFT);
+	u32 val;
+
+	raw_spin_lock_irqsave(&port->lock, flags);
+	val = readl_relaxed(bridge_base_addr + IMASK_LOCAL);
+	val |= mask;
+	writel_relaxed(val, bridge_base_addr + IMASK_LOCAL);
+	raw_spin_unlock_irqrestore(&port->lock, flags);
+}
+
+static struct irq_chip plda_intx_irq_chip = {
+	.name = "PLDA PCIe INTx",
+	.irq_ack = plda_ack_intx_irq,
+	.irq_mask = plda_mask_intx_irq,
+	.irq_unmask = plda_unmask_intx_irq,
+};
+
+static int plda_pcie_intx_map(struct irq_domain *domain, unsigned int irq,
+			      irq_hw_number_t hwirq)
+{
+	irq_set_chip_and_handler(irq, &plda_intx_irq_chip, handle_level_irq);
+	irq_set_chip_data(irq, domain->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops intx_domain_ops = {
+	.map = plda_pcie_intx_map,
+};
+
+static u32 plda_get_events(struct plda_pcie_rp *port)
+{
+	u32 events, val, origin;
+
+	origin = readl_relaxed(port->bridge_addr + ISTATUS_LOCAL);
+
+	/* MSI event and sys events */
+	val = (origin & SYS_AND_MSI_MASK) >> PM_MSI_INT_MSI_SHIFT;
+	events = val << (PM_MSI_INT_MSI_SHIFT - PCI_NUM_INTX + 1);
+
+	/* INTx events */
+	if (origin & PM_MSI_INT_INTX_MASK)
+		events |= BIT(PM_MSI_INT_INTX_SHIFT);
+
+	/* remains are same with register */
+	events |= origin & GENMASK(P_ATR_EVT_DOORBELL_SHIFT, 0);
+
+	return events;
+}
+
+static irqreturn_t plda_event_handler(int irq, void *dev_id)
+{
+	return IRQ_HANDLED;
+}
+
+static void plda_handle_event(struct irq_desc *desc)
+{
+	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
+	unsigned long events;
+	u32 bit;
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+
+	chained_irq_enter(chip, desc);
+
+	events = port->event_ops->get_events(port);
+
+	for_each_set_bit(bit, &events, port->num_events)
+		generic_handle_domain_irq(port->event_domain, bit);
+
+	chained_irq_exit(chip, desc);
+}
+
+static u32 plda_hwirq_to_mask(int hwirq)
+{
+	u32 mask;
+
+	/* hwirq 23 - 0 are the same with register */
+	if (hwirq < EVENT_PM_MSI_INT_INTX)
+		mask = BIT(hwirq);
+	else if (hwirq == EVENT_PM_MSI_INT_INTX)
+		mask = PM_MSI_INT_INTX_MASK;
+	else
+		mask = BIT(hwirq + PCI_NUM_INTX - 1);
+
+	return mask;
+}
+
+static void plda_ack_event_irq(struct irq_data *data)
+{
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+
+	writel_relaxed(plda_hwirq_to_mask(data->hwirq),
+		       port->bridge_addr + ISTATUS_LOCAL);
+}
+
+static void plda_mask_event_irq(struct irq_data *data)
+{
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+	u32 mask, val;
+
+	mask = plda_hwirq_to_mask(data->hwirq);
+
+	raw_spin_lock(&port->lock);
+	val = readl_relaxed(port->bridge_addr + IMASK_LOCAL);
+	val &= ~mask;
+	writel_relaxed(val, port->bridge_addr + IMASK_LOCAL);
+	raw_spin_unlock(&port->lock);
+}
+
+static void plda_unmask_event_irq(struct irq_data *data)
+{
+	struct plda_pcie_rp *port = irq_data_get_irq_chip_data(data);
+	u32 mask, val;
+
+	mask = plda_hwirq_to_mask(data->hwirq);
+
+	raw_spin_lock(&port->lock);
+	val = readl_relaxed(port->bridge_addr + IMASK_LOCAL);
+	val |= mask;
+	writel_relaxed(val, port->bridge_addr + IMASK_LOCAL);
+	raw_spin_unlock(&port->lock);
+}
+
+static struct irq_chip plda_event_irq_chip = {
+	.name = "PLDA PCIe EVENT",
+	.irq_ack = plda_ack_event_irq,
+	.irq_mask = plda_mask_event_irq,
+	.irq_unmask = plda_unmask_event_irq,
+};
+
+static const struct plda_event_ops plda_event_ops = {
+	.get_events = plda_get_events,
+};
+
+static int plda_pcie_event_map(struct irq_domain *domain, unsigned int irq,
+			       irq_hw_number_t hwirq)
+{
+	struct plda_pcie_rp *port = (void *)domain->host_data;
+
+	irq_set_chip_and_handler(irq, port->event_irq_chip, handle_level_irq);
+	irq_set_chip_data(irq, domain->host_data);
+
+	return 0;
+}
+
+static const struct irq_domain_ops plda_event_domain_ops = {
+	.map = plda_pcie_event_map,
+};
+
+static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
+{
+	struct device *dev = port->dev;
+	struct device_node *node = dev->of_node;
+	struct device_node *pcie_intc_node;
+
+	/* Setup INTx */
+	pcie_intc_node = of_get_next_child(node, NULL);
+	if (!pcie_intc_node) {
+		dev_err(dev, "failed to find PCIe Intc node\n");
+		return -EINVAL;
+	}
+
+	port->event_domain = irq_domain_add_linear(pcie_intc_node,
+						   port->num_events,
+						   &plda_event_domain_ops,
+						   port);
+	if (!port->event_domain) {
+		dev_err(dev, "failed to get event domain\n");
+		of_node_put(pcie_intc_node);
+		return -ENOMEM;
+	}
+
+	irq_domain_update_bus_token(port->event_domain, DOMAIN_BUS_NEXUS);
+
+	port->intx_domain = irq_domain_add_linear(pcie_intc_node, PCI_NUM_INTX,
+						  &intx_domain_ops, port);
+	if (!port->intx_domain) {
+		dev_err(dev, "failed to get an INTx IRQ domain\n");
+		of_node_put(pcie_intc_node);
+		return -ENOMEM;
+	}
+
+	irq_domain_update_bus_token(port->intx_domain, DOMAIN_BUS_WIRED);
+
+	of_node_put(pcie_intc_node);
+	raw_spin_lock_init(&port->lock);
+
+	return plda_allocate_msi_domains(port);
+}
+
+int plda_init_interrupts(struct platform_device *pdev,
+			 struct plda_pcie_rp *port,
+			 const struct plda_event *event)
+{
+	struct device *dev = &pdev->dev;
+	int irq;
+	int i, intx_irq, msi_irq, event_irq;
+	int ret;
+
+	if (!port->event_ops)
+		port->event_ops = &plda_event_ops;
+
+	if (!port->event_irq_chip)
+		port->event_irq_chip = &plda_event_irq_chip;
+
+	ret = plda_pcie_init_irq_domains(port);
+	if (ret) {
+		dev_err(dev, "failed creating IRQ domains\n");
+		return ret;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return -ENODEV;
+
+	for (i = 0; i < port->num_events; i++) {
+		event_irq = irq_create_mapping(port->event_domain, i);
+		if (!event_irq) {
+			dev_err(dev, "failed to map hwirq %d\n", i);
+			return -ENXIO;
+		}
+
+		if (event->request_event_irq)
+			ret = event->request_event_irq(port, event_irq, i);
+		else
+			ret = devm_request_irq(dev, event_irq,
+					       plda_event_handler,
+					       0, NULL, port);
+
+		if (ret) {
+			dev_err(dev, "failed to request IRQ %d\n", event_irq);
+			return ret;
+		}
+	}
+
+	intx_irq = irq_create_mapping(port->event_domain,
+				      event->intx_event);
+	if (!intx_irq) {
+		dev_err(dev, "failed to map INTx interrupt\n");
+		return -ENXIO;
+	}
+
+	/* Plug the INTx chained handler */
+	irq_set_chained_handler_and_data(intx_irq, plda_handle_intx, port);
+
+	msi_irq = irq_create_mapping(port->event_domain,
+				     event->msi_event);
+	if (!msi_irq)
+		return -ENXIO;
+
+	/* Plug the MSI chained handler */
+	irq_set_chained_handler_and_data(msi_irq, plda_handle_msi, port);
+
+	/* Plug the main event chained handler */
+	irq_set_chained_handler_and_data(irq, plda_handle_event, port);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(plda_init_interrupts);
+
 void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 			    phys_addr_t axi_addr, phys_addr_t pci_addr,
 			    size_t size)
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index a3ce01735bea..6672a231a4bc 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -169,6 +169,9 @@ struct plda_event {
 	int msi_event;
 };
 
+int plda_init_interrupts(struct platform_device *pdev,
+			 struct plda_pcie_rp *port,
+			 const struct plda_event *event);
 void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 			    phys_addr_t axi_addr, phys_addr_t pci_addr,
 			    size_t size);
-- 
2.17.1


