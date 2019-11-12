Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB608F9CB6
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2019 23:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfKLWAI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Nov 2019 17:00:08 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44073 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfKLWAI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Nov 2019 17:00:08 -0500
Received: by mail-oi1-f193.google.com with SMTP id s71so16321777oih.11;
        Tue, 12 Nov 2019 14:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SM3kzFDlQX16L/SqN04Biyd1Tj/HnHRpvkPbCwJ453o=;
        b=MhDMNtD9ZWPZeT4JeFVRu7zKMj4JAWPGtQtmFdT+YIcXHpn/NqhUl8I8W23+/AoO7Q
         nn06oigDLgupi8ina7DwtKW9nDJuaqqqmXuDT8VrxUZqEd2ehlooNU9RQh6QPLoYh0bf
         IajsyY8KQbaB+AOuMSgR4/v0s7A2IePipyuTAoWl90RXUJqop0KXpAS3uBNMH6Hrt5n1
         0SBiPFVhKaipsDvo13FZ6IRYIdgRYEcGbTwAGAxwJRvHfN99yIU+jMXCwPcxEjF9Md4G
         1UUBwL5bISWBJPM22F7v8w69g+dTWrPMsrMb7gBdFawE2/8gqdaFhvoKkfbYoRct72io
         MYZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SM3kzFDlQX16L/SqN04Biyd1Tj/HnHRpvkPbCwJ453o=;
        b=CiPJRj/5oYWWe3il9vP5blWIdbxhj1NpY0vAkxzBLAjECSXZ1CloTvsseXr7OjxmBK
         LzOfVT9eWTEq1okG+S/gWDgPklcf5apXgA+WXPClZ3xTzsfkYtukNpmhU5lDu9287E6t
         tOeEcZ5LM/zwiIcEeSqQTs/iLUR8feV9R1TQX2/hmzeYGDbkpiZyl3b4f5N6BavXcUdb
         myZf4+zRiK4sazhVJiwM4ZhdmOhSAKGIc3wtyDJfQg4duVk5jWyfU8XhKxQVfAZJPVQm
         NrcNgcOAxvwr/bQ0lMssY889DiYqauCdlqBpiykmv3HFNRiUSeM6cU71MHHPYhLe1OY/
         LrYw==
X-Gm-Message-State: APjAAAXLJrqM1A7CBwzvcRq4xAGhVRYtD2mYTSEt4IBFO28FdyKm7ld+
        X0z1vntT2Fk7w3tgaYKUBLU=
X-Google-Smtp-Source: APXvYqy00Kao8BdxRrpMSwj6gjyWVlESQh9Zt18w6/UeOJeMLEfTfdzm7EZ97i6/hr7islWybH6DSQ==
X-Received: by 2002:aca:7285:: with SMTP id p127mr1116498oic.120.1573596005228;
        Tue, 12 Nov 2019 14:00:05 -0800 (PST)
Received: from localhost.localdomain ([143.166.81.254])
        by smtp.gmail.com with ESMTPSA id d132sm3911oif.2.2019.11.12.14.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 14:00:04 -0800 (PST)
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
Subject: [PATCH] PCI: pciehp: Make sure pciehp_isr clears interrupt events
Date:   Tue, 12 Nov 2019 16:59:38 -0500
Message-Id: <20191112215938.1145-1-stuart.w.hayes@gmail.com>
X-Mailer: git-send-email 2.18.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The pciehp interrupt handler pciehp_isr() will read the slot status
register and then write back to it to clear just the bits that caused the
interrupt. If a different interrupt event bit gets set between the read and
the write, pciehp_isr() will exit without having cleared all of the
interrupt event bits, so we will never get another hotplug interrupt from
that device.

That is expected behavior according to the PCI Express spec (v.5.0, section
6.7.3.4, "Software Notification of Hot-Plug Events").

Because the "presence detect changed" and "data link layer state changed"
event bits are both getting set at nearly the same time when a device is
added or removed, this is more likely to happen than it might seem. The
issue can be reproduced rather easily by connecting and disconnecting an
NVMe device on at least one system model.

This patch fixes the issue by modifying pciehp_isr() to loop back and
re-read the slot status register immediately after writing to it, until
it sees that all of the event status bits have been cleared.

Signed-off-by: Stuart Hayes <stuart.w.hayes@gmail.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 39 +++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 1a522c1c4177..8ec22a872b28 100644
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
@@ -529,16 +539,34 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
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
+
+	if (status) {
+		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, status);
+		events |= status;
+	}
+
+	/*
+	 * All of the event bits must be zero before the port will send
+	 * a new interrupt.  If an event bit gets set between the read
+	 * and the write, we'll never get another interrupt, so loop until
+	 * we see no event bits set.
+	 */
+	if (status && status_reads++ < MAX_ISR_STATUS_READS)
+		goto read_status;
+
+	if (status_reads == MAX_ISR_STATUS_READS)
+		ctrl_warn(ctrl, "Slot(%s): Hot plug event bit stuck, reading %x\n",
+			  status, slot_name(ctrl));
 
 	if (!events) {
 		if (parent)
@@ -546,7 +574,6 @@ static irqreturn_t pciehp_isr(int irq, void *dev_id)
 		return IRQ_NONE;
 	}
 
-	pcie_capability_write_word(pdev, PCI_EXP_SLTSTA, events);
 	ctrl_dbg(ctrl, "pending interrupts %#06x from Slot Status\n", events);
 	if (parent)
 		pm_runtime_put(parent);
-- 
2.18.1

