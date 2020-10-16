Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F38628FC02
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 02:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733173AbgJPAN1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 20:13:27 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:34715 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389715AbgJPAM2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2020 20:12:28 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id ED04DAEF;
        Thu, 15 Oct 2020 20:12:26 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 15 Oct 2020 20:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=PHyu6MB+XozbsB2RUwUB3vXsDG5zNx4Z0tOfnB5deko=; b=NIOuO
        3xfAoRxLaHDl7JTmKQDkEgC7LCYyT+ePglNajQgRhc6CFzOQPJs2vGY2K0Kg0GVS
        +hIyRtgMq/Qr5mfs9bwN8Vlw8gBRSCtePmsJN7HhPScsmw0+sR6YxvX5DajIqFCl
        b1K/IhDQ6+HD1Zp9fg/S1vbJy1cWdZeHSbVBTqmW6d1GUIzG0lUGiBlEfqtisTJw
        6MaIefmhtFjmwKWVMOAKuZTN9kjH+ZLq2nbnDf9ezZ5gfFjrvrNcT9HTDFp3hwpW
        wtDdD2DLvbQK/5PbU6UkdxWELh4vsJBeGQGQ//Rk0Kca0f8EcbX20eS7QIOwvSg/
        emmgHdweSLyW5lJVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=PHyu6MB+XozbsB2RUwUB3vXsDG5zNx4Z0tOfnB5deko=; b=E4kZyhQc
        zRKiVT6oSLNKFS/Hwq0lFbdGehzByh5t9gQjYvjaLGQKfOYvqGr0yL1taKhSH3nW
        SWnErQcMMKou0Urac4iVWUXjT/4o5iNtx5oYXlkvjQ3RkHG2vGud95R3YnYN4YvV
        YKQPC0qPWQ0O3IDld7mzV4sT9CUMT/CNN3ptvGxtuju/smO+2fpFsnWaEtjo8Yhj
        XSp/EzrLfO+yel/CraMSg1lB5SUwGAnqy55rCXLLv/DO9G9pdTJmRxGNR/rC1w30
        2WTRAnj550Re/Ko4cpAj/qR7lw30KR/jWeA3FAIwV77T9GnjtqWuTGSskCdDANbs
        EnL7AnpJgbuHlw==
X-ME-Sender: <xms:auWIX73KEd5CMFt8BROVbz7uW9lRA-VToRH64l2HZiwnf78Qzv46fA>
    <xme:auWIX6E86523i50casHQ3qWlWsLUOmUBUEIWcmmDT-RCffdPK_CY3Y_RVrMZbM47M
    SZO0ZKfghmJA0X_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrieeggdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefuvggrnhcuggcumfgvlhhlvgihuceoshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgheqnecuggftrfgrthhtvghrnhepkefggeektd
    dttdeuffffjeeihfetfffghfdugefhvdeuheeuudelheegleevheefnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucfkphepvdegrddvtddrudegkedrgeelnecuvehluhhsth
    gvrhfuihiivgepieenucfrrghrrghmpehmrghilhhfrhhomhepshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:auWIX77ObQ_SG1vmTW6zBlWJeefCstqZA2JYnLjSNhFQToSSxkkDFA>
    <xmx:auWIXw0ni9kWKFEp5lKL9dkvX0SLOT1x3MFDj6xohKqVMOuR8tixOg>
    <xmx:auWIX-ESlScGIsI_ACnlN4vPWuGPtC-yezC4q4k3aoVtZb4nBqoVbA>
    <xmx:auWIXx0xkbpiAWfihCtFIh-QzQQpAyR2ymdGmtLlPPMQqY5iBQjvSw>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 570F73064680;
        Thu, 15 Oct 2020 20:12:25 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v9 07/15] PCI/ERR: Use "bridge" for clarity in pcie_do_recovery()
