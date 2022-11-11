Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7EC625BAB
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:55:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233906AbiKKNzs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:55:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233817AbiKKNzU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:55:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E48C077E4A;
        Fri, 11 Nov 2022 05:54:38 -0800 (PST)
Message-ID: <20221111122014.409654736@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ihQb1Hr2tFB57KaqSJ6TMuVbBaKbPYZLQeHvg5ugyrc=;
        b=KIxoGLm3fdgX8mVYTA3gqrUlF6RwTtW90vYGHTzR9LA4zR9jAvDQ3Mz275nIl+k1FsCVo8
        BDasSMGgRPumnK+XCfXPGjj7fbt46WHiGID8auAQfUb2Fb1FPhMqiq4S5Vfu8sZEu1C9Y8
        MQnr0/wDyfTzrL68KxmtWwLyR/P+t79hViR57xRScUXMobFg6K+I2h8IV+wgT+yxvAvOM7
        7uVe7yokIXo/LjW9ONZit1EjWi5RuhSl2zMdJxNHQ3BUemd1RxyK5J0d706hKkPPOlSxn2
        x/CvdueaKYFaZ+eSmgX5gR3aO6NPOicaxHiLhYOGfhjwy5k+jQQsoBWV8i2oLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=ihQb1Hr2tFB57KaqSJ6TMuVbBaKbPYZLQeHvg5ugyrc=;
        b=uMHNBoXC2VwEdIAQL/VEAVQGgdOqIQAKBY94YN3/zPMpA2g+0keRMDIAeVH1iiSVA9XOms
        zwnFBQCZgvigUJCQ==
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
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org
Subject: [patch 14/39] PCI/MSI: Let the MSI core free descriptors
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:54:37 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ahmed S. Darwish <darwi@linutronix.de>

Let the core do the freeing of descriptors and just keep it around for the
legacy case.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi/irqdomain.c |   10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -24,11 +24,12 @@ void pci_msi_teardown_msi_irqs(struct pc
 	struct irq_domain *domain;
 
 	domain = dev_get_msi_domain(&dev->dev);
-	if (domain && irq_domain_is_hierarchy(domain))
+	if (domain && irq_domain_is_hierarchy(domain)) {
 		msi_domain_free_irqs_descs_locked(domain, &dev->dev);
-	else
+	} else {
 		pci_msi_legacy_teardown_msi_irqs(dev);
-	msi_free_msi_descs(&dev->dev);
+		msi_free_msi_descs(&dev->dev);
+	}
 }
 
 /**
@@ -170,6 +171,9 @@ struct irq_domain *pci_msi_create_irq_do
 	if (info->flags & MSI_FLAG_USE_DEF_CHIP_OPS)
 		pci_msi_domain_update_chip_ops(info);
 
+	/* Let the core code free MSI descriptors when freeing interrupts */
+	info->flags |= MSI_FLAG_FREE_MSI_DESCS;
+
 	info->flags |= MSI_FLAG_ACTIVATE_EARLY | MSI_FLAG_DEV_SYSFS;
 	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
 		info->flags |= MSI_FLAG_MUST_REACTIVATE;

