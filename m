Return-Path: <linux-pci+bounces-1513-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8545B81FA26
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 18:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0606B22F83
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 16:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18909101CE;
	Thu, 28 Dec 2023 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LARfE/EZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B12410A06;
	Thu, 28 Dec 2023 16:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703782715; x=1735318715;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9cmBqpNWxOkx/qRL+GcnO2FP0hog/X0WaEdjSaE40iI=;
  b=LARfE/EZYUnTKh5Nv3Zu2DP9KF+4Zu39FXYjJBv7Ly6cvHhaYoYSvY56
   YQJDvm9mJdjH8KlZ8M//Esik1j0WM0MH13dbe+ALAIqivMwpnjL6QrMkF
   1alqq41ASjR1AD2xxRfgNN/Q2MnI9o1Io7NNmYCI1Nfn89Lxprq2jbbA+
   slDfHD3kMdTDI7hSyaXFr5O60VG+7sdT0gAez5uD8Lh4kI8qu9/1e2Piy
   b4NyF3Nt6aVTec88f4Hl/6sYf75j7HwWng6PN5uwrqnmZNGpiF+weBCHg
   LQE6qvmWERvjeM6BSc+2Q/qfPrBK1cCDbOzx5GU2r6mS1TvJeQAylvNun
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="381536710"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="381536710"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 08:58:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="844488561"
X-IronPort-AV: E=Sophos;i="6.04,312,1695711600"; 
   d="scan'208";a="844488561"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.94.250.171])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2023 08:58:30 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 7/7] PCI: Relax bridge window tail sizing rules
Date: Thu, 28 Dec 2023 18:57:07 +0200
Message-Id: <20231228165707.3447-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231228165707.3447-1-ilpo.jarvinen@linux.intel.com>
References: <20231228165707.3447-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

During remove & rescan cycle, PCI subsystem will recalculate and adjust
the bridge window sizing that was initially done by "BIOS". The size
calculation is based on the required alignment of the largest resource
among the downstream resources as per pbus_size_mem() (unimportant or
zero parameters marked with "..."):

	min_align = calculate_mem_align(aligns, max_order);
	size0 = calculate_memsize(size, ..., min_align);

and then in calculate_memsize():
	size = ALIGN(max(size, ...) + ..., align);

If the original bridge window sizing tried to conserve space, this will
lead to massive increase of the required bridge window size when the
downstream has a large disparity in BAR sizes. E.g., with 16MiB and
16GiB BARs this results in 32GiB bridge window size even if 16MiB BAR
does not require gigabytes of space to fit.

When doing remove & rescan for a bus that contains such a PCI device, a
larger bridge window is suddenly required on rescan but when there is a
bridge window upstream that is already assigned based on the original
size, it cannot be enlarged to the new requirement. This causes the
allocation of the bridge window to fail (0x600000000 > 0x400ffffff):

pci 0000:02:01.0: PCI bridge to [bus 03]
pci 0000:02:01.0:   bridge window [mem 0x40400000-0x405fffff]
pci 0000:02:01.0:   bridge window [mem 0x6000000000-0x6400ffffff 64bit pref]
pci 0000:01:00.0: PCI bridge to [bus 02-04]
pci 0000:01:00.0:   bridge window [mem 0x40400000-0x406fffff]
pci 0000:01:00.0:   bridge window [mem 0x6000000000-0x6400ffffff 64bit pref]
...
pci_bus 0000:03: busn_res: [bus 03] is released
pci 0000:03:00.0: reg 0x10: [mem 0x6400000000-0x6400ffffff 64bit pref]
pci 0000:03:00.0: reg 0x18: [mem 0x6000000000-0x63ffffffff 64bit pref]
pci 0000:03:00.0: reg 0x30: [mem 0x40400000-0x405fffff pref]
pci 0000:02:01.0: PCI bridge to [bus 03]
pci 0000:02:01.0:   bridge window [mem 0x40400000-0x405fffff]
pci 0000:02:01.0:   bridge window [mem 0x6000000000-0x6400ffffff 64bit pref]
pci 0000:02:01.0: BAR 9: no space for [mem size 0x600000000 64bit pref]
pci 0000:02:01.0: BAR 9: failed to assign [mem size 0x600000000 64bit pref]
pci 0000:02:01.0: BAR 8: assigned [mem 0x40400000-0x405fffff]
pci 0000:03:00.0: BAR 2: no space for [mem size 0x400000000 64bit pref]
pci 0000:03:00.0: BAR 2: failed to assign [mem size 0x400000000 64bit pref]
pci 0000:03:00.0: BAR 0: no space for [mem size 0x01000000 64bit pref]
pci 0000:03:00.0: BAR 0: failed to assign [mem size 0x01000000 64bit pref]
pci 0000:03:00.0: BAR 6: assigned [mem 0x40400000-0x405fffff pref]
pci 0000:02:01.0: PCI bridge to [bus 03]
pci 0000:02:01.0:   bridge window [mem 0x40400000-0x405fffff]

