Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5C9E281B43
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 20:56:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388265AbgJBS4k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 14:56:40 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:42063 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387806AbgJBS4i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2020 14:56:38 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 77A985C0156;
        Fri,  2 Oct 2020 14:48:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 02 Oct 2020 14:48:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=tT8iefN0DZLkQy3RYltQh7+08jyLmhJbKfd+pB35+I4=; b=MXeq3
        1NJ6h1lhxxHxoywk2Y5OGTULsGDY2FsJvGYNig65QwRzQLLBZ+X4XkH18FfAiBnL
        fXzXnsAmIhAC+8ws5hnfl5ZjjYeDZpVmLhf/iCACiadUV1j7VDDPN7PTs4EgA7fI
        BdLUEtVTge2RNGoEFTm1M4T/DbtXH3ECz7Q5MfJ+UhVpuPRdn244KFSl9cF4Kxfw
        CnyDI3s4ODXE3SINef1E2NH09y1iJR3PPnHA5pyaIRxM14/Wmg+OQMsYH0fyWhpv
        aKxlPy6Jy5WzzKc/+SVFyTLnJlesdaNGZpVcbvLxMjfFrk1CzBGviW982kxsEcK2
        NU/YgJnJm9Sf40+6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=tT8iefN0DZLkQy3RYltQh7+08jyLmhJbKfd+pB35+I4=; b=dlHuYca7
        AFlVtpynTAragtiKaqnJ25VLxBs+kzsb9IzbidfzP7rEQxdl3+PWe90LqZv1dPl7
        c3lEHz/qUuLywrQ8HV0m+5aqgRp+clV2Qs77/xlY+ccnQQfChN8yMzFK5qk/1Ngm
        xPUipsxJnooYgCRovNlmRJE+GUni/54fD6yxCoOSOGOJG0U9WUsB6cfjWf9xx0xs
        4ZmQXhRzJSTuHH+It/a3rzf87kPYkY2MOgTXq+I01vfigqfErPtuV2/65Sb3i+BV
        9X8vrqag3xhnpHPRqvSn6r0237Nu+yfnHzftr7gi1+vKJxmRVnwu+pTnH3WQ0J36
        985FTIon812AGg==
X-ME-Sender: <xms:7nV3XzhUfihIfsGTej82lKFQEtg_00UJg5eTLrJu3Gy6EpLOlcx5Fw>
    <xme:7nV3XwBICjkb6afshPUlSI8f0PJ6xlloLwbkmv-VrRmKouHLLl-RWE08Co55co3YW
    vO0OoN0g7kyBKln>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeeigdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepufgvrghnucggucfmvghllhgvhicuoehsvggrnhhvkhdruggv
    vhesohhrvghgohhnthhrrggtkhhsrdhorhhgqeenucggtffrrghtthgvrhhnpeehkeffte
    eiudeiffelkeelvefftdelhfeitdeigeffleeufedvgfegvdefvedtteenucfkphepvdeg
    rddvtddrudegkedrgeelnecuvehluhhsthgvrhfuihiivgepkeenucfrrghrrghmpehmrg
    hilhhfrhhomhepshgvrghnvhhkrdguvghvsehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:7nV3XzEAcd0_uQ85d_FswD8HfcmGP9NizQxLipmOPyEzU8QAlUorFQ>
    <xmx:7nV3XwSHWL-hFscsiTC5w1dq4qXOSemBIhJVJwoeBytHT53n4E37Bw>
    <xmx:7nV3XwzZ8i20fzsTRlsReDzBMOqc4mFn8zgbUfvnBDqohhdYTqGPjw>
    <xmx:7nV3XzzSlSJGpGdiQ7PMbr76ce_K1CX7pTHtNbQqlisTot9bRbVhzg>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5B3393064684;
        Fri,  2 Oct 2020 14:48:12 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v8 11/14] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
Date:   Fri,  2 Oct 2020 11:47:32 -0700
Message-Id: <20201002184735.1229220-12-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201002184735.1229220-1-seanvk.dev@oregontracks.org>
References: <20201002184735.1229220-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

