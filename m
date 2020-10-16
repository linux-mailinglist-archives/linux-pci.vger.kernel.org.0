Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AF0528FBF2
	for <lists+linux-pci@lfdr.de>; Fri, 16 Oct 2020 02:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389887AbgJPAMw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Oct 2020 20:12:52 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:47573 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2389801AbgJPAMl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Oct 2020 20:12:41 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id A5DE9B8B;
        Thu, 15 Oct 2020 20:12:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 15 Oct 2020 20:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=9X1m6g/ZRBBoCrKzQGuKJVyFcUQ8oZiDkzAsIhHlW5g=; b=pJJLB
        gUPjd2ISFzlpN0QD/kEaK9/YSXDy5XrteFrdEWb72Oy2ycAIUEG7L+Ej178/o0FO
        xvK+qKOg84tayZvfxKnaGcmyY1a6mWemJF4o1zBD1jrc6wNcPfnQffU83eIQaxee
        dqz0gzCoWJWJ66djRz0SBXv9y4kPpoL5Q+6/AS6FkecYPJQ9lq5n1Ms6EcqyDJWY
        5epl9AIo+Q9/SWaRHSd7xTiL/VLeBQmZtYtD01eDRCOk9UfzqdzSiKr1OoO2l0CB
        V/N58t1iXyM/VB6tPNad7J3yDpUhzI5xQTe/ZFKkltiMp4Po5qxImOZNH90abgT4
        rQJ/7VajlVhGEWSzg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=9X1m6g/ZRBBoCrKzQGuKJVyFcUQ8oZiDkzAsIhHlW5g=; b=g84BTwYW
        xBlSQ9xb0b2GlUOFP1lEfsaED+7/3IY38V90d46piVBXuqlQ0YuBK+U862Lns1Jy
        2fRa9IMLL+Ch6D4DZv30hkUu5oawp/FPa4BUEiRxCBPqNYIablFazOgosicEhRy3
        VMR+DJ4ejZFzLO3nDPWZJzDuyqgIQBpoudJ2BSZejU4ma1fin3n3YR5PI5vYKAxB
        kjL9DTgztMHs/cn7V89gABVM0E6SsoRgDxkk/XmLchsFSWZuS9PQNzmz+cx7wHUB
        H2aGIjNhx+BBrmXCIGj56tO2F6S5oMbG8wsaofjd6Dm+HEUKKZSTeTRi0PVsET3/
        CF2bxVP2Zf8VXQ==
X-ME-Sender: <xms:ceWIXz3IzGAt4joER12boYhX3l9613ygRFHSwn9k2TK8YzfSgg4rDA>
    <xme:ceWIXyEsSvnJSzRH1grmzHmKvFVbxkCsfOKFPjlAlQrOiE5MegX0JDTH6c_4FPMGj
    GGanikV_N09_ZzX>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrieeggdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefuvggrnhcuggcumfgvlhhlvgihuceoshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgheqnecuggftrfgrthhtvghrnhepkefggeektd
    dttdeuffffjeeihfetfffghfdugefhvdeuheeuudelheegleevheefnecuffhomhgrihhn
    pehkvghrnhgvlhdrohhrghenucfkphepvdegrddvtddrudegkedrgeelnecuvehluhhsth
    gvrhfuihiivgepuddunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvggrnhhvkhdruggv
    vhesohhrvghgohhnthhrrggtkhhsrdhorhhg
X-ME-Proxy: <xmx:ceWIXz7IBgzcIQHmr_twKEmFSgbehk2JM9B5H6E9tlDV4LvyVsb7kA>
    <xmx:ceWIX41i1tjHIhW7FFpBrk9TeeR2b5srgWdVcfSsoB5RCB3tZ556Eg>
    <xmx:ceWIX2FoEkyOV6KIk6KGmZjvj9-2l51hscgPTJ3Utz088pBK_GThxw>
    <xmx:ceWIX50AizGxKKzUDd383ZjlVVwk6vkRZXt8tNI3zEN2Kklp1yLSZw>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id F384D306467E;
        Thu, 15 Oct 2020 20:12:31 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v9 12/15] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
Date:   Thu, 15 Oct 2020 17:11:10 -0700
Message-Id: <20201016001113.2301761-13-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201016001113.2301761-1-seanvk.dev@oregontracks.org>
References: <20201016001113.2301761-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

When attempting error recovery for an RCiEP associated with an RCEC device,
there needs to be a way to update the Root Error Status, the Uncorrectable
Error Status and the Uncorrectable Error Severity of the parent RCEC.  In
some non-native cases in which there is no OS-visible device associated
with the RCiEP, there is nothing to act upon as the firmware is acting
before the OS.

