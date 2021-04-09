Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AE4A35A835
	for <lists+linux-pci@lfdr.de>; Fri,  9 Apr 2021 23:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234082AbhDIVBl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Apr 2021 17:01:41 -0400
Received: from mga01.intel.com ([192.55.52.88]:30859 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233687AbhDIVAr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Apr 2021 17:00:47 -0400
IronPort-SDR: s/5N4BUxWsUhW5VfT2ap2G/OR8+rjYdrRxrCpzalwRmV/HHX1UchHlSeWaI7foAtMRTYmJung7
 4IERqYXWeGTw==
X-IronPort-AV: E=McAfee;i="6000,8403,9949"; a="214276873"
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="214276873"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 14:00:32 -0700
IronPort-SDR: Y9X7jdIsDnvDApXlSuNkDQfXkL4rbUW33/SbHkoqr7n5ufKGjDWvGPI/7b3v+sXLqF7Z8smAGH
 Pj/zg4Nk/LXA==
X-IronPort-AV: E=Sophos;i="5.82,210,1613462400"; 
   d="scan'208";a="520404463"
Received: from eakanoje-mobl.amr.corp.intel.com (HELO jderrick-mobl.amr.corp.intel.com) ([10.255.64.31])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2021 14:00:31 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH] PCI: pciehp: Ignore spurious link inactive change when off
Date:   Fri,  9 Apr 2021 14:59:35 -0600
Message-Id: <20210409205935.41881-1-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When a specific x8 CEM card is bifurcated into x4x4 mode, and the
upstream ports both support hotplugging on each respective x4 device, a
slot management system for the CEM card requires both x4 devices to be
sysfs removed from the OS before it can safely turn-off physical power.
The implications are that Slot Control will display Powered Off status
for the device where the device is actually powered until both ports
have powered off.

When power is removed from the first half, the link remains active to
provide clocking while waiting for the second half to have power
removed. When power is then removed from the second half, the first half
starts shutdown sequence and will trigger a link status change event.
This is misinterpreted as an enabling event due to positive presence
detect and causes the first half to be re-enabled.

The spurious enable can be resolved by ignoring link status change
events when no link is active when in the off state.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 529c34808440..a2c5eef03e7d 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -265,6 +265,11 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 		cancel_delayed_work(&ctrl->button_work);
 		fallthrough;
 	case OFF_STATE:
+		if ((events & PCI_EXP_SLTSTA_DLLSC) && !link_active) {
+			mutex_unlock(&ctrl->state_lock);
+			break;
+		}
+
 		ctrl->state = POWERON_STATE;
 		mutex_unlock(&ctrl->state_lock);
 		if (present)
-- 
2.26.2