When attempting error recovery for an RCiEP associated with an RCEC device,
there needs to be a way to update the Root Error Status, the Uncorrectable
Error Status and the Uncorrectable Error Severity of the parent RCEC.
In some non-native cases in which there is no OS visible device
associated with the RCiEP, there is nothing to act upon as the firmware
is acting before the OS. So add handling for the linked 'rcec' in AER/ERR
while taking into account non-native cases.

Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pcie/aer.c |  9 +++++----
 drivers/pci/pcie/err.c | 39 ++++++++++++++++++++++++++++-----------
 2 files changed, 33 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 65dff5f3457a..dccdba60b5d9 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1358,17 +1358,18 @@ static int aer_probe(struct pcie_device *dev)
 static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 {
 	int aer = dev->aer_cap;
+	int rc = 0;
 	u32 reg32;
-	int rc;
-
 
 	/* Disable Root's interrupt in response to error messages */
 	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
 	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
 	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
 
-	rc = pci_bus_error_reset(dev);
-	pci_info(dev, "Root Port link has been reset\n");
+	if (pci_pcie_type(dev) != PCI_EXP_TYPE_RC_EC) {
+		rc = pci_bus_error_reset(dev);
+		pci_info(dev, "Root Port link has been reset\n");
+	}
 
 	/* Clear Root Error Status */
 	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 38abd7984996..956ad4c86d53 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -149,7 +149,8 @@ static int report_resume(struct pci_dev *dev, void *data)
 /**
  * pci_walk_bridge - walk bridges potentially AER affected
  * @bridge   bridge which may be an RCEC with associated RCiEPs,
- *           an RCiEP associated with an RCEC, or a Port.
+ *           or a Port.
+ * @dev      an RCiEP lacking an associated RCEC.
  * @cb       callback to be called for each device found
  * @userdata arbitrary pointer to be passed to callback.
  *
@@ -160,13 +161,20 @@ static int report_resume(struct pci_dev *dev, void *data)
  * If the device provided has no subordinate bus, call the provided
  * callback on the device itself.
  */
-static void pci_walk_bridge(struct pci_dev *bridge, int (*cb)(struct pci_dev *, void *),
+static void pci_walk_bridge(struct pci_dev *bridge, struct pci_dev *dev,
+			    int (*cb)(struct pci_dev *, void *),
 			    void *userdata)
 {
-	if (bridge->subordinate)
+	/*
+	 * In a non-native case where there is no OS-visible reporting
+	 * device the bridge will be NULL, i.e., no RCEC, no PORT.
+	 */
+	if (bridge && bridge->subordinate)
 		pci_walk_bus(bridge->subordinate, cb, userdata);
-	else
+	else if (bridge)
 		cb(bridge, userdata);
+	else
+		cb(dev, userdata);
 }
 
 static pci_ers_result_t flr_on_rciep(struct pci_dev *dev)
@@ -196,16 +204,25 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	type = pci_pcie_type(dev);
 	if (type == PCI_EXP_TYPE_ROOT_PORT ||
 	    type == PCI_EXP_TYPE_DOWNSTREAM ||
-	    type == PCI_EXP_TYPE_RC_EC ||
-	    type == PCI_EXP_TYPE_RC_END)
+	    type == PCI_EXP_TYPE_RC_EC)
 		bridge = dev;
+	else if (type == PCI_EXP_TYPE_RC_END)
+		bridge = dev->rcec;
 	else
 		bridge = pci_upstream_bridge(dev);
 
 	pci_dbg(dev, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
-		pci_walk_bridge(bridge, report_frozen_detected, &status);
+		pci_walk_bridge(bridge, dev, report_frozen_detected, &status);
 		if (type == PCI_EXP_TYPE_RC_END) {
+			/*
+			 * The callback only clears the Root Error Status
+			 * of the RCEC (see aer.c). Only perform this for the
+			 * native case, i.e., an RCEC is present.
+			 */
+			if (bridge)
+				reset_subordinate_devices(bridge);
+
 			status = flr_on_rciep(dev);
 			if (status != PCI_ERS_RESULT_RECOVERED) {
 				pci_warn(dev, "function level reset failed\n");
@@ -219,13 +236,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 			}
 		}
 	} else {
-		pci_walk_bridge(bridge, report_normal_detected, &status);
+		pci_walk_bridge(bridge, dev, report_normal_detected, &status);
 	}
 
 	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
 		status = PCI_ERS_RESULT_RECOVERED;
 		pci_dbg(dev, "broadcast mmio_enabled message\n");
-		pci_walk_bridge(bridge, report_mmio_enabled, &status);
+		pci_walk_bridge(bridge, dev, report_mmio_enabled, &status);
 	}
 
 	if (status == PCI_ERS_RESULT_NEED_RESET) {
@@ -236,14 +253,14 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		 */
 		status = PCI_ERS_RESULT_RECOVERED;
 		pci_dbg(dev, "broadcast slot_reset message\n");
-		pci_walk_bridge(bridge, report_slot_reset, &status);
+		pci_walk_bridge(bridge, dev, report_slot_reset, &status);
 	}
 
 	if (status != PCI_ERS_RESULT_RECOVERED)
 		goto failed;
 
 	pci_dbg(dev, "broadcast resume message\n");
-	pci_walk_bridge(bridge, report_resume, &status);
+	pci_walk_bridge(bridge, dev, report_resume, &status);
 
 	if (type == PCI_EXP_TYPE_ROOT_PORT ||
 	    type == PCI_EXP_TYPE_DOWNSTREAM ||
-- 
2.28.0

