Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC258104657
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 23:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725842AbfKTWV3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 17:21:29 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:46614 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbfKTWV3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Nov 2019 17:21:29 -0500
Received: by mail-ot1-f65.google.com with SMTP id n23so1049369otr.13;
        Wed, 20 Nov 2019 14:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=+jfkpzTCAcWe+Xzpcosj3+zIbpQIJQRYhnSQKRU1HHk=;
        b=CT7FXPA6dGrBdpXP6az91fi46FFaWxjy+WyV23c2+z8jIw+o1Q/57tpiDlpESD6sEj
         elWQLZMh/1zkxUQhdcgnLDqcvFYvHQl7llX0Dvp6W04S3U/IoQJQAseE/DP4BZyY/7Vs
         asGyViMiBovEChpRPTSGyrY7IbGP1883uY2kWyxsHes2uyadmWtDuzzaeNn6H1PmfhWF
         xid6uZWRL51xJGSbML4+1xEs+i2aJLcYIGEPYjGG7667/eStYcUR+qHk3y93fAQOgs3C
         Fx/C1ZeJGnmDSe741h8WLpmRIV6s4PUIv4HJBxAwhclvVsI9eZutvs3XGS2M0dI+sFag
         uQtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+jfkpzTCAcWe+Xzpcosj3+zIbpQIJQRYhnSQKRU1HHk=;
        b=Hgo+rfe+PeuphJvMMJZKfVfiYFfL0g5jXLWX8SkM4du94q6aJffGLKj9Ye09OchykJ
         EZbk8zZUFJN4xuegwqKTBFt+NzQSVfK+i9ndrWqggftzxbvC1iNkCJ99v2XY+5mK3w+t
         o4FBzw7fMfPEXlsbmNNTkhTpej8jjTAUbnzAxzcitigrM9wL7ADWnFhUk9dfPy3efi48
         Zrrz3yyWP2JDJLj8/HjLFnsqg8/3LE4mTfGeBXvrRjhnSSdlGK1JtI6fYaH/6Bhuefs7
         G5BRj7t0wKuh1zY43aRGumZzJsO+YfJG/1zr0gSbLr6VtiRCFb0PxiLFhr9RULZRVqBj
         exWg==
X-Gm-Message-State: APjAAAWmQZDc19QHoayS0uGcM1t8t9S5N8w3rr6Tdmk9aegwm7TwudUZ
        yYV0v7W54X5xJAnuG9e3UkM=
X-Google-Smtp-Source: APXvYqydQveKtHQIMBx1K2zzU//bSgkA0jrEXuIeirQqY6I2ElrrGH6Zdy8fymcu0fH+7x8oFIkI5g==
X-Received: by 2002:a9d:5c2:: with SMTP id 60mr4066480otd.104.1574288487728;
        Wed, 20 Nov 2019 14:21:27 -0800 (PST)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id k66sm235772oia.40.2019.11.20.14.21.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 14:21:26 -0800 (PST)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Austin Bolen <austin_bolen@dell.com>, keith.busch@intel.com,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v2] PCI: pciehp: Make sure pciehp_isr clears interrupt events
Date:   Wed, 20 Nov 2019 17:20:43 -0500
Message-Id: <20191120222043.53432-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Without this patch, a pciehp hotplug port can stop generating interrupts
on hotplug events, so device adds and removals will not be seen.

The pciehp interrupt handler pciehp_isr() will read the slot status
register and then write back to it to clear the bits that caused the
interrupt. If a different interrupt event bit gets set between the read and
the write, pciehp_isr will exit without having cleared all of the interrupt
event bits. If this happens, and the port is using an MSI interrupt where
per-vector masking is not supported, we won't get any more hotplug
interrupts from that device.

That is expected behavior, according to the PCI Express Base Specification
Revision 5.0 Version 1.0, section 6.7.3.4, "Software Notification of Hot-
Plug Events".

Because the "presence detect changed" and "data link layer state changed"
event bits are both getting set at nearly the same time when a device is
added or removed, this is more likely to happen than it might seem. The
issue was found (and can be reproduced rather easily) by connecting and
disconnecting an NVMe storage device on at least one system model.

This issue was found while adding and removing various NVMe storage devices
on an AMD PCIe port (PCI device 0x1022/0x1483).

This patch fixes this issue by modifying pciehp_isr() by looping back and
re-reading the slot status register immediately after writing to it, until
it sees that all of the event status bits have been cleared.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
v2:
  * fixed ctrl_warn() call
  * improved comments
  * added pvm_capable flag and changed pciehp_isr() to loop back only when
    pvm_capable flag not set (suggested by Lukas Wunner)
  
 drivers/pci/hotplug/pciehp.h     |  3 ++
 drivers/pci/hotplug/pciehp_hpc.c | 50 ++++++++++++++++++++++++++++----
 2 files changed, 47 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 654c972b8ea0..1804277ec433 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -47,6 +47,8 @@ extern int pciehp_poll_time;
  * struct controller - PCIe hotplug controller
  * @pcie: pointer to the controller's PCIe port service device
  * @slot_cap: cached copy of the Slot Capabilities register
