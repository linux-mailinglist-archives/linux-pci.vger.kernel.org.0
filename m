Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B66B625C2B
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:01:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbiKKOBe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233758AbiKKOAz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:00:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA23A845EB;
        Fri, 11 Nov 2022 05:56:50 -0800 (PST)
Message-ID: <20221111132706.445074807@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=92MQH4tsGJzqVWHKcfiMvA7FJnwUvqItKIXp1ZsQCJ8=;
        b=bvPrN6axkYTIF2LbeMNOe+mUeY17g00ZVWsa3pBdSu3JEOoPUTytFVkIan722oupR0E7B8
        ruRapWOMWrJnnYI6lGRY5eZ5BMgE+JQ0g6EuuHihNqcEPk0o4RN6udnD7mss2kBRsBdJc0
        gYys914sOey8OInhnHJYWb1pj3v9Xe8Av3jxGR7q7R2LrZ9J4tvCjHe4rrqWdf7PNxehCT
        Rwt/PNz4/H3CqOboErI5qstR8Nj6gtyNJA2EvgzgLSQsIEkyao9Tx5oEHMZ25BwHZt1Qtu
        HWGGfZczAhaZot6RLR3/JsNNtO9TZ3j5M1Ix/sEsQXWkFN2JH1cVGAV2pMtBwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=92MQH4tsGJzqVWHKcfiMvA7FJnwUvqItKIXp1ZsQCJ8=;
        b=ohCWCJWinKORAyxBehsGXZErXCxGj/Qm9pNCGlsXZYTqFOTm3xGwzE6xksuSIkIbBUGinG
        KrSSQtP+7bRjbUCw==
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
Subject: [patch 07/20] genirq/msi: Add pointers for per device irq domains
References: <20221111131813.914374272@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:56:48 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

With the upcoming per device MSI interrupt domain support it is necessary
to store the domain pointers per device.

Instead of delegating that storage to device drivers or subsystems create a
storage array in struct msi_device_data which will also take care of
tearing down the irq domains when msi_device_data is cleaned up via devres.

The interfaces into the MSI core will be changed from irqdomain pointer
based interfaces to domain id based interfaces to support multiple MSI
domains on a single device (e.g. PCI/MSI[-X] and PCI/IMS.

Once the per device domain support is complete the irq domain pointer in
struct device::msi.domain will not longer contain a pointer to the "global"
MSI domain. It will contain a pointer to the MSI parent domain instead.

It would be a horrible maze of conditionals to evaluate all over the place
which domain pointer should be used, i.e. the "global" one in
device::msi::domain or one from the internal pointer array.

To avoid this evaluate in msi_setup_device_data() whether the irq domain
which is associated to a device is a "global" or a parent MSI domain. If it
is global then copy the pointer into the first entry in the irqdomain
pointer array.

This allows to convert interfaces and implementation to domain ids while
keeping everything existing working.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h     |    3 +++
 include/linux/msi_api.h |    8 ++++++++
 kernel/irq/msi.c        |   14 ++++++++++++++
 3 files changed, 25 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -77,6 +77,7 @@ struct msi_desc;
 struct pci_dev;
 struct platform_msi_priv_data;
 struct device_attribute;
+struct irq_domain;
 
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void get_cached_msi_msg(unsigned int irq, struct msi_msg *msg);
@@ -176,6 +177,7 @@ enum msi_desc_filter {
  * @mutex:		Mutex protecting the MSI descriptor store
  * @__store:		Xarray for storing MSI descriptor pointers
  * @__iter_idx:		Index to search the next entry for iterators
+ * @__irqdomains:	Per device interrupt domains
  */
 struct msi_device_data {
 	unsigned long			properties;
@@ -183,6 +185,7 @@ struct msi_device_data {
 	struct mutex			mutex;
 	struct xarray			__store;
 	unsigned long			__iter_idx;
+	struct irq_domain		*__irqdomains[MSI_MAX_DEVICE_IRQDOMAINS];
 };
 
 int msi_setup_device_data(struct device *dev);
--- a/include/linux/msi_api.h
+++ b/include/linux/msi_api.h
@@ -10,6 +10,14 @@
 
 struct device;
 
+/*
+ * Per device interrupt domain related constants.
+ */
+enum msi_domain_ids {
+	MSI_DEFAULT_DOMAIN,
+	MSI_MAX_DEVICE_IRQDOMAINS,
+};
+
 unsigned int msi_get_virq(struct device *dev, unsigned int index);
 
 #endif
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -21,6 +21,18 @@
 
 static inline int msi_sysfs_create_group(struct device *dev);
 
+static inline void msi_setup_default_irqdomain(struct device *dev, struct msi_device_data *md)
+{
+	if (!dev->msi.domain)
+		return;
+	/*
+	 * If @dev::msi::domain is a global MSI domain, copy the pointer
+	 * into the domain array to avoid conditionals all over the place.
+	 */
+	if (!irq_domain_is_msi_parent(dev->msi.domain))
+		md->__irqdomains[MSI_DEFAULT_DOMAIN] = dev->msi.domain;
+}
+
 /**
  * msi_alloc_desc - Allocate an initialized msi_desc
  * @dev:	Pointer to the device for which this is allocated
@@ -213,6 +225,8 @@ int msi_setup_device_data(struct device
 		return ret;
 	}
 
+	msi_setup_default_irqdomain(dev, md);
+
 	xa_init(&md->__store);
 	mutex_init(&md->mutex);
 	dev->msi.data = md;

