Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25F3222CC0A
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 19:23:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgGXRWh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 13:22:37 -0400
Received: from mga17.intel.com ([192.55.52.151]:2758 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726945AbgGXRWg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Jul 2020 13:22:36 -0400
IronPort-SDR: q7j9iovf8o871WFyEb8XkwUuIu1Q+3Y5/7zrCyfapxXkuj0xQbSlJVhZOupG4gDItd9IhCFZXV
 FJ/dSthYtcew==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="130823256"
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="130823256"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 10:22:35 -0700
IronPort-SDR: PHX01Lbd5BMqWA0B5spsJLegLotH/C7UAvPrg5Bh6PPB0lK2TuebNZjyVNoVCZZOdZmi/96Btr
 g8KyBLeP6/Qw==
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="302730288"
Received: from seokjaeb-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.254.24.239])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 10:22:34 -0700
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@kernel.org, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [RFC PATCH 3/9] PCI/portdrv: Add pcie_walk_rcec() to walk RCiEPs associated with RCEC
Date:   Fri, 24 Jul 2020 10:22:17 -0700
Message-Id: <20200724172223.145608-4-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200724172223.145608-1-sean.v.kelley@intel.com>
References: <20200724172223.145608-1-sean.v.kelley@intel.com>
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
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
---
 drivers/pci/pcie/portdrv.h      |  2 +
 drivers/pci/pcie/portdrv_core.c | 82 +++++++++++++++++++++++++++++++++
 2 files changed, 84 insertions(+)

diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index af7cf237432a..c11d5ecbad76 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -116,6 +116,8 @@ void pcie_port_service_unregister(struct pcie_port_service_driver *new);
 
 extern struct bus_type pcie_port_bus_type;
 int pcie_port_device_register(struct pci_dev *dev);
+void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
+		    void *userdata);
 #ifdef CONFIG_PM
 int pcie_port_device_suspend(struct device *dev);
 int pcie_port_device_resume_noirq(struct device *dev);
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 50a9522ab07d..bdcbb34764c2 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -14,6 +14,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/string.h>
 #include <linux/slab.h>
+#include <linux/bitops.h>
 #include <linux/aer.h>
 
 #include "../pci.h"
@@ -365,6 +366,87 @@ int pcie_port_device_register(struct pci_dev *dev)
 	return status;
 }
 
+static int pcie_walk_rciep_devfn(struct pci_bus *pbus, int (*cb)(struct pci_dev *, void *),
+				 void *userdata, unsigned long bitmap)
+{
+	unsigned int dev, fn;
+	struct pci_dev *pdev;
+	int retval;
+
+	for_each_set_bit(dev, &bitmap, 32) {
+		for (fn = 0; fn < 8; fn++) {
+			pdev = pci_get_slot(pbus, PCI_DEVFN(dev, fn));
+
+			if (!pdev || pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_END)
+				continue;
+
+			retval = cb(pdev, userdata);
+			if (retval)
+				return retval;
+		}
+	}
+
+	return 0;
+}
+
+/** pcie_walk_rcec - Walk RCiEP devices associating with RCEC and call callback.
+ *  @rcec     RCEC whose RCiEP devices should be walked.
+ *  @cb       Callback to be called for each RCiEP device found.
+ *  @userdata Arbitrary pointer to be passed to callback.
+ *
+ *  Walk the given RCEC. Call the provided callback on each RCiEP device found.
+ *
+ *  We check the return of @cb each time. If it returns anything
+ *  other than 0, we break out.
+ *
+ */
+void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
+		    void *userdata)
+{
+	u32 pos, bitmap, hdr, busn;
+	u8 ver, nextbusn, lastbusn;
+	struct pci_bus *pbus;
+	unsigned int bnr;
+
+	pos = pci_find_ext_capability(rcec, PCI_EXT_CAP_ID_RCEC);
+	if (!pos)
+		return;
+
+	pbus = pci_find_bus(pci_domain_nr(rcec->bus), rcec->bus->number);
+	if (!pbus)
+		return;
+
+	pci_read_config_dword(rcec, pos + PCI_RCEC_RCIEP_BITMAP, &bitmap);
+
+	/* Find RCiEP devices on the same bus as the RCEC */
+	if (pcie_walk_rciep_devfn(pbus, cb, userdata, (unsigned long)bitmap))
+		return;
+
+	/* Check whether RCEC BUSN register is present */
+	pci_read_config_dword(rcec, pos, &hdr);
+	ver = PCI_EXT_CAP_VER(hdr);
+	if (ver < PCI_RCEC_BUSN_REG_VER)
+		return;
+
+	pci_read_config_dword(rcec, pos + PCI_RCEC_BUSN, &busn);
+	nextbusn = PCI_RCEC_BUSN_NEXT(busn);
+	lastbusn = PCI_RCEC_BUSN_LAST(busn);
+
+	/* All RCiEP devices are on the same bus as the RCEC */
+	if (nextbusn == 0xff && lastbusn == 0x00)
+		return;
+
+	for (bnr = nextbusn; bnr < (lastbusn + 1); bnr++) {
+		pbus = pci_find_bus(pci_domain_nr(rcec->bus), bnr);
+		if (!pbus)
+			continue;
+
+		/* Find RCiEP devices on the given bus */
+		if (pcie_walk_rciep_devfn(pbus, cb, userdata, 0xffffffff))
+			return;
+	}
+}
+
 #ifdef CONFIG_PM
 typedef int (*pcie_pm_callback_t)(struct pcie_device *);
 
-- 
2.27.0

