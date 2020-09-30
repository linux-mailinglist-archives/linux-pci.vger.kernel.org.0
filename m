Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B32BF27F4AB
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 23:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731402AbgI3V6p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 17:58:45 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:35865 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731424AbgI3V6m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 17:58:42 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 57BA9CC3;
        Wed, 30 Sep 2020 17:58:41 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 30 Sep 2020 17:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=/OyZqHr+MnAPos+2/WvGGh8oUgCI+xxPNRWldepzBz8=; b=kgCtu
        dxocq1EM0U57GV1OBSymHN6qrrxkluH+GeJ0feUioxCTynXWLyvbgGwpKdG/cmXq
        csDUv748fKSGwqoSFo8FxOQw6XD7MCwR3J1SBsgA0dr91hgTGcj70rU14g5PYVPg
        zCRtcXnD/nfUTZ4XSIJzH+fXShKSkdU+0GajrFuNgNbQAAeanOPAtM9YqfDoj4Ma
        9tN3t+0acz0k3xjyzcoxTHg1mMuNKdQ5J7MlLyZrYz24ltydrLbduRIcvOOxJyfi
        rpowcW5PhVbmGeyITyD8p8wVh/ErGzIZzHNHBnt0Sti3tuWHzdt6iaIQ1p645Rs3
        LMpAyxZar+1Xv0/aA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=/OyZqHr+MnAPos+2/WvGGh8oUgCI+xxPNRWldepzBz8=; b=a5qiMbFV
        B4yJQoM8tsVyVwfzw/gkUb79kqHE5+aOaxcjzBeMAjgGQ6Fd/cPDrOOKh3hF7bID
        PAUBYauZ1lKTbaAQda/Wl8FZta4PfaoYod7OI+NAD8KBYbfZCg6r3Rn/pazLknZD
        4ecMhNYIQkB5R9Owr0MXH9iAviMqEoM/B0XTHZ93KE+5Mp2pZ+47dVX+yVicNkdN
        5UtphtcbKjEIBWfp/3K8SvBtZl847wrn/WGQM8NXEwm/IjqxSGkqYMoW3Gxc78tZ
        +dxXy8XLbPUhcZR0FoZxhh24XyhmGeJNJvg+xG2U4UnWC4kDMS/9H5vH8yCYXYJM
        zP3KlGFbHdV0gg==
X-ME-Sender: <xms:kP90X-rKc0JBRc08yNXiHJSrhDFi5wq-mTCsZXWDoPIexrNP3J0taQ>
    <xme:kP90X8q9SZc9GalnMH6FS6a3i1d2z37uBjNlPlqfGP393JyvG3VRJpdog0bb8HNuM
    Y1heXobThCKWFMk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefuvggrnhcuggcumfgvlhhlvgihuceoshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgheqnecuggftrfgrthhtvghrnhepheekffetie
    duieffleekleevffdtlefhiedtieegffelueefvdfggedvfeevtdetnecukfhppedvgedr
    vddtrddugeekrdegleenucevlhhushhtvghrufhiiigvpeeinecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehsvggrnhhvkhdruggvvhesohhrvghgohhnthhrrggtkhhsrdhorhhg
X-ME-Proxy: <xmx:kP90XzOjgcQfjEHYAandcgCZFKUJeOzWbhNIvXyw0H7v6Z1U34alWQ>
    <xmx:kP90X966uRWMMtdWMkwcEk4Top2mao8m8mA5lKSSvHjmOcHUTeVnyg>
    <xmx:kP90X97I4yKVLkx_tqRf0-onGvehzadTa8nKqEda-QKEnrt6I9kmMw>
    <xmx:kP90X4ZOJq_QsP7L3Z8aXI9qli57PX-AStbI93kawG8cK3Hh6iLTfQ>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 93F6D3280063;
        Wed, 30 Sep 2020 17:58:39 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v7 07/13] PCI/AER: Extend AER error handling to RCECs
Date:   Wed, 30 Sep 2020 14:58:14 -0700
Message-Id: <20200930215820.1113353-8-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
References: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
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

A new walk function pci_walk_bridge(), similar to pci_walk_bus(),
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
 drivers/pci/pcie/err.c | 52 +++++++++++++++++++++++++++++++++---------
 1 file changed, 41 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 9e552330155b..c4ceca42a3bf 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -146,44 +146,73 @@ static int report_resume(struct pci_dev *dev, void *data)
 	return 0;
 }
 
+/**
+ * pci_walk_bridge - walk bridges potentially AER affected
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
+static void pci_walk_bridge(struct pci_dev *bridge, int (*cb)(struct pci_dev *, void *),
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
 			pci_ers_result_t (*reset_subordinate_devices)(struct pci_dev *pdev))
 {
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
-	struct pci_bus *bus;
 	struct pci_dev *bridge;
 	int type;
 
 	/*
 	 * Error recovery runs on all subordinates of the first downstream
 	 * bridge. If the downstream bridge detected the error, it is
-	 * cleared at the end.
+	 * cleared at the end. For RCiEPs we should reset just the RCiEP itself.
 	 */
 	type = pci_pcie_type(dev);
 	if (type == PCI_EXP_TYPE_ROOT_PORT ||
-	    type == PCI_EXP_TYPE_DOWNSTREAM)
+	    type == PCI_EXP_TYPE_DOWNSTREAM ||
+	    type == PCI_EXP_TYPE_RC_EC ||
+	    type == PCI_EXP_TYPE_RC_END)
 		bridge = dev;
 	else
 		bridge = pci_upstream_bridge(dev);
 
-	bus = bridge->subordinate;
 	pci_dbg(dev, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
-		pci_walk_bus(bus, report_frozen_detected, &status);
-		status = reset_subordinate_device(dev);
+		pci_walk_bridge(bridge, report_frozen_detected, &status);
+		if (type == PCI_EXP_TYPE_RC_END) {
+			pci_warn(dev, "subordinate device reset not possible for RCiEP\n");
+			status = PCI_ERS_RESULT_NONE;
+			goto failed;
+		}
+
+		status = reset_subordinate_devices(bridge);
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
@@ -194,17 +223,18 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
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
 
 	if (type == PCI_EXP_TYPE_ROOT_PORT ||
-	    type == PCI_EXP_TYPE_DOWNSTREAM) {
+	    type == PCI_EXP_TYPE_DOWNSTREAM ||
+	    type == PCI_EXP_TYPE_RC_EC) {
 		if (pcie_aer_is_native(bridge))
 			pcie_clear_device_status(bridge);
 		pci_aer_clear_nonfatal_status(bridge);
-- 
2.28.0

