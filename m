Return-Path: <linux-pci+bounces-33002-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79BEB13656
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 10:25:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5BAA7A3B8A
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 08:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19BA0237A4F;
	Mon, 28 Jul 2025 08:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srjVlvxl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9EA2367D5;
	Mon, 28 Jul 2025 08:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753691089; cv=none; b=jjf90Wpl+LO8dC2AT+rnopu8f/c6sz21VGQmaH/xvjup7DPOK5gGgKKlRiGyDwunf+5KfiXls+ht17hJ04MAKHZzUq42iP5MMH/jPtO0rBG3GvRKYLwEEiDGwUI6rwF6G807tS3MnegUpjTR7ek2qbGhLSGhqBnTVGoPEpV4Hr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753691089; c=relaxed/simple;
	bh=DDHEw2l9COqoOnSii06vLrGixN7NrFhwB0y2CTTbV2w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y4FfA0fFHdXaOugoaL3dUD8HEKUVDr9tBn8UL0v9MlBGPlJzNvXsuvBR0ieVrf3Jw9CikRGpgXUO6nWkNNftym23uOPCbOG3f40vYdfWMIJ4QgnJxZ7qvbSoJQxlocV/gGCz35MzFoprmGySfJrSKS4jl1x00QAf/OK8ig1J670=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srjVlvxl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F48AC4AF0B;
	Mon, 28 Jul 2025 08:24:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753691088;
	bh=DDHEw2l9COqoOnSii06vLrGixN7NrFhwB0y2CTTbV2w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=srjVlvxlluDoh0Vj/xjN5mI3mQSTgoM1mo//6tuiu1tHx51su7COlep1BroTMmKj6
	 lcwCqto57s1tx7mHEJWsYlbaVqGaGNcTwIaWf1Wn+ovuJv0Iq84ZaqIkUfk+yFAqP1
	 Ys5Thwto14y/A7TtLXAo7alqS+POX+TnBrAXAzgqkQTijkJyLSfQrR3kRQEaOKOckC
	 3la8bJXllKcVxheHB8oj6LUaMmomgF2+pmOFZ0VGaH0aMdul93AzP0dJi1TTC7CUU8
	 hJi4NciHgjJKMjxIfnCFytoqmwODc5EM+83MwcCAYBLh7xU8x6J+mlCQs/2RZ51Nju
	 GvOZpikNOjnyw==
From: Chris Li <chrisl@kernel.org>
Date: Mon, 28 Jul 2025 01:24:32 -0700
Subject: [PATCH RFC 02/25] PCI/LUO: Add struct dev_liveupdate
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250728-luo-pci-v1-2-955b078dd653@kernel.org>
References: <20250728-luo-pci-v1-0-955b078dd653@kernel.org>
In-Reply-To: <20250728-luo-pci-v1-0-955b078dd653@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>, 
 Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
 Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
 Adithya Jayachandran <ajayachandra@nvidia.com>, 
 Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
 Mike Rapoport <rppt@kernel.org>, Chris Li <chrisl@kernel.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
X-Mailer: b4 0.14.2

Introduce struct dev_liveupdate and add it to struct device.

Use the new struct to track a device's liveupdate states.
- requested: The device is requested for a live update.
- depended:  One of the child devices is requested for live update.

When the device is requested, the dev->lu.requested will
set to 1.

Signed-off-by: Chris Li <chrisl@kernel.org>
---
 drivers/pci/liveupdate.c       |  3 +++
 include/linux/dev_liveupdate.h | 35 +++++++++++++++++++++++++++++++++++
 include/linux/device.h         |  6 ++++++
 3 files changed, 44 insertions(+)

diff --git a/drivers/pci/liveupdate.c b/drivers/pci/liveupdate.c
index 86b4f3a2fb44781c6e323ba029db510450556fa9..1c69adf412255c8ee5bc6db588ff04b1642e8e19 100644
--- a/drivers/pci/liveupdate.c
+++ b/drivers/pci/liveupdate.c
@@ -6,8 +6,11 @@
  */
 
 #define pr_fmt(fmt) "PCI liveupdate: " fmt
+#define dev_fmt(fmt) "PCI liveupdate: " fmt
 
+#include <linux/types.h>
 #include <linux/liveupdate.h>
+#include "pci.h"
 
 #define PCI_SUBSYSTEM_NAME "pci"
 
diff --git a/include/linux/dev_liveupdate.h b/include/linux/dev_liveupdate.h
new file mode 100644
index 0000000000000000000000000000000000000000..057407c030b0872bfa8cd666e6ffc305f7aa4083
--- /dev/null
+++ b/include/linux/dev_liveupdate.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (c) 2025, Google LLC.
+ * Pasha Tatashin <pasha.tatashin@soleen.com>
+ * Chris Li <chrisl@kernel.org>
+ */
+#ifndef _LINUX_DEV_LIVEUPDATE_H
+#define _LINUX_DEV_LIVEUPDATE_H
+
+#include <linux/liveupdate.h>
+
+#ifdef CONFIG_LIVEUPDATE
+
+/**
+ * struct dev_liveupdate - Device state for live update operations
+ * @lu_next:	List head for linking the device into live update
+ *		related lists (e.g., a list of devices participating
+ *		in a live update sequence).
+ * @requested:	Set if a live update has been requested for this
+ *		device (i.e. device will participate in live update).
+ * @depended:	Set if the device participtate the live update due to
+ *		one of its child device is requested in live update.
+ *
+ * This structure holds the state information required for performing
+ * live update operations on a device. It is embedded within a struct device.
+ */
+struct dev_liveupdate {
+	struct list_head lu_next;
+	bool requested:1;
+	bool depended:1;
+};
+
+#endif /* CONFIG_LIVEUPDATE */
+#endif /* _LINUX_DEV_LIVEUPDATE_H */
diff --git a/include/linux/device.h b/include/linux/device.h
index 4940db137fffff4ceacf819b32433a0f4898b125..4aee7912218865168a73fe4c6d3a82646b8dd86f 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -21,6 +21,7 @@
 #include <linux/lockdep.h>
 #include <linux/compiler.h>
 #include <linux/types.h>
+#include <linux/dev_liveupdate.h>
 #include <linux/mutex.h>
 #include <linux/pm.h>
 #include <linux/atomic.h>
@@ -508,6 +509,7 @@ struct device_physical_location {
  * @pm_domain:	Provide callbacks that are executed during system suspend,
  * 		hibernation, system resume and during runtime PM transitions
  * 		along with subsystem-level and driver-level callbacks.
+ * @lu:		Live update state.
  * @em_pd:	device's energy model performance domain
  * @pins:	For device pin management.
  *		See Documentation/driver-api/pin-control.rst for details.
@@ -603,6 +605,10 @@ struct device {
 	struct dev_pm_info	power;
 	struct dev_pm_domain	*pm_domain;
 
+#ifdef CONFIG_LIVEUPDATE
+	struct dev_liveupdate	lu;
+#endif
+
 #ifdef CONFIG_ENERGY_MODEL
 	struct em_perf_domain	*em_pd;
 #endif

-- 
2.50.1.487.gc89ff58d15-goog


