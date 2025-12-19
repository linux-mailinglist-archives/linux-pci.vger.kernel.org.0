Return-Path: <linux-pci+bounces-43421-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82329CD133A
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 18:42:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48115303EFB5
	for <lists+linux-pci@lfdr.de>; Fri, 19 Dec 2025 17:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B79243968;
	Fri, 19 Dec 2025 17:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lnny9dI4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F589326948;
	Fri, 19 Dec 2025 17:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766166103; cv=none; b=R5rH1YRSt8XW7sdDcVEx0MGOrapnPn8lme2LX16bf8qUE9qfqgEQjEmdnRX8KtL/GFFeR7/gZmGk7RbMpLZhhPaJUb9ia3BMR2lJFx+XkBYEXNjRlGILzyuSyhjM3J5rFueVGt5qvbFn2Gzyoc4gtObl8pboy2K0bmUNTC1el9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766166103; c=relaxed/simple;
	bh=xSE+b71T+rrale/roOdvUNxaa0Z9eBYAjFEiBGR68VM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LgorNY8je0OuwKiLxV+6GOVLr9oaXjmUjv9+lDNwnfW6NIjkmvgAreUhk+8+5EZrAaFPpsQHqFhU17fukQ1Nb1PtgK6AlRxjux9nJGp9Cose9ipzCoh/MkVUi5XXKSprNU/AnP1j54hfuWkJ66YKrAomvxaebBDaMPmBUl9gPFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lnny9dI4; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766166101; x=1797702101;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xSE+b71T+rrale/roOdvUNxaa0Z9eBYAjFEiBGR68VM=;
  b=lnny9dI4nOlFp+E4NmYA6h9/W08jXCnioCIqBYKH6VHcy6uVOK+UsaG9
   7XI6HvM18B1bQZaxfq7I4pH1627zE47SxvwthP0VmqjLFN4XlfuPSYoJ/
   7tVO5KJzNaIho/uxLH54O027nZg8Cqnl6kYGyGc29aARJz7pdcgmopfxL
   sN/223MkOHg1DAkowdypyV/qAVv0NieRf1/dyR+DPRXUrfqKMaQZ7tNW5
   C5Ah2hRKsQNr5s8xCaNfdTCyNIL2eFXkV2efa9Bht30PW7uBNlJpFNHT2
   kHryLrkygWlWZrDhRqURwwmf0fs/RZw7ztY7Gvs0XF2WkgBk4hPzCzTLX
   A==;
X-CSE-ConnectionGUID: 8ex0sPBFSh+ct2jJt5pu0w==
X-CSE-MsgGUID: gouDggFHTcaDL8i+WHXisw==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="68062514"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="68062514"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:41:41 -0800
X-CSE-ConnectionGUID: Lp5besEGSTyFwbb83btu9g==
X-CSE-MsgGUID: o0AcQSYLQvS/8SCGG9AOvg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; 
   d="scan'208";a="199747954"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.61])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2025 09:41:38 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 06/23] PCI: Push realloc check into pbus_size_mem()
Date: Fri, 19 Dec 2025 19:40:19 +0200
Message-Id: <20251219174036.16738-7-ilpo.jarvinen@linux.intel.com>
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

pbus_size_mem() and calculate_memsize() input both min_size and
add_size. They are given the same value if realloc_head is NULL and
min_size is 0 otherwise. Both are used in calculate_memsize() to
enforce a lower bound to the size.

The interface between __pci_bus_size_bridges() and the forementioned
functions can be simplied by pushing the realloc check into
pbus_size_mem().

There are only two possible cases:

  1) when calculating size0, add_size parameter given to
     calculate_memsize() is always 0 which implies only min_size
     matters.

  2) when calculating size1, realloc_head is not NULL which implies
     min_size=0 so only add_size matters.

Drop min_size parameter from pbus_size_mem() and check realloc_head
when calling calculate_memsize(). Drop add_size from
calculate_memsize() and use only min_size within max() to enforce the
lower bound.

