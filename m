Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A63C632611
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiKUOhN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:37:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiKUOgl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:36:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A504DC6D13;
        Mon, 21 Nov 2022 06:36:28 -0800 (PST)
Message-ID: <20221121083325.898535631@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=9rEv0ZCHRcbwfGXHvRaB+26Gs3i0vHsf2KEnMS96bjY=;
        b=GXvys4RNHQ7h0QJBqveM//QK3VblBKRZ4eYHP/cRMku42RLzjX3JH3BHs7zUb5U/ORz0Qn
        N/TjGTvzSeYuMzUs3dVZUk7xyyDqIZD7+dy/qhNkL/ggGFqlVZb4G+lODo4RrmjkA0pLsE
        DXFG8m0zubDhD9Qz+DOsxZR6jxULosiRgtLhI3HKwk3k601W1wPVdNf9bvxFOndczykdZW
        PLQMuQ9BMlXYsARIKsuQCR0r5ZuInW1CMdeYh/vRpwlFsPwFiIVT/UZe7GSZ53s870/4pS
        ZJp3wL0ucDww9DednLFrLw2+oEbJVvjebsyGeh7/YoO/rYDFIXSVqTGyIvWsyQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041387;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=9rEv0ZCHRcbwfGXHvRaB+26Gs3i0vHsf2KEnMS96bjY=;
        b=/ryo2wZZtD3zkaTdpxsEJC9pzfQODO2gG/rLr9x6xv7NCtw5ssyjyawTKgkSyCSIBjSgiM
        iNZJtqjUellQKGCw==
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
        Allen Hubbe <allenbh@gmail.com>
Subject: [patch V2 07/21] genirq/msi: Check for invalid MSI parent domain usage
References: <20221121083210.309161925@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:36:27 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the upcoming per device MSI domain concept the MSI parent domains are
not allowed to be used as regular MSI domains where the MSI allocation/free
operations are applicable.

Add appropriate checks.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: Made the error return understandable. (Kevin)
---
 kernel/irq/msi.c |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -937,13 +937,21 @@ int msi_domain_alloc_irqs_descs_locked(s
 
 	lockdep_assert_held(&dev->msi.data->mutex);
 
+	if (WARN_ON_ONCE(irq_domain_is_msi_parent(domain))) {
+		ret = -EINVAL;
+		goto free;
+	}
+
+	/* Frees allocated descriptors in case of failure. */
 	ret = msi_domain_add_simple_msi_descs(info, dev, nvec);
 	if (ret)
-		return ret;
+		goto free;
 
 	ret = ops->domain_alloc_irqs(domain, dev, nvec);
-	if (ret)
-		msi_domain_free_irqs_descs_locked(domain, dev);
+	if (!ret)
+		return 0;
+free:
+	msi_domain_free_irqs_descs_locked(domain, dev);
 	return ret;
 }
 
@@ -1013,6 +1021,9 @@ void msi_domain_free_irqs_descs_locked(s
 
 	lockdep_assert_held(&dev->msi.data->mutex);
 
+	if (WARN_ON_ONCE(irq_domain_is_msi_parent(domain)))
+		return;
+
 	ops->domain_free_irqs(domain, dev);
 	if (ops->msi_post_free)
 		ops->msi_post_free(domain, dev);

