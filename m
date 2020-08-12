Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CBFA242DA0
	for <lists+linux-pci@lfdr.de>; Wed, 12 Aug 2020 18:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726937AbgHLQsD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Aug 2020 12:48:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:33836 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726447AbgHLQrL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Aug 2020 12:47:11 -0400
IronPort-SDR: DDvCsuyrDAHsp3AgejIwAh++IT1Af/sWm/PQ/PnOU03O4WHIeRxp9427jEgCCZ7paZyOGAypIe
 PU6GQkWGfAjg==
X-IronPort-AV: E=McAfee;i="6000,8403,9711"; a="133538449"
X-IronPort-AV: E=Sophos;i="5.76,305,1592895600"; 
   d="scan'208";a="133538449"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 09:47:11 -0700
IronPort-SDR: OHDl33/J5XLHhhmwvj6D63wmC3Pef4NnvhAPqxgkdg/LIEyQHFzLSC/Y9ZV3JEwhHpJmHgxO+i
 Px9unan06c4Q==
X-IronPort-AV: E=Sophos;i="5.76,305,1592895600"; 
   d="scan'208";a="439442647"
Received: from ticede-or-099.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.254.58.97])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 09:47:10 -0700
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v3 04/10] PCI/RCEC: Add pcie_walk_rcec() to walk associated RCiEPs
Date:   Wed, 12 Aug 2020 09:46:53 -0700
Message-Id: <20200812164659.1118946-5-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812164659.1118946-1-sean.v.kelley@intel.com>
References: <20200812164659.1118946-1-sean.v.kelley@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

When an RCEC device signals error(s) to a CPU core, the CPU core
needs to walk all the RCiEPs associated with that RCEC to check
errors. So add the function pcie_walk_rcec() to walk all RCiEPs
associated with the RCEC device.

Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pci.h       |  4 +++
 drivers/pci/pcie/rcec.c | 76 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index bd25e6047b54..8bd7528d6977 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -473,9 +473,13 @@ static inline void pci_dpc_init(struct pci_dev *pdev) {}
 #ifdef CONFIG_PCIEPORTBUS
 void pci_rcec_init(struct pci_dev *dev);
 void pci_rcec_exit(struct pci_dev *dev);
+void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
+		    void *userdata);
 #else
 static inline void pci_rcec_init(struct pci_dev *dev) {}
 static inline void pci_rcec_exit(struct pci_dev *dev) {}
+static inline void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
+				  void *userdata) {}
 #endif
 
 #ifdef CONFIG_PCI_ATS
diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
index 519ae086ff41..405f92fcdf7f 100644
--- a/drivers/pci/pcie/rcec.c
+++ b/drivers/pci/pcie/rcec.c
@@ -17,6 +17,82 @@
 
 #include "../pci.h"
 
+static int pcie_walk_rciep_devfn(struct pci_bus *bus, int (*cb)(struct pci_dev *, void *),
+				 void *userdata, const unsigned long bitmap)
+{
+	unsigned int devn, fn;
+	struct pci_dev *dev;
+	int retval;
+
+	for_each_set_bit(devn, &bitmap, 32) {
+		for (fn = 0; fn < 8; fn++) {
+			dev = pci_get_slot(bus, PCI_DEVFN(devn, fn));
+
+			if (!dev)
+				continue;
+
+			if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_END) {
+				pci_dev_put(dev);
+				continue;
+			}
+
+			retval = cb(dev, userdata);
+			pci_dev_put(dev);
+			if (retval)
+				return retval;
+		}
+	}
+
+	return 0;
+}
+
+/**
+ * pcie_walk_rcec - Walk RCiEP devices associating with RCEC and call callback.
+ * @rcec     RCEC whose RCiEP devices should be walked.
+ * @cb       Callback to be called for each RCiEP device found.
+ * @userdata Arbitrary pointer to be passed to callback.
+ *
+ * Walk the given RCEC. Call the provided callback on each RCiEP device found.
+ *
+ * We check the return of @cb each time. If it returns anything
+ * other than 0, we break out.
+ */
+void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
+		    void *userdata)
+{
+	u8 nextbusn, lastbusn;
+	struct pci_bus *bus;
+	unsigned int bnr;
+
+	if (!rcec->rcec_cap)
+		return;
+
+	/* Find RCiEP devices on the same bus as the RCEC */
+	if (pcie_walk_rciep_devfn(rcec->bus, cb, userdata, rcec->rcec_ext->bitmap))
+		return;
+
+	/* Check whether RCEC BUSN register is present */
+	if (rcec->rcec_ext->ver < PCI_RCEC_BUSN_REG_VER)
+		return;
+
+	nextbusn = rcec->rcec_ext->nextbusn;
+	lastbusn = rcec->rcec_ext->lastbusn;
+
+	/* All RCiEP devices are on the same bus as the RCEC */
+	if (nextbusn == 0xff && lastbusn == 0x00)
+		return;
+
+	for (bnr = nextbusn; bnr <= lastbusn; bnr++) {
+		bus = pci_find_bus(pci_domain_nr(rcec->bus), bnr);
+		if (!bus)
+			continue;
+
+		/* Find RCiEP devices on the given bus */
+		if (pcie_walk_rciep_devfn(bus, cb, userdata, 0xffffffff))
+			return;
+	}
+}
+
 void pci_rcec_init(struct pci_dev *dev)
 {
 	u32 rcec, hdr, busn;
-- 
2.28.0

