Return-Path: <linux-pci+bounces-35117-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19EA1B3BC40
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 15:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0740E7B7DD2
	for <lists+linux-pci@lfdr.de>; Fri, 29 Aug 2025 13:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0B731DDBC;
	Fri, 29 Aug 2025 13:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y0jm239z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB3A322527;
	Fri, 29 Aug 2025 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756473232; cv=none; b=Y05KloWJq6v5BzMEeOVqUPN9ZOd+evmoPjBn5xYIaIW7XHw3RfrmWBxAEWLWjexwC9LCVFJIUSfSeqUUMX4ABKsQ0fiVWEsMO8IR8PQvkGHTxvxEJoZF9mvjCEg8d0+uYxU5zhK2pYnjAxxsit9TPEazk9rGp3HeFkZOXCt/M54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756473232; c=relaxed/simple;
	bh=wMCUuHF+XjaAwSmSStybioIny5+bMniscZLMz7OWBZQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g69p4Zmdh+Pv7eQnCswWIvBMcdBY+ZUMAiU4FvW1mZKk9o785C6YeoYd1j0Ha7TqLFtx8p6CTWuHB7IuukCGv+sJluEoeOy1pf0FvWLmY9S3prpfNp5mtari3frLgGDDvOzE18hIdKzxw86Fk9JUk3fXtcJu+yxujRdHHIApfrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y0jm239z; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756473231; x=1788009231;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wMCUuHF+XjaAwSmSStybioIny5+bMniscZLMz7OWBZQ=;
  b=Y0jm239z1uNihN9TTkY4DCTtCgcinWwDp5sVdYLjZjwcJdQA0aVknJsT
   9ucMqU3jWW+monQMQYKPIbkny3AMiLnhvXxXunYtRPgqyI6kVKchjHFQP
   rPBASi8I+uC+k18fhsxRJgQPGAa3PukadurTNwSEL5EbSIja26FAphGpm
   LP2WFg7lcp5cviH3a3g2AhjHLdxSNfQqAHlYLzZ0hKhcB22Eas4e5vu8K
   v39LYmKtI80sv96HrBSbx0wx27LEW5ggQ55IqVNJje4n7ozNyb/Gw2lQm
   82aaqBQbWEzbcsuIrOByckzTcWl4cmYxDT+NMWr7iQZ1b/z1H491ElSYd
   g==;
X-CSE-ConnectionGUID: gcAw+5TNRGqX6fBf4tYghA==
X-CSE-MsgGUID: BfgMHNASRvShy2sBYMLdNA==
X-IronPort-AV: E=McAfee;i="6800,10657,11536"; a="58905330"
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="58905330"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:13:50 -0700
X-CSE-ConnectionGUID: jgv4njJmT6qvSCIJxIvMgQ==
X-CSE-MsgGUID: vRV1fTn5S1exJFWAKAD8WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,221,1751266800"; 
   d="scan'208";a="169680036"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.225])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2025 06:13:48 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 20/24] PCI: Refactor distributing available memory to use loops
Date: Fri, 29 Aug 2025 16:11:09 +0300
Message-Id: <20250829131113.36754-21-ilpo.jarvinen@linux.intel.com>
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

pci_bus_distribute_available_resources() and
pci_bridge_distribute_available_resources() retain bridge window resources
and related data needed for distributing the available window in
independent variables for io, memory, and prefetchable memory windows. The
code is essentially the same for all of them and therefore repeated three
times with different variable names.

Refactor pci_bus_distribute_available_resources() to take an array. This
is complicated slightly by the function taking advantage of passing the
struct as value, which cannot be done for arrays in C. Therefore, copy the
data into a local array in the stack in the first loop.

Variable names are (hopefully) improved slightly as well.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 162 ++++++++++++++++++----------------------
 include/linux/pci.h     |   3 +-
 2 files changed, 74 insertions(+), 91 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 720159bca54d..3bc329b1b923 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2059,15 +2059,16 @@ static void remove_dev_resource(struct resource *avail, struct pci_dev *dev,
 	avail->start = min(avail->start + tmp, avail->end + 1);
 }
 
-static void remove_dev_resources(struct pci_dev *dev, struct resource *io,
-				 struct resource *mmio,
-				 struct resource *mmio_pref)
+static void remove_dev_resources(struct pci_dev *dev,
+				 struct resource available[PCI_P2P_BRIDGE_RESOURCE_NUM])
 {
+	struct resource *mmio_pref = &available[PCI_BUS_BRIDGE_PREF_MEM_WINDOW];
 	struct resource *res;
 
 	pci_dev_for_each_resource(dev, res) {
 		if (resource_type(res) == IORESOURCE_IO) {
-			remove_dev_resource(io, dev, res);
+			remove_dev_resource(&available[PCI_BUS_BRIDGE_IO_WINDOW],
+					    dev, res);
 		} else if (resource_type(res) == IORESOURCE_MEM) {
 
 			/*
@@ -2081,10 +2082,13 @@ static void remove_dev_resources(struct pci_dev *dev, struct resource *io,
 			 */
 			if ((res->flags & IORESOURCE_PREFETCH) &&
 			    ((res->flags & IORESOURCE_MEM_64) ==
-			     (mmio_pref->flags & IORESOURCE_MEM_64)))
-				remove_dev_resource(mmio_pref, dev, res);
-			else
-				remove_dev_resource(mmio, dev, res);
+			     (mmio_pref->flags & IORESOURCE_MEM_64))) {
+				remove_dev_resource(&available[PCI_BUS_BRIDGE_PREF_MEM_WINDOW],
+						    dev, res);
+			} else {
+				remove_dev_resource(&available[PCI_BUS_BRIDGE_MEM_WINDOW],
+						    dev, res);
+			}
 		}
 	}
 }
