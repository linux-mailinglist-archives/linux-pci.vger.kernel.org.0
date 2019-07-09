Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABE5263284
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2019 10:00:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725947AbfGIIA0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 9 Jul 2019 04:00:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:61477 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbfGIIA0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Jul 2019 04:00:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jul 2019 01:00:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,469,1557212400"; 
   d="scan'208";a="156103343"
Received: from irsmsx104.ger.corp.intel.com ([163.33.3.159])
  by orsmga007.jf.intel.com with ESMTP; 09 Jul 2019 01:00:24 -0700
Received: from irsmsx111.ger.corp.intel.com (10.108.20.4) by
 IRSMSX104.ger.corp.intel.com (163.33.3.159) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 9 Jul 2019 09:00:23 +0100
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.88]) by
 irsmsx111.ger.corp.intel.com ([169.254.2.65]) with mapi id 14.03.0439.000;
 Tue, 9 Jul 2019 09:00:23 +0100
From:   "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        'Bjorn Helgaas' <helgaas@kernel.org>
CC:     "Patel, Mayurkumar" <mayurkumar.patel@intel.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "'Andy Shevchenko'" <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] PCI/AER: save/restore AER registers during suspend/resume
Thread-Topic: [PATCH] PCI/AER: save/restore AER registers during
 suspend/resume
Thread-Index: AdU2K450PVQcsHkmQ527SJKW7Dkoyg==
Date:   Tue, 9 Jul 2019 08:00:22 +0000
Message-ID: <92EBB4272BF81E4089A7126EC1E7B28479A7F14D@IRSMSX101.ger.corp.intel.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMzFmOTg0NzktYWVhYy00MDJhLThmNzMtNDljZDI4NjU4ZTdkIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVVwvTEVmdGdcL00zb0RtcEc1SUpXdE0yK2g4WXhuSVVyTnBMZDFmZTh4TTA2MnZhRUg4c2N3U0Nmcmh2Wk5VZHJvIn0=
x-ctpclassification: CTP_NT
x-originating-ip: [163.33.239.181]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

After system suspend/resume cycle AER registers settings are
lost. Not restoring Root Error Command Register bits if it were
set, keeps AER interrupts disabled after system resume.
Moreover, AER mask and severity registers are also required
to be restored back to AER settings prior to system suspend.

Signed-off-by: Mayurkumar Patel <mayurkumar.patel@intel.com>
---
 drivers/pci/pci.c      |  2 ++
 drivers/pci/pcie/aer.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/aer.h    |  4 ++++
 3 files changed, 55 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 8abc843..40d5507 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1340,6 +1340,7 @@ int pci_save_state(struct pci_dev *dev)
 
 	pci_save_ltr_state(dev);
 	pci_save_dpc_state(dev);
+	pci_save_aer_state(dev);
 	return pci_save_vc_state(dev);
 }
 EXPORT_SYMBOL(pci_save_state);
@@ -1453,6 +1454,7 @@ void pci_restore_state(struct pci_dev *dev)
 	pci_restore_dpc_state(dev);
 
 	pci_cleanup_aer_error_status_regs(dev);
+	pci_restore_aer_state(dev);
 
 	pci_restore_config_space(dev);
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index b45bc47..1acc641 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -448,6 +448,54 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 	return 0;
 }
 
+void pci_save_aer_state(struct pci_dev *dev)
+{
+	int pos = 0;
+	struct pci_cap_saved_state *save_state;
+	u32 *cap;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ERR);
+	if (!save_state)
+		return;
+
+	pos = dev->aer_cap;
+	if (!pos)
+		return;
+
+	cap = &save_state->cap.data[0];
+	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, cap++);
+	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, cap++);
+	pci_read_config_dword(dev, pos + PCI_ERR_COR_MASK, cap++);
+	pci_read_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, cap++);
+}
+
+void pci_restore_aer_state(struct pci_dev *dev)
+{
+	int pos = 0;
+	struct pci_cap_saved_state *save_state;
+	u32 *cap;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ERR);
+	if (!save_state)
+		return;
+
+	pos = dev->aer_cap;
+	if (!pos)
+		return;
+
+	cap = &save_state->cap.data[0];
+	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, *cap++);
+	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, *cap++);
+	pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, *cap++);
+	pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, *cap++);
+}
+
 void pci_aer_init(struct pci_dev *dev)
 {
 	dev->aer_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
@@ -1396,6 +1444,7 @@ static int aer_probe(struct pcie_device *dev)
 		return status;
 	}
 
+	pci_add_ext_cap_save_buffer(port, PCI_EXT_CAP_ID_ERR, sizeof(u32) * 4);
 	aer_enable_rootport(rpc);
 	pci_info(port, "enabled with IRQ %d\n", dev->irq);
 	return 0;
diff --git a/include/linux/aer.h b/include/linux/aer.h
index 514bffa..fa19e01 100644
--- a/include/linux/aer.h
+++ b/include/linux/aer.h
@@ -46,6 +46,8 @@ int pci_enable_pcie_error_reporting(struct pci_dev *dev);
 int pci_disable_pcie_error_reporting(struct pci_dev *dev);
 int pci_cleanup_aer_uncorrect_error_status(struct pci_dev *dev);
 int pci_cleanup_aer_error_status_regs(struct pci_dev *dev);
+void pci_save_aer_state(struct pci_dev *dev);
+void pci_restore_aer_state(struct pci_dev *dev);
 #else
 static inline int pci_enable_pcie_error_reporting(struct pci_dev *dev)
 {
@@ -63,6 +65,8 @@ static inline int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 {
 	return -EINVAL;
 }
+static inline void pci_save_aer_state(struct pci_dev *dev) {}
+static inline void pci_restore_aer_state(struct pci_dev *dev) {}
 #endif
 
 void cper_print_aer(struct pci_dev *dev, int aer_severity,
-- 
2.7.4


Mayurkumar Patel
Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928



Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Gary Kershaw
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928

