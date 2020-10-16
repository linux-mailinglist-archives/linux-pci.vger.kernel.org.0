Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DFEA28FBF7
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 02:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389873AbgJPAMv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 20:12:51 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:40827 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389807AbgJPAMl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2020 20:12:41 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id E22F3BDC;
        Thu, 15 Oct 2020 20:12:34 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 15 Oct 2020 20:12:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=Pnbx6VRGhaCAdPEHC8O+SoUAuvTJ47qazF2vJiKC7us=; b=Oz6Wd
        zAGIU1bfBdtHVPCXsWwcVSZ/zGF4DoLsUD1vYQP9Jhx2HPTgqT7L1i8yOabwnA0G
        6xn4ie3FlQDhlyXx9OJzdslwAmNcblwMLt+Z4M5UrBL50AnRq8R48jHY/ygep1S2
        s2LCLxMvo89dXfmUHcnPh+fNY1M0D4ARbKeCHksAlviWsyfnzTGspqGJK7ENplJC
        PM1J2GuV1GZnnMWRwjSYL0sHPYTRgQnV2SKdCu5xU48trXI5M+MawLsdwQVu7OnB
        JQO4gXW9z0f5Am6TP/4dhXfGYLUYMga+E+Rz3sA7IE+M3dvZg5fLgIZkBUULkFkY
        UjF9vVFt2KGIdtDTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=Pnbx6VRGhaCAdPEHC8O+SoUAuvTJ47qazF2vJiKC7us=; b=Osvsayfj
        EED+qu8xBNZNBWLTAOP6Y9NV0lwTQWxlqlBjmnUqWV6QHnw4B5xrLBRzHsl89ZM8
        oosOtgEoaMBltMND71n0Ejbv+L+Gdwa/BMbJRTJNEJpy4pgX1pHu3anAprdsQxk4
        r7BUAas4k4Ts2p5n0T2OPmUhLmH/Gqn50mId0Q/+pnXC6dxhyhlktNCCsVc1l19z
        SyEPuCfRKjemx5gcWsQxkgLbWNrSTFYfokgZyyM1Fn4iff7z8tBRbBoFeU/DhYOj
        e1M0iXrdpsE9WZC+9Ppcf9grzlc0FLYfaOHJfNpuk2l+X6rb3E/d78Ys7Hf/Rc6h
        cYkoGBPHs5txIQ==
X-ME-Sender: <xms:cuWIX2b-MDN1oDgwzDgLB7CZOQGaiOUwUrledhPFlVtb7TMPZTkB2A>
    <xme:cuWIX5YRahKyYJ1bBOz2dstiuMzmfK7tG9B-sRpXUko1bk6L6YsFhaDa0EEeUGuSV
    bKKRIFjBDjaFxmc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrieeggdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefuvggrnhcuggcumfgvlhhlvgihuceoshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgheqnecuggftrfgrthhtvghrnhepkefggeektd
    dttdeuffffjeeihfetfffghfdugefhvdeuheeuudelheegleevheefnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucfkphepvdegrddvtddrudegkedrgeelnecuvehluhhsth
    gvrhfuihiivgepuddunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvggrnhhvkhdruggv
    vhesohhrvghgohhnthhrrggtkhhsrdhorhhg
X-ME-Proxy: <xmx:cuWIXw-ZnmSrjQ8WFsAjzgukh9FIWoWXBIapPvdQFm5a_POguTcu9A>
    <xmx:cuWIX4oRwrX8URYj9TbYmVW0GFun6YbVjX4gF4GocaaOLBcx0yeUjA>
    <xmx:cuWIXxo439KTp03XnizfSkTL_O17LeWQSpkSDiUKQGXNTBC0OheT4w>
    <xmx:cuWIX1Itc6v8hpYVvqnOdHhB5I5rWwIYSiO1GtYV8r8wYuUy5KD6Ew>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4C83B3064680;
        Thu, 15 Oct 2020 20:12:33 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v9 13/15] PCI/AER: Add pcie_walk_rcec() to RCEC AER handling
Date:   Thu, 15 Oct 2020 17:11:11 -0700
Message-Id: <20201016001113.2301761-14-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016001113.2301761-1-seanvk.dev@oregontracks.org>
References: <20201016001113.2301761-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sean V Kelley <sean.v.kelley@intel.com>

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
---
 drivers/pci/pci.h       |  6 ++++++
 drivers/pci/pcie/aer.c  | 29 ++++++++++++++++++++++-------
 drivers/pci/pcie/rcec.c | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9e43a265c006..4090f2f98bf6 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -474,10 +474,16 @@ static inline void pci_dpc_init(struct pci_dev *pdev) {}
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
index 083f69b67bfd..8244a29ef334 100644
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
@@ -1053,6 +1058,7 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
 		if (!(info->status & ~info->mask))
 			return 0;
 	} else if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
+		   pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC ||
 	           pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
 		   info->severity == AER_NONFATAL) {
 
@@ -1205,6 +1211,7 @@ static int set_device_error_reporting(struct pci_dev *dev, void *data)
 	int type = pci_pcie_type(dev);
 
 	if ((type == PCI_EXP_TYPE_ROOT_PORT) ||
+	    (type == PCI_EXP_TYPE_RC_EC) ||
 	    (type == PCI_EXP_TYPE_UPSTREAM) ||
 	    (type == PCI_EXP_TYPE_DOWNSTREAM)) {
 		if (enable)
@@ -1229,9 +1236,12 @@ static void set_downstream_devices_error_reporting(struct pci_dev *dev,
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
@@ -1329,6 +1339,11 @@ static int aer_probe(struct pcie_device *dev)
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
@@ -1407,7 +1422,7 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 
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
2.28.0

