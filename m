Return-Path: <linux-pci+bounces-8800-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AFA9089B9
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 12:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CC591F236B7
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 10:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C44B1193067;
	Fri, 14 Jun 2024 10:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OZIrlT2H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XPcqwysP"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50447193068;
	Fri, 14 Jun 2024 10:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360711; cv=none; b=g815/zJSLX/xfJMHhDn3KufUCTIwRLjw1QyI+mfqJTT7wxFVBelfImhLjsqDkqx5JBIS4Gr6ejMWzzQRSNhbVMoXFdhlUYiVPVg9CIy+fUoIbu/m0efR5Fjz8SngqE1OWlLXdDj3y3XDq4bWvLwM3FX3r+lSupk0GKSALjV9FXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360711; c=relaxed/simple;
	bh=Bz38AJJAkxiyiXheQhddJNiz0L/5mH1liBJj7e/b3Bs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VIafw2JL8uscCelI2NCa1sGydX2YVOkYZ3F6uXUOwwIclT05NygktD78zO2yWodTGdzM34aAAYLGVwpXxBu9oyZTBTR1+AezieD54XJCEjTRAEVgusy2loNExbUFE4iBJhkxI203xA6jw92TcQ/eezSqlC/8/v5TqIqtExNvGUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OZIrlT2H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XPcqwysP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718360709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bi4sD4LcXECh7dwHS2yTW4UCpCGcwPj7Qfpt4c9X9d8=;
	b=OZIrlT2HLUnrq+hPnf83ezpl7OyoE5De9rNYkBn81xMbtfPc1evhX485D+LCIpvw4Iz2ge
	6ooSsM4T8K8ndwavOmVEPy6F/z64xeK0WzUTPPHi9G1pMH3I49DyaIYpqbB0buRpjiHVYE
	GiXfzLjccAgSS1Hng3p8sfsADqfSj2YU+tH3grBpeW3H4uBvHBC/JO1kicnsOTkoDg4O5R
	Bbs/Ik3eUiVtV1X9ZHd+a2hDOxNN26Fcqs1VxMlTjjRYIgFXZ98ibRzTstzUYlmnYOiKTu
	Kxyyk1L/cinJDMxovQtdtjuPb5kGcamltX7l+paWnBRnP51beIQRmFQ4duZzcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718360709;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bi4sD4LcXECh7dwHS2yTW4UCpCGcwPj7Qfpt4c9X9d8=;
	b=XPcqwysPTLs+zhKYpy+HT3Wv0AehgEJnbDrnR1fHj3W1LCYFDfn28pKLIA34AsWdLmsEec
	9dM5tPnEsKaiApCA==
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
Subject: [PATCH v3 01/24] irqdomain: Fix formatting irq_find_matching_fwspec() kerneldoc comment
Date: Fri, 14 Jun 2024 12:23:40 +0200
Message-Id: <20240614102403.13610-2-shivamurthy.shastri@linutronix.de>
In-Reply-To: <20240614102403.13610-1-shivamurthy.shastri@linutronix.de>
References: <20240614102403.13610-1-shivamurthy.shastri@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anna-Maria Behnsen <anna-maria@linutronix.de>

Modify the comment formatting in irq_find_matching_fwspec function to
enhance code readability and maintain consistency.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
---
 kernel/irq/irqdomain.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index aadc8891cc16..8475b83c5519 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -438,7 +438,8 @@ struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
 	struct fwnode_handle *fwnode = fwspec->fwnode;
 	int rc;
 
-	/* We might want to match the legacy controller last since
+	/*
+	 * We might want to match the legacy controller last since
 	 * it might potentially be set to match all interrupts in
 	 * the absence of a device node. This isn't a problem so far
 	 * yet though...
-- 
2.34.1


