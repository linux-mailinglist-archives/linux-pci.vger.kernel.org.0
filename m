Return-Path: <linux-pci+bounces-10300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3829F931A20
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 20:15:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5827A1C20319
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 18:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27ED782D98;
	Mon, 15 Jul 2024 18:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ih8OWQsk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27526BFA6;
	Mon, 15 Jul 2024 18:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721067296; cv=none; b=h4yN8F8BT1YoFxFody79ya0xh132CpdNS2Btyt+zzroNLQQUHsLj2FzKeTQzVKR/VSLS576X6LH8deGkqP6xuDpTkuEmtNZWNLoA/VAssa7wHdF/194+hNkYU1YKS/aIjuQK0VmxanojIDiTya5JZ5jMSw2jNW54+hKkVRBhToc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721067296; c=relaxed/simple;
	bh=eukdmm2ARZSzGfpl7TWM/KvMFFl0gfAb67WYEUP3Nok=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pTbjCbjuOxXCdVzWtfwBxYL7Y1pGVejuz/rCe/BPVbFPwsiJpNRveJxl9DZRV5ojYVBPdr28cRowENWAMhE88NEjeXK1laaACCpLNrtfmf/dJ7A2OVugBrT9ridXfunD7zjGa4nwodDZgfUcAqfIpZYMyweA/DZJQXZC48tAk4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ih8OWQsk; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FH8huT004035;
	Mon, 15 Jul 2024 18:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=XjvE6+jp3bswpcSq3W90XcPf
	2y+syK5804kEk52YpvQ=; b=ih8OWQskGjK2fGObuggBNGl+MyZO3tGLi/vWSMzB
	+6To1xKfgmIR76gl7Wgmz5/agMOfoI+UFIZDD33KpCf2xNBkNjd4M9rtO0HgYhxV
	8h98MEt7EpGtXrElaagQbux9Xw4HTxS80uDrWgZ53Zr+Bl79j8Q3ijuLEpvdbll0
	XRBVlH5IhfFZtR5mrzByQzNmXIod5KqhjS/sLOgp5HX2oitnyd+6zbJR6tYBFt5z
	CYLzjjz9OU0zibM7oXEsDAzsViojOfwm+DqOKeJO5G7iMZm4Ha/KV4HMkNvGiRRb
	28m13b82BwV1ajz06hCYJsjqX6+K6Q7GY/QkZgKpIJGwHg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bghrn1u3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 18:13:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46FIDqGq026337
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 18:13:52 GMT
Received: from hu-mrana-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 15 Jul 2024 11:13:51 -0700
From: Mayank Rana <quic_mrana@quicinc.com>
To: <will@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <manivannan.sadhasivam@linaro.org>, <cassel@kernel.org>,
        <yoshihiro.shimoda.uh@renesas.com>, <s-vadapalli@ti.com>,
        <u.kleine-koenig@pengutronix.de>, <dlemoal@kernel.org>,
        <amishin@t-argos.ru>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <Frank.Li@nxp.com>,
        <ilpo.jarvinen@linux.intel.com>, <vidyas@nvidia.com>,
        <marek.vasut+renesas@gmail.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <quic_ramkri@quicinc.com>, <quic_nkela@quicinc.com>,
        <quic_shazhuss@quicinc.com>, <quic_msarkar@quicinc.com>,
        <quic_nitegupt@quicinc.com>, Mayank Rana <quic_mrana@quicinc.com>
Subject: [PATCH V2 1/7] PCI: dwc: Move MSI functionality related code to separate file
Date: Mon, 15 Jul 2024 11:13:29 -0700
Message-ID: <1721067215-5832-2-git-send-email-quic_mrana@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
References: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jIXMk_IjjS4TtoMbvy1nkdrrN0zCZJTp
X-Proofpoint-ORIG-GUID: jIXMk_IjjS4TtoMbvy1nkdrrN0zCZJTp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_12,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 clxscore=1015 malwarescore=0 spamscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407150142

This change moves dwc PCIe controller specific MSI functionality
into separate file in preparation to allow MSI functionality with
PCIe ECAM driver. Update existing drivers to accommodate this change.

Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
---
 drivers/pci/controller/dwc/Makefile               |   2 +-
 drivers/pci/controller/dwc/pci-keystone.c         |  12 +-
 drivers/pci/controller/dwc/pcie-designware-host.c | 420 +---------------------
 drivers/pci/controller/dwc/pcie-designware-msi.c  | 409 +++++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware-msi.h  |  43 +++
 drivers/pci/controller/dwc/pcie-designware.c      |   1 +
 drivers/pci/controller/dwc/pcie-designware.h      |  26 +-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c       |   1 +
 drivers/pci/controller/dwc/pcie-tegra194.c        |   5 +-
 9 files changed, 484 insertions(+), 435 deletions(-)
 create mode 100644 drivers/pci/controller/dwc/pcie-designware-msi.c
 create mode 100644 drivers/pci/controller/dwc/pcie-designware-msi.h

diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index bac103f..2ecc603 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PCIE_DW) += pcie-designware.o
-obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
+obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o pcie-designware-msi.o
 obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
 obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
 obj-$(CONFIG_PCIE_BT1) += pcie-bt1.o
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index cd0e002..b95d319 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -307,8 +307,14 @@ static int ks_pcie_msi_host_init(struct dw_pcie_rp *pp)
 	 */
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, ks_pcie->app.start);
 
