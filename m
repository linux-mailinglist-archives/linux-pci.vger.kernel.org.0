Return-Path: <linux-pci+bounces-30801-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83E9EAEA505
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 20:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC9217B47AE
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 18:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93ACE2ED859;
	Thu, 26 Jun 2025 18:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="cg+euGfT"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C00C1B0416;
	Thu, 26 Jun 2025 18:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750961748; cv=none; b=hXQFyRGA3+o9R4FmrFcLlAuE5nOXb1YI5xOtxhd9pXL0pQJDO5sg+Ia/x4MREUM+nVYTwbiganaCWoHJJxpt9POoLBce2uUKwYHs4J/NN2sIiVVrTSL+jKkQYhm5qgOSU6T6H6tXvq3uKzfn4FQPrHFWm3yx2rmBBXDH3I8jNqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750961748; c=relaxed/simple;
	bh=0XdUY00XXilqMp4xm15/3+Vzfk9D595eI9rqaslHETA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A3UGbf68qARErqBzaqt1MhJQJQs2r3uCrTIFWoH62IlJxrt0YAlvDIDRgxpvSZcmYYVWZ9kGz8djYekjEWEXQzHr1cRO8NfZS3fm7EVOgxuMQEJOluKff7s2iE3NG3F7sUF4gjOJsTwtqXIqeTJqEHQTOtQDTefAuiNXsb54KMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=cg+euGfT; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 03BD866E999;
	Thu, 26 Jun 2025 20:15:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1750961743;
	bh=0XdUY00XXilqMp4xm15/3+Vzfk9D595eI9rqaslHETA=;
	h=From:Subject:Date;
	b=cg+euGfTZRYoslNudGwMs0Zn2+C7vWQRqavHakEwQ8qRsxRlwcNawUSoa42GrDbC3
	 4MZP7RoJRMjtgM5/y0JGCyKcFbKd56j5Un3+sCKmoHwvmBtelop1WqKeOkAoLCV+0X
	 TQ2U+eaqKg9/UjnIK4s2+6hPFSfdlNkiuxH8kpDHZv91wyHs9ssj6Bq0HHb/Yd8pdu
	 dXROqX3LSUvBsIBIXu9J1IPPcx89Rxzc2w3aq3RTIEd2FR8gpxoa8xAxCRUyaZnMZN
	 ZXbI/e2boOHfvMTO17QFc7WH5DcggdVfX6u1GKVVn/DuzbVhhznsDziHL3bpBO133M
	 TL8Luw7wgRkfw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject:
 [PATCH v2 8/9] ACPI: PM: Set/clear power.strict_midlayer in prepare/complete
Date: Thu, 26 Jun 2025 20:12:25 +0200
Message-ID: <8609825.NyiUUSuA9g@rjwysocki.net>
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
X-VADE-SPAMCAUSE: dmFkZTF716g97GLxl5r0PfOIWPAhDchnkSWDAqwBHc32sD+HpU8yKJB8xV8olL9lC0SzkWwWofqH3VgYdVRji5cIw9ZbUY7WKZiWjf3xKrF5n/kFXPdAEOzPBCDRv7/dwAHJIQ0XttMc6iSOqO8REJ6/sQbblDgpzZ3yfiPesShmkNx66bo1AYj8VcmdJw/BBHB050Zj303Yb/wm5mvAwXKjtlQwzCdkCdX+5402uydNZLICOp4E4D8MElAkMJkSAvvY8Q7l6VyWrFK73NizhJc5WdxP07GoEdKSjFDXh87nwem3gX8mTgRruroBzE94AJIHpV56uBgDMbkYtmhRhrGWknT+UUwxneTHO3/zeqpaau2gLrXfogGojBOc7L9hAUX0LG8Oj0LMQC1PamxCkdOdQYAdrYli+cva424A8EniF6Pj5N+fQT5S1KIyV28ZCqhYAmMWRc5fJlEzWKA1DoWSbo0XGqhKn/u9p+YMHybb4GrXkuAuYZxpubdA/IL74BWo6VhCztSvLtG/RqSBsSfxZG7yQw56SKz8M0dfpy0S6XcNuAWJE6z7sqQ1W19INBC0ehQ6nPrpAPg5+T5U8FKPnY/uWjMr0q+5e4TO2P7xNelWZZbepJ9wEFGkbRwwHsJRfchK9q377c4fyI+ejbxLL1xUWe5QkV834i5OdDtuW+alyA
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The ACPI general PM domain and the LPSS PM domain do not expect their
mid-layer runtime PM callbacks to be invoked at any point during
system-wide suspend and resume, so make acpi_subsys_prepare() set
power.strict_midlayer for the given device to express that expectation
and make acpi_subsys_complete() clear it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Set and clear the new flag in "prepare" and "complete" instead of
     "attach" and "detach", respectively, to (1) cover the LPSS PM domain as
     well as the general ACPI PM domain and (2) allow pm_runtime_force_suspend()
     invoked from driver remove callbacks to work.
   * Update subject and changelog.

---
 drivers/acpi/device_pm.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/acpi/device_pm.c
+++ b/drivers/acpi/device_pm.c
@@ -1119,6 +1119,8 @@
 {
 	struct acpi_device *adev = ACPI_COMPANION(dev);
 
+	dev_pm_set_strict_midlayer(dev, true);
+
 	if (dev->driver && dev->driver->pm && dev->driver->pm->prepare) {
 		int ret = dev->driver->pm->prepare(dev);
 
@@ -1147,6 +1149,8 @@
 	 */
 	if (pm_runtime_suspended(dev) && pm_resume_via_firmware())
 		pm_request_resume(dev);
+
+	dev_pm_set_strict_midlayer(dev, false);
 }
 EXPORT_SYMBOL_GPL(acpi_subsys_complete);
 




