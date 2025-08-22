Return-Path: <linux-pci+bounces-34558-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D047B317EE
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 14:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 659B7A206F6
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 12:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB5AC2FC00E;
	Fri, 22 Aug 2025 12:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PiT7c3YH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5AA2FB972;
	Fri, 22 Aug 2025 12:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755866087; cv=none; b=aW8KXQxWZvAHUHTSh2xoXQdNWAlgrD5dvtmTd2NGM0IXsPgohzZUgqINTIbJkw61RQuTaCDjywBOokySQf6GatBNQh3fkLpNjJ2kpztyOKl/FW9b2+lC3i1H/4uZU/Q/tw4xVtUumvUXJRIe85yvaPlkFuVjGurkY/XuURC1C+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755866087; c=relaxed/simple;
	bh=np5jOecE4nT+dASmiZntjLqhj8X27reIWBQkTw8zbAk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hzKba1zJeLPSHYEUMlnRxB/T/SM9fQ17GC3WwOXhUDyFw8y12rTEBXIX2Z3J1U13OoN7fuYsP0NT4R+RfZdPgsIRhT8qvqPkSPWk9XRmu/msMiPoWD33FLeDYSIp8j9/xmvyXAMWng3zaf7pcsDFkoy07R7BNYhbBgcDeLd9M18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PiT7c3YH; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755866086; x=1787402086;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=np5jOecE4nT+dASmiZntjLqhj8X27reIWBQkTw8zbAk=;
  b=PiT7c3YHlTKQ56xSbpvxqxcTgp5CGjYjPrcGQxccpS6XTlvc6n/7qbhX
   khgFzNeqoifM5XqzvU9u3zmo6f3pPUthTIhqw0RZefIbqD0kKSMhyis0I
   PehcSizhIeXDiIKvMZPdwZeatAFpS8vrCMbFT0QHOeXeYOysG0b7AOWQG
   3y70KUjYkZk54xIX8H5SIpHZUZDtfcfbSMkmkX3aJD1/hMCGGuEqEIv5Q
   cfJArcQ9EMPoQUg2omNLuTNYnvh+kPp9WdscIJiojreEs3LzioOgJ/Res
   6nlxKndhQSah9e/H8xvabtW7CxmHcHLPxOxKHcw0oVfMnMX3StImZDNBc
   g==;
X-CSE-ConnectionGUID: 9vVk9gMpRdWjHEqo4+FD2Q==
X-CSE-MsgGUID: 5DLEe32nSlmw2jSKSFZfYQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11529"; a="45742866"
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="45742866"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 05:34:44 -0700
X-CSE-ConnectionGUID: iLW5NYiFSxe+wgYVIA9zjQ==
X-CSE-MsgGUID: 5aZFHMQKTDK/Vw7+5jxfeg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,309,1747724400"; 
   d="scan'208";a="168599441"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.115])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2025 05:34:40 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	D Scott Phillips <scott@os.amperecomputing.com>,
	Rio Liu <rio@r26.me>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Markus Elfring <Markus.Elfring@web.de>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH v3 3/3] PCI: Fix failure detection during resource resize