@@ -2099,45 +2103,39 @@ static void remove_dev_resources(struct pci_dev *dev, struct resource *io,
  * shared with the bridges.
  */
 static void pci_bus_distribute_available_resources(struct pci_bus *bus,
-					    struct list_head *add_list,
-					    struct resource io,
-					    struct resource mmio,
-					    struct resource mmio_pref)
+		    struct list_head *add_list,
+		    struct resource available_in[PCI_P2P_BRIDGE_RESOURCE_NUM])
 {
+	struct resource available[PCI_P2P_BRIDGE_RESOURCE_NUM];
 	unsigned int normal_bridges = 0, hotplug_bridges = 0;
-	struct resource *io_res, *mmio_res, *mmio_pref_res;
 	struct pci_dev *dev, *bridge = bus->self;
-	resource_size_t io_per_b, mmio_per_b, mmio_pref_per_b, align;
+	resource_size_t per_bridge[PCI_P2P_BRIDGE_RESOURCE_NUM];
+	resource_size_t align;
+	int i;
 
-	io_res = &bridge->resource[PCI_BRIDGE_IO_WINDOW];
-	mmio_res = &bridge->resource[PCI_BRIDGE_MEM_WINDOW];
-	mmio_pref_res = &bridge->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
+	for (i = 0; i < PCI_P2P_BRIDGE_RESOURCE_NUM; i++) {
+		struct resource *res = pci_bus_resource_n(bus, i);
 
-	/*
-	 * The alignment of this bridge is yet to be considered, hence it must
-	 * be done now before extending its bridge window.
-	 */
-	align = pci_resource_alignment(bridge, io_res);
-	if (!io_res->parent && align)
-		io.start = min(ALIGN(io.start, align), io.end + 1);
-
-	align = pci_resource_alignment(bridge, mmio_res);
-	if (!mmio_res->parent && align)
-		mmio.start = min(ALIGN(mmio.start, align), mmio.end + 1);
+		available[i] = available_in[i];
 
-	align = pci_resource_alignment(bridge, mmio_pref_res);
-	if (!mmio_pref_res->parent && align)
-		mmio_pref.start = min(ALIGN(mmio_pref.start, align),
-			mmio_pref.end + 1);
+		/*
+		 * The alignment of this bridge is yet to be considered,
+		 * hence it must be done now before extending its bridge
+		 * window.
+		 */
+		align = pci_resource_alignment(bridge, res);
+		if (!res->parent && align)
+			available[i].start = min(ALIGN(available[i].start, align),
+						 available[i].end + 1);
 
-	/*
-	 * Now that we have adjusted for alignment, update the bridge window
-	 * resources to fill as much remaining resource space as possible.
-	 */
-	adjust_bridge_window(bridge, io_res, add_list, resource_size(&io));
-	adjust_bridge_window(bridge, mmio_res, add_list, resource_size(&mmio));
-	adjust_bridge_window(bridge, mmio_pref_res, add_list,
-			     resource_size(&mmio_pref));
+		/*
+		 * Now that we have adjusted for alignment, update the
+		 * bridge window resources to fill as much remaining
+		 * resource space as possible.
+		 */
+		adjust_bridge_window(bridge, res, add_list,
+				     resource_size(&available[i]));
+	}
 
 	/*
 	 * Calculate how many hotplug bridges and normal bridges there
@@ -2161,7 +2159,7 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 	 */
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		if (!dev->is_virtfn)
-			remove_dev_resources(dev, &io, &mmio, &mmio_pref);
+			remove_dev_resources(dev, available);
 	}
 
 	/*
@@ -2173,16 +2171,9 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 	 * split between non-hotplug bridges. This is to allow possible
 	 * hotplug bridges below them to get the extra space as well.
 	 */
