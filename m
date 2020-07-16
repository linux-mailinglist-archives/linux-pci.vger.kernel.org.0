Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7BD222D69
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jul 2020 23:08:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbgGPVH4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Jul 2020 17:07:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:50682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725926AbgGPVH4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Jul 2020 17:07:56 -0400
Received: from embeddedor (unknown [201.162.240.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7CF9E207DD;
        Thu, 16 Jul 2020 21:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594933675;
        bh=YoUSoM3xGxkRWbb8SYHwwTUnz9+8wwbU0xwpr/carJw=;
        h=Date:From:To:Cc:Subject:From;
        b=ovEcFwCV3dckQXi+gnA2oZ9MWLDRFoYNggAdSPid8aV+FhzCx7w49YKmIgpMm1gM2
         fsjCPSjfnogqYJN9OkrGrJZWzGN6Z5peh7uCrTHG3uTz80hDovGJicnawXZtM5cRkq
         rNmlft5b0TPTuKbLzzvjCOqFzPLN2yZUXq2lqy5Q=
Date:   Thu, 16 Jul 2020 16:13:20 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH][next] PCI: Use fallthrough pseudo-keyword
Message-ID: <20200716211320.GA17054@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
fall-through markings when it is the case.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/pci/hotplug/ibmphp_res.c  | 2 +-
 drivers/pci/hotplug/pciehp_ctrl.c | 4 ++--
 drivers/pci/hotplug/shpchp_ctrl.c | 4 ++--
 drivers/pci/pci.c                 | 4 ++--
 drivers/pci/proc.c                | 2 +-
 drivers/pci/quirks.c              | 4 ++--
 drivers/pci/setup-bus.c           | 2 +-
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/hotplug/ibmphp_res.c b/drivers/pci/hotplug/ibmphp_res.c
index 5c93aa14f0de..ae9acc77d14f 100644
--- a/drivers/pci/hotplug/ibmphp_res.c
+++ b/drivers/pci/hotplug/ibmphp_res.c
@@ -1941,7 +1941,7 @@ static int __init update_bridge_ranges(struct bus_node **bus)
 						break;
 					case PCI_HEADER_TYPE_BRIDGE:
 						function = 0x8;
-						/* fall through */
+						fallthrough;
 					case PCI_HEADER_TYPE_MULTIBRIDGE:
 						/* We assume here that only 1 bus behind the bridge
 						   TO DO: add functionality for several:
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 6503d15effbb..9f85815b4f53 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -236,7 +236,7 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 	switch (ctrl->state) {
 	case BLINKINGOFF_STATE:
 		cancel_delayed_work(&ctrl->button_work);
-		/* fall through */
+		fallthrough;
 	case ON_STATE:
 		ctrl->state = POWEROFF_STATE;
 		mutex_unlock(&ctrl->state_lock);
@@ -265,7 +265,7 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 	switch (ctrl->state) {
 	case BLINKINGON_STATE:
 		cancel_delayed_work(&ctrl->button_work);
-		/* fall through */
+		fallthrough;
 	case OFF_STATE:
 		ctrl->state = POWERON_STATE;
 		mutex_unlock(&ctrl->state_lock);
diff --git a/drivers/pci/hotplug/shpchp_ctrl.c b/drivers/pci/hotplug/shpchp_ctrl.c
index afdc52d1cae7..65502e3f7b4f 100644
--- a/drivers/pci/hotplug/shpchp_ctrl.c
+++ b/drivers/pci/hotplug/shpchp_ctrl.c
@@ -642,7 +642,7 @@ int shpchp_sysfs_enable_slot(struct slot *p_slot)
 	switch (p_slot->state) {
 	case BLINKINGON_STATE:
 		cancel_delayed_work(&p_slot->work);
-		/* fall through */
+		fallthrough;
 	case STATIC_STATE:
 		p_slot->state = POWERON_STATE;
 		mutex_unlock(&p_slot->lock);
@@ -678,7 +678,7 @@ int shpchp_sysfs_disable_slot(struct slot *p_slot)
 	switch (p_slot->state) {
 	case BLINKINGOFF_STATE:
 		cancel_delayed_work(&p_slot->work);
-		/* fall through */
+		fallthrough;
 	case STATIC_STATE:
 		p_slot->state = POWEROFF_STATE;
 		mutex_unlock(&p_slot->lock);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 45c51aff9c03..b02c5e6f5b67 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -922,7 +922,7 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
 		if ((pmcsr & PCI_PM_CTRL_STATE_MASK) == PCI_D3hot
 		 && !(pmcsr & PCI_PM_CTRL_NO_SOFT_RESET))
 			need_restore = true;
-		/* Fall-through - force to D0 */
+		fallthrough;	/* force to D0 */
 	default:
 		pmcsr = 0;
 		break;
@@ -2406,7 +2406,7 @@ static pci_power_t pci_target_state(struct pci_dev *dev, bool wakeup)
 		case PCI_D2:
 			if (pci_no_d1d2(dev))
 				break;
-			/* else, fall through */
+			fallthrough;
 		default:
 			target_state = state;
 		}
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index bd2b691fa7a3..d35186b01d98 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -231,7 +231,7 @@ static long proc_bus_pci_ioctl(struct file *file, unsigned int cmd,
 		}
 		/* If arch decided it can't, fall through... */
 #endif /* HAVE_PCI_MMAP */
-		/* fall through */
+		fallthrough;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 9d7a43261613..0f18237e57a8 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1730,7 +1730,7 @@ static void quirk_jmicron_ata(struct pci_dev *pdev)
 	case PCI_DEVICE_ID_JMICRON_JMB366:
 		/* Redirect IDE second PATA port to the right spot */
 		conf5 |= (1 << 24);
-		/* Fall through */
+		fallthrough;
 	case PCI_DEVICE_ID_JMICRON_JMB361:
 	case PCI_DEVICE_ID_JMICRON_JMB363:
 	case PCI_DEVICE_ID_JMICRON_JMB369:
@@ -2224,7 +2224,7 @@ static void quirk_netmos(struct pci_dev *dev)
 		if (dev->subsystem_vendor == PCI_VENDOR_ID_IBM &&
 				dev->subsystem_device == 0x0299)
 			return;
-		/* else, fall through */
+		fallthrough;
 	case PCI_DEVICE_ID_NETMOS_9735:
 	case PCI_DEVICE_ID_NETMOS_9745:
 	case PCI_DEVICE_ID_NETMOS_9845:
diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 9b94b1f16d80..bd04a6a916d4 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1252,7 +1252,7 @@ void __pci_bus_size_bridges(struct pci_bus *bus, struct list_head *realloc_head)
 			additional_mmio_size = pci_hotplug_mmio_size;
 			additional_mmio_pref_size = pci_hotplug_mmio_pref_size;
 		}
-		/* Fall through */
+		fallthrough;
 	default:
 		pbus_size_io(bus, realloc_head ? 0 : additional_io_size,
 			     additional_io_size, realloc_head);
-- 
2.27.0

