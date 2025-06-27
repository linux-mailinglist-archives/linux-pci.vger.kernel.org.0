Return-Path: <linux-pci+bounces-30962-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 773D3AEBFE1
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 21:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 399031C47704
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 19:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2F02ED17E;
	Fri, 27 Jun 2025 19:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="lUEw4HA5"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A272EA755;
	Fri, 27 Jun 2025 19:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052588; cv=none; b=rOISrm1APMPJ/Qx54SNoOlT9CW6ELxvzIlBIDLVIC0lxERYUEgZF24hn1HC4UM0Hv0i9mQoY4e5m8X3JvYVNVfIAw6hcYvdJLOMhBAKVrv643ndl5cKvk/7h1Pjj9TOsZ+2KptmHm0SCWfhyBUax49DhQn1eQd7re3bodibqpEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052588; c=relaxed/simple;
	bh=YybUBfc+8sGiw13jasECKaaQ7wukGf1o6DQrxm6RhKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NUHztMuImpqlVKitfJsamwynLg3LkrVhj451e9FpHOljEhWgXeWrs/cfGqFdyGLIdGA9rsvdTzPDAKEVwp/9ci6/vtXkKFsPu6dpVWsRqeEepYL080xEc+1+iMAUnyG+8Pa9YxfIReAYBmyCxGEVW6Nwt27Mh4AYXs263kARqJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=lUEw4HA5; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id E953E66DF53;
	Fri, 27 Jun 2025 21:29:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1751052583;
	bh=YybUBfc+8sGiw13jasECKaaQ7wukGf1o6DQrxm6RhKo=;
	h=From:Subject:Date;
	b=lUEw4HA5ctBvx+h0g5AVwYzv2QxoHiRdZq3xDW6UHHiJCTWZtK7/UvrrWg5yHgRlF
	 F4fGLWE34TDOaVKRp+rzqXazpQ/U2uRo+4nQBFHY1vz4PTX7p/xDRWkxBE5LM2xiD8
	 svKjunh4XnGAV0cwd5p//3sUy74nhv2oTjVPcMl/V3i8UcYLrdAiedBseOPWCfpFVe
	 oCJ+MYQyBMo5UcBBQQLi2Ww1yH6WOZjlaJwB7cKevRxwGTIOa1cNFL1UoyxAqjfgbj
	 OQGr5cWn5qUIDqVquwp4lLRXKzI68AWyVxBIf/omZW193qPeQ95KDXIocFqnOZO36q
	 Rr+hxINK0hCDA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v3 1/9] PM: Use true/false as power.needs_force_resume values
Date: Fri, 27 Jun 2025 21:06:34 +0200
Message-ID: <2254988.irdbgypaU6@rjwysocki.net>
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
X-VADE-SPAMCAUSE: dmFkZTGMUf5ozIUuZ+G+BIWXYkha/UUSG8iYef/kxm9xm6hkRjUOHyA7ODhlX0LkM82tu3/gioP+8IFCKojgM359bQwDK8+Et/4ARqFdHmhplrJHKZ0VtgjrlwYyXmvvdpYVUdf1JyOURJCuMzkqRuTZm2czVaP8HE9H1PaJhRlPZ9EfUAL6faVPh1pEPEDNrasKKnajaDt80jgAqena6b+Ga/fMHBqMgpc5wijOOSzvEIz1Kj+OPpXlzwu28DiYKvDviRLz+AP/+/l1tdwY7Pi+LY85uwwDV2GMwgdvA0e6car0+27HK80G+F56t9nhg4+NCbRhYfIzb72Zr1sNRfIlILnzTh8y9Aowew0zACS1YMkc4FS5X05cXiP1oI4uFWVokdy/hstHyZLyPhQg4MOHg1dzkdLPSQWTJQiEJ9mef+gIKm+fpaqH/3A4wWDCitN8IGuym6nDOVHCNbca6nQK8WCmzRfJFs9+zYJJIHZqZoE3SbxRidEJGUbKHU8DcsIVDHJRTAHPoSBvyaP/nWArnO6cMVtJ2wpSwXLzcvrsv4XNBf0FYoILpYFboLC0SoOomNfMkQ4PqKylB83/YbnIlh6NT9U4p8dvcZ3u8slAeH+HCAnT90FGEZxB6XlRUryCq6Ro0Lu2L6kij6YbqFLDzbWMwQzHg7Vvg+eFpCwMf1rHOA
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since power.needs_force_resume is a bool field, use true/false
as its values instead of 1/0, respectively.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---

v2 -> v3: No changes.

v1 -> v2: Added R-by from Ulf.

---
 drivers/base/power/runtime.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -1827,7 +1827,7 @@
 	dev->power.request_pending = false;
 	dev->power.request = RPM_REQ_NONE;
 	dev->power.deferred_resume = false;
-	dev->power.needs_force_resume = 0;
+	dev->power.needs_force_resume = false;
 	INIT_WORK(&dev->power.work, pm_runtime_work);
 
 	dev->power.timer_expires = 0;
@@ -1997,7 +1997,7 @@
 		pm_runtime_set_suspended(dev);
 	} else {
 		__update_runtime_status(dev, RPM_SUSPENDED);
-		dev->power.needs_force_resume = 1;
+		dev->power.needs_force_resume = true;
 	}
 
 	return 0;
@@ -2047,7 +2047,7 @@
 
 	pm_runtime_mark_last_busy(dev);
 out:
-	dev->power.needs_force_resume = 0;
+	dev->power.needs_force_resume = false;
 	pm_runtime_enable(dev);
 	return ret;
 }




