Return-Path: <linux-pci+bounces-8801-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD30F9089BB
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 12:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64E9B28E60A
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 10:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 434D11946C8;
	Fri, 14 Jun 2024 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HWaJea/q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WgPdQ1BR"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DC41946B4;
	Fri, 14 Jun 2024 10:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360714; cv=none; b=fE1H/ehaGL6UPzAVHpFe6LEa0MXAhqQ7BBAVdjVYgc4mQ+S+Gr4NDNprA8QM58DG1XrdzvDc8bVDCZjTFR7TMDvaY7VARDjTOTgDowy1n+8v/dtvJgO73I1jdBLYkLlPojZHxaKDWxRVABcOxfc+WALu59PIORaohjXdZLH5vvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360714; c=relaxed/simple;
	bh=W4EHkQD/USQATfgAfK9XuJ+B8ic1I64zYCHIU2VwG90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BRpjghNu3kA34blWxNmUHWziXUr2h0qqJn4ulgWivXu7ffokEd2cD9fMBYrhAOIj7id/Gkpf5y93lywjewtU5zsovTyTibnZEOtoWihmEKEkfkxTDMC9OrUhppIDnx9TEv4E8pqUwrmeLejzNoYM/nd50IeO16tSz0tjAqIEptE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HWaJea/q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WgPdQ1BR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718360711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x17rwrYa1OepBTAXh2DUI1Oi6J6o2V2XZPp4nnmwS1U=;
	b=HWaJea/qi3XM1IsopjiIUF8iSkcCQl1cy9k8ic87/UIugpshTUsnScvE9PTDEP2MhYr68r
	MkqDgC2fZYC0UVmWPZVYvUbVlZNFrbf4FgzDY0VU3E6uXolZhkJFakTmCbE+xRz7Rhabj9
	5Bgv/ELoc5X4x39WoaagIhTOOtIc74bU1jCHeHbPYuvUF08iJ6l2En6ugVhX5uBenO6KGY
	IntRug3Y/tYnOt+S/xkiwIgqX6QvBUWNq4eHb0GRNPE9ZQlJv6yaK6OjsKeOYf+Kuup2EC
	Gflb1iSNmlYX53I44q6nC/sods6cAhgwgB1DsqE7TBhxVOuRreg/f13HXV/OXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718360711;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x17rwrYa1OepBTAXh2DUI1Oi6J6o2V2XZPp4nnmwS1U=;
	b=WgPdQ1BRb6cgkEhbTEH5udxg0DvnaUaWiLqGBhuPmMG59lf0OO2ok5HrGzs74cj5J+9PNY
	ZbmTcFNWPSOIYZDw==
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
Subject: [PATCH v3 02/24] irqchip/imx-mu-msi: Fix codingstyle in imx_mu_msi_domains_init()
Date: Fri, 14 Jun 2024 12:23:41 +0200
Message-Id: <20240614102403.13610-3-shivamurthy.shastri@linutronix.de>
In-Reply-To: <20240614102403.13610-1-shivamurthy.shastri@linutronix.de>
References: <20240614102403.13610-1-shivamurthy.shastri@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna-Maria Behnsen <anna-maria@linutronix.de>

Fixes the coding style of irq_domain_create_linear() call within
imx_mu_msi_domains_init() for better code readability.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
---
 drivers/irqchip/irq-imx-mu-msi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-imx-mu-msi.c b/drivers/irqchip/irq-imx-mu-msi.c
index 90d41c1407ac..1dceda044db9 100644
--- a/drivers/irqchip/irq-imx-mu-msi.c
+++ b/drivers/irqchip/irq-imx-mu-msi.c
@@ -222,10 +222,8 @@ static int imx_mu_msi_domains_init(struct imx_mu_msi *msi_data, struct device *d
 	struct irq_domain *parent;
 
 	/* Initialize MSI domain parent */
-	parent = irq_domain_create_linear(fwnodes,
-					    IMX_MU_CHANS,
-					    &imx_mu_msi_domain_ops,
-					    msi_data);
+	parent = irq_domain_create_linear(fwnodes, IMX_MU_CHANS,
+					  &imx_mu_msi_domain_ops, msi_data);
 	if (!parent) {
 		dev_err(dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
-- 
2.34.1


