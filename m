Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50A0227E1FC
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 09:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgI3HHk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 03:07:40 -0400
Received: from mga07.intel.com ([134.134.136.100]:34468 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725776AbgI3HHf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 30 Sep 2020 03:07:35 -0400
IronPort-SDR: 2tWKRErBXi8UoiaxPpiDyExKrxt1Zaz6IgVA35KB0oFdXXzELYDJkdVPGSFfG72NWaMgKnuxUJ
 0X0anr+eUs6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9759"; a="226533023"
X-IronPort-AV: E=Sophos;i="5.77,321,1596524400"; 
   d="scan'208";a="226533023"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 00:07:34 -0700
IronPort-SDR: hBil8tgki7BrlZ13zRMXT4C7feoRFMCrWLDNbd74G118uXSIYgCWGIhBIn9n4YpUdPPwQh8/+c
 37zflYtIo5QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,321,1596524400"; 
   d="scan'208";a="496013499"
Received: from shskylake.sh.intel.com ([10.239.48.137])
  by orsmga005.jf.intel.com with ESMTP; 30 Sep 2020 00:07:29 -0700
From:   Ethan Zhao <haifeng.zhao@intel.com>
To:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        lukas@wunner.de, andriy.shevchenko@linux.intel.com,
        stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        mika.westerberg@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@linux.intel.com, sathyanarayanan.kuppuswamy@intel.com,
        xerces.zhao@gmail.com, Ethan Zhao <haifeng.zhao@intel.com>
Subject: [PATCH v6 2/5] PCI/DPC: define a function to check and wait till port finish DPC handling
Date:   Wed, 30 Sep 2020 03:05:34 -0400
Message-Id: <20200930070537.30982-3-haifeng.zhao@intel.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200930070537.30982-1-haifeng.zhao@intel.com>
References: <20200930070537.30982-1-haifeng.zhao@intel.com>
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
---
changes:
 v2：align ICS code name to public doc.
 v3: no change.
 v4: response to Christoph's (Christoph Hellwig <hch@infradead.org>)
     tip, move pci_wait_port_outdpc() to DPC driver and its declaration
     to pci.h.
 v5: fix building issue reported by lkp@intel.com with some config.
 v6: move from [1/5] to [2/5].

 drivers/pci/pci.h      |  2 ++
 drivers/pci/pcie/dpc.c | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fa12f7cbc1a0..455b32187abd 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -455,10 +455,12 @@ void pci_restore_dpc_state(struct pci_dev *dev);
 void pci_dpc_init(struct pci_dev *pdev);
 void dpc_process_error(struct pci_dev *pdev);
 pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
+bool pci_wait_port_outdpc(struct pci_dev *pdev);
 #else
 static inline void pci_save_dpc_state(struct pci_dev *dev) {}
 static inline void pci_restore_dpc_state(struct pci_dev *dev) {}
 static inline void pci_dpc_init(struct pci_dev *pdev) {}
+static inline bool pci_wait_port_outdpc(struct pci_dev *pdev) { return false; }
 #endif
 
 #ifdef CONFIG_PCI_ATS
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index daa9a4153776..2e0e091ce923 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -71,6 +71,33 @@ void pci_restore_dpc_state(struct pci_dev *dev)
 	pci_write_config_word(dev, dev->dpc_cap + PCI_EXP_DPC_CTL, *cap);
 }
 
+bool pci_wait_port_outdpc(struct pci_dev *pdev)
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
+
+	while (status & PCI_EXP_DPC_STATUS_TRIGGER && loop < 100) {
+		msleep(10);
+		loop++;
+		pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
+	}
+
+	if (!(status & PCI_EXP_DPC_STATUS_TRIGGER)) {
+		pci_dbg(pdev, "Out of DPC %x, cost %d ms\n", status, loop*10);
+		return true;
+	}
+
+	pci_dbg(pdev, "Timeout to wait port out of DPC status\n");
+	return false;
+}
+
 static int dpc_wait_rp_inactive(struct pci_dev *pdev)
 {
 	unsigned long timeout = jiffies + HZ;
-- 
2.18.4

