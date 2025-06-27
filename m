Return-Path: <linux-pci+bounces-30957-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9A1AEBFD0
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 21:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE59D7A6286
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 19:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E049217F2E;
	Fri, 27 Jun 2025 19:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="sYijwRMe"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D04520E003;
	Fri, 27 Jun 2025 19:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052584; cv=none; b=AeDHiB5XvzhpCUe/pXg2+pjXMolFXfBuy3PVfpKc6NM0OauchhgjIfU0lRx71BbEu9YyLzyUF9Bv8zQH8aA90dFma7KgcYZ8ROGdzLBIqd/rdfevIF99Ls5wadHeI6AsfCE2qMgO1vvvLomITm2gUSn+1yLIPnEU1TxhpwH5iWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052584; c=relaxed/simple;
	bh=Ef3nKq8yXm7NJvK8HMrAcHGCy5W6AuZJVdvGFiNlhCI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CylXUXFQI+5o/8NbvXS7+oA5TuMZmPJ48Oro3SPuOkn20zgRgTIuJlZMOG/7+DQ1oWWSe6cHrilt/O2DsSJm7dBWlbK/w8gn6MbQkY5WuOPLapiylMMrgVAbMR1c+0RpT+3fOVM3HdaczcZ45oYBhDTNjSj5pvRy8kDikQQ8bks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=sYijwRMe; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 6FB3A66DE4B;
	Fri, 27 Jun 2025 21:29:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1751052574;
	bh=Ef3nKq8yXm7NJvK8HMrAcHGCy5W6AuZJVdvGFiNlhCI=;
	h=From:Subject:Date;
	b=sYijwRMeyirikDRT1hiErZDTiYFz34BLaiCtngQYyKvDKV86Ku5UzAnyZTzJht5Vt
	 NlG9NIhoMFxTTU3wb9xS9hjXdiy6PIP2oEJbSXjOpDM0aiBjkrGPe4ML5ZF35769T7
	 IluWIJ5bd9/75aLQeJSV4L6oS9Ig6LCDOcb70da8FeIgZkB4kFRfx+3dU0DayFXaPt
	 XX7iGbD9lhVMnuXHoPTQI16tvZ4tS1gsKOvCILSIIw2xcjfiFIl7J7TCS5PxQo0K/m
	 sl1/7u+/JZFCwgpPiyF3NvAx/eIItT4E+kgW1RN7FCsifvq0KvbfEjw2Kgd/nun9zH
	 lUBo9b3WwHgnQ==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject:
 [PATCH v3 8/9] ACPI: PM: Set/clear power.strict_midlayer in prepare/complete
Date: Fri, 27 Jun 2025 21:25:22 +0200
Message-ID: <4463062.ejJDZkT8p0@rjwysocki.net>
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
X-VADE-SPAMCAUSE: dmFkZTGrSjjgwBeoPV1BTemn5ImVCZpPTZb07vPRCPpCLNITJNQNwAJrBW+NvQ9gHfopUGw7eKCZUx2JvTkH7ndztXO95C/5NZYx0U0uzSGwSElzY3a0yFW5y/ST6sLyUL+pkZNb6zBf5QQDeWSHMTwFL5SzhnW4lYOV2aXUoJnPKm0KcXRLQpgIKgvtcuh9kc8szEcWaDKkWT6ZvZMLezK4NKUrQ0LRPHVUG/J8XldG2aWmsAAgiz8DIA4tSCjGi3syq1aAO8pJ5+EOuYaRvLcxgtvWWEpF/MWy84RxjOnkuHVdyEMV6Ug0G9LNrdrQ+TwE0ATvvO2S6WiA1+7Yw5g2H305VB1eP2LPOTUP350XhryqJG4RxrShMNdS+hjEtMP/gkgKCwmstC3bmCV2iisv5c3mVd3JaV/HncSScFmO9rsaL+Izy83Uyv9VPGgvYotXIf67jIMym8Q561c2mmhjSybzGLNoD8dfvmWmmd40Bv4jKZDniuOHumeORZk7tIK3YDqFdgryQCH7RgiNy8nzy9l476jK+yu1OGTBqgAk6gz8m19pqAzz/IfKeaXyX3vuhOfYkUbNsEHeTaAf3avNidp/YuKZZZg6JOpH4l9RVCBdrVbUKPMD7I/lUJBBns5PDy7/Lvrw/6WxmA24Q+6WLQdN3Q4UQqf7KiyZbs8303+iqA
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The ACPI general PM domain and the LPSS PM domain do not expect their
mid-layer runtime PM suspend callbacks to be invoked at all during
system-wide suspend and resume and they do not expect their runtime
resume callbacks to be invoked at any point when runtime PM is disabled
for the given device during system suspend and resume, so make
acpi_subsys_prepare() set power.strict_midlayer for the given device
to express that expectation and make acpi_subsys_complete() clear it.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v2 -> v3: Update the changelog to be more precise.

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
 




