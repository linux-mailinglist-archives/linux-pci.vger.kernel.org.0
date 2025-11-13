Return-Path: <linux-pci+bounces-41127-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB941C59028
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 18:09:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E041540056
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 16:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D11C3570B0;
	Thu, 13 Nov 2025 16:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JqQC/IB4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40472FDC30;
	Thu, 13 Nov 2025 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051272; cv=none; b=QIt3uL2GeQYKKwsLnR+W9LMqplbEqkk2VLlK+5AKUqO7iadZ0v6EOGjNoagqixF4/bZzqOgYZVYIRjEfDYgeh4O718hRx874DZWHs6vzQKM77WmedyNsEN/bB827R2P3evTzk9o7/Z2xGWyxIzGxOSKeMmER3MrVMQoWh1nzuXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051272; c=relaxed/simple;
	bh=+trFMYljx22L/rHZ/v5ZIxPiByoxtKGa5piLBTICrnc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WxjY28REMDPQfiIkYe94QRLiq+TdLtZeE55iOCY3EFp0FjhVS938X8vtYBFsrIKn49TKANnYqmqV/Ey6K7M2Qslar6OVt6nBsceAAiFkTsz3NgliNPR2o78pwp1/BVawTU2AL4+CDkNJhUJ3kXlZIruw9zfXHGoIjHTHMyM1gOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JqQC/IB4; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763051269; x=1794587269;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+trFMYljx22L/rHZ/v5ZIxPiByoxtKGa5piLBTICrnc=;
  b=JqQC/IB4gFp6scVugvXXCMOFoT8f+OjUjsvRk7Pbf+f/vsbx1b24stg4
   TYxJmpmSoouSs8oSYSUothJmp3oJmpR79Phi5dO1NO1t35d/rIj/+Dz6c
   KdkOpqiQbNbOTNW+vv9Me61pl7STMa935gCE/jfARylZYxC9M0ZonNIzp
   h3GadtGFy0M7NkCRVlq0UW/qP9uKURdHFK5EpOrmd6oyC+/rTVKieZgQ6
   e/xW93+OsNOw1pyvGsVxQxOVoKWhcnY1LYou9YbUbaQ+BcoWJYGhGU2aj
   7mwkmnl1eLAyGb8D1JStbpJMH4e/4wUDrLkknjCyMjrhKquIlbOBPeTJx
   w==;
X-CSE-ConnectionGUID: KxzgvSwnQcGdyTsNoNFjhQ==
X-CSE-MsgGUID: M909pin7SeGNjWoHrTiKAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="65176202"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="65176202"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:27:48 -0800
X-CSE-ConnectionGUID: VCw9BVjZT+ahX5WRLQxlnA==
X-CSE-MsgGUID: 1RUSgjgnRnOi331giSdIRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="189971942"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.164])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 08:27:43 -0800
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
Subject: [PATCH v2 06/11] PCI: Fix restoring BARs on BAR resize rollback path
Date: Thu, 13 Nov 2025 18:26:23 +0200
Message-Id: <20251113162628.5946-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251113162628.5946-1-ilpo.jarvinen@linux.intel.com>
References: <20251113162628.5946-1-ilpo.jarvinen@linux.intel.com>
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

Some drivers (currently only amdgpu) want to prevent releasing some
resources. Add exclude_bars param to pci_resize_resource() and make
amdgpu to pass its register BAR (BAR 5) which should never be released
during resize operation. Normally 64-bit prefetchable resources do not
share bridge window with it as the register BAR (32-bit only) but there
are various fallbacks in the resource assignment logic which may make
the resources to share the bridge window in rare cases.

