Return-Path: <linux-pci+bounces-31085-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 909BBAEE0A9
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 16:28:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 032FF189EC41
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 14:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C18728C2AA;
	Mon, 30 Jun 2025 14:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WHkyl209"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C30328C2B1;
	Mon, 30 Jun 2025 14:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751293643; cv=none; b=PzskdNEtaXvNwAbkqe3OIltLUvfpO/ijrnchNxPDokPTCsslWOiNl/rJci3N8yIoORk9fYZ7ePb2lXJBQzZg6PXn9wGcTkfqjtI9dD/OI7VhZCb7WV90L0/kMh4VC1otjpvLh1bOdgU9r+yKFvU8X2v4mrmmIzMZf7tst8FngvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751293643; c=relaxed/simple;
	bh=nuAWTsMItNCCzscLTP8xkr9U8H1LoMJ5NrTQyP/NGvo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rm56f9nr0tGbFXiPHMj2pxExZwR5i5zFd9PcV3zWi73Knc4caHlwxnCEFCxZk3mKZSShIF7E+rRdp8AfBetSmPxJ4NMz16iZTWl09ZLVNAOxNiF+hEA+n5/LFKVhz4fdkNFVn9TbZtqtzJR5EwQyIHV547563J1+fmBENz92FfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WHkyl209; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751293642; x=1782829642;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nuAWTsMItNCCzscLTP8xkr9U8H1LoMJ5NrTQyP/NGvo=;
  b=WHkyl2092MfQgWL5xTnlJmQ9HZwcLIwXLXbBuII8VhBCK20FvVgom9Z6
   yF4q8MvGgkboelSeHa/hDTV4ti/SAl1URFEGu3PwA/iU//PfaTZS+5B2o
   n148NJKWx6P9zvzE94NAOezsoTkhkav3x48zp0u1YJRZvt/0j2oHJ0MXR
   H50hi9rW8VOyRnv7nxBff1/NWdJ6iJFZkGR3QUg4kytJbcrkp8F1gB/WT
   HcIrFpMsMuUXFl3rLbX07OgzENWNfmABQEIqcXMdUWuEsein9Q8941SW2
   vR3EowBvOSle0haEZKBF6y7X7uzOOQWrBP0vuWQbPePADxZuz9BinGldn
   A==;
X-CSE-ConnectionGUID: TQqkPNVhRMiNr0bIDuA27w==
X-CSE-MsgGUID: 84iJt1sJQ5qaUGCRt+mfpw==
X-IronPort-AV: E=McAfee;i="6800,10657,11480"; a="76071121"
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="76071121"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 07:27:21 -0700
X-CSE-ConnectionGUID: 0vWuU3l9Tz6APbBipBzcfQ==
X-CSE-MsgGUID: MEyr22i0SgOMn8ipV46Uwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,278,1744095600"; 
   d="scan'208";a="153649823"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.65])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 07:27:17 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Rio <rio@r26.me>,
	D Scott Phillips <scott@os.amperecomputing.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] PCI: Fix failure detection during resource resize
Date: Mon, 30 Jun 2025 17:26:41 +0300
Message-Id: <20250630142641.3516-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250630142641.3516-1-ilpo.jarvinen@linux.intel.com>
References: <20250630142641.3516-1-ilpo.jarvinen@linux.intel.com>
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
Tested-by: D Scott Phillips <scott@os.amperecomputing.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: D Scott Phillips <scott@os.amperecomputing.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: <stable@vger.kernel.org>
---
 drivers/pci/setup-bus.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 24863d8d0053..dbbd80d78d3d 100644
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
@@ -2449,8 +2455,12 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
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


