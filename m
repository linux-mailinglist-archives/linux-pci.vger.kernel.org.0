Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9AD274B72
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 23:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726727AbgIVVqW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 17:46:22 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:40895 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726550AbgIVVpt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Sep 2020 17:45:49 -0400
X-Greylist: delayed 402 seconds by postgrey-1.27 at vger.kernel.org; Tue, 22 Sep 2020 17:45:48 EDT
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 5A8925C01B2;
        Tue, 22 Sep 2020 17:39:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 22 Sep 2020 17:39:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=Lgbt1KCCqzvihMOqXjwNZuU1NDU9I1ERm1UKgqaatPo=; b=Jww68
        VOstninGCjEbcVceVtldrDbkFAA4aR9yAByvynfznzeefsxmvSEdM1Cx6uAWps4d
        4kw2Bno08+6ayAXdPtAMCQs4at0B/WKmG5v5E4yL6SDAanf/CGP1fYtME6UYWBUx
        HrZbmryaVskFLEbc/9UoIU1bOiLYzYnjBESW/Pvs01eard5G/cF3M8V1UfgYXFtp
        6x8Or4yMKYZ88xLh+xKpPlfnlV8vNP8V+Hmri2/WqNxtiPKXyGkJLLoWQ700MvWY
        /0cn7DzOrTIxGwRLm8CO0yhTA32Xsoit1TJRd57EOC4//RZO9ZMJdv8uHn3GxyTj
        E6+TQuP+IB/FYCcXQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=Lgbt1KCCqzvihMOqXjwNZuU1NDU9I1ERm1UKgqaatPo=; b=SElsVuNJ
        HjwPXXAEMd/7lOupNfINGYiIwhUVVpcWUy5Zh8gfVj2JP4D6K9Msxjxeyxhrfca/
        FGQ9ioPpTiVHb6/B0RRxyADGG6mdnwF8c4qaZjioPyQmGGTuPqH2sLR+Pgq1hgI9
        A/jYWcuzhWOecSO2q5Le/i4hTgL3nVxlJLGRFGyZrs7g9AApTKP6pYdzTOM1H+KE
        4E13264Q0ox+OMlt/mhmqhN5fIaDBWrsypBxBbs+SpygvClTH1lzIpaXKwmsiquA
        dG8mkgGcCcE4ZYJdSl4+CCR7yQGtaM/V0++CFE8RuUZwIKrUm/HUTnhvcy1ai89b
        qUtSoCBcl6YI9A==
X-ME-Sender: <xms:CG9qX0WP618zIqYFx3YSgNWVhTO4_DnQ9Sjg-eWlP8XuLZeyCwUr2A>
    <xme:CG9qX4kalqvXYdOOVrSx8g6p-6PkXmAT4qOmg3K0X9xlJEJKmmj3qOFoQYO8tqVB0
    A8ra9I24241Jq5a>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeggdduieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepufgvrghnucggucfmvghllhgvhicuoehsvggrnhhvkhdruggv
    vhesohhrvghgohhnthhrrggtkhhsrdhorhhgqeenucggtffrrghtthgvrhhnpeehkeffte
    eiudeiffelkeelvefftdelhfeitdeigeffleeufedvgfegvdefvedtteenucfkphepvdeg
    rddvtddrudegkedrgeelnecuvehluhhsthgvrhfuihiivgepieenucfrrghrrghmpehmrg
    hilhhfrhhomhepshgvrghnvhhkrdguvghvsehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:CG9qX4a6bCYLGTT-sTeiBUF6EFbFovpNtxUQjA9ndPtQ6sQtfmQytQ>
    <xmx:CG9qXzU7S3hKmvIQ-Qn1KPpeGhGsAE19LlpwMlVUoCip5E723DIKpg>
    <xmx:CG9qX-mXWZZkBwHJXRpiiZ44NTLLca5vTuG1x-MlovSpzBOMbAo0zw>
    <xmx:CG9qXwVZzxXtWFvRcy_OyDNERH9njzIfdm5LvueKM7D0HfEUVpfYkQ>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 225DD3064610;
        Tue, 22 Sep 2020 17:39:18 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v6 07/10] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
