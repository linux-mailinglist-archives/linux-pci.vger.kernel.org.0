Return-Path: <linux-pci+bounces-9155-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA15913C37
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 17:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B3A11C215D6
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 15:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD900183061;
	Sun, 23 Jun 2024 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P2WoZlu3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="siYTR3zw"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3621822FD;
	Sun, 23 Jun 2024 15:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719155950; cv=none; b=abfmhzGdXIjXSDIUdT9KzSuSGFYoFzszmvj6pZaxNLy0v7VqgIOgPrHDvJq7YAmolkZAik1KgvAEHM0M1lSsNDfToJRe1yhrGy2Uzz5h9IXwDI8M4BiXm2rkOZoOqkL3pFnr97mMnyd7/mkFio1+aERqFcj69SM6f/YTghisfUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719155950; c=relaxed/simple;
	bh=VGrBc7l8mSLl0fAYINb1JI/g7yEQ4ovT6Fbyz03Bsuo=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=jkCfkbIsFz+yJMk+OawI0DwU/VFjablFqlgMfS+ZiccIjF9z5iFwGWyATMLfhnmPbwKKlhhVO6Cq3cFZ7/F4rf3VFS1YA6F6Q+zeyU5Vr9uC28o1zRBFyJGsFy2wYQ2WRE8m9iftD4n/8BPSEnEpKEuR1cwndpjb3ktIiQ7RpDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P2WoZlu3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=siYTR3zw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240623142236.003295177@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719155947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ayz7/gapo7J2KsRn3pIvCx1gxgs6k+vCGWQXeJ/y15w=;
	b=P2WoZlu3h/zBcEdVYrNc5xi4sNCYI+hCGzWB0vRZ9NigE4zon4nR7IspWgGnP2lhwte6/f
	vJk08K1OimEUrncEhrXNSMzAQk2WQR+DVjSx4UlE8cVEoOlmlGXYr6Z0oyiEa7sVyYguN3
	8+GcaaHhgrxCEhQiYQea+dL23HasZfJn4x0ZCtdeK/TPmSTdzqbhB3Itha7wKTDwla11xd
	kOPGj5zY5M2d2AqXM7xsePY8IHjaEud1uIrasRC0/HQcpKesvzyIfzBZM2Qh8ZoShCuP6V
	FaK6qr/1YkKLkZ8teiAlI2DJQOkvPyYgPtYr0YBlKeF1x+0p6NCV+6BZ1f1gKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719155947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ayz7/gapo7J2KsRn3pIvCx1gxgs6k+vCGWQXeJ/y15w=;
	b=siYTR3zwA6ww5leVHOjIeXB6U+VYY+4n8khlgdrNC83FSu16TuOuY78u/5Smnss4vzBHwh
	ZIzCInAUMp3H2JCg==
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
Subject: [patch V4 21/21] genirq/msi: Move msi_device_data to core
References: <20240623142137.448898081@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 Jun 2024 17:19:07 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

Now that the platform MSI hack is gone, nothing needs to know about struct
msi_device_data outside of the core code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


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




