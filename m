Return-Path: <linux-pci+bounces-4325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F64686E2A5
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 14:45:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E24828BB11
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 13:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD5A6E5E6;
	Fri,  1 Mar 2024 13:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LRUh3VYa"
X-Original-To: linux-pci@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F257EC;
	Fri,  1 Mar 2024 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.71.153.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709300710; cv=none; b=oAP56PtBwoqgdD1teDtma6k1Hv8ApVXD9K2D5LaKG0GGbKq8ZB6D+E0rD0s8yN8gsP/pCbwVHZuuROqk41B6E4M9BvXpfRdljx6wzDRgoS27VcK9B2duG9ozPgjWR+7TpI2w9Kl1I00bQAQBAKr0ypaDEesWIEbGYouVHZnFzl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709300710; c=relaxed/simple;
	bh=Rqd7JhdOzghj/uhzvhVi9YdO5XqrC581yiS2Js1pe/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ucnvs24pJKUktvboiDWdjtt13WmgGehCzp7EzuCAcnwi+B+kGLcyYaIpunZFliELeYB74lWwPwtZROGCWSiN+1LnZ1xCd1P2xdi7IMHmdsvncoWrEXBuYfZIiYEz4nkQd/l9rXgBN0vc9KgYx3noRy3SC43gck8HTD5WUYSNcEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LRUh3VYa; arc=none smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1709300708; x=1740836708;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Rqd7JhdOzghj/uhzvhVi9YdO5XqrC581yiS2Js1pe/Q=;
  b=LRUh3VYa0e+541csGTXxxOtv069nX86ddjHPtNVgpkLPKvaFI5uB8kwn
   Wkk5GEmOEWDNEaim9KC7yaXnx2MPg4d9lZYs9aCDLYtIomBjzI+/gJXOw
   Hin0KM9+mKKAPrGDn/vm0l6gZsSrhpc4Le8l7Fbhk7YvOGhiQlHcHdQF/
   YawXRfXgpiwErZ62mS5zzr8PUmhkJNdVm9e/P9FSM+mg8dLRXB+bIX5XS
   5QLKBMTnMMZ+YVtvBDPm3IKhcofhsCuR6jAWtxZ/VaN/vyC5V1CSaI7MD
   h4vETuHTWSDkaWEy8grwkWfA5TdSafBG8zJ/UciM7z2zYB0QMTP216mWc
   g==;
X-CSE-ConnectionGUID: hrxlP0gkQMm+8jsLS6Op8A==
X-CSE-MsgGUID: x3k1pSw9T0+mirpcJfrPDQ==
X-IronPort-AV: E=Sophos;i="6.06,196,1705334400"; 
   d="scan'208";a="11175757"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 01 Mar 2024 21:45:06 +0800
IronPort-SDR: qtTKrR3Q55l12ysocmfA8ISz7MGXKzWZBpjW04jRyjGR4RcMDX857qzmcLsZnR3kt3QZW6uvdh
 61l1tz+A2/GQ==
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 01 Mar 2024 04:54:22 -0800
IronPort-SDR: qG8Aq553LhnA9LlDtBuOYKn75VlYq6wtp+5BhgXjjXlEoql7EDYvWPiqfDo92o0+jGBvggqEJv
 zghFtTMoN7ag==
WDCIronportException: Internal
Received: from unknown (HELO shindev.ssa.fujisawa.hgst.com) ([10.149.66.30])
  by uls-op-cesaip01.wdc.com with ESMTP; 01 Mar 2024 05:45:05 -0800
From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
To: platform-driver-x86@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Lukas Wunner <lukas@wunner.de>,
	Klara Modin <klarasmodin@gmail.com>,
	linux-pci@vger.kernel.org,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH] platform/x86: p2sb: Defer P2SB device scan when P2SB device has func 0
Date: Fri,  1 Mar 2024 22:45:04 +0900
Message-ID: <20240301134504.1887132-1-shinichiro.kawasaki@wdc.com>
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
 drivers/platform/x86/p2sb.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/p2sb.c b/drivers/platform/x86/p2sb.c
index 6bd14d0132db..3fd23f6b0a91 100644
--- a/drivers/platform/x86/p2sb.c
+++ b/drivers/platform/x86/p2sb.c
@@ -62,6 +62,17 @@ static bool p2sb_valid_resource(struct resource *res)
 	return false;
 }
 
+static bool p2sb_resource_cached(void)
+{
+	int i;
+
+	for (i = 0; i < NR_P2SB_RES_CACHE; i++)
+		if (p2sb_valid_resource(&p2sb_resources[i].res))
+			return true;
+
+	return false;
+}
+
 /* Copy resource from the first BAR of the device in question */
 static void p2sb_read_bar0(struct pci_dev *pdev, struct resource *mem)
 {
@@ -133,7 +144,7 @@ static struct pci_bus *p2sb_get_bus(struct pci_bus *bus)
 	return p2sb_bus;
 }
 
-static int p2sb_cache_resources(void)
+static int p2sb_cache_resources(bool from_fs_init)
 {
 	unsigned int devfn_p2sb;
 	u32 value = P2SBC_HIDE;
@@ -150,6 +161,15 @@ static int p2sb_cache_resources(void)
 	if (!bus)
 		return -ENODEV;
 
+	/*
+	 * On ASUS VivoBook D540NV-GQ065T which has Goldmont CPU family Pentium
+	 * N4200, P2SB device scan including function 0 at fs_initcall step
+	 * causes ACPI errors. To avoid the errors, defer P2SB device scan and
+	 * cache when P2SB devices has function 0.
+	 */
+	if (PCI_FUNC(devfn_p2sb) == 0 && from_fs_init)
+		return -EBUSY;
+
 	/*
 	 * When a device with same devfn exists and its device class is not
 	 * PCI_CLASS_MEMORY_OTHER for P2SB, do not touch it.
@@ -203,6 +223,9 @@ int p2sb_bar(struct pci_bus *bus, unsigned int devfn, struct resource *mem)
 	struct p2sb_res_cache *cache;
 	int ret;
 
+	if (!p2sb_resource_cached())
+		p2sb_cache_resources(false);
+
 	bus = p2sb_get_bus(bus);
 	if (!bus)
 		return -ENODEV;
@@ -227,7 +250,7 @@ EXPORT_SYMBOL_GPL(p2sb_bar);
 
 static int __init p2sb_fs_init(void)
 {
-	p2sb_cache_resources();
+	p2sb_cache_resources(true);
 	return 0;
 }
 
-- 
2.43.0


