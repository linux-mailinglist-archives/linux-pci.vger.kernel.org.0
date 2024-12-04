Return-Path: <linux-pci+bounces-17650-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23AE59E3A55
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 13:50:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 62C33B2FAC3
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 12:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735DF1BAED6;
	Wed,  4 Dec 2024 12:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgS00sP6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AC6F1DE4E1;
	Wed,  4 Dec 2024 12:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733316369; cv=none; b=shnoBcN8+ikFUP/RaNIMgQ3y52mTc84TxT45HvGXQICkC2WWDRDRIVk3ZpBJ6QlWJuUdMwUb8Wz5C6ldoFMjjtXOlKtb36nSHc6EkILCH5Hw9r/E8Ies+OIh5/dT2RNb7PUpzOOzE3Noq8WihrWy0vJFf/Tk5f7m+Q5AD4LrdSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733316369; c=relaxed/simple;
	bh=dzDLJ7+3sOK1+LLKU8zZ5pSubkCmnjrUQs+PsTqG8a8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gW+rvc+sWdKQ8cBHNpDTikKic+5Vg7Lm1engM5LJNzKga2L2XTftuTC/CxjNPrNuRSxYH/Nh/tpdqLJ2UT5Ie/PhdoGik/WvT5OKlX2bMDCaPKyeUaW6MH5uO12Jfs6TLpYjSjII2b2jw8V/hwXFi6/e1qqiFlbxrbH4iYVJc4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgS00sP6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98BA8C4CEE6;
	Wed,  4 Dec 2024 12:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733316368;
	bh=dzDLJ7+3sOK1+LLKU8zZ5pSubkCmnjrUQs+PsTqG8a8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LgS00sP6aZb9lBTEEMSsEXriSrvPibb7kwIbC2uh2yLKZ+ks+/sPakVinph2cf7yg
	 ArtIt0FeWQmZnN4owZpv2/0sOv83fqNgBRU7l0dnCLxZC6XhG1FMqjUINjPo8SY4Ie
	 QR5q83jiV6vll5jFqLjiTDnBLZMdlLQErFe39jn0M7Npu9kJb5nH5z4w1wR1ktJ16K
	 3GVn/83z+VygVRn7F6AEozLe3O2QGnZ8drfhoHNquC5AXDWNPtoyTgMEArlHb0E3m/
	 dof5S7+cu6eddgOhQC/fTIrwq79kUAiOgLg4LLID7Ip8W4vOk6zsDC0Z/ifx5R+WeD
	 H2DEN6HIN+icw==
Received: from sofa.misterjones.org ([185.219.108.64] helo=valley-girl.lan)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <maz@kernel.org>)
	id 1tIola-000RHy-HV;
	Wed, 04 Dec 2024 12:46:06 +0000
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
Subject: [PATCH 07/11] irqchip/loongson-pch-msi: Convert to msi_create_parent_irq_domain() helper
Date: Wed,  4 Dec 2024 12:45:45 +0000
Message-Id: <20241204124549.607054-8-maz@kernel.org>
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
switch the Loongson MSI stuff over to that.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-loongson-pch-msi.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index 3f6f4e9887c53..f15528f76a647 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -158,20 +158,15 @@ static int pch_msi_init_domains(struct pch_msi_data *priv,
 {
 	struct irq_domain *middle_domain;
 
-	middle_domain = irq_domain_create_hierarchy(parent, 0, priv->num_irqs,
-						    domain_handle,
-						    &pch_msi_middle_domain_ops,
-						    priv);
+	middle_domain = msi_create_parent_irq_domain(domain_handle,
+						     &pch_msi_parent_ops,
+						     &pch_msi_middle_domain_ops, 0,
+						     priv->num_irqs, priv, parent);
 	if (!middle_domain) {
 		pr_err("Failed to create the MSI middle domain\n");
 		return -ENOMEM;
 	}
 
-	irq_domain_update_bus_token(middle_domain, DOMAIN_BUS_NEXUS);
-
-	middle_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
-	middle_domain->msi_parent_ops = &pch_msi_parent_ops;
-
 	return 0;
 }
 
-- 
2.39.2


