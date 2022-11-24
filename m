Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD2DF6381AF
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:30:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiKXXab (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:30:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230075AbiKXX35 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:29:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE114EC2C;
        Thu, 24 Nov 2022 15:27:57 -0800 (PST)
Message-ID: <20221124232326.904316841@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=pHYNj/tOODPRGvpoXQej+yHyq5YhurDakOsBIaKgkpM=;
        b=PyiRAtx7MFPlpm9eN7xpUzZPic7sdE/sSBL0cZBTN7tzq7ViW7LukLk/uLyWa4zPu+qn7g
        hZiKoPSaEExgzeQQn6fkxk7hDJ/cBMXpzIzz2u7zQko/WUWzpTH8bdLZKpFg+LrInOw8Jn
        kR5XjfByqB/WTK7/NN2ecOCWoFyaIfTUMny/XfwMemWI7wCLwEYHfgD38KjEjgMi8shY+l
        bfJ/YfYwGK6sgyjWiX9y2AXSv11/yzr1A3A70fnhYTbgAixLeIW6tQ82jWUkJzXO6cGCu6
        xzJSDAe6z7nHc55FHk9ucX/yhvaSPpfghV/KoLmr3waDQS0V3BDflxZaEVJ9fQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=pHYNj/tOODPRGvpoXQej+yHyq5YhurDakOsBIaKgkpM=;
        b=TvagWfbPoNQbp4EysCimvVt8l3uSwoBEmMmkZYlJWsXx67hqhyoYVMqtoiHHZW3BviDNP4
        WObeRGPpMWnLkqDg==
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
Subject: [patch V3 28/33] PCI/MSI: Provide IMS (Interrupt Message Store) support
References: <20221124230505.073418677@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:26:29 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

IMS (Interrupt Message Store) is a new specification which allows
implementation specific storage of MSI messages contrary to the
strict standard specified MSI and MSI-X message stores.

This requires new device specific interrupt domains to handle the
implementation defined storage which can be an array in device memory or
host/guest memory which is shared with hardware queues.

Add a function to create IMS domains for PCI devices. IMS domains are using
the new per device domain mechanism and are configured by the device driver
via a template. IMS domains are created as secondary device domains so they
work side on side with MSI[-X] on the same device.

The IMS domains have a few constraints:

  - The index space is managed by the core code.

    Device memory based IMS provides a storage array with a fixed size
    which obviously requires an index. But there is no association between
    index and functionality so the core can randomly allocate an index in
    the array.

    System memory based IMS does not have the concept of an index as the
    storage is somewhere in memory. In that case the index is purely
    software based to keep track of the allocations.

  - There is no requirement for consecutive index ranges

    This is currently a limitation of the MSI core and can be implemented
    if there is a justified use case by changing the internal storage from
    xarray to maple_tree. For now it's single vector allocation.

  - The interrupt chip must provide the following callbacks:

  	- irq_mask()
	- irq_unmask()
	- irq_write_msi_msg()

   - The interrupt chip must provide the following optional callbacks
     when the irq_mask(), irq_unmask() and irq_write_msi_msg() callbacks
     cannot operate directly on hardware, e.g. in the case that the
     interrupt message store is in queue memory:

     	- irq_bus_lock()
	- irq_bus_unlock()

     These callbacks are invoked from preemptible task context and are
     allowed to sleep. In this case the mandatory callbacks above just
     store the information. The irq_bus_unlock() callback is supposed to
     make the change effective before returning.

   - Interrupt affinity setting is handled by the underlying parent
     interrupt domain and communicated to the IMS domain via
     irq_write_msi_msg(). IMS domains cannot have a irq_set_affinity()
     callback. That's a reasonable restriction similar to the PCI/MSI
     device domain implementations.

The domain is automatically destroyed when the PCI device is removed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Queue memory -> system memory (Kevin)
---
 drivers/pci/msi/irqdomain.c |   59 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h         |    5 +++
 2 files changed, 64 insertions(+)

--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -355,6 +355,65 @@ bool pci_msi_domain_supports(struct pci_
 	return (supported & feature_mask) == feature_mask;
 }
 
+/**
+ * pci_create_ims_domain - Create a secondary IMS domain for a PCI device
+ * @pdev:	The PCI device to operate on
+ * @template:	The MSI info template which describes the domain
+ * @hwsize:	The size of the hardware entry table or 0 if the domain
+ *		is purely software managed
+ * @data:	Optional pointer to domain specific data to be stored
+ *		in msi_domain_info::data
+ *
+ * Return: True on success, false otherwise
+ *
+ * An IMS domain is expected to have the following constraints:
+ *	- The index space is managed by the core code
+ *
+ *	- There is no requirement for consecutive index ranges
+ *
+ *	- The interrupt chip must provide the following callbacks:
+ *		- irq_mask()
+ *		- irq_unmask()
+ *		- irq_write_msi_msg()
+ *
+ *	- The interrupt chip must provide the following optional callbacks
+ *	  when the irq_mask(), irq_unmask() and irq_write_msi_msg() callbacks
+ *	  cannot operate directly on hardware, e.g. in the case that the
+ *	  interrupt message store is in queue memory:
+ *		- irq_bus_lock()
+ *		- irq_bus_unlock()
+ *
+ *	  These callbacks are invoked from preemptible task context and are
+ *	  allowed to sleep. In this case the mandatory callbacks above just
+ *	  store the information. The irq_bus_unlock() callback is supposed
+ *	  to make the change effective before returning.
+ *
+ *	- Interrupt affinity setting is handled by the underlying parent
+ *	  interrupt domain and communicated to the IMS domain via
+ *	  irq_write_msi_msg().
+ *
+ * The domain is automatically destroyed when the PCI device is removed.
+ */
+bool pci_create_ims_domain(struct pci_dev *pdev, const struct msi_domain_template *template,
+			   unsigned int hwsize, void *data)
+{
+	struct irq_domain *domain = dev_get_msi_domain(&pdev->dev);
+
+	if (!domain || !irq_domain_is_msi_parent(domain))
+		return -ENOTSUPP;
+
+	if (template->info.bus_token != DOMAIN_BUS_PCI_DEVICE_IMS ||
+	    !(template->info.flags & MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS) ||
+	    !(template->info.flags & MSI_FLAG_FREE_MSI_DESCS) ||
+	    !template->chip.irq_mask || !template->chip.irq_unmask ||
+	    !template->chip.irq_write_msi_msg || template->chip.irq_set_affinity)
+		return -EINVAL;
+
+	return msi_create_device_irq_domain(&pdev->dev, MSI_SECONDARY_DOMAIN, template,
+					    hwsize, data, NULL);
+}
+EXPORT_SYMBOL_GPL(pci_create_ims_domain);
+
 /*
  * Users of the generic MSI infrastructure expect a device to have a single ID,
  * so with DMA aliases we have to pick the least-worst compromise. Devices with
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2487,6 +2487,11 @@ static inline bool pci_is_thunderbolt_at
 void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
 #endif
 
+struct msi_domain_template;
+
+bool pci_create_ims_domain(struct pci_dev *pdev, const struct msi_domain_template *template,
+			   unsigned int hwsize, void *data);
+
 #include <linux/dma-mapping.h>
 
 #define pci_printk(level, pdev, fmt, arg...) \

