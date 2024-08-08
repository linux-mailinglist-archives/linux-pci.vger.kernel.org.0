Return-Path: <linux-pci+bounces-11482-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6D8694BD38
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 14:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F12631C22752
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 12:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07041487E1;
	Thu,  8 Aug 2024 12:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hQKYKd+I"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CDD63D;
	Thu,  8 Aug 2024 12:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723119443; cv=none; b=sIlALtaFhVq+ySmbZdoaiy5/qrOGO3fZyyPmVcQ3Vno7HGFKq2J16HeT+idB5soqT1oMSJVBdwS8n9DVYhKWMaLriVWLL58XLnWUgK3KEZZo4/o3AQsd8WjPvaUuTIhGPJUJ23Mg0+vECNKC0bF1JaDZnugDi+1TMh7/J1E43WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723119443; c=relaxed/simple;
	bh=jxdAQwclMC1Qk5rFWcQxmVDsNJV1MmvKrCcqjq3ELws=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=hCiX3Um6vYt4j5K3ua/Jf3wzkMsB1qONN7D0TC/VLZK4ha4LfiNFFDfplQBU9do81kMfPwZjQkirpuVx2mMEPLrfjHiYDdPltyZnupxe3vCRv83Da/iZBOrIpZPRnLY3gaRDdEhejaq1U32NweDnIjRok3sMciHOvn01+Wm2g4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hQKYKd+I; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723119442; x=1754655442;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jxdAQwclMC1Qk5rFWcQxmVDsNJV1MmvKrCcqjq3ELws=;
  b=hQKYKd+IZV9IJyHU2upq/rBsPm2WDJ1BkpyrpC5BFzUVb22ccIKJG3Pc
   FywjlV67g1VEijGZrVk8czm7DYnIf4XsKmf4aa1DIJ77FcFwJELnBYEC9
   laZu4ZWlNdnBZUnf60LNAYFuGYHMzEyrGrnRzlbYWrLDvvES+wHnzTLCV
   Ss7edZJCu9112wJHQAZ6P8fuMRkYsn5k2xic9uBW8Af/+IGHQ0pcln961
   VYSk6H1cI9TtSpnhmjJ1e6X18PCIqqt45nEXRzdOg8BijiqhIA2p6FpLZ
   Otcr0NteWoP1E5roTWsJMma/++KxzkwiDPvTmtbh982oiWj0E3569tAPW
   g==;
X-CSE-ConnectionGUID: Seoy7kw4RUuZI94YE9FnHA==
X-CSE-MsgGUID: N490G7OLSG2InIZhnsOczw==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="21408504"
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="21408504"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 05:17:21 -0700
X-CSE-ConnectionGUID: YkPvuPKuTIaXeB3gNntgwA==
X-CSE-MsgGUID: Yn66PLr4S1CmEN3SAPnU3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,273,1716274800"; 
   d="scan'208";a="80433578"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.125.108.108])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 05:17:19 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: "David E . Box" <david.e.box@linux.intel.com>,
	Jian-Hong Pan <jhp@endlessos.org>,
	Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 1/1] PCI: Wait for Link before restoring Downstream Buses
Date: Thu,  8 Aug 2024 15:17:07 +0300
Message-Id: <20240808121708.2523-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

__pci_reset_bus() calls pci_bridge_secondary_bus_reset() to perform the
reset and also waits for the Secondary Bus to become again accessible.
__pci_reset_bus() then calls pci_bus_restore_locked() that restores the
PCI devices connected to the bus, and if necessary, recursively restores
also the subordinate buses and their devices.

The logic in pci_bus_restore_locked() does not take into account that
after restoring a device on one level, there might be another Link
Downstream that can only start to come up after restore has been
performed for its Downstream Port device. That is, the Link may
require additional wait until it becomes accessible.

Similarly, pci_slot_restore_locked() lacks wait.

Amend pci_bus_restore_locked() and pci_slot_restore_locked() to wait
for the Secondary Bus before recursively performing the restore of that
bus.

Fixes: 090a3c5322e9 ("PCI: Add pci_reset_slot() and pci_reset_bus()")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

NOTE TO MAINTAINER: I've not seen anything to actually trigger this issue
but only realized this problem exist while looking into the other issues
related to bus reset/restore. The fix regardless seems to make sense so
sending it out.

 drivers/pci/pci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e3a49f66982d..98c7b732998a 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5671,8 +5671,10 @@ static void pci_bus_restore_locked(struct pci_bus *bus)
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
 		pci_dev_restore(dev);
-		if (dev->subordinate)
+		if (dev->subordinate) {
+			pci_bridge_wait_for_secondary_bus(dev, "bus reset");
 			pci_bus_restore_locked(dev->subordinate);
+		}
 	}
 }
 
@@ -5706,8 +5708,10 @@ static void pci_slot_restore_locked(struct pci_slot *slot)
 		if (!dev->slot || dev->slot != slot)
 			continue;
 		pci_dev_restore(dev);
-		if (dev->subordinate)
+		if (dev->subordinate) {
+			pci_bridge_wait_for_secondary_bus(dev, "slot reset");
 			pci_bus_restore_locked(dev->subordinate);
+		}
 	}
 }
 
-- 
2.39.2


