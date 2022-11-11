Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BF6625B96
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 14:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233644AbiKKNyw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 08:54:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233518AbiKKNyY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 08:54:24 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2220F654F6;
        Fri, 11 Nov 2022 05:54:24 -0800 (PST)
Message-ID: <20221111122013.888850936@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668174862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=efOtDMgGZtrOq2C93xDB3bkE3dnMFMUi6PhL2K3F+Xc=;
        b=OGgspOZeBC55SSE4L/03t3Yj8kEAUvaCDyesgMfIQ/8qhXJLoIiwTqSD0usnmt+jNWsGxe
        jJQIhOK2glpk+B7OSR+bSxnJRrGYjm7l6+v8O35MDAj8CaLu4GeF+phCjLDtbCTxh5572M
        +ZpPJAvMXeUjr0mPgIt+9+snp1r51HIvN8aPT4w0auBrP/NkfAAUYZzp759bwdCn1Kq78A
        lb32ySTfELSWx1/+L0w3PdN47RZdW50J4E5gvQQfzie7ob1/CZlWpi2e3Wn5ebKYWS0ZtB
        zSBgFrBCzs8wHVGv86iPTFC38nFfQbhWVVsDO/a8gXoX8MLGY2aFp0qzQ9nWRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668174862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=efOtDMgGZtrOq2C93xDB3bkE3dnMFMUi6PhL2K3F+Xc=;
        b=sIAyS0gBMPiZE7rx+h8POgBoJq70Rx877SA8g16n791fowonYh2meMpqEAwdbzM0ajaQbK
        ljBVTKfudKOlfWCg==
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
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linuxppc-dev@lists.ozlabs.org,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [patch 05/39] genirq/msi: Remove filter from msi_free_descs_free_range()
References: <20221111120501.026511281@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:54:22 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When a range of descriptors is freed then all of them are not associated to
a linux interrupt. Remove the filter and add a warning to the free function.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/base/platform-msi.c |    2 +-
 include/linux/msi.h         |    5 ++---
 kernel/irq/msi.c            |   19 ++++++++++---------
 3 files changed, 13 insertions(+), 13 deletions(-)

--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -325,7 +325,7 @@ void platform_msi_device_domain_free(str
 
 	msi_lock_descs(data->dev);
 	irq_domain_free_irqs_common(domain, virq, nr_irqs);
-	msi_free_msi_descs_range(data->dev, MSI_DESC_ALL, virq, virq + nr_irqs - 1);
+	msi_free_msi_descs_range(data->dev, virq, virq + nr_irqs - 1);
 	msi_unlock_descs(data->dev);
 }
 
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -247,8 +247,7 @@ static inline void pci_write_msi_msg(uns
 #endif /* CONFIG_PCI_MSI */
 
 int msi_add_msi_desc(struct device *dev, struct msi_desc *init_desc);
-void msi_free_msi_descs_range(struct device *dev, enum msi_desc_filter filter,
-			      unsigned int first_index, unsigned int last_index);
+void msi_free_msi_descs_range(struct device *dev, unsigned int first_index, unsigned int last_index);
 
 /**
  * msi_free_msi_descs - Free MSI descriptors of a device
@@ -256,7 +255,7 @@ void msi_free_msi_descs_range(struct dev
  */
 static inline void msi_free_msi_descs(struct device *dev)
 {
-	msi_free_msi_descs_range(dev, MSI_DESC_ALL, 0, MSI_MAX_INDEX);
+	msi_free_msi_descs_range(dev, 0, MSI_MAX_INDEX);
 }
 
 void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -120,7 +120,7 @@ static int msi_add_simple_msi_descs(stru
 fail_mem:
 	ret = -ENOMEM;
 fail:
-	msi_free_msi_descs_range(dev, MSI_DESC_ALL, index, last);
+	msi_free_msi_descs_range(dev, index, last);
 	return ret;
 }
 
@@ -141,12 +141,11 @@ static bool msi_desc_match(struct msi_de
 /**
  * msi_free_msi_descs_range - Free MSI descriptors of a device
  * @dev:		Device to free the descriptors
- * @filter:		Descriptor state filter
  * @first_index:	Index to start freeing from
  * @last_index:		Last index to be freed
  */
-void msi_free_msi_descs_range(struct device *dev, enum msi_desc_filter filter,
-			      unsigned int first_index, unsigned int last_index)
+void msi_free_msi_descs_range(struct device *dev, unsigned int first_index,
+			      unsigned int last_index)
 {
 	struct xarray *xa = &dev->msi.data->__store;
 	struct msi_desc *desc;
@@ -155,10 +154,12 @@ void msi_free_msi_descs_range(struct dev
 	lockdep_assert_held(&dev->msi.data->mutex);
 
 	xa_for_each_range(xa, idx, desc, first_index, last_index) {
-		if (msi_desc_match(desc, filter)) {
-			xa_erase(xa, idx);
-			msi_free_desc(desc);
-		}
+		xa_erase(xa, idx);
+
+		/* Leak the descriptor when it is still referenced */
+		if (WARN_ON_ONCE(msi_desc_match(desc, MSI_DESC_ASSOCIATED)))
+			continue;
+		msi_free_desc(desc);
 	}
 }
 
@@ -739,7 +740,7 @@ int msi_domain_populate_irqs(struct irq_
 fail:
 	for (--virq; virq >= virq_base; virq--)
 		irq_domain_free_irqs_common(domain, virq, 1);
-	msi_free_msi_descs_range(dev, MSI_DESC_ALL, virq_base, virq_base + nvec - 1);
+	msi_free_msi_descs_range(dev, virq_base, virq_base + nvec - 1);
 unlock:
 	msi_unlock_descs(dev);
 	return ret;

