Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D883BA63E
	for <lists+linux-pci@lfdr.de>; Sat,  3 Jul 2021 01:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhGBXSS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jul 2021 19:18:18 -0400
Received: from mail-lf1-f46.google.com ([209.85.167.46]:37470 "EHLO
        mail-lf1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbhGBXSS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jul 2021 19:18:18 -0400
Received: by mail-lf1-f46.google.com with SMTP id q16so20913148lfr.4
        for <linux-pci@vger.kernel.org>; Fri, 02 Jul 2021 16:15:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=AorGHztfZlXp7JGTGU6/CIrqArA0BHWkqVm56YaiVHc=;
        b=iDaPbJ63Xx1rhCi5zVJOlUSoRWgNWGd4QRAa6SdYLWMHSjY1WnzzCWoWG+BT2QCk+u
         84mXGM/sWOY+/asSM3D0uaBN1BKKyshnn9mzucq/kMH4R1lSMPvqjZ06ZEkgw7KcaOvb
         i2MkDRdnmfLpB0dbaKppPBchCo+q9/139/qrXc6jb548q/5rWdj4sSj1m4i6XX5dWXFu
         xmN3myaLZUenw5o20w9HgbSK3bc22qzfhwa6hoxtMxJxlmEz6NXMlEdWhX7xAWGhGmqM
         UjpzkT0bPUZkmPWR2i3PWd38sfBTPFcXeOM3sz151qqsBeIhjRUQfNJbq5xBv8MTC+a4
         bS5g==
X-Gm-Message-State: AOAM533p7A9Eo7MC6wEJDXYtAeBJ8kfY2PIet/c6pf+0CWahf1ZqNdzN
        /cxcDgWCvzQfd0IOn/8HM+4=
X-Google-Smtp-Source: ABdhPJyJwrCx/KDJDXwpUVo8+lKA/83ZQRRgYpV8BM63D7rMHXykdfoeQzHbe235J3+Gg9BdH0rL9A==
X-Received: by 2002:ac2:5d49:: with SMTP id w9mr1508423lfd.345.1625267743558;
        Fri, 02 Jul 2021 16:15:43 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id z12sm424759lfg.140.2021.07.02.16.15.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 16:15:42 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Scott Murray <scott@spiteful.org>, linux-pci@vger.kernel.org
Subject: [PATCH v3] PCI: hotplug: Fix kernel-doc formatting and add missing documentation
Date:   Fri,  2 Jul 2021 23:15:41 +0000
Message-Id: <20210702231541.1671875-1-kw@linux.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix kernel-doc formatting and add missing documentation for the
parameters "bus" of the get_slot_mapping() function, "t" of the
cpqhp_pushbutton_thread() function and "controller" of the
inband_presence_disabled() function.

Additionally, fix formatting and add missing documentation for the
members "slot_list" and "pci_slot" of the struct hotplug_slot.

Also remove surplus parameter "slot" from the description of the
function cpqhp_pushbutton_thread().

Thus, resolve build time warnings related to kernel-doc:

  drivers/pci/hotplug/cpqphp_core.c:308: warning: Function parameter or member 'bus' not described in 'get_slot_mapping'
  drivers/pci/hotplug/cpqphp_core.c:308: warning: Function parameter or member 'bus_num' not described in 'get_slot_mapping'
  drivers/pci/hotplug/cpqphp_core.c:308: warning: Function parameter or member 'dev_num' not described in 'get_slot_mapping'
  drivers/pci/hotplug/cpqphp_core.c:308: warning: Function parameter or member 'slot' not described in 'get_slot_mapping'

  drivers/pci/hotplug/cpqphp_ctrl.c:1887: warning: Function parameter or member 't' not described in 'cpqhp_pushbutton_thread'
  drivers/pci/hotplug/cpqphp_ctrl.c:1887: warning: Excess function parameter 'slot' description in 'cpqhp_pushbutton_thread'

  drivers/pci/hotplug/pciehp.h:110: warning: Function parameter or member 'inband_presence_disabled' not described in 'controller'

  include/linux/pci_hotplug.h:64: warning: Function parameter or member 'slot_list' not described in 'hotplug_slot'
  include/linux/pci_hotplug.h:64: warning: Function parameter or member 'pci_slot' not described in 'hotplug_slot'

No change to functionality intended.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
Changes in v3:
  Added kernel-doc fixes for the file include/linux/pci_hotplug.h.
Changes in v2:
  Added kernel-doc fixes for the files drivers/pci/hotplug/cpqphp_ctrl.c
  and drivers/pci/hotplug/pciehp.h.

 drivers/pci/hotplug/cpqphp_core.c | 16 ++++---
 drivers/pci/hotplug/cpqphp_ctrl.c |  4 +-
 drivers/pci/hotplug/pciehp.h      | 80 ++++++++++++++++++-------------
 include/linux/pci_hotplug.h       | 12 +++--
 4 files changed, 67 insertions(+), 45 deletions(-)

diff --git a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
index b8aacb41a83c..efe6031c1e68 100644
--- a/drivers/pci/hotplug/cpqphp_core.c
+++ b/drivers/pci/hotplug/cpqphp_core.c
@@ -292,15 +292,17 @@ static int ctrl_slot_cleanup(struct controller *ctrl)
 
 
 /**
- * get_slot_mapping - determine logical slot mapping for PCI device
+ * get_slot_mapping - Determine logical slot mapping for PCI device.
+ * @bus:	Pointer to the PCI bus structure.
+ * @bus_num:	Bus number of the PCI device.
+ * @dev_num:	Device number of the PCI device.
+ * @slot:	Pointer to where slot number will be returned.
  *
- * Won't work for more than one PCI-PCI bridge in a slot.
+ * Will not work for more than one PCI-PCI bridge in a slot.
  *
- * @bus_num - bus number of PCI device
- * @dev_num - device number of PCI device
- * @slot - Pointer to u8 where slot number will	be returned
- *
- * Output:	SUCCESS or FAILURE
+ * Return:
+ * * 0		- Logical slot mapping has been found for this PCI device.
+ * * < 0	- Unable to find entry in the routing table for this PCI device.
  */
 static int
 get_slot_mapping(struct pci_bus *bus, u8 bus_num, u8 dev_num, u8 *slot)
diff --git a/drivers/pci/hotplug/cpqphp_ctrl.c b/drivers/pci/hotplug/cpqphp_ctrl.c
index 68de958a9be8..035114423ebb 100644
--- a/drivers/pci/hotplug/cpqphp_ctrl.c
+++ b/drivers/pci/hotplug/cpqphp_ctrl.c
@@ -1876,8 +1876,8 @@ static void interrupt_event_handler(struct controller *ctrl)
 
 
 /**
- * cpqhp_pushbutton_thread - handle pushbutton events
- * @slot: target slot (struct)
+ * cpqhp_pushbutton_thread - Handle pushbutton events.
+ * @t: Pointer to struct timer_list which holds all timer related callbacks.
  *
  * Scheduled procedure to handle blocking stuff for the pushbuttons.
  * Handles all pending events and exits.
diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 4fd200d8b0a9..c8b2b1e046e8 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -44,38 +44,54 @@ extern int pciehp_poll_time;
 #define SLOT_NAME_SIZE 10
 
 /**
- * struct controller - PCIe hotplug controller
- * @pcie: pointer to the controller's PCIe port service device
- * @slot_cap: cached copy of the Slot Capabilities register
- * @slot_ctrl: cached copy of the Slot Control register
- * @ctrl_lock: serializes writes to the Slot Control register
- * @cmd_started: jiffies when the Slot Control register was last written;
- *	the next write is allowed 1 second later, absent a Command Completed
- *	interrupt (PCIe r4.0, sec 6.7.3.2)
- * @cmd_busy: flag set on Slot Control register write, cleared by IRQ handler
- *	on reception of a Command Completed event
- * @queue: wait queue to wake up on reception of a Command Completed event,
- *	used for synchronous writes to the Slot Control register
- * @pending_events: used by the IRQ handler to save events retrieved from the
- *	Slot Status register for later consumption by the IRQ thread
- * @notification_enabled: whether the IRQ was requested successfully
- * @power_fault_detected: whether a power fault was detected by the hardware
- *	that has not yet been cleared by the user
- * @poll_thread: thread to poll for slot events if no IRQ is available,
- *	enabled with pciehp_poll_mode module parameter
- * @state: current state machine position
- * @state_lock: protects reads and writes of @state;
- *	protects scheduling, execution and cancellation of @button_work
- * @button_work: work item to turn the slot on or off after 5 seconds
- *	in response to an Attention Button press
- * @hotplug_slot: structure registered with the PCI hotplug core
- * @reset_lock: prevents access to the Data Link Layer Link Active bit in the
- *	Link Status register and to the Presence Detect State bit in the Slot
- *	Status register during a slot reset which may cause them to flap
- * @ist_running: flag to keep user request waiting while IRQ thread is running
- * @request_result: result of last user request submitted to the IRQ thread
- * @requester: wait queue to wake up on completion of user request,
- *	used for synchronous slot enable/disable request via sysfs
+ * struct controller - PCIe hotplug controller.
+ * @pcie:			Pointer to the controller's PCIe port service
+ *				device.
+ * @slot_cap:			Cached copy of the Slot Capabilities register.
+ * @inband_presence_disabled:	Flag to used to track whether the in-band
+ *				presence detection is disabled.
+ * @slot_ctrl:			Cached copy of the Slot Control register.
+ * @ctrl_lock:			Serializes writes to the Slot Control register.
+ * @cmd_started:		Jiffies when the Slot Control register was last
+ *				written; the next write is allowed 1 second
+ *				later, absent a Command Completed interrupt
+ *				(PCIe r4.0, sec 6.7.3.2).
+ * @cmd_busy:			Flag set on Slot Control register write, cleared
+ *				by IRQ handler on reception of a Command
+ *				Completed event.
+ * @queue:			Wait queue to wake up on reception of a Command
+ *				Completed event, used for synchronous writes to
+ *				the Slot Control register.
+ * @pending_events:		Used by the IRQ handler to save events retrieved
+ *				from the Slot Status register for later
+ *				consumption by the IRQ thread.
+ * @notification_enabled:	Whether the IRQ was requested successfully.
+ * @power_fault_detected:	Whether a power fault was detected by the
+ *				hardware that has not yet been cleared by the
+ *				user.
+ * @poll_thread:		Thread to poll for slot events if no IRQ is
+ *				available, enabled with pciehp_poll_mode module
+ *				parameter.
+ * @state:			Current state machine position.
+ * @state_lock:			Protects reads and writes of @state; protects
+ *				scheduling, execution and cancellation of
+ *				@button_work.
+ * @button_work:		Work item to turn the slot on or off after
+ *				5 seconds in response to an Attention Button
+ *				press.
+ * @hotplug_slot:		Structure registered with the PCI hotplug core.
+ * @reset_lock:			Prevents access to the Data Link Layer Link
+ *				Active bit in the Link Status register and to
+ *				the Presence Detect State bit in the Slot Status
+ *				register during a slot reset which may cause
+ *				them to flap.
+ * @ist_running:		Flag to keep user request waiting while IRQ
+ *				thread is running.
+ * @request_result:		Result of last user request submitted to the IRQ
+ *				thread.
+ * @requester:			Wait queue to wake up on completion of user
+ *				request, used for synchronous slot
+ *				enable/disable request via sysfs.
  *
  * PCIe hotplug has a 1:1 relationship between controller and slot, hence
  * unlike other drivers, the two aren't represented by separate structures.
diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index b482e42d7153..a73851884b81 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -48,10 +48,14 @@ struct hotplug_slot_ops {
 };
 
 /**
- * struct hotplug_slot - used to register a physical slot with the hotplug pci core
- * @ops: pointer to the &struct hotplug_slot_ops to be used for this slot
- * @owner: The module owner of this structure
- * @mod_name: The module name (KBUILD_MODNAME) of this structure
+ * struct hotplug_slot - Used to register a physical slot with the hotplug PCI
+ *			 core.
+ * @ops:	Pointer to the &struct hotplug_slot_ops to be used for this
+ *		slot.
+ * @slot_list:	Internal list used to track hotplug PCI slots.
+ * @pci_slot:	Pepresents a physical slot.
+ * @owner:	The module owner of this structure.
+ * @mod_name:	The module name (KBUILD_MODNAME) of this structure.
  */
 struct hotplug_slot {
 	const struct hotplug_slot_ops	*ops;
-- 
2.32.0

