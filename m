Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 69B1D85093
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2019 18:04:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbfHGQD4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 7 Aug 2019 12:03:56 -0400
Received: from mga12.intel.com ([192.55.52.136]:61443 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbfHGQDz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 7 Aug 2019 12:03:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2019 09:03:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,357,1559545200"; 
   d="scan'208";a="174545129"
Received: from irsmsx154.ger.corp.intel.com ([163.33.192.96])
  by fmsmga008.fm.intel.com with ESMTP; 07 Aug 2019 09:03:53 -0700
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.88]) by
 IRSMSX154.ger.corp.intel.com ([169.254.12.160]) with mapi id 14.03.0439.000;
 Wed, 7 Aug 2019 17:03:52 +0100
From:   "Patel, Mayurkumar" <mayurkumar.patel@intel.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC:     "Busch, Keith" <keith.busch@intel.com>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v2] PCI/AER: Save and restore AER config state
Thread-Topic: [PATCH v2] PCI/AER: Save and restore AER config state
Thread-Index: AdVNNOxDeM4PdfoxRxylrjXnbDircw==
Date:   Wed, 7 Aug 2019 16:03:52 +0000
Message-ID: <92EBB4272BF81E4089A7126EC1E7B28479A895C7@IRSMSX101.ger.corp.intel.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMDVkMGUxNjAtZjk5My00YTQwLTkwYmMtNWFiMzU5Zjk1MzUyIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSDVOS1wvTENDVnJXbVA0TG0zWDZWXC9HTHhpdEpRa1Y0RlRUNnVJRXhuZ24rNFVVVE1uNG9jQytzNnNSQTJMbTlDIn0=
x-ctpclassification: CTP_NT
x-originating-ip: [163.33.239.182]
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
---
 drivers/pci/pci.c      |  2 ++
 drivers/pci/pcie/aer.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/aer.h    |  4 +++
 3 files changed, 76 insertions(+)

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
index b45bc47..fb067dc 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -448,6 +448,64 @@ int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
 	return 0;
 }
 
+static inline bool pcie_aer_cap_has_root_command(struct pci_dev *dev)
+{
+	return pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
+		pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC;
+}
+
+void pci_save_aer_state(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state;
+	u32 *cap;
+	int pos;
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
+	pci_read_config_dword(dev, pos + PCI_ERR_CAP, cap++);
+	if (pcie_aer_cap_has_root_command(dev))
+		pci_read_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, cap++);
+}
+
+void pci_restore_aer_state(struct pci_dev *dev)
+{
+	struct pci_cap_saved_state *save_state;
+	u32 *cap;
+	int pos;
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
+	pci_write_config_dword(dev, pos + PCI_ERR_CAP, *cap++);
+	if (pcie_aer_cap_has_root_command(dev))
+		pci_write_config_dword(dev, pos + PCI_ERR_ROOT_COMMAND, *cap++);
+}
+
 void pci_aer_init(struct pci_dev *dev)
 {
 	dev->aer_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
@@ -455,6 +513,18 @@ void pci_aer_init(struct pci_dev *dev)
 	if (dev->aer_cap)
 		dev->aer_stats = kzalloc(sizeof(struct aer_stats), GFP_KERNEL);
 
+	/*
+	 * Since PCI_ERR_ROOT_COMMAND is only valid for root port and root
+	 * complex event collector, as per PCIe 4.0 section 7.8.4, interpret
+	 * the device/port type to determine the availability of additional
+	 * root port and root complex event collector register.
+	 */
+	if (pcie_aer_cap_has_root_command(dev))
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

