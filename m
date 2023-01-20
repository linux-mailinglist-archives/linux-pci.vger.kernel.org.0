Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F62F675099
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 10:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbjATJT2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Jan 2023 04:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbjATJT1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 20 Jan 2023 04:19:27 -0500
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8ACF6A327
        for <linux-pci@vger.kernel.org>; Fri, 20 Jan 2023 01:19:16 -0800 (PST)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
         client-signature RSA-PSS (4096 bits) client-digest SHA256)
        (Client CN "*.hostsharing.net", Issuer "RapidSSL Global TLS RSA4096 SHA256 2022 CA1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 0A13E300160EC;
        Fri, 20 Jan 2023 10:19:13 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id F20C71D7C40; Fri, 20 Jan 2023 10:19:12 +0100 (CET)
Message-Id: <3dc88ea82bdc0e37d9000e413d5ebce481cbd629.1674205689.git.lukas@wunner.de>
From:   Lukas Wunner <lukas@wunner.de>
Date:   Fri, 20 Jan 2023 10:19:02 +0100
Subject: [PATCH] PCI: hotplug: Allow marking devices as disconnected during
 bind/unbind
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Anatoli Antonovitch <anatoli.antonovitch@amd.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        linux-pci@vger.kernel.org
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On surprise removal, pciehp_unconfigure_device() and acpiphp's
trim_stale_devices() call pci_dev_set_disconnected() to mark removed
devices as permanently offline.  Thereby, the PCI core and drivers know
to skip device accesses.

However pci_dev_set_disconnected() takes the device_lock and thus waits
for a concurrent driver bind or unbind to complete.  As a result, the
driver's ->probe and ->remove hooks have no chance to learn that the
device is gone.

That doesn't make any sense, so drop the device_lock and instead use
atomic xchg() and cmpxchg() operations to update the device state.

As a byproduct, an AB-BA deadlock reported by Anatoli is fixed which
occurs on surprise removal with AER concurrently performing a bus reset.

AER bus reset:

  INFO: task irq/26-aerdrv:95 blocked for more than 120 seconds.
  Tainted: G        W          6.2.0-rc3-custom-norework-jan11+
  schedule
  rwsem_down_write_slowpath
  down_write_nested
  pciehp_reset_slot                      # acquires reset_lock
  pci_reset_hotplug_slot
  pci_slot_reset                         # acquires device_lock
  pci_bus_error_reset
  aer_root_reset
  pcie_do_recovery
  aer_process_err_devices
  aer_isr

pciehp surprise removal:

  INFO: task irq/26-pciehp:96 blocked for more than 120 seconds.
  Tainted: G        W          6.2.0-rc3-custom-norework-jan11+
  schedule_preempt_disabled
  __mutex_lock
  mutex_lock_nested
  pci_dev_set_disconnected               # acquires device_lock
  pci_walk_bus
  pciehp_unconfigure_device
  pciehp_disable_slot
  pciehp_handle_presence_or_link_change
  pciehp_ist                             # acquires reset_lock

Fixes: a6bd101b8f84 ("PCI: Unify device inaccessible")
Link: https://bugzilla.kernel.org/show_bug.cgi?id=215590
Reported-by: Anatoli Antonovitch <anatoli.antonovitch@amd.com>
Signed-off-by: Lukas Wunner <lukas@wunner.de>
Cc: stable@vger.kernel.org # v4.20+
Cc: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pci.h | 43 +++++++++++++------------------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9ed3b55..5d5a44a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -310,53 +310,36 @@ struct pci_sriov {
  * @dev: PCI device to set new error_state
  * @new: the state we want dev to be in
  *
- * Must be called with device_lock held.
+ * If the device is experiencing perm_failure, it has to remain in that state.
+ * Any other transition is allowed.
  *
  * Returns true if state has been changed to the requested state.
  */
 static inline bool pci_dev_set_io_state(struct pci_dev *dev,
 					pci_channel_state_t new)
 {
-	bool changed = false;
+	pci_channel_state_t old;
 
-	device_lock_assert(&dev->dev);
 	switch (new) {
 	case pci_channel_io_perm_failure:
-		switch (dev->error_state) {
-		case pci_channel_io_frozen:
-		case pci_channel_io_normal:
-		case pci_channel_io_perm_failure:
-			changed = true;
-			break;
-		}
-		break;
+		xchg(&dev->error_state, pci_channel_io_perm_failure);
+		return true;
 	case pci_channel_io_frozen:
-		switch (dev->error_state) {
-		case pci_channel_io_frozen:
-		case pci_channel_io_normal:
-			changed = true;
-			break;
-		}
-		break;
+		old = cmpxchg(&dev->error_state, pci_channel_io_normal,
+			      pci_channel_io_frozen);
+		return old != pci_channel_io_perm_failure;
 	case pci_channel_io_normal:
-		switch (dev->error_state) {
-		case pci_channel_io_frozen:
-		case pci_channel_io_normal:
-			changed = true;
-			break;
-		}
-		break;
+		old = cmpxchg(&dev->error_state, pci_channel_io_frozen,
+			      pci_channel_io_normal);
+		return old != pci_channel_io_perm_failure;
+	default:
+		return false;
 	}
-	if (changed)
-		dev->error_state = new;
-	return changed;
 }
 
 static inline int pci_dev_set_disconnected(struct pci_dev *dev, void *unused)
 {
-	device_lock(&dev->dev);
 	pci_dev_set_io_state(dev, pci_channel_io_perm_failure);
-	device_unlock(&dev->dev);
 
 	return 0;
 }
-- 
2.39.1

