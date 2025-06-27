Return-Path: <linux-pci+bounces-30956-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90616AEBFCA
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 21:29:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7799F1C4689C
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 19:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003D8211460;
	Fri, 27 Jun 2025 19:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b="chxIXNcN"
X-Original-To: linux-pci@vger.kernel.org
Received: from cloudserver094114.home.pl (cloudserver094114.home.pl [79.96.170.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4F220C03E;
	Fri, 27 Jun 2025 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.96.170.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751052583; cv=none; b=bh5FCqSww+sihfc+gUQgAUpGpwLHjSL/9YQ3thPBQK0ogylUcVBgkWWPumDZs/v64vV+11M2NM8nMQg3WExIyPGmI5qp571LsWMncXk/wQteqa/Dm5ZqbMBWCP1RTBHeX04oAg2KRpURCowA85LvmHpkfbp6jGlXHuW3f5TQy8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751052583; c=relaxed/simple;
	bh=kY9pRbBGXyFt52NNCZFJytbQXz3mokYgEYHz3UNvujM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mAcq8KCUHi/Yft9qqpdu41sy/F/KI/DgVGvcARwjI1rCLmhJDdk0xtndOr69Vp2OAZq1oFBKPX4f7JJmvSa6wilq3A8j8iPNiLWdhAjrlfRgx+IfeEIZoYC51SlMCnz5NWvOLTkt77LahrrNbHE2HTzZlxVcNq/q0JL1QrSEi/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net; spf=pass smtp.mailfrom=rjwysocki.net; dkim=pass (2048-bit key) header.d=rjwysocki.net header.i=@rjwysocki.net header.b=chxIXNcN; arc=none smtp.client-ip=79.96.170.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rjwysocki.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rjwysocki.net
Received: from kreacher.localnet (unknown [5.63.189.50])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by cloudserver094114.home.pl (Postfix) with ESMTPSA id 2E32866DE29;
	Fri, 27 Jun 2025 21:29:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rjwysocki.net;
	s=dkim; t=1751052573;
	bh=kY9pRbBGXyFt52NNCZFJytbQXz3mokYgEYHz3UNvujM=;
	h=From:Subject:Date;
	b=chxIXNcNZweVjZDYMbATeSQQTOp1C6QSshPZptPOHzlZGHjAzY1XSkiQEBFM4jBos
	 WMIB42fmWiYWKEdiUnqjTlFp6vWCN6/PGWkER0kxElUSF6IvDXxVdCTh0dqTyksPel
	 9f7JGBZgy8xSCLFnKyGZRqIk6U8A28K7y0+I0rDih0q7ZYZxYPR9MJJObxJUh+sD7U
	 oEUWk7YgzjkfHQCwkUVcwdsdSzOQUos5dzPDtXbZBpP6VGSMUqwHiVVF85yDpXT775
	 59U2Es4hoaVyAupPRyHLOAe6bz3fEa1L4rvhTTueBYOI8QDl8NA8FCu/ooi/08scp9
	 Jf1LLtdYYJyFw==
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Subject: [PATCH v3 9/9] PCI/PM: Set power.strict_midlayer in pci_pm_init()
Date: Fri, 27 Jun 2025 21:29:16 +0200
Message-ID: <1925097.atdPhlSkOF@rjwysocki.net>
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
X-VADE-SPAMCAUSE: dmFkZTGRmHXmKxezHgHnenmfNBRxuxS5icg2UpqKuDHPuOJctsue4XUZZKRq+I3k43I7hGGWSVpCO2RMCqeSIExCba3+jEV4RHupFvblFZsJZEOU7KXO+apCLF7BrBbkfQgmVa3qfzu3l1CWWL3sTxIklFfy+SfQ3LU6S7g6b40rVIMKuT9PeVQ7vN73+o7FRm9i7DCswR8ZH2qLd5FKGiCRHAdTIZCJcdKbCzlNjgCJP7j9sC140zaF4s84pWcODIanBShuw8pSTZor6gJPE1mce69YOKvKUPMQL94xAmz+P6IQ2jB2WOr72U/SFpTenbJ1S72cePd03wWASkAhj+PgKNE/kKaG855T+EyLZWoLbf4OYEM2kSOJ7GiNom/yotNU5itFRBu9ztylBE6t5JhKLjiXKijes9NEspnrfifqNeEp1Iti6cizTPhSednvuVLBvTgy22/fO5Hdwix0ZC67F4Is0PRCrSBuuF7KbGU4LIhBJv8/XKtYrzsYSiRbLVUBf0HTlsKeaxYAbcVoxU997JTOkabLjeefj/4PDUXPX7gfPxWiQoKCdoQ2q3YeD5r9SIpwTX4Q1yW1rAk3Ubk30v+V+PvNb2Z1gR5NzsHGaG4RHE0g6QLLpAkF++EbO6hrRRakssNrfSdFb0IgXU7vRUp7COxhzJFOT/Q8mdjKYmP8ow
X-DCC--Metrics: v370.home.net.pl 1024; Body=7 Fuz1=7 Fuz2=7

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The PCI bus type does not expect its runtime PM suspend callback
function, pci_pm_runtime_suspend(), to be invoked at all during system-
wide suspend and resume, and it does not expect its runtime resume
callback function, pci_pm_runtime_resume(), to be invoked at any point
when runtime PM is disabled for the given device during system-wide
suspend and resume, so make it express that expectation by setting
power.strict_midlayer for all PCI devices in pci_pm_prepare() and
clear it in pci_pm_complete().

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---

v2 -> v3:
   * Update subject prefix (Bjorn).
   * Update the changelog to be more precise.
   * Add Acked-by from Bjorn.

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




