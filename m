Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988BD274B64
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 23:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgIVVqA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 17:46:00 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:40853 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726576AbgIVVpu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Sep 2020 17:45:50 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id B90925C01AE;
        Tue, 22 Sep 2020 17:39:12 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 22 Sep 2020 17:39:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=oJHPiPe5Nctxyx/8EoFRuwzqCQlX4iKVFYHYBm5C0Ag=; b=FWusy
        PEbveOdUzLFab64jd2Gsj5TC4kONLYj2aybO+zdyD3TVOFZKaG4MVBTERuD83TnH
        bGhEgubG+WbfEzRoH+73ayrcg4WIFX4weYZpndxAT434/A6kzxZnO7a6igebW1bU
        BDY+xm/9skxjLNJMI0yBi3oURS8WcYVlKYEVWcscaD9YNtYYIxe4+PXBXcG/wQ0G
        X67JP2XfdiH6Maz8gR7+pICfcaDObHVYYRLzerlBvMT29zP+XoEdg5q1qp8Sbj2J
        MHPeUN5u9MNiLVzA0nZO97naWJGtZfYZjOsyswZqM4RQ/DVA5VVmQtPLvEsCGC8J
        Y3zYjjujjP42T60zQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=oJHPiPe5Nctxyx/8EoFRuwzqCQlX4iKVFYHYBm5C0Ag=; b=mNyoL4vO
        DUbDNQzWj4cVvd5OGNO07l3TA4UTFT1Z9wTkFUcfq0rUmKcFt+oZ0G9eO39wDdEm
        7oqk5aPPDUDNlz5l2Y5RJjzV9IdsTlNNBBIJRjEU4yXf7trPGOr+/aW5JJzzCOG9
        9UD//dl0Jer9JYu/aZstscaZsOLhFtpjfBhU6kM1my6Uc9Z8qXD7cXjP7B5fRABZ
        I0nhO4EX96jr7Q9jvJ5Ks0vsRkFoZ9hpi84A67cRNYNBZX1vFcngfzo9CP45Q+Tn
        vM5Y4eyQEZfqWgbSxwmyAiHE8vW/CiNeaR4n6+aCjqmW8yiuXeyLjXRq+iCKqyrF
        NLsHf1Cbw9JpHw==
X-ME-Sender: <xms:AG9qX2MgxNVTeXL250Q0SUFe6s8CZR37IRrruG9MzHhvu62gIdyV9g>
    <xme:AG9qX0_Y1DYSgvS-s1tH-hTzHVXrP2BOVi6TpgwGG5q5oVOS9z1x0KVf7Yok7MLBy
    V72AWsH8iwqFoOY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeggdduieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepufgvrghnucggucfmvghllhgvhicuoehsvggrnhhvkhdruggv
    vhesohhrvghgohhnthhrrggtkhhsrdhorhhgqeenucggtffrrghtthgvrhhnpeehkeffte
    eiudeiffelkeelvefftdelhfeitdeigeffleeufedvgfegvdefvedtteenucfkphepvdeg
    rddvtddrudegkedrgeelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepshgvrghnvhhkrdguvghvsehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:AG9qX9RrK3UrO4X4whfzqcd4WxFRNU-S870GNIifG4ma1ObtLZ98Tw>
    <xmx:AG9qX2vNsGp3DomL9canS8Xc_671rQE-TnPZuO6osxyYNKIOPPGWKQ>
    <xmx:AG9qX-dcvaoOmLZQeW4qvbKm1_u-bqX0ZTNHxb6tw8xRJenZ60kg6w>
    <xmx:AG9qX0sU8StIbgB_nnSC4sSlczhfv2rT3P6qOiv-QLcrQrpE9KnxYQ>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 436CF306467D;
        Tue, 22 Sep 2020 17:39:11 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v6 04/10] PCI/AER: Extend AER error handling to RCECs
Date:   Tue, 22 Sep 2020 14:38:53 -0700
Message-Id: <20200922213859.108826-5-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922213859.108826-1-seanvk.dev@oregontracks.org>
References: <20200922213859.108826-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Currently the kernel does not handle AER errors for Root Complex
integrated End Points (RCiEPs)[0]. These devices sit on a root bus within
the Root Complex (RC). AER handling is performed by a Root Complex Event
Collector (RCEC) [1] which is a effectively a type of RCiEP on the same
root bus.

For an RCEC (technically not a Bridge), error messages "received" from
associated RCiEPs must be enabled for "transmission" in order to cause a
System Error via the Root Control register or (when the Advanced Error
Reporting Capability is present) reporting via the Root Error Command
register and logging in the Root Error Status register and Error Source
Identification register.

In addition to the defined OS level handling of the reset flow for the
associated RCiEPs of an RCEC, it is possible to also have non-native
handling. In that case there is no need to take any actions on the RCEC
because the firmware is responsible for them. This is true where APEI [2]
is used to report the AER errors via a GHES[v2] HEST entry [3] and
relevant AER CPER record [4] and non-native handling is in use.

We effectively end up with two different types of discovery for
purposes of handling AER errors:

1) Normal bus walk - we pass the downstream port above a bus to which
the device is attached and it walks everything below that point.

2) An RCiEP with no visible association with an RCEC as there is no need
to walk devices. In that case, the flow is to just call the callbacks for
the actual device, which in turn references its associated RCEC.

A new walk function pci_bridge_walk(), similar to pci_bus_walk(),
is provided that takes a pci_dev instead of a bus. If that bridge
corresponds to a downstream port it will walk the subordinate bus of
that bridge. If the device does not then it will call the function on
that device alone.

