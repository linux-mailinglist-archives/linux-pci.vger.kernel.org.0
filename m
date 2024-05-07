Return-Path: <linux-pci+bounces-7159-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C839F8BDFB2
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 12:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 800C6287A3A
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 10:28:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A471509A2;
	Tue,  7 May 2024 10:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XGcApnKE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E803815099D;
	Tue,  7 May 2024 10:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715077622; cv=none; b=N5jcJx7Y9p2I567TLP4vRwCYHhCybC+U6nbdXJN5VS/dS1HETlGimiKE3Qb4f2OcSmdUqgQL7YNiaLUSow8lK95Vuf7aMqUMoo0oENKEx6Nwqd45luhax+yk8H0fx+6KA82lix338aGJNFn2QqkhYB5VEhWZI/nozm4GkePE1UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715077622; c=relaxed/simple;
	bh=nt/ZLutgromZ7gcwB6Dx88HxYCkd13s5thFkq0sTUgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dEGG5v75gZnoQlK4nCjwhkCZ8HA4lHEmaMMiH3OexzUtS1NwSMvA55F6hTW4CSduWceL21v9QJeC4Ube0k23lXdv9rUMavYfK+e85Wpuuo26WqvYLbyZARA2k3XmGUpm7n90IUBV9K9cVkcBwubICSBXYgMHRdrr+2aaU5pupTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XGcApnKE; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715077621; x=1746613621;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nt/ZLutgromZ7gcwB6Dx88HxYCkd13s5thFkq0sTUgo=;
  b=XGcApnKEDn2PSU+fYCVUJDbaRMGr5NjB7NPVM/sKOtBwar2D/fbdYL3a
   9EsRfq3g4/jRiJmUolgIZWnNWtfmvC0Om+mxQ3huU8FCe00EI/DxMqdBu
   N59VCWcKtk0kdLjsBBHnZRRDkIsm8o92R+5lQAdIkCHpZrEsOPzCuuHfg
   wzYRjYrnDLzoGGJ4Kv6MXriKI5YmfPVoPRIFEx6sJDQy97IbWzvd/lHKI
   2SUcjTNc5UgB0syUluGMDx3h+dOVHilpyzNVzYLp8zfch25fCYwlv9Npr
   ZjJinQBbEbNWllLrzm4QucOuy1YD60SSzodv35E/GaxOLN/tO0nTGtJ+I
   w==;
X-CSE-ConnectionGUID: ZmscuW21T8KM9hCIK0FJwg==
X-CSE-MsgGUID: 2JSlOsT+SnS+ummjeAUlaQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="10987193"
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="10987193"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 03:27:01 -0700
X-CSE-ConnectionGUID: T6h0186/TKC0AdLZaYMvMQ==
X-CSE-MsgGUID: ljHjrteKTm2UmOKNsvbwIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,261,1708416000"; 
   d="scan'208";a="28535704"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.74])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 03:26:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Lidong Wang <lidong.wang@intel.com>
Subject: [PATCH v3 8/8] PCI: Relax bridge window tail sizing rules
Date: Tue,  7 May 2024 13:25:23 +0300
Message-Id: <20240507102523.57320-9-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240507102523.57320-1-ilpo.jarvinen@linux.intel.com>
References: <20240507102523.57320-1-ilpo.jarvinen@linux.intel.com>
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

inside calculate_memsize(), for the largest alignment:
	min_align = align1 >> 1;
	...
	return min_align;

and then in calculate_memsize():
	return ALIGN(max(size, ...), align);

If the original bridge window sizing tried to conserve space, this will
lead to massive increase of the required bridge window size when the
downstream has a large disparity in BAR sizes. E.g., with 16MiB and
16GiB BARs this results in 24GiB bridge window size even if 16MiB BAR
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

pci 0000:03:00.0: device released
pci 0000:02:01.0: device released
pcieport 0000:01:00.0: scanning [bus 02-04] behind bridge, pass 0
pci 0000:02:01.0: PCI bridge to [bus 03]
pci 0000:02:01.0:   bridge window [mem 0x40400000-0x405fffff]
pci 0000:02:01.0:   bridge window [mem 0x6000000000-0x6400ffffff 64bit pref]
pci 0000:02:01.0: scanning [bus 03-03] behind bridge, pass 0
pci 0000:03:00.0: BAR 0 [mem 0x6400000000-0x6400ffffff 64bit pref]
pci 0000:03:00.0: BAR 2 [mem 0x6000000000-0x63ffffffff 64bit pref]
pci 0000:03:00.0: ROM [mem 0x40400000-0x405fffff pref]

