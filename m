Return-Path: <linux-pci+bounces-4391-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF5286FA98
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 08:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49806281414
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 07:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4972D23BF;
	Mon,  4 Mar 2024 07:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="UxxbeOY0"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498DB12E73;
	Mon,  4 Mar 2024 07:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709536765; cv=none; b=pLcOLm8Re3SZtXvKGNnK/AhesznMX4tcK2gTM2vSwZKwtIzKDljNI5crG1C/8gBt/hXaJWOuAbmE+SW6sJN+ZxOGfX4wDATsaD/657dh8TeLIkRy9EipLRsjH2626BTl9bPMYyf6qqhRNo65RJHmuKWzMdL+v3OLvCcq0Z9/cZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709536765; c=relaxed/simple;
	bh=27m+tmbU3Vw1hrSNuoUjlN8I76/kIOXS9GCN6Oqhahw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bLtZo5wlM8gjPUSVTnZ0fdoZ27W3YqgD8kraGiK4VjupJodE7nkwNAESID6dcSsL8h+gvVtUzgftKjqA3xT1BYsRQLi3juhQ45nX8JQJTrCaxxV1s2W8thZrUC5cRr0XZwT3Y/qFEbaILGTOZoZaY/aOqh+O/lQ93TRCZ/XaVrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=UxxbeOY0; arc=none smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709536763; x=1741072763;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=27m+tmbU3Vw1hrSNuoUjlN8I76/kIOXS9GCN6Oqhahw=;
  b=UxxbeOY0WyfqOvtUK2e4QmfEUaNeMv5+ML3gYV5MKzMeI0DTahzn0IdE
   p6e8C3ACQSRF96T/PlUGPxjqfmH4Hs7gXdoHclC3mRkwlmORU4HsRPzpI
   lOcW4jKjehd8m643Krz9UBzlKnQE0h1q30tMgjV60CW4snIgxWCBUcMQf
   12Os4i/+QNIeBLmIO0CHYzHIEWH0l9l+SRBFrr0hQfZYWvoBHRU1KksfD
   Vdy3d7urf6GOrrjEp+v3UN8qlM6YAIzoYnCrcxBKUATcLQ8xPL1fWqZZT
   E42emrt2YdfH88bOQ0A+9OSN0tyYabozWGbxxBYZcxkxTeFfKLHCywAzt
   A==;
X-CSE-ConnectionGUID: 6aQO7IDcR0+NbWIl4yRiSQ==
X-CSE-MsgGUID: Rk/fly5AQA6suj0ZSEpwew==
X-IronPort-AV: E=Sophos;i="6.06,203,1705334400"; 
   d="scan'208";a="10280128"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 04 Mar 2024 15:19:16 +0800
IronPort-SDR: fST7KfhiIGeVm2eXX3N7FQXv7rpzPpFcYpiefLY0e84pDdS/zagiAhY8YAJar+Aq3uyCE1zvu5
 k7sLa879Syqg==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Mar 2024 22:22:47 -0800
IronPort-SDR: Lq+TQ2wMZhm5dP9aUY2gDpJabBsLe0TylHOF151wwdtAfHmjMiN3Z13xBgyHXmyD9w455d9PvY
 q0ufxgjjY8DA==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 03 Mar 2024 23:19:13 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: platform-driver-x86@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	danilrybakov249@gmail.com,
	Lukas Wunner <lukas@wunner.de>,
	Klara Modin <klarasmodin@gmail.com>,
	linux-pci@vger.kernel.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v3] platform/x86: p2sb: Defer P2SB device scan when P2SB device has func 0
Date: Mon,  4 Mar 2024 16:19:12 +0900
Message-ID: <20240304071912.2340622-1-shinichiro.kawasaki@wdc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 5913320eb0b3 ("platform/x86: p2sb: Allow p2sb_bar() calls
during PCI device probe") triggered repeated ACPI errors on ASUS
VivoBook D540NV-GQ065T [1]. The P2SB device on the system has multiple
functions, and the system requires P2SB device function 2. The commit
introduced the P2SB device scan for all functions including function 0
and 2. It was confirmed that the P2SB device scan for function 0 on the
system triggered the errors.

To avoid the errors, defer the P2SB device scan on the concerned device.
If the P2SB device has function 0, defer the device scan and do it later
when p2sb_bar() is called for the first time. At the deferred scan, do
not scan multiple functions and scan only the requested function to
avoid the unnecessary scan of function 0.

If sysfs pci bus rescans trigger the first p2sb_bar() call, deadlock
happens in the deferred P2SB device scan. In most cases, the p2sb_bar()
calls happen during the system boot process, then there is no chance of
deadlock.

After this change, the code to scan multiple functions for P2SB devices
with function 0 in p2sb_scan_and_cache() is no longer required. The
resource validity check in p2sb_scan_and_cache() is not required either
since it is done in p2sb_bar() also. Remove p2sb_scan_and_cache() and
call p2sb_scan_and_cache_devfn() instead.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218531 [1]
Fixes: 5913320eb0b3 ("platform/x86: p2sb: Allow p2sb_bar() calls during PCI device probe")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
Changes from v2:
* Target only the requested devfn at the deferred scan and cache
* Removed p2sb_scan_and_cache() and use p2sb_scan_and_cache_devfn() instead

Changes from v1:
* Removed unnecessary p2sb_resource_cached()
* Reflected other review comments

 drivers/platform/x86/p2sb.c | 47 ++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 27 deletions(-)

diff --git a/drivers/platform/x86/p2sb.c b/drivers/platform/x86/p2sb.c
index 6bd14d0132db..c829dbd8f058 100644
--- a/drivers/platform/x86/p2sb.c
+++ b/drivers/platform/x86/p2sb.c
@@ -96,30 +96,6 @@ static void p2sb_scan_and_cache_devfn(struct pci_bus *bus, unsigned int devfn)
 	pci_stop_and_remove_bus_device(pdev);
 }
 
