Return-Path: <linux-pci+bounces-9145-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 49439913C23
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 17:20:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 045CE2851FD
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2024 15:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA0811850A8;
	Sun, 23 Jun 2024 15:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="00nT+Bsd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TrUOv2rf"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A1F185091;
	Sun, 23 Jun 2024 15:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719155933; cv=none; b=gaSsd11/+zTnWU8BDEZfas/Go597JLGDd1bHTNtmZwzcIJNeampE75PaOr4rw6Ttsl5cRJL3TnQYxo4/23GpjGtgNcmOClA7jWB+8JWQmqFfM3SjldmhJFnOtwK/TofxxjjTQfFJpr/FGYwbXn1yy+xnamAdQh9l0xQL3zYBDXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719155933; c=relaxed/simple;
	bh=lZJSbJIjuls5uvg427hLTGbgKUxkm2pLgnJ63CBjy38=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=knOXtHU9bT8l9Gcfsk2TDFfZCQ6CdAetysGPvPCsN3SaJ1UmKlFhfzn42JEFsny4sFy9RRytnjVNgJr9uuq7OwaEl3T6zT/cswIBY0Z2Gom+u+7sy2gTa0ZQYRQdNFPF7kB+sXZTOy7aVSonLcIsJ/tN23/hJ2QcpJInHg4x1ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=00nT+Bsd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TrUOv2rf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20240623142235.395577449@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719155930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=5g+/TNQ5raYN3z+NHWJMLW27TgpXviJLsOri9fpyqos=;
	b=00nT+BsdpZKIUu2Ud6lQk9mg5BjuUIoXdQAML7kUsxyvY9cGLHVy2TW50+hQ6Y5CnzLAf6
	JmktWJcsuPUAt+OnKYqbj7nFCUj9JJhcYCRRWs4w3yr8MKe7OaidHxmmmzDIFzVwG2Z92R
	8dOuKV6U8zL9CuUfzjbeQqQnVaKismBqYQrceHj/MerM2gZjZ/8irDIlYyjS6Y3cckiRqy
	+hbYk6FSs50/DtXpqDt23+fAwKIKM3vh1R776wVBnRFei9nZy9LclL2Sn3lnx5jcBRPpTd
	3OXzHinR1OT62Qeu7Fxl4Oq1bbXhCyE3BGYuESVI+GwCsXLn4Hm2VKk2Vwmugg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719155930;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=5g+/TNQ5raYN3z+NHWJMLW27TgpXviJLsOri9fpyqos=;
	b=TrUOv2rfISBU+dO+5vB/iyMln8r+gGKITVeE2XGxvjEWBzppD8eEracaTCNT82PogM5GoD
	3+paOQs4cYSIEkBA==
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
Subject: [patch V4 11/21] genirq/msi: Remove
 platform_msi_create_device_domain()
References: <20240623142137.448898081@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Sun, 23 Jun 2024 17:18:50 +0200 (CEST)

From: Thomas Gleixner <tglx@linutronix.de>

No more users.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>


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



