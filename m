Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2669C625C60
	for <lists+linux-pci@lfdr.de>; Fri, 11 Nov 2022 15:05:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234386AbiKKOFz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Nov 2022 09:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234285AbiKKOFl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Nov 2022 09:05:41 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9846E8B2C7;
        Fri, 11 Nov 2022 05:59:17 -0800 (PST)
Message-ID: <20221111135205.658112153@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668175102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=9djoTnmW2VtqTMdaiZC8X9Gnafs0aQyZvLVu/huu2eY=;
        b=u3GZ9jOyY697Umvm6Bz8b77Vr10iY59IVHLL7RWVSAz+ip6JECS/SJRThTpobNZxb6uiap
        O2Crja51Es4Pge/PZRg8dATgOjNJpPUIc+ZRHX+MSWlUH6AS/2YxaXFrLvefFpjkZgyS3j
        TXBf04VWVaKQ9mohx1RkfKrK3GW9iDM1ZnU/cbjdHEgtoHl8xbe+zNplYyJA9TfDrf3ODI
        iV3y9MEw79iqf3nFdaQ9dXGHVhbHCmpt/mWVXMs3iFAcpmb/zY/Vv6evXK78mP7nO/b0pv
        YizNZfVMly6DmACKEB3IURNPZzcRa89ptiItf1tNYeId1h88yY/otRQzUuNUVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668175102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=9djoTnmW2VtqTMdaiZC8X9Gnafs0aQyZvLVu/huu2eY=;
        b=jp7f4Xus9IpGRuTKh8gJZ2gBs16nAevYOaKBKHy0wvF5NlHAb1kZ29AslIPptmRPs4LKfB
        4eKSp/7lSfUzlBDQ==
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
Subject: [patch 07/33] genirq/msi: Provide msi_create/free_device_irq_domain()
References: <20221111133158.196269823@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Fri, 11 Nov 2022 14:58:22 +0100 (CET)
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
 include/linux/msi.h |    6 ++
 kernel/irq/msi.c    |  142 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 148 insertions(+)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -531,6 +531,12 @@ struct irq_domain *msi_create_irq_domain
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
@@ -52,6 +52,14 @@ static inline void msi_setup_default_irq
 		md->__irqdomains[MSI_DEFAULT_DOMAIN] = dev->msi.domain;
 }
 
+static inline void msi_remove_device_irqdomains(struct device *dev, struct msi_device_data *md)
+{
+	int domid;
+
+	for (domid = 0; domid < MSI_MAX_DEVICE_IRQDOMAINS; domid++)
+		msi_remove_device_irq_domain(dev, domid);
+}
+
 static int msi_get_domain_base_index(struct device *dev, unsigned int domid)
 {
 	lockdep_assert_held(&dev->msi.data->mutex);
@@ -281,6 +289,7 @@ static void msi_device_data_release(stru
 {
 	struct msi_device_data *md = res;
 
+	msi_remove_device_irqdomains(dev, md);
 	WARN_ON_ONCE(!xa_empty(&md->__store));
 	xa_destroy(&md->__store);
 	dev->msi.data = NULL;
@@ -869,6 +878,139 @@ bool msi_parent_init_dev_msi_info(struct
 	return parent->msi_parent_ops->init_dev_msi_info(dev, parent, real_parent, info);
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
+	bundle->info.hwsize = hwsize ? hwsize : MSI_MAX_INDEX;
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
+	dev->msi.data->__irqdomains[domid] = domain;
+	msi_unlock_descs(dev);
+	return true;
+
+fail:
+	msi_unlock_descs(dev);
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
+	dev->msi.data->__irqdomains[domid] = NULL;
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