-	pp->msi_irq_chip = &ks_pcie_msi_irq_chip;
-	return dw_pcie_allocate_domains(pp);
+	pp->msi = devm_kzalloc(pci->dev, sizeof(struct dw_msi *), GFP_KERNEL);
+	if (pp->msi == NULL)
+		return -ENOMEM;
+
+	pp->msi->msi_irq_chip = &ks_pcie_msi_irq_chip;
+	pp->msi->dev =  pci->dev;
+	pp->msi->private_data = pp;
+	return dw_pcie_allocate_domains(pp->msi);
 }
 
 static void ks_pcie_handle_intx_irq(struct keystone_pcie *ks_pcie,
@@ -322,7 +328,7 @@ static void ks_pcie_handle_intx_irq(struct keystone_pcie *ks_pcie,
 
 	if (BIT(0) & pending) {
 		dev_dbg(dev, ": irq: irq_offset %d", offset);
-		generic_handle_domain_irq(ks_pcie->intx_irq_domain, offset);
+		generic_handle_domain_irq(ks_pcie->msi->intx_irq_domain, offset);
 	}
 
 	/* EOI the INTx interrupt */
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index a0822d5..3dcf88a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -9,9 +9,6 @@
  */
 
 #include <linux/iopoll.h>
-#include <linux/irqchip/chained_irq.h>
-#include <linux/irqdomain.h>
-#include <linux/msi.h>
 #include <linux/of_address.h>
 #include <linux/of_pci.h>
 #include <linux/pci_regs.h>
@@ -19,385 +16,11 @@
 
 #include "../../pci.h"
 #include "pcie-designware.h"
+#include "pcie-designware-msi.h"
 
 static struct pci_ops dw_pcie_ops;
 static struct pci_ops dw_child_pcie_ops;
 
-static void dw_msi_ack_irq(struct irq_data *d)
-{
-	irq_chip_ack_parent(d);
-}
-
-static void dw_msi_mask_irq(struct irq_data *d)
-{
-	pci_msi_mask_irq(d);
-	irq_chip_mask_parent(d);
-}
-
-static void dw_msi_unmask_irq(struct irq_data *d)
-{
-	pci_msi_unmask_irq(d);
-	irq_chip_unmask_parent(d);
-}
-
-static struct irq_chip dw_pcie_msi_irq_chip = {
-	.name = "PCI-MSI",
-	.irq_ack = dw_msi_ack_irq,
-	.irq_mask = dw_msi_mask_irq,
-	.irq_unmask = dw_msi_unmask_irq,
-};
-
-static struct msi_domain_info dw_pcie_msi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
-	.chip	= &dw_pcie_msi_irq_chip,
-};
-
-/* MSI int handler */
-irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp)
-{
-	int i, pos;
-	unsigned long val;
-	u32 status, num_ctrls;
-	irqreturn_t ret = IRQ_NONE;
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-
-	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
-
-	for (i = 0; i < num_ctrls; i++) {
-		status = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS +
-					   (i * MSI_REG_CTRL_BLOCK_SIZE));
-		if (!status)
-			continue;
-
-		ret = IRQ_HANDLED;
-		val = status;
-		pos = 0;
-		while ((pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL,
-					    pos)) != MAX_MSI_IRQS_PER_CTRL) {
-			generic_handle_domain_irq(pp->irq_domain,
-						  (i * MAX_MSI_IRQS_PER_CTRL) +
-						  pos);
-			pos++;
-		}
-	}
-
-	return ret;
-}
-
-/* Chained MSI interrupt service routine */
-static void dw_chained_msi_isr(struct irq_desc *desc)
-{
-	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct dw_pcie_rp *pp;
-
-	chained_irq_enter(chip, desc);
-
-	pp = irq_desc_get_handler_data(desc);
-	dw_handle_msi_irq(pp);
-
-	chained_irq_exit(chip, desc);
-}
-
-static void dw_pci_setup_msi_msg(struct irq_data *d, struct msi_msg *msg)
-{
-	struct dw_pcie_rp *pp = irq_data_get_irq_chip_data(d);
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	u64 msi_target;
-
-	msi_target = (u64)pp->msi_data;
-
-	msg->address_lo = lower_32_bits(msi_target);
-	msg->address_hi = upper_32_bits(msi_target);
-
-	msg->data = d->hwirq;
-
-	dev_dbg(pci->dev, "msi#%d address_hi %#x address_lo %#x\n",
-		(int)d->hwirq, msg->address_hi, msg->address_lo);
-}
-
-static int dw_pci_msi_set_affinity(struct irq_data *d,
-				   const struct cpumask *mask, bool force)
-{
-	return -EINVAL;
-}
-
-static void dw_pci_bottom_mask(struct irq_data *d)
-{
-	struct dw_pcie_rp *pp = irq_data_get_irq_chip_data(d);
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	unsigned int res, bit, ctrl;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&pp->lock, flags);
-
-	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
-	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
-	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
-
-	pp->irq_mask[ctrl] |= BIT(bit);
-	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK + res, pp->irq_mask[ctrl]);
-
-	raw_spin_unlock_irqrestore(&pp->lock, flags);
-}
-
-static void dw_pci_bottom_unmask(struct irq_data *d)
-{
-	struct dw_pcie_rp *pp = irq_data_get_irq_chip_data(d);
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	unsigned int res, bit, ctrl;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&pp->lock, flags);
-
-	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
-	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
-	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
-
-	pp->irq_mask[ctrl] &= ~BIT(bit);
-	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK + res, pp->irq_mask[ctrl]);
-
-	raw_spin_unlock_irqrestore(&pp->lock, flags);
-}
-
-static void dw_pci_bottom_ack(struct irq_data *d)
-{
-	struct dw_pcie_rp *pp  = irq_data_get_irq_chip_data(d);
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	unsigned int res, bit, ctrl;
-
-	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
-	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
-	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
-
-	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_STATUS + res, BIT(bit));
-}
-
-static struct irq_chip dw_pci_msi_bottom_irq_chip = {
-	.name = "DWPCI-MSI",
-	.irq_ack = dw_pci_bottom_ack,
-	.irq_compose_msi_msg = dw_pci_setup_msi_msg,
-	.irq_set_affinity = dw_pci_msi_set_affinity,
-	.irq_mask = dw_pci_bottom_mask,
-	.irq_unmask = dw_pci_bottom_unmask,
-};
-
-static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
-				    unsigned int virq, unsigned int nr_irqs,
-				    void *args)
-{
-	struct dw_pcie_rp *pp = domain->host_data;
-	unsigned long flags;
-	u32 i;
-	int bit;
-
-	raw_spin_lock_irqsave(&pp->lock, flags);
-
-	bit = bitmap_find_free_region(pp->msi_irq_in_use, pp->num_vectors,
-				      order_base_2(nr_irqs));
-
-	raw_spin_unlock_irqrestore(&pp->lock, flags);
-
-	if (bit < 0)
-		return -ENOSPC;
-
-	for (i = 0; i < nr_irqs; i++)
-		irq_domain_set_info(domain, virq + i, bit + i,
-				    pp->msi_irq_chip,
-				    pp, handle_edge_irq,
-				    NULL, NULL);
-
-	return 0;
-}
-
-static void dw_pcie_irq_domain_free(struct irq_domain *domain,
-				    unsigned int virq, unsigned int nr_irqs)
-{
-	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
-	struct dw_pcie_rp *pp = domain->host_data;
-	unsigned long flags;
-
-	raw_spin_lock_irqsave(&pp->lock, flags);
-
-	bitmap_release_region(pp->msi_irq_in_use, d->hwirq,
-			      order_base_2(nr_irqs));
-
-	raw_spin_unlock_irqrestore(&pp->lock, flags);
-}
-
-static const struct irq_domain_ops dw_pcie_msi_domain_ops = {
-	.alloc	= dw_pcie_irq_domain_alloc,
-	.free	= dw_pcie_irq_domain_free,
-};
-
-int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct fwnode_handle *fwnode = of_node_to_fwnode(pci->dev->of_node);
-
-	pp->irq_domain = irq_domain_create_linear(fwnode, pp->num_vectors,
-					       &dw_pcie_msi_domain_ops, pp);
-	if (!pp->irq_domain) {
-		dev_err(pci->dev, "Failed to create IRQ domain\n");
-		return -ENOMEM;
-	}
-
-	irq_domain_update_bus_token(pp->irq_domain, DOMAIN_BUS_NEXUS);
-
-	pp->msi_domain = pci_msi_create_irq_domain(fwnode,
-						   &dw_pcie_msi_domain_info,
-						   pp->irq_domain);
-	if (!pp->msi_domain) {
-		dev_err(pci->dev, "Failed to create MSI domain\n");
-		irq_domain_remove(pp->irq_domain);
-		return -ENOMEM;
-	}
-
-	return 0;
-}
-
-static void dw_pcie_free_msi(struct dw_pcie_rp *pp)
-{
-	u32 ctrl;
-
-	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++) {
-		if (pp->msi_irq[ctrl] > 0)
-			irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
-							 NULL, NULL);
-	}
-
-	irq_domain_remove(pp->msi_domain);
-	irq_domain_remove(pp->irq_domain);
-}
-
-static void dw_pcie_msi_init(struct dw_pcie_rp *pp)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	u64 msi_target = (u64)pp->msi_data;
-
-	if (!pci_msi_enabled() || !pp->has_msi_ctrl)
-		return;
-
-	/* Program the msi_data */
-	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_LO, lower_32_bits(msi_target));
-	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_HI, upper_32_bits(msi_target));
-}
-
-static int dw_pcie_parse_split_msi_irq(struct dw_pcie_rp *pp)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct device *dev = pci->dev;
-	struct platform_device *pdev = to_platform_device(dev);
-	u32 ctrl, max_vectors;
-	int irq;
-
-	/* Parse any "msiX" IRQs described in the devicetree */
-	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++) {
-		char msi_name[] = "msiX";
-
-		msi_name[3] = '0' + ctrl;
-		irq = platform_get_irq_byname_optional(pdev, msi_name);
-		if (irq == -ENXIO)
-			break;
-		if (irq < 0)
-			return dev_err_probe(dev, irq,
-					     "Failed to parse MSI IRQ '%s'\n",
-					     msi_name);
-
-		pp->msi_irq[ctrl] = irq;
-	}
-
-	/* If no "msiX" IRQs, caller should fallback to "msi" IRQ */
-	if (ctrl == 0)
-		return -ENXIO;
-
-	max_vectors = ctrl * MAX_MSI_IRQS_PER_CTRL;
-	if (pp->num_vectors > max_vectors) {
-		dev_warn(dev, "Exceeding number of MSI vectors, limiting to %u\n",
-			 max_vectors);
-		pp->num_vectors = max_vectors;
-	}
-	if (!pp->num_vectors)
-		pp->num_vectors = max_vectors;
-
-	return 0;
-}
-
-static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
-{
-	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	struct device *dev = pci->dev;
-	struct platform_device *pdev = to_platform_device(dev);
-	u64 *msi_vaddr = NULL;
-	int ret;
-	u32 ctrl, num_ctrls;
-
-	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
-		pp->irq_mask[ctrl] = ~0;
-
-	if (!pp->msi_irq[0]) {
-		ret = dw_pcie_parse_split_msi_irq(pp);
-		if (ret < 0 && ret != -ENXIO)
-			return ret;
-	}
-
-	if (!pp->num_vectors)
-		pp->num_vectors = MSI_DEF_NUM_VECTORS;
-	num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
-
-	if (!pp->msi_irq[0]) {
-		pp->msi_irq[0] = platform_get_irq_byname_optional(pdev, "msi");
-		if (pp->msi_irq[0] < 0) {
-			pp->msi_irq[0] = platform_get_irq(pdev, 0);
-			if (pp->msi_irq[0] < 0)
-				return pp->msi_irq[0];
-		}
-	}
-
-	dev_dbg(dev, "Using %d MSI vectors\n", pp->num_vectors);
-
-	pp->msi_irq_chip = &dw_pci_msi_bottom_irq_chip;
-
-	ret = dw_pcie_allocate_domains(pp);
-	if (ret)
-		return ret;
-
-	for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
-		if (pp->msi_irq[ctrl] > 0)
-			irq_set_chained_handler_and_data(pp->msi_irq[ctrl],
-						    dw_chained_msi_isr, pp);
-	}
-
-	/*
-	 * Even though the iMSI-RX Module supports 64-bit addresses some
-	 * peripheral PCIe devices may lack 64-bit message support. In
-	 * order not to miss MSI TLPs from those devices the MSI target
-	 * address has to be within the lowest 4GB.
-	 *
-	 * Note until there is a better alternative found the reservation is
-	 * done by allocating from the artificially limited DMA-coherent
-	 * memory.
-	 */
-	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
-	if (!ret)
-		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
-						GFP_KERNEL);
-
-	if (!msi_vaddr) {
-		dev_warn(dev, "Failed to allocate 32-bit MSI address\n");
-		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
-		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
-						GFP_KERNEL);
-		if (!msi_vaddr) {
-			dev_err(dev, "Failed to allocate MSI address\n");
-			dw_pcie_free_msi(pp);
-			return -ENOMEM;
-		}
-	}
-
-	return 0;
-}
-
 static void dw_pcie_host_request_msg_tlp_res(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -433,6 +56,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	struct resource_entry *win;
 	struct pci_host_bridge *bridge;
 	struct resource *res;
+	bool has_msi_ctrl;
 	int ret;
 
 	raw_spin_lock_init(&pp->lock);
@@ -479,15 +103,15 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	}
 
 	if (pci_msi_enabled()) {
-		pp->has_msi_ctrl = !(pp->ops->msi_init ||
-				     of_property_read_bool(np, "msi-parent") ||
-				     of_property_read_bool(np, "msi-map"));
+		has_msi_ctrl = !(pp->ops->msi_init ||
+					of_property_read_bool(np, "msi-parent") ||
+					of_property_read_bool(np, "msi-map"));
 
 		/*
 		 * For the has_msi_ctrl case the default assignment is handled
 		 * in the dw_pcie_msi_host_init().
 		 */
-		if (!pp->has_msi_ctrl && !pp->num_vectors) {
+		if (!has_msi_ctrl && !pp->num_vectors) {
 			pp->num_vectors = MSI_DEF_NUM_VECTORS;
 		} else if (pp->num_vectors > MAX_MSI_IRQS) {
 			dev_err(dev, "Invalid number of vectors\n");
@@ -499,10 +123,12 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 			ret = pp->ops->msi_init(pp);
 			if (ret < 0)
 				goto err_deinit_host;
-		} else if (pp->has_msi_ctrl) {
-			ret = dw_pcie_msi_host_init(pp);
-			if (ret < 0)
+		} else if (has_msi_ctrl) {
+			pp->msi = dw_pcie_msi_host_init(pdev, pp, pp->num_vectors);
+			if (IS_ERR(pp->msi)) {
+				ret = PTR_ERR(pp->msi);
 				goto err_deinit_host;
+			}
 		}
 	}
 
@@ -557,8 +183,7 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	dw_pcie_edma_remove(pci);
 
 err_free_msi:
-	if (pp->has_msi_ctrl)
-		dw_pcie_free_msi(pp);
+	dw_pcie_free_msi(pp->msi);
 
 err_deinit_host:
 	if (pp->ops->deinit)
@@ -579,8 +204,7 @@ void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
 
 	dw_pcie_edma_remove(pci);
 
-	if (pp->has_msi_ctrl)
-		dw_pcie_free_msi(pp);
+	dw_pcie_free_msi(pp->msi);
 
 	if (pp->ops->deinit)
 		pp->ops->deinit(pp);
@@ -808,7 +432,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
-	u32 val, ctrl, num_ctrls;
+	u32 val;
 	int ret;
 
 	/*
@@ -819,21 +443,7 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 
 	dw_pcie_setup(pci);
 
-	if (pp->has_msi_ctrl) {
-		num_ctrls = pp->num_vectors / MAX_MSI_IRQS_PER_CTRL;
-
-		/* Initialize IRQ Status array */
-		for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
-			dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK +
-					    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
-					    pp->irq_mask[ctrl]);
-			dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_ENABLE +
-					    (ctrl * MSI_REG_CTRL_BLOCK_SIZE),
-					    ~0);
-		}
-	}
-
-	dw_pcie_msi_init(pp);
+	dw_pcie_msi_init(pp->msi);
 
 	/* Setup RC BARs */
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0x00000004);
diff --git a/drivers/pci/controller/dwc/pcie-designware-msi.c b/drivers/pci/controller/dwc/pcie-designware-msi.c
new file mode 100644
index 0000000..39fe5be
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-designware-msi.c
@@ -0,0 +1,409 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2013 Samsung Electronics Co., Ltd.
+ *		https://www.samsung.com
+ *
+ * Author: Jingoo Han <jg1.han@samsung.com>
+ */
+
+#include <linux/irqchip/chained_irq.h>
+#include <linux/irqdomain.h>
+#include <linux/msi.h>
+#include <linux/platform_device.h>
+
+#include "pcie-designware.h"
+#include "pcie-designware-msi.h"
+
+static void dw_msi_ack_irq(struct irq_data *d)
+{
+	irq_chip_ack_parent(d);
+}
+
+static void dw_msi_mask_irq(struct irq_data *d)
+{
+	pci_msi_mask_irq(d);
+	irq_chip_mask_parent(d);
+}
+
+static void dw_msi_unmask_irq(struct irq_data *d)
+{
+	pci_msi_unmask_irq(d);
+	irq_chip_unmask_parent(d);
+}
+
+static struct irq_chip dw_pcie_msi_irq_chip = {
+	.name = "PCI-MSI",
+	.irq_ack = dw_msi_ack_irq,
+	.irq_mask = dw_msi_mask_irq,
+	.irq_unmask = dw_msi_unmask_irq,
+};
+
+static struct msi_domain_info dw_pcie_msi_domain_info = {
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
+		   MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI),
+	.chip	= &dw_pcie_msi_irq_chip,
+};
+
+/* MSI int handler */
+irqreturn_t dw_handle_msi_irq(struct dw_msi *msi)
+{
+	int i, pos;
+	unsigned long val;
+	u32 status, num_ctrls;
+	irqreturn_t ret = IRQ_NONE;
+	struct dw_pcie *pci = to_dw_pcie_from_pp(msi->pp);
+
+	num_ctrls = msi->num_vectors / MAX_MSI_IRQS_PER_CTRL;
+
+	for (i = 0; i < num_ctrls; i++) {
+		status = dw_pcie_readl_dbi(pci, PCIE_MSI_INTR0_STATUS +
+					   (i * MSI_REG_CTRL_BLOCK_SIZE));
+		if (!status)
+			continue;
+
+		ret = IRQ_HANDLED;
+		val = status;
+		pos = 0;
+		while ((pos = find_next_bit(&val, MAX_MSI_IRQS_PER_CTRL,
+					    pos)) != MAX_MSI_IRQS_PER_CTRL) {
+			generic_handle_domain_irq(msi->irq_domain,
+						  (i * MAX_MSI_IRQS_PER_CTRL) +
+						  pos);
+			pos++;
+		}
+	}
+
+	return ret;
+}
+
+/* Chained MSI interrupt service routine */
+static void dw_chained_msi_isr(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct dw_msi *msi;
+
+	chained_irq_enter(chip, desc);
+
+	msi = irq_desc_get_handler_data(desc);
+	dw_handle_msi_irq(msi);
+
+	chained_irq_exit(chip, desc);
+}
+
+static void dw_pci_setup_msi_msg(struct irq_data *d, struct msi_msg *msg)
+{
+	struct dw_msi *msi = irq_data_get_irq_chip_data(d);
+	u64 msi_target;
+
+	msi_target = (u64)msi->msi_data;
+
+	msg->address_lo = lower_32_bits(msi_target);
+	msg->address_hi = upper_32_bits(msi_target);
+
+	msg->data = d->hwirq;
+
+	dev_dbg(msi->dev, "msi#%d address_hi %#x address_lo %#x\n",
+		(int)d->hwirq, msg->address_hi, msg->address_lo);
+}
+
+static int dw_pci_msi_set_affinity(struct irq_data *d,
+				   const struct cpumask *mask, bool force)
+{
+	return -EINVAL;
+}
+
+static void dw_pci_bottom_mask(struct irq_data *d)
+{
+	struct dw_msi *msi = irq_data_get_irq_chip_data(d);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(msi->pp);
+	unsigned int res, bit, ctrl;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&msi->lock, flags);
+
+	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
+	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
+	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
+
+	msi->irq_mask[ctrl] |= BIT(bit);
+	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK + res, msi->irq_mask[ctrl]);
+
+	raw_spin_unlock_irqrestore(&msi->lock, flags);
+}
+
+static void dw_pci_bottom_unmask(struct irq_data *d)
+{
+	struct dw_msi *msi = irq_data_get_irq_chip_data(d);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(msi->pp);
+	unsigned int res, bit, ctrl;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&msi->lock, flags);
+
+	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
+	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
+	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
+
+	msi->irq_mask[ctrl] &= ~BIT(bit);
+	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK + res, msi->irq_mask[ctrl]);
+
+	raw_spin_unlock_irqrestore(&msi->lock, flags);
+}
+
+static void dw_pci_bottom_ack(struct irq_data *d)
+{
+	struct dw_msi *msi  = irq_data_get_irq_chip_data(d);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(msi->pp);
+	unsigned int res, bit, ctrl;
+
+	ctrl = d->hwirq / MAX_MSI_IRQS_PER_CTRL;
+	res = ctrl * MSI_REG_CTRL_BLOCK_SIZE;
+	bit = d->hwirq % MAX_MSI_IRQS_PER_CTRL;
+
+	dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_STATUS + res, BIT(bit));
+}
+
+static struct irq_chip dw_pci_msi_bottom_irq_chip = {
+	.name = "DWPCI-MSI",
+	.irq_ack = dw_pci_bottom_ack,
+	.irq_compose_msi_msg = dw_pci_setup_msi_msg,
+	.irq_set_affinity = dw_pci_msi_set_affinity,
+	.irq_mask = dw_pci_bottom_mask,
+	.irq_unmask = dw_pci_bottom_unmask,
+};
+
+static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
+				    unsigned int virq, unsigned int nr_irqs,
+				    void *args)
+{
+	struct dw_msi *msi = domain->host_data;
+	unsigned long flags;
+	u32 i;
+	int bit;
+
+	raw_spin_lock_irqsave(&msi->lock, flags);
+
+	bit = bitmap_find_free_region(msi->msi_irq_in_use, msi->num_vectors,
+				      order_base_2(nr_irqs));
+
+	raw_spin_unlock_irqrestore(&msi->lock, flags);
+
+	if (bit < 0)
+		return -ENOSPC;
+
+	for (i = 0; i < nr_irqs; i++)
+		irq_domain_set_info(domain, virq + i, bit + i,
+				    msi->msi_irq_chip,
+				    msi, handle_edge_irq,
+				    NULL, NULL);
+
+	return 0;
+}
+
+static void dw_pcie_irq_domain_free(struct irq_domain *domain,
+				    unsigned int virq, unsigned int nr_irqs)
+{
+	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
+	struct dw_msi *msi = domain->host_data;
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&msi->lock, flags);
+
+	bitmap_release_region(msi->msi_irq_in_use, d->hwirq,
+			      order_base_2(nr_irqs));
+
+	raw_spin_unlock_irqrestore(&msi->lock, flags);
+}
+
+static const struct irq_domain_ops dw_pcie_msi_domain_ops = {
+	.alloc	= dw_pcie_irq_domain_alloc,
+	.free	= dw_pcie_irq_domain_free,
+};
+
+int dw_pcie_allocate_domains(struct dw_msi *msi)
+{
+	struct fwnode_handle *fwnode = of_node_to_fwnode(msi->dev->of_node);
+
+	msi->irq_domain = irq_domain_create_linear(fwnode, msi->num_vectors,
+				&dw_pcie_msi_domain_ops,
+				msi->private_data ? msi->private_data : msi);
+	if (!msi->irq_domain) {
+		dev_err(msi->dev, "Failed to create IRQ domain\n");
+		return -ENOMEM;
+	}
+
+	irq_domain_update_bus_token(msi->irq_domain, DOMAIN_BUS_NEXUS);
+
+	msi->msi_domain = pci_msi_create_irq_domain(fwnode,
+						   &dw_pcie_msi_domain_info,
+						   msi->irq_domain);
+	if (!msi->msi_domain) {
+		dev_err(msi->dev, "Failed to create MSI domain\n");
+		irq_domain_remove(msi->irq_domain);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void dw_pcie_free_msi(struct dw_msi *msi)
+{
+	u32 ctrl;
+
+	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++) {
+		if (msi->msi_irq[ctrl] > 0)
+			irq_set_chained_handler_and_data(msi->msi_irq[ctrl],
+							 NULL, NULL);
+	}
+
+	irq_domain_remove(msi->msi_domain);
+	irq_domain_remove(msi->irq_domain);
+}
+
+void dw_pcie_msi_init(struct dw_msi *msi)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(msi->pp);
+	u32 ctrl, num_ctrls;
+	u64 msi_target;
+
+	if (!pci_msi_enabled() || !msi->has_msi_ctrl)
+		return;
+
+	msi_target = (u64)msi->msi_data;
+	num_ctrls = msi->num_vectors / MAX_MSI_IRQS_PER_CTRL;
+	/* Initialize IRQ Status array */
+	for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
+		dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_MASK +
+				(ctrl * MSI_REG_CTRL_BLOCK_SIZE),
+				msi->irq_mask[ctrl]);
+		dw_pcie_writel_dbi(pci, PCIE_MSI_INTR0_ENABLE +
+				(ctrl * MSI_REG_CTRL_BLOCK_SIZE), ~0);
+	}
+
+	/* Program the msi_data */
+	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_LO, lower_32_bits(msi_target));
+	dw_pcie_writel_dbi(pci, PCIE_MSI_ADDR_HI, upper_32_bits(msi_target));
+}
+
+static int dw_pcie_parse_split_msi_irq(struct dw_msi *msi, struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	u32 ctrl, max_vectors;
+	int irq;
+
+	/* Parse any "msiX" IRQs described in the devicetree */
+	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++) {
+		char msi_name[] = "msiX";
+
+		msi_name[3] = '0' + ctrl;
+		irq = platform_get_irq_byname_optional(pdev, msi_name);
+		if (irq == -ENXIO)
+			break;
+		if (irq < 0)
+			return dev_err_probe(dev, irq,
+					     "Failed to parse MSI IRQ '%s'\n",
+					     msi_name);
+
+		msi->msi_irq[ctrl] = irq;
+	}
+
+	/* If no "msiX" IRQs, caller should fallback to "msi" IRQ */
+	if (ctrl == 0)
+		return -ENXIO;
+
+	max_vectors = ctrl * MAX_MSI_IRQS_PER_CTRL;
+	if (msi->num_vectors > max_vectors) {
+		dev_warn(dev, "Exceeding number of MSI vectors, limiting to %u\n",
+			 max_vectors);
+		msi->num_vectors = max_vectors;
+	}
+	if (!msi->num_vectors)
+		msi->num_vectors = max_vectors;
+
+	return 0;
+}
+
+struct dw_msi *dw_pcie_msi_host_init(struct platform_device *pdev,
+				void *pp, u32 num_vectors)
+{
+	struct device *dev = &pdev->dev;
+	u64 *msi_vaddr = NULL;
+	u32 ctrl, num_ctrls;
+	struct dw_msi *msi;
+	int ret;
+
+	msi = devm_kzalloc(dev, sizeof(*msi), GFP_KERNEL);
+	if (msi == NULL)
+		return ERR_PTR(-ENOMEM);
+
+	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
+		msi->irq_mask[ctrl] = ~0;
+
+	raw_spin_lock_init(&msi->lock);
+	msi->dev = dev;
+	msi->pp = pp;
+	msi->has_msi_ctrl = true;
+	msi->num_vectors = num_vectors;
+
+	if (!msi->msi_irq[0]) {
+		ret = dw_pcie_parse_split_msi_irq(msi, pdev);
+		if (ret < 0 && ret != -ENXIO)
+			return ERR_PTR(ret);
+	}
+
+	if (!msi->num_vectors)
+		msi->num_vectors = MSI_DEF_NUM_VECTORS;
+	num_ctrls = msi->num_vectors / MAX_MSI_IRQS_PER_CTRL;
+
+	if (!msi->msi_irq[0]) {
+		msi->msi_irq[0] = platform_get_irq_byname_optional(pdev, "msi");
+		if (msi->msi_irq[0] < 0) {
+			msi->msi_irq[0] = platform_get_irq(pdev, 0);
+			if (msi->msi_irq[0] < 0)
+				return ERR_PTR(msi->msi_irq[0]);
+		}
+	}
+
+	dev_dbg(dev, "Using %d MSI vectors\n", msi->num_vectors);
+
+	msi->msi_irq_chip = &dw_pci_msi_bottom_irq_chip;
+
+	ret = dw_pcie_allocate_domains(msi);
+	if (ret)
+		return ERR_PTR(ret);
+
+	for (ctrl = 0; ctrl < num_ctrls; ctrl++) {
+		if (msi->msi_irq[ctrl] > 0)
+			irq_set_chained_handler_and_data(msi->msi_irq[ctrl],
+						    dw_chained_msi_isr, msi);
+	}
+
+	/*
+	 * Even though the iMSI-RX Module supports 64-bit addresses some
+	 * peripheral PCIe devices may lack 64-bit message support. In
+	 * order not to miss MSI TLPs from those devices the MSI target
+	 * address has to be within the lowest 4GB.
+	 *
+	 * Note until there is a better alternative found the reservation is
+	 * done by allocating from the artificially limited DMA-coherent
+	 * memory.
+	 */
+	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
+	if (!ret)
+		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &msi->msi_data,
+						GFP_KERNEL);
+
+	if (!msi_vaddr) {
+		dev_warn(dev, "Failed to allocate 32-bit MSI address\n");
+		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
+		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &msi->msi_data,
+						GFP_KERNEL);
+		if (!msi_vaddr) {
+			dev_err(dev, "Failed to allocate MSI address\n");
+			dw_pcie_free_msi(msi);
+			return ERR_PTR(-ENOMEM);
+		}
+	}
+
+	return msi;
+}
diff --git a/drivers/pci/controller/dwc/pcie-designware-msi.h b/drivers/pci/controller/dwc/pcie-designware-msi.h
new file mode 100644
index 0000000..633156e
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-designware-msi.h
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Synopsys DesignWare PCIe host controller driver
+ *
+ * Copyright (C) 2013 Samsung Electronics Co., Ltd.
+ *		https://www.samsung.com
+ *
+ * Author: Jingoo Han <jg1.han@samsung.com>
+ */
+#ifndef _PCIE_DESIGNWARE_MSI_H
+#define _PCIE_DESIGNWARE_MSI_H
+
+#include "../../pci.h"
+
+#define MAX_MSI_IRQS			256
+#define MAX_MSI_IRQS_PER_CTRL		32
+#define MAX_MSI_CTRLS			(MAX_MSI_IRQS / MAX_MSI_IRQS_PER_CTRL)
+#define MSI_REG_CTRL_BLOCK_SIZE		12
+#define MSI_DEF_NUM_VECTORS		32
+
+struct dw_msi {
+	struct device		*dev;
+	struct irq_domain	*irq_domain;
+	struct irq_domain	*msi_domain;
+	struct irq_chip		*msi_irq_chip;
+	int			msi_irq[MAX_MSI_CTRLS];
+	dma_addr_t		msi_data;
+	u32			num_vectors;
+	u32			irq_mask[MAX_MSI_CTRLS];
+	raw_spinlock_t		lock;
+	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
+	bool                    has_msi_ctrl;
+	void			*private_data;
+	void			*pp;
+};
+
+struct dw_msi *dw_pcie_msi_host_init(struct platform_device *pdev,
+			void *pp, u32 num_vectors);
+int dw_pcie_allocate_domains(struct dw_msi *msi);
+void dw_pcie_msi_init(struct dw_msi *msi);
+void dw_pcie_free_msi(struct dw_msi *msi);
+irqreturn_t dw_handle_msi_irq(struct dw_msi *msi);
+#endif /* _PCIE_DESIGNWARE_MSI_H */
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 1b5aba1..e84298e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -22,6 +22,7 @@
 
 #include "../../pci.h"
 #include "pcie-designware.h"
