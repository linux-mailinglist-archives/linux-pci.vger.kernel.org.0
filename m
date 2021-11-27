Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168BB45FAB5
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 02:31:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbhK0BeB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 20:34:01 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40502 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350144AbhK0BcA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 20:32:00 -0500
Message-ID: <20211126232735.489750235@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=D1PGUTvbMCo12qSm9MpHyC/iszyAeQMlmvbSI9Ov2K8=;
        b=dSOefgEzVF3y0kFgrBELTV78fRT2lvmklMRud2O8mTwCq1fooqITSW6M0o7Y1Ikoq6ZQgE
        9lk4I+5L6XyUZDCm5WVLnAbSqz/C00eGpmuyJSiRTwCy1/gYpH38PfBD+eZjope/mcuEZY
        Odm0tP/s6oSiFqLTWxH+vBCrptn6ud5dBR293EPQtv3luwM+554i5ZfZSS5OKWCTfRXkk3
        VaKTFgeK5qhGhBVvvZYKycFTW3I+Cxa+jxVibbGjfhD7fyWmf4lBimd1YrS2cob1apVBBk
        bje7cFpIi1OAHzZOid9MfC31Sn+QAtrkCI9oV5Wj9e6Mnif9NN7Z/f/w0DIJnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=D1PGUTvbMCo12qSm9MpHyC/iszyAeQMlmvbSI9Ov2K8=;
        b=nFhopcGPYBSKoeH9CKS3nz+cxdVkftjHUy8fitQVgZ3dwO0mFLrSoZ7n4NnE11nUsB6YgH
        PRseupyvssZHNJAw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: [patch 20/32] PCI: hv: Rework MSI handling
References: <20211126230957.239391799@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:22:58 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace the about to vanish iterators and make use of the filtering. Take
the descriptor lock around the iterators.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/controller/pci-hyperv.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -3445,18 +3445,23 @@ static int hv_pci_suspend(struct hv_devi
 
 static int hv_pci_restore_msi_msg(struct pci_dev *pdev, void *arg)
 {
-	struct msi_desc *entry;
 	struct irq_data *irq_data;
+	struct msi_desc *entry;
+	int ret = 0;
 
-	for_each_pci_msi_entry(entry, pdev) {
+	msi_lock_descs(&pdev->dev);
+	msi_for_each_desc(entry, &pdev->dev, MSI_DESC_ASSOCIATED) {
 		irq_data = irq_get_irq_data(entry->irq);
-		if (WARN_ON_ONCE(!irq_data))
-			return -EINVAL;
+		if (WARN_ON_ONCE(!irq_data)) {
+			ret = -EINVAL;
+			break;
+		}
 
 		hv_compose_msi_msg(irq_data, &entry->msg);
 	}
+	msi_unlock_descs(&pdev->dev);
 
-	return 0;
+	return ret;
 }
 
 /*

