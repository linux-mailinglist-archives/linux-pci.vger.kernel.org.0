Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4954928FBF9
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 02:13:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733151AbgJPANQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 20:13:16 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:54963 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731916AbgJPAMb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2020 20:12:31 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 9B4E2AD8;
        Thu, 15 Oct 2020 20:12:29 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 15 Oct 2020 20:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=rHCMN9zyF7Ze4M2N/M7lyomCGAwsWRCxFG15YuGa8xs=; b=hxquV
        a9jsyp0z3jyO99opqiiaqdCHnIUN2R4vUfjRqmqA+8JTUeVjqC8CHizOA0DXta0x
        U+w844uwxdD+gDROmV5fKVWRgDni927W8EQCN96GdgRtT24Y/S7D5UOziEliorC2
        uBJ3FGCSC1oEbfSa5EQRvq7nuaSyBWd/RJ0FuAKIP/HMdKP5peJ6x10pINSza11n
        6yF9t0CGyU/pwq05PBnnwSWdIC7QaOjJboXb8PVZ1smP27BY2OxrU6hnDDuh3n/E
        Vt6HHv/+/lpwem7RtnFcqdlYi98OVWLP0u0n/CWeJokpR9O3xVoaq4/Mn6W7V8lM
        SbR4goC0XGfm0k2sA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=rHCMN9zyF7Ze4M2N/M7lyomCGAwsWRCxFG15YuGa8xs=; b=nW2SOVO0
        dnYGBsfZz5wZ14mxDZiMJRtPneND8EmOHOX8TjbAkteuOaSq2hIxemWLQOO41ast
        LgVRMqJJKQZSMpqyUKIG+a5Emh/pozIrZEgiaS4NvzTKMLuSh1+OOinPdr8bag89
        b/JlA0YFGfGIS6sRMQjxsZajBAsFOI9A2zNwc/5WVJv3YcjV8/LQ9HGFmOT5ATbO
        2mniRS41Yte3OItC/ze1OQs89M8LPgYppLrwwBTXKyyj9w+Lk494yeXqUhUyalln
        eif+h4xWyTHAJu71KmmU1TNvo+P6NJF05PzD1BTXqROrH0jj9IGvVxBNcagwXK/f
        EizN6I9PBNdEZg==
X-ME-Sender: <xms:beWIXyQPeJJsu4YiuvsbmJfFyIS0LwcNNVFf_OtYab_tZJFlIiPaag>
    <xme:beWIX3zm3q9qqvDUF2tZK9agjh-cjmUGdtXcXeXj9KObBwkVzje10DWGBw_UQAHPZ
    xi7fCu_xjBeR4OK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrieeggdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefuvggrnhcuggcumfgvlhhlvgihuceoshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgheqnecuggftrfgrthhtvghrnhepkefggeektd
    dttdeuffffjeeihfetfffghfdugefhvdeuheeuudelheegleevheefnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucfkphepvdegrddvtddrudegkedrgeelnecuvehluhhsth
    gvrhfuihiivgepieenucfrrghrrghmpehmrghilhhfrhhomhepshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:beWIX_3iqx57LVvRXL_yCCBpVZyJy_Ei66K2Nf-kas18tJvL-vyZWQ>
    <xmx:beWIX-BfPmlr8uEXiML9qI6K_y7zKoxoYpBlmQbbx64tZmFADTzW0g>
    <xmx:beWIX7jWdbg0Lr55zPHiDoXuP7MiIYlnRa9GUzAZmATTCxlmxXFNsg>
    <xmx:beWIX7gH_0fqWwfSQ2ndmvz0-7lAWxKirLLWS6aXhzmAknRJSvJ3zw>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 02E393064684;
        Thu, 15 Oct 2020 20:12:27 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v9 09/15] PCI/ERR: Add pci_walk_bridge() to pcie_do_recovery()
Date:   Thu, 15 Oct 2020 17:11:07 -0700
Message-Id: <20201016001113.2301761-10-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016001113.2301761-1-seanvk.dev@oregontracks.org>
References: <20201016001113.2301761-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sean V Kelley <sean.v.kelley@intel.com>

Consolidate subordinate bus checks with pci_walk_bus() into
pci_walk_bridge() for walking below potentially AER affected bridges.

[bhelgaas: fix kerneldoc]
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20201002184735.1229220-7-seanvk.dev@oregontracks.org
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pcie/err.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 931e75f2549d..8b53aecdb43d 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -146,13 +146,30 @@ static int report_resume(struct pci_dev *dev, void *data)
 	return 0;
 }
 
+/**
+ * pci_walk_bridge - walk bridges potentially AER affected
+ * @bridge:	bridge which may be a Port
+ * @cb:		callback to be called for each device found
+ * @userdata:	arbitrary pointer to be passed to callback
+ *
+ * If the device provided is a bridge, walk the subordinate bus, including
+ * any bridged devices on buses under this bus.  Call the provided callback
+ * on each device found.
+ */
+static void pci_walk_bridge(struct pci_dev *bridge,
+			    int (*cb)(struct pci_dev *, void *),
+			    void *userdata)
+{
+	if (bridge->subordinate)
+		pci_walk_bus(bridge->subordinate, cb, userdata);
+}
+
 pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		pci_channel_state_t state,
 		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev))
 {
 	int type = pci_pcie_type(dev);
 	struct pci_dev *bridge;
-	struct pci_bus *bus;
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
 
 	/*
@@ -165,23 +182,22 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	else
 		bridge = pci_upstream_bridge(dev);
 
-	bus = bridge->subordinate;
 	pci_dbg(bridge, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
-		pci_walk_bus(bus, report_frozen_detected, &status);
+		pci_walk_bridge(bridge, report_frozen_detected, &status);
 		status = reset_subordinates(bridge);
 		if (status != PCI_ERS_RESULT_RECOVERED) {
 			pci_warn(bridge, "subordinate device reset failed\n");
 			goto failed;
 		}
 	} else {
-		pci_walk_bus(bus, report_normal_detected, &status);
+		pci_walk_bridge(bridge, report_normal_detected, &status);
 	}
 
 	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
 		status = PCI_ERS_RESULT_RECOVERED;
 		pci_dbg(bridge, "broadcast mmio_enabled message\n");
-		pci_walk_bus(bus, report_mmio_enabled, &status);
+		pci_walk_bridge(bridge, report_mmio_enabled, &status);
 	}
 
 	if (status == PCI_ERS_RESULT_NEED_RESET) {
@@ -192,14 +208,14 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		 */
 		status = PCI_ERS_RESULT_RECOVERED;
 		pci_dbg(bridge, "broadcast slot_reset message\n");
-		pci_walk_bus(bus, report_slot_reset, &status);
+		pci_walk_bridge(bridge, report_slot_reset, &status);
 	}
 
 	if (status != PCI_ERS_RESULT_RECOVERED)
 		goto failed;
 
 	pci_dbg(bridge, "broadcast resume message\n");
-	pci_walk_bus(bus, report_resume, &status);
+	pci_walk_bridge(bridge, report_resume, &status);
 
 	if (pcie_aer_is_native(bridge))
 		pcie_clear_device_status(bridge);
-- 
2.28.0

