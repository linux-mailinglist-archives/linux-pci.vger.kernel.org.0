Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B50013BA5EF
	for <lists+linux-pci@lfdr.de>; Sat,  3 Jul 2021 00:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbhGBWUl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jul 2021 18:20:41 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:40922 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229917AbhGBWUk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jul 2021 18:20:40 -0400
Received: by mail-lf1-f53.google.com with SMTP id q18so20644254lfc.7
        for <linux-pci@vger.kernel.org>; Fri, 02 Jul 2021 15:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MRXcfUUUika1jq9IO2Fs/5pLOnBVqCm32/qxc3uP+zI=;
        b=lZmVvO3RImlwJLeYX8kvZc2pXpvb/ApUML5EXrxz54HPYO3/+T7WfPc2OmAI+tZ3CU
         /GjBmL/+MobTc4NauoIR4iyerLV3MII4RzcTRQetQ29Zz1OePsOe+A48eW7zWK4xXg0b
         XDKwljRjqbQODHwqgKpesoPLZEvaTEOv3GMhv53mQqLzf9O3LEfBY/4KCsxUifscDQUT
         FQOQSYqPdV5pKpZnvDK/vBaePKqgpYpxHM7IobY+uvi8+b2Tm7EwUoNqrL02dyOScxLT
         Vb3qXReGcqhPmGKol44ZF4IKt10bIeN+CVQvg+a2CBzvEVMGR4NyrYuRYuiThzCrlp/e
         rUWA==
X-Gm-Message-State: AOAM533evIUIj1pkZOVOFNMJSg5MBWDtr/6NgN/mz39Jceno/YLzZAdS
        YMFBN0k0eDMS49PZD8ogDfw=
X-Google-Smtp-Source: ABdhPJxWXPFMrlbDXHlSa1LQ751HsWNCjyosJhnl1nPnECUsQ5euP6R+6O2ojtT3j8jDaDDwoPDS6w==
X-Received: by 2002:a05:6512:ea1:: with SMTP id bi33mr1286685lfb.281.1625264286275;
        Fri, 02 Jul 2021 15:18:06 -0700 (PDT)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id z3sm487669ljm.110.2021.07.02.15.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 15:18:05 -0700 (PDT)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: [PATCH v2] PCI: hotplug: Fix kernel-doc formatting and add missing documentation
Date:   Fri,  2 Jul 2021 22:18:04 +0000
Message-Id: <20210702221804.1668189-1-kw@linux.com>
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

No change to functionality intended.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/hotplug/cpqphp_core.c | 16 ++++---
 drivers/pci/hotplug/cpqphp_ctrl.c |  4 +-
 drivers/pci/hotplug/pciehp.h      | 80 ++++++++++++++++++-------------
 3 files changed, 59 insertions(+), 41 deletions(-)

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
-- 
2.32.0