-	if (hotplug_bridges) {
-		io_per_b = div64_ul(resource_size(&io), hotplug_bridges);
-		mmio_per_b = div64_ul(resource_size(&mmio), hotplug_bridges);
-		mmio_pref_per_b = div64_ul(resource_size(&mmio_pref),
-					   hotplug_bridges);
-	} else {
-		io_per_b = div64_ul(resource_size(&io), normal_bridges);
-		mmio_per_b = div64_ul(resource_size(&mmio), normal_bridges);
-		mmio_pref_per_b = div64_ul(resource_size(&mmio_pref),
-					   normal_bridges);
+	for (i = 0; i < PCI_P2P_BRIDGE_RESOURCE_NUM; i++) {
+		per_bridge[i] = div64_ul(resource_size(&available[i]),
+					 hotplug_bridges ?: normal_bridges);
 	}
 
 	for_each_pci_bridge(dev, bus) {
@@ -2195,49 +2186,41 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
 		if (hotplug_bridges && !dev->is_hotplug_bridge)
 			continue;
 
-		res = &dev->resource[PCI_BRIDGE_IO_WINDOW];
+		for (i = 0; i < PCI_P2P_BRIDGE_RESOURCE_NUM; i++) {
+			res = pci_bus_resource_n(bus, i);
 
-		/*
-		 * Make sure the split resource space is properly aligned
-		 * for bridge windows (align it down to avoid going above
-		 * what is available).
-		 */
-		align = pci_resource_alignment(dev, res);
-		resource_set_size(&io, ALIGN_DOWN_IF_NONZERO(io_per_b, align));
-
-		/*
-		 * The x_per_b holds the extra resource space that can be
-		 * added for each bridge but there is the minimal already
-		 * reserved as well so adjust x.start down accordingly to
-		 * cover the whole space.
-		 */
-		io.start -= resource_size(res);
-
-		res = &dev->resource[PCI_BRIDGE_MEM_WINDOW];
-		align = pci_resource_alignment(dev, res);
-		resource_set_size(&mmio,
-				  ALIGN_DOWN_IF_NONZERO(mmio_per_b,align));
-		mmio.start -= resource_size(res);
+			/*
+			 * Make sure the split resource space is properly
+			 * aligned for bridge windows (align it down to
+			 * avoid going above what is available).
+			 */
+			align = pci_resource_alignment(dev, res);
+			resource_set_size(&available[i],
+					  ALIGN_DOWN_IF_NONZERO(per_bridge[i],
+								align));
 
-		res = &dev->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
-		align = pci_resource_alignment(dev, res);
-		resource_set_size(&mmio_pref,
-				  ALIGN_DOWN_IF_NONZERO(mmio_pref_per_b, align));
-		mmio_pref.start -= resource_size(res);
+			/*
+			 * The per_bridge holds the extra resource space
+			 * that can be added for each bridge but there is
+			 * the minimal already reserved as well so adjust
+			 * x.start down accordingly to cover the whole
+			 * space.
+			 */
+			available[i].start -= resource_size(res);
+		}
 
-		pci_bus_distribute_available_resources(b, add_list, io, mmio,
-						       mmio_pref);
+		pci_bus_distribute_available_resources(b, add_list, available);
 
-		io.start += io.end + 1;
-		mmio.start += mmio.end + 1;
-		mmio_pref.start += mmio_pref.end + 1;
+		for (i = 0; i < PCI_P2P_BRIDGE_RESOURCE_NUM; i++)
+			available[i].start += available[i].end + 1;
 	}
 }
 
 static void pci_bridge_distribute_available_resources(struct pci_dev *bridge,
 						      struct list_head *add_list)
 {
-	struct resource available_io, available_mmio, available_mmio_pref;
+	struct resource *res, available[PCI_P2P_BRIDGE_RESOURCE_NUM];
+	unsigned int i;
 
 	if (!bridge->is_hotplug_bridge)
 		return;
@@ -2245,14 +2228,13 @@ static void pci_bridge_distribute_available_resources(struct pci_dev *bridge,
 	pci_dbg(bridge, "distributing available resources\n");
 
 	/* Take the initial extra resources from the hotplug port */
-	available_io = bridge->resource[PCI_BRIDGE_IO_WINDOW];
-	available_mmio = bridge->resource[PCI_BRIDGE_MEM_WINDOW];
-	available_mmio_pref = bridge->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
+	for (i = 0; i < PCI_P2P_BRIDGE_RESOURCE_NUM; i++) {
+		res = pci_resource_n(bridge, PCI_BRIDGE_RESOURCES + i);
+		available[i] = *res;
+	}
 
 	pci_bus_distribute_available_resources(bridge->subordinate,
-					       add_list, available_io,
-					       available_mmio,
-					       available_mmio_pref);
+					       add_list, available);
 }
 
 static bool pci_bridge_resources_not_assigned(struct pci_dev *dev)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 275df4058767..723e9cede69d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -119,7 +119,8 @@ enum {
 #define PCI_CB_BRIDGE_MEM_1_WINDOW	(PCI_BRIDGE_RESOURCES + 3)
 
 /* Total number of bridge resources for P2P and CardBus */
-#define PCI_BRIDGE_RESOURCE_NUM 4
+#define PCI_P2P_BRIDGE_RESOURCE_NUM	3
+#define PCI_BRIDGE_RESOURCE_NUM		4
 
 	/* Resources assigned to buses behind the bridge */
 	PCI_BRIDGE_RESOURCES,
-- 
2.39.5


