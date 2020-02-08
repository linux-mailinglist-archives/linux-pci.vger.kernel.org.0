Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46E911561AF
	for <lists+linux-pci@lfdr.de>; Sat,  8 Feb 2020 01:00:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgBHAAW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Feb 2020 19:00:22 -0500
Received: from mga03.intel.com ([134.134.136.65]:58200 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727543AbgBHAAV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Feb 2020 19:00:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 16:00:21 -0800
X-IronPort-AV: E=Sophos;i="5.70,415,1574150400"; 
   d="scan'208";a="225545800"
Received: from nsgsw-rhel7p6.lm.intel.com ([10.232.116.83])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Feb 2020 16:00:20 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Pawel Baldysiak <pawel.baldysiak@intel.com>,
        Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [RFC 6/9] PCI: pciehp: Expose the poll loop to other drivers
Date:   Fri,  7 Feb 2020 17:00:04 -0700
Message-Id: <1581120007-5280-7-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1581120007-5280-1-git-send-email-jonathan.derrick@intel.com>
References: <1581120007-5280-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Abstract the poll loop into an 'events pending' check and a 'handle
events' method in order to allow another driver to call the polling
loop.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/hotplug/pciehp.h     |  2 ++
 drivers/pci/hotplug/pciehp_hpc.c | 16 +++++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index c898c75..48fdd62 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -160,6 +160,8 @@ struct controller {
 #define NO_CMD_CMPL(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_NCCS)
 #define PSN(ctrl)		(((ctrl)->slot_cap & PCI_EXP_SLTCAP_PSN) >> 19)
 
+bool pciehp_events_pending(struct controller *ctrl);
+void pciehp_handle_events(struct controller *ctrl);
 void pciehp_request(struct controller *ctrl, int action);
 void pciehp_handle_button_press(struct controller *ctrl);
 void pciehp_handle_disable_request(struct controller *ctrl);
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index ce1e8c7..e46f177 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -708,6 +708,17 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+bool pciehp_events_pending(struct controller *ctrl)
+{
+	return pciehp_isr(IRQ_NOTCONNECTED, ctrl) == IRQ_WAKE_THREAD ||
+	       atomic_read(&ctrl->pending_events);
+}
+
+void pciehp_handle_events(struct controller *ctrl)
+{
+	pciehp_ist(IRQ_NOTCONNECTED, ctrl);
+}
+
 static int pciehp_poll(void *data)
 {
 	struct controller *ctrl = data;
@@ -716,9 +727,8 @@ static int pciehp_poll(void *data)
 
 	while (!kthread_should_stop()) {
 		/* poll for interrupt events or user requests */
-		while (pciehp_isr(IRQ_NOTCONNECTED, ctrl) == IRQ_WAKE_THREAD ||
-		       atomic_read(&ctrl->pending_events))
-			pciehp_ist(IRQ_NOTCONNECTED, ctrl);
+		while (pciehp_events_pending(ctrl))
+			pciehp_handle_events(ctrl);
 
 		if (pciehp_poll_time <= 0 || pciehp_poll_time > 60)
 			pciehp_poll_time = 2; /* clamp to sane value */
-- 
1.8.3.1