This is a major surprise for users who are suddenly left with a PCIe
device that was working fine with the original bridge window sizing.

Even if the already assigned bridge window could be enlarged by
reallocation in some cases (something the current code does not attempt
to do), it is not possible in general case and the large amount of
wasted space at the tail of the bridge window may lead to other
resource exhaustion problems on Root Complex level (think of multiple
PCIe cards with VFs and BAR size disparity in a single system).

PCI specifications only expect natural alignment for BARs (PCI Express
Base Specification, rev. 6.1 sect. 7.5.1.2.1) and minimum of 1MiB
alignment for the bridge window (PCI Express Base Specification,
rev 6.1 sect. 7.5.1.3). The current bridge window tail alignment rule
was introduced in the commit 5d0a8965aea9 ("[PATCH] 2.5.14: New PCI
allocation code (alpha, arm, parisc) [2/2]") that only states:
"pbus_size_mem: core stuff; tested with randomly generated sets of
resources". It does not explain the motivation for the extra tail space
allocated that is not truly needed by the downstream resources. As
such, it is far from clear if it ever has been required by any HW.

To prevent PCIe cards with BAR size disparity from becoming unusable
after remove & rescan cycle, attempt to do a truly minimal allocation
for memory resources if needed. First check if the normally calculated
bridge window will not fit into an already assigned upstream resource.
In such case, try with relaxed bridge window tail sizing rules instead
where no extra tail space is requested beyond what the downstream
resources require. Only enforce the alignment requirement of the bridge
window itself (normally 1MiB).

With this patch, the resources are successfully allocated:

pci 0000:02:01.0: PCI bridge to [bus 03]
pci 0000:02:01.0:   bridge window [mem 0x40400000-0x405fffff]
pci 0000:02:01.0:   bridge window [mem 0x6000000000-0x6400ffffff 64bit pref]
pci 0000:02:01.0: bridge window [mem 0x6000000000-0x6400ffffff 64bit pref] to [bus 03] requires relaxed alignment rules
pci 0000:02:01.0: BAR 9: assigned [mem 0x6000000000-0x6400ffffff 64bit pref]
pci 0000:02:01.0: BAR 8: assigned [mem 0x40400000-0x405fffff]
pci 0000:03:00.0: BAR 2: assigned [mem 0x6000000000-0x63ffffffff 64bit pref]
pci 0000:03:00.0: BAR 0: assigned [mem 0x6400000000-0x6400ffffff 64bit pref]
pci 0000:03:00.0: BAR 6: assigned [mem 0x40400000-0x405fffff pref]
pci 0000:02:01.0: PCI bridge to [bus 03]
pci 0000:02:01.0:   bridge window [mem 0x40400000-0x405fffff]
pci 0000:02:01.0:   bridge window [mem 0x6000000000-0x6400ffffff 64bit pref]

This patch draws inspiration from the initial investigations and work
by Mika Westerberg.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=216795
Link: https://lore.kernel.org/linux-pci/20190812144144.2646-1-mika.westerberg@linux.intel.com/
Fixes: 5d0a8965aea9 ("[PATCH] 2.5.14: New PCI allocation code (alpha, arm, parisc) [2/2]")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/setup-bus.c | 74 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index e3e6ff8854a7..7a32283262c2 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -21,6 +21,7 @@
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/cache.h>
+#include <linux/limits.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
 #include "pci.h"
@@ -960,6 +961,62 @@ static inline resource_size_t calculate_mem_align(resource_size_t *aligns,
 	return min_align;
 }
 
+/**
+ * pbus_upstream_assigned_limit - Check no upstream resource limits allocation
+ * @bus:	The bus
+ * @mask:	Mask the resource flag, then compare it with type
+ * @type:	The type of resource from bridge
+ * @size:	The size required from the bridge window
+ * @align:	Required alignment for the resource
+ *
+ * Checks that @size can fit inside the upstream bridge resources that are
+ * already assigned.
+ *
+ * Return: -ENOSPC if @size cannot fit into an already assigned resource
+ * upstream resource.
+ */
+static int pbus_upstream_assigned_limit(struct pci_bus *bus, unsigned long mask,
+					unsigned long type, resource_size_t size,
+					resource_size_t align)
+{
+	struct resource_constraint constraint = {
+		.max = RESOURCE_SIZE_MAX,
+		.align = align,
+	};
+	struct pci_bus *downstream = bus;
+	struct resource *r;
+
+	while ((bus = bus->parent)) {
+		if (pci_is_root_bus(bus))
+			break;
+
+		pci_bus_for_each_resource(bus, r) {
+			if (!r || !r->parent || (r->flags & mask) != type)
+				continue;
+
+			if (resource_size(r) >= size) {
+				struct resource gap = {};
+
+				if (!find_empty_resource_slot(r, &gap, size, &constraint))
+					return 0;
+			}
+
+			if (bus->self) {
+				pci_dbg(bus->self,
+					"Assigned bridge window %pR to %pR cannot fit 0x%llx required for %s bridging to %pR\n",
+					r, &bus->busn_res,
+					(unsigned long long)size,
+					pci_name(downstream->self),
+					&downstream->busn_res);
+			}
+
+			return -ENOSPC;
+		}
+	}
+
+	return 0;
+}
+
 /**
  * pbus_size_mem() - Size the memory window of a given bus
  *
@@ -986,7 +1043,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			 struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
-	resource_size_t min_align, align, size, size0, size1;
+	resource_size_t min_align, win_align, align, size, size0, size1;
 	resource_size_t aligns[24]; /* Alignments from 1MB to 8TB */
 	int order, max_order;
 	struct resource *b_res = find_bus_resource_of_type(bus,
@@ -1064,10 +1121,23 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 		}
 	}
 
+	win_align = window_alignment(bus, b_res->flags);
 	min_align = calculate_mem_align(aligns, max_order);
-	min_align = max(min_align, window_alignment(bus, b_res->flags));
+	min_align = max(min_align, win_align);
 	size0 = calculate_memsize(size, min_size, 0, 0, resource_size(b_res), min_align);
 	add_align = max(min_align, add_align);
+
+	if (bus->self && size0 &&
+	    pbus_upstream_assigned_limit(bus, mask | IORESOURCE_PREFETCH, type,
+					 size0, add_align)) {
+		min_align = 1ULL << (max_order + 20);
+		min_align = max(min_align, win_align);
+		size0 = calculate_memsize(size, min_size, 0, 0, resource_size(b_res), win_align);
+		add_align = win_align;
+		pci_info(bus->self, "bridge window %pR to %pR requires relaxed alignment rules\n",
+			 b_res, &bus->busn_res);
+	}
+
 	size1 = (!realloc_head || (realloc_head && !add_size && !children_add_size)) ? size0 :
 		calculate_memsize(size, min_size, add_size, children_add_size,
 				resource_size(b_res), add_align);
-- 
2.30.2