[0] ACPI PCI Express Base Specification 5.0-1 1.3.2.3 Root Complex
Integrated Endpoint Rules.
[1] ACPI PCI Express Base Specification 5.0-1 6.2 Error Signalling and
Logging
[2] ACPI Specification 6.3 Chapter 18 ACPI Platform Error Interface (APEI)
[3] ACPI Specification 6.3 18.2.3.7 Generic Hardware Error Source
[4] UEFI Specification 2.8, N.2.7 PCI Express Error Section

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
---
 drivers/pci/pci.h      |  2 +-
 drivers/pci/pcie/err.c | 77 +++++++++++++++++++++++++++++++-----------
 2 files changed, 59 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 83670a6425d8..7b547fc3679a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -575,7 +575,7 @@ static inline int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
 /* PCI error reporting and recovery */
 pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 			pci_channel_state_t state,
-			pci_ers_result_t (*reset_link)(struct pci_dev *pdev));
+			pci_ers_result_t (*reset_subordinate_devices)(struct pci_dev *pdev));
 
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 #ifdef CONFIG_PCIEASPM
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index c543f419d8f9..e575fa6cee63 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -146,38 +146,73 @@ static int report_resume(struct pci_dev *dev, void *data)
 	return 0;
 }
 
+/**
+ * pci_bridge_walk - walk bridges potentially AER affected
+ * @bridge   bridge which may be an RCEC with associated RCiEPs,
+ *           an RCiEP associated with an RCEC, or a Port.
+ * @cb       callback to be called for each device found
+ * @userdata arbitrary pointer to be passed to callback.
+ *
+ * If the device provided is a bridge, walk the subordinate bus,
+ * including any bridged devices on buses under this bus.
+ * Call the provided callback on each device found.
+ *
+ * If the device provided has no subordinate bus, call the provided
+ * callback on the device itself.
+ */
+static void pci_bridge_walk(struct pci_dev *bridge, int (*cb)(struct pci_dev *, void *),
+			    void *userdata)
+{
+	if (bridge->subordinate)
+		pci_walk_bus(bridge->subordinate, cb, userdata);
+	else
+		cb(bridge, userdata);
+}
+
 pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 			pci_channel_state_t state,
-			pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
+			pci_ers_result_t (*reset_subordinate_devices)(struct pci_dev *pdev))
 {
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
-	struct pci_bus *bus;
+	struct pci_dev *bridge;
+	int type;
 
 	/*
-	 * Error recovery runs on all subordinates of the first downstream port.
-	 * If the downstream port detected the error, it is cleared at the end.
+	 * Error recovery runs on all subordinates of the first downstream
+	 * bridge. If the downstream bridge detected the error, it is
+	 * cleared at the end. For RCiEPs we should reset just the RCiEP itself.
 	 */
-	if (!(pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
-	      pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM))
-		dev = dev->bus->self;
-	bus = dev->subordinate;
+	type = pci_pcie_type(dev);
+	if (type == PCI_EXP_TYPE_ROOT_PORT ||
+	    type == PCI_EXP_TYPE_DOWNSTREAM ||
+	    type == PCI_EXP_TYPE_RC_EC ||
+	    type == PCI_EXP_TYPE_RC_END)
+		bridge = dev;
+	else
+		bridge = pci_upstream_bridge(dev);
 
 	pci_dbg(dev, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
-		pci_walk_bus(bus, report_frozen_detected, &status);
-		status = reset_link(dev);
+		pci_bridge_walk(bridge, report_frozen_detected, &status);
+		if (type == PCI_EXP_TYPE_RC_END) {
+			pci_warn(dev, "link reset not possible for RCiEP\n");
+			status = PCI_ERS_RESULT_NONE;
+			goto failed;
+		}
+
+		status = reset_subordinate_devices(bridge);
 		if (status != PCI_ERS_RESULT_RECOVERED) {
-			pci_warn(dev, "link reset failed\n");
+			pci_warn(dev, "subordinate device reset failed\n");
 			goto failed;
 		}
 	} else {
-		pci_walk_bus(bus, report_normal_detected, &status);
+		pci_bridge_walk(bridge, report_normal_detected, &status);
 	}
 
 	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
 		status = PCI_ERS_RESULT_RECOVERED;
 		pci_dbg(dev, "broadcast mmio_enabled message\n");
-		pci_walk_bus(bus, report_mmio_enabled, &status);
+		pci_bridge_walk(bridge, report_mmio_enabled, &status);
 	}
 
 	if (status == PCI_ERS_RESULT_NEED_RESET) {
@@ -188,18 +223,22 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		 */
 		status = PCI_ERS_RESULT_RECOVERED;
 		pci_dbg(dev, "broadcast slot_reset message\n");
-		pci_walk_bus(bus, report_slot_reset, &status);
+		pci_bridge_walk(bridge, report_slot_reset, &status);
 	}
 
 	if (status != PCI_ERS_RESULT_RECOVERED)
 		goto failed;
 
 	pci_dbg(dev, "broadcast resume message\n");
-	pci_walk_bus(bus, report_resume, &status);
-
-	if (pcie_aer_is_native(dev))
-		pcie_clear_device_status(dev);
-	pci_aer_clear_nonfatal_status(dev);
+	pci_bridge_walk(bridge, report_resume, &status);
+
+	if (type == PCI_EXP_TYPE_ROOT_PORT ||
+	    type == PCI_EXP_TYPE_DOWNSTREAM ||
+	    type == PCI_EXP_TYPE_RC_EC) {
+		if (pcie_aer_is_native(bridge))
+			pcie_clear_device_status(bridge);
+		pci_aer_clear_nonfatal_status(bridge);
+	}
 	pci_info(dev, "device recovery successful\n");
 	return status;
 
-- 
2.28.0

