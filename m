Return-Path: <linux-pci+bounces-43416-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 413A5CD130D
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5B633001BE3
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 17:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45682339B4F;
	Fri, 19 Dec 2025 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kXQtDNM7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D372DC32B;
	Fri, 19 Dec 2025 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166059; cv=none; b=OGxIEHsOjy+iKkMejO/XYr3KieSm3ibG3Q5QGTXuq8QG5BQhQDMPkT6osx2C3tWT0yRMo2bDizLOfXrxoKo7AtXJHq+V85u1riZ44ypStkrd55+xvG4jQvnJ3+jwME+9AkY/WVnzzRjuGSYABvIRVLUfsMhJYyaXZTamj6FKOz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166059; c=relaxed/simple;
	bh=6k6XnSLCX0J/usKJONUDwI7bCA9yVh1g+rcsjInq7KI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LH032ePjp+PS9MHgEhJoJ2NUTWAwzt39U3j8j3c7EDvoGyrr191lzClHNs4JYl4YTtZT6nBFua1YQT7zgu78G4z2E+U1qA5iT4MH37GwSUnZEIOJw6YdNX1qVeZ7uxWhiqbH4isTlSq8qNPSq8WTXcGWu/xwM4K94ex9482RWbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kXQtDNM7; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766166057; x=1797702057;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6k6XnSLCX0J/usKJONUDwI7bCA9yVh1g+rcsjInq7KI=;
  b=kXQtDNM7SiQa7+zMkMG+FE89qevGlN8ctePhltiE0roO7p+cfwpLXTna
   QPOHeJ8A6xUJfqPx6wk/2aZogvhTAQM4Zoow92JqBghkCoVLVPHx4JJoa
   FMIe1qadleMFASiVwm1tBEhZSvsvFrjoPh49leZnjunJYTquGEGCMu2hi
   VRqVEFEVEQhxwVMI2RVggI1eC6495EtOGZwRqBN71r/FAO2fObYEcyd2F
   uupZfE8Ruytdz2iiFFj+QMN7pAmnokMT0wPSICiltcRJrmejfvRkmhK1f
   iQTQbvZk6u8ZvV+UCU4b9dOEGCYQOhdj5+E/bab6dnUa7YObjcFSEbtcr
   w==;
X-CSE-ConnectionGUID: 6jMljgSiRbyMOtJixyzisw==
X-CSE-MsgGUID: Dl0SJl1VTseSzyjFifU6Nw==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="68173769"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="68173769"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:40:55 -0800
X-CSE-ConnectionGUID: mzIiNWYsQvayGFFC1KzCdw==
X-CSE-MsgGUID: 5jGnh02wR+Ou6ciWVrBFbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="198974779"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:40:51 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Wei Yang <weiyang@linux.vnet.ibm.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	=?UTF-8?q?Malte=20Schr=C3=B6der?= <malte+lkml@tnxip.de>,
	stable@vger.kernel.org
Subject: [PATCH 01/23] PCI: Fix bridge window alignment with optional resources
Date: Fri, 19 Dec 2025 19:40:14 +0200
Message-Id: <20251219174036.16738-2-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
References: <20251219174036.16738-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pbus_size_mem() has two alignments, one for required resources in
min_align and another in add_align that takes account optional
resources.

The add_align is applied to the bridge window through the realloc_head
list. It can happen, however, that add_align is larger than min_align
but calculated size1 and size0 are equal due to extra tailroom (e.g.,
hotplug reservation, tail alignment), and therefore no entry is created
to the realloc_head list. Without the bridge appearing in the realloc
head, add_align is lost when pbus_size_mem() returns.

The problem is visible in this log for 0000:05:00.0 which lacks
add_size ... add_align ... line that would indicate it was added into
the realloc_head list:

