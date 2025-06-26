Return-Path: <linux-pci+bounces-30733-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BBCAE9B6B
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 036441C413D2
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 10:33:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF2C26B75E;
	Thu, 26 Jun 2025 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E9DMcGLR"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3EA25B2E8;
	Thu, 26 Jun 2025 10:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750933719; cv=none; b=Nz1EmfzlpVTzwvdjzByx3xPV+yjyPa2xZ5a9/CbgBUxovhDkGxxguVnvG5aCILjqBnRfWDLNu+brWVNV7wi2LttApTRnGKwFoPOPDn4fdkdLeZLpKmLUSqntM1yNbP78sZjhmz0aSMYVhggmtIVSqmMEHdGE/6LCBPb/JbVlCRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750933719; c=relaxed/simple;
	bh=2t+pbHLPg+ls2EtXz7TcnOFKUGN7yrK1ryOvzqY4j+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IqBYuKLiqq8bV99lITQrWPGtlQ+WlTVEvKJSWGzqrqOTRU9xYAQUB8KXUfzGHG8wuqFwLnZTrb+4XhdZ0Qzd/gQYxKd3uBTOR5ihLkiZ35uFA0U+NJ2p2lntc58cQS7q9zBNne7fBFiNZb84bX9FEAgzfRKu60tIo4nDKYNcvnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E9DMcGLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76F58C4CEEB;
	Thu, 26 Jun 2025 10:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750933719;
	bh=2t+pbHLPg+ls2EtXz7TcnOFKUGN7yrK1ryOvzqY4j+k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E9DMcGLRe97AIBUEkLyvRsSZdH5ltK5qKq0GeqGGUOf1+MZ2PhDIqxCjDq8zH7MKX
	 52Od10YyqdnvPiT+RE2PwYUerdwZ0f+Fxrh7EWhi6mDjcW7MdRPyfg+Rrv4hzEu2XX
	 xKeAxuHAzoxWhJU2ktRdAoZoV4yuHExQDUXY0JWOrEQb1hGbkUwJcsA0zB+pvaV8oj
	 d5pjMjK6ygeiXKkU9p/12auaZ+MtrA2klTgi6cUitHyF2yCJuq9nWJI+ABRuwxSjgG
	 Z4wYCgq2oBAP3s9sfj+ydGemfHKK3qmP40Zk8DDJRbjpuGcs35JG5f6j7ClvL1dc4J
	 s3CZZiokzg0RA==
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
Date: Thu, 26 Jun 2025 12:26:16 +0200
Subject: [PATCH v6 25/31] PCI/MSI: Add pci_msi_map_rid_ctlr_node() helper
 function
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250626-gicv5-host-v6-25-48e046af4642@kernel.org>
References: <20250626-gicv5-host-v6-0-48e046af4642@kernel.org>
In-Reply-To: <20250626-gicv5-host-v6-0-48e046af4642@kernel.org>
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