Date:   Thu, 15 Oct 2020 17:11:05 -0700
Message-Id: <20201016001113.2301761-8-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016001113.2301761-1-seanvk.dev@oregontracks.org>
References: <20201016001113.2301761-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sean V Kelley <sean.v.kelley@intel.com>

pcie_do_recovery() may be called with "dev" being either a bridge (Root
Port or Switch Downstream Port) or an Endpoint.  The bulk of the function
deals with the bridge, so if we start with an Endpoint, we reset "dev" to
be the bridge leading to it.

For clarity, replace "dev" in the body of the function with "bridge".  No
functional change intended.

[bhelgaas: commit log, split pieces out so this is pure rename, also
replace "dev" with "bridge" in messages and pci_uevent_ers()]
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20201002184735.1229220-6-seanvk.dev@oregontracks.org
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pcie/err.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 7a5af873d8bc..46a5b84f8842 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -151,24 +151,27 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		pci_ers_result_t (*reset_subordinates)(struct pci_dev *pdev))
 {
 	int type = pci_pcie_type(dev);
-	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
+	struct pci_dev *bridge;
 	struct pci_bus *bus;
+	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
 
 	/*
-	 * Error recovery runs on all subordinates of the first downstream port.
-	 * If the downstream port detected the error, it is cleared at the end.
+	 * Error recovery runs on all subordinates of the bridge.  If the
+	 * bridge detected the error, it is cleared at the end.
 	 */
 	if (!(type == PCI_EXP_TYPE_ROOT_PORT ||
 	      type == PCI_EXP_TYPE_DOWNSTREAM))
-		dev = pci_upstream_bridge(dev);
-	bus = dev->subordinate;
+		bridge = pci_upstream_bridge(dev);
+	else
+		bridge = dev;
 
-	pci_dbg(dev, "broadcast error_detected message\n");
+	bus = bridge->subordinate;
+	pci_dbg(bridge, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bus(bus, report_frozen_detected, &status);
-		status = reset_subordinates(dev);
+		status = reset_subordinates(bridge);
 		if (status != PCI_ERS_RESULT_RECOVERED) {
-			pci_warn(dev, "subordinate device reset failed\n");
+			pci_warn(bridge, "subordinate device reset failed\n");
 			goto failed;
 		}
 	} else {
@@ -177,7 +180,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 
 	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
 		status = PCI_ERS_RESULT_RECOVERED;
-		pci_dbg(dev, "broadcast mmio_enabled message\n");
+		pci_dbg(bridge, "broadcast mmio_enabled message\n");
 		pci_walk_bus(bus, report_mmio_enabled, &status);
 	}
 
@@ -188,27 +191,27 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		 * drivers' slot_reset callbacks?
 		 */
 		status = PCI_ERS_RESULT_RECOVERED;
-		pci_dbg(dev, "broadcast slot_reset message\n");
+		pci_dbg(bridge, "broadcast slot_reset message\n");
 		pci_walk_bus(bus, report_slot_reset, &status);
 	}
 
 	if (status != PCI_ERS_RESULT_RECOVERED)
 		goto failed;
 
-	pci_dbg(dev, "broadcast resume message\n");
+	pci_dbg(bridge, "broadcast resume message\n");
 	pci_walk_bus(bus, report_resume, &status);
 
-	if (pcie_aer_is_native(dev))
-		pcie_clear_device_status(dev);
-	pci_aer_clear_nonfatal_status(dev);
-	pci_info(dev, "device recovery successful\n");
+	if (pcie_aer_is_native(bridge))
+		pcie_clear_device_status(bridge);
+	pci_aer_clear_nonfatal_status(bridge);
+	pci_info(bridge, "device recovery successful\n");
 	return status;
 
 failed:
-	pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
+	pci_uevent_ers(bridge, PCI_ERS_RESULT_DISCONNECT);
 
 	/* TODO: Should kernel panic here? */
-	pci_info(dev, "device recovery failed\n");
+	pci_info(bridge, "device recovery failed\n");
 
 	return status;
 }
-- 
2.28.0

