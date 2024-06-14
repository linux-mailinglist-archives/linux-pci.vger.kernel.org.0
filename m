Return-Path: <linux-pci+bounces-8807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 105AD9089D4
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 12:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E625281BA4
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 10:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9424C1946A5;
	Fri, 14 Jun 2024 10:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hLewYcJi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UZCm5SSc"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B33E195B21;
	Fri, 14 Jun 2024 10:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360726; cv=none; b=mLu1JFHVERLCqi9buENS6rddctlk6k6ajQHMEzqKuKDFvFbSmhQly8xfzN5FfGQEl5JOyamSznXkHUkvuclqqbUWxTU3MvvwkmJhBVqkoSKWwiA7GW4+/DaAG5udm/OilClvhezbVMf1/ZHJPAADjomOJCWaoEgGjZbW8B6h0/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360726; c=relaxed/simple;
	bh=Xajq4UsK70Vujz3qaEzh61ETJnQa6GsiINQgyoMqBKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E+JgtsRQSe9PKVACgV60XTAmdkZMuBpjNimbb3BnlIIi03QHza0EddIqFqEO2VWTyQ7LIuUMr76vHsj/yUpoWAPM4GMiylcdXD+dO97I8GzvYJ9DUkwtGYmVEK9clLz6wrNA913lQANjITzNvavKZzJVAX3okmjtBh+IxHEXl0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hLewYcJi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UZCm5SSc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718360723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PVKnDq5RP74qEIntN4x/BI6MJXtMmXAhy4Q5IiI19U0=;
	b=hLewYcJiU0KJRnfdmmxSgO2k9vnl6gYnmv0q/sbzuTfoNFCylqB0vPJ0KkIPDLiNnF37kx
	uaEM+gGrDMR13wdvtAETpNHRtTHXZ2Q+vjO8Ay0DNNOQ8l1DGJQHk0UCS4WC0hBlNxDhM0
	aWqda+reatvn4/C4Zpk3rqX8iSLtAUuOea9tHF2LQc3Da6pjOorIhKQdD0WC1XBjxerqUf
	FLA9+1P9edUzzYI8hRmvw1bwZbRntc2yCfejWGOuZqJGPFagarz+uTK9O0Jy/aEAkYIUZn
	qizsn5hwYio8QTXd0t9Xskl6ZHsWovsktLh6qitXcMnZdIa3erUGhK8eg9iHYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718360723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PVKnDq5RP74qEIntN4x/BI6MJXtMmXAhy4Q5IiI19U0=;
	b=UZCm5SSc3r/V98bpoVWD0fGR/2M1X6fAApHNeWw1e00My5x+1K4QJ0rwDWP6ynR7TFSnnW
	IOflkMmeVzAuxgCA==
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
Subject: [PATCH v3 08/24] irqchip/irq-msi-lib: Prepare for DEVICE MSI to replace platform MSI
Date: Fri, 14 Jun 2024 12:23:47 +0200
Message-Id: <20240614102403.13610-9-shivamurthy.shastri@linutronix.de>
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

Add the prerequisites for DEVICE MSI into the shared select() and child
domain init function. These domains are really trivial and just provide a
custom irq chip callback to write the MSI message.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
---
v3: adopted to IMS->MSI rename
---
 drivers/irqchip/irq-msi-lib.c | 13 +++++++++++++
 drivers/irqchip/irq-msi-lib.h |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index 0b359c5d8c6c..6aa4974d2d12 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -53,6 +53,19 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 		if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_PCI_MSI)))
 			return false;
 
+		break;
+	case DOMAIN_BUS_DEVICE_MSI:
+		/*
+		 * Per device MSI should never have any MSI feature bits
+		 * set. It's sole purpose is to create a dumb interrupt
+		 * chip which has a device specific irq_write_msi_msg()
+		 * callback.
+		 */
+		if (WARN_ON_ONCE(info->flags))
+			return false;
+
+		/* Core managed MSI descriptors */
+		info->flags = MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS | MSI_FLAG_FREE_MSI_DESCS;
 		break;
 	default:
 		/*
diff --git a/drivers/irqchip/irq-msi-lib.h b/drivers/irqchip/irq-msi-lib.h
index 525aa5284a99..681ceabb7bc7 100644
--- a/drivers/irqchip/irq-msi-lib.h
+++ b/drivers/irqchip/irq-msi-lib.h
@@ -15,6 +15,8 @@
 #define MATCH_PCI_MSI		(0)
 #endif
 
+#define MATCH_PLATFORM_MSI	BIT(DOMAIN_BUS_PLATFORM_MSI)
+
 int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
 			      enum irq_domain_bus_token bus_token);
 
-- 
2.34.1


