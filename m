Return-Path: <linux-pci+bounces-30800-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B82AEA501
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 20:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1EC3D562522
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 18:15:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B827221F11;
	Thu, 26 Jun 2025 18:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="hpor0GUh"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B51C194AD5;
	Thu, 26 Jun 2025 18:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750961747; cv=none; b=nFBhysiYFVQhOaOXBBdQb7VPAg1hL/CB5n83VsP4WkgiRE7qJWmRWCpBnVtVrygPUesmdb75yetF8vpvdAqoKCVXAoF2/3KCE8AwE3gS1aZt/X7WGjAu9p4idE9lMuCUtTXbPZctpW8CtYWvYIAatancY0IUgcz3ZN8hSB2VJIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750961747; c=relaxed/simple;
	bh=r3WpNTdcTTb9WS1CkoWJWXyTbx4bCpMGmoYafXc0yDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=APPJAie98fi2/0f4uEKjp19ZbYCA3rRBycnJwAR9U34RSPI9bBU7Qf6ix9o2+WN4y5rP27mhb8Nxj0X2UwZNORQ3+/xSo0eRmYKil4X12aVDMrBwezKGxwU0gHWyur22L87i9uIdwSomWFOYZTEFcR0XZIOECtP5NPsOc1v/FYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=hpor0GUh; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id C6FE866E981;
	Thu, 26 Jun 2025 20:15:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1750961742;
	bh=r3WpNTdcTTb9WS1CkoWJWXyTbx4bCpMGmoYafXc0yDw=;
	h=From:Subject:Date;
	b=hpor0GUhJU2UpT+mWXAZ1iWAve1fG94EubYMxOT46UKLSs8yOOAQE+vzOoNXHv9Ki
	 /Djl4XicABpoRuIosEIM35P7DGWPNbLL0BXPw37w+GoKUmGQwf7FVbZKRg96bLOner
	 9pRIXiwFKZBBENi7ijqeWE986edmvmkavYqdPNkDDp6737RoBMnkvPubOyUOPvwbgG
	 PMJUq+aSNWYAqJrSjMF1wB4Ns8Inb8p0rn0+vlq9dz1YXINaw+RQXrU3GHGK7H4aZ6
	 EBm7j8roAulQoxNlXxKExOP9pAW0whovm62YAjtjGId1v2UXnB7+QJoCMjHDjyCw0k
	 ktrza3gphBuoA==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v2 9/9] PCI: PM: Set power.strict_midlayer in pci_pm_init()
Date: Thu, 26 Jun 2025 20:15:05 +0200
Message-ID: <1952931.CQOukoFCf9@rjwysocki.net>
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
X-VADE-SPAMCAUSE: dmFkZTF716g97GLxl5r0PfOIWPAhDchnkSWDAqwBHc32sD+HpU8yKJB8xV8olL9lC0SzkWwWofqH3VgYdVRji5cIw9ZbUY7WKZiWjf3xKrF5n/kFXPdAEOzPBCDRv7/dwAHJIQ0XttMc6iSOqO8REJ6/sQbblDgpzZ3yfiPesShmkNx66bo1AYj8VcmdJw/BBHB050Zj303Yb/wm5mvAwXKjtlQwzCdkCdX+5402uydNZLICOp4E4D8MElAkMJkSAvvY8Q7l6VyWrFK73NizhJc5WdxP07GoEdKSjFDXh87nwem3gX8mTgRruroBzE94AJIHpV56uBgDMbkYtmhRhrGWknT+ZVaBlvUkIf98kXjOh7zf/rwGM6n5dCbEfhHGQsWrA3HHQ1Ms69CW6/9hCbQ4LW2sBpvzkT+ob09vZAir5OzBRnrYQvtEu6tWtZPptSh/D2v+ZmI4P9wfInsWJnlKaQO0HUEI0SdovPPVucY/QICxEMoh5P4LDjntqEKznBeXXVNU1cu0zOf8wFMoDcEy2PuFDCAn/NTalwQ426kcLJTYUZ8njOm8r/OoiFgnbiL+DlhmVUKLnpHEZvkLpyGdCqZW8JN/XGKgzIPTrDUGWeYja9pPzJBn53SlI7X1T4+Dmv5hGO+u1/B3JPLn/ScRy5A5hAd17B8W4SM3SBLM+9EJsw
X-DCC--Metrics: v370.home.net.pl 1024; Body=6 Fuz1=6 Fuz2=6

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The PCI bus type does not expect its runtime PM callbacks,
pci_pm_runtime_suspend() and pci_pm_runtime_resume(), to be invoked at
any point during system-wide suspend and resume, so make it express
that expectation by setting power.strict_midlayer for all PCI devices
in pci_pm_prepare() and clear it in pci_pm_complete().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

v1 -> v2:
   * Set and clear the new flag in "prepare" and "complete" to allow
     pm_runtime_force_suspend() invoked from driver remove callbacks to
     work.
   * Update subject and changelog.

---
 drivers/pci/pci-driver.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -708,6 +708,8 @@
 	struct pci_dev *pci_dev = to_pci_dev(dev);
 	const struct dev_pm_ops *pm = dev->driver ? dev->driver->pm : NULL;
 
+	dev_pm_set_strict_midlayer(dev, true);
+
 	if (pm && pm->prepare) {
 		int error = pm->prepare(dev);
 		if (error < 0)
@@ -749,6 +751,8 @@
 		if (pci_dev->current_state < pre_sleep_state)
 			pm_request_resume(dev);
 	}
+
+	dev_pm_set_strict_midlayer(dev, false);
 }
 
 #else /* !CONFIG_PM_SLEEP */




