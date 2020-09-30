Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCFE27E1FF
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 09:07:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728310AbgI3HHk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 03:07:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:34486 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728289AbgI3HHk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Sep 2020 03:07:40 -0400
IronPort-SDR: nWdrddDvBXe1rBNEm1+ZsgbC6/4QALVmBX68uCoHxrYHUgxlfyBEWK9JfwaGlHb1ollfg34GvE
 QwhJ1f8cbnbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="226533035"
X-IronPort-AV: E=Sophos;i="5.77,321,1596524400"; 
   d="scan'208";a="226533035"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 00:07:39 -0700
IronPort-SDR: Cp7pasQhjZ/vyF5yUd91vW0fcLt5NS3xyxq0SRkPj0p1erFt7IwSjssvRUkJy3ipKKF1S+geNe
 Od0Y8v/YJwfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,321,1596524400"; 
   d="scan'208";a="496013739"
Received: from shskylake.sh.intel.com ([10.239.48.137])
  by orsmga005.jf.intel.com with ESMTP; 30 Sep 2020 00:07:35 -0700
From:   Ethan Zhao <haifeng.zhao@intel.com>
To:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        lukas@wunner.de, andriy.shevchenko@linux.intel.com,
        stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        mika.westerberg@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@linux.intel.com, sathyanarayanan.kuppuswamy@intel.com,
        xerces.zhao@gmail.com, Ethan Zhao <haifeng.zhao@intel.com>
Subject: [PATCH v6 3/5] PCI: pciehp: check and wait port status out of DPC before handling DLLSC and PDC
Date:   Wed, 30 Sep 2020 03:05:35 -0400
Message-Id: <20200930070537.30982-4-haifeng.zhao@intel.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200930070537.30982-1-haifeng.zhao@intel.com>
References: <20200930070537.30982-1-haifeng.zhao@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When root port has DPC capability and it is enabled, then triggered by
errors, DPC DLLSC and PDC etc interrupts will be sent to DPC driver, pciehp
drivers almost at the same time.
That will cause following messed and confused errors handling/recovery/
removal/plugin procedure.

1. Port and device are in error recovery resetting initiated by DPC
   hardware, pciehp driver treats them as device is doing hot-remove or
   hot-plugin the same time.

2. While DPC handler calling device driver->err_handler callback(
   error_detected/resume etc), but the slot may be powered off by

   pciehp
   -> remove_board()
      -> pciehp_power_off_slot().

3. While DPC handler -> pci_do_recovery is doing different action to detect
   error and recover based on device->error_state, pciehp driver could
   change it on the fly by:

   pciehp_unconfigure_device()
   ->pci_walk_bus()
     -> pci_dev_set_disconnected()

4. While DPC handler is calling device driver err_handler callback to
   detect error and recover, pciehp driver could is doing device unbind and
   release its driver.

   ...

While NON-FATAL/FATAL errors happen while hotplug is(is not)doing, result
is not determinate.

So we need some kind of synchronization between pciehp DLLSC/PDC handling
and DPC driver error recover handling.  we need a determinate result
of DPC error containment, link is recovered, link isn't recovered, device
is still there, device is removed, then do pciehp hot-remove and hot-plugin
procudure, don't mix them together.

Per our test on ICS platform, DPC error containment and software handler
will take 10ms up to 50ms till clean the DPC triggered status. it is quick
enough for pciehp compared with its 1000ms waiting to ignore DLLSC/PDC
after doing power off.

With this patch, the handling flow of DPC containment and hotplug is
partly ordered and serialized, let hardware DPC do the controller reset
etc recovery action first, then DPC driver handling the call-back from
device drivers, clear the DPC status, at the end, pciehp handle the DLLSC
and PDC etc.

After tens of PCIe Gen4 NVMe SSD brute force hot-remove and hot-plugin with
any time internval between the two actions, also stressed with the DPC
injection test. system recovered to normal working state from NON-FATAL/
FATAL errors as expected. hotplug works well without any random
undeterminate errors or malfunction.

Brute DPC error injection script:

for i in {0..100}
do
        setpci -s 64:02.0 0x196.w=000a
        setpci -s 65:00.0 0x04.w=0544
        mount /dev/nvme0n1p1 /root/nvme
        sleep 1
done

Signed-off-by: Ethan Zhao <haifeng.zhao@intel.com>
Tested-by: Wen Jin <wen.jin@intel.com>
Tested-by: Shanshan Zhang <ShanshanX.Zhang@intel.com>
---
Changes:
 v2: revise doc according to Andy's suggestion.
 v3: no change.
 v4: no change.
 v5: no change.
 v6: moved to [3/5] from [2/5] and re-wrote description.

 drivers/pci/hotplug/pciehp_hpc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 53433b37e181..6f271160f18d 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -710,8 +710,10 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	down_read(&ctrl->reset_lock);
 	if (events & DISABLE_SLOT)
 		pciehp_handle_disable_request(ctrl);
-	else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC))
+	else if (events & (PCI_EXP_SLTSTA_PDC | PCI_EXP_SLTSTA_DLLSC)) {
+		pci_wait_port_outdpc(pdev);
 		pciehp_handle_presence_or_link_change(ctrl, events);
+	}
 	up_read(&ctrl->reset_lock);
 
 	ret = IRQ_HANDLED;
-- 
2.18.4

