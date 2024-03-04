Return-Path: <linux-pci+bounces-4418-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A538870313
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 14:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547F328C0F1
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 13:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA873E462;
	Mon,  4 Mar 2024 13:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IARRpBWA"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 013E73D963
	for <linux-pci@vger.kernel.org>; Mon,  4 Mar 2024 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709559846; cv=none; b=oQr3T0cKQaGoH2tauHisNv1R7zpxu/Y6eXSaq/hwxRmoqVFwSs1ph9tTdp1t1FrvN2euSsRpE+moUbnCTz1Ea3XdSVvoHIlroLet+ATdTJp4i6mXHeL/LS3+yKhLo80mitYTijc+xrSaZ0r6DJeN7mYtE15n4TkeDM74ClCDL8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709559846; c=relaxed/simple;
	bh=6temxexlrCI0DLt9A9CbkEwDrv1mp4dXTU/zTUzl1+U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O1gZlXDsqVD8S4lVXR+hcE2GT3ADpM2cwCtn/QcEoO78XzUdcjUEi3wQd8X1L9z2lR6nlzE5X28Jr5wPjS/TcCIHAJNgma21yB/6FX82R488zNrUT08j020R/VkzsDNhBI8TVYNR3pKB0tEH/N+3HbseCGvoS4Q1M3xhegaCG9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IARRpBWA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709559844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y52A912ZtNs9Ap8KrFaEE37xvN2BehQdyIwgbj6SpGs=;
	b=IARRpBWAxHBddBn3bbrCqbEByzm8BLKCobPi8L/6L2kv1WFhyfBjTqjANbCqcRU/DEBJXm
	IP/KlqgxeqpRpzbBnoEe1h4xCqgdjt1oYO9r1TfcupEsaUNW8wxNQ4Q/clGCd25EBzh20Y
	/pyPtqlwabYNjGbFyfhWllK6ABf+gyM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-502-9ZGS7V5-Ow2sWG5vJ-Cjeg-1; Mon, 04 Mar 2024 08:44:00 -0500
X-MC-Unique: 9ZGS7V5-Ow2sWG5vJ-Cjeg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 28891185A783;
	Mon,  4 Mar 2024 13:44:00 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.195.86])
	by smtp.corp.redhat.com (Postfix) with ESMTP id C936D492BE4;
	Mon,  4 Mar 2024 13:43:58 +0000 (UTC)
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
Subject: [RFC 1/1] platform/x86: p2sb: On Goldmont only cache P2SB and SPI devfn BAR
Date: Mon,  4 Mar 2024 14:43:55 +0100
Message-ID: <20240304134356.305375-2-hdegoede@redhat.com>
In-Reply-To: <20240304134356.305375-1-hdegoede@redhat.com>
References: <20240304134356.305375-1-hdegoede@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Goldmont p2sb_bar() only ever gets called for 2 devices, the actual P2SB
devfn 13,0 and the SPI controller which is part of the P2SB, devfn 13,2.

But the current p2sb code tries to cache BAR0 info for all of
devfn 13,0 to 13,7 . This involves calling pci_scan_single_device()
for device 13 functions 0-7 and the hw does not seem to like
pci_scan_single_device() getting called for some of the other hidden
devices. E.g. on an ASUS VivoBook D540NV-GQ065T this leads to continuous
ACPI errors leading to high CPU usage.

Fix this by only caching BAR0 info and thus only calling
pci_scan_single_device() for the P2SB and the SPI controller.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=218531 [1]
Fixes: 5913320eb0b3 ("platform/x86: p2sb: Allow p2sb_bar() calls during PCI device probe")
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/p2sb.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/platform/x86/p2sb.c b/drivers/platform/x86/p2sb.c
index 6bd14d0132db..3d66e1d4eb1f 100644
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
 
@@ -98,21 +100,12 @@ static void p2sb_scan_and_cache_devfn(struct pci_bus *bus, unsigned int devfn)
 
 static int p2sb_scan_and_cache(struct pci_bus *bus, unsigned int devfn)
 {
-	unsigned int slot, fn;
+	/* Scan the P2SB device and cache its BAR0 */
+	p2sb_scan_and_cache_devfn(bus, devfn);
 
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
+	/* On Goldmont p2sb_bar() also gets called for the SPI controller */
+	if (devfn == P2SB_DEVFN_GOLDMONT)
+		p2sb_scan_and_cache_devfn(bus, SPI_DEVFN_GOLDMONT);
 
 	if (!p2sb_valid_resource(&p2sb_resources[PCI_FUNC(devfn)].res))
 		return -ENOENT;
-- 
2.44.0


