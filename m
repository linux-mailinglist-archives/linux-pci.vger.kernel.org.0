Return-Path: <linux-pci+bounces-22734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41284A4B812
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 08:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2479E18903C1
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 07:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6248E1DE882;
	Mon,  3 Mar 2025 07:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GilfxMHA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5BF34A3C
	for <linux-pci@vger.kernel.org>; Mon,  3 Mar 2025 07:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740985511; cv=none; b=ZMeMQXujIYetOr6E1Z8zTkS2egYO5VEBgCZMbYwmUn9UGrxdj3roZ6tT5W+XOqeuesU7yhlfL4ujIKYMsqY7Lfn9LumVqJq9HNOwuLcnfht2jVYTz217Ustum3n11Z4T4qqD0RQWFrqAj7Ok3/rqLmijNyEgPRxn0pb4LRo8ihc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740985511; c=relaxed/simple;
	bh=fkrqlJ4lMkpnhFF/JoRmoy6Xl6EPh2ZYHBadIDE00g4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=mAdRmaOc9uUvsgvyfRT3t9ce4sXZrwz5DZu1gmbCeMTaOaYdoUg694OPdJHQf18wWT3Cr+yMDFOlw/g3nJ8mz133RjVC1NM1idkt4bvnBBrdaaPhA44gbhbHUwKruuTqdSt9iTRwOFNcN7til2+s3fHXQU2fSCMrjS2rVmFxmpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--danielsftsai.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GilfxMHA; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--danielsftsai.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2234c09241fso123505325ad.2
        for <linux-pci@vger.kernel.org>; Sun, 02 Mar 2025 23:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740985509; x=1741590309; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y6serRKEoQuCfoPht6pEqOgdrHUy6pFLgmEnKfz2JXo=;
        b=GilfxMHAsWDiljAHdj5W/9uR7B3jcEzKITjuz4S3R/PCcHWSbY7P0fiXoMzmqn+NPC
         DPlQQsnnEL29kUR8O1rkfLoTw7W/zlv6mD5fFnkGVMSlGQ3XUUgfQ5zx+Q1/8DtM8hfu
         aC8fw+fxTXFVkPCDUqOoueoRZSy54J5AZ2Q6c0AjlBtnm4EGeOKcNqby3zGzp0QVNK3t
         +JFMY/mCeVrp9rPYJ8w6Wu80iANRz//gkMRRWQGrUW6NzJjA20dpDhBKkmRw8wUaHelC
         sYTjOuH6jvNuW5HhcRcuKZOpRmv4j4KelXFyNJLoAngHnPqfbPLRsLwLjD3f4RzQNCyS
         JfJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740985509; x=1741590309;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y6serRKEoQuCfoPht6pEqOgdrHUy6pFLgmEnKfz2JXo=;
        b=kXd21QQKxNW2h6pg6Js/sCnbHLlettX0ePO3Twk8ZlzT41+yxVEdm3DiaZZbuT6dw4
         fS1FUGFXFyYJLUDStV2BLDxsZsN5d1EDLdY2NYRKOhaQ8d+QSpq6WgUneCGdZCK7QwBs
         ceo+pv0i4HNKwleWXI+c5iiE1Zo45TZpQwx0pMZYjnRAvZr7W2k8ZxlfTDoHHbkEdvsf
         O5dUThUqLIi0fPEFyh9M71W9weUk90GBGD8DX3HqmhZ5AfYjbuY+vwi0dUAxcBUb4YOY
         FtwCOBJAlthU8nuggiT142OjnNV3ByUJ6CezX90Ln58QVmxMjaxQy4j1//N58kaC8Xjv
         SLlA==
X-Forwarded-Encrypted: i=1; AJvYcCUKSYxCbx8210B31js7kbgve8a1jtj2roA6b+GCkEvYvb4fLjggE6yssO9ZxUI7vy40udoVlR+mynA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0ozj1Yh3sUwYili96rg60rIo3adPcCkG1RjQ3pA1kYV8bCV0f
	6mEFF5ocCLw60AB2TNIyoXdpL2aNqjpMf2MKMTsA27GptZUk4f+oirhvFJBFr98GvEX3MuwO/7U
	by/iDdaHdLYOd/yOaHCbVRh97BA==
