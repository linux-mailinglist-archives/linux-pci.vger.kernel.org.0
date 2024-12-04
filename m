Return-Path: <linux-pci+bounces-17646-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D37189E3A3A
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 13:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C7F286AA0
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 12:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4571C1F12;
	Wed,  4 Dec 2024 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n3iG8HnO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D8721B9831;
	Wed,  4 Dec 2024 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316367; cv=none; b=QTOfbfEhOO1lGv+23hXd297L/ys6aNHyz1FMpAlOD6GzP4kbqx4NVZnlMz6ZcAzZ5viqs1L9RueGU9L0XzPmFuKKvb21H0sZXIr//gkh3T31Wz1ICkJBX57MlvbEcCyZ/WaFRuHleFautlZs8DypnC6lU+eOnYSl+ekjcwWTaPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316367; c=relaxed/simple;
	bh=1V1FmvDMYnTWLajD7/gkCCe4tIOFd8A5mV3a3mgRPVM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CgXKMgXQ7ydpsZKuxy6U1oo1ZugrTjNmrXqFZLKpJO+6pY58IhA9qyf8dhaujjVz18a7746w0xZzhgXFieL/ugqXTp4BeaGIwKaOhhJV7K4Fnj+4/MX2REz1YvHAQVHDHKb8cJ90/XsZHxMSWfzBXXSmyWFe2I3U6ryNXhGC5A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n3iG8HnO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA059C4CEE1;
	Wed,  4 Dec 2024 12:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733316366;
	bh=1V1FmvDMYnTWLajD7/gkCCe4tIOFd8A5mV3a3mgRPVM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n3iG8HnOi+ARtsWCUBL1CRJL9kMugczwqyYnB+XTeNHXx9L8y2GQ22sIoWSLtcxy6
	 QXIPGa+mIuBiymtO45sUfVk8J0kI5TmsKayPVHsiyrhY4M9tmzCYgno6vJsJJgfUpj
	 u9revKLDf+dC0ACsldoFraFy3jZSqA5a20y1KsX7Wc/lJ3dsAEXpD+Lnu20YAVnyu5
	 9T4NwHb+gQenhY9XN1DvHJVLfUGJUkQbOcfpnLMFaXGoV1URNyDbP6vd8eXn55VWx/
	 2/O3YOtPxLrX0Hwp0EmB8RWPAHQR6/6mg7t+SOeBxMApoznkpC2v9t6QEDVTQ9Nhvn
	 KhMWJcvs1B++w==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tIolY-000RHy-Uq;
	Wed, 04 Dec 2024 12:46:05 +0000
From: Marc Zyngier <maz@kernel.org>
To: iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	linux-pci@vger.kernel.org
Cc: Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Anup Patel <anup@brainfault.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Toan Le <toan@os.amperecomputing.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>
Subject: [PATCH 03/11] irqchip/gic: Convert to msi_create_parent_irq_domain() helper
Date: Wed,  4 Dec 2024 12:45:41 +0000
Message-Id: <20241204124549.607054-4-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241204124549.607054-1-maz@kernel.org>
References: <20241204124549.607054-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org, joro@8bytes.org, suravee.suthikulpanit@amd.com, dwmw2@infradead.org, baolu.lu@linux.intel.com, tglx@linutronix.de, shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com, chenhuacai@kernel.org, kernel@xen0n.name, jiaxun.yang@flygoat.com, andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, anup@brainfault.org, paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu, lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, bhelgaas@google.com, toan@os.amperecomputing.com, alyssa@rosenzweig.io
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Now that we have a concise helper to create an MSI parent domain,
switch the GIC family over to that.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v2m.c    |  9 ++++-----
 drivers/irqchip/irq-gic-v3-its.c | 14 +++++---------
 drivers/irqchip/irq-gic-v3-mbi.c |  9 ++++-----
 3 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index db79ae622f3c4..4916743aed314 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -270,16 +270,15 @@ static __init int gicv2m_allocate_domains(struct irq_domain *parent)
 	if (!v2m)
 		return 0;
 
-	inner_domain = irq_domain_create_hierarchy(parent, 0, 0, v2m->fwnode,
-						   &gicv2m_domain_ops, v2m);
+	inner_domain = msi_create_parent_irq_domain(v2m->fwnode,
+						    &gicv2m_msi_parent_ops,
+						    &gicv2m_domain_ops,
+						    0, 0, v2m, parent);
 	if (!inner_domain) {
 		pr_err("Failed to create GICv2m domain\n");
 		return -ENOMEM;
 	}
 
-	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_NEXUS);
-	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
-	inner_domain->msi_parent_ops = &gicv2m_msi_parent_ops;
 	return 0;
 }
 
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 334fd15be1de1..6f61ee7c5d394 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5114,20 +5114,16 @@ static int its_init_domain(struct its_node *its)
 	info->ops = &its_msi_domain_ops;
 	info->data = its;
 
-	inner_domain = irq_domain_create_hierarchy(its_parent,
-						   its->msi_domain_flags, 0,
-						   its->fwnode_handle, &its_domain_ops,
-						   info);
+	inner_domain = msi_create_parent_irq_domain(its->fwnode_handle,
+						    &gic_v3_its_msi_parent_ops,
+						    &its_domain_ops,
+						    its->msi_domain_flags, 0,
+						    info, its_parent);
 	if (!inner_domain) {
 		kfree(info);
 		return -ENOMEM;
 	}
 
-	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_NEXUS);
-
-	inner_domain->msi_parent_ops = &gic_v3_its_msi_parent_ops;
-	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
-
 	return 0;
 }
 
diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index 63c658375fd55..e5f532f95148d 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -211,14 +211,13 @@ static int mbi_allocate_domain(struct irq_domain *parent)
 {
 	struct irq_domain *nexus_domain;
 
-	nexus_domain = irq_domain_create_hierarchy(parent, 0, 0, parent->fwnode,
-						   &mbi_domain_ops, NULL);
+	nexus_domain = msi_create_parent_irq_domain(parent->fwnode,
+						    &gic_v3_mbi_msi_parent_ops,
+						    &mbi_domain_ops,
+						    0, 0, NULL, parent);
 	if (!nexus_domain)
 		return -ENOMEM;
 
-	irq_domain_update_bus_token(nexus_domain, DOMAIN_BUS_NEXUS);
-	nexus_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
-	nexus_domain->msi_parent_ops = &gic_v3_mbi_msi_parent_ops;
 	return 0;
 }
 
-- 
2.39.2


