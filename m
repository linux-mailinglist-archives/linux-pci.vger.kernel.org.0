Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05CA727F4B4
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 23:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731517AbgI3V7C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 17:59:02 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:36763 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731449AbgI3V6q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 17:58:46 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 5EB2FF91;
        Wed, 30 Sep 2020 17:58:45 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 30 Sep 2020 17:58:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=tT8iefN0DZLkQy3RYltQh7+08jyLmhJbKfd+pB35+I4=; b=N8ok4
        Tc1qxKHAqLE9QCISIGD+I1b45FnqrQowBipCsKYlxR8LO9hQhgA4010T3UVMICXX
        Hjy9fzeS8Naq/DZbKbNFg95VSrUtH5UQuySW63aQPZNVeJJ9Nyyaf+FxkrU4p5Yh
        Tk5Fv3UCXjmZdJJjU3QNM1vnw1zodiXKt8jt/5Hs1kyIU87S5VNYWcJXtaWMdqWl
        8xul+rEjQAdEafFxj/c+fs+ZHExbmU8R+2zYG/J8b+O8hAsaPbvSbpCLkiy0QWDS
        ms/dwJtuZBvLnaT8Mwxw3yG918IHBc+2Rx08JRy3iHyiiuedQL/qDftw5GPTwbS6
        JnNtGaN+6sV20qzKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=tT8iefN0DZLkQy3RYltQh7+08jyLmhJbKfd+pB35+I4=; b=DHXJpYpv
        rZWNPL/l0P/ArpDLhs/sDGsdJm0jT5x2a4/fBgKNaM2YgkA3Jz4JsLk0G/BVlqLo
        RisFXJ4jmZ+6apZ6AbmxkwKO+JcZXKNewCc3kInhPY25yt/GJNN+Zh5K26nwRKur
        l9rlD2gIu+tpQJpEcp20fjjORXkxGISHDMGbSQ0n8etWoTHpCCxgovWjlL5rQlb1
        p9z2MO+gsQucEqbpJp8nKlVmV0+xICxxE9DxOvVz7u4VztNBmYCM1AwHJCxps+1w
        RGRFOWlvptyxJdDQ9S2WpxmUT4Ya6Yt8N20ADbOKt6EXb6BAkTruT1RVPVwqtte/
        CDbpmDo3GUbRbQ==
X-ME-Sender: <xms:lP90X7D_PgTkgVZM-9n_JDEo19ep5UYtRLSiEa5Q2-hyZxnzcbhBiQ>
    <xme:lP90XxgawQZTnGEYVThVRt48DQkwoOrSdK6kQeHgqqAUWbfLDwVbQIcQlzpialRpj
    kvYzGlXtnYznSuM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefuvggrnhcuggcumfgvlhhlvgihuceoshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgheqnecuggftrfgrthhtvghrnhepheekffetie
    duieffleekleevffdtlefhiedtieegffelueefvdfggedvfeevtdetnecukfhppedvgedr
    vddtrddugeekrdegleenucevlhhushhtvghrufhiiigvpeeinecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehsvggrnhhvkhdruggvvhesohhrvghgohhnthhrrggtkhhsrdhorhhg
X-ME-Proxy: <xmx:lP90X2kEKjPqfZjL2O9MaDPWCiZTTA-esiXVKDrQpuP3AynR_eqbsg>
    <xmx:lP90X9yiiexmSwSeJVVhjsfk8rQ4fsbYMdWJwfZqapstdKpM9LfBYw>
    <xmx:lP90XwTE_4XDcC1AoahVRNmxbteCPG_4pVlD9zgqbDuvZBk-Hn4aGg>
    <xmx:lf90X1Rahf6_pguEx_0UoYzhNc8V2SH6zDSNKw8rNZGqir9bEeV2cg>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8FD4D3280059;
        Wed, 30 Sep 2020 17:58:43 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v7 10/13] PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
Date:   Wed, 30 Sep 2020 14:58:17 -0700
Message-Id: <20200930215820.1113353-11-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
References: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
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