X-Google-Smtp-Source: AGHT+IGj/e+ErRwQh7WxW71yHsqbrkcNr3dTdjGTJ1zJjDWEzR94QagaUzbyUc30AtDfU3zSwxybwaYaoo/ktDf3zR4=
X-Received: from pfwo4.prod.google.com ([2002:a05:6a00:1bc4:b0:736:520e:b9dc])
 (user=danielsftsai job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:23c4:b0:736:65c9:918d with SMTP id d2e1a72fcca58-73665c992b7mr102926b3a.8.1740985508990;
 Sun, 02 Mar 2025 23:05:08 -0800 (PST)
Date: Mon,  3 Mar 2025 07:05:01 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.48.1.711.g2feabab25a-goog
Message-ID: <20250303070501.2740392-1-danielsftsai@google.com>
Subject: [PATCH] PCI: dwc: Chain the set IRQ affinity request back to the parent
From: Daniel Tsai <danielsftsai@google.com>
To: Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	"=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Andrew Chant <achant@google.com>, Brian Norris <briannorris@google.com>, 
	Sajid Dalvi <sdalvi@google.com>, Mark Cheng <markcheng@google.com>, Ben Cheng <bccheng@google.com>, 
	Thomas Gleixner <tglx@linutronix.de>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Tsai Sung-Fu <danielsftsai@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Tsai Sung-Fu <danielsftsai@google.com>

In our use case, we hope to have each MSI controller to have assigned
CPU affinity due to throughput/performance concern.

Therefore, we chained the set affinity request pass down from Endpoint
device back to the parent by implementing the dw_pci_msi_set_affinity().

We aware of some concerns of breaking userspace ABI brought up in the
past discussion. So our implementation try to make some kind of
resolution to those ABI questions. Like the algo will reject the
affinity changing requests which are deem incompatible to the rest of
others which shared the same parent IRQ line. It also update their
effective affinities upon successful request, so correct affinity
setting will be reflected on the Sysfs interface.

Here is the flow

1. Map current MSI vector to the MSI controller it goes to, so we know
   it's parent IRQ number, stored in pp->msi_irq[].
2. Check if this is a valid request by calling to
   dw_pci_check_mask_compatibility(), we do cpumask_and() with all the MSI
   vectors binding to this MSI controller, as long as the result is not
   empty, we deem it as a valid request.
3. Call to the irq_set_affinity() callback bind to the parent to update
   the CPU affinity if it is a valid request.
4. Update the effective_mask of all the MSI vectors bind to this MSI
   controller by calling to the dw_pci_update_effective_affinity(), so
   we can have correct value reflect to the user space.

Set DesignWare with different IRQ lock class to avoid recursive lock
warning when running the kernel compile with debug configuration
enabled.

Signed-off-by: Tsai Sung-Fu <danielsftsai@google.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 131 +++++++++++++++++-
 1 file changed, 128 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d2291c3ceb8be..4cab9f05c8813 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -49,8 +49,7 @@ static struct irq_chip dw_pcie_msi_irq_chip = {
 
 static struct msi_domain_info dw_pcie_msi_domain_info = {
 	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		  MSI_FLAG_NO_AFFINITY | MSI_FLAG_PCI_MSIX |
-		  MSI_FLAG_MULTI_PCI_MSI,
+		  MSI_FLAG_PCI_MSIX | MSI_FLAG_MULTI_PCI_MSI,
 	.chip	= &dw_pcie_msi_irq_chip,
 };
 
@@ -117,6 +116,125 @@ static void dw_pci_setup_msi_msg(struct irq_data *d, struct msi_msg *msg)
 		(int)d->hwirq, msg->address_hi, msg->address_lo);
 }
 
