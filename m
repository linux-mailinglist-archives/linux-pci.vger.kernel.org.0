Return-Path: <linux-pci+bounces-30805-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351A6AEA512
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 20:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 741154A80FC
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 18:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3816C2EF9A2;
	Thu, 26 Jun 2025 18:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="e0ui7HXk"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6970F2EE964;
	Thu, 26 Jun 2025 18:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750961751; cv=none; b=X8908UrS5YxyXgN0IrDcMKz5uzll/7UFVtQoqrqgfKY7/Lp72nhiqFgG+qWsJnII7jn/aJ5mnN8wlGpAFbtdhMJrzPJHWfQmNguXmgpv4KPF/370ze/6ZweT33fuCOOZednHaZ3dMPDAvYqJ6x5Gi2cJfWLXcSgXRi/jOeGWF0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750961751; c=relaxed/simple;
	bh=jrR0QwX50YgjBD7ux5m2fHwyJQcVwogX3B7uX59GpJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pm52FYEVwC2u1IRfPcD1RRdSWy4gWAa7OyJdm5dg2ANB2Nb+zMUnwiZfA3j1UGvMDTEMAuCjAFIVtv2R2PApFE5J49ZZXlFGqub7HJ+FEmBHWEYg5UbrlBEbfpJ7be/r/j+jUj6VTOCtStMGSg3bmAj+36MXFH/P4iM+3rR7O7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=e0ui7HXk; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 1921F66E9BF;
	Thu, 26 Jun 2025 20:15:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1750961747;
	bh=jrR0QwX50YgjBD7ux5m2fHwyJQcVwogX3B7uX59GpJA=;
	h=From:Subject:Date;
	b=e0ui7HXkn2P3CZNlgxE8z8VfneRlp++O6ov6ah96Pcedj8I9iMRQAsKuPyx1zxMYX
	 S/cFWt2b3BLxfbbPCbCXuk/S75dFFGKDbqm92VAasCa9uCaZXuw2HlSR09selrImgf
	 tZpkjB2lGb83QKYMZ2O28dAgOOg6bB0hUgeXgyOwfvWm6MU7sOnDFz4Odx7u2vgQoO
	 XK9wYktwDSRhH34/VmbYxOKwMWcjjbNHXuLzDdpitvIFZt6itIqkwqDSk3bzXE1XcR
	 htgs7ZqLxYenmz2brYKGGs/YSxAaXEDLhpP++83i+1tbdMD+RNXtcKxmmUFjJjcdn1
	 f0QnKnSt3zrIw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject:
 [PATCH v2 4/9] PM: Check power.needs_force_resume in
 pm_runtime_force_suspend()
Date: Thu, 26 Jun 2025 20:03:23 +0200
Message-ID: <2336655.iZASKD2KPV@rjwysocki.net>
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
X-VADE-SPAMCAUSE: dmFkZTELtlwpycCpv0Vcuy8QanEK65EXpXLDYHJklsvPFyrHxl+avjRHDMJ7Pn1w8r8jjwxdARbdK2l6HvrQpU6gOIgHwqnc6mWfuAcVkm0fjKgXKtQhSdxCxnuVXrmGsTXIoZNtqbmO2vNuBJTcPUJZcz8R30PgE7bGEL3PWfdNzVLoVYs7Qoda0OTfmBJ3NatDBgLvJuvPlRG2dcl26WhHZbi4RyoYzmp2r7+bO7YpOn26wkYi1BZUkbAIVk0I3hYwmbSrEOMnYl/hve4oRCJ1F8R5clMEE2pVXAf8o49/YUaNEHtTh2A9QXrvEf9flQXInm5SNV3s2dtsBWqHjVykY5tzbAURry+mnTgEbzMYulTzFYmMfT3Ht0p/UEeVRXiVgdjWmXHQ0wg2Jb69HGOGx2dhGH6YcNpYKYIJezhcCx2hWobFrI4NT1K/h2w1DgYOdk/SajLhyPsH4dKO710wBiohhMffcD4mOO0V5Id7IELJrmGJByPFQzpKFE7+HZVDt2Y867XVGiVwH3V4Beub0fj5C+wGYkrD7vxaQuRM99iqyb7IdcMvnDCOYTG4X7ckk2R6VkaAwcQcqo6pRj75VlVIn63LotfJ6NN9qlKFDxjgcmod7PENgDb2ojcVThRcGUm3xgEVhr0NuRTkQEWGQizRIzfNWBBB5xGQ4KtqTvRkyw
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Add a power.needs_force_resume check to pm_runtime_force_suspend() so
it need not rely on the runtime PM status of the device when deciding
whether or not to return early.

With the new check in place, pm_runtime_force_suspend() will also skip
devices with the runtime PM status equal to RPM_ACTIVE if they have
power.needs_force_resume set, so it won't need to change the RPM
status of the device to RPM_SUSPENDED in addition to setting
power.needs_force_resume in the case when pm_runtime_need_not_resume()
return false.

This allows the runtime PM status update to be removed from
pm_runtime_force_resume(), so the runtime PM status remains unchanged
between the pm_runtime_force_suspend() and pm_runtime_force_resume()
calls.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2: Corresponds to patch [2/9] (that was posted as [0/9] by mistake) in v1.

---
 drivers/base/power/runtime.c |   21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1973,7 +1973,7 @@
 	int ret;
 
 	pm_runtime_disable(dev);
-	if (pm_runtime_status_suspended(dev))
+	if (pm_runtime_status_suspended(dev) || dev->power.needs_force_resume)
 		return 0;
 
 	callback = RPM_GET_CALLBACK(dev, runtime_suspend);
@@ -1988,15 +1988,16 @@
 	/*
 	 * If the device can stay in suspend after the system-wide transition
 	 * to the working state that will follow, drop the children counter of
-	 * its parent, but set its status to RPM_SUSPENDED anyway in case this
-	 * function will be called again for it in the meantime.
+	 * its parent and the usage counters of its suppliers.  Otherwise, set
+	 * power.needs_force_resume to let pm_runtime_force_resume() know that
+	 * the device needs to be taken care of and to prevent this function
+	 * from handling the device again in case the device is passed to it
+	 * once more subsequently.
 	 */
-	if (pm_runtime_need_not_resume(dev)) {
+	if (pm_runtime_need_not_resume(dev))
 		pm_runtime_set_suspended(dev);
-	} else {
-		__update_runtime_status(dev, RPM_SUSPENDED);
+	else
 		dev->power.needs_force_resume = true;
-	}
 
 	return 0;
 
@@ -2029,12 +2030,6 @@
 	if (!dev->power.needs_force_resume)
 		goto out;
 
-	/*
-	 * The value of the parent's children counter is correct already, so
-	 * just update the status of the device.
-	 */
-	__update_runtime_status(dev, RPM_ACTIVE);
-
 	callback = RPM_GET_CALLBACK(dev, runtime_resume);
 
 	dev_pm_disable_wake_irq_check(dev, false);




