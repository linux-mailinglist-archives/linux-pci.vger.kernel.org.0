Return-Path: <linux-pci+bounces-17652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDA79E3A45
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 13:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48C201687D9
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 12:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF4C71BAEFD;
	Wed,  4 Dec 2024 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CULY6W2h"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1CC1E00BE;
	Wed,  4 Dec 2024 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316369; cv=none; b=Oz2cg2uB/UWAbP4iJYZk4fKZ4iIPJrUDlmhWLGBlxxC6mcz9c8pd5IVxvbluq/qLI3o1WY7WISBP49m4ipJC3TVJm4ysQ1LMBruzQBB6sLZ+VVyEb3pbMtga+3js/++2XSb0YG5z1qPR3FXknW/IK6LqctPXFG8gyo0VjYubQSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316369; c=relaxed/simple;
	bh=jTOd4yz8gsuLBweIwiSBdwKwzbJR5VQQ29Mpm+esKEo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fdeNnZAXg6CcRuwD9OkHMkPhVgNQY14HNN3MZLcDzHppfmXMkNlTqlnROW18dbsIRPjYV0mW5fexgvppowgTpjKyFBruRkNjKd+nJYI38u/Kh02x7/5QSw6QUIOyhFzk1DmXGNUfvC19mhw65dgTwCHHll0FnbJa4kQgJuSEers=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CULY6W2h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35A20C4CED1;
	Wed,  4 Dec 2024 12:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733316369;
	bh=jTOd4yz8gsuLBweIwiSBdwKwzbJR5VQQ29Mpm+esKEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CULY6W2hnlcApn+/5dZASAOALgPuZhsI6jjUFBPT/KJ4ZfGZ8cg2cY0v2WPWXw6nj
	 UEqSb8sUxBAWecBR7EgPWt8x6JmNdKSKaJ482+PLQOIbe6e6zESQlFhbfh7CNVGVvK
	 sEgJAGLobF58pVXznkLg/CSHhKgTYqLHVRs297eOuTbEbhnl5rRYTHyTwLA7bCo8W2
	 08KIz3JsqETuv5CRfMHuLcVVYQujMbTCjqTnxFqwH7Aza2uyvJFK3v3LpYL7d5jPq8
	 kjrDyCmIO55v8pnz+xj/oPioY43885lOvqe/shfmGGL7/wUwpDCB/tsrnxjic4aflv
	 Ll+SNoL+RA3wQ==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tIolb-000RHy-BS;
	Wed, 04 Dec 2024 12:46:07 +0000
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
Subject: [PATCH 09/11] iommu/intel: Convert to msi_create_parent_irq_domain() helper
Date: Wed,  4 Dec 2024 12:45:47 +0000
Message-Id: <20241204124549.607054-10-maz@kernel.org>
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
switch the Intel IOMMU remapping over to that.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/iommu/intel/irq_remapping.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 466c1412dd456..7ca3ee4c985c9 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -557,21 +557,16 @@ static int intel_setup_irq_remapping(struct intel_iommu *iommu)
 	if (!fn)
 		goto out_free_bitmap;
 
-	iommu->ir_domain =
-		irq_domain_create_hierarchy(arch_get_ir_parent_domain(),
-					    0, INTR_REMAP_TABLE_ENTRIES,
-					    fn, &intel_ir_domain_ops,
-					    iommu);
+	iommu->ir_domain = msi_create_parent_irq_domain(fn, &dmar_msi_parent_ops,
+							&intel_ir_domain_ops,
+							IRQ_DOMAIN_FLAG_ISOLATED_MSI,
+							INTR_REMAP_TABLE_ENTRIES,
+							iommu, arch_get_ir_parent_domain());
 	if (!iommu->ir_domain) {
 		pr_err("IR%d: failed to allocate irqdomain\n", iommu->seq_id);
 		goto out_free_fwnode;
 	}
 
-	irq_domain_update_bus_token(iommu->ir_domain,  DOMAIN_BUS_DMAR);
-	iommu->ir_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT |
-				   IRQ_DOMAIN_FLAG_ISOLATED_MSI;
-	iommu->ir_domain->msi_parent_ops = &dmar_msi_parent_ops;
-
 	ir_table->base = ir_table_base;
 	ir_table->bitmap = bitmap;
 	iommu->ir_table = ir_table;
@@ -1522,6 +1517,7 @@ static const struct irq_domain_ops intel_ir_domain_ops = {
 
 static const struct msi_parent_ops dmar_msi_parent_ops = {
 	.supported_flags	= X86_VECTOR_MSI_FLAGS_SUPPORTED | MSI_FLAG_MULTI_PCI_MSI,
+	.bus_token		= DOMAIN_BUS_DMAR,
 	.prefix			= "IR-",
 	.init_dev_msi_info	= msi_parent_init_dev_msi_info,
 };
-- 
2.39.2


