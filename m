Return-Path: <linux-pci+bounces-45044-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF1FD3168F
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 13:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 181A3300D575
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jan 2026 12:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5702F236A8B;
	Fri, 16 Jan 2026 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IMS92Xb9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC59225A38;
	Fri, 16 Jan 2026 12:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768568302; cv=none; b=j25f4oGcJxxSKGnDhWcVIeRqWPbDD7fX1Hjly3JIZpGEl4c1KqcHiyXOeShrTcxsdzGknUIebopDZftSlByENBWiwOUvjCZVz7AIhUhbkEwXG4qcDunefG93ie9Rw0dHlBhgk5R5gmle9vkAzx+ZEuJgBqVKsu01tH3U8eSDEac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768568302; c=relaxed/simple;
	bh=UDXrYaw3rI48vBK1SRp/7YhpPlUFuB+2Nhwv4YDnGnw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PiO98700RJGoz6vD9EHCOX9GRBsW3zUwfLsShMC6kNC2lUNqd16HUCOLlVXg3R82ocoEzl/TGMV5arYPd+Gx5z39F1tX4/xQpFRcWbAU5P0umkyagQe3A5Q1Jn/OuInPlS5pUXd5EYpxuN5iUFWi22Y0eXFzB7hywL6XbVjvZhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IMS92Xb9; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768568298; x=1800104298;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UDXrYaw3rI48vBK1SRp/7YhpPlUFuB+2Nhwv4YDnGnw=;
  b=IMS92Xb98SDgsiN/jA+/cOPudS7yLqjRKhjgHGu9A86iqQZ/WPCspu10
   NcqscoWiAV5OGdfejTdyzaQzaRuNcnjofJbL8rPjMCI471rZQ1yEdKYiJ
   BX+F4lpfXrhXaPr5DH4ekg+ko5DqaiD5Lc9YxuMsbK0IN19CmoGjmnR9F
   w9TKgTKnvaQNhjm/F2Hbeaj2rdyzsaiLeSAM+huxDmaPQ19IXprGTy2Hx
   muboNla3+SoBzBgwvzFythmyHOMTJ1yvI73wsuyyshFdRg3XpRaquucs0
   sZrb0tV4742V9VHgXhNU23Y6YyozGVHEeXfTNO4OU0960PTIDVWih6sOn
   w==;
X-CSE-ConnectionGUID: uSZj3yjTR0iAZOZUhfJHyw==
X-CSE-MsgGUID: 24BL9NFoRYm+GvDQ25TH+g==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="73511154"
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="73511154"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 04:58:18 -0800
X-CSE-ConnectionGUID: hc6jFAjiR/2FaSiib9+J2Q==
X-CSE-MsgGUID: mnUbxwsYT1qEmIwvmSPa/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,231,1763452800"; 
   d="scan'208";a="209371180"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.178])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 04:58:14 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "Jinhui Guo" <guojinhui.liam@bytedance.com>,
	Keith Busch <kbusch@kernel.org>,
	"Anthony Pighin (Nokia)" <anthony.pighin@nokia.com>,
	Alex Williamson <alex@shazbot.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/3] PCI: Consolidate pci_bus/slot_lock/unlock/trylock()
Date: Fri, 16 Jan 2026 14:57:42 +0200
Message-Id: <20260116125742.1890-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260116125742.1890-1-ilpo.jarvinen@linux.intel.com>
References: <20260116125742.1890-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

pci_bus/slot_lock/unlock/trylock() largely duplicate the bus iteration
loop with variation only due to slot filter handling. The only
differences in the loops is where the struct bus is found (directly in
the argument vs in slot->bus) and whether slot filter is applied. Those
difference are simple to handle using function parameters.

Consolidate the bus iteration loop to one place by creating
__pci_bus_{lock,unlock,trylock}() and call them from the non-underscore
locking functions.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pci.c | 103 ++++++++++++++++++++++------------------------
 1 file changed, 49 insertions(+), 54 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e1333539c7b7..622920c1529f 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5242,13 +5242,18 @@ static bool pci_bus_resettable(struct pci_bus *bus)
 	return true;
 }
 
+static void pci_bus_lock(struct pci_bus *bus);
+static void pci_bus_unlock(struct pci_bus *bus);
+static int pci_bus_trylock(struct pci_bus *bus);
+
 /* Lock devices from the top of the tree down */
-static void pci_bus_lock(struct pci_bus *bus)
+static void __pci_bus_lock(struct pci_bus *bus, struct pci_slot *slot)
 {
 	struct pci_dev *dev;
 
-	pci_dev_lock(bus->self);
 	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (slot && (!dev->slot || dev->slot != slot))
+			continue;
 		if (dev->subordinate)
 			pci_bus_lock(dev->subordinate);
 		else
@@ -5257,28 +5262,28 @@ static void pci_bus_lock(struct pci_bus *bus)
 }
 
 /* Unlock devices from the bottom of the tree up */
