Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B34F281B37
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 20:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388237AbgJBS4g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 14:56:36 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51825 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387712AbgJBS4g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2020 14:56:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 9CD945C014B;
        Fri,  2 Oct 2020 14:48:03 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 02 Oct 2020 14:48:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=RvNXChfCO49Huc+IA9ctJyJl6CuCZgjiaLEu9TFj2D0=; b=DtYce
        j5gZ6xAbWl0T4dVpUPRolfUr/bCN5YI8jWBealz/czdj4JBTEF+ehOHDQGDz8rSq
        HUQHa6/aESpQaI54lLmGhpjdJrRSNiAvwpnf328J3iPnXYm0zXA6pMdL46nL8XWT
        W9+Xm06z9wE6OwXAByCgrDMpunJ9S4PLFPXc7TmCU+eA9oxYSPHFyouHFSkNaryW
        gfWoWKjqQgNjw0JOCkjve7mo1Xq04c2AQqfQLjJBk7iS4EgAJWyJ2RoM3PP7tNf7
        AwZa5aa5CaU2anbB6kXwPHbflAIwgdh6ALIR9gh34aJKBj0/gaIkNSj+7ZnUizJ+
        dV1HWMcJumMXa+W2w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=RvNXChfCO49Huc+IA9ctJyJl6CuCZgjiaLEu9TFj2D0=; b=L2/9Es/x
        PXdwHqmXjmtoUyO/d7mHsxLdMrG28E6eB0DxkdCrQRe1jHPMY9JHktkaN0wxaEZb
        BG1NOWbXQ64E18HUJaePNpvHe5C+aOV3CKAihFIARrcPbAuyfJgl8Kjg0/4Lj4vL
        q8NebfP4ZQT8UgU5LxLXkQ75G8TIPaHkeSwOactUUjZ9X11zCwzKxVo0vHMIe/Yh
        khtlozjHmbnUPVFuQUnDhtBw65zJVaQrGnPDncrduL6X91Emzv9tIlkjtCTUyh92
        sc3cXn2rh7cBSGvLtMnhZdt2EHvEH+Yqj2PdVg8YAMc6523SVlejHjhyAHZ2dF6e
        Jh3oMTo+nZZYPg==
X-ME-Sender: <xms:43V3X5AhCiOw0wCcpqfN1cjxhRVvfplwZNSYg1a68zTNo2MCESjDOg>
    <xme:43V3X3jGLR4GMaXc9QG16qa7rhCh36ZqYTNflEq2gi6g-1C4EhVEusYK9nNknYC59
    cTeYQ6fxFDpgiVx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeeigdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepufgvrghnucggucfmvghllhgvhicuoehsvggrnhhvkhdruggv
    vhesohhrvghgohhnthhrrggtkhhsrdhorhhgqeenucggtffrrghtthgvrhhnpeehkeffte
    eiudeiffelkeelvefftdelhfeitdeigeffleeufedvgfegvdefvedtteenucfkphepvdeg
    rddvtddrudegkedrgeelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepshgvrghnvhhkrdguvghvsehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:43V3X0mpzfc2olpAi7nnP23FaFzguP4ndQRYCMJG5rcTuh4tV1VxHA>
    <xmx:43V3XzwW2OqduQBDkFPFaIwnmuIV2SQfmzIA76H342C8FYap9UPYeg>
    <xmx:43V3X-Qjj-V-tSjM5VdZ3oG0e5upNEttXxKvgUi-sxQolfMtyY3BJw>
    <xmx:43V3X7Te9eVgT1oDbV0Ry2mmFF-D8Z_ekFrexSLlcJdr36MF0GoYTA>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6915F3064680;
        Fri,  2 Oct 2020 14:48:01 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v8 06/14] PCI/ERR: Add pci_walk_bridge() to pcie_do_recovery()
Date:   Fri,  2 Oct 2020 11:47:27 -0700
Message-Id: <20201002184735.1229220-7-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201002184735.1229220-1-seanvk.dev@oregontracks.org>
References: <20201002184735.1229220-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sean V Kelley <sean.v.kelley@intel.com>

Consolidate subordinate bus checks with pci_walk_bus()
into pci_walk_bridge() for walking below potentially
AER affected bridges.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
---
 drivers/pci/pcie/err.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index e68ea5243ff2..9b2130725ab6 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -146,12 +146,28 @@ static int report_resume(struct pci_dev *dev, void *data)
 	return 0;
 }
 
+/**
+ * pci_walk_bridge - walk bridges potentially AER affected
+ * @bridge   bridge which may be a Port.
+ * @cb       callback to be called for each device found
+ * @userdata arbitrary pointer to be passed to callback.
+ *
+ * If the device provided is a bridge, walk the subordinate bus,
+ * including any bridged devices on buses under this bus.
+ * Call the provided callback on each device found.
+ */
+static void pci_walk_bridge(struct pci_dev *bridge, int (*cb)(struct pci_dev *, void *),
+			    void *userdata)
+{
+	if (bridge->subordinate)
+		pci_walk_bus(bridge->subordinate, cb, userdata);
+}
+
 pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 			pci_channel_state_t state,
 			pci_ers_result_t (*reset_subordinate_devices)(struct pci_dev *pdev))
 {
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
-	struct pci_bus *bus;
 	struct pci_dev *bridge;
 	int type;
 
@@ -167,23 +183,22 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	else
 		bridge = pci_upstream_bridge(dev);
 
-	bus = bridge->subordinate;
 	pci_dbg(dev, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
-		pci_walk_bus(bus, report_frozen_detected, &status);
+		pci_walk_bridge(bridge, report_frozen_detected, &status);
 		status = reset_subordinate_device(bridge);
 		if (status != PCI_ERS_RESULT_RECOVERED) {
 			pci_warn(dev, "subordinate device reset failed\n");
 			goto failed;
 		}
 	} else {
-		pci_walk_bus(bus, report_normal_detected, &status);
+		pci_walk_bridge(bridge, report_normal_detected, &status);
 	}
 
 	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
 		status = PCI_ERS_RESULT_RECOVERED;
 		pci_dbg(dev, "broadcast mmio_enabled message\n");
-		pci_walk_bus(bus, report_mmio_enabled, &status);
+		pci_walk_bridge(bridge, report_mmio_enabled, &status);
 	}
 
 	if (status == PCI_ERS_RESULT_NEED_RESET) {
@@ -194,14 +209,14 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		 */
 		status = PCI_ERS_RESULT_RECOVERED;
 		pci_dbg(dev, "broadcast slot_reset message\n");
-		pci_walk_bus(bus, report_slot_reset, &status);
+		pci_walk_bridge(bridge, report_slot_reset, &status);
 	}
 
 	if (status != PCI_ERS_RESULT_RECOVERED)
 		goto failed;
 
 	pci_dbg(dev, "broadcast resume message\n");
-	pci_walk_bus(bus, report_resume, &status);
+	pci_walk_bridge(bridge, report_resume, &status);
 
 	if (pcie_aer_is_native(bridge))
 		pcie_clear_device_status(bridge);
-- 
2.28.0

