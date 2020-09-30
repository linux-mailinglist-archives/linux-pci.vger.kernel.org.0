Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59E127F4AD
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 23:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731034AbgI3V66 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 17:58:58 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:38509 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731388AbgI3V6s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 17:58:48 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 1A356FA3;
        Wed, 30 Sep 2020 17:58:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 30 Sep 2020 17:58:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=3XMUwzDQAEBZXn+9J8mGrGgpAFJVHQZk4InGjJxlJEU=; b=Quw5N
        szpdpCdzG8+Dfyn0FjORynddTGsIKmGYsG3QJtYr29LFyp9fw/xGueFaPfMwcOmR
        ahcp7ccPbFP8R8v9Q2mGUOAsBncTgRa6Z9aVTgKu8JYe0IfE2K4kWHJXVI6o486y
        v5lomcpmP4fXm8Hq2uU1yV7yBzYHNDrvIzepuV5jayiTsNjjjbEFL3CCrS1N/yF2
        D7k2sGtu2Y7oEzLKJU7eyYgRwE9F9Gke9TLpRCCD+D0pQQ1QWta44g0/H/6KSA3z
        jV6HrhHphFYX6zxBGdZjd0Ua+19Ny3kEkiPjRugNhAKOcS4GBhcwDG1BkTX8a07K
        wWw1LQ0WuMq/t8OUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=3XMUwzDQAEBZXn+9J8mGrGgpAFJVHQZk4InGjJxlJEU=; b=MHpQyMSd
        CkLHt4b9pkcT9FvLIAUUd7bBLmj2ykwXSmmcb+NcpW5fcY5tGIYtsUJuxbXzfZtQ
        AwG8pIor99PK6LnOTywcdrhbkqunWTc48Z1inD/RgPj//gPMGD0N7pd84uSkmqCC
        V4sknJ+84HfCv+yRptmlYnUCTmT+qYreyHzwvYEEXbgRAiOaMM0rnUotywbHwnQs
        llxTk58PSueIK4JmOQd3/oSvHVbTKc6XtKNExp2ilgQLVWjAlHVe8sjzH7bM9uyB
        jjy349a3Rumx0Xkg8Lmm8j1eLsuCeiIJggY5z6TaU/Yz4MY+E7Jm1WJEitUMzvl4
        z6bju5c8nAWLIw==
X-ME-Sender: <xms:lv90X3Iu_Xr12aMX9tL2sTw-Immx0OKaObu4IzaV92qGIqEuFjeeug>
    <xme:lv90X7JOlcqNYSx7tt9BOLPGaAB91ISAxJv6poHQPTbCEffljncm7wxt9VljW8KA6
    yTkXFUb9lH8ibNN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefuvggrnhcuggcumfgvlhhlvgihuceoshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgheqnecuggftrfgrthhtvghrnhepheekffetie
    duieffleekleevffdtlefhiedtieegffelueefvdfggedvfeevtdetnecukfhppedvgedr
    vddtrddugeekrdegleenucevlhhushhtvghrufhiiigvpedutdenucfrrghrrghmpehmrg
    hilhhfrhhomhepshgvrghnvhhkrdguvghvsehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:lv90X_vFvkVs65F52k-Np7T-d1M_aN-RW3Umv6m6-IehVKUkruOj0Q>
    <xmx:lv90XwY6YYoypV12vo1eI5XdmZO0taQ8Rsi6b5hhr9-n4bc5yoD-RA>
    <xmx:lv90X-bcUjMYXXxftItSih3lB2pdiQ8nYesVqMmCX4MbYsoJrVqtgQ>
    <xmx:lv90X27pl_VeoLh_pO3nHgD6G1xbHJ1O2pJl2akbKXuYbjbWTRiqOg>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id E4C92328005E;
        Wed, 30 Sep 2020 17:58:44 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v7 11/13] PCI/AER: Add pcie_walk_rcec() to RCEC AER handling
Date:   Wed, 30 Sep 2020 14:58:18 -0700
Message-Id: <20200930215820.1113353-12-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
References: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sean V Kelley <sean.v.kelley@intel.com>

Root Complex Event Collectors (RCEC) appear as peers to Root Ports
and also have the AER capability. In addition, actions need to be taken
for associated RCiEPs. In such cases the RCECs will need to be walked in
order to find and act upon their respective RCiEPs.  Extend the existing
ability to link the RCECs with a walking function pcie_walk_rcec(). Add
RCEC support to the current AER service driver and attach the AER service
driver to the RCEC device.

Co-developed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pci.h       |  4 ++++
 drivers/pci/pcie/aer.c  | 27 ++++++++++++++++++++-------
 drivers/pci/pcie/rcec.c | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ef60a78a1861..b20cc3544267 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -474,10 +474,14 @@ static inline void pci_dpc_init(struct pci_dev *pdev) {}
 int pci_rcec_init(struct pci_dev *dev);
 void pci_rcec_exit(struct pci_dev *dev);
 void pcie_link_rcec(struct pci_dev *rcec);