+#include "pcie-designware-msi.h"
 
 static const char * const dw_pcie_app_clks[DW_PCIE_NUM_APP_CLKS] = {
 	[DW_PCIE_DBI_CLK] = "dbi",
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ef84931..8b7fddf 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -232,12 +232,6 @@
 #define DEFAULT_DBI_ATU_OFFSET (0x3 << 20)
 #define DEFAULT_DBI_DMA_OFFSET PCIE_DMA_UNROLL_BASE
 
-#define MAX_MSI_IRQS			256
-#define MAX_MSI_IRQS_PER_CTRL		32
-#define MAX_MSI_CTRLS			(MAX_MSI_IRQS / MAX_MSI_IRQS_PER_CTRL)
-#define MSI_REG_CTRL_BLOCK_SIZE		12
-#define MSI_DEF_NUM_VECTORS		32
-
 /* Maximum number of inbound/outbound iATUs */
 #define MAX_IATU_IN			256
 #define MAX_IATU_OUT			256
@@ -319,7 +313,6 @@ struct dw_pcie_host_ops {
 };
 
 struct dw_pcie_rp {
-	bool			has_msi_ctrl:1;
 	bool			cfg0_io_shared:1;
 	u64			cfg0_base;
 	void __iomem		*va_cfg0_base;
@@ -329,16 +322,10 @@ struct dw_pcie_rp {
 	u32			io_size;
 	int			irq;
 	const struct dw_pcie_host_ops *ops;
-	int			msi_irq[MAX_MSI_CTRLS];
-	struct irq_domain	*irq_domain;
-	struct irq_domain	*msi_domain;
-	dma_addr_t		msi_data;
-	struct irq_chip		*msi_irq_chip;
 	u32			num_vectors;
-	u32			irq_mask[MAX_MSI_CTRLS];
+	struct dw_msi		*msi;
 	struct pci_host_bridge  *bridge;
 	raw_spinlock_t		lock;
-	DECLARE_BITMAP(msi_irq_in_use, MAX_MSI_IRQS);
 	bool			use_atu_msg;
 	int			msg_atu_index;
 	struct resource		*msg_res;
@@ -639,19 +626,12 @@ static inline enum dw_pcie_ltssm dw_pcie_get_ltssm(struct dw_pcie *pci)
 }
 
 #ifdef CONFIG_PCIE_DW_HOST
-irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp);
 int dw_pcie_setup_rc(struct dw_pcie_rp *pp);
 int dw_pcie_host_init(struct dw_pcie_rp *pp);
 void dw_pcie_host_deinit(struct dw_pcie_rp *pp);
-int dw_pcie_allocate_domains(struct dw_pcie_rp *pp);
 void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus, unsigned int devfn,
 				       int where);
 #else
