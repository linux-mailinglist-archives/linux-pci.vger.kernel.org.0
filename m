Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB88155EF7
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2020 20:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgBGTzA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Feb 2020 14:55:00 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45862 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727011AbgBGTzA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Feb 2020 14:55:00 -0500
Received: by mail-oi1-f195.google.com with SMTP id v19so3126778oic.12;
        Fri, 07 Feb 2020 11:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=iuBTW8/X2lrkp6zyi9azV1//txrOxUa2PqcAjwGzB5o=;
        b=IgqE+Gku8NGjxDIjHIZo+toujsrY9kw4GnV5wXzYIM1ZK/JUJudzftIjtFGi5waRwy
         V6HHOwbXo827zOMwlKYH6qZyn2TXJ3OWBGe4zoeUKylasNTvreeD6NG3F/HTc72m8gKy
         QifGqgpbeP8v1yi1Q7Q4+mqOgB+NyQRHlLx5+XZnc6Cmu8ataX9Abqmkeigg857861Wy
         NOZTJ3R5//ozwzwSHM1o/j0KVX3Z2QNbPKMG1z4SmsYS823DClEGZv+Nvak1InHciwa/
         LOqjetpP6CKEi+cU7/UzVQUfVL5FlMfJlHAzGxZ7KpNQVRYlrNFtuB5suPIGw5wbZB55
         BPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=iuBTW8/X2lrkp6zyi9azV1//txrOxUa2PqcAjwGzB5o=;
        b=OZ1wtuGXGfUinB935ny4s2iGYxgJu5ORDMQflc87XRkOX3EzJha0CGio91/FVy7YMf
         sw78SirnrSHv+zlIaoqVh3yL/UbPMl6MkOXHOezN/RLDyQ/hPi/BlXjFDueiWXJhe60h
         Taf48KXzvjDzHe0agX6mPUbb3nekLFRdNo7PI4KYQj0l02iMWyw87k2LQbHyAKSmSN3u
         1YpbW+AxSwpGLHg9bZzd8f89oZ+PGoyMiHvXod3GZULGtxupm/U0SIs2xc06uBnxcbBG
         FGozoIROpPA2c52HQsqWhDnBonfyOHkQc1oCph5GaU5JkPArL/yH3skBTeEOyldBjuum
         LQYQ==
X-Gm-Message-State: APjAAAUTNb9e/DDE/9p/VtUtavb3YY7G93ddmKjG4Vbe2C6zOb03ORAx
        bYDDgAF9SNWmBuQt+WC4bSo=
X-Google-Smtp-Source: APXvYqzZbOuSZAycQWop/eZuj34wF1eV9/CI5pBjXr7j3A/QQPilNWLI+COWhAgoOnG8MBrunGNFkA==
X-Received: by 2002:aca:b70a:: with SMTP id h10mr3365291oif.20.1581105298806;
        Fri, 07 Feb 2020 11:54:58 -0800 (PST)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id f142sm1335239oig.48.2020.02.07.11.54.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 11:54:58 -0800 (PST)
From:   Stuart Hayes <stuart.w.hayes@gmail.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Austin Bolen <austin_bolen@dell.com>,
        Keith Busch <kbusch@kernel.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de, narendra_k@dell.com,
        Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: [PATCH v3] PCI: pciehp: Make sure pciehp_isr clears interrupt events
Date:   Fri,  7 Feb 2020 14:54:50 -0500
Message-Id: <20200207195450.52026-1-stuart.w.hayes@gmail.com>
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
event bits. If this happens when the MSI isn't masked (it will never be,
for example, when MSR per-vector masking is not supported), we won't get
any more hotplug interrupts from that device.

That is expected behavior, according to the PCI Express Base Specification
Revision 5.0 Version 1.0, section 6.7.3.4, "Software Notification of Hot-
Plug Events".

Because the "presence detect changed" and "data link layer state changed"
event bits can both get set at nearly the same time when a device is added
or removed, this is more likely to happen than it might seem. The issue was
found (and can be reproduced rather easily) by connecting and disconnecting
an NVMe storage device on at least one system model where the NVMe devices
were being connected to an AMD PCIe port (PCI device 0x1022/0x1483).

This patch fixes this issue by modifying pciehp_isr() by looping back and
re-reading the slot status register immediately after writing to it, until
it sees that all of the event status bits have been cleared.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
v3:
  * removed pvm_capable flag (from v2) since MSI may not be masked
    regardless of whether per-vector masking is supported
  * tweaked comments

v2:
  * fixed ctrl_warn() call
  * improved comments
  * added pvm_capable flag and changed pciehp_isr() to loop back only when
    pvm_capable flag not set (suggested by Lukas Wunner)

 drivers/pci/hotplug/pciehp_hpc.c | 41 +++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 8a2cb1764386..0f99a150115e 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -522,12 +522,22 @@ void pciehp_power_off_slot(struct controller *ctrl)
 		 PCI_EXP_SLTCTL_PWR_OFF);
 }
 
+/*
+ * Set a limit to how many times the ISR will loop reading and writing the
+ * slot status register trying to clear the event bits.  These bits should
+ * not toggle rapidly, and there are only six possible events that could
+ * generate this interrupt.  If we still see events after this many reads,
+ * there is likely a bit stuck.
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
@@ -552,6 +562,7 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 		}
 	}
 
+read_status:
 	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &status);
 	if (status == (u16) ~0) {
 		ctrl_info(ctrl, "%s: no response from device\n", __func__);
@@ -564,24 +575,42 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
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
+		 * Unless the MSI happens to be masked, all of the event
+		 * bits must be zero before the port will send a new
+		 * interrupt (see PCI Express Base Specification Rev 5.0
+		 * Version 1.0, section 6.7.3.4, "Software Notification of
+		 * Hot-Plug Events"). So, if an event bit gets set between
+		 * the read and the write of PCI_EXP_SLTSTA, we need to
+		 * loop back and try again.
+		 */
+		if (status_reads++ < MAX_ISR_STATUS_READS)
+			goto read_status;
+		ctrl_warn(ctrl, "Hot plug event bit stuck (%x)\n",
+			  status);
+	}
+
 	ctrl_dbg(ctrl, "pending interrupts %#06x from Slot Status\n", events);
 	if (parent)
 		pm_runtime_put(parent);
-- 
2.18.1

