Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0F002BBAA2
	for <lists+linux-pci@lfdr.de>; Sat, 21 Nov 2020 01:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728698AbgKUAKp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 19:10:45 -0500
Received: from mga02.intel.com ([134.134.136.20]:34300 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728641AbgKUAKo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Nov 2020 19:10:44 -0500
IronPort-SDR: bmNcJlWjK35OuXUpyOF9i0LzzC5AQCWEPlIM5VwURg6CK44cvp4VRNqiClzrBTIFKf6mkaCkce
 9/+Qwnr4IxNA==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="158601589"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="158601589"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 16:10:44 -0800
IronPort-SDR: GCarN3VmyiyLLOM6Zjn7ArZoFFbD9oaKJxjBlBRE5DhRMqyW5026fmhZIkfpvn1zq9INCi2Flm
 VZxW3/xUnm0w==
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="369387332"
Received: from unknown (HELO arch-ashland-svkelley.intel.com) ([10.212.171.128])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 16:10:43 -0800
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        xerces.zhao@gmail.com, rafael.j.wysocki@intel.com,
        ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@intel.com, qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v12 13/15] PCI/AER: Add pcie_walk_rcec() to RCEC AER handling
Date:   Fri, 20 Nov 2020 16:10:34 -0800
Message-Id: <20201121001036.8560-14-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201121001036.8560-1-sean.v.kelley@intel.com>
References: <20201121001036.8560-1-sean.v.kelley@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Root Complex Event Collectors (RCEC) appear as peers to Root Ports and also
have the AER capability. In addition, actions need to be taken for
associated RCiEPs. In such cases the RCECs will need to be walked in order
to find and act upon their respective RCiEPs.

Extend the existing ability to link the RCECs with a walking function
pcie_walk_rcec(). Add RCEC support to the current AER service driver and
attach the AER service driver to the RCEC device.

[bhelgaas: kernel doc, whitespace cleanup]
Co-developed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Link: https://lore.kernel.org/r/20201002184735.1229220-13-seanvk.dev@oregontracks.org
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pci.h       |  6 ++++++
 drivers/pci/pcie/aer.c  | 29 ++++++++++++++++++++++-------
 drivers/pci/pcie/rcec.c | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ae2ee4df1cff..e988cc930d0b 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -473,10 +473,16 @@ static inline void pci_dpc_init(struct pci_dev *pdev) {}
 void pci_rcec_init(struct pci_dev *dev);
 void pci_rcec_exit(struct pci_dev *dev);
 void pcie_link_rcec(struct pci_dev *rcec);
+void pcie_walk_rcec(struct pci_dev *rcec,
+		    int (*cb)(struct pci_dev *, void *),
+		    void *userdata);
 #else
 static inline void pci_rcec_init(struct pci_dev *dev) {}
 static inline void pci_rcec_exit(struct pci_dev *dev) {}
 static inline void pcie_link_rcec(struct pci_dev *rcec) {}
+static inline void pcie_walk_rcec(struct pci_dev *rcec,
+				  int (*cb)(struct pci_dev *, void *),
+				  void *userdata) {}
 #endif
 
 #ifdef CONFIG_PCI_ATS
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 51389a6ee4ca..b86a92494345 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -300,7 +300,8 @@ int pci_aer_raw_clear_status(struct pci_dev *dev)
 		return -EIO;
 
 	port_type = pci_pcie_type(dev);
-	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
+	if (port_type == PCI_EXP_TYPE_ROOT_PORT ||
+	    port_type == PCI_EXP_TYPE_RC_EC) {
 		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &status);
 		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, status);
 	}
@@ -595,7 +596,8 @@ static umode_t aer_stats_attrs_are_visible(struct kobject *kobj,
 	if ((a == &dev_attr_aer_rootport_total_err_cor.attr ||
 	     a == &dev_attr_aer_rootport_total_err_fatal.attr ||
 	     a == &dev_attr_aer_rootport_total_err_nonfatal.attr) &&
-	    pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT)
+	    ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
+	     (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_EC)))
 		return 0;
 
 	return a->mode;
