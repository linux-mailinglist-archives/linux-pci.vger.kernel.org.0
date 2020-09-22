Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12CAF274B65
	for <lists+linux-pci@lfdr.de>; Tue, 22 Sep 2020 23:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgIVVqB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Sep 2020 17:46:01 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:37203 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726763AbgIVVpu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Sep 2020 17:45:50 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 1AC0F5C0185;
        Tue, 22 Sep 2020 17:39:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 22 Sep 2020 17:39:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=la5jToBt8q9PRytey4reAvvjJgf9Zx4zizrgsmeICRE=; b=C/aSg
        xU3HwJ7ZJ1wJub1rRyt2Haly0I6dNpGMsiioRC/BUfUt1g7qggIZxPxaB0Esju/1
        QgB6IZ4zBlwNUp32hhhr9Jz6zPfwIVsXJmyjuPZJTs5qTS52VGMMxPH5J4Ck2yEX
        DBpExLCvSedXF7jDzmuEvIhnXb982iMRM+9omDX4E4FHBNBpBvopnhSFM6Afmu9o
        7SW0BuEs21mWzxaOiv2JGeL3utdLVxWFiHJTc7Q+FVGv7885sn9/dnrssGavTIyw
        P9PI/0kRbKcqJ0Q9HgsdaP8iIUJDgvj4VWARB8IKjZXU9qutu1cfpd5FhwsYIjKT
        hVLzFU9aqIfNIESIQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=la5jToBt8q9PRytey4reAvvjJgf9Zx4zizrgsmeICRE=; b=D8AwpIuo
        K9jxMnfmDIINZisJsTjpgpr5yDEBCZ1VCpP4nT40qoNYBPjWOYzuqnMm/MQMfKSP
        UO+xWRAqruBxfPgTP9KGRf+j//8WvlDW8HyGc2xTNrZKzBS9d1cnHEUlIED7iXqi
        pOddSQlGVRbJlK2fWXbKWXdWRceQj6yWeRI828UV7bQ3l6e6OFMt7mtVkigFoQsm
        TO1Mv29U6eoW2yxg+0HADQpWmAoMTLSBbLGof3LAvUzh1FRb+46HX/RGI3fDk3ml
        9BWnqQBhfrs+uXty+72VjmHpNA/H+jXgBJK0GdxffyyI/ImHSfD85eRlPAEeZqlk
        2hScY+wGP3Ty/w==
X-ME-Sender: <xms:Am9qX4e_M3OI40mVg0i0FBne52SiwCFh-LOmg00aZDopsRgw60_QZw>
    <xme:Am9qX6PyhXUvIt36d45yxfZIhF_yj7IVQE3GViymXJtpGcBZfUkh4AUd3CYxnTE6x
    s9rB8CCOBq0q_Bc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeggdduieefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgjfhgggfestdekre
    dtredttdenucfhrhhomhepufgvrghnucggucfmvghllhgvhicuoehsvggrnhhvkhdruggv
    vhesohhrvghgohhnthhrrggtkhhsrdhorhhgqeenucggtffrrghtthgvrhhnpeehkeffte
    eiudeiffelkeelvefftdelhfeitdeigeffleeufedvgfegvdefvedtteenucfkphepvdeg
    rddvtddrudegkedrgeelnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrg
    hilhhfrhhomhepshgvrghnvhhkrdguvghvsehorhgvghhonhhtrhgrtghkshdrohhrgh
X-ME-Proxy: <xmx:Am9qX5gZq2GGiexFZ252oFLJPLJ2_1TmJWG-8gRb8xp-mmKbQwGhQA>
    <xmx:Am9qX9_h2_sMdjVmaBGT5pbqZn5HvBTBlEQIzyqVJABzLEu64bcgMA>
    <xmx:Am9qX0tKZaFyNA2SKIyWpIr2XOmooV2bB0STPsu2JmsGpeRgPpakUg>
    <xmx:A29qX4gUPLyUG54-mvlo4TyxWv9fzQC7p6vk5t_suMKWglpAp27Q0Q>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id 41170306467D;
        Tue, 22 Sep 2020 17:39:13 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 05/10] PCI/AER: Apply function level reset to RCiEP on fatal error
Date:   Tue, 22 Sep 2020 14:38:54 -0700
Message-Id: <20200922213859.108826-6-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200922213859.108826-1-seanvk.dev@oregontracks.org>
References: <20200922213859.108826-1-seanvk.dev@oregontracks.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

Attempt to do function level reset for an RCiEP associated with an
RCEC device on fatal error.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
 drivers/pci/pcie/err.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index e575fa6cee63..5380ecc41506 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -169,6 +169,17 @@ static void pci_bridge_walk(struct pci_dev *bridge, int (*cb)(struct pci_dev *,
 		cb(bridge, userdata);
 }
 
+static pci_ers_result_t flr_on_rciep(struct pci_dev *dev)
+{
+	if (!pcie_has_flr(dev))
+		return PCI_ERS_RESULT_NONE;
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
 		pci_bridge_walk(bridge, report_frozen_detected, &status);
 		if (type == PCI_EXP_TYPE_RC_END) {
-			pci_warn(dev, "link reset not possible for RCiEP\n");
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
 		pci_bridge_walk(bridge, report_normal_detected, &status);
-- 
2.28.0