Date: Fri, 22 Aug 2025 15:33:59 +0300
Message-Id: <20250822123359.16305-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250822123359.16305-1-ilpo.jarvinen@linux.intel.com>
References: <20250822123359.16305-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Since the commit 96336ec70264 ("PCI: Perform reset_resource() and build
fail list in sync") the failed list is always built and returned to let
the caller decide what to do with the failures. The caller may want to
retry resource fitting and assignment and before that can happen, the
resources should be restored to their original state (a reset
effectively clears the struct resource), which requires returning them
on the failed list so that the original state remains stored in the
associated struct pci_dev_resource.

Resource resizing is different from the ordinary resource fitting and
assignment in that it only considers part of the resources. This means
failures for other resource types are not relevant at all and should be
ignored. As resize doesn't unassign such unrelated resources, those
resource ending up into the failed list implies assignment of that
resource must have failed before resize too. The check in
pci_reassign_bridge_resources() to decide if the whole assignment is
successful, however, is based on list emptiness which will cause false
negatives when the failed list has resources with an unrelated type.

If the failed list is not empty, call pci_required_resource_failed()
and extend it to be able to filter on specific resource types too (if
provided).

Calling pci_required_resource_failed() at this point is slightly
problematic because the resource itself is reset when the failed list
is constructed in __assign_resources_sorted(). As a result,
pci_resource_is_optional() does not have access to the original
resource flags. This could be worked around by restoring and
re-reseting the resource around the call to pci_resource_is_optional(),
however, it shouldn't cause issue as resource resizing is meant for
64-bit prefetchable resources according to Christian König (see the
Link which unfortunately doesn't point directly to Christian's reply
because lore didn't store that email at all).

Fixes: 96336ec70264 ("PCI: Perform reset_resource() and build fail list in sync")
Link: https://lore.kernel.org/all/c5d1b5d8-8669-5572-75a7-0b480f581ac1@linux.intel.com/
Reported-by: D Scott Phillips <scott@os.amperecomputing.com>
Closes: https://lore.kernel.org/all/86plf0lgit.fsf@scott-ph-mail.amperecomputing.com/
Tested-by: D Scott Phillips <scott@os.amperecomputing.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: D Scott Phillips <scott@os.amperecomputing.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: <stable@vger.kernel.org>
---
 drivers/pci/setup-bus.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index df5aec46c29d..def29506700e 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -28,6 +28,10 @@
 #include <linux/acpi.h>
 #include "pci.h"
 
+#define PCI_RES_TYPE_MASK \
+	(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH |\
+	 IORESOURCE_MEM_64)
+
 unsigned int pci_flags;
 EXPORT_SYMBOL_GPL(pci_flags);
 
@@ -384,13 +388,19 @@ static bool pci_need_to_release(unsigned long mask, struct resource *res)
 }
 
 /* Return: @true if assignment of a required resource failed. */
-static bool pci_required_resource_failed(struct list_head *fail_head)
+static bool pci_required_resource_failed(struct list_head *fail_head,
+					 unsigned long type)
 {
 	struct pci_dev_resource *fail_res;
 
+	type &= PCI_RES_TYPE_MASK;
+
 	list_for_each_entry(fail_res, fail_head, list) {
 		int idx = pci_resource_num(fail_res->dev, fail_res->res);
 
+		if (type && (fail_res->flags & PCI_RES_TYPE_MASK) != type)
+			continue;
+
 		if (!pci_resource_is_optional(fail_res->dev, idx))
 			return true;
 	}
@@ -504,7 +514,7 @@ static void __assign_resources_sorted(struct list_head *head,
 	}
 
 	/* Without realloc_head and only optional fails, nothing more to do. */
-	if (!pci_required_resource_failed(&local_fail_head) &&
+	if (!pci_required_resource_failed(&local_fail_head, 0) &&
 	    list_empty(realloc_head)) {
 		list_for_each_entry(save_res, &save_head, list) {
 			struct resource *res = save_res->res;
@@ -1708,10 +1718,6 @@ static void __pci_bridge_assign_resources(const struct pci_dev *bridge,
 	}
 }
 
-#define PCI_RES_TYPE_MASK \
-	(IORESOURCE_IO | IORESOURCE_MEM | IORESOURCE_PREFETCH |\
-	 IORESOURCE_MEM_64)
-
 static void pci_bridge_release_resources(struct pci_bus *bus,
 					 unsigned long type)
 {
@@ -2450,8 +2456,12 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 		free_list(&added);
 
 	if (!list_empty(&failed)) {
-		ret = -ENOSPC;
-		goto cleanup;
+		if (pci_required_resource_failed(&failed, type)) {
+			ret = -ENOSPC;
+			goto cleanup;
+		}
+		/* Only resources with unrelated types failed (again) */
+		free_list(&failed);
 	}
 
 	list_for_each_entry(dev_res, &saved, list) {
-- 
2.39.5