@@ -916,7 +918,10 @@ static bool find_source_device(struct pci_dev *parent,
 	if (result)
 		return true;
 
-	pci_walk_bus(parent->subordinate, find_device_iter, e_info);
+	if (pci_pcie_type(parent) == PCI_EXP_TYPE_RC_EC)
+		pcie_walk_rcec(parent, find_device_iter, e_info);
+	else
+		pci_walk_bus(parent->subordinate, find_device_iter, e_info);
 
 	if (!e_info->error_dev_num) {
 		pci_info(parent, "can't find device of ID%04x\n", e_info->id);
@@ -1054,6 +1059,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 		if (!(info->status & ~info->mask))
 			return 0;
 	} else if (type == PCI_EXP_TYPE_ROOT_PORT ||
+		   type == PCI_EXP_TYPE_RC_EC ||
 		   type == PCI_EXP_TYPE_DOWNSTREAM ||
 		   info->severity == AER_NONFATAL) {
 
@@ -1206,6 +1212,7 @@ static int set_device_error_reporting(struct pci_dev *dev, void *data)
 	int type = pci_pcie_type(dev);
 
 	if ((type == PCI_EXP_TYPE_ROOT_PORT) ||
+	    (type == PCI_EXP_TYPE_RC_EC) ||
 	    (type == PCI_EXP_TYPE_UPSTREAM) ||
 	    (type == PCI_EXP_TYPE_DOWNSTREAM)) {
 		if (enable)
@@ -1230,9 +1237,12 @@ static void set_downstream_devices_error_reporting(struct pci_dev *dev,
 {
 	set_device_error_reporting(dev, &enable);
 
-	if (!dev->subordinate)
-		return;
-	pci_walk_bus(dev->subordinate, set_device_error_reporting, &enable);
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
+		pcie_walk_rcec(dev, set_device_error_reporting, &enable);
+	else if (dev->subordinate)
+		pci_walk_bus(dev->subordinate, set_device_error_reporting,
+			     &enable);
+
 }
 
 /**
@@ -1330,6 +1340,11 @@ static int aer_probe(struct pcie_device *dev)
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
@@ -1410,7 +1425,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 
 static struct pcie_port_service_driver aerdriver = {
 	.name		= "aer",
-	.port_type	= PCI_EXP_TYPE_ROOT_PORT,
+	.port_type	= PCIE_ANY_PORT,
 	.service	= PCIE_PORT_SERVICE_AER,
 
 	.probe		= aer_probe,
diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
index cdec277cbd62..2c5c552994e4 100644
--- a/drivers/pci/pcie/rcec.c
+++ b/drivers/pci/pcie/rcec.c
@@ -53,6 +53,18 @@ static int link_rcec_helper(struct pci_dev *dev, void *data)
 	return 0;
 }
 
+static int walk_rcec_helper(struct pci_dev *dev, void *data)
+{
+	struct walk_rcec_data *rcec_data = data;
+	struct pci_dev *rcec = rcec_data->rcec;
+
+	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) &&
+	    rcec_assoc_rciep(rcec, dev))
+		rcec_data->user_callback(dev, rcec_data->user_data);
+
+	return 0;
+}
+
 static void walk_rcec(int (*cb)(struct pci_dev *dev, void *data),
 		      void *userdata)
 {
@@ -109,6 +121,31 @@ void pcie_link_rcec(struct pci_dev *rcec)
 	walk_rcec(link_rcec_helper, &rcec_data);
 }
 
+/**
+ * pcie_walk_rcec - Walk RCiEP devices associating with RCEC and call callback.
+ * @rcec:	RCEC whose RCiEP devices should be walked
+ * @cb:		Callback to be called for each RCiEP device found
+ * @userdata:	Arbitrary pointer to be passed to callback
+ *
+ * Walk the given RCEC. Call the callback on each RCiEP found.
+ *
+ * If @cb returns anything other than 0, break out.
+ */
+void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
+		    void *userdata)
+{
+	struct walk_rcec_data rcec_data;
+
+	if (!rcec->rcec_ea)
+		return;
+
+	rcec_data.rcec = rcec;
+	rcec_data.user_callback = cb;
+	rcec_data.user_data = userdata;
+
+	walk_rcec(walk_rcec_helper, &rcec_data);
+}
+
 void pci_rcec_init(struct pci_dev *dev)
 {
 	struct rcec_ea *rcec_ea;
-- 
2.29.2

