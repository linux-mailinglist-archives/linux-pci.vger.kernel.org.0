Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17311281B36
	for <lists+linux-pci@lfdr.de>; Fri,  2 Oct 2020 20:56:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733260AbgJBS4g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Oct 2020 14:56:36 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:57357 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387688AbgJBS4g (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Oct 2020 14:56:36 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id B64C35C014F;
        Fri,  2 Oct 2020 14:48:10 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Fri, 02 Oct 2020 14:48:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=VzqaRORlnEuUozDef6epiKpVS9HjyrVB/kcqBdBNMb4=; b=aXSPD
        jheA7ApwpWlTw1ywXB2zCGx6yJU7ozRRih2Zju3IfBNENeldFYkhQBXN+AMDQrer
        XhJMIkdtzMMa2amIPhiRJI+ctmsWpK6pnn99eYZ4ik+aqRad2058RxKRNPR4KwSZ
        L978rN8H5KAWjfEXpMkfpFMm62QrFilSkjCwZcDwvEpBwFLdYzWvCnAOPNvu6y/R
        CmSiZSP5yohTJ48LZtvRh4PrSvrFmGYukX1hRQ6Uo/fpgxm1s+OcsifkVXCGg3sW
        dCmQDPiOdHsbkVC65fsr14Wr8ZzWNH2gZ4uHYzbaKk3VUQzb2CJ0aI8jea7uLuiM
        r1RkteZicvuu718aw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=VzqaRORlnEuUozDef6epiKpVS9HjyrVB/kcqBdBNMb4=; b=e+kAEgdJ
        6lw38/wURiwpEBbrIodIIDFNpe3WmsWr4N1nrKk5Cii0qpAnnPmyI8VKW4JFBbwB
        oP2ZFhq5jVQ4lGLxviTYEd+PdzqQjVBodoM4XJN+SpG/yeCmDOd5huWA1vnyPy5s
        b1cil9pUrVWnH+iGrxS6RbenKUbdBUHu1mLosrDfFuE6lk7TPj6fCkHnDf0BZx9G
        +0ktmnixJNuE4wzQW4rw1v/U9erBclDsHc2SRro8Lky+Y1M2+GS4Qc67sp9d0zmd
        AmoZSemIVGyhZ3U6F0jhp3L/mrpYfrsvzn4G1OzzfecvkfeDtDWPGWRmjSqBXknd
        GRWsxHPsrZSHlA==
X-ME-Sender: <xms:6nV3X1dUhedJ_WVTiUAphfBZmj6rl9q9_Co16al4Keg8k4IcgCLHFg>
    <xme:6nV3XzMvtdc-pbEHl7FK0wqKo43OrwMqxw10IuhDkv2zQ8x-1KriwsLRjaeHNCJW0
    Y7xWj5CRbvk4JD0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeeigdduvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepufgvrghnucggucfmvghllhgvhicuoehsvggrnhhvkhdruggv
    vhesohhrvghgohhnthhrrggtkhhsrdhorhhgqeenucggtffrrghtthgvrhhnpeehkeffte
    eiudeiffelkeelvefftdelhfeitdeigeffleeufedvgfegvdefvedtteenucfkphepvdeg
    rddvtddrudegkedrgeelnecuvehluhhsthgvrhfuihiivgepkeenucfrrghrrghmpehmrg
    hilhhfrhhomhepshgvrghnvhhkrdguvghvsehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:6nV3X-hC8VQ7RwwJhiuYn0yXMHOphMc_3PIaylzGRj1Qasks36Q-1A>
    <xmx:6nV3X-9YmQ-kZNM6g8Ve_l5ZOBcIOvv8AdGm24oexHXfh0HKaa9MQA>
    <xmx:6nV3XxtcyeTfqdeR5bc03_Wq0ZnvwaxvgFeShp9tyOVJ6toq1CFzpg>
    <xmx:6nV3X1h9XFa9E1a9p4SQgqA5OJ-jtsIlaVEJoK4-Fq59U3H5Ag-owQ>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 56736306468B;
        Fri,  2 Oct 2020 14:48:08 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 09/14] PCI/AER: Apply function level reset to RCiEP on fatal error
Date:   Fri,  2 Oct 2020 11:47:30 -0700
Message-Id: <20201002184735.1229220-10-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201002184735.1229220-1-seanvk.dev@oregontracks.org>
References: <20201002184735.1229220-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Attempt to do a function level reset for an RCiEP on fatal error.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/pci/pcie/err.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index c4ceca42a3bf..38abd7984996 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -169,6 +169,17 @@ static void pci_walk_bridge(struct pci_dev *bridge, int (*cb)(struct pci_dev *,
 		cb(bridge, userdata);
 }
 
+static pci_ers_result_t flr_on_rciep(struct pci_dev *dev)
+{
+	if (!pcie_has_flr(dev))
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	if (pcie_flr(dev))
+		return PCI_ERS_RESULT_DISCONNECT;
+
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
 pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 			pci_channel_state_t state,
 			pci_ers_result_t (*reset_subordinate_devices)(struct pci_dev *pdev))
@@ -195,15 +206,17 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bridge(bridge, report_frozen_detected, &status);
 		if (type == PCI_EXP_TYPE_RC_END) {
-			pci_warn(dev, "subordinate device reset not possible for RCiEP\n");
-			status = PCI_ERS_RESULT_NONE;
-			goto failed;
-		}
-
-		status = reset_subordinate_devices(bridge);
-		if (status != PCI_ERS_RESULT_RECOVERED) {
-			pci_warn(dev, "subordinate device reset failed\n");
-			goto failed;
+			status = flr_on_rciep(dev);
+			if (status != PCI_ERS_RESULT_RECOVERED) {
+				pci_warn(dev, "function level reset failed\n");
+				goto failed;
+			}
+		} else {
+			status = reset_subordinate_devices(bridge);
+			if (status != PCI_ERS_RESULT_RECOVERED) {
+				pci_warn(dev, "subordinate device reset failed\n");
+				goto failed;
+			}
 		}
 	} else {
 		pci_walk_bridge(bridge, report_normal_detected, &status);
-- 
2.28.0

