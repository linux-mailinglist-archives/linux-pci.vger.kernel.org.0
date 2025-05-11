Return-Path: <linux-pci+bounces-27560-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 84654AB2BB4
	for <lists+linux-pci@lfdr.de>; Sun, 11 May 2025 23:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 051ED173001
	for <lists+linux-pci@lfdr.de>; Sun, 11 May 2025 21:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C4525B697;
	Sun, 11 May 2025 21:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ncrT/gZt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2CB19307F;
	Sun, 11 May 2025 21:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747000356; cv=none; b=pceXdQYTlyGo48OMMkU6t+SKvN45WX+4VkjqJXYQkUMQ2yYKW16hPJtlA/IBwFxcPtsKWjW8q0LeOj30iKLkzFCR1OfkRihHH7RISK86URmiPkNo5lfwKmthd+ZhPcp8Btz6WZD2+55r4ocRyHFO/Jvm+vy8+4vEQRJ5ldiBxfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747000356; c=relaxed/simple;
	bh=eVOfRC71/v0naU88mPmpGGIMHyzVH0LVRTWmB7Cvdx8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=aAh4hU5LcdAjARlvZjNQCkuo3mkHv+tez42iPMI8ylyrQj9Qf5sj2nGxX00AovnWbwAExton2Fi6Kd90wcTeTGXY9cBFUGxUcKevgCG+96w4c98ESiAHws5SDePxqeKnnRCE6TiZDGGRCsi99NL222qU1j2vCp4WqSi2w92q6fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ncrT/gZt; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747000354; x=1778536354;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eVOfRC71/v0naU88mPmpGGIMHyzVH0LVRTWmB7Cvdx8=;
  b=ncrT/gZtZMtA+gFsSqq9GA7zVEWMHjJchL22c0aoCFxRf2G75v5nctJI
   eBj2aPQOEjpvxBQZZxUgyOrumjFdhuvW20htyOPc7Emw7b13w2LcGOOIl
   /vbBTyBEEbMn0buxjVDH4AqKzHLJgZDPx9Ytu9Eq2f6nm5MY1jKz0F+Y2
   aspJ+YjbDld17yi5uFz/fmgiaR2JUllRl64LcIIbB34rV6ibX6u+Culuk
   XQAVUVXsq57pMyyNfj4hamF4O7bysItRaeYzF1zxqRjnwnfhha0j6t1/H
   KhYd7BF751EQAvBb5fx/9I6gL4mtVO1dzX23IlDF4qhxlSEM/wFOqm8Ac
   g==;
X-CSE-ConnectionGUID: WoSREJfRTlqYJI52M7qxXA==
X-CSE-MsgGUID: jW+Yzt+yT5+eOm18b/dRQA==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="74181807"
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="74181807"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 14:52:33 -0700
X-CSE-ConnectionGUID: 22mdZdqxQ9abjmxrBSv0iA==
X-CSE-MsgGUID: T5wY4l6VSUCR8Y7CbARB4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,281,1739865600"; 
   d="scan'208";a="136896737"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.117])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 14:52:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 1/1] PCI: Non-empty add_list/realloc_head does not warrant BUG_ON()
Date: Mon, 12 May 2025 00:52:23 +0300
Message-Id: <20250511215223.7131-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Resource fitting/assignment code checks if there's a remainder in
add_list (aka. realloc_head in the inner functions) using BUG_ON().
This problem typically results in a mere PCI device resource assignment
failure which does not warrant using BUG_ON(). The machine could well
come up usable even if this condition occurs because the realloc_head
relates to resources which are optional anyway.

Change BUG_ON() to WARN_ON_ONCE() and free the list if it it's not
empty.

Reported-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Link: https://lore.kernel.org/linux-pci/5f103643-5e1c-43c6-b8fe-9617d3b5447c@linaro.org/
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

The cause for the regression reported by Tudor is not understood yet,
but this change seems useful regardless given somebody has now hit one
of these BUG_ON()s.

 drivers/pci/setup-bus.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 54d6f4fa3ce1..a0d815557f5c 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -2298,8 +2298,8 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 
 		/* Depth last, allocate resources and update the hardware. */
 		__pci_bus_assign_resources(bus, add_list, &fail_head);
-		if (add_list)
-			BUG_ON(!list_empty(add_list));
+		if (WARN_ON_ONCE(add_list && !list_empty(add_list)))
+			free_list(add_list);
 		tried_times++;
 
 		/* Any device complain? */
@@ -2361,7 +2361,8 @@ void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
 		pci_bridge_distribute_available_resources(bridge, &add_list);
 
 		__pci_bridge_assign_resources(bridge, &add_list, &fail_head);
-		BUG_ON(!list_empty(&add_list));
+		if (WARN_ON_ONCE(!list_empty(&add_list)))
+			free_list(&add_list);
 		tried_times++;
 
 		if (list_empty(&fail_head))
@@ -2437,7 +2438,8 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
 
 	__pci_bus_size_bridges(bridge->subordinate, &added);
 	__pci_bridge_assign_resources(bridge, &added, &failed);
-	BUG_ON(!list_empty(&added));
+	if (WARN_ON_ONCE(!list_empty(&added)))
+		free_list(&added);
 
 	if (!list_empty(&failed)) {
 		ret = -ENOSPC;
@@ -2493,6 +2495,7 @@ void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
 			__pci_bus_size_bridges(dev->subordinate, &add_list);
 	up_read(&pci_bus_sem);
 	__pci_bus_assign_resources(bus, &add_list, NULL);
-	BUG_ON(!list_empty(&add_list));
+	if (WARN_ON_ONCE(!list_empty(&add_list)))
+		free_list(&add_list);
 }
 EXPORT_SYMBOL_GPL(pci_assign_unassigned_bus_resources);

base-commit: 0af2f6be1b4281385b618cb86ad946eded089ac8
-- 
2.39.5


