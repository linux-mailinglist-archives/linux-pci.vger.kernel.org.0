Return-Path: <linux-pci+bounces-8809-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DF89089D8
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 12:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22BB228ACE7
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 10:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AEC199EAF;
	Fri, 14 Jun 2024 10:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0AW9DdRf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l1V+KLtt"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607B5199243;
	Fri, 14 Jun 2024 10:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360730; cv=none; b=uFdoqkjktXJvcew0f0KK6JFxdY6356YziOgF4FUZ8UAKHeDT9U3mFazUiheLtfXAki5Xy4YARPaj482kLIPjRVFVHkxKSsseVqxe0v94By9RZyqeM08BOg49UwPafh3K1r+QNYeuagqsRpDo683YakKmrgFCmXHVvzZ8hTIAd/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360730; c=relaxed/simple;
	bh=Gr6x5Af1T3e6BqYgeDgl5M6TNhij8GwDd9hH6AZ9VmM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pcrSmOOYMPQ3bLNCLfy0pSNufeSFMhci4KCtSG9slRi0+d5qVGlnHAFZ8NU0Eh4G40N3nJxdc2l4PDqCmXqOejAcRLkLzijKYxMmghvM0kSPOvyco9K2WKx3j+zBiE8h0l7mlf+4BnluiSc4wyWrLeBNV45rHUrGcJdZVKujHmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0AW9DdRf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l1V+KLtt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718360727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hu8jwuONIIS4GQdDHULVcq3X+X39ZgE9L/lJAb7DSqQ=;
	b=0AW9DdRfLJf7Vf2/ilethvmyTZH+A48EkKZh/itkVeMyj9rHC258ID6yg8kzyRP+ZpZAd4
	5W8Rv25wIrPxUofwa24834nANepg319T5pi941RJTIkgXKzO2DbzmBcDOBpFig66zj2MYJ
	skSYyZQn1/9YGlXntQukQVyzFUJPQue6y6mo3rjNW9hvBuPbdumZWg5Gvbf5sy0drxTKkv
	V0LFHUlcRIh0KK24BIiUc23rqcCddfb5WLxyOGaia07F3KJmAKB8QIc+ZX5J6h5btUNIsL
	wh/neDOcsN+OGdJNA6b9Xj8zrhj7Napqu7rOnybLoWROJW3zHi15TAAOzmBrRQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718360727;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hu8jwuONIIS4GQdDHULVcq3X+X39ZgE9L/lJAb7DSqQ=;
	b=l1V+KLttbMKCcOMpKdXjPbvBxG6N/BZQG1a1GTkKRDQU796wLGg/gD7jmMc7rKrksbkTbO
	b38VLJt7ukzUS3Bw==
To: linux-kernel@vger.kernel.org
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
Subject: [PATCH v3 10/24] irqchip/irq-msi-lib: Prepare for DOMAIN_BUS_WIRED_TO_MSI
Date: Fri, 14 Jun 2024 12:23:49 +0200
Message-Id: <20240614102403.13610-11-shivamurthy.shastri@linutronix.de>
In-Reply-To: <20240614102403.13610-1-shivamurthy.shastri@linutronix.de>
References: <20240614102403.13610-1-shivamurthy.shastri@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thomas Gleixner <tglx@linutronix.de>

Add the new bus token to the accepted list of child domain tokens.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
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


