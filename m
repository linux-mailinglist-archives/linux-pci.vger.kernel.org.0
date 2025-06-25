Return-Path: <linux-pci+bounces-30649-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39674AE8E99
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 21:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D3B54A5A38
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 19:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A243C2E11D8;
	Wed, 25 Jun 2025 19:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="LQqwJrkH"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E202E06CA;
	Wed, 25 Jun 2025 19:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750879553; cv=none; b=IYNTIEVwQ2q4h1a30JVAE4NMsFO40/q09YBLMfFLz9c+LnlCPJlslRx5rHv7npT54zs8PpU8T0stFKfSChLk+lbbEpxrFOAMOdNJwfFLK8mdk9y/uNWmcXdLNt+gB9C8sSawb4GwdPqf8Y0uGqqeBDXzj/Nc2RFna1ELu1PnPSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750879553; c=relaxed/simple;
	bh=jitevF2LM49CrS922leO0FhKCTCoG60LelCLKUFcPGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ksqciw7KvEfDsDrwn2S0j898oTeW8GRm+mH+Nb4Jm0VIQ7r+EiZBjJUSF5ilQXWlsCaC+oVqtesjooRV6HdsVk9Xgz4LtBFn5HAJkgNK88C3h+UTrXSBfKqVoAwTBUYMd9xB0wR4TgeOhlSs7e0/dSpqKNVO8BLok8UuOCOIv80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=LQqwJrkH; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 166BE66E811;
	Wed, 25 Jun 2025 21:25:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1750879546;
	bh=jitevF2LM49CrS922leO0FhKCTCoG60LelCLKUFcPGg=;
	h=From:Subject:Date;
	b=LQqwJrkH6yzL5ZUSztC1yFHsYVVRJ9h1gv/tNnp+ZZ5bh4LpaSrWaiDQOsn+hTYDq
	 WZaVugQP2hgvuOXMdKia/BOkXvCGLXfndsmYafedtV9wxEJbVUQPtfvgI9xqtfyogN
	 KaXaiGeMEKR99HCNWHJW2gimk1lAEcX+vdRjV8MClzDbK+hXfpipKON9Nn95y6y+QX
	 6SY8xsDMyY+fHxmJCsaPkYayf0hhGbXGlFNgD9BpV+OkTR+gSNQu8OWKpH2DGK9iC/
	 i7NDca0ZFR4cx11tdPteVxbGic2QPmaSHRt9/EadlMbFLghgTuSBBzJL1Y52ZmzAm3
	 UBpUltTYaf0xg==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v1 1/9] PM: Use true/false as power.needs_force_resume values
Date: Wed, 25 Jun 2025 21:16:25 +0200
Message-ID: <3903497.kQq0lBPeGt@rjwysocki.net>
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
X-VADE-SPAMCAUSE: dmFkZTG4CnQAyPiKDc4jTltm7NHnLCVtZKhxHwU/mx8re2dPOhVfeN2eNC/e4rO1ylH7/jVRItFrHJw0alo6q5EY6ycicQVAxpI/D4AkyVUs+mfLX3ZcB3xxv7uahSbIs4J2st+V8cgyyC8VUBcQvaIZl2zWD9dzBr3uiNVX2NjAuTH/gnfcGRRYyxzbuVPNjhWSx8dOqRKOQvf1IglMg/3h7ogdqmaycOwfsL5s2iPEhjShLQY0WqSSxys77Ch18Xb2QGNEyhuCzh8rm8ulzZuyR45HOwqbaOFBEnnHJsxbFQlE2kQLfuFrUSAdGFgOeJNT/FpqijQgMN89RLqtpvna+1fHkTzLrr2TnxJ+BuWpZjbF9tqBAy9YUdaa5zzFwRroWx7WVX8k2rCqSCISXebKeQuoRrXyeo6BIjIY5MrYMVfYNsnwqvU9Jo3KNlBUtyFPBFvO54+BOJhh3sH4dSFfewTnfk2c04meav9ZffBSbEk2oza8IJKEd1+xitusCEHjclNZQ/zBd3+eKlW4h4ie5kkWa2kzdq5gzg/qvAN5pRnmoLNEP2mQ7ppimTtPhkgh4qaB7CapUbQ37nAbr8VB6v5gXG8pgJY5bIzd1heuYtWmggrevT5S3a8bHhgkbeNk/eKPedjlEABV3jCcMIun5//Y8GEN0C7blgqGpKdpNPeEUw
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Since power.needs_force_resume is a bool field, use true/false
as its values instead of 1/0, respectively.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
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




