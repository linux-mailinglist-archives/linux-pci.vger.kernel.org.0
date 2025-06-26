Return-Path: <linux-pci+bounces-30803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7ACAEA50A
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 20:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 383327B4A1B
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 18:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 183252EE5ED;
	Thu, 26 Jun 2025 18:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="oYRgjITf"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C3D201004;
	Thu, 26 Jun 2025 18:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750961748; cv=none; b=T1IGRA6mxj2SMzdNIjbWuCsIPMEuUJ+MyLD+6aEV72p4gVYH4m2cr0o+//NHwYaBJAtl3gIRIEzLj4zhOrg9BSoYGs57nnP5pKvqWK/1b6gvXdtEHAgQmD5ORVtOg2KrJewU99J9TJHOBLTEGMA2TGglBM/jjEdkh97vwMl+Y7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750961748; c=relaxed/simple;
	bh=780/ATOXshjqm/EGKAazcJERmd1ciKlnGfoV4PmGGjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I/AW2YDntzqZl3DFTVvbQ8sXnLXJIZynX4lJDTR29bQY8MSXsc+QPL0D9/Ll0EvNqhWvkQPObsHZEMxohz9mkfKxzzPy5B6xljagTyzAYp1OSL7FrMQdQH5n56UuqRMhoC1btef3OfYybOWPdTXf9GAGCmwSVdvFbHVO+JKaBAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=oYRgjITf; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 1AD1D66E9B3;
	Thu, 26 Jun 2025 20:15:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1750961745;
	bh=780/ATOXshjqm/EGKAazcJERmd1ciKlnGfoV4PmGGjM=;
	h=From:Subject:Date;
	b=oYRgjITfRq9mvyoioCNBvAgPq+QLsH0fEEX8+nbbVdA5uzfs+ZK/PsVzGmyBupuyU
	 6894igS+6rSkm7f0OrY4d+GdqzgmpFPWmpRfuBV2RdKlWbe4Kx+shGc4wI287N78kt
	 WLM91s6QDaJWxyzYQX56FBPM2aSRhCW6d6mut2rrXQBRoWZQ0A3pm3lOSafBRQhOdO
	 OnqapfqYX+HA+WW/aPlT2L2FItV2hmiRTZoM8yGGwAYWglYnmJsJcxxYYAwMUmffeZ
	 k0IWu8MFAdQbOSsqJP/1PY9hBO2vPqABi1hg+jnm2okNxuXSsMpz2IjvmpPnuy1Vt9
	 XodTNEpZMVEWQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 6/9] PM: runtime: Introduce __rpm_get_driver_callback()
Date: Thu, 26 Jun 2025 20:06:27 +0200
Message-ID: <3909078.kQq0lBPeGt@rjwysocki.net>
In-Reply-To: <5015172.GXAFRqVoOG@rjwysocki.net>
References: <5015172.GXAFRqVoOG@rjwysocki.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"
X-CLIENT-IP: 5.63.189.50
X-CLIENT-HOSTNAME: 5.63.189.50
X-VADE-SPAMSTATE: clean
X-VADE-SPAMCAUSE: dmFkZTELtlwpycCpv0Vcuy8QanEK65EXpXLDYHJklsvPFyrHxl+avjRHDMJ7Pn1w8r8jjwxdARbdK2l6HvrQpU6gOIgHwqnc6mWfuAcVkm0fjKgXKtQhSdxCxnuVXrmGsTXIoZNtqbmO2vNuBJTcPUJZcz8R30PgE7bGEL3PWfdNzVLoVYs7Qoda0OTfmBJ3NatDBgLvJuvPlRG2dcl26WhHZbi4RyoYzmp2r7+bO7YpOn26wkYi1BZUkbAIVk0I3hYwmbSrEOMnYl/hve4oRCJ1F8R5clMEE2pVXAf8o49/YUaNEHtTh2A9QXrvEf9flQXInm5SNV3s2dtsBWqHjVykY5tzr+eZlEvGR2rJ4NAHkTlU7MkNb/hZ+aZy7+rUSjO0gb231iYX4nbwEswu+ow9ldNkrKuBEj7TI5+4F6nIB5XBLygo4qQKmWkvtwRyfT8AysDe05oBmIBOlKMTvN3Qn+3H3RjvFextnBFtDaTY5gQtxsy1I7f8c+rh22wOLCkGwVa4uMwqQ3L+y1h4QpSxh+DIoCxcL0lxyzznJyq+491mY9rA0CNE7udK9TSA04MrmOi9wkdcWPxrgHswZdOG/LdnRkovpXOImkZ8nGEPAGE57p9y9mOyDVEqP7kRQXw+xFjvSQ17U884xPy9h6OS9ZFE5KxGfbPIL5p3h2Gv9CWoRw
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a special function for computing the address of the runtime PM
callback given by an offset relative to the start of the device
driver's struct dev_pm_ops and use it to obtain the driver callback
in __rpm_get_callback().

Also put the shared part of the callback address computation into a
separate helper function to avoid code duplication and explicit
pointer type casts.

The new __rpm_get_driver_callback() will be used subsequently for
implementing callback lookup in pm_runtime_force_suspend/resume().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: New patch (not actually posted in v1 by mistake)

---
 drivers/base/power/runtime.c |   24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -19,10 +19,24 @@
 
 typedef int (*pm_callback_t)(struct device *);
 
+static inline pm_callback_t get_callback_ptr(const void *start, size_t offset)
+{
+	return *(pm_callback_t *)(start + offset);
+}
+
+static pm_callback_t __rpm_get_driver_callback(struct device *dev,
+					       size_t cb_offset)
+{
+	if (dev->driver && dev->driver->pm)
+		return get_callback_ptr(dev->driver->pm, cb_offset);
+
+	return NULL;
+}
+
 static pm_callback_t __rpm_get_callback(struct device *dev, size_t cb_offset)
 {
-	pm_callback_t cb;
 	const struct dev_pm_ops *ops;
+	pm_callback_t cb = NULL;
 
 	if (dev->pm_domain)
 		ops = &dev->pm_domain->ops;
@@ -36,12 +50,10 @@
 		ops = NULL;
 
 	if (ops)
-		cb = *(pm_callback_t *)((void *)ops + cb_offset);
-	else
-		cb = NULL;
+		cb = get_callback_ptr(ops, cb_offset);
 
-	if (!cb && dev->driver && dev->driver->pm)
-		cb = *(pm_callback_t *)((void *)dev->driver->pm + cb_offset);
+	if (!cb)
+		cb = __rpm_get_driver_callback(dev, cb_offset);
 
 	return cb;
 }




