Return-Path: <linux-pci+bounces-4101-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BBAE868DC2
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 11:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68B628ED43
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 10:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F821386AD;
	Tue, 27 Feb 2024 10:37:09 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2118.outbound.protection.partner.outlook.cn [139.219.17.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37DE913A273;
	Tue, 27 Feb 2024 10:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709030229; cv=fail; b=jTmR2N6NAa6yP0HgpzZBMtWNGc45Yv3fwgjIfHnHm2B8E274/SSHEHwqNjXqxUtDM+g9ZoKLGX+MZRxhx7jB+vTTeDavcror6p5FqZijzX/oBmOY8Hgt2uKKMqkrxP2YfkoLsXUfTU5wYW84GW9lpXeSps7opcKtxLjKHJQVWt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709030229; c=relaxed/simple;
	bh=ggawvIbzZ+PVOvsxbzkoIgKBxmy45+7ZS0uM5XtO8PE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GALPShwHPsBgBRj/douX0dmhfUqcpVdfn0OVkzl+iD/OmmQKG5a3obpa8YzZ7HKKywT6kQbieCxItL2+iVfUBOnKvub6z2kUzFKHewUD3hlhpLXihcY5IBhj1oH0AWgiSQqHtfOP4eK5AKprzztym0pgqTFYH9J0+aevAR/a8EA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ChDOrTNouFiGBugsVD7TlfFPzaYayHQ7xYmMGuyGP177AhnCBeAwqKguBK3tdcSdGPcWKAc9anm3HhSTk7a4Q0Cid/GI1bIER++kk2vlwdeUkVKoqVhwQA3NT2nEVt+c7Lq2ogL8Hwoko4scQ+NN9+/7w6WF5NGpiBYAnVGKhNO5u9CsCR1ASdDM0G+5ESbbsPSbBhBAfsLThig7tqj8Nat6mPQ9LCG6pjmDU46VnP4s6f1V1ZsJtBq8UPCtHTiXxXCg0stSXCJlVLAb2Xh81VaUXXZNwtMiB10Vx4yuY1WHIMIsmc5JCYEBY44i2/VlAj5cGBeKOnuQQlKLzWrcKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SUkOg1G/JyezYceJLyKECcz3PCvNZXhK6wSQeUoGtK0=;
 b=hPdpuIOiMCxMXeM615jp8JF3fNHQQBWlutnhgunrC0r5t8cvcCh4X4npfkkGC9lsxyL+O4bbncSybmNDQRhZtMYxBw+Nmefw325vev4uQVXk4E5MFdtmAMMqNbLItoSqY9W7PEin4mxN3k0Or13x4T+dTBVDqhibQmAG83ALbTJ3LPGoJiw24jCEbqUr2T02sVBHw0VeKd6LKw9jlWkupiKsFMtNxxVB0lu3czaEC0IBRoDIwzE5AaFaVHHL35gFkNq3JHQmOF9hy+oQByM3MCuGb87xI72qiIeEwPEIaO+8Ipv/tgwEzXaaEmT4lIBUFYg1kKEiYE59V5/ioqX6Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0496.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.47; Tue, 27 Feb
 2024 10:35:46 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7270.047; Tue, 27 Feb 2024 10:35:46 +0000
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
Subject: [PATCH v15,RESEND 16/23] PCI: microchip: Move IRQ functions to pcie-plda-host.c
Date: Tue, 27 Feb 2024 18:35:15 +0800
Message-Id: <20240227103522.80915-17-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 0b46a00b-3033-4399-15cc-08dc377fdb68
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aI/xxfcrEziGr6QeMa63ZDI7Yczr2MlhB3OtFWg+Hp7nXnLK9RcPGizZi5o9F+uIuxEVunUTg3a4uTzDbixj9FBRjBLq+ebZZmPcnAtfHE77LG80J7ZBdkte0raxHyaV5meC8YJ61nIAIYVFTOkd7ASFvy0nYZ27q0Vn8xGV5gEqUcB9C+Nh8GBORn45ciVC4lKqOb/sbgkpB8JNwueq7y277z06F7hvDASbs3HbvbhxXvSXLU/hATiIOcshYHiPC3BjX/Sx0+MmrtrTz5Avrv0sSlmZPCpVXLoQivuJtsikqVlWWoM/7ebFYqHliFJAecZSns0kHvDSkywv9BGnqz4Dk8fwKWyOVrjLFGrr4LvrE9dje9BzkeEAwcaj66267G4g8GyTodv67xnx54lk2CSbSohp8vO/2RuvgoUxbOgBXEvXl9EtxPinrPL5AwE/oaBK0PQl8zPUdkDaBwIyox35Ja7zRYjVUPVq+0jx7dLjmV8lTqbXepU+Jy0eBx4iSVzydLu+BI+HdK1oQusU1lmsmTwFI/kicBxv+vo1tHwpFe9BsMmCFqDQzxhphYT29t1Qg6BR6aurXLHGoBYrPMSq/1UY3ExJyVF7iV5Hl3t2tS3gqXHHk4GwKrDfcmoi
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e0OaXr/lMqhXr/gBE9v6Ft9IJGL0Mo5wCBY3YxPAmVd/VQGAp0VHJ8sa7AHd?=
 =?us-ascii?Q?HYRlH4o7SM0Rm5mnT8BKLdBFcv+m+1+TTBnEB0FS1uMbNJP1b82SQoU3Q+qu?=
 =?us-ascii?Q?BCjDLWMb07bteB3D0aF7OOyp06PaxLkRbIdpsAgyMvfQhRiX6tcxSKBoL4n8?=
 =?us-ascii?Q?TaPEsA6G79bm0IyFeGIxRaNaaB0DPkIlo6B4WnY1yqvYfcpLFW15+kwyHfwy?=
 =?us-ascii?Q?iBj+tx38b47efxwuxCldBYSoXv4NGCWj9o12cDYI2UenoxM4F4pYwVG4tQY1?=
 =?us-ascii?Q?W75p9LP92HR712QQpVyFNeGZWRo70ovEq5s9jHRO/TffTpWZ8+3+QAIz+ozA?=
 =?us-ascii?Q?B+3oRhxQ5Ysoun1f5IWeOPWVmVGUqkai++zgpJxv7pi31NKIgk262CrPRHKg?=
 =?us-ascii?Q?1yI+XsjPWUDGguGTZDfQ0vLMSPw/DTnzDSMNAvVQdKGQQxs/+8zCNioetXnm?=
 =?us-ascii?Q?emS73TBmiQZkbzHdLcg/hdv931i/34GTWkIn5/FuiGiTznF+iR0fvvkNFbdw?=
 =?us-ascii?Q?v+g69A0zDS2MHf2nGudZ88ZXkHxhSwN6pcL1U/3tJQrUTHTKO67JgfIas4ln?=
 =?us-ascii?Q?QEv3pvvZ9nNIIUBgzksT6xpu3h1dCu+RLITYzVLtbm1xVGXiYPu6/+WHe2Mj?=
 =?us-ascii?Q?dGhs8x5k7SNEoXFIWAr0hIep65He15aQLaAByuN4ZP5IgBoVujeQvhPr0AXU?=
 =?us-ascii?Q?OjKCjGrbj1WeuNrNi3sa0ngWdYpgIr8VLKRTuK6JC26RVXO3VED6Rt0zSggv?=
 =?us-ascii?Q?PQGp8CbCZa32TPrO51D7jm8lUJfbVHLcvu8pbRrF1BrIzWcnGSgc5LdRWN5z?=
 =?us-ascii?Q?JhNF2b/jfhtaigXoGCsvHgewX6RcNWJ+aiusJ0/Hbj6oVF5PZWUnbjsAoPsK?=
 =?us-ascii?Q?bbBo40PI9+ShgL8VYVRG3cJp6U+IVRTndFcRYoUMb/OinUyPDUOJUrLVXSnv?=
 =?us-ascii?Q?Uvge2uSuwOrIr9CIciUcJp5TLIoYmJ1LUdQEAAklE16/QfZCJuNIKF7RT29K?=
 =?us-ascii?Q?fbDsdHiCM9Hp1+UF8eGheSPcEuEI+76DbYPLkSnenp6Xo9Lly0/TaXQtPvz4?=
 =?us-ascii?Q?5NnpMe/PMlWnI4PGMSuSXOrtbQecszxDayxZO6BGwCqD07ss+fpWg4ftpA4w?=
 =?us-ascii?Q?dYBSyKb9kWxwPhpOy570RQFZzwBDA6SjXvCGjtMnBgjstE2W5tQOVGA8eNrM?=
 =?us-ascii?Q?zZTgmZ6xhE6uGmzUrjO6hVYxmE53maLyI1OsLlCwaKHcvtaOzQzsRXdtIArn?=
 =?us-ascii?Q?wN4qn8CUuNlEqidz+Sfh0Mr7IcfSAXQ+Z53wpLE+HUBnx/UGp3JsEuKvrXGA?=
 =?us-ascii?Q?u//dmObfb4/us3HDT2nTp6Ub+p1SGMwHLLsc9N+Pc2ataz/07/dbURGhAwH+?=
 =?us-ascii?Q?9MxJEQJ01L6Let5gDb6RJOOAvt873QbAsQLB1/4TblN9Ptbal1rXSyzdXM6y?=
 =?us-ascii?Q?jATbgShSOmGaRTHXu65PyzcLfHQ1lQ+6LDTE94FqpnfmFJnq0o9Bn723M5Wt?=
 =?us-ascii?Q?/SahLk21C0YZmGUvWuwXFZ6dhrXtN9xrLqUmTk+Y4YYsFapK6Fl3irt4vfxr?=
 =?us-ascii?Q?dj52DpsdOU/u8ZgEwTv8+zmSHl9KLqOxFXbpQnjubmmq/7J+Kq8cKLj4uyHn?=
 =?us-ascii?Q?nA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b46a00b-3033-4399-15cc-08dc377fdb68
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 10:35:46.3125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VSbAA3WQ0ZsDY0KrJfT1cO3avxDHS37mGDSonxYK5I2oItxPsH0p9vfqV3o5WqEukRV4TFrlknCVqvdBsYTpC/DCe5mG0W8ysgGw5LC5crw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0496

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


