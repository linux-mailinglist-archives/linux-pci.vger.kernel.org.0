Return-Path: <linux-pci+bounces-27654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1666CAB5B39
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 19:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F657188E8D8
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 17:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FFD2BEC21;
	Tue, 13 May 2025 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m3NXXBME"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE43B2BE7C4;
	Tue, 13 May 2025 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747157310; cv=none; b=MG4czBLRp0jvzNBzlNJzf4r/euQScIvCAMaFJi1GvXK4Dsi7eLPYfHHGgH/iWTNWFYZtKTBDfrVn8L8SyeC5FUbEnZBUJGQOqont8xn/AVcRNaEiotjBz0XTWI3y4UhT6rWgEwBy22O3gQ70GVyhYE5wHza7XjuLNejCb7Dcs3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747157310; c=relaxed/simple;
	bh=hJnEDdlO2yAeWjJZLwOK8T9TN8bPwhBcclQiZAl/tvQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RCZGeRRfRx/+PBTvh0Y2lkNaJmF10iIJVdKc8o0aGET5F99YfoOquz0DlhYBDZbRECLlyMgA+yDRXDavJzH/wbpYIYwEL4cejOfX895mblBCrYyZIm5OLAsP4JjDvHa05CyoIsYZWGalBRrPP1XuDrA5zWWj72jRiHhHCoV4LHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m3NXXBME; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60828C4CEF2;
	Tue, 13 May 2025 17:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747157310;
	bh=hJnEDdlO2yAeWjJZLwOK8T9TN8bPwhBcclQiZAl/tvQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m3NXXBMEOno7S4l41KbEzkbwBRE0r32Lrlik96A7hRHsMUPQDujQ4f1z01V0wv5Lr
	 nPmmGQAXsxOlzy58uQc78D9aWMkpIWkKXjgBrQFUDFf2w4fjWNwcADhcRQLfPW3/IU
	 hJlq3tAZh8SulU07V3e+b5rZmlphQ9B+nhALsGlTBga75KJfCC8ijE5+XQdPI1SfBv
	 Xffhs97gS0jM0Af3k/vvzahGfHfdX9feZpBE6Tf7Pce7w1lzVHb296s+pBUteGKZYn
	 lqvpBmhMEP7K34siTFutWivrPR/tVQKJqQJeyaHcJBf5nskooCUgP8Y2vvNt2WTFHh
	 kpmLq3bq7t+yw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uEtQa-00EbRz-HN;
	Tue, 13 May 2025 18:28:28 +0100
From: Marc Zyngier <maz@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Andrew Lunn <andrew@lunn.ch>,
	Gregory Clement <gregory.clement@bootlin.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Toan Le <toan@os.amperecomputing.com>,
	Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Subject: [PATCH v2 3/9] irqchip/gic: Convert to msi_create_parent_irq_domain() helper
Date: Tue, 13 May 2025 18:28:13 +0100
Message-Id: <20250513172819.2216709-4-maz@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20250513172819.2216709-1-maz@kernel.org>
References: <20250513172819.2216709-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, tglx@linutronix.de, andrew@lunn.ch, gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com, lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org, bhelgaas@google.com, toan@os.amperecomputing.com, alyssa@rosenzweig.io, thierry.reding@gmail.com, jonathanh@nvidia.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

Now that we have a concise helper to create an MSI parent domain,
switch the GIC family over to that.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v2m.c    | 12 +++++++-----
 drivers/irqchip/irq-gic-v3-its.c | 19 +++++++++----------
 drivers/irqchip/irq-gic-v3-mbi.c | 11 ++++++-----
 3 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index 62676994d0695..9050792e3242f 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -268,16 +268,18 @@ static __init int gicv2m_allocate_domains(struct irq_domain *parent)
 	if (!v2m)
 		return 0;
 
-	inner_domain = irq_domain_create_hierarchy(parent, 0, 0, v2m->fwnode,
-						   &gicv2m_domain_ops, v2m);
+	inner_domain = msi_create_parent_irq_domain(&(struct irq_domain_info){
+			.fwnode		= v2m->fwnode,
+			.ops		= &gicv2m_domain_ops,
+			.host_data	= v2m,
+			.parent		= parent,
+		}, &gicv2m_msi_parent_ops);
+
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
index 9e6380f597488..9ea3a6723263c 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -5128,20 +5128,19 @@ static int its_init_domain(struct its_node *its)
 	info->ops = &its_msi_domain_ops;
 	info->data = its;
 
-	inner_domain = irq_domain_create_hierarchy(its_parent,
-						   its->msi_domain_flags, 0,
-						   its->fwnode_handle, &its_domain_ops,
-						   info);
+	inner_domain = msi_create_parent_irq_domain(&(struct irq_domain_info){
+			.fwnode		= its->fwnode_handle,
+			.ops		= &its_domain_ops,
+			.host_data	= info,
+			.domain_flags	= its->msi_domain_flags,
+			.parent		= its_parent,
+		}, &gic_v3_its_msi_parent_ops);
+
 	if (!inner_domain) {
 		kfree(info);
 		return -ENOMEM;
 	}
 
-	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_NEXUS);
-
-	inner_domain->msi_parent_ops = &gic_v3_its_msi_parent_ops;
-	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT | IRQ_DOMAIN_FLAG_MSI_IMMUTABLE;
-
 	return 0;
 }
 
@@ -5518,7 +5517,7 @@ static struct its_node __init *its_node_init(struct resource *res,
 	its->base = its_base;
 	its->phys_base = res->start;
 	its->get_msi_base = its_irq_get_msi_base;
-	its->msi_domain_flags = IRQ_DOMAIN_FLAG_ISOLATED_MSI;
+	its->msi_domain_flags = IRQ_DOMAIN_FLAG_ISOLATED_MSI | IRQ_DOMAIN_FLAG_MSI_IMMUTABLE;
 
 	its->numa_node = numa_node;
 	its->fwnode_handle = handle;
diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index e562b57923229..11fa5df9da8c7 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -208,14 +208,15 @@ static int mbi_allocate_domain(struct irq_domain *parent)
 {
 	struct irq_domain *nexus_domain;
 
-	nexus_domain = irq_domain_create_hierarchy(parent, 0, 0, parent->fwnode,
-						   &mbi_domain_ops, NULL);
+	nexus_domain = msi_create_parent_irq_domain(&(struct irq_domain_info){
+			.fwnode		= parent->fwnode,
+			.ops		= &mbi_domain_ops,
+			.parent		= parent,
+		}, &gic_v3_mbi_msi_parent_ops);
+
 	if (!nexus_domain)
 		return -ENOMEM;
 
-	irq_domain_update_bus_token(nexus_domain, DOMAIN_BUS_NEXUS);
-	nexus_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
-	nexus_domain->msi_parent_ops = &gic_v3_mbi_msi_parent_ops;
 	return 0;
 }
 
-- 
2.39.2


