Return-Path: <linux-pci+bounces-8823-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7BB9089EC
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 12:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A214E1C20D68
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 10:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7037719EEBF;
	Fri, 14 Jun 2024 10:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yFky7UdK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wwHrV34f"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA5919EEA5;
	Fri, 14 Jun 2024 10:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360770; cv=none; b=fyNhSUiHi26PrTEX6EGLi4zxUG+zPL6/AAMSdY6xOj7PRp2CDQbUmHuS9XeiK+9S76a55W5ZA7CtTTpUVMFPx4zatV0AbrPjrJHJwrhdCSQiXmmiQgWPdWz9l6WZjJqMUlFHH/b7C8cS+577vcLxODXH+5wj2jt5qvozxrXvprc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360770; c=relaxed/simple;
	bh=MVrQ8vFdz8KrvafTvYlWpAfOt5noLfh4IiMY+gu30rU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eZaQCEGv2oOEvGVySkDLMr39oE1+enOJHb9dgyOv6LGGSVIcf3wxV0CQxqAbDTYiJY7NkblGBhWvLeUaJaZg0BHPaKBLJzVakx5zSjIkLDw2vIsKTSUjwskcUu4amcCX5hFDE4PSDGtaWFuA6zSeqnv3jeRv+RlIbCJQ9fHb1kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yFky7UdK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wwHrV34f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718360767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jlwM44KfJXXmlV7qBcE4B5AolBhhXAHiWfp6+tG6k2s=;
	b=yFky7UdK80kPkSR6wKGxyMPcFUqoBR1IS9mdGWRjedZ7oolxeYHEGjUWQlIvoRaVjbUu8Q
	wXnKeKAxcML+atLg97NYOrCg9bjy8xDqDpVcuiFz/AhewedM4cQC8sHiBg46haf6s7MPUG
	QImTb0fguZe2/mE6NyAI1bhKHorAJg7OIT7YN5Y32OjobsmJ6PDnbpc5fJ1XiSkHlNoXFX
	p+RWD8zf4GPb/qMshEmT0owo5/QXIgnPvaxZy7BvDHotXFEHoir0rmmPe0Ys7m31JhnuuA
	xMioKJQlk+C1gsB76lOVh0YSt5C6U5q6TvW+hJc4z7/MseZpp1+Tw4SOA5HzRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718360767;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jlwM44KfJXXmlV7qBcE4B5AolBhhXAHiWfp6+tG6k2s=;
	b=wwHrV34fukJ+/cxgP5f7ZnVp0W9y1680sBEiZIvyW4ug/H3TguDVwJtkczi+UXw+t1aWJy
	dDKS54YQ8vFuZ7Dw==
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
Subject: [PATCH v3 24/24] genirq/msi: Move msi_device_data to core
Date: Fri, 14 Jun 2024 12:24:03 +0200
Message-Id: <20240614102403.13610-25-shivamurthy.shastri@linutronix.de>
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

Now that the platform MSI hack is gone, nothing needs to know about struct
msi_device_data outside of the core code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
---
v3: fixed warning by kernel test robot
warning: cannot understand function prototype: 'struct msi_device_data '
---
 include/linux/msi.h | 18 ------------------
 kernel/irq/msi.c    | 20 ++++++++++++++++++--
 2 files changed, 18 insertions(+), 20 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 4c3462a6a97b..369367ecae5e 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -21,11 +21,7 @@
 #include <linux/irqdomain_defs.h>
 #include <linux/cpumask.h>
 #include <linux/msi_api.h>
-#include <linux/xarray.h>
-#include <linux/mutex.h>
-#include <linux/list.h>
 #include <linux/irq.h>
-#include <linux/bits.h>
 
 #include <asm/msi.h>
 
@@ -227,20 +223,6 @@ struct msi_dev_domain {
 	struct irq_domain	*domain;
 };
 
-/**
- * msi_device_data - MSI per device data
- * @properties:		MSI properties which are interesting to drivers
- * @mutex:		Mutex protecting the MSI descriptor store
- * @__domains:		Internal data for per device MSI domains
- * @__iter_idx:		Index to search the next entry for iterators
- */
-struct msi_device_data {
-	unsigned long			properties;
-	struct mutex			mutex;
-	struct msi_dev_domain		__domains[MSI_MAX_DEVICE_IRQDOMAINS];
-	unsigned long			__iter_idx;
-};
-
 int msi_setup_device_data(struct device *dev);
 
 void msi_lock_descs(struct device *dev);
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 8314b1d4a903..5fa0547ece0c 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -8,17 +8,33 @@
  * This file contains common code to support Message Signaled Interrupts for
  * PCI compatible and non PCI compatible devices.
  */
-#include <linux/types.h>
 #include <linux/device.h>
 #include <linux/irq.h>
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
 #include <linux/slab.h>
 #include <linux/sysfs.h>
-#include <linux/pci.h>
+#include <linux/types.h>
+#include <linux/xarray.h>
 
 #include "internals.h"
 
+/**
+ * struct msi_device_data - MSI per device data
+ * @properties:		MSI properties which are interesting to drivers
+ * @mutex:		Mutex protecting the MSI descriptor store
+ * @__domains:		Internal data for per device MSI domains
+ * @__iter_idx:		Index to search the next entry for iterators
+ */
+struct msi_device_data {
+	unsigned long			properties;
+	struct mutex			mutex;
+	struct msi_dev_domain		__domains[MSI_MAX_DEVICE_IRQDOMAINS];
+	unsigned long			__iter_idx;
+};
+
 /**
  * struct msi_ctrl - MSI internal management control structure
  * @domid:	ID of the domain on which management operations should be done
-- 
2.34.1


