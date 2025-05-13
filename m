Return-Path: <linux-pci+bounces-27657-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E5B5AB5B3E
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 19:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AE3C3B29E5
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 17:28:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C345E2BF97B;
	Tue, 13 May 2025 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ErTw/W3y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3A62BF973;
	Tue, 13 May 2025 17:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747157311; cv=none; b=BhvoKXC7nvDPQJTTs8a3/X1ZsyfZcSalr97j1om7vNAD99YvlyXqva6HLiPWDhqFu9DjKX6CukX5o+6naVvVDHGqOYH630hUWvnmFEftRi+ImNtU2JueAiXhpx03nXTVP0QPFBfDTT7wJJa0rMJdAohpo4mqHq7RSgzxPFKOX+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747157311; c=relaxed/simple;
	bh=3pi3K+153jZ2kXdt+nyEuufOhRW3Pxm1XQ7dRPfM1vw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PO7nznaei7kBNSeC07VmygMKwMr+JkT5OdZ6KdYN3aP5leepzRT6+VaJw1wnjhri+idnzbMSYQRkRQBQDAke0l0JV/3U+KP8ymdi/Dvt8CfRsg1DvH41FbBVgf+5jWaDRflYksCo/+6xMV7OkzGlZdxBJg9vrOI+5GZDObkA7ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ErTw/W3y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A08FCC4CEF3;
	Tue, 13 May 2025 17:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747157310;
	bh=3pi3K+153jZ2kXdt+nyEuufOhRW3Pxm1XQ7dRPfM1vw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ErTw/W3ywaBJ3jtS4Pqj74LRXBO+OPQetOWMzPbJW14568am0KQcrJI83itDEuyG5
	 y/ca7qLq3nsXlBpuQx2j19H2WI15sH4iSiIQthLoU3TROIqLpkUEkQa1yu+uhwBhku
	 pzEDuQK42K9bOLThyXEp7VsX8nYr/b4sv4R6roqQQrwRsDkQXwrIP8wMqlTt1NoZEG
	 CbQElVfwjfll+7JDVb8gV9qv1USw1eRX6ia+/+WwvIObNdBEEM4XGWqVStPBkI9bM1
	 Eqdzmt3CGraC+3lBAkzHpoKLyE3Go7P4JcBMPD1h4//Q8EnXCQOg93+rNMIQtzLGtg
	 s1rFCwdwLEEGw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1uEtQa-00EbRz-OZ;
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
Subject: [PATCH v2 4/9] irqchip/mvebu: Convert to msi_create_parent_irq_domain() helper
Date: Tue, 13 May 2025 18:28:14 +0100
Message-Id: <20250513172819.2216709-5-maz@kernel.org>
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
switch the mvebu family of interrupt controllers over to that.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-mvebu-gicp.c | 14 +++++++-------
 drivers/irqchip/irq-mvebu-odmi.c | 14 ++++++--------
 drivers/irqchip/irq-mvebu-sei.c  | 16 +++++++---------
 3 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/irqchip/irq-mvebu-gicp.c b/drivers/irqchip/irq-mvebu-gicp.c
index 0b2a857b49018..c7c83f8923fcd 100644
--- a/drivers/irqchip/irq-mvebu-gicp.c
+++ b/drivers/irqchip/irq-mvebu-gicp.c
@@ -230,16 +230,16 @@ static int mvebu_gicp_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	inner_domain = irq_domain_create_hierarchy(parent_domain, 0,
-						   gicp->spi_cnt,
-						   of_node_to_fwnode(node),
-						   &gicp_domain_ops, gicp);
+	inner_domain = msi_create_parent_irq_domain(&(struct irq_domain_info){
+			.fwnode		= of_node_to_fwnode(node),
+			.ops		= &gicp_domain_ops,
+			.size		= gicp->spi_cnt,
+			.host_data	= gicp,
+			.parent		= parent_domain,
+		}, &gicp_msi_parent_ops);
 	if (!inner_domain)
 		return -ENOMEM;
 
-	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_GENERIC_MSI);
-	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
-	inner_domain->msi_parent_ops = &gicp_msi_parent_ops;
 	return 0;
 }
 
diff --git a/drivers/irqchip/irq-mvebu-odmi.c b/drivers/irqchip/irq-mvebu-odmi.c
index 306a7754e44f8..e6049f647a017 100644
--- a/drivers/irqchip/irq-mvebu-odmi.c
+++ b/drivers/irqchip/irq-mvebu-odmi.c
@@ -205,19 +205,17 @@ static int __init mvebu_odmi_init(struct device_node *node,
 
 	parent_domain = irq_find_host(parent);
 
-	inner_domain = irq_domain_create_hierarchy(parent_domain, 0,
-						   odmis_count * NODMIS_PER_FRAME,
-						   of_node_to_fwnode(node),
-						   &odmi_domain_ops, NULL);
+	inner_domain = msi_create_parent_irq_domain(&(struct irq_domain_info){
+			.fwnode		= of_node_to_fwnode(node),
+			.ops		= &odmi_domain_ops,
+			.size		= odmis_count * NODMIS_PER_FRAME,
+			.parent		= parent_domain,
+		}, &odmi_msi_parent_ops);
 	if (!inner_domain) {
 		ret = -ENOMEM;
 		goto err_unmap;
 	}
 
-	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_GENERIC_MSI);
-	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
-	inner_domain->msi_parent_ops = &odmi_msi_parent_ops;
-
 	return 0;
 
 err_unmap:
diff --git a/drivers/irqchip/irq-mvebu-sei.c b/drivers/irqchip/irq-mvebu-sei.c
index a962ef4977169..cacf88530e444 100644
--- a/drivers/irqchip/irq-mvebu-sei.c
+++ b/drivers/irqchip/irq-mvebu-sei.c
@@ -430,21 +430,19 @@ static int mvebu_sei_probe(struct platform_device *pdev)
 	irq_domain_update_bus_token(sei->ap_domain, DOMAIN_BUS_WIRED);
 
 	/* Create the 'MSI' domain */
-	sei->cp_domain = irq_domain_create_hierarchy(sei->sei_domain, 0,
-						     sei->caps->cp_range.size,
-						     of_node_to_fwnode(node),
-						     &mvebu_sei_cp_domain_ops,
-						     sei);
+	sei->cp_domain = msi_create_parent_irq_domain(&(struct irq_domain_info){
+			.fwnode		= of_node_to_fwnode(node),
+			.ops		= &mvebu_sei_cp_domain_ops,
+			.size		= sei->caps->cp_range.size,
+			.host_data	= sei,
+			.parent		= sei->sei_domain,
+		}, &sei_msi_parent_ops);
 	if (!sei->cp_domain) {
 		pr_err("Failed to create CPs IRQ domain\n");
 		ret = -ENOMEM;
 		goto remove_ap_domain;
 	}
 
-	irq_domain_update_bus_token(sei->cp_domain, DOMAIN_BUS_GENERIC_MSI);
-	sei->cp_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
-	sei->cp_domain->msi_parent_ops = &sei_msi_parent_ops;
-
 	mvebu_sei_reset(sei);
 
 	irq_set_chained_handler_and_data(parent_irq, mvebu_sei_handle_cascade_irq, sei);
-- 
2.39.2


