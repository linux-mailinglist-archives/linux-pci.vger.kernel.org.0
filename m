Return-Path: <linux-pci+bounces-4421-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C9E870341
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 14:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32DF9286DA2
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 13:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5D1C3EA73;
	Mon,  4 Mar 2024 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5CsINmC"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4453C3EA88
	for <linux-pci@vger.kernel.org>; Mon,  4 Mar 2024 13:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709560174; cv=none; b=GetGlYj1V08giTMmeqi0EMRNVKJsA0jCcVibhodGGAYkDbnhWGE609nqBYejFkEmFkCo64GRUoXXqpBMf4k6XRz6JKSaUO21Q6bwWmAuaHxsWyr9h/0YFkxWQPSA3SDe9a0xuP/CikQL89IaSVqhpMnu4wAGRaYE4/7IhOnK/og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709560174; c=relaxed/simple;
	bh=ab6NCkfs608hbc+RmM+x7S7Cf9KVhXHplzzitqSTm1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=scoe13Y/QqQoXT5bumq6ZiKGxbkNIfOwjxL4BTU0L5Kyg0AM33e6R+E1vr4sQz+n5fgSbG39j8H46MFLwsfKlJ8elQ4eQ+H9xzJe1z63RxOR+BYEZYl/FQfGtFo0TFLFYI9Hr3wgpPKHpezebiJby3IBwJqIhMie+b+D9obEuZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U5CsINmC; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709560172;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1j6QC9mKfo/Twv/PFscDn/m8Ct/THACvivrr0TsTMSU=;
	b=U5CsINmCpv3cZKaqXW7OZPz8E2QjNbpeyrCS+0iDcuk7u5M1L9/kf0w0Z85mDrqX2oVB4X
	EtBDzRSdX/iES1UHUOM6hmhAE70OpC4rtoFJwHmYyizpbhILRJriqBj7RSHa6yL4hYEJct
	hGiqlY1JetxSZAE60gB5DS8/XqkeHYc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-572-Ht8lGBtcMCyvDbTZrbhjsA-1; Mon, 04 Mar 2024 08:49:26 -0500
X-MC-Unique: Ht8lGBtcMCyvDbTZrbhjsA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4C78C1064C67;
	Mon,  4 Mar 2024 13:49:26 +0000 (UTC)
Received: from x1.localdomain.com (unknown [10.39.195.86])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1154A400D6C9;
	Mon,  4 Mar 2024 13:49:24 +0000 (UTC)
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
Subject: [RFC 2/2] platform/x86: p2sb: Make p2sb_get_devfn() return void
Date: Mon,  4 Mar 2024 14:49:21 +0100
Message-ID: <20240304134921.305604-3-hdegoede@redhat.com>
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

p2sb_get_devfn() always succeeds, make it return void and
remove error checking from its callers.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/platform/x86/p2sb.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/platform/x86/p2sb.c b/drivers/platform/x86/p2sb.c
index caf037b44487..3293c2a4ed6c 100644
--- a/drivers/platform/x86/p2sb.c
+++ b/drivers/platform/x86/p2sb.c
@@ -43,7 +43,7 @@ struct p2sb_res_cache {
 
 static struct p2sb_res_cache p2sb_resources[NR_P2SB_RES_CACHE];
 
-static int p2sb_get_devfn(unsigned int *devfn)
+static void p2sb_get_devfn(unsigned int *devfn)
 {
 	unsigned int fn = P2SB_DEVFN_DEFAULT;
 	const struct x86_cpu_id *id;
@@ -53,7 +53,6 @@ static int p2sb_get_devfn(unsigned int *devfn)
 		fn = (unsigned int)id->driver_data;
 
 	*devfn = fn;
-	return 0;
 }
 
 static bool p2sb_valid_resource(struct resource *res)
@@ -117,12 +116,9 @@ static int p2sb_cache_resources(unsigned int devfn_to_cache)
 	u32 value = P2SBC_HIDE;
 	struct pci_bus *bus;
 	u16 class;
-	int ret;
 
 	/* Get devfn for P2SB device itself */
-	ret = p2sb_get_devfn(&devfn_p2sb);
-	if (ret)
-		return ret;
+	p2sb_get_devfn(&devfn_p2sb);
 
 	bus = p2sb_get_bus(NULL);
 	if (!bus)
@@ -159,7 +155,7 @@ static int p2sb_cache_resources(unsigned int devfn_to_cache)
 
 	pci_unlock_rescan_remove();
 
-	return ret;
+	return 0;
 }
 
 /**
@@ -179,17 +175,13 @@ static int p2sb_cache_resources(unsigned int devfn_to_cache)
 int p2sb_bar(struct pci_bus *bus, unsigned int devfn, struct resource *mem)
 {
 	struct p2sb_res_cache *cache;
-	int ret;
 
 	bus = p2sb_get_bus(bus);
 	if (!bus)
 		return -ENODEV;
 
-	if (!devfn) {
-		ret = p2sb_get_devfn(&devfn);
-		if (ret)
-			return ret;
-	}
+	if (!devfn)
+		p2sb_get_devfn(&devfn);
 
 	cache = &p2sb_resources[PCI_FUNC(devfn)];
 
-- 
2.44.0


