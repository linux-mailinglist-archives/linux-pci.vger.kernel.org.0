Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09CE46DC23
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 20:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235169AbhLHT2l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 14:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234463AbhLHT2j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 14:28:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C012C061746;
        Wed,  8 Dec 2021 11:25:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5EC1B8226E;
        Wed,  8 Dec 2021 19:25:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F03C341CA;
        Wed,  8 Dec 2021 19:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638991504;
        bh=oQFwcN3lUVqm/QC2mXvvhW5W+70BEyg1ywIOR6zcnUA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Er+Q1gw7uO6ekkXfxvesyhl0sDJc2L88xfrJ9wikppnjwxdUtHuWJ1M4Ug2G1vg6c
         OasEocccOiD6b1dkjTCUPwycDkzI+7enwlP0auOvCeOak81HmRHZZMueMFxNKp+F8z
         mhtLsz2Ziml5LCktjoP1ukZynuoryu6Ta8FI9HDTRq3+9B7aRZ4yfJR/71v2BEtrLI
         ONgouI3WDZd4zPqzgTOo+NrpccETm9qqn5IQIdlha+hS3i2ohjqt5XJtZ8fmfi8wHa
         CUEFLukDCUNmXrap8fprOPbxX/J9R2o7v6z272V+ugZ4Vh+jix6GI96ukgk8+IOKPz
         egp4XBjhWCRSQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jens Axboe <axboe@kernel.dk>,
        Joshua Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v5 1/4] mtip32xx: remove pointless drvdata checking
Date:   Wed,  8 Dec 2021 13:24:46 -0600
Message-Id: <20211208192449.146076-2-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211208192449.146076-1-helgaas@kernel.org>
References: <20211208192449.146076-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The .suspend() and .resume() methods are only called after the .probe()
method (mtip_pci_probe()) has set the drvdata and returned success.

Therefore, if we get to mtip_pci_suspend() or mtip_pci_resume(), the
drvdata must be valid.  Drop the unnecessary checking.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/block/mtip32xx/mtip32xx.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index c91b9010c1a6..8677ac4c3431 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -4150,12 +4150,6 @@ static int mtip_pci_suspend(struct pci_dev *pdev, pm_message_t mesg)
 	int rv = 0;
 	struct driver_data *dd = pci_get_drvdata(pdev);
 
-	if (!dd) {
-		dev_err(&pdev->dev,
-			"Driver private datastructure is NULL\n");
-		return -EFAULT;
-	}
-
 	set_bit(MTIP_DDF_RESUME_BIT, &dd->dd_flag);
 
 	/* Disable ports & interrupts then send standby immediate */
@@ -4189,14 +4183,7 @@ static int mtip_pci_suspend(struct pci_dev *pdev, pm_message_t mesg)
 static int mtip_pci_resume(struct pci_dev *pdev)
 {
 	int rv = 0;
-	struct driver_data *dd;
-
-	dd = pci_get_drvdata(pdev);
-	if (!dd) {
-		dev_err(&pdev->dev,
-			"Driver private datastructure is NULL\n");
-		return -EFAULT;
-	}
+	struct driver_data *dd = pci_get_drvdata(pdev);
 
 	/* Move the device to active State */
 	pci_set_power_state(pdev, PCI_D0);
-- 
2.25.1