Date:   Tue, 22 Sep 2020 14:38:56 -0700
Message-Id: <20200922213859.108826-8-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922213859.108826-1-seanvk.dev@oregontracks.org>
References: <20200922213859.108826-1-seanvk.dev@oregontracks.org>
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
---
 drivers/pci/pcie/aer.c |  9 +++++----
 drivers/pci/pcie/err.c | 38 ++++++++++++++++++++++++--------------
 2 files changed, 29 insertions(+), 18 deletions(-)

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
index 5380ecc41506..a61a2518163a 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -149,7 +149,8 @@ static int report_resume(struct pci_dev *dev, void *data)
 /**
  * pci_bridge_walk - walk bridges potentially AER affected
  * @bridge   bridge which may be an RCEC with associated RCiEPs,
- *           an RCiEP associated with an RCEC, or a Port.
+ *           or a Port.
+ * @dev      an RCiEP lacking an associated RCEC.
  * @cb       callback to be called for each device found
  * @userdata arbitrary pointer to be passed to callback.
  *
@@ -160,13 +161,16 @@ static int report_resume(struct pci_dev *dev, void *data)
  * If the device provided has no subordinate bus, call the provided
  * callback on the device itself.
  */
-static void pci_bridge_walk(struct pci_dev *bridge, int (*cb)(struct pci_dev *, void *),
+static void pci_bridge_walk(struct pci_dev *bridge, struct pci_dev *dev,
+			    int (*cb)(struct pci_dev *, void *),
 			    void *userdata)
 {
-	if (bridge->subordinate)
+	if (bridge && bridge->subordinate)
 		pci_walk_bus(bridge->subordinate, cb, userdata);
-	else
+	else if (bridge)
 		cb(bridge, userdata);
+	else
+		cb(dev, userdata);
 }
 
 static pci_ers_result_t flr_on_rciep(struct pci_dev *dev)
@@ -196,16 +200,24 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
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
-		pci_bridge_walk(bridge, report_frozen_detected, &status);
+		pci_bridge_walk(bridge, dev, report_frozen_detected, &status);
 		if (type == PCI_EXP_TYPE_RC_END) {
+			/*
+			 * The callback only clears the Root Error Status
+			 * of the RCEC (see aer.c).
+			 */
+			if (bridge)
+				reset_subordinate_devices(bridge);
+
 			status = flr_on_rciep(dev);
 			if (status != PCI_ERS_RESULT_RECOVERED) {
 				pci_warn(dev, "function level reset failed\n");
@@ -219,13 +231,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 			}
 		}
 	} else {
-		pci_bridge_walk(bridge, report_normal_detected, &status);
+		pci_bridge_walk(bridge, dev, report_normal_detected, &status);
 	}
 
 	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
 		status = PCI_ERS_RESULT_RECOVERED;
 		pci_dbg(dev, "broadcast mmio_enabled message\n");
-		pci_bridge_walk(bridge, report_mmio_enabled, &status);
+		pci_bridge_walk(bridge, dev, report_mmio_enabled, &status);
 	}
 
 	if (status == PCI_ERS_RESULT_NEED_RESET) {
@@ -236,18 +248,16 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		 */
 		status = PCI_ERS_RESULT_RECOVERED;
 		pci_dbg(dev, "broadcast slot_reset message\n");
-		pci_bridge_walk(bridge, report_slot_reset, &status);
+		pci_bridge_walk(bridge, dev, report_slot_reset, &status);
 	}
 
 	if (status != PCI_ERS_RESULT_RECOVERED)
 		goto failed;
 
 	pci_dbg(dev, "broadcast resume message\n");
-	pci_bridge_walk(bridge, report_resume, &status);
+	pci_bridge_walk(bridge, dev, report_resume, &status);
 
-	if (type == PCI_EXP_TYPE_ROOT_PORT ||
-	    type == PCI_EXP_TYPE_DOWNSTREAM ||
-	    type == PCI_EXP_TYPE_RC_EC) {
+	if (bridge) {
 		if (pcie_aer_is_native(bridge))
 			pcie_clear_device_status(bridge);
 		pci_aer_clear_nonfatal_status(bridge);
-- 
2.28.0

