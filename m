Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A25A7A4A4B
	for <lists+linux-pci@lfdr.de>; Mon, 18 Sep 2023 14:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239775AbjIRM6f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Sep 2023 08:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242026AbjIRM6Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 18 Sep 2023 08:58:25 -0400
X-Greylist: delayed 552 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 18 Sep 2023 05:57:45 PDT
Received: from mailout1.hostsharing.net (mailout1.hostsharing.net [83.223.95.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C83CA131
        for <linux-pci@vger.kernel.org>; Mon, 18 Sep 2023 05:57:45 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by mailout1.hostsharing.net (Postfix) with ESMTPS id B21EA101920D6;
        Mon, 18 Sep 2023 14:48:31 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by h08.hostsharing.net (Postfix) with ESMTPSA id 92ED06000E21;
        Mon, 18 Sep 2023 14:48:31 +0200 (CEST)
X-Mailbox-Line: From b8a7f4af2b73f6b506ad8ddee59d747cbf834606 Mon Sep 17 00:00:00 2001
Message-Id: <b8a7f4af2b73f6b506ad8ddee59d747cbf834606.1695025365.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Mon, 18 Sep 2023 14:48:01 +0200
Subject: [PATCH] PCI/sysfs: Protect driver's D3cold preference from user space
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        linux-pci@vger.kernel.org,
        Mario Limonciello <mario.limonciello@amd.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

struct pci_dev contains two flags which govern whether the device may
suspend to D3cold:

* no_d3cold provides an opt-out for drivers (e.g. if a device is known
  to not wake from D3cold)

* d3cold_allowed provides an opt-out for user space (default is true,
  user space may set to false)

Since commit 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend"),
the user space setting overwrites the driver setting.  Essentially user
space is trusted to know better than the driver whether D3cold is
working.

That feels unsafe and wrong.  Assume that the change was introduced
inadvertently and do not overwrite no_d3cold when d3cold_allowed is
modified.  Instead, consider d3cold_allowed in addition to no_d3cold
when choosing a suspend state for the device.

That way, user space may opt out of D3cold if the driver hasn't, but it
may no longer force an opt in if the driver has opted out.

Fixes: 9d26d3a8f1b0 ("PCI: Put PCIe ports into D3 during suspend")
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v4.8+
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pci-acpi.c  | 2 +-
 drivers/pci/pci-sysfs.c | 5 +----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 7aa1c20..2f5eddf 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -911,7 +911,7 @@ pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
 {
 	int acpi_state, d_max;
 
-	if (pdev->no_d3cold)
+	if (pdev->no_d3cold || !pdev->d3cold_allowed)
 		d_max = ACPI_STATE_D3_HOT;
 	else
 		d_max = ACPI_STATE_D3_COLD;
diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index ba38fc4..e18ccd2 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -530,10 +530,7 @@ static ssize_t d3cold_allowed_store(struct device *dev,
 		return -EINVAL;
 
 	pdev->d3cold_allowed = !!val;
-	if (pdev->d3cold_allowed)
-		pci_d3cold_enable(pdev);
-	else
-		pci_d3cold_disable(pdev);
+	pci_bridge_d3_update(pdev);
 
 	pm_runtime_resume(dev);
 
-- 
2.39.2