calculate_iosize() is a bit more complicated than calculate_memsize()
and is therefore left as is, but pbus_size_io() can still input only
min_size similar to pbus_size_mem().

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/setup-bus.c | 34 ++++++++++++----------------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 8660449f59bd..f85ae20dc894 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1069,14 +1069,10 @@ static resource_size_t calculate_iosize(resource_size_t size,
 
 static resource_size_t calculate_memsize(resource_size_t size,
 					 resource_size_t min_size,
-					 resource_size_t add_size,
 					 resource_size_t children_add_size,
 					 resource_size_t align)
 {
-	if (size < min_size)
-		size = min_size;
-
-	size = max(size, add_size) + children_add_size;
+	size = max(size, min_size) + children_add_size;
 	return ALIGN(size, align);
 }
 
@@ -1115,8 +1111,7 @@ static resource_size_t window_alignment(struct pci_bus *bus, unsigned long type)
  * pbus_size_io() - Size the I/O window of a given bus
  *
  * @bus:		The bus
- * @min_size:		The minimum I/O window that must be allocated
- * @add_size:		Additional optional I/O window
+ * @add_size:		Additional I/O window
  * @realloc_head:	Track the additional I/O window on this list
  *
  * Sizing the I/O windows of the PCI-PCI bridge is trivial, since these
@@ -1124,8 +1119,7 @@ static resource_size_t window_alignment(struct pci_bus *bus, unsigned long type)
  * devices are limited to 256 bytes.  We must be careful with the ISA
  * aliasing though.
  */
-static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
-			 resource_size_t add_size,
+static void pbus_size_io(struct pci_bus *bus, resource_size_t add_size,
 			 struct list_head *realloc_head)
 {
 	struct pci_dev *dev;
@@ -1170,7 +1164,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 		}
 	}
 
-	size0 = calculate_iosize(size, min_size, size1, 0, 0,
+	size0 = calculate_iosize(size, realloc_head ? 0 : add_size, size1, 0, 0,
 			resource_size(b_res), min_align);
 
 	if (size0)
@@ -1178,7 +1172,7 @@ static void pbus_size_io(struct pci_bus *bus, resource_size_t min_size,
 
 	size1 = size0;
 	if (realloc_head && (add_size > 0 || children_add_size > 0)) {
-		size1 = calculate_iosize(size, min_size, size1, add_size,
+		size1 = calculate_iosize(size, 0, size1, add_size,
 					 children_add_size, resource_size(b_res),
 					 min_align);
 	}
@@ -1269,8 +1263,7 @@ static resource_size_t calculate_head_align(resource_size_t *aligns,
  *
  * @bus:		The bus
  * @type:		The type of bridge resource
- * @min_size:		The minimum memory window that must be allocated
- * @add_size:		Additional optional memory window
+ * @add_size:		Additional memory window
  * @realloc_head:	Track the additional memory window on this list
  *
  * Calculate the size of the bus resource for @type and minimal alignment
@@ -1283,7 +1276,6 @@ static resource_size_t calculate_head_align(resource_size_t *aligns,
  * supplied.
  */
 static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
-			 resource_size_t min_size,
 			 resource_size_t add_size,
 			 struct list_head *realloc_head)
 {
@@ -1363,7 +1355,8 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 	win_align = window_alignment(bus, b_res->flags);
 	min_align = calculate_head_align(aligns, max_order);
 	min_align = max(min_align, win_align);
-	size0 = calculate_memsize(size, min_size, 0, 0, win_align);
+	size0 = calculate_memsize(size, realloc_head ? 0 : add_size,
+				  0, win_align);
 
 	if (size0) {
 		resource_set_range(b_res, min_align, size0);
@@ -1372,7 +1365,7 @@ static void pbus_size_mem(struct pci_bus *bus, unsigned long type,
 
 	if (realloc_head && (add_size > 0 || children_add_size > 0)) {
 		add_align = max(min_align, add_align);
-		size1 = calculate_memsize(size, min_size, add_size, children_add_size,
+		size1 = calculate_memsize(size, add_size, children_add_size,
 					  win_align);
 	}
 
@@ -1550,20 +1543,17 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 		}
 		fallthrough;
 	default:
-		pbus_size_io(bus, realloc_head ? 0 : additional_io_size,
-			     additional_io_size, realloc_head);
+		pbus_size_io(bus, additional_io_size, realloc_head);
 
 		if (pref && (pref->flags & IORESOURCE_PREFETCH)) {
 			pbus_size_mem(bus,
 				      IORESOURCE_MEM | IORESOURCE_PREFETCH |
 				      (pref->flags & IORESOURCE_MEM_64),
-				      realloc_head ? 0 : additional_mmio_pref_size,
 				      additional_mmio_pref_size, realloc_head);
 		}
 
-		pbus_size_mem(bus, IORESOURCE_MEM,
-			      realloc_head ? 0 : additional_mmio_size,
-			      additional_mmio_size, realloc_head);
+		pbus_size_mem(bus, IORESOURCE_MEM, additional_mmio_size,
+			      realloc_head);
 		break;
 	}
 }
-- 
2.39.5


