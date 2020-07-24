Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5D6E22CC07
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jul 2020 19:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgGXRWo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jul 2020 13:22:44 -0400
Received: from mga17.intel.com ([192.55.52.151]:2758 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727058AbgGXRWn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Jul 2020 13:22:43 -0400
IronPort-SDR: Pzb2lPI3uk5qLODhRuILykcLU2WBiXEYdtVkiaVvCRWs4a5acj2krt4dkVVhs3bMPUXD3eyfBR
 Daam23T2BEGg==
X-IronPort-AV: E=McAfee;i="6000,8403,9692"; a="130823283"
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="130823283"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 10:22:43 -0700
IronPort-SDR: gNHtUNUSYjjBetjlgm0O99eR7Kp7sDxYf+dsaQIIpWb+/ysktxFqv52F5dPqw419Y6nLMY1WWg
 eFmfxGSnTN7A==
X-IronPort-AV: E=Sophos;i="5.75,391,1589266800"; 
   d="scan'208";a="302730330"
Received: from seokjaeb-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.254.24.239])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2020 10:22:42 -0700
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@kernel.org, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Subject: [RFC PATCH 7/9] PCI/AER: Add RCEC AER handling
Date:   Fri, 24 Jul 2020 10:22:21 -0700
Message-Id: <20200724172223.145608-8-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200724172223.145608-1-sean.v.kelley@intel.com>
References: <20200724172223.145608-1-sean.v.kelley@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Root Complex Event Collectors(RCEC) appear as peers to Root Ports
and also have the AER capability. So add RCEC support to the current AER
service driver and attach the AER service driver to the RCEC device.

Co-developed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/pci/pcie/aer.c | 34 +++++++++++++++++++++++++++-------
 1 file changed, 27 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index f1bf06be449e..7cc430c74c46 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -303,7 +303,7 @@ int pci_aer_raw_clear_status(struct pci_dev *dev)
 		return -EIO;
 
 	port_type = pci_pcie_type(dev);
-	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
+	if (port_type == PCI_EXP_TYPE_ROOT_PORT || port_type == PCI_EXP_TYPE_RC_EC) {
 		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &status);
 		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, status);
 	}
@@ -389,6 +389,12 @@ void pci_aer_init(struct pci_dev *dev)
 	pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ERR, sizeof(u32) * n);
 
 	pci_aer_clear_status(dev);
+
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) {
+		if (!pci_find_ext_capability(dev, PCI_EXT_CAP_ID_RCEC))
+			return;
+		pci_info(dev, "AER: RCEC CAP FOUND and cap_has_rtctl = %d\n", n);
+	}
 }
 
 void pci_aer_exit(struct pci_dev *dev)
@@ -577,7 +583,8 @@ static umode_t aer_stats_attrs_are_visible(struct kobject *kobj,
 	if ((a == &dev_attr_aer_rootport_total_err_cor.attr ||
 	     a == &dev_attr_aer_rootport_total_err_fatal.attr ||
 	     a == &dev_attr_aer_rootport_total_err_nonfatal.attr) &&
-	    pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT)
+	    ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
+	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_EC)))
 		return 0;
 
 	return a->mode;
@@ -894,7 +901,10 @@ static bool find_source_device(struct pci_dev *parent,
 	if (result)
 		return true;
 
-	pci_walk_bus(parent->subordinate, find_device_iter, e_info);
+	if (pci_pcie_type(parent) == PCI_EXP_TYPE_RC_EC)
+		pcie_walk_rcec(parent, find_device_iter, e_info);
+	else
+		pci_walk_bus(parent->subordinate, find_device_iter, e_info);
 
 	if (!e_info->error_dev_num) {
 		pci_info(parent, "can't find device of ID%04x\n", e_info->id);
@@ -1030,6 +1040,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 		if (!(info->status & ~info->mask))
 			return 0;
 	} else if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
+		   pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC ||
 	           pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
 		   info->severity == AER_NONFATAL) {
 
@@ -1182,6 +1193,8 @@ static int set_device_error_reporting(struct pci_dev *dev, void *data)
 	int type = pci_pcie_type(dev);
 
 	if ((type == PCI_EXP_TYPE_ROOT_PORT) ||
+	    (type == PCI_EXP_TYPE_RC_EC) ||
+	    (type == PCI_EXP_TYPE_RC_END) ||
 	    (type == PCI_EXP_TYPE_UPSTREAM) ||
 	    (type == PCI_EXP_TYPE_DOWNSTREAM)) {
 		if (enable)
@@ -1206,9 +1219,11 @@ static void set_downstream_devices_error_reporting(struct pci_dev *dev,
 {
 	set_device_error_reporting(dev, &enable);
 
-	if (!dev->subordinate)
-		return;
-	pci_walk_bus(dev->subordinate, set_device_error_reporting, &enable);
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
+		pcie_walk_rcec(dev, set_device_error_reporting, &enable);
+	else if (dev->subordinate)
+		pci_walk_bus(dev->subordinate, set_device_error_reporting, &enable);
+
 }
 
 /**
@@ -1306,6 +1321,11 @@ static int aer_probe(struct pcie_device *dev)
 	struct device *device = &dev->device;
 	struct pci_dev *port = dev->port;
 
+	/* Limit to Root Ports or Root Complex Event Collectors */
+	if ((pci_pcie_type(port) != PCI_EXP_TYPE_RC_EC) &&
+	    (pci_pcie_type(port) != PCI_EXP_TYPE_ROOT_PORT))
+		return -ENODEV;
+
 	rpc = devm_kzalloc(device, sizeof(struct aer_rpc), GFP_KERNEL);
 	if (!rpc)
 		return -ENOMEM;
@@ -1362,7 +1382,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 
 static struct pcie_port_service_driver aerdriver = {
 	.name		= "aer",
-	.port_type	= PCI_EXP_TYPE_ROOT_PORT,
+	.port_type	= PCIE_ANY_PORT,
 	.service	= PCIE_PORT_SERVICE_AER,
 
 	.probe		= aer_probe,
-- 
2.27.0

