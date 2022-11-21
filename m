Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7C88632623
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:37:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiKUOh0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:37:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiKUOgq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:36:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B759C76A7;
        Mon, 21 Nov 2022 06:36:45 -0800 (PST)
Message-ID: <20221121083326.617156908@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=/bVC6uqxnLqu0Y//SpNf+743RFr9freD3IllzYYvzRs=;
        b=W4ofMafVh7rm8emZNfhg4DWL9YKcdUtjs6guGjP+2xWvPEkM/Z3g8zvywlJ26EKcimUPrG
        p+0rRkGpxZfQIsBIfNoLlxbsP8n0+fTwgcTFVghxl/CvmU4D4r4XCylHgj9HYAdcp4f2vy
        gcXpl9/m4tFuqoq1GI2UKZVzxjKi7LD3xsvuo7grqLp4btDr97+UovVC9Rtu89uH1UqTQ9
        RArVsqghKaGxoK2DCPrp0AePChj16INqKWprmxNEB3ydCybr6uPJxRgf3EFp3Kske6WiGc
        rKecQRavmplxvjIuu/blQKmUMnhRFhPmDx86o+uFKcQEHU7AXLfmQN8EYMGn1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=/bVC6uqxnLqu0Y//SpNf+743RFr9freD3IllzYYvzRs=;
        b=wL0px/wfju+i+mk2KAVG6Hi7dBxm2Ya43G2ZKWk//5waKcYH38ir3ie5RLpaUd9kfqjs/Q
        KmVlvoEmJ4gsRWBQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>
Subject: [patch V2 20/21] oc: ti: ti_sci_inta_msi: Switch to domain id aware
 MSI functions
References: <20221121083210.309161925@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:36:43 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ahmed S. Darwish <darwi@linutronix.de>

Switch to the new domain id aware interfaces to phase out the previous
ones. Remove the domain check as it happens in the core code now.

No functional change.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/soc/ti/ti_sci_inta_msi.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

--- a/drivers/soc/ti/ti_sci_inta_msi.c
+++ b/drivers/soc/ti/ti_sci_inta_msi.c
@@ -93,13 +93,8 @@ int ti_sci_inta_msi_domain_alloc_irqs(st
 				      struct ti_sci_resource *res)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	struct irq_domain *msi_domain;
 	int ret, nvec;
 
-	msi_domain = dev_get_msi_domain(dev);
-	if (!msi_domain)
-		return -EINVAL;
-
 	if (pdev->id < 0)
 		return -ENODEV;
 
@@ -114,7 +109,8 @@ int ti_sci_inta_msi_domain_alloc_irqs(st
 		goto unlock;
 	}
 
-	ret = msi_domain_alloc_irqs_descs_locked(msi_domain, dev, nvec);
+	/* Use alloc ALL as it's unclear whether there are gaps in the indices */
+	ret = msi_domain_alloc_irqs_all_locked(dev, MSI_DEFAULT_DOMAIN, nvec);
 	if (ret)
 		dev_err(dev, "Failed to allocate IRQs %d\n", ret);
 unlock:

