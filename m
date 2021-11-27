Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C13D45FC07
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 03:19:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350470AbhK0CWY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 21:22:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350328AbhK0CUM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 21:20:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D79C5C08EC69;
        Fri, 26 Nov 2021 17:32:02 -0800 (PST)
Message-ID: <20211127000918.534790941@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=FLvm8heMaeaty/kI8f2vBLPLCFbQls4zKlJo+z99yXU=;
        b=Rgn2VawwzQ0ib5p4AELlzTAOBT3z/JgcnD6AnK0Qfzl6Uwsil8g1x/9XiTMVZQsgyeVIi3
        0gXRql6Ez1Bwux6eJRLZZN6ep1ZKt7yHr9WNWwyQgv2J2iPQv2OpUkVTphzxjQc/TXjQd6
        QrEbHa8FlPjzAbmFfDyjz0xlOuEFu285ccRglffWT5nPxzJzVuJEmafUHPqz/AG3d8bbiC
        irhNiREHR29EkuDLYQYQiozWrtkmshtjkubVVO5yckAdZsLUMR7pd/idgzU6HQsYelAHGN
        ey2KAnWKLAw0kqNlSuHDIQ5OoiKhbviDoKw5C8m9d9EblJZtZ3+D8LXxcDlDeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976299;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=FLvm8heMaeaty/kI8f2vBLPLCFbQls4zKlJo+z99yXU=;
        b=OypxZJqCdtcbu0qEZDL96om+fVeYFNbs5Fj6R/pfkyy3JlnHxvBL8Mt/s28uDHYZRunVd2
        CR6gFWwaMCE9ObCQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Andrew Cooper <amc96@cam.ac.uk>,
        Juergen Gross <jgross@suse.com>, linux-pci@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: [patch 01/10] genirq/msi: Add range argument to alloc/free MSI domain ops
References: <20211126233124.618283684@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:24:58 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In preparation for supporting range allocations for MSI-X, add a range
argument to the MSI domain alloc/free function pointers and fixup all
affected places.

The range is supplied via a pointer to a struct msi_range which contains
the first and last MSI index and the number of vectors to allocate/free.

To support the sparse MSI-X allocations via pci_enable_msix_range() and
pci_enable_msix_exact() the number of vectors can be smaller than the range
defined by the first and last MSI index. This can be cleaned up later once
the code is converted by converting these sparse allocations to an initial
allocation on enable and expansion of the vector space at the required
indices.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/platforms/pseries/msi.c |    6 +++---
 arch/x86/pci/xen.c                   |   10 +++++-----
 include/linux/msi.h                  |   30 +++++++++++++++++++++++-------
 kernel/irq/msi.c                     |   12 ++++++------
 4 files changed, 37 insertions(+), 21 deletions(-)

