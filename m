Return-Path: <linux-pci+bounces-35110-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 135D6B3BC2B
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 15:15:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6142A1BA250B
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 13:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414CF2F618F;
	Fri, 29 Aug 2025 13:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dK2ZGe97"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB1E31AF29;
	Fri, 29 Aug 2025 13:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473181; cv=none; b=mUtZrsEkfj8TcaCqSdDadRcKmQngm3L4Y8lzpg6hPM7Gmvn9WOpUrh7rl6P6dz0zrpSMF1NATgpfN6BtbLqNCgJXyNRIMerbFKqs1rbIl/Rx3fn8Fj88LvIwOArINZYCWN9bd9f3JoSKF20z7qixtLFf3Nkvpmh6L2dP9ONSWwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473181; c=relaxed/simple;
	bh=ncIGZH0YgUz4aIK0xB5ReVsHWKkCKIQ51Z//CtFD9/Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fcFDiCD+x2bDmqJR4+Z+P+gn3FKBiqa2CpJJt9H1FaF9af9i/04DniXvUZFN+lfznOVm0amqDrppGKXMt9f4GHM0U1BEEMJjcFPcm1KtjUgBkoOH3xzCPZCHDUmcb+nEqa5TQFYIsoaZSm3Csze144xeQMRqXi3r9tRhRGyIi3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dK2ZGe97; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756473180; x=1788009180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ncIGZH0YgUz4aIK0xB5ReVsHWKkCKIQ51Z//CtFD9/Y=;
  b=dK2ZGe97QdCUjWs9OrS2AZMDVQ8pamX/sHNvyZ+wzhZw8PuO2fXnBPQA
   aehOQF92lh0OmqzrITI9sNxFtI2XFKk1931WoIsyydZIoUV4U9ErGrVh4
   sl+QvmGp/HWFeV2yNsju6FA8B6LrxUXI1zipAvIjSVy8qk7+V+DB7JQN5
   j0rQcxkAHKzuBN6YR7oCR6YV/XPwgrj/N+sNWE7npFOi4LsHfzKxteW/x
   Tf0WhOYLyJvM46U9Xg3iO4LYUj/HMef6zWHAg+ViInJA1KRLqH60jpSoa
   h/S+IwlShmWa2WKFpGGMAGh36uXtDMi9FjrguuvofxfBmmBcG1GiyJ11Z
   w==;
X-CSE-ConnectionGUID: taaEgf9jQs+Db3O9joaBqg==
X-CSE-MsgGUID: /JKGCkEJQYKnZTAcf3SfMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="62576120"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="62576120"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:12:59 -0700
X-CSE-ConnectionGUID: nSRZTtfLQayp2HFSYtK/jQ==
X-CSE-MsgGUID: +QR1nEcuRLuwD32oo28Utw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="174733748"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:12:57 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 13/24] PCI: Fix finding bridge window in pci_reassign_bridge_resources()
Date: Fri, 29 Aug 2025 16:11:02 +0300
Message-Id: <20250829131113.36754-14-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
References: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_reassign_bridge_resources() walks upwards in the PCI bus hierarchy,
locates the relevant bridge window on each level using flags check, and
attempts to release the bridge window. The flags-based check is fragile due
to various fallbacks in the bridge window selection logic. As such, the
algorithm might not locate the correct bridge window.

Refactor pci_reassign_bridge_resources() to determine the correct bridge
window using pbus_select_window(), which contains logic to handle all
fallback cases correctly. Change function prefix to pbus as it now inputs
struct bus and resource for which to locate the bridge window.

The main purpose is to make bridge window selection logic consistent across
the entire PCI core (one step at a time). While this technically also fixes
the commit 8bb705e3e79d ("PCI: Add pci_resize_resource() for resizing
BARs") making the bridge window walk algorithm more robust, the normal
setup having a 64-bit resizable BAR underneath bridge(s) with 64-bit
prefetchable windows does not need to use any fallbacks. As such, the
practical impact is low (requiring BAR resize use case and a non-typical
bridge device).

The way to detect if unrelated resource failed again is left to use the
type based approximation which should not behave worse than before.

Fixes: 8bb705e3e79d ("PCI: Add pci_resize_resource() for resizing BARs")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.h       |  2 +-
 drivers/pci/setup-bus.c | 38 ++++++++++++++++++--------------------
 drivers/pci/setup-res.c |  2 +-
 3 files changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index cbd40f05c39c..0d96a9141227 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -334,7 +334,7 @@ struct device *pci_get_host_bridge_device(struct pci_dev *dev);
 void pci_put_host_bridge_device(struct device *dev);
 
 unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge);
-int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type);
+int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *res);
 int __must_check pci_reassign_resource(struct pci_dev *dev, int i, resource_size_t add_size, resource_size_t align);
 
 int pci_configure_extended_tags(struct pci_dev *dev, void *ign);
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 913fd41e1d0d..4b08b9cecab3 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2522,10 +2522,16 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 }
 EXPORT_SYMBOL_GPL(pci_assign_unassigned_bridge_resources);
 
-int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
+/*
+ * Walk to the root bus, find the bridge window relevant for @res and
+ * release it when possible. If the bridge window contains assigned
+ * resources, it cannot be released.
+ */
+int pbus_reassign_bridge_resources(struct pci_bus *bus, struct resource *res)
 {
+	unsigned long type = res->flags;
 	struct pci_dev_resource *dev_res;
-	struct pci_dev *next;
+	struct pci_dev *bridge;
 	LIST_HEAD(saved);
 	LIST_HEAD(added);
 	LIST_HEAD(failed);
@@ -2534,33 +2540,25 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 
 	down_read(&pci_bus_sem);
 
-	/* Walk to the root hub, releasing bridge BARs when possible */
-	next = bridge;
-	do {
-		bridge = next;
-		for (i = PCI_BRIDGE_RESOURCES; i < PCI_BRIDGE_RESOURCE_END;
-		     i++) {
-			struct resource *res = &bridge->resource[i];
-
-			if ((res->flags ^ type) & PCI_RES_TYPE_MASK)
-				continue;
+	while (!pci_is_root_bus(bus)) {
+		bridge = bus->self;
+		res = pbus_select_window(bus, res);
+		if (!res)
+			break;
 
-			/* Ignore BARs which are still in use */
-			if (res->child)
-				continue;
+		i = pci_resource_num(bridge, res);
 
+		/* Ignore BARs which are still in use */
+		if (!res->child) {
 			ret = add_to_list(&saved, bridge, res, 0, 0);
 			if (ret)
 				goto cleanup;
 
 			pci_release_resource(bridge, i);
-			break;
 		}
-		if (i == PCI_BRIDGE_RESOURCE_END)
-			break;
 
-		next = bridge->bus ? bridge->bus->self : NULL;
-	} while (next);
+		bus = bus->parent;
+	}
 
 	if (list_empty(&saved)) {
 		up_read(&pci_bus_sem);
diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
index 21f77e5c647c..c3ba4ccecd43 100644
--- a/drivers/pci/setup-res.c
+++ b/drivers/pci/setup-res.c
@@ -496,7 +496,7 @@ int pci_resize_resource(struct pci_dev *dev, int resno, int size)
 
 	/* Check if the new config works by trying to assign everything. */
 	if (dev->bus->self) {
-		ret = pci_reassign_bridge_resources(dev->bus->self, res->flags);
+		ret = pbus_reassign_bridge_resources(dev->bus, res);
 		if (ret)
 			goto error_resize;
 	}
-- 
2.39.5


