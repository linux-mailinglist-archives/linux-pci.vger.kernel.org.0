Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744DB539E91
	for <lists+linux-pci@lfdr.de>; Wed,  1 Jun 2022 09:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350240AbiFAHkh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jun 2022 03:40:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347535AbiFAHke (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2022 03:40:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D313B986FC
        for <linux-pci@vger.kernel.org>; Wed,  1 Jun 2022 00:40:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=bSZC4FSJofuI+VV+ZJCRH6usaWL11Vlq3/ZzErlcnB4=; b=j4c1tZLc3QRl+M2NWB2i3JY0tZ
        L3damVHL7zlt6MRdnzb/+CF0VDbwjW4IDjWrYLqmw6L74rZt2VZ4DcVMTr62UcRnW6ZY4Km6YymjX
        G3RaD5SWNgPYoGwLYnL8aoyupFugP2br5FpbImVOkzCVmIubwkGjGm+WQNMG6A7c350FBmDTHYdTd
        QdJJ6qPNB1PTzvmp75dfEmGce2NDt30IqKX86j/1aLvuk6g8j7oPd2B6oUlezAsd5Cd4UFFnXWMQU
        kYNdsjI4VCkzspD7X7srymSzFBGjdBb+TS5a6WVKLQ7JadH40zZ9mTYCtvLyZOv/1ZokKbeqY7Paa
        pN3ia4tg==;
Received: from [2001:4bb8:185:a81e:471a:4927:bd2e:6050] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nwIxu-00EQJW-JI; Wed, 01 Jun 2022 07:40:27 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     ruscur@russell.cc, oohall@gmail.com, bhelgaas@google.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        kbusch@kernel.org
Subject: [PATCH] PCI/ERR: handle disconnected devices in report_error_detected
Date:   Wed,  1 Jun 2022 09:40:24 +0200
Message-Id: <20220601074024.3481035-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When a device is already unplugged by pciehp by the time that the AER
handler is invoked, the PCIe device will lready be in the
pci_channel_io_perm_failure state.  In that case we should simply
return PCI_ERS_RESULT_DISCONNECT instead of trying to do a state
transition that will fail.

Also untangle the state transition failure from the lack of methods to
improve the debugging output in case it will happen ever again.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/pcie/err.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 0c5a143025af4..59c90d04a609a 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -55,10 +55,14 @@ static int report_error_detected(struct pci_dev *dev,
 
 	device_lock(&dev->dev);
 	pdrv = dev->driver;
-	if (!pci_dev_set_io_state(dev, state) ||
-		!pdrv ||
-		!pdrv->err_handler ||
-		!pdrv->err_handler->error_detected) {
+	if (pci_dev_is_disconnected(dev)) {
+		vote = PCI_ERS_RESULT_DISCONNECT;
+	} else if (!pci_dev_set_io_state(dev, state)) {
+		pci_info(dev, "can't recover (state transition %u -> %u invalid)\n",
+			dev->error_state, state);
+		vote = PCI_ERS_RESULT_NONE;
+	} else if (!pdrv || !pdrv->err_handler ||
+		   !pdrv->err_handler->error_detected) {
 		/*
 		 * If any device in the subtree does not have an error_detected
 		 * callback, PCI_ERS_RESULT_NO_AER_DRIVER prevents subsequent
-- 
2.30.2

