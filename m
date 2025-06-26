Return-Path: <linux-pci+bounces-30808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BB6AEA51E
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 20:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBA234E1F8B
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 18:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56672F0C74;
	Thu, 26 Jun 2025 18:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="UGH+pnsI"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 044992EFD87;
	Thu, 26 Jun 2025 18:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750961753; cv=none; b=F5fUYlXSGW2C4dtBwW1FXPBLUbx8I4EtRC5McUKUp/P5kuz2Lmt4nPyX2dHkFn0O4n0xfPj33iwq3iiEYZZ1JC2RN9DYOXlobV1CgCV5bgItv76n0ctaconzJAmyWlVwpbzNjGlpi+smCyjWVaBMr7a4L4QQtV4zE3GurDjZafY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750961753; c=relaxed/simple;
	bh=5Ghj7mmpXK5+Z14K3i4eyh7PxN+hKxNJI1KRN27J7qI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c1hozEiT6cXz3RW7NZMd0Rrru1OSKikoH2O8VEKo++r5xCuQexm4CyT+ZjdvaCY8z2NY0TieHgaTt0wJJ69zzS9Eic1GBWbGEKMSP0OKdnIv37iD9XXplIb+sAdVKGcToFCozQJYWL5R80xqT9ATDXibNbSxC+oieg32Me7jlFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=UGH+pnsI; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 0A8B466E9A9;
	Thu, 26 Jun 2025 20:15:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1750961750;
	bh=5Ghj7mmpXK5+Z14K3i4eyh7PxN+hKxNJI1KRN27J7qI=;
	h=From:Subject:Date;
	b=UGH+pnsIM5ouM6UrqsMrpNQUVY8AjBTnL9xIHMHV5EJqNo7ZE2Uu71n7C2nU4p5Z3
	 RIjhD8mZcsOgMT5SZW3Ryk3fHaFMb9D6UbW7KktXjpMU3v1JXjn7vOC+6gM3rTf1yt
	 +kN/q+4fxixiKpLTyrVcHwNRNxokUK1o+uq7+WJt1bBXyd62gB7MBed9N6laSVdFT+
	 zCfHTEcmiNI7Y/nu6MZONCqdhOyx6qgWnLuXJWVZC11zsND/r4OkmCXUcnGY2cbO4l
	 jiZKEq/7DFZ/jXNxOISQzmwCTRbOOCx7e/mS+7BOfhG0Mn7efj5KsH/W4mrF5w4tuD
	 4ZZVn2Ja60kmQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 1/9]  PM: Use true/false as power.needs_force_resume values
Date: Thu, 26 Jun 2025 19:57:41 +0200
Message-ID: <2251535.irdbgypaU6@rjwysocki.net>
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
X-VADE-SPAMCAUSE: dmFkZTF716g97GLxl5r0PfOIWPAhDchnkSWDAqwBHc32sD+HpU8yKJB8xV8olL9lC0SzkWwWofqH3VgYdVRji5cIw9ZbUY7WKZiWjf3xKrF5n/kFXPdAEOzPBCDRv7/dwAHJIQ0XttMc6iSOqO8REJ6/sQbblDgpzZ3yfiPesShmkNx66bo1AYj8VcmdJw/BBHB050Zj303Yb/wm5mvAwXKjtlQwzCdkCdX+5402uydNZLICOp4E4D8MElAkMJkSAvvY8Q7l6VyWrFK73NizhJc5WdxP07GoEdKSjFDXh87nwem3gX8mTgRruroBzE94AJIHpV56uBgDMbkYtmhRhrGWknT+IKOfQNZZPK3Pklypv0d+7J8Eu0HNbc5kenkzyNYo40ABVBwAmeLJegCFIOD9bC3fzLsN6GM0kW9ldhH/fmn0F3RCzPAGeMoIcW18A1+tGyp11anJei0BSiSERzjxOqQikDJYG0PBgmkjholOA3tgSpDU806uK10GJ8hoU4fTp7TlWQ4Y/yleWD/dnXpCgWaPn8lAL1FAuqcqO2qjriZwxoLSD3YktzF+/VlreoGR/brbL+oz1RbdbR161MheWe77vDa+QiSOsoeFbPcPh2yQ4OCeGuz+U9F7M8qrqJpLE15WC7ZaneOSTybeZqsFSiRE9FO8H7gaTxtAIsY7h5CV/g
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since power.needs_force_resume is a bool field, use true/false
as its values instead of 1/0, respectively.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
---

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