+/*
+ * The algo here honor if there is any intersection of mask of
+ * the existing MSI vectors and the requesting MSI vector. So we
+ * could handle both narrow (1 bit set mask) and wide (0xffff...)
+ * cases, return -EINVAL and reject the request if the result of
+ * cpumask is empty, otherwise return 0 and have the calculated
+ * result on the mask_to_check to pass down to the irq_chip.
+ */
+static int dw_pci_check_mask_compatibility(struct dw_pcie_rp *pp,
+					   unsigned long ctrl,
+					   unsigned long hwirq_to_check,
+					   struct cpumask *mask_to_check)
+{
+	unsigned long end, hwirq;
+	const struct cpumask *mask;
+	unsigned int virq;
+
+	hwirq = ctrl * MAX_MSI_IRQS_PER_CTRL;
+	end = hwirq + MAX_MSI_IRQS_PER_CTRL;
+	for_each_set_bit_from(hwirq, pp->msi_irq_in_use, end) {
+		if (hwirq == hwirq_to_check)
+			continue;
+		virq = irq_find_mapping(pp->irq_domain, hwirq);
+		if (!virq)
+			continue;
+		mask = irq_get_affinity_mask(virq);
+		if (!cpumask_and(mask_to_check, mask, mask_to_check))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void dw_pci_update_effective_affinity(struct dw_pcie_rp *pp,
+					     unsigned long ctrl,
+					     const struct cpumask *effective_mask,
+					     unsigned long hwirq_to_check)
+{
+	struct irq_desc *desc_downstream;
+	unsigned int virq_downstream;
+	unsigned long end, hwirq;
+
+	/*
+	 * Update all the irq_data's effective mask
+	 * bind to this MSI controller, so the correct
+	 * affinity would reflect on
+	 * /proc/irq/XXX/effective_affinity
+	 */
+	hwirq = ctrl * MAX_MSI_IRQS_PER_CTRL;
+	end = hwirq + MAX_MSI_IRQS_PER_CTRL;
+	for_each_set_bit_from(hwirq, pp->msi_irq_in_use, end) {
+		virq_downstream = irq_find_mapping(pp->irq_domain, hwirq);
+		if (!virq_downstream)
+			continue;
+		desc_downstream = irq_to_desc(virq_downstream);
+		irq_data_update_effective_affinity(&desc_downstream->irq_data,
+						   effective_mask);
+	}
+}
+
+static int dw_pci_msi_set_affinity(struct irq_data *d,
+				   const struct cpumask *mask, bool force)
+{
+	struct dw_pcie_rp *pp = irq_data_get_irq_chip_data(d);
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	int ret;
+	int virq_parent;
+	unsigned long hwirq = d->hwirq;
+	unsigned long flags, ctrl;
+	struct irq_desc *desc_parent;
+	const struct cpumask *effective_mask;
+	cpumask_var_t mask_result;
+
+	ctrl = hwirq / MAX_MSI_IRQS_PER_CTRL;
+	if (!alloc_cpumask_var(&mask_result, GFP_ATOMIC))
+		return -ENOMEM;
+
+	/*
+	 * Loop through all possible MSI vector to check if the
+	 * requested one is compatible with all of them
+	 */
+	raw_spin_lock_irqsave(&pp->lock, flags);
+	cpumask_copy(mask_result, mask);
+	ret = dw_pci_check_mask_compatibility(pp, ctrl, hwirq, mask_result);
+	if (ret) {
+		dev_dbg(pci->dev, "Incompatible mask, request %*pbl, irq num %u\n",
+			cpumask_pr_args(mask), d->irq);
+		goto unlock;
+	}
+
+	dev_dbg(pci->dev, "Final mask, request %*pbl, irq num %u\n",
+		cpumask_pr_args(mask_result), d->irq);
+
+	virq_parent = pp->msi_irq[ctrl];
+	desc_parent = irq_to_desc(virq_parent);
+	ret = desc_parent->irq_data.chip->irq_set_affinity(&desc_parent->irq_data,
+							   mask_result, force);
+
+	if (ret < 0)
+		goto unlock;
+
+	switch (ret) {
+	case IRQ_SET_MASK_OK:
+	case IRQ_SET_MASK_OK_DONE:
+		cpumask_copy(desc_parent->irq_common_data.affinity, mask);
+		fallthrough;
+	case IRQ_SET_MASK_OK_NOCOPY:
+		break;
+	}
+
+	effective_mask = irq_data_get_effective_affinity_mask(&desc_parent->irq_data);
+	dw_pci_update_effective_affinity(pp, ctrl, effective_mask, hwirq);
+
+unlock:
+	free_cpumask_var(mask_result);
+	raw_spin_unlock_irqrestore(&pp->lock, flags);
+	return ret < 0 ? ret : IRQ_SET_MASK_OK_NOCOPY;
+}
+
 static void dw_pci_bottom_mask(struct irq_data *d)
 {
 	struct dw_pcie_rp *pp = irq_data_get_irq_chip_data(d);
@@ -172,10 +290,14 @@ static struct irq_chip dw_pci_msi_bottom_irq_chip = {
 	.name = "DWPCI-MSI",
 	.irq_ack = dw_pci_bottom_ack,
 	.irq_compose_msi_msg = dw_pci_setup_msi_msg,
+	.irq_set_affinity = dw_pci_msi_set_affinity,
 	.irq_mask = dw_pci_bottom_mask,
 	.irq_unmask = dw_pci_bottom_unmask,
 };
 
+static struct lock_class_key dw_pci_irq_lock_class;
+static struct lock_class_key dw_pci_irq_request_class;
+
 static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
 				    unsigned int virq, unsigned int nr_irqs,
 				    void *args)
@@ -195,11 +317,14 @@ static int dw_pcie_irq_domain_alloc(struct irq_domain *domain,
 	if (bit < 0)
 		return -ENOSPC;
 
-	for (i = 0; i < nr_irqs; i++)
+	for (i = 0; i < nr_irqs; i++) {
+		irq_set_lockdep_class(virq + i, &dw_pci_irq_lock_class,
+				      &dw_pci_irq_request_class);
 		irq_domain_set_info(domain, virq + i, bit + i,
 				    pp->msi_irq_chip,
 				    pp, handle_edge_irq,
 				    NULL, NULL);
+	}
 
 	return 0;
 }
-- 
2.48.1.711.g2feabab25a-goog


