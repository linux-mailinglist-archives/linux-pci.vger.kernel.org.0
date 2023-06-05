Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65A59722ECE
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jun 2023 20:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjFESf6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jun 2023 14:35:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjFESf5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jun 2023 14:35:57 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577D0D9;
        Mon,  5 Jun 2023 11:35:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=wwWxJXe5pQm4QqI2inojr71AUA3uHrvhwwB6tIvkbAY=;
        t=1685990155; x=1687199755; b=vMSJw61j6Bh6IqvojaxzY4mlzdqYZK0dibeB2zbz+cgxLH6
        Cm1urxgzbBLJyEl4zL4uNeEkwYkwQg6y5tYTSJBxSmcN4CKJr6ZADeL3QQgibgdB6vTOv03rT9xNC
        yieSXPjOML3zRbfGrUXUKJ13FcU28wivSl2kyOH12vcCOnK0yTN/Y2bTw3z3F5HuZjFfPr55DF2Zt
        X/LExVBoO3H2sSJznI1yFnlHW4ZEzaNkg8y5ICc0qlaJR5N+YLRn8abpVR6aYI+NK1FTXmmxtm0Zu
        k7mwUMzGJMFZpRNGiu14eCJtzYgM/7dQPW3/s4J19wamxaNpabkHhU9vROR3WStg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1q6F3W-00EaFL-2E;
        Mon, 05 Jun 2023 20:35:50 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     rafael@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH v2] PCI/PM: enable runtime PM later during device scanning
Date:   Mon,  5 Jun 2023 20:35:45 +0200
Message-Id: <20230605203519.bc4232207449.Idbaa55b93f780838af44ebccb84c36f60716df04@changeid>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230605121621.4259f1be6cd2.Idbaa55b93f780838af44ebccb84c36f60716df04@changeid>
References: <20230605121621.4259f1be6cd2.Idbaa55b93f780838af44ebccb84c36f60716df04@changeid>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

We found that that the following race is possible if userspace
enables runtime PM/auto-suspend immediately when a device shows
up in sysfs, if there's any call to pci_rescan_bus() during
normal system state (i.e. userspace is already active):

 - we rescan the PCI bus (*)
 - this creates the new PCI device including its sysfs
   representation
 - udev sees the new device, and the (OS-specific) scripting
   enables runtime PM by writing to power/control; this can
   happen _before_ the next step - this will runtime-suspend
   the device which saves the config space, including the BARs
   that weren't assigned yet
 - the bus rescan assigns resources to the devices and writes
   them to the config space of the device
   (but not the runtime-pm saved copy, course)
 - the driver binds and this disallows runtime PM, so the device
   is resumed, restoring the (incomplete!) config space
 - the device cannot work due to BARs not being configured

Fix this by allowing runtime PM only once the device has been
fully added. Also, with a warning, reject runtime PM on a not-
added device; this shouldn't happen anymore now.

Note that the comment that was there (that I'm replacing) was
indicating that pci_device_add() wouldn't be called at this
place yet, but in fact it's called much earlier during the whole
scan/probe process, which in part causes this problem, but it
doesn't seem possible to defer it until here either.

(*) In the case we encountered, this happened due to some reset
    of the iwlwifi device that the driver then needs to recover
    from by rescanning the bus since the device was reset and
    the system doesn't know about it yet.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
v2: use pm_runtime_get_noresume()/pm_runtime_put_noidle()
    instead as advised by Rafael
---
 drivers/pci/bus.c        | 8 ++++++--
 drivers/pci/pci-driver.c | 3 +++
 drivers/pci/pci.c        | 1 +
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 5bc81cc0a2de..e06ea5449be9 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -13,6 +13,7 @@
 #include <linux/ioport.h>
 #include <linux/proc_fs.h>
 #include <linux/slab.h>
+#include <linux/pm_runtime.h>
 
 #include "pci.h"
 
@@ -335,9 +336,12 @@ void pci_bus_add_device(struct pci_dev *dev)
 	int retval;
 
 	/*
-	 * Can not put in pci_device_add yet because resources
-	 * are not assigned yet for some devices.
+	 * Allow runtime PM only here, since otherwise we may
+	 * try to suspend a device that isn't fully configured
+	 * yet, which causes problems.
 	 */
+	pm_runtime_put_noidle(&dev->dev);
+
 	pcibios_bus_add_device(dev);
 	pci_fixup_device(pci_fixup_final, dev);
 	pci_create_sysfs_dev_files(dev);
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index ae9baf801681..8d82b4abb169 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1278,6 +1278,9 @@ static int pci_pm_runtime_suspend(struct device *dev)
 	pci_power_t prev = pci_dev->current_state;
 	int error;
 
+	if (WARN_ON(!pci_dev_is_added(pci_dev)))
+		return -EBUSY;
+
 	pci_suspend_ptm(pci_dev);
 
 	/*
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5ede93222bc1..808906ad14b9 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3139,6 +3139,7 @@ void pci_pm_init(struct pci_dev *dev)
 	u16 pmc;
 
 	pm_runtime_forbid(&dev->dev);
+	pm_runtime_get_noresume(&dev->dev);
 	pm_runtime_set_active(&dev->dev);
 	pm_runtime_enable(&dev->dev);
 	device_enable_async_suspend(&dev->dev);
-- 
2.40.1

