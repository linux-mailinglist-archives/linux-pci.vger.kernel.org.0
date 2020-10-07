Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D69285E38
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 13:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgJGLeP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 07:34:15 -0400
Received: from mga06.intel.com ([134.134.136.31]:24771 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727591AbgJGLdg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Oct 2020 07:33:36 -0400
IronPort-SDR: GUMT6fxF4Av/dxPSvSejLBBuTchjFp1hVXvJjnk5i0S8mwfbgu1ZSrhrse+LeW3cWuN6ZaD5CR
 g5uLZnneDQUg==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="226492550"
X-IronPort-AV: E=Sophos;i="5.77,346,1596524400"; 
   d="scan'208";a="226492550"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2020 04:33:35 -0700
IronPort-SDR: L2qYYc5bMC9NDKNqSHHmQlARqs/UWhYihe6yJ9CPNkod0/oaNlh3IwzJTuBALN8knq4tyjrrn5
 oUWdD4ZyOj3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,346,1596524400"; 
   d="scan'208";a="354862135"
Received: from shskylake.sh.intel.com ([10.239.48.137])
  by orsmga007.jf.intel.com with ESMTP; 07 Oct 2020 04:33:32 -0700
From:   Ethan Zhao <haifeng.zhao@intel.com>
To:     bhelgaas@google.com, oohall@gmail.com, ruscur@russell.cc,
        lukas@wunner.de, andriy.shevchenko@linux.intel.com,
        stuart.w.hayes@gmail.com, mr.nuke.me@gmail.com,
        mika.westerberg@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@linux.intel.com, sathyanarayanan.kuppuswamy@intel.com,
        xerces.zhao@gmail.com, Ethan Zhao <haifeng.zhao@intel.com>
Subject: [PATCH v8 2/6] PCI/DPC: define a function to check and wait till port finish DPC handling
Date:   Wed,  7 Oct 2020 07:31:54 -0400
Message-Id: <20201007113158.48933-3-haifeng.zhao@intel.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201007113158.48933-1-haifeng.zhao@intel.com>
References: <20201007113158.48933-1-haifeng.zhao@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=a
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
 v7: no change.
 v8: no change.

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

