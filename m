Return-Path: <linux-pci+bounces-4420-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7A587033E
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 14:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE9891C23936
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 13:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7155B3EA90;
	Mon,  4 Mar 2024 13:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IMp/xxah"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8523F9CC
	for <linux-pci@vger.kernel.org>; Mon,  4 Mar 2024 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709560171; cv=none; b=k9JT/ar/hSC7S5wXAD6FRmEE52r8Wm6QwyUI/PYPvlScLKvju/lfaUjOMIvca52x68Ao7Wy8fkSyQTWbEOGDScri4F4ECVxgUNHYkKPKJr70GE8kQ/iZHoPyOCX9UP8XYEBJwdfDTHFyXYbmgBNs9JbS3Ad+ma+pQm055NBp8+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709560171; c=relaxed/simple;
	bh=a8Oeia3y6iiXNQb/h+FkMpPj8XaNTESPE0upy5Hq1GU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRlX7duImHMZsFGPRutwEg9G08Pw8/KU6zw+8kd3VnvVX0IXYOxntBAsDuMRHOIGFuy1b5s1ucOYo9UMupUeZgSUO4pwv0PGpXVlUs2GgqOFFbeXi2fesGeiF0s+0L5Ojai/puukpLqsJ7MWG49p6seD1hlGVLR0g3zIE3iaaxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IMp/xxah; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709560168;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p07BVuCRl/vgtI3ktEGIWBy/AyZuue/MffO8lcXsVeQ=;
	b=IMp/xxahGDnn9pXKb4vwBZ1SF8ppKTbyBNcFP66/iKXhSEUeBss3DrEtFJTe3+daJJSP21
	U47mXVmXPrDiHKlI+2DPS7Ki/Ciyqq2cvuoM0ZEsTS9siFbgp5DlXFM2sY+IPscqjBVmiq
	Y8+rPWGqdH88NFjcQEdCnqaudzMlR8E=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-77-1BKKvLu9Ocqdl27lYGVyTg-1; Mon,
 04 Mar 2024 08:49:25 -0500
X-MC-Unique: 1BKKvLu9Ocqdl27lYGVyTg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A577C1C068C9;
	Mon,  4 Mar 2024 13:49:24 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.195.86])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 39246401546D;
	Mon,  4 Mar 2024 13:49:23 +0000 (UTC)
From: Hans de Goede <hdegoede@redhat.com>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	danilrybakov249@gmail.com,
	Lukas Wunner <lukas@wunner.de>,
	Klara Modin <klarasmodin@gmail.com>,
	linux-pci@vger.kernel.org,
	platform-driver-x86@vger.kernel.org
Subject: [RFC 1/2] platform/x86: p2sb: Cache SPI controller resources on Goldmont platforms
Date: Mon,  4 Mar 2024 14:49:20 +0100
Message-ID: <20240304134921.305604-2-hdegoede@redhat.com>
In-Reply-To: <20240304134921.305604-1-hdegoede@redhat.com>
References: <20240304134921.305604-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Instead of skipping all fs_initcall() caching of resources on Goldmont
platforms, cache the SPI controller BAR. Caching the SPI controller BAR
seems safe to do (unlike the P2SB BAR which is known to cause issues
on Goldmont).

Caching the SPI controller BAR is useful since p2sb_bar() normally
is always called for the SPI devfn on Goldmont platforms.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/p2sb.c | 41 ++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/drivers/platform/x86/p2sb.c b/drivers/platform/x86/p2sb.c
index c829dbd8f058..caf037b44487 100644
--- a/drivers/platform/x86/p2sb.c
+++ b/drivers/platform/x86/p2sb.c
@@ -20,9 +20,11 @@
 #define P2SBC_HIDE		BIT(8)
 
 #define P2SB_DEVFN_DEFAULT	PCI_DEVFN(31, 1)
+#define P2SB_DEVFN_GOLDMONT	PCI_DEVFN(13, 0)
+#define SPI_DEVFN_GOLDMONT	PCI_DEVFN(13, 2)
 
 static const struct x86_cpu_id p2sb_cpu_ids[] = {
-	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,	PCI_DEVFN(13, 0)),
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT, P2SB_DEVFN_GOLDMONT),
 	{}
 };
 
@@ -109,7 +111,7 @@ static struct pci_bus *p2sb_get_bus(struct pci_bus *bus)
 	return p2sb_bus;
 }
 
-static int p2sb_cache_resources(unsigned int devfn_to_cache, bool from_fs_init)
+static int p2sb_cache_resources(unsigned int devfn_to_cache)
 {
 	unsigned int devfn_p2sb;
 	u32 value = P2SBC_HIDE;
@@ -126,18 +128,6 @@ static int p2sb_cache_resources(unsigned int devfn_to_cache, bool from_fs_init)
 	if (!bus)
 		return -ENODEV;
 
-	/*
-	 * On ASUS VivoBook D540NV-GQ065T which has Goldmont CPU family Pentium
-	 * N4200, P2SB device scan including function 0 at fs_initcall() step
-	 * causes ACPI errors. To avoid the errors, defer P2SB device scan and
-	 * cache when P2SB devices has function 0.
-	 */
-	if (PCI_FUNC(devfn_p2sb) == 0 && from_fs_init)
-		return -EBUSY;
-
-	if (devfn_to_cache == 0)
-		devfn_to_cache = devfn_p2sb;
-
 	/*
 	 * When a device with same devfn exists and its device class is not
 	 * PCI_CLASS_MEMORY_OTHER for P2SB, do not touch it.
@@ -205,7 +195,7 @@ int p2sb_bar(struct pci_bus *bus, unsigned int devfn, struct resource *mem)
 
 	/* Scan and cache P2SB device if it was deferred at fs_initcall() */
 	if (!p2sb_valid_resource(&cache->res))
-		p2sb_cache_resources(devfn, false);
+		p2sb_cache_resources(devfn);
 
 	if (cache->bus_dev_id != bus->dev.id)
 		return -ENODEV;
@@ -220,7 +210,26 @@ EXPORT_SYMBOL_GPL(p2sb_bar);
 
 static int __init p2sb_fs_init(void)
 {
-	p2sb_cache_resources(0, true);
+	unsigned int devfn;
+
+	/*
+	 * On most platforms p2sb_bar() is only called with the PCI devfn
+	 * of the P2SB PCI device itself, cache the P2SB BAR.
+	 */
+	p2sb_get_devfn(&devfn);
+
+	/*
+	 * On Goldmont platforms p2sb_bar() may be called with 2 different PCI
+	 * devfn values, one for the P2SB itself and one for the SPI controller.
+	 * Unhiding the P2SB is known to cause ACPI errors on some devices
+	 * where p2sb_bar() is never called for the P2SB devfn. This happens
+	 * on e.g. the ASUS VivoBook D540NV-GQ065T with a Pentium N4200 CPU.
+	 * To avoid this issue only cache the SPI BAR at fs_initcall() time.
+	 */
+	if (devfn == P2SB_DEVFN_GOLDMONT)
+		devfn = SPI_DEVFN_GOLDMONT;
+
+	p2sb_cache_resources(devfn);
 	return 0;
 }
 
-- 
2.44.0


