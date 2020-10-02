Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F9D281B44
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 20:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387806AbgJBS4l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 14:56:41 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:33881 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725991AbgJBS4g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2020 14:56:36 -0400
X-Greylist: delayed 523 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Oct 2020 14:56:35 EDT
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 2AF485C0154;
        Fri,  2 Oct 2020 14:48:08 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 02 Oct 2020 14:48:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=dmuUM23EPHsYPhkgKH73wmuIoV0cSfp+zz0aR4jDCFE=; b=XOV0r
        nFhNFbsbFdgg1c/bWkc1F+ONQhmvE2gVjXJDCUOsGTOg0WBmFJzJkNXTFD17esFS
        3C7YcfdV+6tItk2bEEPDQKfp5Bfy3zBpEc4KNu9kZ57yWqlk1CoeylXDbB9clwFa
        Bn/khgTUGRA8g+JwvxL9Jc6yWB4MnMpGY7B81KrKlBTUiXf82hmCKiavRya6ZJfx
        T3siILKPxX0HaEs081fRpWLHmxyl3k6NFu4sU4mzLVFXsKemV1BdgcUCZvywHBWc
        ZC8rVCYUTR9IVnLzomNBMBTVb7N7M2v2EEXh6Ep5ZpUnQ/7J8OB3Xvl+UkYQXu+N
        S0TWWSIp3ruZiS8hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=dmuUM23EPHsYPhkgKH73wmuIoV0cSfp+zz0aR4jDCFE=; b=kMHVvR0P
        uFIXa5ZuOMi/mZI0MIJ2KRus48msDxPxsEI6uMbVJ+TilYPOZg6877ynClBJPnZI
        TID/cVkdBfqOLy2gUVNTjsA/KGiOW3UOmV8j+3lEkzO2jHNA6ODfUFujZ/2Vd11+
        Mp0nuxufeqzueSomdnvi7ys6ivJ32LPHqLJL7mAG8rYQKRrzZyKdVDSI2JAv1gnj
        HEpSxH4l6hGlmKLU35sqrxsAHeoycUIQuM5yZ0M6HZgCSruiDSMcrfX21JzTyoup
        rK732vnSZT05jbcCxARgDlQ76DV4CMPdftchJ5qPr795hzL5ef6aArYD5F+Ry/0h
        KXD0ZprVAcIPFg==
X-ME-Sender: <xms:6HV3X7qK-jhsXGYmUDRdwGfY439R8OVh-bvS5TzGaUrT99i_VKfzww>
    <xme:6HV3X1pJvtIIVpF2jHXoezv9szzPlI0l6f6HxiA7e4jusL2jkU81I0Z3LY3oKwvwd
    B1xAq2LHi_bcWLo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeeigdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepufgvrghnucggucfmvghllhgvhicuoehsvggrnhhvkhdruggv
    vhesohhrvghgohhnthhrrggtkhhsrdhorhhgqeenucggtffrrghtthgvrhhnpeehkeffte
    eiudeiffelkeelvefftdelhfeitdeigeffleeufedvgfegvdefvedtteenucfkphepvdeg
    rddvtddrudegkedrgeelnecuvehluhhsthgvrhfuihiivgepieenucfrrghrrghmpehmrg
    hilhhfrhhomhepshgvrghnvhhkrdguvghvsehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:6HV3X4NvRFP6CVWYa0JVleurThFqjxdtgOBjsWMV4NW9vp_9uq9Wtw>
    <xmx:6HV3X-6Y-ps4HYd9IiU1eUAXAFA6TPN1agkFDw1tIv1NdOdMaejSWw>
    <xmx:6HV3X661xCq3Z0Dbcsap_QjBIZPYOKTjmZixCPPg2Cxc91dOglzNYA>
    <xmx:6HV3XxbeFO4iR-YPIKPm_fE6YtyZDkjtRtC9ZQgoLbw0RKzeFxOWvw>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 32E59306468B;
        Fri,  2 Oct 2020 14:48:06 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v8 08/14] PCI/AER: Extend AER error handling to RCECs
Date:   Fri,  2 Oct 2020 11:47:29 -0700
Message-Id: <20201002184735.1229220-9-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201002184735.1229220-1-seanvk.dev@oregontracks.org>
References: <20201002184735.1229220-1-seanvk.dev@oregontracks.org>
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

Modify pci_walk_bridge() to handle devices which lack a subordinate bus.
If the device does not then it will call the function on that device
alone.

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
 drivers/pci/pcie/err.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 5ff1afa4763d..c4ceca42a3bf 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -148,19 +148,25 @@ static int report_resume(struct pci_dev *dev, void *data)
 
 /**
  * pci_walk_bridge - walk bridges potentially AER affected
- * @bridge   bridge which may be a Port.
+ * @bridge   bridge which may be an RCEC with associated RCiEPs,
+ *           an RCiEP associated with an RCEC, or a Port.
  * @cb       callback to be called for each device found
  * @userdata arbitrary pointer to be passed to callback.
  *
  * If the device provided is a bridge, walk the subordinate bus,
  * including any bridged devices on buses under this bus.
  * Call the provided callback on each device found.
+ *
+ * If the device provided has no subordinate bus, call the provided
+ * callback on the device itself.
  */
 static void pci_walk_bridge(struct pci_dev *bridge, int (*cb)(struct pci_dev *, void *),
 			    void *userdata)
 {
 	if (bridge->subordinate)
 		pci_walk_bus(bridge->subordinate, cb, userdata);
+	else
+		cb(bridge, userdata);
 }
 
 pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
@@ -174,11 +180,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
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
@@ -186,7 +194,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_dbg(dev, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bridge(bridge, report_frozen_detected, &status);
-		status = reset_subordinate_device(bridge);
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
@@ -219,7 +233,8 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_walk_bridge(bridge, report_resume, &status);
 
 	if (type == PCI_EXP_TYPE_ROOT_PORT ||
-	    type == PCI_EXP_TYPE_DOWNSTREAM) {
+	    type == PCI_EXP_TYPE_DOWNSTREAM ||
+	    type == PCI_EXP_TYPE_RC_EC) {
 		if (pcie_aer_is_native(bridge))
 			pcie_clear_device_status(bridge);
 		pci_aer_clear_nonfatal_status(bridge);
-- 
2.28.0