-static int p2sb_scan_and_cache(struct pci_bus *bus, unsigned int devfn)
-{
-	unsigned int slot, fn;
-
-	if (PCI_FUNC(devfn) == 0) {
-		/*
-		 * When function number of the P2SB device is zero, scan it and
-		 * other function numbers, and if devices are available, cache
-		 * their BAR0s.
-		 */
-		slot = PCI_SLOT(devfn);
-		for (fn = 0; fn < NR_P2SB_RES_CACHE; fn++)
-			p2sb_scan_and_cache_devfn(bus, PCI_DEVFN(slot, fn));
-	} else {
-		/* Scan the P2SB device and cache its BAR0 */
-		p2sb_scan_and_cache_devfn(bus, devfn);
-	}
-
-	if (!p2sb_valid_resource(&p2sb_resources[PCI_FUNC(devfn)].res))
-		return -ENOENT;
-
-	return 0;
-}
-
 static struct pci_bus *p2sb_get_bus(struct pci_bus *bus)
 {
 	static struct pci_bus *p2sb_bus;
@@ -133,7 +109,7 @@ static struct pci_bus *p2sb_get_bus(struct pci_bus *bus)
 	return p2sb_bus;
 }
 
-static int p2sb_cache_resources(void)
+static int p2sb_cache_resources(unsigned int devfn_to_cache, bool from_fs_init)
 {
 	unsigned int devfn_p2sb;
 	u32 value = P2SBC_HIDE;
@@ -150,6 +126,18 @@ static int p2sb_cache_resources(void)
 	if (!bus)
 		return -ENODEV;
 
+	/*
+	 * On ASUS VivoBook D540NV-GQ065T which has Goldmont CPU family Pentium
+	 * N4200, P2SB device scan including function 0 at fs_initcall() step
+	 * causes ACPI errors. To avoid the errors, defer P2SB device scan and
+	 * cache when P2SB devices has function 0.
+	 */
+	if (PCI_FUNC(devfn_p2sb) == 0 && from_fs_init)
+		return -EBUSY;
+
+	if (devfn_to_cache == 0)
+		devfn_to_cache = devfn_p2sb;
+
 	/*
 	 * When a device with same devfn exists and its device class is not
 	 * PCI_CLASS_MEMORY_OTHER for P2SB, do not touch it.
@@ -173,7 +161,7 @@ static int p2sb_cache_resources(void)
 	if (value & P2SBC_HIDE)
 		pci_bus_write_config_dword(bus, devfn_p2sb, P2SBC, 0);
 
-	ret = p2sb_scan_and_cache(bus, devfn_p2sb);
+	p2sb_scan_and_cache_devfn(bus, devfn_to_cache);
 
 	/* Hide the P2SB device, if it was hidden */
 	if (value & P2SBC_HIDE)
@@ -214,6 +202,11 @@ int p2sb_bar(struct pci_bus *bus, unsigned int devfn, struct resource *mem)
 	}
 
 	cache = &p2sb_resources[PCI_FUNC(devfn)];
+
+	/* Scan and cache P2SB device if it was deferred at fs_initcall() */
+	if (!p2sb_valid_resource(&cache->res))
+		p2sb_cache_resources(devfn, false);
+
 	if (cache->bus_dev_id != bus->dev.id)
 		return -ENODEV;
 
@@ -227,7 +220,7 @@ EXPORT_SYMBOL_GPL(p2sb_bar);
 
 static int __init p2sb_fs_init(void)
 {
-	p2sb_cache_resources();
+	p2sb_cache_resources(0, true);
 	return 0;
 }
 
-- 
2.43.0


