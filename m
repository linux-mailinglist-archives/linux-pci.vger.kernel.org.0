Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9534B6326B3
	for <lists+linux-pci@lfdr.de>; Mon, 21 Nov 2022 15:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbiKUOsT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Nov 2022 09:48:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbiKUOrq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Nov 2022 09:47:46 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35F9D3283;
        Mon, 21 Nov 2022 06:41:51 -0800 (PST)
Message-ID: <20221121140049.301480611@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1669041588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=kl5jEFmZ6mV3MxctqQhK0mI7GqDB/127fsAWZEDHGQ4=;
        b=t/MsyzEBwE5k1Edq3y3kvTBANZV0O2ddSvfhvolvR+zZnU9MzXt6cYGo40UzFSOUtcjjul
        wETGPWwc45KGUGmH9nSYmRif8veDZxXnaZRBAkmvsiw3Dtr9MC5PulBoZwF7kdIN0N9L2t
        s5C+05g5r9xI+DArNrW/7oe1j2XN1eAHPiCbdMoFqlH1by7TiktOQCinkeUpxF1tVXoCU3
        r3kvi6b+P9koiJ6WPCEZQMNrBxDjaJbDuCyr4QJbVR/nDf6bZvDaj12j7oI5o4ZQSwlJfe
        wHNNpmLe8Ix1Q4VpnS+dLvUkKNZCHj8qr255HVOXxUL9HrYBMPCTx65Kj1RXMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1669041588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=kl5jEFmZ6mV3MxctqQhK0mI7GqDB/127fsAWZEDHGQ4=;
        b=/2nHaNj8gHb80Ft70cE0eTktfhiSxxG04atdWQJIAxt6nK2X8oncIsGOW1zVDPUxa5g/1W
        /rsCxDJNiGoYwvDw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Will Deacon <will@kernel.org>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ammar Faizi <ammarfaizi2@gnuweeb.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: [patch V2 16/40] platform-msi: Prepare for real per device domains
References: <20221121135653.208611233@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 21 Nov 2022 15:39:48 +0100 (CET)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Provide functions to create and remove per device MSI domains which replace
the platform-MSI domains. The new model is that each of the devices which
utilize platform-MSI gets now its private MSI domain which is "customized"
in size and with a device specific function to write the MSI message into
the device.

This is the same functionality as platform-MSI but it avoids all the down
sides of platform MSI, i.e. the extra ID book keeping, the special data
structure in the msi descriptor. Further the domains are only created when
the devices are really in use, so the burden is on the usage and not on the
infrastructure.

Fill in the domain template and provide two functions to init/allocate and
remove a per device MSI domain.

Until all users and parent domain providers are converted, the init/alloc
function invokes the original platform-MSI code when the irqdomain which is
associated to the device does not provide MSI parent functionality yet.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/base/platform-msi.c |   98 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/msi.h         |    4 +
 2 files changed, 102 insertions(+)

--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -13,6 +13,8 @@
 #include <linux/msi.h>
 #include <linux/slab.h>
 
+/* Begin of removal area. Once everything is converted over. Cleanup the includes too! */
+
 #define DEV_ID_SHIFT	21
 #define MAX_DEV_MSIS	(1 << (32 - DEV_ID_SHIFT))
 
@@ -349,3 +351,99 @@ int platform_msi_device_domain_alloc(str
 
 	return msi_domain_populate_irqs(domain->parent, dev, virq, nr_irqs, &data->arg);
 }
+
+/* End of removal area */
+
+/* Real per device domain interfaces */
+
+/*
+ * This indirection can go when platform_device_ims_init_and_alloc_irqs()
+ * is switched to a proper irq_chip::irq_write_msi_msg() callback. Keep it
+ * simple for now.
+ */
+static void platform_msi_write_msi_msg(struct irq_data *d, struct msi_msg *msg)
+{
+	irq_write_msi_msg_t cb = d->chip_data;
+
+	cb(irq_data_get_msi_desc(d), msg);
+}
+
+static void platform_msi_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
+{
+	arg->desc = desc;
+	arg->hwirq = desc->msi_index;
+}
+
+static const struct msi_domain_template platform_msi_template = {
+	.chip = {
+		.name			= "pMSI",
+		.irq_mask		= irq_chip_mask_parent,
+		.irq_unmask		= irq_chip_unmask_parent,
+		.irq_write_msi_msg	= platform_msi_write_msi_msg,
+		/* The rest is filled in by the platform MSI parent */
+	},
+
+	.ops = {
+		.set_desc		= platform_msi_set_desc,
+	},
+
+	.info = {
+		.bus_token		= DOMAIN_BUS_DEVICE_IMS,
+	},
+};
+
+/**
+ * platform_device_ims_init_and_alloc_irqs - Initialize platform device IMS
+ *					     and allocate interrupts for @dev
+ * @dev:		The device for which to allocate interrupts
+ * @nvec:		The number of interrupts to allocate
+ * @write_msi_msg:	Callback to write an interrupt message for @dev
+ *
+ * Returns:
+ * Zero for success, or an error code in case of failure
+ *
+ * This creates a MSI domain on @dev which has @dev->msi.domain as
+ * parent. The parent domain sets up the new domain. The domain has
+ * a fixed size of @nvec. The domain is managed by devres and will
+ * be removed when the device is removed.
+ *
+ * Note: For migration purposes this falls back to the original platform_msi code
+ *	 up to the point where all platforms have been converted to the MSI
+ *	 parent model.
+ */
+int platform_device_ims_init_and_alloc_irqs(struct device *dev, unsigned int nvec,
+					    irq_write_msi_msg_t write_msi_msg)
+{
+	struct irq_domain *domain = dev->msi.domain;
+	int ret;
+
+	if (!domain || !write_msi_msg)
+		return -EINVAL;
+
+	/* Migration support. Will go away once everything is converted */
+	if (!irq_domain_is_msi_parent(domain))
+		return platform_msi_domain_alloc_irqs(dev, nvec, write_msi_msg);
+
+	/*
+	 * @write_msi_msg is stored in the resulting msi_domain_info::data.
+	 * The underlying domain creation mechanism will assign that
+	 * callback to the resulting irq chip.
+	 */
+	if (!msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN,
+					  &platform_msi_template,
+					  nvec, NULL, write_msi_msg))
+		return -ENODEV;
+
+	return msi_domain_alloc_irqs_range(dev, MSI_DEFAULT_DOMAIN, 0, nvec - 1);
+}
+EXPORT_SYMBOL_GPL(platform_device_ims_init_and_alloc_irqs);
+
+/**
+ * platform_device_ims_free_irqs_all - Free all interrupts for @dev
+ * @dev:	The device for which to free interrupts
+ */
+void platform_device_ims_free_irqs_all(struct device *dev)
+{
+	msi_domain_free_irqs_all(dev, MSI_DEFAULT_DOMAIN);
+}
+EXPORT_SYMBOL_GPL(platform_device_ims_free_irqs_all);
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -649,6 +649,10 @@ int platform_msi_device_domain_alloc(str
 void platform_msi_device_domain_free(struct irq_domain *domain, unsigned int virq,
 				     unsigned int nvec);
 void *platform_msi_get_host_data(struct irq_domain *domain);
+/* Per device platform MSI */
+int platform_device_ims_init_and_alloc_irqs(struct device *dev, unsigned int nvec,
+					    irq_write_msi_msg_t write_msi_msg);
+void platform_device_ims_free_irqs_all(struct device *dev);
 #endif /* CONFIG_GENERIC_MSI_IRQ */
 
 /* PCI specific interfaces */

