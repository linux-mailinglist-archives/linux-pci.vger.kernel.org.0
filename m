Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAF7A63260F
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:37:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiKUOhL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiKUOgl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:36:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0370DC6D16;
        Mon, 21 Nov 2022 06:36:30 -0800 (PST)
Message-ID: <20221121083325.950255253@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=W7qVbQgLsW9+eyoM2fn4CU+n/dlKHe6NknzgWNBQJFM=;
        b=nQVGQACbwDgZgFx6Yzjx95AJmLSoQLwxKE1n+al/J1KQEZFIX5TbDcZEuaFUjQuLDeJ0iO
        GbY/q/6UgN99PnEeTDHVJMVoz5hbW2y4TWu8fv3219e4f1sBqPbJQRUt3TNboXcIQOHB3C
        BQ4SP8gLZ5wrn/taAL/7kxxIqz2CkmCAEdYIl1UAs8oMvGY6+X2j+Gks1jIXOzoFksie6R
        lUGpRKjCdlDJ9AsF04mx3GzyZrgsXv6tHTGy5OswCQ/tvR6t3kfFjmJxBjtszWXxvuxZ4z
        fn9fdLbTr84EWKgXasbHdlhHz4dN2pXJkVp0n+g5f0Z9KxvGffVK36G1nIHqPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=W7qVbQgLsW9+eyoM2fn4CU+n/dlKHe6NknzgWNBQJFM=;
        b=U4VJ4dAgXGtzIyaO0c7BJIiFHBNo3jeZHyXGDxSY68cLTykCaDumafui4CSyQh6fJZRQaB
        8m/CSoIAq4Bug9DQ==
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
Subject: [patch V2 08/21] genirq/msi: Add pointers for per device irq domains
References: <20221121083210.309161925@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:36:28 +0100 (CET)
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
 #ifdef CONFIG_GENERIC_MSI_IRQ
@@ -180,6 +181,7 @@ enum msi_desc_filter {
  * @mutex:		Mutex protecting the MSI descriptor store
  * @__store:		Xarray for storing MSI descriptor pointers
  * @__iter_idx:		Index to search the next entry for iterators
+ * @__irqdomains:	Per device interrupt domains
  */
 struct msi_device_data {
 	unsigned long			properties;
@@ -187,6 +189,7 @@ struct msi_device_data {
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

