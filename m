Return-Path: <linux-pci+bounces-8805-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E9D9089CD
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 12:26:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52025B2A0CC
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 10:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7D1A195F28;
	Fri, 14 Jun 2024 10:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MGIQcmcx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VvbDJc/H"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F07195B21;
	Fri, 14 Jun 2024 10:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360721; cv=none; b=aaWbcK5/VslbSlsFMHDNlCJD5wLz2ltJ8aotInBS4G4j7Uglm3ldU8Xu0lbclIsKI/NQgB9yHGd3pzqLLiu2Mmsl5J+Osi4wtBbKLDFAQpJDIYaCGabKKQMmzBA4/cRl5+xcYH3pXfsOJKL9PaZt1tTjCwvyNGdU3wUhkCnv3C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360721; c=relaxed/simple;
	bh=VVyE2J8mEjfpFKgi+2wVYCGHx96Y+dCn6bhZztmIErM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KfhOLch38OEMe3BlH9UtlbLZMFr0yJ9FL6d0NJMQJu5mXEK9ldFpO99bnGl5zfaZKvughioZzPMwRrjh45UhB5v4JAHQY6sR+2sAma0qC01Q7HmlUHRJvYexicGeiJGQNaf7pKtK2+WJQUkiqi9MSKDgph+oQ1mwHodVYlF/wMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MGIQcmcx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VvbDJc/H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718360718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yikTSJu1poetWI4ECiHRreU60wKS8OeepPBXxI3d4d4=;
	b=MGIQcmcxZ0rfEOL3+Wbuv6rWLeI+IkHbRgAt8SmWjOpFBeC7eCmOOfr+MY0HrYhvbEeQGr
	qSXiXIX6elvE6UIS41eSqCYc0Z3lU/IPloK5/+Vng+aqojVuCFbMdvn8YPQbZAjg8E+UnB
	qPH+dCpISzJHo0G/qGuLNUTm9V9EPutV/XWwmbHIuBq2lXeyaifnpioIY4ZQlOZTgzL/q6
	aAF/MiRkrZ9f/YsGlDET1nldnlBTI29Derm8XB4IfS1tiWZ1YnCc/R/qygFgCoDnkr+IjI
	NIZKCALshoigVJ7jf0ILSctll/mztWNLN1Y+0yu/8QhZQ084ae70gepdQGq+rQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718360718;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yikTSJu1poetWI4ECiHRreU60wKS8OeepPBXxI3d4d4=;
	b=VvbDJc/HuaBSHK3ChIXMYo5r/ZQ36HBco0XgZFcuhZgdw2kMhglczLQ+0c4QIHWUkepK2f
	fEVpKnsx6s4HA5DA==
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
Subject: [PATCH v3 06/24] irqchip/irq-msi-lib: Prepare for PCI MSI/MSIX
Date: Fri, 14 Jun 2024 12:23:45 +0200
Message-Id: <20240614102403.13610-7-shivamurthy.shastri@linutronix.de>
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

Add the bus tokens for DOMAIN_BUS_PCI_DEVICE_MSI and
DOMAIN_BUS_PCI_DEVICE_MSIX to the common child init
function.

Provide the match mask which can be used by parent domain
implementation so the bitmask based child bus token match
works.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
---
v3: removed pci_device_msi_mask_unmask_parent_enable call as there is no
more global static key.
---
 drivers/irqchip/irq-msi-lib.c | 6 ++++++
 drivers/irqchip/irq-msi-lib.h | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index acbccf8f7f5b..0b359c5d8c6c 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -48,6 +48,12 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 
 	/* Is the target domain bus token supported? */
 	switch(info->bus_token) {
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
+		if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_PCI_MSI)))
+			return false;
+
+		break;
 	default:
 		/*
 		 * This should never be reached. See
diff --git a/drivers/irqchip/irq-msi-lib.h b/drivers/irqchip/irq-msi-lib.h
index f0706cc28264..525aa5284a99 100644
--- a/drivers/irqchip/irq-msi-lib.h
+++ b/drivers/irqchip/irq-msi-lib.h
@@ -9,6 +9,12 @@
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
 
+#ifdef CONFIG_PCI_MSI
+#define MATCH_PCI_MSI		BIT(DOMAIN_BUS_PCI_MSI)
+#else
+#define MATCH_PCI_MSI		(0)
+#endif
+
 int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
 			      enum irq_domain_bus_token bus_token);
 
-- 
2.34.1