pci 0000:05:00.0: PCI bridge to [bus 06-16]
...
pci 0000:06:00.0: bridge window [mem 0x00100000-0x001fffff] to [bus 07] requires relaxed alignment rules
pci 0000:06:06.0: bridge window [mem 0x00100000-0x001fffff] to [bus 0a] requires relaxed alignment rules
pci 0000:06:07.0: bridge window [mem 0x00100000-0x003fffff] to [bus 0b] requires relaxed alignment rules
pci 0000:06:08.0: bridge window [mem 0x00800000-0x00ffffff 64bit pref] to [bus 0c-14] requires relaxed alignment rules
pci 0000:06:08.0: bridge window [mem 0x01000000-0x057fffff] to [bus 0c-14] requires relaxed alignment rules
pci 0000:06:08.0: bridge window [mem 0x01000000-0x057fffff] to [bus 0c-14] requires relaxed alignment rules
pci 0000:06:08.0: bridge window [mem 0x01000000-0x057fffff] to [bus 0c-14] add_size 100000 add_align 1000000
pci 0000:06:0c.0: bridge window [mem 0x00100000-0x001fffff] to [bus 15] requires relaxed alignment rules
pci 0000:06:0d.0: bridge window [mem 0x00100000-0x001fffff] to [bus 16] requires relaxed alignment rules
pci 0000:06:0d.0: bridge window [mem 0x00100000-0x001fffff] to [bus 16] requires relaxed alignment rules
pci 0000:05:00.0: bridge window [mem 0xd4800000-0xd97fffff]: assigned
pci 0000:05:00.0: bridge window [mem 0x1060000000-0x10607fffff 64bit pref]: assigned
pci 0000:06:08.0: bridge window [mem size 0x04900000]: can't assign; no space
pci 0000:06:08.0: bridge window [mem size 0x04900000]: failed to assign

While this bug itself seems old, it has likely become more visible
after the relaxed tail alignment that does not grossly overestimate the
size needed for the bridge window.

Make sure add_align > min_align too results in adding an entry into the
realloc head list. In addition, add handling to the cases where
add_size is zero while only alignment differs.

Fixes: d74b9027a4da ("PCI: Consider additional PF's IOV BAR alignment in sizing and assigning")
Reported-by: Malte Schröder <malte+lkml@tnxip.de>
Tested-by: Malte Schröder <malte+lkml@tnxip.de>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org
---
 drivers/pci/setup-bus.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 6e90f46f52af..4b918ff4d2d8 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -14,6 +14,7 @@
  *	     tighter packing. Prefetchable range support.
  */
 
+#include <linux/align.h>
 #include <linux/bitops.h>
 #include <linux/bug.h>
 #include <linux/init.h>
@@ -456,7 +457,7 @@ static void reassign_resources_sorted(struct list_head *realloc_head,
 					"%s %pR: ignoring failure in optional allocation\n",
 					res_name, res);
 			}
-		} else if (add_size > 0) {
+		} else if (add_size > 0 || !IS_ALIGNED(res->start, align)) {
 			res->flags |= add_res->flags &
 				 (IORESOURCE_STARTALIGN|IORESOURCE_SIZEALIGN);
 			if (pci_reassign_resource(dev, idx, add_size, align))
@@ -1442,12 +1443,13 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 
 	resource_set_range(b_res, min_align, size0);
 	b_res->flags |= IORESOURCE_STARTALIGN;
-	if (bus->self && size1 > size0 && realloc_head) {
+	if (bus->self && realloc_head && (size1 > size0 || add_align > min_align)) {
 		b_res->flags &= ~IORESOURCE_DISABLED;
-		add_to_list(realloc_head, bus->self, b_res, size1-size0, add_align);
+		add_size = size1 > size0 ? size1 - size0 : 0;
+		add_to_list(realloc_head, bus->self, b_res, add_size, add_align);
 		pci_info(bus->self, "bridge window %pR to %pR add_size %llx add_align %llx\n",
 			   b_res, &bus->busn_res,
-			   (unsigned long long) (size1 - size0),
+			   (unsigned long long) add_size,
 			   (unsigned long long) add_align);
 	}
 }
-- 
2.39.5