-static inline irqreturn_t dw_handle_msi_irq(struct dw_pcie_rp *pp)
-{
-	return IRQ_NONE;
-}
-
 static inline int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 {
 	return 0;
@@ -666,10 +646,6 @@ static inline void dw_pcie_host_deinit(struct dw_pcie_rp *pp)
 {
 }
 
-static inline int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
-{
-	return 0;
-}
 static inline void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus,
 						     unsigned int devfn,
 						     int where)
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index d99e12f..6139330 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -16,6 +16,7 @@
 
 #include "../../pci.h"
 #include "pcie-designware.h"
+#include "pcie-designware-msi.h"
 
 /* Renesas-specific */
 /* PCIe Mode Setting Register 0 */
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 804341b..f415fa1 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -34,6 +34,7 @@
 #include <soc/tegra/bpmp.h>
 #include <soc/tegra/bpmp-abi.h>
 #include "../../pci.h"
+#include "pcie-designware-msi.h"
 
 #define TEGRA194_DWC_IP_VER			0x490A
 #define TEGRA234_DWC_IP_VER			0x562A
@@ -2407,6 +2408,7 @@ static int tegra_pcie_dw_resume_early(struct device *dev)
 static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
 {
 	struct tegra_pcie_dw *pcie = platform_get_drvdata(pdev);
+	struct dw_msi *msi;
 
 	if (pcie->of_data->mode == DW_PCIE_RC_TYPE) {
 		if (!pcie->link_state)
@@ -2415,9 +2417,10 @@ static void tegra_pcie_dw_shutdown(struct platform_device *pdev)
 		debugfs_remove_recursive(pcie->debugfs);
 		tegra_pcie_downstream_dev_to_D0(pcie);
 
+		msi = pcie->pci.pp.msi;
 		disable_irq(pcie->pci.pp.irq);
 		if (IS_ENABLED(CONFIG_PCI_MSI))
-			disable_irq(pcie->pci.pp.msi_irq[0]);
+			disable_irq(msi->msi_irq[0]);
 
 		tegra_pcie_dw_pme_turnoff(pcie);
 		tegra_pcie_unconfig_controller(pcie);
-- 
2.7.4