This change (together with the driver side changes) is to counter the
resource releases that had to be done to prevent resource tree
corruption in the ("PCI: Release assigned resource before restoring
them") change. As such, it likely restores functionality in cases where
device resources were released to avoid resource tree conflicts which
appeared to be "working" when such conflicts were not correctly
detected by the kernel.

Link: https://lore.kernel.org/linux-pci/f9a8c975-f5d3-4dd2-988e-4371a1433a60@hogyros.de/
Link: https://lore.kernel.org/linux-pci/874irqop6b.fsf@draig.linaro.org/
Reported-by: Simon Richter <Simon.Richter@hogyros.de>
Reported-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   2 +-
 drivers/gpu/drm/i915/gt/intel_region_lmem.c |   2 +-
 drivers/gpu/drm/xe/xe_vram.c                |   2 +-
 drivers/pci/pci-sysfs.c                     |  17 +---
 drivers/pci/pci.h                           |   4 +-
 drivers/pci/setup-bus.c                     | 100 +++++++++++++++-----
 drivers/pci/setup-res.c                     |  23 ++---
 include/linux/pci.h                         |   3 +-
 8 files changed, 91 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7a899fb4de29..4e241836ae68 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1736,7 +1736,7 @@ int amdgpu_device_resize_fb_bar(struct amdgpu_device *adev)
 
 	pci_release_resource(adev->pdev, 0);
 
-	r = pci_resize_resource(adev->pdev, 0, rbar_size);
+	r = pci_resize_resource(adev->pdev, 0, rbar_size, 1 << 5);
 	if (r == -ENOSPC)
 		dev_info(adev->dev,
 			 "Not enough PCI address space for a large BAR.");
diff --git a/drivers/gpu/drm/i915/gt/intel_region_lmem.c b/drivers/gpu/drm/i915/gt/intel_region_lmem.c
index 51bb27e10a4f..7699e8fcf5ed 100644
--- a/drivers/gpu/drm/i915/gt/intel_region_lmem.c
+++ b/drivers/gpu/drm/i915/gt/intel_region_lmem.c
@@ -37,7 +37,7 @@ _resize_bar(struct drm_i915_private *i915, int resno, resource_size_t size)
 
 	_release_bars(pdev);
 
-	ret = pci_resize_resource(pdev, resno, bar_size);
+	ret = pci_resize_resource(pdev, resno, bar_size, 0);
 	if (ret) {
 		drm_info(&i915->drm, "Failed to resize BAR%d to %dM (%pe)\n",
 			 resno, 1 << bar_size, ERR_PTR(ret));
diff --git a/drivers/gpu/drm/xe/xe_vram.c b/drivers/gpu/drm/xe/xe_vram.c
index b44ebf50fedb..00dd027057df 100644
--- a/drivers/gpu/drm/xe/xe_vram.c
+++ b/drivers/gpu/drm/xe/xe_vram.c
@@ -36,7 +36,7 @@ _resize_bar(struct xe_device *xe, int resno, resource_size_t size)
 	if (pci_resource_len(pdev, resno))
 		pci_release_resource(pdev, resno);
 
-	ret = pci_resize_resource(pdev, resno, bar_size);
+	ret = pci_resize_resource(pdev, resno, bar_size, 0);
 	if (ret) {
 		drm_info(&xe->drm, "Failed to resize BAR%d to %dM (%pe). Consider enabling 'Resizable BAR' support in your BIOS\n",
 			 resno, 1 << bar_size, ERR_PTR(ret));
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 9d6f74bd95f8..2a1b5456c2dc 100644
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
@@ -1632,15 +1627,7 @@ static ssize_t __resource_resize_store(struct device *dev, int n,
 
 	pci_remove_resource_files(pdev);
 
-	pci_dev_for_each_resource(pdev, res, i) {
-		if (i >= PCI_BRIDGE_RESOURCES)
-			break;
-
-		if (b_win == pbus_select_window(bus, res))
-			pci_release_resource(pdev, i);
-	}
-
-	ret = pci_resize_resource(pdev, n, size);
+	ret = pci_resize_resource(pdev, n, size, 0);
 
 	pci_assign_unassigned_bus_resources(bus);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index bf1a577e9623..9893ea12d1f2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -421,8 +421,10 @@ enum pci_bar_type {
 struct device *pci_get_host_bridge_device(struct pci_dev *dev);
 void pci_put_host_bridge_device(struct device *dev);
 
+void pci_resize_resource_set_size(struct pci_dev *dev, int resno, int size);
+int pci_do_resource_release_and_resize(struct pci_dev *dev, int resno, int size,
+				       int exclude_bars);
 unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge);
-int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *res);
 int __must_check pci_reassign_resource(struct pci_dev *dev, int i, resource_size_t add_size, resource_size_t align);
 
 int pci_configure_extended_tags(struct pci_dev *dev, void *ign);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 51f5e5a80b54..7e268960954b 100644
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
 	struct pci_dev *bridge = NULL;
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
@@ -2468,34 +2466,78 @@ int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *res)
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
+int pci_do_resource_release_and_resize(struct pci_dev *pdev, int resno, int size,
+				       int exclude_bars)
+{
+	struct resource *res = pci_resource_n(pdev, resno);
+	struct pci_dev_resource *dev_res;
+	struct pci_bus *bus = pdev->bus;
+	struct resource *b_win, *r;
+	LIST_HEAD(saved);
+	unsigned int i;
+	int ret = 0;
+
+	b_win = pbus_select_window(bus, res);
+	if (!b_win)
+		return -EINVAL;
+
+	pci_dev_for_each_resource(pdev, r, i) {
+		if (i >= PCI_BRIDGE_RESOURCES)
+			break;
+
+		if (exclude_bars & BIT(i))
+			continue;
 
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
+	down_read(&pci_bus_sem);
+	ret = pbus_reassign_bridge_resources(bus, res, &saved);
+	if (ret)
+		goto restore;
+
+out:
+	up_read(&pci_bus_sem);
+	free_list(&saved);
+	return ret;
+
+restore:
 	/* Revert to the old configuration */
 	list_for_each_entry(dev_res, &saved, list) {
 		struct resource *res = dev_res->res;
@@ -2510,13 +2552,21 @@ int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *res)
 
 		restore_dev_resource(dev_res);
 
-		pci_claim_resource(dev, i);
-		pci_setup_bridge(dev->subordinate);
-	}
-	up_read(&pci_bus_sem);
-	free_list(&saved);
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
index 3d0b0b3f60c4..e4486d7030c0 100644
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
@@ -456,9 +455,9 @@ static void pci_resize_resource_set_size(struct pci_dev *dev, int resno,
 	resource_set_size(res, res_size);
 }
 
-int pci_resize_resource(struct pci_dev *dev, int resno, int size)
+int pci_resize_resource(struct pci_dev *dev, int resno, int size,
+			int exclude_bars)
 {
-	struct resource *res = pci_resource_n(dev, resno);
 	struct pci_host_bridge *host;
 	int old, ret;
 	u32 sizes;
@@ -468,10 +467,6 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 	if (host->preserve_config)
 		return -ENOTSUPP;
 
-	/* Make sure the resource isn't assigned before resizing it. */
-	if (!(res->flags & IORESOURCE_UNSET))
-		return -EBUSY;
-
 	if (pci_resize_is_memory_decoding_enabled(dev, resno))
 		return -EBUSY;
 
@@ -490,19 +485,13 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
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
+	ret = pci_do_resource_release_and_resize(dev, resno, size, exclude_bars);
+	if (ret)
+		goto error_resize;
 	return 0;
 
 error_resize:
 	pci_rebar_set_size(dev, resno, old);
-	pci_resize_resource_set_size(dev, resno, old);
 	return ret;
 }
 EXPORT_SYMBOL(pci_resize_resource);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index d1fdf81fbe1e..cc58abbd2b20 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1428,7 +1428,8 @@ static inline int pci_rebar_bytes_to_size(u64 bytes)
 }
 
 u32 pci_rebar_get_possible_sizes(struct pci_dev *pdev, int bar);
-int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size);
+int __must_check pci_resize_resource(struct pci_dev *dev, int i, int size,
+				     int exlucde_bars);
 int pci_select_bars(struct pci_dev *dev, unsigned long flags);
 bool pci_device_is_present(struct pci_dev *pdev);
 void pci_ignore_hotplug(struct pci_dev *dev);
-- 
2.39.5


