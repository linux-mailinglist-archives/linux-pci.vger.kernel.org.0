Return-Path: <linux-pci+bounces-4356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF5A86EDD8
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 02:28:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48EF28646D
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 01:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D449566A;
	Sat,  2 Mar 2024 01:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="q2iWUGRt"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91C01C33;
	Sat,  2 Mar 2024 01:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.154.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709342906; cv=none; b=nVG6OMbDcRB/6nhXM7cyTq5+e0zQVAAnWrJg7iAlwxxxrcRMkOZuGaxsTfAHrZYG0aPTyvmiytDft1MrwdcnrO4hWX7DftnltzZpwTpOv/y6RCK72GU2rFep46XCMWfNBZz7eSU+xyPnfvpoAkghM3bNPrtwEiwYsj3+I3N0T80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709342906; c=relaxed/simple;
	bh=oyDrZNPSjvpWQkpJ8dArju319ngvkCkZjLCZ/y/DP1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OEp+mQlwsnWOfDjxZ+i8s8XnnbbQ/Q8UxWdFhFDc2ztFLl+yIjGbziLGkDWtRzr2alDCeWJWguh72srS5pctpFd7HhEXMh30cjyD2TD+k1DCub7km+0KO6dyT4Ef3wN45He4nO6OYPUu5cXQ/q++TPJcgn00+Bp7jR0/yRjjEmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=q2iWUGRt; arc=none smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709342904; x=1740878904;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=oyDrZNPSjvpWQkpJ8dArju319ngvkCkZjLCZ/y/DP1A=;
  b=q2iWUGRtDCXj9bWkN7upH/mgHSEtLPF4K9bJ2SiMs1OEg1hUgupyKrHm
   WZ+OesPN5Zfx98ORv7+ZAqYUCJt5SuTEqJUIv1wdypHCyiHWgbgrEa2QR
   FYfYm9FLCgxnqi7ru0qPIFQknxx3/i4xl/LgxW7PfIxZPMqFQmrkDQjUS
   XkC5J4w9QS2RT1dKgihC3cF1MtAihw/s7jzhp+lNUVwaUBrRG7BhrB3id
   Bg7Yj6/XJ855g/1msnThoLMANU/t9OvlekPE5sWy6BrE8LK8BwGik2kIf
   FIB/XYK90wrSoY0C/alFhPQQuHuErIL64EVnQreA4eLtsv7m6ChQQus3f
   w==;
X-CSE-ConnectionGUID: LSUP/S1eTS24GE0X/k1evA==
X-CSE-MsgGUID: HtIEbumaRaWtMgiPAEQVBw==
X-IronPort-AV: E=Sophos;i="6.06,197,1705334400"; 
   d="scan'208";a="10627732"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 02 Mar 2024 09:28:17 +0800
IronPort-SDR: nU6CspXQJGrALxhVfkk74fZsE74HoI111g0+QN7iVVEyxiUEELQCyhrx03aYQlzBZlc7o9byrR
 sN4myoPmwDjw==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Mar 2024 16:37:33 -0800
IronPort-SDR: lFkGGry0ISTHwHx6ka0bgEeCgykFa69Y/gkpM0wGNAk8Ytql6ysR5Bl6dQkCrxEuMnM7OXERG+
 Sg4NlhYLx5Xw==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 01 Mar 2024 17:28:14 -0800
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
Subject: [PATCH v2] platform/x86: p2sb: Defer P2SB device scan when P2SB device has func 0
Date: Sat,  2 Mar 2024 10:28:13 +0900
Message-ID: <20240302012813.2011111-1-shinichiro.kawasaki@wdc.com>
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
VivoBook D540NV-GQ065T [1]. It was confirmed that the P2SB device scan
and remove at the fs_initcall stage triggered the errors.

To avoid the error, defer the P2SB device scan on the concerned device.
The error was observed on the system with Pentium N4200 in Goldmont micro-
architecture, and on which P2SB has function 0. Then refer to the P2SB
function to decide whether to defer or not.

When the device scan is deferred, do the scan later when p2sb_bar() is
called for the first time. If this first scan is triggered by sysfs
pci bus rescan, deadlock happens. In most cases, the scan happens during
system boot process, then there is no chance of deadlock.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218531 [1]
Fixes: 5913320eb0b3 ("platform/x86: p2sb: Allow p2sb_bar() calls during PCI device probe")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
---
Changes from v1:
* Removed unnecessary p2sb_resource_cached()
* Reflected other review comments

 drivers/platform/x86/p2sb.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/p2sb.c b/drivers/platform/x86/p2sb.c
index 6bd14d0132db..8d206238f63a 100644
--- a/drivers/platform/x86/p2sb.c
+++ b/drivers/platform/x86/p2sb.c
@@ -133,7 +133,7 @@ static struct pci_bus *p2sb_get_bus(struct pci_bus *bus)
 	return p2sb_bus;
 }
 
-static int p2sb_cache_resources(void)
+static int p2sb_cache_resources(bool from_fs_init)
 {
 	unsigned int devfn_p2sb;
 	u32 value = P2SBC_HIDE;
@@ -150,6 +150,15 @@ static int p2sb_cache_resources(void)
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
 	/*
 	 * When a device with same devfn exists and its device class is not
 	 * PCI_CLASS_MEMORY_OTHER for P2SB, do not touch it.
@@ -214,6 +223,11 @@ int p2sb_bar(struct pci_bus *bus, unsigned int devfn, struct resource *mem)
 	}
 
 	cache = &p2sb_resources[PCI_FUNC(devfn)];
+
+	/* Scan and cache P2SB device if it was deferred at fs_initcall() */
+	if (!p2sb_valid_resource(&cache->res))
+		p2sb_cache_resources(false);
+
 	if (cache->bus_dev_id != bus->dev.id)
 		return -ENODEV;
 
@@ -227,7 +241,7 @@ EXPORT_SYMBOL_GPL(p2sb_bar);
 
 static int __init p2sb_fs_init(void)
 {
-	p2sb_cache_resources();
+	p2sb_cache_resources(true);
 	return 0;
 }
 
-- 
2.43.0


