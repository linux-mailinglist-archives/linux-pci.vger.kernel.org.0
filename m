Return-Path: <linux-pci+bounces-9140-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1CD913C18
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 17:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 549C21F22389
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 15:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB111836D6;
	Sun, 23 Jun 2024 15:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w4P1ryoC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XV7yoRW0"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60501183098;
	Sun, 23 Jun 2024 15:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719155924; cv=none; b=mIIsJ6ioc2AXKk8yiB3Tdo4tvzgdrCBeyeywi8ZTAi9phW1VNVKCx+FQQ4mqUJwpZpDKuCDasJoC+WagoilmwDowJk4Fz9L/4i5OmIpfapWoHK+svvG4j4G54huzY+pU2rB+3d1rKHaElIZqvFVBJ+jm4UUNyOp00dbDHPUrfRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719155924; c=relaxed/simple;
	bh=VCs9vR9L8tS7ORBRzwiSYaxudXZ+PIxX58zWdWLOBYM=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=FLJca5vyFGsjeH5A2A8hqV/mHX8XOfu5Caq+Fe7guQktJPpIUXk0/LeDayp+4DhhIw3Bw3KWtHYRyIhWTeRBVagKYsKYN+PIlA/w8ZLTZJ86GvPi9z07yhBK+wOd6u8BMGmOvLFDEPs0F9wR4H8ltCyERvqtD4VQXCcsKsNqs/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w4P1ryoC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XV7yoRW0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240623142235.085171290@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719155922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=wOD2YiEHXUX3rjbStHAS9fZ4qSSYi9Sy24lwqsYMXSI=;
	b=w4P1ryoCPe7Q0vPyNq3b3D3rxQoHW47u5SWLJXB4IuiWzwaCrx+f6LEQ/PSRSlyuuehGtj
	SYM7fABLqak97rBm1zBPXHZIfaC3USyOXDeJXvXiO60f556b2PmGXB2IerD41uDPS5oO5g
	bp9+IOU6pynayJ9jkimvm8AvFJcsli/tjsgcPHO6qLX42FWtnJf0yeX+CSYUOM9umq8NHD
	SDSROpUx+rGcXx2VGmKOflqwMdROeEbHXVR9yCyymogYvakg06Z7663mUqP4EeHW2QukBM
	GMbU7pQb/asQao5wLCYrSfFvl/NlUDEzo5jZvsaOVQlrewgS5YFgqx5dT3SfPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719155922;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=wOD2YiEHXUX3rjbStHAS9fZ4qSSYi9Sy24lwqsYMXSI=;
	b=XV7yoRW07udk/Xc1M87gDRZTwGup7rBFh60azUzARAmDpCrnXPgQK9oNcKGb8uGvyHgtYZ
	LQKfCC4WXTEORuBg==
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
Subject: [patch V4 06/21] irqchip/irq-msi-lib: Prepare for DEVICE MSI to
 replace platform MSI
References: <20240623142137.448898081@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 Jun 2024 17:18:41 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

Add the prerequisites for DEVICE MSI into the shared select() and child
domain init function. These domains are really trivial and just provide a
custom irq chip callback to write the MSI message.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


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




