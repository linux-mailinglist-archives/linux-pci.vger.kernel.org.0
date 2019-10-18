Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 065DCDCBF1
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2019 18:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409016AbfJRQw3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 18 Oct 2019 12:52:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:39664 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390112AbfJRQw2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Oct 2019 12:52:28 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Oct 2019 09:52:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,312,1566889200"; 
   d="scan'208";a="226595379"
Received: from irsmsx103.ger.corp.intel.com ([163.33.3.157])
  by fmsmga002.fm.intel.com with ESMTP; 18 Oct 2019 09:52:23 -0700
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.76]) by
 IRSMSX103.ger.corp.intel.com ([169.254.3.139]) with mapi id 14.03.0439.000;
 Fri, 18 Oct 2019 17:52:22 +0100
From:   "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        "Busch, Keith" <keith.busch@intel.com>
Subject: [RESEND RESEND PATCH v3] PCI/AER: Save and restore AER config state
Thread-Topic: [RESEND RESEND PATCH v3] PCI/AER: Save and restore AER config
 state
Thread-Index: AdWF1EHos/8166j4QMWmCwTvC1xctw==
Date:   Fri, 18 Oct 2019 16:52:21 +0000
Message-ID: <92EBB4272BF81E4089A7126EC1E7B28492C3B007@IRSMSX101.ger.corp.intel.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTQ0NzAwMTktMzkxNC00MDYxLWI1OTktMDk2MWU2YThmYjAyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoibDJUbjk3WVBJTTBxN24zQWVKWm9aY3dYOGZJQ0tWbWdWWkZ0aGR2emVLa055SGdiMXlpYmVtTm91dFA0dWd3TyJ9
x-ctpclassification: CTP_NT
x-originating-ip: [163.33.239.180]
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch provides AER config save and restore capabilities. After system
resume AER config registers settings are lost. Not restoring AER root error
command register bits on root port if they were set, disables generation
of an AER interrupt reported by function as described in PCIe spec r4.0,
sec 7.8.4.9. Moreover, AER config mask, severity and ECRC registers are
also required to maintain same state prior to system suspend to maintain
AER interrupts behavior.

Signed-off-by: Mayurkumar Patel <mayurkumar.patel@intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/access.c   |  2 +-
 drivers/pci/pci.c      |  2 ++
 drivers/pci/pci.h      |  1 +
 drivers/pci/pcie/aer.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/aer.h    |  4 ++++
 5 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index 544922f..962295c 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -364,7 +364,7 @@ static inline bool pcie_cap_has_sltctl(const struct pci_dev *dev)
 	       pcie_caps_reg(dev) & PCI_EXP_FLAGS_SLOT;
 }
 
-static inline bool pcie_cap_has_rtctl(const struct pci_dev *dev)
+bool pcie_cap_has_rtctl(const struct pci_dev *dev)
 {
 	int type = pci_pcie_type(dev);
 
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
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9cb9938..268995b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -12,6 +12,7 @@ extern const unsigned char pcie_link_speed[];
 extern bool pci_early_dump;
 
 bool pcie_cap_has_lnkctl(const struct pci_dev *dev);
+bool pcie_cap_has_rtctl(const struct pci_dev *dev);
 
 /* Functions internal to the PCI core code */
 
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index b45bc47..7c41dec 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -448,6 +448,53 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 	return 0;
 }
 
+
+void pci_save_aer_state(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state;
+	u32 *cap;
+	int pos;
+
+	pos = dev->aer_cap;
+	if (!pos)
+		return;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ERR);
+	if (!save_state)
+		return;
+
+	cap = &save_state->cap.data[0];
+	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, cap++);
+	pci_read_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, cap++);
+	pci_read_config_dword(dev, pos + PCI_ERR_COR_MASK, cap++);
+	pci_read_config_dword(dev, pos + PCI_ERR_CAP, cap++);
+	if (pcie_cap_has_rtctl(dev))
+		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, cap++);
+}
+
+void pci_restore_aer_state(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state;
+	u32 *cap;
+	int pos;
+
+	pos = dev->aer_cap;
+	if (!pos)
+		return;
+
+	save_state = pci_find_saved_ext_cap(dev, PCI_EXT_CAP_ID_ERR);
+	if (!save_state)
+		return;
+
+	cap = &save_state->cap.data[0];
+	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_MASK, *cap++);
+	pci_write_config_dword(dev, pos + PCI_ERR_UNCOR_SEVER, *cap++);
+	pci_write_config_dword(dev, pos + PCI_ERR_COR_MASK, *cap++);
+	pci_write_config_dword(dev, pos + PCI_ERR_CAP, *cap++);
+	if (pcie_cap_has_rtctl(dev))
+		pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, *cap++);
+}
+
 void pci_aer_init(struct pci_dev *dev)
 {
 	dev->aer_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
@@ -455,6 +502,18 @@ void pci_aer_init(struct pci_dev *dev)
 	if (dev->aer_cap)
 		dev->aer_stats = kzalloc(sizeof(struct aer_stats), GFP_KERNEL);
 
+	/*
+	 * Since PCI_ERR_ROOT_COMMAND is only valid for root port and root
+	 * complex event collector, as per PCIe 4.0 section 7.8.4, interpret
+	 * the device/port type to determine the availability of additional
+	 * root port and root complex event collector register.
+	 */
+	if (pcie_cap_has_rtctl(dev))
+		pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ERR,
+					sizeof(u32) * 5);
+	else
+		pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ERR,
+					sizeof(u32) * 4);
 	pci_cleanup_aer_error_status_regs(dev);
 }
 
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



Intel Deutschland GmbH
Registered Address: Am Campeon 10-12, 85579 Neubiberg, Germany
Tel: +49 89 99 8853-0, www.intel.de
Managing Directors: Christin Eisenschmid, Gary Kershaw
Chairperson of the Supervisory Board: Nicole Lau
Registered Office: Munich
Commercial Register: Amtsgericht Muenchen HRB 186928

