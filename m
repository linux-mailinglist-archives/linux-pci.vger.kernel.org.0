Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4952B28FBF5
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 02:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389919AbgJPAMx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 20:12:53 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:34481 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733122AbgJPAMc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2020 20:12:32 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 0902B20D;
        Thu, 15 Oct 2020 20:12:30 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 15 Oct 2020 20:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=0ILUgxdlB4XScK187m+/KuvJzas1e3+LKs/gk1YjLAY=; b=F7G2l
        9Rk5/yi4GSvaJY+3JxWInrlfc6NqlIXtNNgMFe5B5pozn19R1hqh4Jq4BJNCNLHl
        uX91nXmNK6rdrYd6YjExhOZdvSWEgm+HJQC8cnkSORw/Box/uAAAOs4DM3ld3GIy
        k7jv0pah/gvdDO88kPhQ0sEVmEzDfTxp+NocxudGhCtqwi8nlMIV1kI85LZ4z1MH
        5mz5FqfBud40maxP+3DpCWV+SUDKfxWO5lGevBD/ooeH/3cBs4KKGzv3UU31xOQn
        X9ahwhmRhKayFY6Y7YOtx/Ow3kzJbt+mMwVW5DlDU8pa7gyoSiPtTxgn2C2epjzQ
        pTjuaFsDHnR6MbkIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=0ILUgxdlB4XScK187m+/KuvJzas1e3+LKs/gk1YjLAY=; b=cMozK+5y
        nzAGSrC7ZEbAsHxp+EZ9Y4zWuH+i5aj+id/2yi44wGYbqq2nHk+OFCSuRGKOodpH
        yVchgjwb+4qfrwwThCGRMR+rSKyA3+fJjKXPkktA+A21rh20KzYrMTX14ypA6Ily
        Yxl4UAFQ+e99ZuuNi66TM060e2/ZFNcWqX8fAc1mgS9gE+PNjFpk0VByo0VmynQ8
        VhXHZVkzuOOAolQr1IDPYcSW3EfKMbYUjkKXfOznoDt0g0mcCj1k4RZ4hm+Vke+e
        lpdiTVURwM2pM58ofMCNanYSP53hrjWKF0mySf1+I16LFR66TPGcPxVSdXyG6Y4R
        d5vk7SqxQ6Acqw==
X-ME-Sender: <xms:buWIX0QhxH9Ravu1ipLAG6o4FPT_LDpERbOgPLph1AQyByGsmpgYUQ>
    <xme:buWIXxxeC4czkB8mnmVcCHCvvE9QcOF4X-trUasGqxY8rjOCDmZN3bRcmGldUPUgN
    owrTEEuOCqWeyoB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrieeggdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefuvggrnhcuggcumfgvlhhlvgihuceoshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgheqnecuggftrfgrthhtvghrnhepkefggeektd
    dttdeuffffjeeihfetfffghfdugefhvdeuheeuudelheegleevheefnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucfkphepvdegrddvtddrudegkedrgeelnecuvehluhhsth
    gvrhfuihiivgepieenucfrrghrrghmpehmrghilhhfrhhomhepshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:buWIXx2SlLeNuO-tHooQBtaTWTOSNTkzr6oBQGg6OU2WpQdJRr34fQ>
    <xmx:buWIX4CwJ8Ns1sQo6S0SDlbMgyaEeMb0e_-KMTXyQZAXozEN0Jcrtg>
    <xmx:buWIX9jqvLJ8SJmYMV9bRbpL35IBgv5bLnvS96R4o0seg3R5V1P96Q>
    <xmx:buWIX1inuHchuzaM0vEJwiujGvc6Qtl6G-HBBhQPg_IKUPQjZ3UHrw>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 54DD5306467E;
        Thu, 15 Oct 2020 20:12:29 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v9 10/15] PCI/ERR: Limit AER resets in pcie_do_recovery()