+void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
+		    void *userdata);
 #else
 static inline int pci_rcec_init(struct pci_dev *dev) {return 0;}
 static inline void pci_rcec_exit(struct pci_dev *dev) {}
 static inline void pcie_link_rcec(struct pci_dev *rcec) {}
+static inline void pcie_walk_rcec(struct pci_dev *rcec, int (*cb)(struct pci_dev *, void *),
+				  void *userdata) {}
 #endif
 
 #ifdef CONFIG_PCI_ATS
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index dccdba60b5d9..3cde646f71c0 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -300,7 +300,7 @@ int pci_aer_raw_clear_status(struct pci_dev *dev)
 		return -EIO;
 
 	port_type = pci_pcie_type(dev);
-	if (port_type == PCI_EXP_TYPE_ROOT_PORT) {
+	if (port_type == PCI_EXP_TYPE_ROOT_PORT || port_type == PCI_EXP_TYPE_RC_EC) {
 		pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &status);
 		pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, status);
 	}
@@ -595,7 +595,8 @@ static umode_t aer_stats_attrs_are_visible(struct kobject *kobj,
 	if ((a == &dev_attr_aer_rootport_total_err_cor.attr ||
 	     a == &dev_attr_aer_rootport_total_err_fatal.attr ||
 	     a == &dev_attr_aer_rootport_total_err_nonfatal.attr) &&
-	    pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT)
+	    ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ROOT_PORT) &&
+	     (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_EC)))
 		return 0;
 
 	return a->mode;
@@ -916,7 +917,10 @@ static bool find_source_device(struct pci_dev *parent,
 	if (result)
 		return true;
 
-	pci_walk_bus(parent->subordinate, find_device_iter, e_info);
+	if (pci_pcie_type(parent) == PCI_EXP_TYPE_RC_EC)
+		pcie_walk_rcec(parent, find_device_iter, e_info);
+	else
+		pci_walk_bus(parent->subordinate, find_device_iter, e_info);
 
 	if (!e_info->error_dev_num) {
 		pci_info(parent, "can't find device of ID%04x\n", e_info->id);
@@ -1053,6 +1057,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 		if (!(info->status & ~info->mask))
 			return 0;
 	} else if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
+		   pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC ||
 	           pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
 		   info->severity == AER_NONFATAL) {
 
@@ -1205,6 +1210,7 @@ static int set_device_error_reporting(struct pci_dev *dev, void *data)
 	int type = pci_pcie_type(dev);
 
 	if ((type == PCI_EXP_TYPE_ROOT_PORT) ||
+	    (type == PCI_EXP_TYPE_RC_EC) ||
 	    (type == PCI_EXP_TYPE_UPSTREAM) ||
 	    (type == PCI_EXP_TYPE_DOWNSTREAM)) {
 		if (enable)
@@ -1229,9 +1235,11 @@ static void set_downstream_devices_error_reporting(struct pci_dev *dev,
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
@@ -1329,6 +1337,11 @@ static int aer_probe(struct pcie_device *dev)
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
@@ -1385,7 +1398,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 
 static struct pcie_port_service_driver aerdriver = {
 	.name		= "aer",
-	.port_type	= PCI_EXP_TYPE_ROOT_PORT,
+	.port_type	= PCIE_ANY_PORT,
 	.service	= PCIE_PORT_SERVICE_AER,
 
 	.probe		= aer_probe,
diff --git a/drivers/pci/pcie/rcec.c b/drivers/pci/pcie/rcec.c
index 9ba74d8064e9..a3ca3bbfac93 100644
--- a/drivers/pci/pcie/rcec.c
+++ b/drivers/pci/pcie/rcec.c
@@ -51,6 +51,17 @@ static int link_rcec_helper(struct pci_dev *dev, void *data)
 	return 0;
 }
 
+static int walk_rcec_helper(struct pci_dev *dev, void *data)
+{
+	struct walk_rcec_data *rcec_data = data;
+	struct pci_dev *rcec = rcec_data->rcec;
+
+	if ((pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END) && rcec_assoc_rciep(rcec, dev))
+		rcec_data->user_callback(dev, rcec_data->user_data);
+
+	return 0;
+}
+
 static void walk_rcec(int (*cb)(struct pci_dev *dev, void *data), void *userdata)
 {
 	struct walk_rcec_data *rcec_data = userdata;
@@ -106,6 +117,32 @@ void pcie_link_rcec(struct pci_dev *rcec)
 	walk_rcec(link_rcec_helper, &rcec_data);
 }
 
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
 int pci_rcec_init(struct pci_dev *dev)
 {
 	struct rcec_ea *rcec_ea;
-- 
2.28.0

