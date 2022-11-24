Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29A9F638163
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiKXXYx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:24:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiKXXYg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:24:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49CD2898E7;
        Thu, 24 Nov 2022 15:24:25 -0800 (PST)
Message-ID: <20221124230313.923860399@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=BJi5dwk0jz30HETfOkPgoRQ1A7CjonfRPPdcMlCUzKw=;
        b=uLgPamwAoH81d9p92Z4MvAAxOEMhoJZOWImWf5FEq+5V3Ijf8p76AW3Nw3JFmC5GyqgOmr
        TPmp2X8s9K3byzhNqiNgFjhAZhf9HV9jaobBYFF6F13rkY7UJHAqpeZPNQognmqwZPVFlT
        xMfHKWq4o2GG3QOlZk33G3WS/ZOzBn3qR2ON0xKB2k1kMVUlaRhJmih8alHRdsF0nRAFHm
        xcOBE08nQX12IrtDg3ljaoAv0iaHS1x8GGCOtpqJlqHl7JYTpRPO37QLHeQaXt67fWiqOD
        VABP5ArGjHB4xfT6W+ROLgxz0wQgM04LjNW3AInXpr1PRD0e4Dk0VKXuVuwO4w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332263;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=BJi5dwk0jz30HETfOkPgoRQ1A7CjonfRPPdcMlCUzKw=;
        b=Y20fQzYqd/z4lG+KIf0OGav7Y3ngbWHVqg57QE1AR96VzM/FCX387MoEHp7ID8y8EaurlY
        UtWJUhyaV7oWFbCw==
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
Subject: [patch V3 09/22] genirq/msi: Add pointers for per device irq domains
References: <20221124225331.464480443@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:24:22 +0100 (CET)
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

Instead of delegating that storage to device drivers or subsystems add a
domain pointer to the msi_dev_domain array in struct msi_device_data.

This pointer is also used to take care of tearing down the irq domains when
msi_device_data is cleaned up via devres.

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
is global then copy the pointer into the first entry of the msi_dev_domain
array.

This allows to convert interfaces and implementation to domain ids while
keeping everything existing working.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Adopt to the domain/xarray storage change
---
 include/linux/msi.h |    3 +++
 kernel/irq/msi.c    |    9 +++++++++
 2 files changed, 12 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -77,6 +77,7 @@ struct msi_desc;
 struct pci_dev;
 struct platform_msi_priv_data;
 struct device_attribute;
+struct irq_domain;
 
 void __get_cached_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 #ifdef CONFIG_GENERIC_MSI_IRQ
@@ -177,9 +178,11 @@ enum msi_desc_filter {
 /**
  * struct msi_dev_domain - The internals of MSI domain info per device
  * @store:		Xarray for storing MSI descriptor pointers
+ * @irqdomain:		Pointer to a per device interrupt domain
  */
 struct msi_dev_domain {
 	struct xarray		store;
+	struct irq_domain	*domain;
 };
 
 /**
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -220,6 +220,15 @@ int msi_setup_device_data(struct device
 	for (i = 0; i < MSI_MAX_DEVICE_IRQDOMAINS; i++)
 		xa_init(&md->__domains[i].store);
 
+	/*
+	 * If @dev::msi::domain is set and is a global MSI domain, copy the
+	 * pointer into the domain array so all code can operate on domain
+	 * ids. The NULL pointer check is required to keep the legacy
+	 * architecture specific PCI/MSI support working.
+	 */
+	if (dev->msi.domain && !irq_domain_is_msi_parent(dev->msi.domain))
+		md->__domains[MSI_DEFAULT_DOMAIN].domain = dev->msi.domain;
+
 	mutex_init(&md->mutex);
 	dev->msi.data = md;
 	devres_add(dev, md);

