Return-Path: <linux-pci+bounces-39558-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3072AC163E8
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 18:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DAF9950554B
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 17:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77F8E34D90B;
	Tue, 28 Oct 2025 17:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hIHuKwj6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A4BF3314B8;
	Tue, 28 Oct 2025 17:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673036; cv=none; b=U+Tnt+VYGA6E7jSsEHaEo3iGCY0G8PueXbhXaZAj1xaHF8vu3etgAILFL3zuhOLIbuyDNhNccV5F6xOwjNPYpKaO4Qpcp6RQs/hXVrOpm8UXtnl4ybXXt8tMlDJbbRWmHGkGallMy4PDKUvhf9+9O6mXYJJmgMitEQg2tT1AURc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673036; c=relaxed/simple;
	bh=ERhBbsVAijg7GuSGAHqVgu4x2K9pEZ/HJeGvKGSqDY4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q3OyF4UiG9NbkBnOfINf1y7fNsCp8LcXqVI08I4s+lkwY1XRclxORSDdArukiDeqPYwiQwHZLhpGZHrNOUHdXOcRw9iFFOKrkNpZawja7irZwcbmiB+ZEtbY7u2JpY+6KgS1FnpRY4gidII4RzoOl4KsNYiObyMutZwVoutvjO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hIHuKwj6; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761673034; x=1793209034;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ERhBbsVAijg7GuSGAHqVgu4x2K9pEZ/HJeGvKGSqDY4=;
  b=hIHuKwj6uHLPnWMo5HvMUY21CnfyNLKRGkO5JYXG9UbIqep9wr7NbJbn
   Fa+WIz63b6dagu97JYtSo71Qr+mz0KmkuH5VwJfVhudyxZnu2CAyAZHbN
   INq4l2It0Z38dJPZBePMq1hLyrN66sAZtBtUsI8bcqeM3wiGNs/gjxdyT
   x1c7//TH+IS49GpCEFqPSgHwps/B5CtbnpRpU1DJwjZEopOh55BJcu4pS
   wgNkapLfeEVmPx72wEvboSZkJuU6lXnGA5Pf2YYuMLRuSXhqFhioUQGWR
   SrzEompmeyFeQn9HWlawuqhoXHIXuR0Zu3PPXeSGiiXRWojrB8c2cEG8l
   Q==;
X-CSE-ConnectionGUID: AnZ/bBbfSu+Di1KvOXWQfA==
X-CSE-MsgGUID: hQG4Ga0iSqyRn3jAg8qIww==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="74901595"
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="74901595"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 10:37:13 -0700
X-CSE-ConnectionGUID: E5Edt0WoRfO3JJ720iobsA==
X-CSE-MsgGUID: uxBzOToVRBaZotqYJKVqbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,261,1754982000"; 
   d="scan'208";a="222635764"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.182])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2025 10:37:05 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Simon Richter <Simon.Richter@hogyros.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	amd-gfx@lists.freedesktop.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	David Airlie <airlied@gmail.com>,
	dri-devel@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	linux-pci@vger.kernel.org,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tvrtko Ursulin <tursulin@ursulin.net>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	=?UTF-8?q?Micha=C5=82=20Winiarski?= <michal.winiarski@intel.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 5/9] PCI: Fix restoring BARs on BAR resize rollback path
Date: Tue, 28 Oct 2025 19:35:47 +0200
Message-Id: <20251028173551.22578-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251028173551.22578-1-ilpo.jarvinen@linux.intel.com>
References: <20251028173551.22578-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

BAR resize operation is implemented in the pci_resize_resource() and
pbus_reassign_bridge_resources() functions. pci_resize_resource() can
be called either from __resource_resize_store() from sysfs or directly
by the driver for the Endpoint Device.

The pci_resize_resource() requires that caller has released the device
resources that share the bridge window with the BAR to be resized as
otherwise the bridge window is pinned in place and cannot be changed.

pbus_reassign_bridge_resources() implement rollback of the resources if
the resize operation fails, but rollback is performed only for the
bridge windows. Because releasing the device resources are done by the
caller of the BAR resize interface, these functions performing the BAR
resize do not have access to the device resources as they were before
the resize.

pbus_reassign_bridge_resources() could try to
__pci_bridge_assign_resources() after rolling back the bridge windows
as they were, however, it will not guarantee the resource are assigned
due to differences how FW and the kernel may want to assign the
resources (alignment of the start address and tail).

In order to perform rollback robustly, the BAR resize interface has to
be altered to also release the device resources that share the bridge
window with the BAR to be resized.

