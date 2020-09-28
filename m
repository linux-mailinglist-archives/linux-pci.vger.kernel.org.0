Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A498E27A614
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 06:08:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbgI1EI2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Sep 2020 00:08:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:30276 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbgI1EI1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Sep 2020 00:08:27 -0400
IronPort-SDR: wRDBwBBX99j+Q1ERbJr4dfJVh7hgGG8pAQ4wTuvxdp37xjImcXJ6lhZSjeaZiKnhgRvdF1FXKO
 5bvT6vj/DAsA==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="149710883"
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="149710883"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 21:08:27 -0700
IronPort-SDR: /dR6Zsvn4ZqhrX64qoZxy7osbDuMI+x74QV0Z51ZhpO1VMycux+C5qZyKDYh07MBjK8qiQL6VG
 HGp4ICIdAAog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="311628137"
Received: from shskylake.sh.intel.com ([10.239.48.137])
  by orsmga006.jf.intel.com with ESMTP; 27 Sep 2020 21:08:24 -0700
From:   Ethan Zhao <haifeng.zhao@intel.com>
To:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        lukas@wunner.de, andriy.shevchenko@linux.intel.com,
        stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        mika.westerberg@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        pei.p.jia@intel.com, ashok.raj@linux.intel.com,
        sathyanarayanan.kuppuswamy@intel.com,
        Ethan Zhao <haifeng.zhao@intel.com>
Subject: [PATCH 1/5 V5] PCI: define a function to check and wait till port finish DPC handling
Date:   Mon, 28 Sep 2020 00:06:47 -0400
Message-Id: <20200928040651.24937-2-haifeng.zhao@intel.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200928040651.24937-1-haifeng.zhao@intel.com>
References: <20200928040651.24937-1-haifeng.zhao@intel.com>
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
 V2：align ICS code name to public doc.
 V3: no change.
 V4: response to Christoph's (Christoph Hellwig <hch@infradead.org>) 
     tip, move pci_wait_port_outdpc() to DPC driver and its declaration
     to pci.h.
 V5: fix building issue reported by lkp@intel.com with some config.

 drivers/pci/pci.h      |  2 ++
 drivers/pci/pcie/dpc.c | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fa12f7cbc1a0..8fdb0d823d5a 100644
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