pci 0000:02:01.0: PCI bridge to [bus 03]
pci 0000:02:01.0: scanning [bus 03-03] behind bridge, pass 1
pcieport 0000:01:00.0: scanning [bus 02-04] behind bridge, pass 1
pci 0000:02:01.0: bridge window [mem size 0x600000000 64bit pref]: can't assign; no space
pci 0000:02:01.0: bridge window [mem size 0x600000000 64bit pref]: failed to assign
pci 0000:02:01.0: bridge window [mem 0x40400000-0x405fffff]: assigned
pci 0000:03:00.0: BAR 2 [mem size 0x400000000 64bit pref]: can't assign; no space
pci 0000:03:00.0: BAR 2 [mem size 0x400000000 64bit pref]: failed to assign
pci 0000:03:00.0: BAR 0 [mem size 0x01000000 64bit pref]: can't assign; no space
pci 0000:03:00.0: BAR 0 [mem size 0x01000000 64bit pref]: failed to assign
pci 0000:03:00.0: ROM [mem 0x40400000-0x405fffff pref]: assigned
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
pci 0000:02:01.0: scanning [bus 03-03] behind bridge, pass 1
pcieport 0000:01:00.0: scanning [bus 02-04] behind bridge, pass 1
pcieport 0000:01:00.0: Assigned bridge window [mem 0x6000000000-0x6400ffffff 64bit pref] to [bus 02-04] cannot fit 0x600000000 required for 0000:02:01.0 bridging to [bus 03]
pci 0000:02:01.0: bridge window [mem 0x6000000000-0x6400ffffff 64bit pref] to [bus 03] requires relaxed alignment rules
pcieport 0000:01:00.0: Assigned bridge window [mem 0x40400000-0x406fffff] to [bus 02-04] free space at [mem 0x40400000-0x405fffff]
pci 0000:02:01.0: bridge window [mem 0x6000000000-0x6400ffffff 64bit pref]: assigned
pci 0000:02:01.0: bridge window [mem 0x40400000-0x405fffff]: assigned
pci 0000:03:00.0: BAR 2 [mem 0x6000000000-0x63ffffffff 64bit pref]: assigned
pci 0000:03:00.0: BAR 0 [mem 0x6400000000-0x6400ffffff 64bit pref]: assigned
pci 0000:03:00.0: ROM [mem 0x40400000-0x405fffff pref]: assigned
pci 0000:02:01.0: PCI bridge to [bus 03]
pci 0000:02:01.0:   bridge window [mem 0x40400000-0x405fffff]
pci 0000:02:01.0:   bridge window [mem 0x6000000000-0x6400ffffff 64bit pref]

This patch draws inspiration from the initial investigations and work
by Mika Westerberg.

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=216795
Link: https://lore.kernel.org/linux-pci/20190812144144.2646-1-mika.westerberg@linux.intel.com/
Fixes: 5d0a8965aea9 ("[PATCH] 2.5.14: New PCI allocation code (alpha, arm, parisc) [2/2]")
Tested-by: Lidong Wang <lidong.wang@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/setup-bus.c | 79 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index bca1df46f19c..11ee60b9ca71 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -22,6 +22,7 @@
 #include <linux/errno.h>
 #include <linux/ioport.h>
 #include <linux/cache.h>
+#include <linux/limits.h>
 #include <linux/sizes.h>
 #include <linux/slab.h>
 #include <linux/acpi.h>
@@ -971,6 +972,67 @@ static inline resource_size_t calculate_mem_align(resource_size_t *aligns,
 	return min_align;
 }
 
+/**
+ * pbus_upstream_space_available - Check no upstream resource limits allocation
+ * @bus:	The bus
+ * @mask:	Mask the resource flag, then compare it with type
+ * @type:	The type of resource from bridge
+ * @size:	The size required from the bridge window
+ * @align:	Required alignment for the resource
+ *
+ * Checks that @size can fit inside the upstream bridge resources that are
+ * already assigned.
+ *
+ * Return: %true if enough space is available on all assigned upstream
+ * resources.
+ */
+static bool pbus_upstream_space_available(struct pci_bus *bus, unsigned long mask,
+					  unsigned long type, resource_size_t size,
+					  resource_size_t align)
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
+				if (find_resource_space(r, &gap, size, &constraint) == 0) {
+					gap.flags = type;
+					pci_dbg(bus->self,
+						"Assigned bridge window %pR to %pR free space at %pR\n",
+						r, &bus->busn_res, &gap);
+					return true;
+				}
+			}
+
+			if (bus->self) {
+				pci_info(bus->self,
+					 "Assigned bridge window %pR to %pR cannot fit 0x%llx required for %s bridging to %pR\n",
+					 r, &bus->busn_res,
+					 (unsigned long long)size,
+					 pci_name(downstream->self),
+					 &downstream->busn_res);
+			}
+
+			return false;
+		}
+	}
+
+	return true;
+}
+
 /**
  * pbus_size_mem() - Size the memory window of a given bus
  *
@@ -997,7 +1059,7 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
 			 struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
-	resource_size_t min_align, align, size, size0, size1;
+	resource_size_t min_align, win_align, align, size, size0, size1;
 	resource_size_t aligns[24]; /* Alignments from 1MB to 8TB */
 	int order, max_order;
 	struct resource *b_res = find_bus_resource_of_type(bus,
@@ -1076,10 +1138,23 @@ static int pbus_size_mem(struct pci_bus *bus, unsigned long mask,
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
+	    !pbus_upstream_space_available(bus, mask | IORESOURCE_PREFETCH, type,
+					   size0, add_align)) {
+		min_align = 1ULL << (max_order + __ffs(SZ_1M));
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
2.39.2