Also, remove restoring from the entries failed list as saved list
should now contain both the bridge windows and device resources so
the extra restore is duplicated work.

This change (together with the driver side changes) is to counter the
resource releases that had to be done to prevent resource tree
corruption in the ("PCI: Release assigned resource before restoring
them") change. As such, it likely restores functionality in cases where
device resources were released to avoid resource tree conflicts which
appeared to be "working" when such conflicts were not correctly
detected by the kernel.

Reported-by: Simon Richter <Simon.Richter@hogyros.de>
Reported-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci-sysfs.c | 15 +------
 drivers/pci/pci.h       |  3 +-
 drivers/pci/setup-bus.c | 95 ++++++++++++++++++++++++++++++-----------
 drivers/pci/setup-res.c | 20 ++-------
 4 files changed, 77 insertions(+), 56 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 9d6f74bd95f8..caffd20abb9f 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -1599,18 +1599,13 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pci_bus *bus = pdev->bus;
-	struct resource *b_win, *res;
 	unsigned long size;
-	int ret, i;
+	int ret;
 	u16 cmd;
 
 	if (kstrtoul(buf, 0, &size) < 0)
 		return -EINVAL;
 
-	b_win = pbus_select_window(bus, pci_resource_n(pdev, n));
-	if (!b_win)
-		return -EINVAL;
-
 	device_lock(dev);
 	if (dev->driver || pci_num_vf(pdev)) {
 		ret = -EBUSY;
@@ -1632,14 +1627,6 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
 
 	pci_remove_resource_files(pdev);
 
-	pci_dev_for_each_resource(pdev, res, i) {
-		if (i >= PCI_BRIDGE_RESOURCES)
-			break;
-
-		if (b_win == pbus_select_window(bus, res))
-			pci_release_resource(pdev, i);
-	}
-
 	ret = pci_resize_resource(pdev, n, size);
 
 	pci_assign_unassigned_bus_resources(bus);
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index bf1a577e9623..d22e595b3891 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -421,8 +421,9 @@ enum pci_bar_type {
 struct device *pci_get_host_bridge_device(struct pci_dev *dev);
 void pci_put_host_bridge_device(struct device *dev);
 
+void pci_resize_resource_set_size(struct pci_dev *dev, int resno, int size);
+int pci_do_resource_release_and_resize(struct pci_dev *dev, int resno, int size);
 unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge);
-int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *res);
 int __must_check pci_reassign_resource(struct pci_dev *dev, int i, resource_size_t add_size, resource_size_t align);
 
 int pci_configure_extended_tags(struct pci_dev *dev, void *ign);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 76a4259ab076..8da83b612c59 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2420,18 +2420,16 @@ EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
  * release it when possible. If the bridge window contains assigned
  * resources, it cannot be released.
  */
-int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *res)
+static int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *res,
+					  struct list_head *saved)
 {
 	unsigned long type = res->flags;
 	struct pci_dev_resource *dev_res;
 	struct pci_dev *bridge;
-	LIST_HEAD(saved);
 	LIST_HEAD(added);
 	LIST_HEAD(failed);
 	unsigned int i;
-	int ret;
-
-	down_read(&pci_bus_sem);
+	int ret = 0;
 
 	while (!pci_is_root_bus(bus)) {
 		bridge = bus->self;
@@ -2443,9 +2441,9 @@ int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *res)
 
 		/* Ignore BARs which are still in use */
 		if (!res->child) {
-			ret = add_to_list(&saved, bridge, res, 0, 0);
+			ret = add_to_list(saved, bridge, res, 0, 0);
 			if (ret)
-				goto cleanup;
+				return ret;
 
 			pci_release_resource(bridge, i);
 		} else {
@@ -2468,34 +2466,73 @@ int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *res)
 		free_list(&added);
 
 	if (!list_empty(&failed)) {
-		if (pci_required_resource_failed(&failed, type)) {
+		if (pci_required_resource_failed(&failed, type))
 			ret = -ENOSPC;
-			goto cleanup;
-		}
-		/* Only resources with unrelated types failed (again) */
 		free_list(&failed);
+		if (ret)
+			return ret;
+
+		/* Only resources with unrelated types failed (again) */
 	}
 
-	list_for_each_entry(dev_res, &saved, list) {
+	list_for_each_entry(dev_res, saved, list) {
 		struct pci_dev *dev = dev_res->dev;
 
 		/* Skip the bridge we just assigned resources for */
 		if (bridge == dev)
 			continue;
 
+		if (!dev->subordinate)
+			continue;
+
 		pci_setup_bridge(dev->subordinate);
 	}
 
-	free_list(&saved);
-	up_read(&pci_bus_sem);
 	return 0;
+}
 
-cleanup:
-	/* Restore size and flags */
-	list_for_each_entry(dev_res, &failed, list)
-		restore_dev_resource(dev_res);
-	free_list(&failed);
+int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size)
+{
+	struct resource *res = pci_resource_n(pdev, resno);
+	struct pci_dev_resource *dev_res;
+	struct pci_bus *bus = pdev->bus;
+	struct resource *b_win, *r;
+	LIST_HEAD(saved);
+	unsigned int i;
+	int ret;
+
+	b_win = pbus_select_window(bus, res);
+	if (!b_win)
+		return -EINVAL;
+
+	pci_dev_for_each_resource(pdev, r, i) {
+		if (i >= PCI_BRIDGE_RESOURCES)
+			break;
 
+		if (b_win != pbus_select_window(bus, r))
+			continue;
+
+		ret = add_to_list(&saved, pdev, r, 0, 0);
+		if (ret)
+			goto restore;
+		pci_release_resource(pdev, i);
+	}
+
+	pci_resize_resource_set_size(pdev, resno, size);
+
+	if (!bus->self)
+		goto out;
+
+	guard(rwsem_read)(&pci_bus_sem);
+	ret = pbus_reassign_bridge_resources(bus, res, &saved);
+	if (ret)
+		goto restore;
+
+out:
+	free_list(&saved);
+	return ret;
+
+restore:
 	/* Revert to the old configuration */
 	list_for_each_entry(dev_res, &saved, list) {
 		struct resource *res = dev_res->res;
@@ -2510,13 +2547,21 @@ int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *res)
 
 		restore_dev_resource(dev_res);
 
-		pci_claim_resource(dev, i);
-		pci_setup_bridge(dev->subordinate);
-	}
-	free_list(&saved);
-	up_read(&pci_bus_sem);
+		ret = pci_claim_resource(dev, i);
+		if (ret)
+			continue;
 
