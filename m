Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B7A07E561E
	for <lists+linux-pci@lfdr.de>; Wed,  8 Nov 2023 13:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231696AbjKHMUr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Nov 2023 07:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbjKHMUq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Nov 2023 07:20:46 -0500
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2C019A5;
        Wed,  8 Nov 2023 04:20:44 -0800 (PST)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 6D9283F6DC;
        Wed,  8 Nov 2023 12:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1699446043;
        bh=E9tPQVwzEhlooRe4K4Q7wJl4JNG7qDs+SM/Us4/qStU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=j6+GfkbJEKd30I/ExzPH+erSfujCAlTYCzF5l1oJIE7vbNa2ZxRpjNrHGnV4PFapP
         v+tRR0AOcsUQqm5PmHMKvOkvTobTqQs+gfVdg+ab2GA6OmqWWMe4r5vY7b2KRYx+V7
         w6n4lcUaftoWYhdb0QGWJxgoZHxbNO/T7szw4BVcOBgakNmT9CIERutKOXCg6Ju6nA
         wl/XfL++SlUflfDR2K7NI+w9FJ3k5dOEXIY7Zf1/XRvh7Abj182fjN6QP5aycKgpDA
         cIjQuiuLaGv+NAZNT9BWoUdWsya1jFDzy+dQKzlTez5ui28G8zNOWaRzJXDLFAoUuh
         X6cMt063Cx1aQ==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     srinivas.pandruvada@linux.intel.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com
Cc:     linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jian Hui Lee <jianhui.lee@canonical.com>,
        Even Xu <even.xu@intel.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] HID: intel-ish-hid: ipc: Rework EHL OOB wakeup
Date:   Wed,  8 Nov 2023 14:19:39 +0200
Message-Id: <20231108121940.288005-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since PCI core and ACPI core already handles PCI PME wake and GPE wake
when the device has wakeup capability, use device_init_wakeup() to let
them do the wakeup setting work.

Also add a shutdown callback which uses pci_prepare_to_sleep() to let
PCI and ACPI set OOB wakeup for S5.

Cc: Jian Hui Lee <jianhui.lee@canonical.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 Rebase on ("HID: intel-ish-hid: ipc: Disable and reenable ACPI GPE bit")

 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 67 ++++++-------------------
 1 file changed, 15 insertions(+), 52 deletions(-)

diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index 710fda5f19e1..65e7eeb2fa64 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -119,50 +119,6 @@ static inline bool ish_should_leave_d0i3(struct pci_dev *pdev)
 	return !pm_resume_via_firmware() || pdev->device == CHV_DEVICE_ID;
 }
 
-static int enable_gpe(struct device *dev)
-{
-#ifdef CONFIG_ACPI
-	acpi_status acpi_sts;
-	struct acpi_device *adev;
-	struct acpi_device_wakeup *wakeup;
-
-	adev = ACPI_COMPANION(dev);
-	if (!adev) {
-		dev_err(dev, "get acpi handle failed\n");
-		return -ENODEV;
-	}
-	wakeup = &adev->wakeup;
-
-	/*
-	 * Call acpi_disable_gpe(), so that reference count
-	 * gpe_event_info->runtime_count doesn't overflow.
-	 * When gpe_event_info->runtime_count = 0, the call
-	 * to acpi_disable_gpe() simply return.
-	 */
-	acpi_disable_gpe(wakeup->gpe_device, wakeup->gpe_number);
-
-	acpi_sts = acpi_enable_gpe(wakeup->gpe_device, wakeup->gpe_number);
-	if (ACPI_FAILURE(acpi_sts)) {
-		dev_err(dev, "enable ose_gpe failed\n");
-		return -EIO;
-	}
-
-	return 0;
-#else
-	return -ENODEV;
-#endif
-}
-
-static void enable_pme_wake(struct pci_dev *pdev)
-{
-	if ((pci_pme_capable(pdev, PCI_D0) ||
-	     pci_pme_capable(pdev, PCI_D3hot) ||
-	     pci_pme_capable(pdev, PCI_D3cold)) && !enable_gpe(&pdev->dev)) {
-		pci_pme_active(pdev, true);
-		dev_dbg(&pdev->dev, "ish ipc driver pme wake enabled\n");
-	}
-}
-
 /**
  * ish_probe() - PCI driver probe callback
  * @pdev:	pci device
@@ -233,7 +189,7 @@ static int ish_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	/* Enable PME for EHL */
 	if (pdev->device == EHL_Ax_DEVICE_ID)
-		enable_pme_wake(pdev);
+		device_init_wakeup(dev, true);
 
 	ret = ish_init(ishtp);
 	if (ret)
@@ -256,6 +212,19 @@ static void ish_remove(struct pci_dev *pdev)
 	ish_device_disable(ishtp_dev);
 }
 
+
+/**
+ * ish_shutdown() - PCI driver shutdown callback
+ * @pdev:	pci device
+ *
+ * This function sets up wakeup for S5
+ */
+static void ish_shutdown(struct pci_dev *pdev)
+{
+	if (pdev->device == EHL_Ax_DEVICE_ID)
+		pci_prepare_to_sleep(pdev);
+}
+
 static struct device __maybe_unused *ish_resume_device;
 
 /* 50ms to get resume response */
@@ -378,13 +347,6 @@ static int __maybe_unused ish_resume(struct device *device)
 	struct pci_dev *pdev = to_pci_dev(device);
 	struct ishtp_device *dev = pci_get_drvdata(pdev);
 
-	/* add this to finish power flow for EHL */
-	if (dev->pdev->device == EHL_Ax_DEVICE_ID) {
-		pci_set_power_state(pdev, PCI_D0);
-		enable_pme_wake(pdev);
-		dev_dbg(dev->devc, "set power state to D0 for ehl\n");
-	}
-
 	ish_resume_device = device;
 	dev->resume_flag = 1;
 
@@ -400,6 +362,7 @@ static struct pci_driver ish_driver = {
 	.id_table = ish_pci_tbl,
 	.probe = ish_probe,
 	.remove = ish_remove,
+	.shutdown = ish_shutdown,
 	.driver.pm = &ish_pm_ops,
 };
 
-- 
2.34.1