--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -450,13 +450,13 @@ static void pseries_msi_ops_msi_free(str
  * RTAS can not disable one MSI at a time. It's all or nothing. Do it
  * at the end after all IRQs have been freed.
  */
-static void pseries_msi_domain_free_irqs(struct irq_domain *domain,
-					 struct device *dev)
+static void pseries_msi_domain_free_irqs(struct irq_domain *domain, struct device *dev,
+					 struct msi_range *range)
 {
 	if (WARN_ON_ONCE(!dev_is_pci(dev)))
 		return;
 
-	__msi_domain_free_irqs(domain, dev);
+	__msi_domain_free_irqs(domain, dev, range);
 
 	rtas_disable_msi(to_pci_dev(dev));
 }
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -407,8 +407,8 @@ static void xen_pv_teardown_msi_irqs(str
 	xen_teardown_msi_irqs(dev);
 }
 
-static int xen_msi_domain_alloc_irqs(struct irq_domain *domain,
-				     struct device *dev,  int nvec)
+static int xen_msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
+				     struct msi_range *range)
 {
 	int type;
 
@@ -420,11 +420,11 @@ static int xen_msi_domain_alloc_irqs(str
 	else
 		type = PCI_CAP_ID_MSI;
 
-	return xen_msi_ops.setup_msi_irqs(to_pci_dev(dev), nvec, type);
+	return xen_msi_ops.setup_msi_irqs(to_pci_dev(dev), range->ndesc, type);
 }
 
-static void xen_msi_domain_free_irqs(struct irq_domain *domain,
-				     struct device *dev)
+static void xen_msi_domain_free_irqs(struct irq_domain *domain, struct device *dev,
+				     struct msi_range *range)
 {
 	if (WARN_ON_ONCE(!dev_is_pci(dev)))
 		return;
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -191,6 +191,23 @@ struct msi_device_data {
 	enum msi_desc_filter		__iter_filter;
 };
 
+/**
+ * msi_range - Descriptor for a MSI index range
+ * @first:	First index
+ * @last:	Last index (inclusive)
+ * @ndesc:	Number of descriptors for allocations
+ *
+ * @first = 0 and @last = UINT_MAX is the full range for an operation.
+ *
+ * Note: @ndesc can be less than the range defined by @first and @last to
+ * support sparse allocations from PCI/MSI-X.
+ */
+struct msi_range {
+	unsigned int	first;
+	unsigned int	last;
+	unsigned int	ndesc;
+};
+
 int msi_setup_device_data(struct device *dev);
 
 /* MSI device properties */
@@ -415,10 +432,10 @@ struct msi_domain_ops {
 				       msi_alloc_info_t *arg);
 	void		(*set_desc)(msi_alloc_info_t *arg,
 				    struct msi_desc *desc);
-	int		(*domain_alloc_irqs)(struct irq_domain *domain,
-					     struct device *dev, int nvec);
-	void		(*domain_free_irqs)(struct irq_domain *domain,
-					    struct device *dev);
+	int		(*domain_alloc_irqs)(struct irq_domain *domain, struct device *dev,
+					     struct msi_range *range);
+	void		(*domain_free_irqs)(struct irq_domain *domain, struct device *dev,
+					    struct msi_range *range);
 };
 
 /**
@@ -484,13 +501,12 @@ int msi_domain_set_affinity(struct irq_d
 struct irq_domain *msi_create_irq_domain(struct fwnode_handle *fwnode,
 					 struct msi_domain_info *info,
 					 struct irq_domain *parent);
-int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
-			    int nvec);
+int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev, struct msi_range *range);
 int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct device *dev,
 				       int nvec);
 int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 			  int nvec);
-void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
+void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev, struct msi_range *range);
 void msi_domain_free_irqs_descs_locked(struct irq_domain *domain, struct device *dev);
 void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
 struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain);
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -869,8 +869,7 @@ static int msi_init_virq(struct irq_doma
 	return 0;
 }
 
-int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
-			    int nvec)
+int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev, struct msi_range *range)
 {
 	struct msi_domain_info *info = domain->host_data;
 	struct msi_domain_ops *ops = info->ops;
@@ -880,7 +879,7 @@ int __msi_domain_alloc_irqs(struct irq_d
 	int allocated = 0;
 	int i, ret, virq;
 
-	ret = msi_domain_prepare_irqs(domain, dev, nvec, &arg);
+	ret = msi_domain_prepare_irqs(domain, dev, range->ndesc, &arg);
 	if (ret)
 		return ret;
 
@@ -960,6 +959,7 @@ int msi_domain_alloc_irqs_descs_locked(s
 				       int nvec)
 {
 	struct msi_domain_info *info = domain->host_data;
+	struct msi_range range = { .ndesc = nvec };
 	struct msi_domain_ops *ops = info->ops;
 	int ret;
 
@@ -969,7 +969,7 @@ int msi_domain_alloc_irqs_descs_locked(s
 	if (ret)
 		return ret;
 
-	ret = ops->domain_alloc_irqs(domain, dev, nvec);
+	ret = ops->domain_alloc_irqs(domain, dev, &range);
 	if (ret)
 		msi_domain_free_irqs_descs_locked(domain, dev);
 	return ret;
@@ -994,7 +994,7 @@ int msi_domain_alloc_irqs(struct irq_dom
 	return ret;
 }
 
-void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
+void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev, struct msi_range *range)
 {
 	struct msi_domain_info *info = domain->host_data;
 	struct irq_data *irqd;
@@ -1041,7 +1041,7 @@ void msi_domain_free_irqs_descs_locked(s
 
 	lockdep_assert_held(&dev->msi.data->mutex);
 
-	ops->domain_free_irqs(domain, dev);
+	ops->domain_free_irqs(domain, dev, NULL);
 	msi_domain_free_msi_descs(info, dev);
 }
 

