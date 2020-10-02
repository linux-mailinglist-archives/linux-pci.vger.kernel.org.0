Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D75B281B3E
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 20:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387908AbgJBS4j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 14:56:39 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:41001 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387929AbgJBS4g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2020 14:56:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 31C4D5C014E;
        Fri,  2 Oct 2020 14:48:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 02 Oct 2020 14:48:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=k17DVN24cWKAsiO1uGgbkyxB3+DEX3Kdzvq1wfhTv0E=; b=YoEBG
        /5ihulEgAY2/+8kczm/4/3Wa1YdgV7zkbU8CSRsfTp4rYoJaytl3v/BB8tpJneIJ
        mzPI1B63MuR1GAi2fdEFgk5dL6PoZ6vz8iKpnSLF5TaEGRuEqStIGmlMrS8odlSB
        vh1Rhcnx6WpzoRMkBB2iaJ1ymnIDJzW/GKgw/ZCx8mcK5nvqzAMGB3NoUWAfZ78/
        J7roeQlmB7BHXFYKKHFrdvXhGrkfwtgu9lBFKleMcy8jiR+8bXxUAPy0KFDSuvLG
        2pwiGFrpGAldnuAGoBP+IZUQdZ+wj27SyyGPbpO61S7QWp/UX/ia1LaBQZf6CJsc
        8a1/aBwU4PJBCQnJQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=k17DVN24cWKAsiO1uGgbkyxB3+DEX3Kdzvq1wfhTv0E=; b=Z5EFOgT3
        WjSOJXLFWB6LUrYpP4pIDQzi9b3ReIwbwFRyKkq+fKq3y8PSGIaMh5YwpWwvqqpK
        +WakIRBc1qkjFTadd9lhu3qiqk4HqZVT0S+6zrkTN4jJ1qt6nwxiXD6cM4xovfhQ
        hvF1JkEVfDUzIwh3VSJID50gXp4Jfm2KsEFYV232VAi+tkeyQsQ1hGxRntm6t+zl
        RJ3DqOpiJJ8Z+Sj+lGIStbcDMzzW2aEky+uCFc4h31r5TcD2X5Wio8ZdyA/by26h
        5/gv3ygak0VcQ3f8tIsn4+ZbLpZVoo7iA04XXBnlbMgygpQQ7ZnewXiuthWodM8o
        un2NJ80K3mVGiA==
X-ME-Sender: <xms:5nV3X95w1Wwu7XxtX8g6p1ZwRg7DZgJt-9uTZ8cQmwXaLOtR45JRHg>
    <xme:5nV3X66e5vI7ewbDVK_BqWIUGnGKG5FQOjX0tK1eGYtMVXjlnFSL6ZgHlSRvvcFTL
    dptQD2osHD_QiUD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeeigdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepufgvrghnucggucfmvghllhgvhicuoehsvggrnhhvkhdruggv
    vhesohhrvghgohhnthhrrggtkhhsrdhorhhgqeenucggtffrrghtthgvrhhnpeehkeffte
    eiudeiffelkeelvefftdelhfeitdeigeffleeufedvgfegvdefvedtteenucfkphepvdeg
    rddvtddrudegkedrgeelnecuvehluhhsthgvrhfuihiivgepieenucfrrghrrghmpehmrg
    hilhhfrhhomhepshgvrghnvhhkrdguvghvsehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:5nV3X0c8isJlz5tIbfonBGtjJrTFDGfukQzFhicjNLI9sFzcH1ex_g>
    <xmx:5nV3X2LgWm8VIIvBE7_808RKQ1wHrjwYGSQS-A2b1lHEh-X7PRoDFA>
    <xmx:5nV3XxJa5SEWorWZdNPr38OyM1xh906_aegupY1CcyGh-JChev3vhQ>
    <xmx:5nV3X2owDZM1WBavBXgleu8lcLgvI8xX57O0o3eM9DbQ3k6bxylEIw>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id C9C1B306468E;
        Fri,  2 Oct 2020 14:48:03 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v8 07/14] PCI/ERR: Limit AER resets in pcie_do_recovery()
Date:   Fri,  2 Oct 2020 11:47:28 -0700
Message-Id: <20201002184735.1229220-8-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201002184735.1229220-1-seanvk.dev@oregontracks.org>
References: <20201002184735.1229220-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sean V Kelley <sean.v.kelley@intel.com>

In some cases a bridge may not exist as the hardware
controlling may be handled only by firmware and so is
not visible to the OS. This scenario is also possible
in future use cases involving non-native use of RCECs
by firmware. So explicitly apply conditional logic
around these resets by limiting them to root ports and
downstream ports.

Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pcie/err.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 9b2130725ab6..5ff1afa4763d 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -218,9 +218,12 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_dbg(dev, "broadcast resume message\n");
 	pci_walk_bridge(bridge, report_resume, &status);
 
-	if (pcie_aer_is_native(bridge))
-		pcie_clear_device_status(bridge);
-	pci_aer_clear_nonfatal_status(bridge);
+	if (type == PCI_EXP_TYPE_ROOT_PORT ||
+	    type == PCI_EXP_TYPE_DOWNSTREAM) {
+		if (pcie_aer_is_native(bridge))
+			pcie_clear_device_status(bridge);
+		pci_aer_clear_nonfatal_status(bridge);
+	}
 	pci_info(dev, "device recovery successful\n");
 	return status;
 
-- 
2.28.0

