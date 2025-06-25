Return-Path: <linux-pci+bounces-30650-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0868BAE8E9C
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 21:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EA634A5440
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 19:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F0B2E1732;
	Wed, 25 Jun 2025 19:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="KbRUa7/K"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F282E06CD;
	Wed, 25 Jun 2025 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750879553; cv=none; b=mRSvNeeYdeorNwomyGC9aGkHqqIwlI/klCOJWPMv6eEsqfNqOX8jfRakwUBbASkQVcIFJ4AhLQOZuFdl2vNPgWk6E7MPFP679hyOvOLLZJeeZr/YfMOd/0CTelLzpW6gdV3L5MEEHwHrQhZoODQeUHW7wod54Rgs2cwNuALw7c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750879553; c=relaxed/simple;
	bh=ma51aG4nAF0i+mtWhvtB7GFVsMicWR6PiqiDI3vGMPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g8vZBd0KWZJ7BhX3gtWNf3Kigq4ZKfXKTrVSXYcIgdqfQ1NNlNIvHjb/3MSnWPhUxffjhvPhjutSVw5WahYoldCi1P9eGa8UYWz8QuL2H4Tf0rSvU+jHDuXcVFEZ0bTTBWQAIErKaoEr+0W8+aPmW9pnkPEas43yCpjOcz/wMKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=KbRUa7/K; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id D61EE66E810;
	Wed, 25 Jun 2025 21:25:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1750879545;
	bh=ma51aG4nAF0i+mtWhvtB7GFVsMicWR6PiqiDI3vGMPY=;
	h=From:Subject:Date;
	b=KbRUa7/KX36JifdwVde9/hc955gnjcwTXR3knlflNouXakmHV0X49JX4CSJaI/wRm
	 GP8MXI0vjQwnoWLV3hTP2z5oWAUhuhdM8fXBrW0Zr4HlCggm6DMWBC0vn8TZ/0shju
	 9E0i1OogxEUmV5/EXfy2xfwTw96yZx5ya1LoVDJDxlhyqWsEy2jakcIbC48EswDPUx
	 Ih47MsHRCWNG5fBTBZUaBy8WVUFNahR0bB7Z30jSsuXQbzewKQyqu5uVTLq082Gv7B
	 8F65cw9obkhku0d3FwzlM7DxzdLamzKKP56YOTmorNtHzWj7qbrwj79tyvOWDzyVgb
	 xLKNMT+np2mpA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject:
 [PATCH v1 0/9] PM: Check power.needs_force_resume in
 pm_runtime_force_suspend()
Date: Wed, 25 Jun 2025 21:17:34 +0200
Message-ID: <3306233.5fSG56mABF@rjwysocki.net>
In-Reply-To: <22759968.EfDdHjke4D@rjwysocki.net>
References: <22759968.EfDdHjke4D@rjwysocki.net>
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
X-VADE-SPAMCAUSE: dmFkZTFf0XyIiSZsZxYER0kz1TDEaXPAxA6gWWkqxbUG6bEHYAAT6v7TovVLR3EubwKjtEYyKmRiDNwmxXjQgb7Fv7X9ZuMdrdZfAsHv0PNIdc3iCuimsCLgXHS3VdwsBDlX+N2aSEHhKkKe4bFtl6F8Z6j2Dip+JGIUOsjjf6wHXknBNzvedAFcMa3I+tP7mmNK0F2ZVMgNSEzPeNupteWTsKw+sVoNy7iibCNpCgtEmjTquEHJKyONjNL/DspJaB9CYI95YPuyjrNfj7djbo9ryKCwSItxPuwAqjcIzTCmlXbMERM6KTV/Uy/Mx0PyilUut5rFF6N5pUFFlP2Rd0dpJHiDZjw2suz76zHZzpBqcgr07qd5yjCiDZopW6C4C7twN+4p4beqdCbBzznkb+aVnui3urYGpFt9q0ZXKcB3EN2xpbd/HaDc2VecAnHTiLQOVCzI2O8LkVkEpetulTWgiIxvuauNbC56nUdV5htptx0O0iHpe4D1gcj+KHiz9CzoYJEJtmCLc945JxZoJQjKrakAYPFtxUwVCXLTG+MOrQEMDukukHkkdt8DmUKauDO4CmTLZy4Ld182JxGVs2uY8P7n/9WqMeqEzioR3Ikzf+Mjm72q+Z+gBU5hqklB9KehxRVK6XRZhJ1H4B3wcXM9w9cx6aGLB1e/jEERpsFJu9Semg
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
 drivers/base/power/runtime.c |   21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1975,7 +1975,7 @@
 	int ret;
 
 	pm_runtime_disable(dev);
-	if (pm_runtime_status_suspended(dev))
+	if (pm_runtime_status_suspended(dev) || dev->power.needs_force_resume)
 		return 0;
 
 	callback = RPM_GET_CALLBACK(dev, runtime_suspend);
@@ -1990,15 +1990,16 @@
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




