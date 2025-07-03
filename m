Return-Path: <linux-pci+bounces-31376-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CF1AF7052
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 12:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099491BC1C4B
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 10:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C0272E54B7;
	Thu,  3 Jul 2025 10:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDiIwa/A"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2248B2E3AE9;
	Thu,  3 Jul 2025 10:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751538453; cv=none; b=l9Yc3lcfwwbUVxtsDNVmAN2lMo8OrrEseEwqzzY12uzgcBa6PvVK8bjUPCXYNqhrHCkM0+cRxqxlWQnTh0JB+oWt/JFM4p8peFQjQwnFV3FPW8gD05aM+LJjf9dkgpyB2Z5rUM562es3XVOAzCWXmbguZbHV5Xcd//J8opnD7R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751538453; c=relaxed/simple;
	bh=kcQzsER7QdASrb9daMHpXtsDHIwhK/zyXrrP1v57pPY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kcd+alE8WDbyCZ9wVf+4U6vhkToNhrZor2C+YmMg0GY6kI5bkUOikvUDDMAv8a98KDZkOF0jhcMNj+PjwgZrOYfKNpR2UYhh86/VBNSxjTUS5GCTkOOnXD6M+p1rMzLQg7Vwkz4SsYUWjmzDQFK8/8a4VtsdEmj15ChQwtnKdG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDiIwa/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0268C4CEE3;
	Thu,  3 Jul 2025 10:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751538452;
	bh=kcQzsER7QdASrb9daMHpXtsDHIwhK/zyXrrP1v57pPY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LDiIwa/ApQJbdkfprm22n+4WcQLTw0PmULQUgVooIItke6uzDx6Ah/iZdwqiZ7nr1
	 Wjs7LgJ1ApCZT01xDU8lBh/DmFdM2BixPYAHNw31pDkBsX9C7ESIktnM7Po37jbZ4/
	 B+gEFmuepvcllGOF5Wuhjh96QGwWJsXeLj9sBvEWm1YqN9zIqy4+KBrLBSiHo3nBEC
	 Q/oJauRvHzdIrWigLwPbIMRqiuoNSEdcBosNKfioan6MDwsFkerl2GVkSgIpFw9/r6
	 7S0xiV4sP/xT7t/p0dlEDUZr15MhQqwF5vfJPlgN6tb2ckGhNLpVoT06++MzI4Y2kV
	 sdqBVjBZk26+w==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 03 Jul 2025 12:25:15 +0200
Subject: [PATCH v7 25/31] PCI/MSI: Add pci_msi_map_rid_ctlr_node() helper
 function
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-gicv5-host-v7-25-12e71f1b3528@kernel.org>
References: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
In-Reply-To: <20250703-gicv5-host-v7-0-12e71f1b3528@kernel.org>
To: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, 
 Sascha Bischoff <sascha.bischoff@arm.com>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Timothy Hayes <timothy.hayes@arm.com>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Mark Rutland <mark.rutland@arm.com>, Jiri Slaby <jirislaby@kernel.org>, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>
X-Mailer: b4 0.15-dev-6f78e

IRQchip drivers need a PCI/MSI function to map a RID to a MSI
controller deviceID namespace and at the same time retrieve the
struct device_node pointer of the MSI controller the RID is mapped
to.

Add pci_msi_map_rid_ctlr_node() to achieve this purpose.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc  Bjorn Helgaas <bhelgaas@google.com>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/pci/msi/irqdomain.c | 20 ++++++++++++++++++++
 include/linux/msi.h         |  1 +
 2 files changed, 21 insertions(+)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index c05152733993..8a6e80d3963a 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -427,6 +427,26 @@ u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev)
 	return rid;
 }
 
+/**
+ * pci_msi_map_rid_ctlr_node - Get the MSI controller node and MSI requester id (RID)
+ * @pdev:	The PCI device
+ * @node:	Pointer to store the MSI controller device node
+ *
+ * Use the firmware data to find the MSI controller node for @pdev.
+ * If found map the RID and initialize @node with it. @node value must
+ * be set to NULL on entry.
+ *
+ * Returns: The RID.
+ */
+u32 pci_msi_map_rid_ctlr_node(struct pci_dev *pdev, struct device_node **node)
+{
+	u32 rid = pci_dev_id(pdev);
+
+	pci_for_each_dma_alias(pdev, get_msi_id_cb, &rid);
+
+	return of_msi_xlate(&pdev->dev, node, rid);
+}
+
 /**
  * pci_msi_get_device_domain - Get the MSI domain for a given PCI device
  * @pdev:	The PCI device
diff --git a/include/linux/msi.h b/include/linux/msi.h
index 6863540f4b71..a418e2695b05 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -705,6 +705,7 @@ struct irq_domain *pci_msi_create_irq_domain(struct fwnode_handle *fwnode,
 					     struct msi_domain_info *info,
 					     struct irq_domain *parent);
 u32 pci_msi_domain_get_msi_rid(struct irq_domain *domain, struct pci_dev *pdev);
+u32 pci_msi_map_rid_ctlr_node(struct pci_dev *pdev, struct device_node **node);
 struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev);
 #else /* CONFIG_PCI_MSI */
 static inline struct irq_domain *pci_msi_get_device_domain(struct pci_dev *pdev)

-- 
2.48.0


