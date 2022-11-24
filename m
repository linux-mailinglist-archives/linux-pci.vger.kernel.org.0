Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAAC663818D
	for <lists+linux-pci@lfdr.de>; Fri, 25 Nov 2022 00:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbiKXX2R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Nov 2022 18:28:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229868AbiKXX1m (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Nov 2022 18:27:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D953CFE94;
        Thu, 24 Nov 2022 15:26:27 -0800 (PST)
Message-ID: <20221124232325.678838546@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669332356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Rptg2jhZEWRDJFBrlepwa1/xZvdteCw3yYQE94xTOcY=;
        b=fW2DsyCMmwC/fWggszLgz8x8UiAskhOBvhZHehVRbyM687CPHaUbhefSmCGGaxpuwnDa5P
        7NsJ0AHxQDCBWxDwBMT92EMgSCalRB3f5CV6RTBOFIsCDDLPx5KwRprr5HfR1UGK9C54gq
        dFTo2tF3WuxOJkhfEFs69fiY7Ln+aLsXntX/Iig77MMARArntCn/n5FhrrViaKNylxjRPk
        GY0yeyOzK/CXqXPPxWCg/fLbrJGRZBiMzfb8I5x5alDD1oUwGDPEeMNRCzu5Cof8YAw4Vw
        vho8a+FCZDrraaLA4CTxAiWXXciZYN2/PZFHMO126y3QrLwbhs6qdWsOIlVo5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669332356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=Rptg2jhZEWRDJFBrlepwa1/xZvdteCw3yYQE94xTOcY=;
        b=L4uU5SYaFhw2E0gZeFX/eZrNo/oW66U+Mb9vA8sLvLtkUdgJ65TnsiZgKisP9jPzm6bnz9
        947zQTU2sBQUtoBA==
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
Subject: [patch V3 07/33] genirq/msi: Provide msi_create/free_device_irq_domain()
References: <20221124230505.073418677@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 25 Nov 2022 00:25:56 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that all prerequsites are in place, provide the actual interfaces for
creating and removing per device interrupt domains.

MSI device interrupt domains are created from the provided
msi_domain_template which is duplicated so that it can be modified for the
particular device.

The name of the domain and the name of the interrupt chip are composed by
"$(PREFIX)$(CHIPNAME)-$(DEVNAME)"

  $PREFIX:   The optional prefix provided by the underlying MSI parent domain
             via msi_parent_ops::prefix.
  $CHIPNAME: The name of the irq_chip in the template
  $DEVNAME:  The name of the device

The domain is further initialized through a MSI parent domain callback which
fills in the required functionality for the parent domain or domains further
down the hierarchy. This initialization can fail, e.g. when the requested
feature or MSI domain type cannot be supported.

The domain pointer is stored in the pointer array inside of msi_device_data
which is attached to the domain.

The domain can be removed via the API or left for disposal via devres when
the device is torn down. The API removal is useful e.g. for PCI to have
seperate domains for MSI and MSI-X, which are mutually exclusive and always
occupy the default domain id slot.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V3: Remove unused argument and adopt the hwsize init (Kevin)
    Adopt to the xarray and domain storage split
---
 include/linux/msi.h |    6 ++
 kernel/irq/msi.c    |  138 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 144 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -547,6 +547,12 @@ struct irq_domain *msi_create_irq_domain
 					 struct msi_domain_info *info,
 					 struct irq_domain *parent);
 
+bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
+				  const struct msi_domain_template *template,
+				  unsigned int hwsize, void *domain_data,
+				  void *chip_data);
+void msi_remove_device_irq_domain(struct device *dev, unsigned int domid);
+
 int msi_domain_alloc_irqs_range_locked(struct device *dev, unsigned int domid,
 				       unsigned int first, unsigned int last);
 int msi_domain_alloc_irqs_range(struct device *dev, unsigned int domid,
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -240,6 +240,7 @@ static void msi_device_data_release(stru
 	int i;
 
 	for (i = 0; i < MSI_MAX_DEVICE_IRQDOMAINS; i++) {
+		msi_remove_device_irq_domain(dev, i);
 		WARN_ON_ONCE(!xa_empty(&md->__domains[i].store));
 		xa_destroy(&md->__domains[i].store);
 	}
@@ -849,6 +850,143 @@ bool msi_parent_init_dev_msi_info(struct
 							 msi_child_info);
 }
 
+/**
+ * msi_create_device_irq_domain - Create a device MSI interrupt domain
+ * @dev:		Pointer to the device
+ * @domid:		Domain id
+ * @template:		MSI domain info bundle used as template
+ * @hwsize:		Maximum number of MSI table entries (0 if unknown or unlimited)
+ * @domain_data:	Optional pointer to domain specific data which is set in
+ *			msi_domain_info::data
+ * @chip_data:		Optional pointer to chip specific data which is set in
+ *			msi_domain_info::chip_data
+ *
+ * Return: True on success, false otherwise
+ *
+ * There is no firmware node required for this interface because the per
+ * device domains are software constructs which are actually closer to the
+ * hardware reality than any firmware can describe them.
+ *
+ * The domain name and the irq chip name for a MSI device domain are
+ * composed by: "$(PREFIX)$(CHIPNAME)-$(DEVNAME)"
+ *
+ * $PREFIX:   Optional prefix provided by the underlying MSI parent domain
+ *	      via msi_parent_ops::prefix. If that pointer is NULL the prefix
+ *	      is empty.
+ * $CHIPNAME: The name of the irq_chip in @template
+ * $DEVNAME:  The name of the device
+ *
+ * This results in understandable chip names and hardware interrupt numbers
+ * in e.g. /proc/interrupts
+ *
+ * PCI-MSI-0000:00:1c.0     0-edge  Parent domain has no prefix
+ * IR-PCI-MSI-0000:00:1c.4  0-edge  Same with interrupt remapping prefix 'IR-'
+ *
+ * IR-PCI-MSIX-0000:3d:00.0 0-edge  Hardware interrupt numbers reflect
+ * IR-PCI-MSIX-0000:3d:00.0 1-edge  the real MSI-X index on that device
+ * IR-PCI-MSIX-0000:3d:00.0 2-edge
+ *
+ * On IMS domains the hardware interrupt number is either a table entry
+ * index or a purely software managed index but it is guaranteed to be
+ * unique.
+ *
+ * The domain pointer is stored in @dev::msi::data::__irqdomains[]. All
+ * subsequent operations on the domain depend on the domain id.
+ *
+ * The domain is automatically freed when the device is removed via devres
+ * in the context of @dev::msi::data freeing, but it can also be
+ * independently removed via @msi_remove_device_irq_domain().
+ */
+bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
+				  const struct msi_domain_template *template,
+				  unsigned int hwsize, void *domain_data,
+				  void *chip_data)
+{
+	struct irq_domain *domain, *parent = dev->msi.domain;
+	const struct msi_parent_ops *pops;
+	struct msi_domain_template *bundle;
+	struct fwnode_handle *fwnode;
+
+	if (!irq_domain_is_msi_parent(parent))
+		return false;
+
+	if (domid >= MSI_MAX_DEVICE_IRQDOMAINS)
+		return false;
+
+	bundle = kmemdup(template, sizeof(*bundle), GFP_KERNEL);
+	if (!bundle)
+		return false;
+
+	bundle->info.hwsize = hwsize;
+	bundle->info.chip = &bundle->chip;
+	bundle->info.ops = &bundle->ops;
+	bundle->info.data = domain_data;
+	bundle->info.chip_data = chip_data;
+
+	pops = parent->msi_parent_ops;
+	snprintf(bundle->name, sizeof(bundle->name), "%s%s-%s",
+		 pops->prefix ? : "", bundle->chip.name, dev_name(dev));
+	bundle->chip.name = bundle->name;
+
+	fwnode = irq_domain_alloc_named_fwnode(bundle->name);
+	if (!fwnode)
+		goto free_bundle;
+
+	if (msi_setup_device_data(dev))
+		goto free_fwnode;
+
+	msi_lock_descs(dev);
+
+	if (WARN_ON_ONCE(msi_get_device_domain(dev, domid)))
+		goto fail;
+
+	if (!pops->init_dev_msi_info(dev, parent, parent, &bundle->info))
+		goto fail;
+
+	domain = __msi_create_irq_domain(fwnode, &bundle->info, IRQ_DOMAIN_FLAG_MSI_DEVICE, parent);
+	if (!domain)
+		goto fail;
+
+	domain->dev = dev;
+	dev->msi.data->__domains[domid].domain = domain;
+	msi_unlock_descs(dev);
+	return true;
+
+fail:
+	msi_unlock_descs(dev);
+free_fwnode:
+	kfree(fwnode);
+free_bundle:
+	kfree(bundle);
+	return false;
+}
+
+/**
+ * msi_remove_device_irq_domain - Free a device MSI interrupt domain
+ * @dev:	Pointer to the device
+ * @domid:	Domain id
+ */
+void msi_remove_device_irq_domain(struct device *dev, unsigned int domid)
+{
+	struct msi_domain_info *info;
+	struct irq_domain *domain;
+
+	msi_lock_descs(dev);
+
+	domain = msi_get_device_domain(dev, domid);
+
+	if (!domain || !irq_domain_is_msi_device(domain))
+		goto unlock;
+
+	dev->msi.data->__domains[domid].domain = NULL;
+	info = domain->host_data;
+	irq_domain_remove(domain);
+	kfree(container_of(info, struct msi_domain_template, info));
+
+unlock:
+	msi_unlock_descs(dev);
+}
+
 int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
 			    int nvec, msi_alloc_info_t *arg)
 {

