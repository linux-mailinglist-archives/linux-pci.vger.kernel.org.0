Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41420625C81
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbiKKOH6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbiKKOHU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:07:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B58D8C5AB;
        Fri, 11 Nov 2022 06:00:05 -0800 (PST)
Message-ID: <20221111135206.912428659@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=R8X/63rO52IiLYrJWmoKP44/nsK9YU8Bw0NawruV3mM=;
        b=Y52rqaQEowoXK/iAaqizlNsaSh0oGgd/a2CSd9kNrKCUACWq3K4y1MEHQ79xbRBO5GCPZX
        zHR8gAjtWFOfTwqZPAyo+PRVSm0yyRrVGts7i5VCy8S6uP8t8KG2MQTaDjThMpwx3gPGdT
        euDKXvr7PHJIDZx17ucFSDMJaaIXb8Fc4L5uIxNx6FoI6/fEDYlktY3r4vonDErIbR6XAX
        P3NRkGqZNOJqNI02KbNNmLNMSm7Z8/7tr1sGevwdBR4QfrQQShrB2aXLIiCv19gHce9O0N
        X4KnpFldpX19pJfEpfAYtCnKXFaJHhWCt9rhhOx6EaqmnP9aVwcopECtTEmIDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=R8X/63rO52IiLYrJWmoKP44/nsK9YU8Bw0NawruV3mM=;
        b=XFYTHHgf0o68nsruCxfjPdNiXmxoJFLRr9y1Civxd+7+YxtAi9o894oPl4FN6Y7obsuevL
        ifNGvA2yZQ0UewAw==
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
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [patch 29/33] PCI/MSI: Provide pci_ims_alloc/free_irq()
References: <20221111133158.196269823@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:58:57 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Single vector allocation which allocates the next free index in the IMS
space. The free function releases.

All allocated vectors are released also via pci_free_vectors() which is
also releasing MSI/MSI-X vectors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi/api.c |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h   |    3 +++
 2 files changed, 53 insertions(+)

--- a/drivers/pci/msi/api.c
+++ b/drivers/pci/msi/api.c
@@ -361,6 +361,56 @@ const struct cpumask *pci_irq_get_affini
 EXPORT_SYMBOL(pci_irq_get_affinity);
 
 /**
+ * pci_ims_alloc_irq - Allocate an interrupt on a PCI/IMS interrupt domain
+ * @dev:	The PCI device to operate on
+ * @cookie:	Pointer to an IMS implementation specific device cookie
+ *		(PASID, queue id, pointer...). The cookie content is stored
+ *		in the MSI descriptor for the interrupt chip callbacks or
+ *		domain specific setup functions
+ * @affdesc:	Optional pointer to an interrupt affinity descriptor
+ *
+ * Return: A struct msi_map
+ *
+ *	On success msi_map::index contains the allocated index (>= 0) and
+ *	msi_map::virq the allocated Linux interrupt number (> 0).
+ *
+ *	On fail msi_map::index contains the error code and msi_map::virq
+ *	is set to 0.
+ *
+ * Note: There is no index for IMS allocations as IMS is an implementation
+ *	 specific storage and does not have any direct associations between
+ *	 index, which might be a pure software construct, and device
+ *	 functionality. This association is established by the driver either
+ *	 via the index - if there is a hardware table - or in case of purely
+ *	 software managed IMS implementation the association happens via
+ *	 the irq_write_msi_msg() callback of the implementation specific
+ *	 interrupt chip, which utilizes the provided @cookie to store the MSI
+ *	 message in the appropriate place.
+ */
+struct msi_map pci_ims_alloc_irq(struct pci_dev *dev, union msi_dev_cookie *cookie,
+				 const struct irq_affinity_desc *affdesc)
+{
+	return msi_domain_alloc_irq_at(&dev->dev, MSI_SECONDARY_DOMAIN, MSI_ANY_INDEX,
+				       affdesc, cookie);
+}
+EXPORT_SYMBOL_GPL(pci_ims_alloc_irq);
+
+/**
+ * pci_ims_free_irq - Allocate an interrupt on a PCI/IMS interrupt domain
+ *		      which was allocated via pci_ims_alloc_irq()
+ * @dev:	The PCI device to operate on
+ * @map:	A struct msi_map describing the interrupt to free as
+ *		returned from pci_ims_alloc_irq()
+ */
+void pci_ims_free_irq(struct pci_dev *dev, struct msi_map map)
+{
+	if (WARN_ON_ONCE(map.index < 0 || !map.virq))
+		return;
+	msi_domain_free_irqs_range(&dev->dev, MSI_SECONDARY_DOMAIN, map.index, map.index);
+}
+EXPORT_SYMBOL_GPL(pci_ims_free_irq);
+
+/**
  * pci_free_irq_vectors() - Free previously allocated IRQs for a device
  * @dev: the PCI device to operate on
  *
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2485,6 +2485,9 @@ struct msi_domain_template;
 
 bool pci_create_ims_domain(struct pci_dev *pdev, const struct msi_domain_template *template,
 			   unsigned int hwsize, void *data);
+struct msi_map pci_ims_alloc_irq(struct pci_dev *pdev, union msi_dev_cookie *cookie,
+				 const struct irq_affinity_desc *affdesc);
+void pci_ims_free_irq(struct pci_dev *pdev, struct msi_map map);
 
 #include <linux/dma-mapping.h>
 

