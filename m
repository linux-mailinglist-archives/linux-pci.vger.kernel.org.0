Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C648163267E
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiKUOk5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:40:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231490AbiKUOjM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:39:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A30FC80D7;
        Mon, 21 Nov 2022 06:38:22 -0800 (PST)
Message-ID: <20221121091328.026206487@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=dPsIsUTlWmyEo9zstL3A7RgXpEoaaZrG8HYlS9a0uvQ=;
        b=JglSAlvkoT93jFng1mXI8Xf/zFG0jlpT/jwqUNY06+Ky3te+1WrjDQoGWJJjH5fql9GSMj
        h5e2dRXcLcYqPR9CU8ZgD/UNomBHM5nzrk9tCnY+pjJLRzoLPXKrTJHDij9bprbOacnKl9
        kTnDQ8lbyzgYbJODEX/8k+VoimWaN2Gpyk9mYnFF2HGiQ0ho3n2iIm2AF16EOaVEhWSpCw
        RG1lRoSLSdR/Zm6xlFvVOgAnWKkVS9wG9hJu4uIEyMFj7gdjS0GhsVj1QotpxUnPBD2UYT
        6iNCFD4beXzfjJa6QseP+mD3THhlekOzpCqrPMDVewbeQp7bYoB5exkotgE4Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041501;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=dPsIsUTlWmyEo9zstL3A7RgXpEoaaZrG8HYlS9a0uvQ=;
        b=RI0AvfYJNxBkTf4pYxjTYuca9HBGvMWiBuMSms34qGjav9Ed8HKwEQChZqwifhcu+7/Pkb
        VEEYQ08eMz1bSTDw==
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
Subject: [patch V2 28/33] PCI/MSI: Provide IMS (Interrupt Message Store) support
References: <20221121083657.157152924@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:38:21 +0100 (CET)
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

    Queue memory based IMS does not have the concept of an index as the
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

