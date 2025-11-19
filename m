Return-Path: <linux-pci+bounces-41698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5581C7154A
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 23:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 299A14E31D1
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 22:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEFFB32E754;
	Wed, 19 Nov 2025 22:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b="ADyj2e5H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9D032C333;
	Wed, 19 Nov 2025 22:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.226.149.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763592166; cv=none; b=GX6qg2PoasfqEpxhctENh3KI9EJH97s5YyFcSckGTEnkGJsDsAEFsB+2bfUtqbB1dnaxfjIbFPlCkFfFnH/z03OYvvddNY6FJ8sc1gkjgOsv/gAXIp9vA5J0FAkXVGcy5yv+roAUyZp5oVl9n0h8aw59t9UpbO6oIl8BblZVMog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763592166; c=relaxed/simple;
	bh=xi1t4MFBQ1L8tT9qBtdZpKRHloM9ntgypdnghQeHWDg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KSAw9T8m8WoQKUkEiDngTWABlSCyhc0aEYBibZUD0XDDT7Bbtbcm6OPDC/LkxWQhN10bd/oAXkWIHUMHrrxOoc1sTq07CvDOpYpGOSptcgD74GwSyuYLa6af4GCk4D0biK5iy0H3aR3daLeVMKRWbGfup/p/Q5Tudkf4keO2hJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=runbox.com; dkim=pass (2048-bit key) header.d=runbox.com header.i=@runbox.com header.b=ADyj2e5H; arc=none smtp.client-ip=185.226.149.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=runbox.com
Received: from mailtransmit03.runbox ([10.9.9.163] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqsm-006you-TB; Wed, 19 Nov 2025 23:42:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=runbox.com;
	 s=selector1; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To
	:Message-Id:Date:Subject:Cc:To:From;
	bh=VlTq4CSr8IVQYIyEUXYTQu65fyJbQD/rfAsxYUTy3tQ=; b=ADyj2e5H26WHkINTwYZB0c1OVX
	rE/Oj5NDMWcAhzBDVK7jHNJaFxgM23dxoPBAagy/pLzlObzYMvGIQ/+yYv4aaq4uI8A025mF5V1Fj
	rlDmX9ev18QxNIz0+YZGnXQEVT58UiYAqoBo6z28fhLSXhf7o/Qr71XSeu33wEQN9WvsFvlYKn+D2
	DO1eJY9hjEms79MBX6LO4gBB9QCBMzO2BbKQyvooNrbUHAUgj4g+Ra1Uw/6032dtlaOlsbMZY9WeY
	YsXyhu1okMAAgMjJdw21k7RLt+45f7kk03EP9iOf4cgsw0VK22WQHk0oJf/gh5iRXQjEPaOdb5F9l
	YH1XSglg==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit03.runbox with esmtp (Exim 4.86_2)
	(envelope-from <david.laight.linux_spam@runbox.com>)
	id 1vLqsm-00006p-J4; Wed, 19 Nov 2025 23:42:36 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (1493616)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.93)
	id 1vLqsg-00Fos6-Nd; Wed, 19 Nov 2025 23:42:30 +0100
From: david.laight.linux@gmail.com
To: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 25/44] drivers/pci: use min() instead of min_t()
Date: Wed, 19 Nov 2025 22:41:21 +0000
Message-Id: <20251119224140.8616-26-david.laight.linux@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251119224140.8616-1-david.laight.linux@gmail.com>
References: <20251119224140.8616-1-david.laight.linux@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Laight <david.laight.linux@gmail.com>

min_t(unsigned int, a, b) casts an 'unsigned long' to 'unsigned int'.
Use min(a, b) instead as it promotes any 'unsigned int' to 'unsigned long'
and so cannot discard significant bits.

In this case although pci_hotplug_bus_size is 'long' it is constrained
to be <= 255.

Detected by an extra check added to min_t().

Signed-off-by: David Laight <david.laight.linux@gmail.com>
---
 drivers/pci/probe.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 0ce98e18b5a8..0f0d1b44d8c2 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3163,8 +3163,7 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
 	 * bus number if there is room.
 	 */
 	if (bus->self && bus->self->is_hotplug_bridge) {
-		used_buses = max_t(unsigned int, available_buses,
-				   pci_hotplug_bus_size - 1);
+		used_buses = max(available_buses, pci_hotplug_bus_size - 1);
 		if (max - start < used_buses) {
 			max = start + used_buses;
 
-- 
2.39.5


