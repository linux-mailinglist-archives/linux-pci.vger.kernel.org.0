Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374E34614F6
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 13:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhK2M0T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 07:26:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20937 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237410AbhK2MYS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 07:24:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638188461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1WY9N/WdHw4EuhHdEEHxJlQmC0ZWlV74g+hiQSgIYe0=;
        b=V0XDkoRILfQXwgNu3Ewaz6myGTHpooj1ynrgEvIbT0FmQFjzNh+Ko6A/yOa2VJ4r/Jx8g+
        aoo2wsoo7h/hFOPBYNBLtIb6JOhMZx58dlDJJ64ULroTwKnd+X58qhCkPKC1s/l14sjDno
        8kd/NEQf8s2P3EERnSEfjVcs8nqhZ20=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-2-MqjPNu6YNamXw-61jY3VsA-1; Mon, 29 Nov 2021 07:19:47 -0500
X-MC-Unique: MqjPNu6YNamXw-61jY3VsA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 409C381CCB6;
        Mon, 29 Nov 2021 12:19:46 +0000 (UTC)
Received: from x1.localdomain (unknown [10.39.194.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A2AD0101E819;
        Mon, 29 Nov 2021 12:19:38 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>
Cc:     Hans de Goede <hdegoede@redhat.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH 2/2] PCI: pciehp: Use down_read/write_nested(reset_lock) to fix lockdep errors
Date:   Mon, 29 Nov 2021 13:19:34 +0100
Message-Id: <20211129121934.4963-2-hdegoede@redhat.com>
In-Reply-To: <20211129121934.4963-1-hdegoede@redhat.com>
References: <20211129121934.4963-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use down_read_nested() and down_write_nested() when taking the
ctrl->reset_lock rw-sem, passing the PCI-device depth in the hierarchy
as lock subclass parameter. This fixes the following false-positive lockdep
report when unplugging a Lenovo X1C8 from a Lenovo 2nd gen TB3 dock:

[   28.583853] pcieport 0000:06:01.0: pciehp: Slot(1): Link Down
[   28.583891] pcieport 0000:06:01.0: pciehp: Slot(1): Card not present
[   28.583995] pcieport 0000:09:04.0: can't change power state from D3cold to D0 (config space inaccessible)

[   28.584849] ============================================
[   28.584854] WARNING: possible recursive locking detected
[   28.584858] 5.16.0-rc2+ #621 Not tainted
[   28.584864] --------------------------------------------
[   28.584867] irq/124-pciehp/86 is trying to acquire lock:
[   28.584873] ffff8e5ac4299ef8 (&ctrl->reset_lock){.+.+}-{3:3}, at: pciehp_check_presence+0x23/0x80
[   28.584904]
               but task is already holding lock:
[   28.584908] ffff8e5ac4298af8 (&ctrl->reset_lock){.+.+}-{3:3}, at: pciehp_ist+0xf3/0x180
[   28.584929]
               other info that might help us debug this:
[   28.584933]  Possible unsafe locking scenario:

[   28.584936]        CPU0
[   28.584939]        ----
[   28.584942]   lock(&ctrl->reset_lock);
[   28.584949]   lock(&ctrl->reset_lock);
[   28.584955]
                *** DEADLOCK ***

[   28.584959]  May be due to missing lock nesting notation

[   28.584963] 3 locks held by irq/124-pciehp/86:
[   28.584970]  #0: ffff8e5ac4298af8 (&ctrl->reset_lock){.+.+}-{3:3}, at: pciehp_ist+0xf3/0x180
[   28.584991]  #1: ffffffffa3b024e8 (pci_rescan_remove_lock){+.+.}-{3:3}, at: pciehp_unconfigure_device+0x31/0x110
[   28.585012]  #2: ffff8e5ac1ee2248 (&dev->mutex){....}-{3:3}, at: device_release_driver+0x1c/0x40
[   28.585037]
               stack backtrace:
[   28.585042] CPU: 4 PID: 86 Comm: irq/124-pciehp Not tainted 5.16.0-rc2+ #621
[   28.585052] Hardware name: LENOVO 20U90SIT19/20U90SIT19, BIOS N2WET30W (1.20 ) 08/26/2021
[   28.585059] Call Trace:
[   28.585064]  <TASK>
[   28.585073]  dump_stack_lvl+0x59/0x73
[   28.585087]  __lock_acquire.cold+0xc5/0x2c6
[   28.585106]  ? find_held_lock+0x2b/0x80
[   28.585124]  lock_acquire+0xb5/0x2b0
[   28.585132]  ? pciehp_check_presence+0x23/0x80
[   28.585144]  ? lock_is_held_type+0xa8/0x120
[   28.585161]  down_read+0x3e/0x50
[   28.585172]  ? pciehp_check_presence+0x23/0x80
[   28.585183]  pciehp_check_presence+0x23/0x80
[   28.585194]  pciehp_runtime_resume+0x5c/0xa0
[   28.585206]  ? pci_msix_init+0x60/0x60
[   28.585214]  device_for_each_child+0x45/0x70
[   28.585227]  pcie_port_device_runtime_resume+0x20/0x30
[   28.585236]  pci_pm_runtime_resume+0xa7/0xc0
[   28.585246]  ? pci_pm_freeze_noirq+0x100/0x100
[   28.585257]  __rpm_callback+0x41/0x110
[   28.585271]  ? pci_pm_freeze_noirq+0x100/0x100
[   28.585281]  rpm_callback+0x59/0x70
[   28.585293]  rpm_resume+0x512/0x7b0
[   28.585309]  __pm_runtime_resume+0x4a/0x90
[   28.585322]  __device_release_driver+0x28/0x240
[   28.585338]  device_release_driver+0x26/0x40
[   28.585351]  pci_stop_bus_device+0x68/0x90
[   28.585363]  pci_stop_bus_device+0x2c/0x90
[   28.585373]  pci_stop_and_remove_bus_device+0xe/0x20
[   28.585384]  pciehp_unconfigure_device+0x6c/0x110
[   28.585396]  ? __pm_runtime_resume+0x58/0x90
[   28.585409]  pciehp_disable_slot+0x5b/0xe0
[   28.585421]  pciehp_handle_presence_or_link_change+0xc3/0x2f0
[   28.585436]  pciehp_ist+0x179/0x180
[   28.585449]  ? disable_irq_nosync+0x10/0x10
[   28.585460]  irq_thread_fn+0x1d/0x60
[   28.585470]  ? irq_thread+0x81/0x1a0
[   28.585480]  irq_thread+0xcb/0x1a0
[   28.585491]  ? irq_thread_fn+0x60/0x60
[   28.585502]  ? irq_thread_check_affinity+0xb0/0xb0
[   28.585514]  kthread+0x165/0x190
[   28.585522]  ? set_kthread_struct+0x40/0x40
[   28.585531]  ret_from_fork+0x1f/0x30
[   28.585554]  </TASK>
[   28.586512] xhci_hcd 0000:0a:00.0: remove, state 1
[   28.586538] usb usb4: USB disconnect, device number 1
[   28.586547] usb 4-2: USB disconnect, device number 2
[   28.586555] usb 4-2.1: USB disconnect, device number 3
[   28.586561] usb 4-2.1.2: USB disconnect, device number 5
[   28.587709] xhci_hcd 0000:0a:00.0: xHCI host controller not responding, assume dead
[   28.590021] usb 4-2.3: USB disconnect, device number 4
[   28.613814] xhci_hcd 0000:0a:00.0: WARN Can't disable streams for endpoint 0x1, streams are being disabled already
[   28.616865] xhci_hcd 0000:0a:00.0: USB bus 4 deregistered
[   28.617082] xhci_hcd 0000:0a:00.0: remove, state 1
[   28.617089] usb usb3: USB disconnect, device number 1
[   28.617092] usb 3-2: USB disconnect, device number 2
[   28.617094] usb 3-2.1: USB disconnect, device number 3
[   28.617096] usb 3-2.1.1: USB disconnect, device number 6
[   28.617098] usb 3-2.1.1.4: USB disconnect, device number 8
[   28.645354] usb 3-2.1.3: USB disconnect, device number 7
[   28.645357] usb 3-2.1.3.1: USB disconnect, device number 10
[   28.647489] usb 3-2.1.3.4: USB disconnect, device number 11
[   28.647494] usb 3-2.1.3.4.1: USB disconnect, device number 13
[   28.760411] usb 3-2.1.4: USB disconnect, device number 9
[   28.760414] usb 3-2.1.4.1: USB disconnect, device number 12
[   28.795513] usb 3-2.4: USB disconnect, device number 4
[   28.821464] usb 3-2.5: USB disconnect, device number 5
[   28.822850] xhci_hcd 0000:0a:00.0: Host halt failed, -19
[   28.822854] xhci_hcd 0000:0a:00.0: Host not accessible, reset failed.
[   28.823331] xhci_hcd 0000:0a:00.0: USB bus 3 deregistered
[   28.823589] pci 0000:0a:00.0: Removing from iommu group 15
[   28.823605] pci_bus 0000:0a: busn_res: [bus 0a] is released
[   28.823660] pci 0000:09:02.0: Removing from iommu group 15
[   28.823729] pci_bus 0000:0b: busn_res: [bus 0b-2c] is released
[   28.823773] pci 0000:09:04.0: Removing from iommu group 15
[   28.823782] pci_bus 0000:09: busn_res: [bus 09-2c] is released
[   28.823851] pci 0000:08:00.0: Removing from iommu group 15

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/pci/hotplug/pciehp.h      | 1 +
 drivers/pci/hotplug/pciehp_core.c | 2 +-
 drivers/pci/hotplug/pciehp_hpc.c  | 7 ++++---
 3 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 918dccbc74b6..7de17f32bf8c 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -106,6 +106,7 @@ struct controller {
 
 	struct hotplug_slot hotplug_slot;	/* hotplug core interface */
 	struct rw_semaphore reset_lock;
+	unsigned int depth;
 	unsigned int ist_running;
 	int request_result;
 	wait_queue_head_t requester;
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index f34114d45259..4042d87d539d 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -166,7 +166,7 @@ static void pciehp_check_presence(struct controller *ctrl)
 {
 	int occupied;
 
-	down_read(&ctrl->reset_lock);
+	down_read_nested(&ctrl->reset_lock, ctrl->depth);
 	mutex_lock(&ctrl->state_lock);
 
 	occupied = pciehp_card_present_or_link_active(ctrl);
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 83a0fa119cae..54643a95baad 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -583,7 +583,7 @@ static void pciehp_ignore_dpc_link_change(struct controller *ctrl,
 	 * the corresponding link change may have been ignored above.
 	 * Synthesize it to ensure that it is acted on.
 	 */
-	down_read(&ctrl->reset_lock);
+	down_read_nested(&ctrl->reset_lock, ctrl->depth);
 	if (!pciehp_check_link_active(ctrl))
 		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
 	up_read(&ctrl->reset_lock);
@@ -746,7 +746,7 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	 * Disable requests have higher priority than Presence Detect Changed
 	 * or Data Link Layer State Changed events.
 	 */
-	down_read(&ctrl->reset_lock);
+	down_read_nested(&ctrl->reset_lock, ctrl->depth);
 	if (events & DISABLE_SLOT)
 		pciehp_handle_disable_request(ctrl);
 	else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC))
@@ -906,7 +906,7 @@ int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, bool probe)
 	if (probe)
 		return 0;
 
-	down_write(&ctrl->reset_lock);
+	down_write_nested(&ctrl->reset_lock, ctrl->depth);
 
 	if (!ATTN_BUTTN(ctrl)) {
 		ctrl_mask |= PCI_EXP_SLTCTL_PDCE;
@@ -975,6 +975,7 @@ struct controller *pcie_init(struct pcie_device *dev)
 		return NULL;
 
 	ctrl->pcie = dev;
+	ctrl->depth = pci_dev_depth(dev->port);
 	pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP, &slot_cap);
 
 	if (pdev->hotplug_user_indicators)
-- 
2.33.1

