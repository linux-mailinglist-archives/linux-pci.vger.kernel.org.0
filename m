Return-Path: <linux-pci+bounces-5330-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5F788FB22
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 10:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99C82292156
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 09:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7EE7F47F;
	Thu, 28 Mar 2024 09:19:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2136.outbound.protection.partner.outlook.cn [139.219.146.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 858A27E574;
	Thu, 28 Mar 2024 09:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711617553; cv=fail; b=L6Gb7fDd+IWoX1kcttXZ8P1gFMLuFelk5WwiZk/INVxSzD9JEYamwKRgRInJMNnbKki5p5VzlBvUNU1S8Lu4coVxvepwPTYVTHMGMfZZ8Eyzo+gxO46uS1v9T0PYqga9/TrrUmZ+UbwGedtfivEbbw+WRsercG/SWXOYVts4zDc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711617553; c=relaxed/simple;
	bh=R7MY5z4KGgMjqpxAq5Ngu87BHLKDh8ynLtvTNJvvN78=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RQXVP0wTd1s1n3tnVSly9wGTj1RqUx6fXHMaw9WkWH1FEPlEbLTvsC9ixbCYK6vk3OxhgbB1fwbDa0iH9l6h3iiTye7cXZVpnWuPvTECs549zle/FEJEq7Z0T7eMr6JWzNlXUv1ju1aYBNRkFmJoqnUHn8mXmwhy1vcY15mL91k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fmtX7bo2Rzod1Dwkbxwn5FPQqjSE3SlZo3ZGHgiuey0MhfM/H3x9jyHRnlrXyr02R9EreakLGOelk8K29XK4mhCuT9CToG/CeeXlXj+t5rCSAIbvPjVi8FulGCJVFWx4MKkSbyv48CoIFX8pN+0JPAR3KPmuKJe0pYyVzM/y/Was8skWI6drnUvL3ePXMz0SWIcySptYoDKwCVbHSHvRCeXORBZ9oYLAAabTZRX5He5Sb28ufaAVK5T6GR7SBgEvEEn8TdxDCsi7j9BDb+O6gTl10nLPRRmCLZljV8Hx++GzRUcIA09mlOimANKtpJAD2mE/H/sNefUupFyd5m3uiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pl/toXvd7sGslxROSN3JTdd8+ySb2QgEK+xIP0knF20=;
 b=mqaMfnnzgigTDwrWu/NWmtUYxk4Yif2O+3Wq1f3jjBOYt+D+6wn67zBhSFiD/yFmm903hnwCM1csmChTbhaK3A09b7yDQayzLwfjOlW48DcrbcunyarbRHFL0wKB2Uct3oJ+p/6EsSuehGNT7vTh+doZ92eyxz95aNlXLmZCV1kTLY7ycqYZFwsDE2O/BzjfK2Fp4SY5FW0rnVo+haG2Oq5NbnqQI20UFJ/bBOi0ZZtfRpa4nUh2j8C5QypB8zmbFXiHyfsL9ZeQOxWoGl0OLk+pdbY6YyVmKPvt44madmu8ylyDGPtG3m2fXqTYi1iSTACnLBkiE1mU5eKTYu1htg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0559.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1d::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 09:19:00 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::c738:9e6b:f92e:8bb9]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::c738:9e6b:f92e:8bb9%6])
 with mapi id 15.20.7409.031; Thu, 28 Mar 2024 09:19:00 +0000
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
Subject: [PATCH v16 16/22] PCI: microchip: Move IRQ functions to pcie-plda-host.c
Date: Thu, 28 Mar 2024 17:18:29 +0800
Message-Id: <20240328091835.14797-17-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 27e02b61-d809-43c8-341b-08dc4f081a4a
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7QNW6rrjhFdxseLpErHSIm0moYerf3Oq6/EimJmtNNI3i/sQ7O0jTcrqErAo7cTnC1ccYF++F7dvOfK7vMIVY3ZUWnzREw2vuB4CcCcWBsVSmPbnhQQwq9Cw0pvSVyGZTqwG+iwPlWme7X5U9IJplT9lkhCxj8IRPbBztygTL8C0LFaMnvgyAPCgGlHhVUC74EBfBOclDgDodz1K2XTCTRT47SCnNcSKfuPzXS+4DN+AOFivz7SuMjnQXD8Sb3THmDBGLqmtqx1CohmmmtIjSe3hjWvGjIlNN/nbgs9+58RfGMecyPzLzZAY4RW+Im8AatwppegL/4Mnl+BFYGzztCAvmhR61+Uxw82uC3dS4GK4QEL03Ou4FxfZw7aOHukxE3YOUcnBKLC8z3LdrrVysJTOyErEOufZYEUIsev8yFos077XFXoDyT7xpVLryfbMRrQLoHluLYsbIUnQj+jUcBuFLMbSPC9BG1eJBE4jo0X6kIwBUsTVNEJx8b3N4na8IXo26CkR2+DQZ8CvaQjtHw4PrgwdshsmhcBJSqfbVVLDh+pH2gBISfnOhe+p+40B0JrPiEVcfYpw6JOdN8S+hU9cBeSEtV7Zez+A9yzFS+LYr8XeVEYCSSZrGmiphu04
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(41320700004)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GI4EYVmPt99SYorvHJkrOxRSPBOnc382Inmx1gYtQ2uwpPlwzOvBKK8WUMI5?=
 =?us-ascii?Q?LP/e9JwQN1UT+EbRZ5/jZkbOu8Zr2lFchy+vlUJ8MgMdaTFCPJOQoepgxgLx?=
 =?us-ascii?Q?SlcMXj5r8XkPBdfRH/kqzYE4CusWBrnvSe4OlSoalStZFBT+N/g6WUf4zoR+?=
 =?us-ascii?Q?lqQIg/DqXVG6vdOtGeDHTTtbBIoH8LONkpnEK0OHcehcPpyIKh2UIoD4WsCc?=
 =?us-ascii?Q?d3rHHhRy288GaCSshS1oIMarjNrS54CgeSNoYAWWnlo6x2zdqqf7ldeXt1X5?=
 =?us-ascii?Q?GIPcbegVApHUh+ysNH9AyhduW1WjOXXY2I0wYvJvowTMFSSikyIRFX8FBwZS?=
 =?us-ascii?Q?OUJlAwY8pt0F+cnUUT/S8KkOsVQVwNurK+8fcQDJOlk7m5MnJGPeZGgjd9VI?=
 =?us-ascii?Q?zO3eilKnuaJl1dNClZzK1s5f7Gg1SoNxVS9dn9CRcGGnm+UferEe7ERmdEnh?=
 =?us-ascii?Q?ELCOefpMM1gEZod0yjpif1SiFyNU6xWJZpvzpOKmYvZccNcWIDBIA8xvU5ue?=
 =?us-ascii?Q?AgvIpyKdYBbLnobw91RNxTkEycvLZ62b+AhKrw8h6vNARCYJ/87YveGrS7+m?=
 =?us-ascii?Q?Otn6WHUb8curfrdFXsOI3In8mZJeLAgjNd3OaQVucwFyM82JT2YWIKOM2uYa?=
 =?us-ascii?Q?zUVUELFgw/IU6MmHYgNKA1VOQ6BeznrLl0uoaO7iQ1M8pHFKP0id57OIvIW8?=
 =?us-ascii?Q?9V/0GXu2Y0sBnVougL3qdgtiRoX9fJlWC4SumeJ40+PDOhazPmFtXpJNDjUg?=
 =?us-ascii?Q?uacRqlJswlNvhOo2rdWaJHrV4w7i0Nx20u+WW2DE4Jvc61lER/cgwmTtecBG?=
 =?us-ascii?Q?b8HBIbw62ghtRmJxkT+0lxcWTJ2xfzHT0ZBSUwcitNroJx/uPodO3YGbQK/8?=
 =?us-ascii?Q?l6R/o8BBR4VLupmYm6dySHQIMfK+WYykU+kGXiqH65oiBOI0gB+f+JJ2af4T?=
 =?us-ascii?Q?JbD0ZLObQR1xCy9TUIgDw6szxvHs8tccwoctK/Oz3dxLagEmfWQHKg1hoo1N?=
 =?us-ascii?Q?xHWtO7Pgak9Yvx+4vF+gNECUzq9XBUseJGANDiUEeJvIGFjaBBzd2qQzeOW/?=
 =?us-ascii?Q?Qz7ngDiqoKPOYl8CVeHdiQn9svZP9VfIg096yaoC5GKNgezW7OMP7F9Ivw+C?=
 =?us-ascii?Q?HVkmi48P4YX38HX9bgz5mA+CxTrSmbQv5LnrDN/lnH9TNMHV4JOKKuKB6Sjw?=
 =?us-ascii?Q?+PrjoWxcwo0KRn0O0fG3T7RwSwVCi/AU96OYwwnYRipmKkkdt2VdwCeM/lbS?=
 =?us-ascii?Q?gHn3+z7UBdLirEZKukvp3DU6+sY0ZNUsWgP0R3ZpljX8o1vZG3h0iJUjnPXG?=
 =?us-ascii?Q?S3W9q9I3ZukyWHkiRovziRTqX+s6T/fH6zYRthYFVd9GGHsJZncBpz9F79hO?=
 =?us-ascii?Q?o2WYbiEorF6Ug6STMZD/6r3sNhqC1qmMAHO6JzEhynQqMQ3ZxfBKnPqE+PcV?=
 =?us-ascii?Q?fC+KpfEeeZfkVfMo0jyH4kK1mFNuLbhEP+IXkZVZHPjW0pabK9mD1+8rYJ2b?=
 =?us-ascii?Q?bsnaxM12gPjv8KLoa2T7OQnGZDk6KrM0JvxICtt9g4zIpypp9sxh/NLoseEh?=
 =?us-ascii?Q?hO5mSAx9M4/EA+1flFB60c2fKP8nKrVizaLhCdYydfETMMaf9haNPa3ULeTH?=
 =?us-ascii?Q?nQ=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e02b61-d809-43c8-341b-08dc4f081a4a
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 09:19:00.0793
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FLB6hZmMQAUUqm5CceQLtu1WqgbecN+hQuWQQx9ZrcInCVQxNR4/grLijhW/YC8ociI2Ny+C/BsFertR3UcdhdYqLbVZlbel8xNiYD8Shso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0559

Move IRQ related functions to common file pcie-plda-host.c

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
index 0e5157eb3a32..eb9e6f304985 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -170,6 +170,9 @@ struct plda_event {
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