Add handling for the linked RCEC in AER/ERR while taking into account
non-native cases.

Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
Link: https://lore.kernel.org/r/20201002184735.1229220-12-seanvk.dev@oregontracks.org
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pcie/aer.c | 53 ++++++++++++++++++++++++++++++------------
 drivers/pci/pcie/err.c | 20 ++++++++--------
 2 files changed, 48 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 65dff5f3457a..083f69b67bfd 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1357,27 +1357,50 @@ static int aer_probe(struct pcie_device *dev)
  */
 static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
 {
-	int aer = dev->aer_cap;
+	int type = pci_pcie_type(dev);
+	struct pci_dev *root;
+	int aer = 0;
+	int rc = 0;
 	u32 reg32;
-	int rc;
 
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_END)
+		/*
+		 * The reset should only clear the Root Error Status
+		 * of the RCEC. Only perform this for the
+		 * native case, i.e., an RCEC is present.
+		 */
+		root = dev->rcec;
+	else
+		root = dev;
 
-	/* Disable Root's interrupt in response to error messages */
-	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
-	reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
-	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
+	if (root)
+		aer = dev->aer_cap;
 
-	rc = pci_bus_error_reset(dev);
-	pci_info(dev, "Root Port link has been reset\n");
+	if (aer) {
+		/* Disable Root's interrupt in response to error messages */
+		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
+		reg32 &= ~ROOT_PORT_INTR_ON_MESG_MASK;
+		pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, reg32);
 
-	/* Clear Root Error Status */
-	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, &reg32);
-	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_STATUS, reg32);
+		/* Clear Root Error Status */
+		pci_read_config_dword(root, aer + PCI_ERR_ROOT_STATUS, &reg32);
+		pci_write_config_dword(root, aer + PCI_ERR_ROOT_STATUS, reg32);
 
-	/* Enable Root Port's interrupt in response to error messages */
-	pci_read_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, &reg32);
-	reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
-	pci_write_config_dword(dev, aer + PCI_ERR_ROOT_COMMAND, reg32);
+		/* Enable Root Port's interrupt in response to error messages */
+		pci_read_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, &reg32);
+		reg32 |= ROOT_PORT_INTR_ON_MESG_MASK;
+		pci_write_config_dword(root, aer + PCI_ERR_ROOT_COMMAND, reg32);
+	}
+
+	if ((type == PCI_EXP_TYPE_RC_EC) || (type == PCI_EXP_TYPE_RC_END)) {
+		if (pcie_has_flr(root)) {
+			rc = pcie_flr(root);
+			pci_info(dev, "has been reset (%d)\n", rc);
+		}
+	} else {
+		rc = pci_bus_error_reset(root);
+		pci_info(dev, "Root Port link has been reset (%d)\n", rc);
+	}
 
 	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
 }
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 7883c9791562..cbc5abfe767b 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -148,10 +148,10 @@ static int report_resume(struct pci_dev *dev, void *data)
 
 /**
  * pci_walk_bridge - walk bridges potentially AER affected
- * @bridge:	bridge which may be a Port, an RCEC with associated RCiEPs,
- *		or an RCiEP associated with an RCEC
- * @cb:		callback to be called for each device found
- * @userdata:	arbitrary pointer to be passed to callback
+ * @bridge   bridge which may be an RCEC with associated RCiEPs,
+ *           or a Port.
+ * @cb       callback to be called for each device found
+ * @userdata arbitrary pointer to be passed to callback.
  *
  * If the device provided is a bridge, walk the subordinate bus, including
  * any bridged devices on buses under this bus.  Call the provided callback
@@ -164,8 +164,14 @@ static void pci_walk_bridge(struct pci_dev *bridge,
 			    int (*cb)(struct pci_dev *, void *),
 			    void *userdata)
 {
+	/*
+	 * In a non-native case where there is no OS-visible reporting
+	 * device the bridge will be NULL, i.e., no RCEC, no Downstream Port.
+	 */
 	if (bridge->subordinate)
 		pci_walk_bus(bridge->subordinate, cb, userdata);
+	else if (bridge->rcec)
+		cb(bridge->rcec, userdata);
 	else
 		cb(bridge, userdata);
 }
@@ -194,12 +200,6 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_dbg(bridge, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bridge(bridge, report_frozen_detected, &status);
-		if (type == PCI_EXP_TYPE_RC_END) {
-			pci_warn(dev, "subordinate device reset not possible for RCiEP\n");
-			status = PCI_ERS_RESULT_NONE;
-			goto failed;
-		}
-
 		status = reset_subordinates(bridge);
 		if (status != PCI_ERS_RESULT_RECOVERED) {
 			pci_warn(bridge, "subordinate device reset failed\n");
-- 
2.28.0

