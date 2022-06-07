Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D17CD53F4B8
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jun 2022 05:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiFGDwI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jun 2022 23:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiFGDwF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jun 2022 23:52:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D495BC0453;
        Mon,  6 Jun 2022 20:52:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B1FB6147E;
        Tue,  7 Jun 2022 03:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F965C385A5;
        Tue,  7 Jun 2022 03:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654573923;
        bh=yNrQt95Y8ZC4NDramYhCk2RGnaCtu+WEz2UClGTdMnA=;
        h=From:To:Cc:Subject:Date:From;
        b=u1fhAAeeNx8MwQn3pZ6MpAS4ae3vrtTpEGavsJdTngEvvlIdBCupTtKUgx199T5DY
         ShqKQL/pt2v04wtjL5WrnDX8L7LrxoKSPk1mQoML0R7VSaRJ2Ci0LDnmZXr1AkPoUT
         Z5Ri81vnwbnaaprIGJKOJ0xnYjyKTd2TDnrNvsezADVoeDAwPnB3aFiQ5j6hLv2tEk
         Pb7cleJZND+Ha1SKG5y9Jj8890esXQMr4mWcoDpv2pI7ugOenw5jwyV+qY/S2ZoyH5
         tIcgDXdi7kJ6mN2nyO8+vg6tibRlHUh9DCd1TDkA8imy8fXk9+PEcs1/uFhQq0U6US
         3T5epRgYyj1WA==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH] PM / wakeup: Unify device_init_wakeup() for PM_SLEEP and !PM_SLEEP
Date:   Mon,  6 Jun 2022 22:51:58 -0500
Message-Id: <20220607035158.308111-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Previously the CONFIG_PM_SLEEP and !CONFIG_PM_SLEEP device_init_wakeup()
implementations differed in confusing ways:

  - The PM_SLEEP version checked for a NULL device pointer and returned
    -EINVAL, while the !PM_SLEEP version did not and would simply
    dereference a NULL pointer.

  - When called with "false", the !PM_SLEEP version cleared "capable" and
    "enable" in the opposite order of the PM_SLEEP version.  That was
    harmless because for !PM_SLEEP they're simple assignments, but it's
    unnecessary confusion.

Use a simplified version of the PM_SLEEP implementation for both cases.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/base/power/wakeup.c | 30 ------------------------------
 include/linux/pm_wakeup.h   | 31 +++++++++++++++++++++++--------
 2 files changed, 23 insertions(+), 38 deletions(-)

diff --git a/drivers/base/power/wakeup.c b/drivers/base/power/wakeup.c
index 11a4ffe91367..e3befa2c1b66 100644
--- a/drivers/base/power/wakeup.c
+++ b/drivers/base/power/wakeup.c
@@ -500,36 +500,6 @@ void device_set_wakeup_capable(struct device *dev, bool capable)
 }
 EXPORT_SYMBOL_GPL(device_set_wakeup_capable);
 
-/**
- * device_init_wakeup - Device wakeup initialization.
- * @dev: Device to handle.
- * @enable: Whether or not to enable @dev as a wakeup device.
- *
- * By default, most devices should leave wakeup disabled.  The exceptions are
- * devices that everyone expects to be wakeup sources: keyboards, power buttons,
- * possibly network interfaces, etc.  Also, devices that don't generate their
- * own wakeup requests but merely forward requests from one bus to another
- * (like PCI bridges) should have wakeup enabled by default.
- */
-int device_init_wakeup(struct device *dev, bool enable)
-{
-	int ret = 0;
-
-	if (!dev)
-		return -EINVAL;
-
-	if (enable) {
-		device_set_wakeup_capable(dev, true);
-		ret = device_wakeup_enable(dev);
-	} else {
-		device_wakeup_disable(dev);
-		device_set_wakeup_capable(dev, false);
-	}
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(device_init_wakeup);
-
 /**
  * device_set_wakeup_enable - Enable or disable a device to wake up the system.
  * @dev: Device to handle.
diff --git a/include/linux/pm_wakeup.h b/include/linux/pm_wakeup.h
index 196a157456aa..77f4849e3418 100644
--- a/include/linux/pm_wakeup.h
+++ b/include/linux/pm_wakeup.h
@@ -109,7 +109,6 @@ extern struct wakeup_source *wakeup_sources_walk_next(struct wakeup_source *ws);
 extern int device_wakeup_enable(struct device *dev);
 extern int device_wakeup_disable(struct device *dev);
 extern void device_set_wakeup_capable(struct device *dev, bool capable);
-extern int device_init_wakeup(struct device *dev, bool val);
 extern int device_set_wakeup_enable(struct device *dev, bool enable);
 extern void __pm_stay_awake(struct wakeup_source *ws);
 extern void pm_stay_awake(struct device *dev);
@@ -167,13 +166,6 @@ static inline int device_set_wakeup_enable(struct device *dev, bool enable)
 	return 0;
 }
 
-static inline int device_init_wakeup(struct device *dev, bool val)
-{
-	device_set_wakeup_capable(dev, val);
-	device_set_wakeup_enable(dev, val);
-	return 0;
-}
-
 static inline bool device_may_wakeup(struct device *dev)
 {
 	return dev->power.can_wakeup && dev->power.should_wakeup;
@@ -217,4 +209,27 @@ static inline void pm_wakeup_hard_event(struct device *dev)
 	return pm_wakeup_dev_event(dev, 0, true);
 }
 
+/**
+ * device_init_wakeup - Device wakeup initialization.
+ * @dev: Device to handle.
+ * @enable: Whether or not to enable @dev as a wakeup device.
+ *
+ * By default, most devices should leave wakeup disabled.  The exceptions are
+ * devices that everyone expects to be wakeup sources: keyboards, power buttons,
+ * possibly network interfaces, etc.  Also, devices that don't generate their
+ * own wakeup requests but merely forward requests from one bus to another
+ * (like PCI bridges) should have wakeup enabled by default.
+ */
+static inline int device_init_wakeup(struct device *dev, bool enable)
+{
+	if (enable) {
+		device_set_wakeup_capable(dev, true);
+		return device_wakeup_enable(dev);
+	} else {
+		device_wakeup_disable(dev);
+		device_set_wakeup_capable(dev, false);
+		return 0;
+	}
+}
+
 #endif /* _LINUX_PM_WAKEUP_H */
-- 
2.25.1