+ * @pvm_capable: set if per-vector masking is supported (if not set, the ISR
+ *	needs to ensure all event bits cleared)
  * @slot_ctrl: cached copy of the Slot Control register
  * @ctrl_lock: serializes writes to the Slot Control register
  * @cmd_started: jiffies when the Slot Control register was last written;
@@ -83,6 +85,7 @@ struct controller {
 	struct pcie_device *pcie;
 
 	u32 slot_cap;				/* capabilities and quirks */
+	unsigned int pvm_capable:1;
 
 	u16 slot_ctrl;				/* control register access */
 	struct mutex ctrl_lock;
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 1a522c1c4177..4ffd489a5413 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -487,12 +487,21 @@ void pciehp_power_off_slot(struct controller *ctrl)
 		 PCI_EXP_SLTCTL_PWR_OFF);
 }
 
+/*
+ * We should never need to re-read the slot status register this many times,
+ * because there are only six possible events that could generate this
+ * interrupt.  If we still see events after this many reads, there's a stuck
+ * bit.
+ */
+#define MAX_ISR_STATUS_READS 6
+
 static irqreturn_t pciehp_isr(int irq, void *dev_id)
 {
 	struct controller *ctrl = (struct controller *)dev_id;
 	struct pci_dev *pdev = ctrl_dev(ctrl);
 	struct device *parent = pdev->dev.parent;
-	u16 status, events;
+	u16 status, events = 0;
+	int status_reads = 0;
 
 	/*
 	 * Interrupts only occur in D3hot or shallower and only if enabled
@@ -517,6 +526,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 		}
 	}
 
+read_status:
 	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
 	if (status == (u16) ~0) {
 		ctrl_info(ctrl, "%s: no response from device\n", __func__);
@@ -529,24 +539,44 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 	 * Slot Status contains plain status bits as well as event
 	 * notification bits; right now we only want the event bits.
 	 */
-	events = status & (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
-			   PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_CC |
-			   PCI_EXP_SLTSTA_DLLSC);
+	status &= (PCI_EXP_SLTSTA_ABP | PCI_EXP_SLTSTA_PFD |
+		   PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_CC |
+		   PCI_EXP_SLTSTA_DLLSC);
 
 	/*
 	 * If we've already reported a power fault, don't report it again
 	 * until we've done something to handle it.
 	 */
 	if (ctrl->power_fault_detected)
-		events &= ~PCI_EXP_SLTSTA_PFD;
+		status &= ~PCI_EXP_SLTSTA_PFD;
 
+	events |= status;
 	if (!events) {
 		if (parent)
 			pm_runtime_put(parent);
 		return IRQ_NONE;
 	}
 
-	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
+	if (status) {
+		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, status);
+
+		/*
+		 * If MSI per-vector masking is not supported by the port,
+		 * all of the event bits must be zero before the port will
+		 * send a new interrupt (see PCI Express Base Specification
+		 * Revision 5.0 Version 1.0, section 6.7.3.4, "Software
+		 * Notification of Hot-Plug Events"). So in that case, if
+		 * event bit gets set between the read and the write of
+		 * PCI_EXP_SLTSTA, we need to loop back and try again.
+		 */
+		if (!ctrl->pvm_capable) {
+			if (status_reads++ < MAX_ISR_STATUS_READS)
+				goto read_status;
+			ctrl_warn(ctrl, "Hot plug event bit stuck (%x)\n",
+				  status);
+		}
+	}
+
 	ctrl_dbg(ctrl, "pending interrupts %#06x from Slot Status\n", events);
 	if (parent)
 		pm_runtime_put(parent);
@@ -812,6 +842,7 @@ struct controller *pcie_init(struct pcie_device *dev)
 {
 	struct controller *ctrl;
 	u32 slot_cap, link_cap;
+	u16 msiflags;
 	u8 poweron;
 	struct pci_dev *pdev = dev->port;
 	struct pci_bus *subordinate = pdev->subordinate;
@@ -881,6 +912,13 @@ struct controller *pcie_init(struct pcie_device *dev)
 		}
 	}
 
+	ctrl->pvm_capable = 1;
+	if (pdev->msi_enabled) {
+		pci_read_config_word(pdev, pdev->msi_cap + PCI_MSI_FLAGS,
+				     &msiflags);
+		ctrl->pvm_capable = !!(msiflags & PCI_MSI_FLAGS_MASKBIT);
+	}
+
 	return ctrl;
 }
 
-- 
2.18.1

