Return-Path: <linux-pci+bounces-9144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3C7B913C21
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 17:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1325C1C21AC6
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 15:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 368C318508E;
	Sun, 23 Jun 2024 15:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iFjqv6ru";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FSEaCE8W"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4B91849E6;
	Sun, 23 Jun 2024 15:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719155932; cv=none; b=lTexU+xqETPnXFL7/lBFTOg72u+bJI2TKCOTfpT6/K50ZHpBcGAaUK5tcn0P/TxB7ySnM2C5S0xKEL/YxPvChKBLIQHiHznD37EF+A978fPTWoNvw+zfLbUqCydKiVb4ev+//CzTk+bnPaHl/P7qu/it1c9oPpDmwfNCl7OsRkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719155932; c=relaxed/simple;
	bh=/HEuT2HxCGvBwMN6NF8neYIIggUALfyp3iRvKu+M+Jw=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=JD5a1AdIg48gnnXCHcUVJ9jB2Gi/KMwXe/n/WHq6t+q+oTSLqctSHrikv8U580W3cwTN7/bKJ2FFi3ggGTByuHDFAYWz5Si1PBqDnPhc5oMoXJBklnObk9eh478qeDAOr2WFL5YU/1qF4GTI4mO7tfRX7BSJXcJopaNZOt3WZDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iFjqv6ru; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FSEaCE8W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240623142235.333333826@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719155928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Jc52rBCJlbR4TIodyraHL4HXxXYh7cjRCGSo8H0yxQ8=;
	b=iFjqv6ru/g5fAUD6w82j1a17IeW1X+flQLjom/SHBVjEEO181pYfOkeUE3Nb9Y/pvc8AvR
	ndDpJGe9rlx69swCcTXjXY060KSrjaPxL+RcRzPOxZogZD4BcVwy1iRk5fVCTbKYsBlZW5
	lWbTs/KtBQgjoUSjA0BO9YwtRWx3ZLz+1WhzbZz03Gpplu11GMMmhFvqNwiOrgd/XipBaZ
	vKWTBJxczzBQSjfNAmDTnv5foNCDQGRFf+60/MtmnY/bTXp8JFrJNSMxEWM4h3Mvyu5HtG
	Msvbqn0EYHoLtpMuT+GppsZ3zwZ0AEyhFz7A7iK07jXX5WQfuk855WWFSVb+qQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719155928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=Jc52rBCJlbR4TIodyraHL4HXxXYh7cjRCGSo8H0yxQ8=;
	b=FSEaCE8WTolOJOgA48mMuw2d4DIz9sQBBNJ4ptb+8J33jY0qvmkHngZGwqlXHeQ2YtwC14
	UKn+zyr6ztCPILCg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
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
Subject: [patch V4 10/21] irqchip/mbigen: Remove
 platform_msi_create_device_domain() fallback
References: <20240623142137.448898081@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 Jun 2024 17:18:48 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

Now that ITS provides the MSI parent domain, remove the unused fallback
code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
 drivers/irqchip/irq-mbigen.c | 74 ++----------------------------------
 1 file changed, 4 insertions(+), 70 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index db0fa80330d9..093fd42893a7 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -180,64 +180,6 @@ static int mbigen_domain_translate(struct irq_domain *d, struct irq_fwspec *fwsp
 	return -EINVAL;
 }
 
-/* The following section will go away once ITS provides a MSI parent */
-
-static struct irq_chip mbigen_irq_chip = {
-	.name =			"mbigen-v2",
-	.irq_mask =		irq_chip_mask_parent,
-	.irq_unmask =		irq_chip_unmask_parent,
-	.irq_eoi =		mbigen_eoi_irq,
-	.irq_set_type =		mbigen_set_type,
-	.irq_set_affinity =	irq_chip_set_affinity_parent,
-};
-
-static int mbigen_irq_domain_alloc(struct irq_domain *domain,
-					unsigned int virq,
-					unsigned int nr_irqs,
-					void *args)
-{
-	struct irq_fwspec *fwspec = args;
-	irq_hw_number_t hwirq;
-	unsigned int type;
-	struct mbigen_device *mgn_chip;
-	int i, err;
-
-	err = mbigen_domain_translate(domain, fwspec, &hwirq, &type);
-	if (err)
-		return err;
-
-	err = platform_msi_device_domain_alloc(domain, virq, nr_irqs);
-	if (err)
-		return err;
-
-	mgn_chip = platform_msi_get_host_data(domain);
-
-	for (i = 0; i < nr_irqs; i++)
-		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
-				      &mbigen_irq_chip, mgn_chip->base);
-
-	return 0;
-}
-
-static void mbigen_irq_domain_free(struct irq_domain *domain, unsigned int virq,
-				   unsigned int nr_irqs)
-{
-	platform_msi_device_domain_free(domain, virq, nr_irqs);
-}
-
-static const struct irq_domain_ops mbigen_domain_ops = {
-	.translate	= mbigen_domain_translate,
-	.alloc		= mbigen_irq_domain_alloc,
-	.free		= mbigen_irq_domain_free,
-};
-
-static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
-{
-	mbigen_write_msi_msg(irq_get_irq_data(desc->irq), msg);
-}
-
-/* End of to be removed section */
-
 static void mbigen_domain_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
 {
 	arg->desc = desc;
@@ -268,20 +210,12 @@ static const struct msi_domain_template mbigen_msi_template = {
 static bool mbigen_create_device_domain(struct device *dev, unsigned int size,
 					struct mbigen_device *mgn_chip)
 {
-	struct irq_domain *domain = dev->msi.domain;
-
-	if (WARN_ON_ONCE(!domain))
+	if (WARN_ON_ONCE(!dev->msi.domain))
 		return false;
 
-	if (irq_domain_is_msi_parent(domain)) {
-		return msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN,
-						    &mbigen_msi_template, size,
-						    NULL, mgn_chip->base);
-	}
-
-	/* Remove once ITS provides MSI parent */
-	return !!platform_msi_create_device_domain(dev, size, mbigen_write_msg,
-						   &mbigen_domain_ops, mgn_chip);
+	return msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN,
+					    &mbigen_msi_template, size,
+					    NULL, mgn_chip->base);
 }
 
 static int mbigen_of_create_domain(struct platform_device *pdev,
-- 
2.34.1