-static void pci_bus_unlock(struct pci_bus *bus)
+static void __pci_bus_unlock(struct pci_bus *bus, struct pci_slot *slot)
 {
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (slot && (!dev->slot || dev->slot != slot))
+			continue;
 		if (dev->subordinate)
 			pci_bus_unlock(dev->subordinate);
 		else
 			pci_dev_unlock(dev);
 	}
-	pci_dev_unlock(bus->self);
 }
 
 /* Return 1 on successful lock, 0 on contention */
-static int pci_bus_trylock(struct pci_bus *bus)
+static int __pci_bus_trylock(struct pci_bus *bus, struct pci_slot *slot)
 {
 	struct pci_dev *dev;
 
-	if (!pci_dev_trylock(bus->self))
-		return 0;
-
 	list_for_each_entry(dev, &bus->devices, bus_list) {
+		if (slot && (!dev->slot || dev->slot != slot))
+			continue;
 		if (dev->subordinate) {
 			if (!pci_bus_trylock(dev->subordinate))
 				goto unlock;
@@ -5288,12 +5293,44 @@ static int pci_bus_trylock(struct pci_bus *bus)
 	return 1;
 
 unlock:
-	list_for_each_entry_continue_reverse(dev, &bus->devices, bus_list) {
+	list_for_each_entry_continue_reverse(dev,
+					     &slot->bus->devices, bus_list) {
+		if (slot && (!dev->slot || dev->slot != slot))
+			continue;
 		if (dev->subordinate)
 			pci_bus_unlock(dev->subordinate);
 		else
 			pci_dev_unlock(dev);
 	}
+	return 0;
+}
+
+/* Lock devices from the top of the tree down */
+static void pci_bus_lock(struct pci_bus *bus)
+{
+	pci_dev_lock(bus->self);
+	__pci_bus_lock(bus, NULL);
+}
+
+/* Unlock devices from the bottom of the tree up */
+static void pci_bus_unlock(struct pci_bus *bus)
+{
+	__pci_bus_unlock(bus, NULL);
+	pci_dev_unlock(bus->self);
+}
+
+/* Return 1 on successful lock, 0 on contention */
+static int pci_bus_trylock(struct pci_bus *bus)
+{
+	if (!pci_dev_trylock(bus->self))
+		return 0;
+
+	if (!__pci_bus_trylock(bus, NULL))
+		goto unlock;
+
+	return 1;
+
+unlock:
 	pci_dev_unlock(bus->self);
 	return 0;
 }
@@ -5321,61 +5358,19 @@ static bool pci_slot_resettable(struct pci_slot *slot)
 /* Lock devices from the top of the tree down */
 static void pci_slot_lock(struct pci_slot *slot)
 {
-	struct pci_dev *dev;
-
-	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
-		if (!dev->slot || dev->slot != slot)
-			continue;
-		if (dev->subordinate)
-			pci_bus_lock(dev->subordinate);
-		else
-			pci_dev_lock(dev);
-	}
+	__pci_bus_lock(slot->bus, slot);
 }
 
 /* Unlock devices from the bottom of the tree up */
 static void pci_slot_unlock(struct pci_slot *slot)
 {
-	struct pci_dev *dev;
-
-	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
-		if (!dev->slot || dev->slot != slot)
-			continue;
-		if (dev->subordinate)
-			pci_bus_unlock(dev->subordinate);
-		else
-			pci_dev_unlock(dev);
-	}
+	__pci_bus_unlock(slot->bus, slot);
 }
 
 /* Return 1 on successful lock, 0 on contention */
 static int pci_slot_trylock(struct pci_slot *slot)
 {
-	struct pci_dev *dev;
-
-	list_for_each_entry(dev, &slot->bus->devices, bus_list) {
-		if (!dev->slot || dev->slot != slot)
-			continue;
-		if (dev->subordinate) {
-			if (!pci_bus_trylock(dev->subordinate)) {
-				goto unlock;
-			}
-		} else if (!pci_dev_trylock(dev))
-			goto unlock;
-	}
-	return 1;
-
-unlock:
-	list_for_each_entry_continue_reverse(dev,
-					     &slot->bus->devices, bus_list) {
-		if (!dev->slot || dev->slot != slot)
-			continue;
-		if (dev->subordinate)
-			pci_bus_unlock(dev->subordinate);
-		else
-			pci_dev_unlock(dev);
-	}
-	return 0;
+	return __pci_bus_trylock(slot->bus, slot);
 }
 
 /*
-- 
2.39.5


