Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AF54EA828
	for <lists+linux-pci@lfdr.de>; Tue, 29 Mar 2022 08:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbiC2G5x (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Mar 2022 02:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233179AbiC2G5w (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Mar 2022 02:57:52 -0400
Received: from ha.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8C3D82E08B;
        Mon, 28 Mar 2022 23:56:08 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by ha.nfschina.com (Postfix) with ESMTP id 875C01E80D78;
        Tue, 29 Mar 2022 14:55:33 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from ha.nfschina.com ([127.0.0.1])
        by localhost (ha.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id SzzPa-VjaOV5; Tue, 29 Mar 2022 14:55:30 +0800 (CST)
Received: from localhost.localdomain (unknown [61.152.154.52])
        (Authenticated sender: renyu@nfschina.com)
        by ha.nfschina.com (Postfix) with ESMTPA id 9F43E1E80D70;
        Tue, 29 Mar 2022 14:55:30 +0800 (CST)
From:   Ren Yu <renyu@nfschina.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, yuzhe@nfschina.com,
        Ren Yu <renyu@nfschina.com>
Subject: [PATCH] pci: check the function request_region return value
Date:   Tue, 29 Mar 2022 14:56:02 +0800
Message-Id: <20220329065602.262316-1-renyu@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When the function request_region return NULL,add a waring message

Signed-off-by: Ren Yu <renyu@nfschina.com>
---
 drivers/pci/quirks.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index da829274fc66..27f9eb459051 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -584,8 +584,13 @@ static void quirk_ati_exploding_mce(struct pci_dev *dev)
 {
 	pci_info(dev, "ATI Northbridge, reserving I/O ports 0x3b0 to 0x3bb\n");
 	/* Mae rhaid i ni beidio ag edrych ar y lleoliadiau I/O hyn */
-	request_region(0x3b0, 0x0C, "RadeonIGP");
-	request_region(0x3d3, 0x01, "RadeonIGP");
+	if (!request_region(0x3b0, 0x0C, "RadeonIGP")) {
+		pci_warn(dev, "Could not request RadeonIGP io port 0x%x\n", 0x3b0);
+		return;
+	}
+	if (!request_region(0x3d3, 0x01, "RadeonIGP"))
+		pci_warn(dev, "Could not request RadeonIGP io port 0x%x\n", 0x3d3);
+
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI,	PCI_DEVICE_ID_ATI_RS100,   quirk_ati_exploding_mce);
 
-- 
2.25.1

