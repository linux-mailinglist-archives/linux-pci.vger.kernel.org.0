Return-Path: <linux-pci+bounces-9142-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8971D913C1D
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 17:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F5361F22285
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 15:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5711D18411D;
	Sun, 23 Jun 2024 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VajC+rxr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WUWqIz0+"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8783181D14;
	Sun, 23 Jun 2024 15:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719155928; cv=none; b=J2+R8Gtszuld/B9Bo7BVwpzLw1idoth7w6DuG8F/ToywFlL6EvDuURcAz9UCG1a/jd37EkPyXLMn3ss3xdRwm7akY4YtcLT7Xz1uYzyeAoAyx3Rj6NLdHahTvyEMdyI38whrpBYkANSqNSCCJ7xFnDedWsyjBUW2YHTXL5EjY3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719155928; c=relaxed/simple;
	bh=9R6Pf4h6MHAY+fO5HTo1aZNwmbmzd4EmVjHCkaQRTus=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=MMWncrLWTYjYlPouGGfJ+tY5hZhiZI1/PbpSnItMtUwUcH7VkLVkUqXV2QivXsNdoJSHv5dYS/fvlNswJBu0n6XKQ2zHT+Paxu+k2DsPZmCAEPx9dr5x5AnEiUu3G2pzeLuQjmcmWXuKW4NgKnJa4WVL17UX8FBSlWVE+MVQwHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VajC+rxr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WUWqIz0+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240623142235.207343466@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719155925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ny/xLHHBI8pj1DezroGAGGpqksCi1QsmJy3JhhsXDiA=;
	b=VajC+rxrDdblPUv+7QMPfpJna6m6Edsi+4PyLZT3KgXOV3IB2rYoVUZbu0kl8R6JGSqJRL
	ucoaaYN2P74WjPYLEwXWw/83JPcEDEg2xQiZ7ICrOQOvzYMxNsNCB5LcFudTkEwlVxDT+V
	rkbh15BGa5qArJwzyuDVvQ1BOXNscVJIFVA0JjRzb4GC66rniKTr77hZxY1H5+djTzIKtQ
	jGkcA11xvhz6jsNToHsEtEkEEseiQnTO5aRO1az/zBdVVp9TcvGo4sLCaLgDspSczPTV3o
	n/a9dCxZSl+lHVfUEy1fxzLKKKXPM9MbOQgHB/aQQychGWOd30Sd9P/GquLWhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719155925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=ny/xLHHBI8pj1DezroGAGGpqksCi1QsmJy3JhhsXDiA=;
	b=WUWqIz0+tDgaW4cUwToSovywAm7gU7GpaFZkDhNF8GTWIhFFn2MUg7wMQ/r2zMSa3sRVfL
	lNtpeOBlRZD9j/Cw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-arm-kernel@lists.infradead.org,
 linux-pci@vger.kernel.org,
 maz@kernel.org,
 tglx@linutronix.de,
 anna-maria@linutronix.de,
 shawnguo@kernel.org,
 s.hauer@pengutronix.de,
 festevam@gmail.com,
 bhelgaas@google.com,
 rdunlap@infradead.org,
 vidyas@nvidia.com,
 ilpo.jarvinen@linux.intel.com,
 apatel@ventanamicro.com,
 kevin.tian@intel.com,
 nipun.gupta@amd.com,
 den@valinux.co.jp,
 andrew@lunn.ch,
 gregory.clement@bootlin.com,
 sebastian.hesselbarth@gmail.com,
 gregkh@linuxfoundation.org,
 rafael@kernel.org,
 alex.williamson@redhat.com,
 will@kernel.org,
 lorenzo.pieralisi@arm.com,
 jgg@mellanox.com,
 ammarfaizi2@gnuweeb.org,
 robin.murphy@arm.com,
 lpieralisi@kernel.org,
 nm@ti.com,
 kristo@kernel.org,
 vkoul@kernel.org,
 okaya@kernel.org,
 agross@kernel.org,
 andersson@kernel.org,
 mark.rutland@arm.com,
 shameerali.kolothum.thodi@huawei.com,
 yuzenghui@huawei.com,
 shivamurthy.shastri@linutronix.de
Subject: [patch V4 08/21] irqchip/irq-msi-lib: Prepare for
 DOMAIN_BUS_WIRED_TO_MSI
References: <20240623142137.448898081@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 Jun 2024 17:18:44 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

Add the new bus token to the accepted list of child domain tokens.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


---
 drivers/irqchip/irq-msi-lib.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index 6aa4974d2d12..40c19087d719 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -67,6 +67,8 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 		/* Core managed MSI descriptors */
 		info->flags = MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS | MSI_FLAG_FREE_MSI_DESCS;
 		break;
+	case DOMAIN_BUS_WIRED_TO_MSI:
+		break;
 	default:
 		/*
 		 * This should never be reached. See
-- 
2.34.1