Date:   Thu, 15 Oct 2020 17:11:08 -0700
Message-Id: <20201016001113.2301761-11-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016001113.2301761-1-seanvk.dev@oregontracks.org>
References: <20201016001113.2301761-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sean V Kelley <sean.v.kelley@intel.com>

In some cases a bridge may not exist as the hardware controlling may be
handled only by firmware and so is not visible to the OS. This scenario is
also possible in future use cases involving non-native use of RCECs by
firmware.

Explicitly apply conditional logic around these resets by limiting them to
Root Ports and Downstream Ports.

Link: https://lore.kernel.org/r/20201002184735.1229220-8-seanvk.dev@oregontracks.org
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pcie/err.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 8b53aecdb43d..7883c9791562 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -148,13 +148,17 @@ static int report_resume(struct pci_dev *dev, void *data)
 
 /**
  * pci_walk_bridge - walk bridges potentially AER affected
- * @bridge:	bridge which may be a Port
+ * @bridge:	bridge which may be a Port, an RCEC with associated RCiEPs,
+ *		or an RCiEP associated with an RCEC
  * @cb:		callback to be called for each device found
  * @userdata:	arbitrary pointer to be passed to callback
  *
  * If the device provided is a bridge, walk the subordinate bus, including
  * any bridged devices on buses under this bus.  Call the provided callback
  * on each device found.
+ *
+ * If the device provided has no subordinate bus, call the callback on the
+ * device itself.
  */
 static void pci_walk_bridge(struct pci_dev *bridge,
 			    int (*cb)(struct pci_dev *, void *),
@@ -162,6 +166,8 @@ static void pci_walk_bridge(struct pci_dev *bridge,
 {
 	if (bridge->subordinate)
 		pci_walk_bus(bridge->subordinate, cb, userdata);
+	else
+		cb(bridge, userdata);
 }
 
 pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
@@ -174,10 +180,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 
 	/*
 	 * Error recovery runs on all subordinates of the bridge.  If the
-	 * bridge detected the error, it is cleared at the end.
+	 * bridge detected the error, it is cleared at the end.  For RCiEPs
+	 * we should reset just the RCiEP itself.
 	 */
 	if (type == PCI_EXP_TYPE_ROOT_PORT ||
-	    type == PCI_EXP_TYPE_DOWNSTREAM)
+	    type == PCI_EXP_TYPE_DOWNSTREAM ||
+	    type == PCI_EXP_TYPE_RC_EC ||
+	    type == PCI_EXP_TYPE_RC_END)
 		bridge = dev;
 	else
 		bridge = pci_upstream_bridge(dev);
@@ -185,6 +194,12 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_dbg(bridge, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bridge(bridge, report_frozen_detected, &status);
+		if (type == PCI_EXP_TYPE_RC_END) {
+			pci_warn(dev, "subordinate device reset not possible for RCiEP\n");
+			status = PCI_ERS_RESULT_NONE;
+			goto failed;
+		}
+
 		status = reset_subordinates(bridge);
 		if (status != PCI_ERS_RESULT_RECOVERED) {
 			pci_warn(bridge, "subordinate device reset failed\n");
@@ -217,9 +232,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_dbg(bridge, "broadcast resume message\n");
 	pci_walk_bridge(bridge, report_resume, &status);
 
-	if (pcie_aer_is_native(bridge))
-		pcie_clear_device_status(bridge);
-	pci_aer_clear_nonfatal_status(bridge);
+	if (type == PCI_EXP_TYPE_ROOT_PORT ||
+	    type == PCI_EXP_TYPE_DOWNSTREAM ||
+	    type == PCI_EXP_TYPE_RC_EC) {
+		if (pcie_aer_is_native(bridge))
+			pcie_clear_device_status(bridge);
+		pci_aer_clear_nonfatal_status(bridge);
+	}
 	pci_info(bridge, "device recovery successful\n");
 	return status;
 
-- 
2.28.0

