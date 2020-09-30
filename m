Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F06CE27F4A5
	for <lists+linux-pci@lfdr.de>; Wed, 30 Sep 2020 23:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbgI3V6o (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Sep 2020 17:58:44 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:34151 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731388AbgI3V6n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Sep 2020 17:58:43 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id A8391F8F;
        Wed, 30 Sep 2020 17:58:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Wed, 30 Sep 2020 17:58:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        oregontracks.org; h=from:to:cc:subject:date:message-id
        :in-reply-to:references:mime-version:content-transfer-encoding;
         s=fm1; bh=VzqaRORlnEuUozDef6epiKpVS9HjyrVB/kcqBdBNMb4=; b=DWOTJ
        9Oy6+E3TbsAPIuh7Vf8KotrLue32f9oiuY1+8namXfqbxl/3dLv4JCUgu8Rc1Zxv
        IXwUwRibzP2IhOEsYzVRjjUUE16azQblFzXggGSNT01t1rXR8WED6cQeS113MmpK
        bwP7nW1wC+ih1eq402VCdOumsccgEbr5btkxssJ6bgFYktBLzesT7+x78da8QYB0
        pn2WzWPGMc715u6XPGA2bqFwTZbQ0I/cujAGA1YcAmtEQBrwNkChDscyrZkHQ+v4
        2jIOOSHvQ4CsULTG9lpHP1AghBppM4f6r1P/ylNbi70zIXqMcP+6FU+KMNGHiZex
        SKx0uwtP8WR4N5v2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=VzqaRORlnEuUozDef6epiKpVS9HjyrVB/kcqBdBNMb4=; b=kNYhkw4E
        C44RqUVDec3riOk1TNANqEpYqWOVPogz2eeqUxlLCRspiAQcOQEWEJepnU8Gp47d
        MRac/0fwCqC1htakvtYgx8ZC8++CH28FuxkU5H9Cqqmh1j9EVk9sx4bq3wM2GzFy
        7GwBxULvmoHQHeSiGqMOSFuC3zLK/0cK4IoDJ2iOQSk1wXwaoZwlW2aPS3FS7EtL
        NRF1KxivETKPLT7rPPd8MBGh72g+R+4XpbL0DuUaEkETYEGEvk9gWK+spykdxDcP
        CIwUgVqy2nwjYN8vlWsI/mUoBfy3jFtrI+mnDjVWATpBxU/IEpTTrqrM1Hi+AoOz
        vRYUNCnApt9m4Q==
X-ME-Sender: <xms:kv90X_eRLgN0aTQ9yRFVSPitWiYDODwf0jIQ-b4GCfPm_-h_HYHchA>
    <xme:kv90X1MsojvxaCvWv-yJSe8I0t0xoV5FG5vrpse0G3VMhwJUOcIu8-BRK9X1XlMDQ
    Whs3l4JuB5wCIfD>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrfeefgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffojghfggfgsedtkeertd
    ertddtnecuhfhrohhmpefuvggrnhcuggcumfgvlhhlvgihuceoshgvrghnvhhkrdguvghv
    sehorhgvghhonhhtrhgrtghkshdrohhrgheqnecuggftrfgrthhtvghrnhepheekffetie
    duieffleekleevffdtlefhiedtieegffelueefvdfggedvfeevtdetnecukfhppedvgedr
    vddtrddugeekrdegleenucevlhhushhtvghrufhiiigvpeeinecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehsvggrnhhvkhdruggvvhesohhrvghgohhnthhrrggtkhhsrdhorhhg
X-ME-Proxy: <xmx:kv90X4jJw-VSRnPMsHnNn4cviDzLWiqNTcyHqGLLeCl7GT4o4v5dOg>
    <xmx:kv90Xw9rsLmCxBhDgZbbIpR_OMelSlhgFhAYJHQhuJs7pm60RNeG2g>
    <xmx:kv90X7vTZICmwpO8szr4G_554Bq9XPnBa8rlXSpMK5M1OaXqgTRU0A>
    <xmx:kv90X_hiUJsp2wW1-g1XyRq6Pi5TRLG4adnzP3gNA29a8aDZnDokKw>
Received: from arch-ashland-svkelley.hsd1.or.comcast.net (c-24-20-148-49.hsd1.or.comcast.net [24.20.148.49])
        by mail.messagingengine.com (Postfix) with ESMTPA id EA9E73280059;
        Wed, 30 Sep 2020 17:58:40 -0400 (EDT)
From:   Sean V Kelley <seanvk.dev@oregontracks.org>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v7 08/13] PCI/AER: Apply function level reset to RCiEP on fatal error
Date:   Wed, 30 Sep 2020 14:58:15 -0700
Message-Id: <20200930215820.1113353-9-seanvk.dev@oregontracks.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
References: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
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

