Return-Path: <linux-pci+bounces-30958-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE814AEBFD8
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 21:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9CAE7B0176
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 19:29:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141D72EAD19;
	Fri, 27 Jun 2025 19:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="pv5QW8N+"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530622E8E02;
	Fri, 27 Jun 2025 19:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052586; cv=none; b=YqVU4fECYdgzEZ0HH0nUg4iR5CuGPq1HEgcf1tDw8qWg/9mBBQ5BpD0W8Jt0biD4KE7lRPK8ojiZ8evjUR1pJMbrAgWt99zRLJLwCJB350ecZCfXBw8ENXeSYBarp0kCOFNL1NrnBxfv+2mdcFalKPxKlPB9ULK+hDGL72ndMz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052586; c=relaxed/simple;
	bh=qGYN3AV3osezWNS5dQz+DCSh5Js7ChADk/vd5Bl3bxg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jG7hZzLztcgpa4GjFwmE1mhiCz1Zl3mxky4tv2g4xxp7V7UOZ88TtHua0lKM+nGVFXkHlVH3OOrG0QSzsXarXuJ/I1Jxkfq98Btnl3ikyn/3CLUooHnBsV7+T3NihLAMhHukay29kQHHXqvZPqnNA/8j799WOassHvkaA69Apwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=pv5QW8N+; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 3377F66DE60;
	Fri, 27 Jun 2025 21:29:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1751052577;
	bh=qGYN3AV3osezWNS5dQz+DCSh5Js7ChADk/vd5Bl3bxg=;
	h=From:Subject:Date;
	b=pv5QW8N+/CjOqD34ww8lg6F1vHCz10J4x2GW+bPON/8hvBHk5t+RY+VRLrFvfwgcz
	 catNpIm99VLg+SiEImlmJDIekhwzu8v0DuDtgEimwTQja0JPLDmWV2sTcTqXS5NkYD
	 FsLMuODmAihPM3Hlu5a6kbabdqAD7nvp8UAAQYirQ+YETPgpiwfOyNrOYbOOXNK/N2
	 GBnSGkcuP/f5UAkk6ulGdi1QG+YnZNyb5gpFj5hIhTnYIJX+ZImO8R5rQ4htoneOg1
	 kF6vc5ZJHlF/kNO1zv86KzO2UJTR9e+dr1X+kLb+WgwO0nhV8q0Cb+m0w1OmPF8Whf
	 DtrUzwWcfHyZg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v3 6/9] PM: runtime: Introduce __rpm_get_driver_callback()
Date: Fri, 27 Jun 2025 21:20:40 +0200
Message-ID: <2054356.usQuhbGJ8B@rjwysocki.net>
In-Reply-To: <5018768.GXAFRqVoOG@rjwysocki.net>
References: <5018768.GXAFRqVoOG@rjwysocki.net>
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
X-VADE-SPAMCAUSE: dmFkZTGrSjjgwBeoPV1BTemn5ImVCZpPTZb07vPRCPpCLNITJNQNwAJrBW+NvQ9gHfopUGw7eKCZUx2JvTkH7ndztXO95C/5NZYx0U0uzSGwSElzY3a0yFW5y/ST6sLyUL+pkZNb6zBf5QQDeWSHMTwFL5SzhnW4lYOV2aXUoJnPKm0KcXRLQpgIKgvtcuh9kc8szEcWaDKkWT6ZvZMLezK4NKUrQ0LRPHVUG/J8XldG2aWmsAAgiz8DIA4tSCjGi3syq1aAO8pJ5+EOuYaRvLcxgtvWWEpF/MWy84RxjOnkuHVdyEMV6Ug0G9LNrdrQ+TwE0ATvvO2S6WiA1+7Yw5g2H305a6HGXDySMBqAotFBAfk+5FHBLB5PwEBpEGiORQWT7lGaqwG4jpesER8Pje1XjsRjuHitns+vz0SLqkJeNhYO/fbWjHvnr3zm2No471oww+Lsj9MF5+MZqBv0FSNUF4K9bk032oLDk3XyM9eRWMHPOdeipvZMZweZBMZfwAJukVcoF6rTitQ682F/tyybO2HRLsFUPaEVoMuGPCWsKOVAVnLvucVI978OmkcwuiVALWXOUm7Px0R+2IXFj4jFBw8uT1DXf8NbxQTMcAJnczQae+D+eKJ/V0qsZ3m+K81yvkji6taZT1/aJDj0iLl3gpWdIJSWKdk9zACdLm0ec0QiKg
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

v2 -> v3: No changes.

v1 -> v2: New patch (not actually posted in v1 by mistake).

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




