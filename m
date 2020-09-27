Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B042279E69
	for <lists+linux-pci@lfdr.de>; Sun, 27 Sep 2020 07:30:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbgI0FaT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 01:30:19 -0400
Received: from mga07.intel.com ([134.134.136.100]:23634 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726478AbgI0FaT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 27 Sep 2020 01:30:19 -0400
IronPort-SDR: iXRjaFxMCts+zb+4vi/rfN5RdHhcXNE5ZRIDhYaZsvS0FYdeu4t4ZtJ+pHsCXM2KVHP7xE1rBz
 4iVNBIba/DJg==
X-IronPort-AV: E=McAfee;i="6000,8403,9756"; a="225993130"
X-IronPort-AV: E=Sophos;i="5.77,308,1596524400"; 
   d="scan'208";a="225993130"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2020 22:30:18 -0700
IronPort-SDR: lwe9O8A/DcJFUChqzqo4COzMhjKnNj8pXL5qeArEGt4BbghcEeHLRf7jAXVfvDS7Einalw6MWK
 T2nkTDWvgufA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,308,1596524400"; 
   d="scan'208";a="323909336"
Received: from shskylake.sh.intel.com ([10.239.48.137])
  by orsmga002.jf.intel.com with ESMTP; 26 Sep 2020 22:30:15 -0700
From:   Ethan Zhao <haifeng.zhao@intel.com>
To:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        lukas@wunner.de, andriy.shevchenko@linux.intel.com,
        stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        mika.westerberg@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        pei.p.jia@intel.com, ashok.raj@linux.intel.com,
        sathyanarayanan.kuppuswamy@intel.com,
        Ethan Zhao <haifeng.zhao@intel.com>
Subject: [PATCH 1/5 V3] PCI: define a function to check and wait till port finish DPC handling
Date:   Sun, 27 Sep 2020 01:28:37 -0400
Message-Id: <20200927052841.12629-2-haifeng.zhao@intel.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200927052841.12629-1-haifeng.zhao@intel.com>
References: <20200927052841.12629-1-haifeng.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Once root port DPC capability is enabled and triggered, at the beginning
of DPC is triggered, the DPC status bits are set by hardware and then
sends DPC/DLLSC/PDC interrupts to OS DPC and pciehp drivers, it will
take the port and software DPC interrupt handler 10ms to 50ms (test data
on ICS(Ice Lake SP platform, see
https://en.wikichip.org/wiki/intel/microarchitectures/ice_lake_(server)
& stable 5.9-rc6) to complete the DPC containment procedure
till the DPC status is cleared at the end of the DPC interrupt handler.

We use this function to check if the root port is in DPC handling status
and wait till the hardware and software completed the procedure.

Signed-off-by: Ethan Zhao <haifeng.zhao@intel.com>
Tested-by: Wen Jin <wen.jin@intel.com>
Tested-by: Shanshan Zhang <ShanshanX.Zhang@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
changes:
 V2：align ICS code name to public doc.
 V3: no change. 
 include/linux/pci.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/pci.h b/include/linux/pci.h
index 835530605c0d..5beb76c6ae26 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -38,6 +38,7 @@
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/resource_ext.h>
+#include <linux/delay.h>
 #include <uapi/linux/pci.h>
 
 #include <linux/pci_ids.h>
@@ -2427,4 +2428,34 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 	WARN_ONCE(condition, "%s %s: " fmt, \
 		  dev_driver_string(&(pdev)->dev), pci_name(pdev), ##arg)
 
+#ifdef CONFIG_PCIE_DPC
+static inline bool pci_wait_port_outdpc(struct pci_dev *pdev)
+{
+	u16 cap = pdev->dpc_cap, status;
+	u16 loop = 0;
+
+	if (!cap) {
+		pci_WARN_ONCE(pdev, !cap, "No DPC capability initiated\n");
+		return false;
+	}
+	pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
+	pci_dbg(pdev, "DPC status %x, cap %x\n", status, cap);
+	while (status & PCI_EXP_DPC_STATUS_TRIGGER && loop < 100) {
+		msleep(10);
+		loop++;
+		pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
+	}
+	if (!(status & PCI_EXP_DPC_STATUS_TRIGGER)) {
+		pci_dbg(pdev, "Out of DPC %x, cost %d ms\n", status, loop*10);
+		return true;
+	}
+	pci_dbg(pdev, "Timeout to wait port out of DPC status\n");
+	return false;
+}
+#else
+static inline bool pci_wait_port_outdpc(struct pci_dev *pdev)
+{
+	return true;
+}
+#endif
 #endif /* LINUX_PCI_H */
-- 
2.18.4

