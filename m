Return-Path: <linux-pci+bounces-8812-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E65DF9089DE
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 12:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 899DE1F25B3B
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2024 10:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E4E19ADA8;
	Fri, 14 Jun 2024 10:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z74DZkk8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oe0WAv+o"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2806819AD81;
	Fri, 14 Jun 2024 10:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718360737; cv=none; b=r35ZaUpST7kJb08CVXHeYOLXrko0MCSgtnwoh73ophz36Dr4GGTDqItttvoRTR/fuCHxpN583RAjHp8jOPNH56prHcwGe7c7e1e73qyl40K18mbdcFI0SrKtRxlz54QsZG1PgpYJJ+AcoLJ2qmgqwNvijGLZ25Arbh4SMbWKRHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718360737; c=relaxed/simple;
	bh=JOq0aEl0NoDI8HMVqP1G7ze1cDRymSGt5CfqjH86Us4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fA94r61ZhpwEFrrK0CYshNZtYRGgzCpNU+hB3fM5vl3tSDBOHJI2zLOU82oQ7subm38Ub9ZGC8vkYfn0ipEZT1jo6fIjdWNtEiXDyS6FDKk8r6jdtx0hHnPXjEVauNXcN9Xjh0m9antRlrV3dL5ZoQbSk2feuJSG0ppe3hw5zDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z74DZkk8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oe0WAv+o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718360734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IoWIhn8Qz9Gzw9KGqqKiXojJYOmF8v+7IIpGxNKVEqg=;
	b=Z74DZkk8oQBWswhyMLnk9GYOPbbH26N5/JbxzOpcCBLg5uMazF+jWeTEgqostsrLtJEz/H
	zjNUgnBuf/qUsYTC2Z1qMHYrlFqBAf5xvDOE1HrlGm8KIG3gfcvzxrUpsoGG3U8qt4iTUX
	Ks/7CGcpnHh9NwKNCQV6v8Af2Ui+SsvrJp6m6yefFLQS0kVm3+L77keZGURCL5MTQHjRjY
	ExNkGQt/kNHy/to6Fj5PPKkIjyRB7xxzoFHuS3BdOtVBUdGM/nzYHtsR3kTsT8DyoxgCgx
	F7C63dTWtqPyIZyudD16Kbo70sxWVZYZqeXgTWtFSEHscJ5gv8nFNNimECGkjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718360734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IoWIhn8Qz9Gzw9KGqqKiXojJYOmF8v+7IIpGxNKVEqg=;
	b=oe0WAv+olVQWau8y42LpGQxP78YoOlLvI71ZgjNwNmqzOjOl1yLEcn1RYb1h+ZSlm1o7+7
	lEMOeEHsWZlcJDAA==
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
Subject: [PATCH v3 13/24] genirq/msi: Remove platform_msi_create_device_domain()
Date: Fri, 14 Jun 2024 12:23:52 +0200
Message-Id: <20240614102403.13610-14-shivamurthy.shastri@linutronix.de>
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

No more users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
---
 include/linux/msi.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 04f33e7f6f8b..4ae036d0c7db 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -660,8 +660,6 @@ __platform_msi_create_device_domain(struct device *dev,
 				    const struct irq_domain_ops *ops,
 				    void *host_data);
 
-#define platform_msi_create_device_domain(dev, nvec, write, ops, data)	\
-	__platform_msi_create_device_domain(dev, nvec, false, write, ops, data)
 #define platform_msi_create_device_tree_domain(dev, nvec, write, ops, data) \
 	__platform_msi_create_device_domain(dev, nvec, true, write, ops, data)
 
-- 
2.34.1


