Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B926281B3F
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 20:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388321AbgJBS4j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 14:56:39 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44837 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387908AbgJBS4h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2020 14:56:37 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D31EC5C0113;
        Fri,  2 Oct 2020 14:47:59 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 02 Oct 2020 14:47:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=+L/bVLx0NzcqWSlT2sv7VJ/WBvhY/OVPot9ze0Q+R2Q=; b=UTwdZ
        yAY7Xh83C60BJrW6QCi1vX8+DuHNCRjE3wExLdXbb2/CfNxlpVJnOKgmsDLvcxnG
        XMKbm30OcT40WyTtAYF+d6rmiS0ZPyGd3mKTtdLyOruEFdrDA1+Q7ZSaiaMY1af9
        TaSB4OQaDd0mnTqQ8CgEBu0oFzO47sTnUqjkv1n2l247VeX8xVRu7fetLR16iwtX
        J3Hn/h0N4flpMnUtsMy0mXfvrbxKWg8jQ1f3WZYMhOB67WO23TRpWDA56CU801js
        8ZpqMc9cH2aT2Z4FGyAZkqtFAhStmr+vfwdHEJkYbJfZ/JgsPo2wSNlIq4GR9tt8
        abVEGRtZQR647ZZ1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=+L/bVLx0NzcqWSlT2sv7VJ/WBvhY/OVPot9ze0Q+R2Q=; b=kNI9LqB9
        HKWzGSCriaOYW/0IONW7N5Jn+agrPHSU+H+LjD+gk0w98n2ymhPxSoAwaH+anRwV
        TRpCuj+H3YSfenPhH9Zj6RUCdOx4N1EMVuqQEUTtDCo+Nt/kB3QygxX9pGd68kNr
        JWfCBRIlkr1a56ZBWmE07Zb/2VfVCw9dp/1tEcL+YJftRJWJOIDN7xAebmHvapmJ
        mYctndsfA0hqAG35piTBooDRQLW+zOiHnMZkYVqPwjefpgPXBbHxKFn/JqQXwIUU
        uVTNmcmd7p99UoV5wFQRcLRtOjSpTxM2HgP/R+y2UGBVZglb1Sr76t3n4UFSm4ev
        juw2nzAk4B0fIQ==
X-ME-Sender: <xms:33V3X9AaOtIQS1UebFEKpHUPHs0p1Q1n7Bjj6WHCay1nCVcZgq-MGw>
    <xme:33V3X7hmihaFwbOh3I9Bnlhin5S7Hwf2FaLxAiHbLyVeV5ogrjrrxl11BCvQh_Brn
    2r41gLTh3RnpB_h>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeeigdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepufgvrghnucggucfmvghllhgvhicuoehsvggrnhhvkhdruggv
    vhesohhrvghgohhnthhrrggtkhhsrdhorhhgqeenucggtffrrghtthgvrhhnpeehkeffte
    eiudeiffelkeelvefftdelhfeitdeigeffleeufedvgfegvdefvedtteenucfkphepvdeg
    rddvtddrudegkedrgeelnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepshgvrghnvhhkrdguvghvsehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:33V3X4lkNyrOOhG94y-he7HS7yaWoUdJaCOgZXm0HBtjzY5bDIp1Gg>
    <xmx:33V3X3xQGH9anklgA_Ru4SM5a2Sac0DxQc5ijMIUk_IlSrtv_EUxsg>
    <xmx:33V3XyRxPezyJ0QkndbBEPxRJX7s2YGR_4Y6yyNSpXknnHTQ_BFn5g>
    <xmx:33V3X_QOu0vN-q2neLIbCSTRVzlnVHpduFDEKMMBiF7ZwhdJFAwCxQ>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6A1873064686;
        Fri,  2 Oct 2020 14:47:58 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v8 04/14] PCI/ERR: Rename reset_link() to reset_subordinate_device()
Date:   Fri,  2 Oct 2020 11:47:25 -0700
Message-Id: <20201002184735.1229220-5-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201002184735.1229220-1-seanvk.dev@oregontracks.org>
References: <20201002184735.1229220-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sean V Kelley <sean.v.kelley@intel.com>

reset_link() appears to be misnamed. The point is to really
reset any devices below a given bridge. So rename it to
reset_subordinate_devices() to make it clear that we are
passing a bridge with the intent to reset the devices below it.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pci.h      | 2 +-
 drivers/pci/pcie/err.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 0e332a218d75..98ec87ef780d 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -574,7 +574,7 @@ static inline int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
 /* PCI error reporting and recovery */
 pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 			pci_channel_state_t state,
-			pci_ers_result_t (*reset_link)(struct pci_dev *pdev));
+			pci_ers_result_t (*reset_subordinate_devices)(struct pci_dev *pdev));
 
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 #ifdef CONFIG_PCIEASPM
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index c543f419d8f9..950612342f1c 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -148,7 +148,7 @@ static int report_resume(struct pci_dev *dev, void *data)
 
 pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 			pci_channel_state_t state,
-			pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
+			pci_ers_result_t (*reset_subordinate_devices)(struct pci_dev *pdev))
 {
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
 	struct pci_bus *bus;
@@ -165,9 +165,9 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_dbg(dev, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bus(bus, report_frozen_detected, &status);
-		status = reset_link(dev);
+		status = reset_subordinate_device(dev);
 		if (status != PCI_ERS_RESULT_RECOVERED) {
-			pci_warn(dev, "link reset failed\n");
+			pci_warn(dev, "subordinate device reset failed\n");
 			goto failed;
 		}
 	} else {
-- 
2.28.0

