Return-Path: <linux-pci+bounces-8813-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3723A908A03
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 12:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BFDFB2A965
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 10:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE0A1946C8;
	Fri, 14 Jun 2024 10:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0VcQKRsa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q/ujLmtV"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797871946C4;
	Fri, 14 Jun 2024 10:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360746; cv=none; b=Vv37k0vH3FRQpo/qi/jQdZbqtJw2tk+gY0NCj0Z9wxXa+c/Ez7qw5c+FixhdjS1y5TsyEF1el0++vqE/huntf72lUo2Q6hf8lzTMVXip1koeBI2UYcy/v0mta206Mhl/QfOzk+Ji1lBwlUQM3I4OnjZd6HuBbctvJbPSjy5S7cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360746; c=relaxed/simple;
	bh=ynXlB8OVlVAjLts3TSJguH/McbJys5RSK8YmKlRdBhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WprvSiiHciWp4dIrJ+A8vf44VNQLfX9hooMscVUE7j3j2b2dhnazYWa1M63SLRfcfxrHcabKrHbaZ/7PVw1iI0sWk4fZjvNWFmp2uIteKlmpLeT9pFZGHRileKXZZPpHyLTE4OirLIvbRYg+VhwMhg6/J4bDntB0Fe4fbxNtVDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0VcQKRsa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q/ujLmtV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718360743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+1NN8XVT31CYCXb+vZoMNRf75ND/htb0i/ZeSUfcTBY=;
	b=0VcQKRsavDoYftiUfCtYhjdtvMAonSrJ1ZAKYh98VS6FOVkcI0COj4uyknF3KpsIC5sr66
	R+P/9jl/uQ2fyP9To9CNZRqxCQ2P+N9R57KVcq0BmzLWRmE+drQGfddWiXyOWyPdImQD2u
	A0Pi4yA/LP/5BxZxNLlE1NZNYpM78aJnGFQE9VRbmVe814Y7PnAzVBYurS82mOIEqg3wn7
	HxkqHu9FQ3gp4DqUPhPlgo4+YheQXPiEwDptOsw1zFE+EZa9WU6IOyH9tS/LcX9V96rBVF
	qbDMwYB0sh9kmx7ySYqOGihC9E3Olc76xtzQ4cUY+GSJUxKCLqcKeVVQ8xozyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718360743;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+1NN8XVT31CYCXb+vZoMNRf75ND/htb0i/ZeSUfcTBY=;
	b=Q/ujLmtVIFjwC2SVpaNj/lD+gOK1mv7MdWczW+i5gp1oE+2HZfgyV/Aed+CcCPxNb66OOU
	l2lrEkJNxpQvGLDQ==
To: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	maz@kernel.org,
	tglx@linutronix.de,
	anna-maria@linutronix.de,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com,
	bhelgaas@google.com,
	rdunlap@infradead.org,
	vidyas@nvidia.com,
	ilpo.jarvinen@linux.intel.com,
	apatel@ventanamicro.com,
	kevin.tian@intel.com,
	nipun.gupta@amd.com,
	den@valinux.co.jp,
	andrew@lunn.ch,
	gregory.clement@bootlin.com,
	sebastian.hesselbarth@gmail.com,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	alex.williamson@redhat.com,
	will@kernel.org,
	lorenzo.pieralisi@arm.com,
	jgg@mellanox.com,
	ammarfaizi2@gnuweeb.org,
	robin.murphy@arm.com,
	lpieralisi@kernel.org,
	nm@ti.com,
	kristo@kernel.org,
	vkoul@kernel.org,
	okaya@kernel.org,
	agross@kernel.org,
	andersson@kernel.org,
	mark.rutland@arm.com,
	shameerali.kolothum.thodi@huawei.com,
	yuzenghui@huawei.com,
	shivamurthy.shastri@linutronix.de
Subject: [PATCH v3 14/24] genirq/gic-v3-mbi: Remove unused wired MSI mechanics
Date: Fri, 14 Jun 2024 12:23:53 +0200
Message-Id: <20240614102403.13610-15-shivamurthy.shastri@linutronix.de>
In-Reply-To: <20240614102403.13610-1-shivamurthy.shastri@linutronix.de>
References: <20240614102403.13610-1-shivamurthy.shastri@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

Nothing builds a platform_device MSI domain for wire to MSI on top of
this. The "regular" users of the platform MSI domain just provide their own
irq_write_msi_msg() callback.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-mbi.c | 17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index dbb8b1efda44..19298cc6c2ee 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -199,31 +199,16 @@ static int mbi_allocate_pci_domain(struct irq_domain *nexus_domain,
 }
 #endif
 
-static void mbi_compose_mbi_msg(struct irq_data *data, struct msi_msg *msg)
-{
-	mbi_compose_msi_msg(data, msg);
-
-	msg[1].address_hi = upper_32_bits(mbi_phys_base + GICD_CLRSPI_NSR);
-	msg[1].address_lo = lower_32_bits(mbi_phys_base + GICD_CLRSPI_NSR);
-	msg[1].data = data->parent_data->hwirq;
-
-	iommu_dma_compose_msi_msg(irq_data_get_msi_desc(data), &msg[1]);
-}
-
 /* Platform-MSI specific irqchip */
 static struct irq_chip mbi_pmsi_irq_chip = {
 	.name			= "pMSI",
-	.irq_set_type		= irq_chip_set_type_parent,
-	.irq_compose_msi_msg	= mbi_compose_mbi_msg,
-	.flags			= IRQCHIP_SUPPORTS_LEVEL_MSI,
 };
 
 static struct msi_domain_ops mbi_pmsi_ops = {
 };
 
 static struct msi_domain_info mbi_pmsi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_LEVEL_CAPABLE),
+	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS),
 	.ops	= &mbi_pmsi_ops,
 	.chip	= &mbi_pmsi_irq_chip,
 };
-- 
2.34.1