-	return ret;
+		if (i < PCI_BRIDGE_RESOURCES) {
+			const char *res_name = pci_resource_name(dev, i);
+
+			pci_update_resource(dev, i);
+			pci_info(dev, "%s %pR: old value restored\n",
+				 res_name, res);
+		}
+		if (dev->subordinate)
+			pci_setup_bridge(dev->subordinate);
+	}
+	goto out;
 }
 
 void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 3d0b0b3f60c4..93c70f8a8552 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -444,8 +444,7 @@ static bool pci_resize_is_memory_decoding_enabled(struct pci_dev *dev,
 	return cmd & PCI_COMMAND_MEMORY;
 }
 
-static void pci_resize_resource_set_size(struct pci_dev *dev, int resno,
-					 int size)
+void pci_resize_resource_set_size(struct pci_dev *dev, int resno, int size)
 {
 	resource_size_t res_size = pci_rebar_size_to_bytes(size);
 	struct resource *res = pci_resource_n(dev, resno);
@@ -458,7 +457,6 @@ static void pci_resize_resource_set_size(struct pci_dev *dev, int resno,
 
 int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 {
-	struct resource *res = pci_resource_n(dev, resno);
 	struct pci_host_bridge *host;
 	int old, ret;
 	u32 sizes;
@@ -468,10 +466,6 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 	if (host->preserve_config)
 		return -ENOTSUPP;
 
-	/* Make sure the resource isn't assigned before resizing it. */
-	if (!(res->flags & IORESOURCE_UNSET))
-		return -EBUSY;
-
 	if (pci_resize_is_memory_decoding_enabled(dev, resno))
 		return -EBUSY;
 
@@ -490,19 +484,13 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 	if (ret)
 		return ret;
 
-	pci_resize_resource_set_size(dev, resno, size);
-
-	/* Check if the new config works by trying to assign everything. */
-	if (dev->bus->self) {
-		ret = pbus_reassign_bridge_resources(dev->bus, res);
-		if (ret)
-			goto error_resize;
-	}
+	ret = pci_do_resource_release_and_resize(dev, resno, size);
+	if (ret)
+		goto error_resize;
 	return 0;
 
 error_resize:
 	pci_rebar_set_size(dev, resno, old);
-	pci_resize_resource_set_size(dev, resno, old);
 	return ret;
 }
 EXPORT_SYMBOL(pci_resize_resource);
-- 
2.39.5


