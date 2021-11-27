Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2197E45FB3E
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 02:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346353AbhK0BhT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 20:37:19 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40746 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350570AbhK0BfS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 20:35:18 -0500
Message-ID: <20211127000918.594818541@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=EW+Gm4C9srsYC5SImaDJkppoIX48hbwPcUobStKFJEM=;
        b=WPtHzJnqC/pvKOTKIh1WRHHQJ9m+SrUMIkLf9wya1H4Qe6kX/FjXJxpDkYVQi9r5c2JVzZ
        eldEBhETCeNkaX33xH9U7/qQtC6MjjRZbuA0biqdYe0j6ynzURABx2EW7ToDAZEPDghbHu
        2byWMlSljGkM+P7knI47JSpaSBXc80u/NsAHfS1oFNv7F4s9jJvUCPHjtfHQkwF+4eIjOr
        vhdvbRKjtz2/rE8kchNQYUxAz2X7cCEjpq8STzeSs2Lz1YCB5Y/LDXa4n1cOQodqa4f9F4
        45PWlB6lvsF08kNIEzF+igCOsVF1D0E6v7sOUmLpX2bgbZ4ej72smMbjMrrW+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=EW+Gm4C9srsYC5SImaDJkppoIX48hbwPcUobStKFJEM=;
        b=f2HlKwCdkwO2fqJ4/LJVZyypea5bEsyJHp/ABfz87E53J5cxaBIKdNf2B2KQQimDJ8mO2U
        8kjukHl5RWBoBsBg==
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
Subject: [patch 02/10] genirq/msi: Add range argument to
 msi_domain_alloc/free_descs_locked()
References: <20211126233124.618283684@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:25:00 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In preparation for supporting range allocations for MSI-X, add a range
argument to the msi_domain_alloc/free_descs_locked() functions and fixup
all affected places.

Hand in ranges which are covering the current use case. They will be
refined in later steps.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi/irqdomain.c |    6 ++++--
 include/linux/msi.h         |    5 ++---
 kernel/irq/msi.c            |   21 ++++++++++++---------
 3 files changed, 18 insertions(+), 14 deletions(-)

--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -10,22 +10,24 @@
 
 int pci_msi_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
 {
+	struct msi_range range = { .first = 0, .last = UINT_MAX, .ndesc = nvec};
 	struct irq_domain *domain;
 
 	domain = dev_get_msi_domain(&dev->dev);
 	if (domain && irq_domain_is_hierarchy(domain))
-		return msi_domain_alloc_irqs_descs_locked(domain, &dev->dev, nvec);
+		return msi_domain_alloc_irqs_descs_locked(domain, &dev->dev, &range);
 
 	return pci_msi_legacy_setup_msi_irqs(dev, nvec, type);
 }
 
 void pci_msi_teardown_msi_irqs(struct pci_dev *dev)
 {
+	struct msi_range range = { .first = 0, .last = UINT_MAX, };
 	struct irq_domain *domain;
 
 	domain = dev_get_msi_domain(&dev->dev);
 	if (domain && irq_domain_is_hierarchy(domain))
-		msi_domain_free_irqs_descs_locked(domain, &dev->dev);
+		msi_domain_free_irqs_descs_locked(domain, &dev->dev, &range);
 	else
 		pci_msi_legacy_teardown_msi_irqs(dev);
 }
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -502,12 +502,11 @@ struct irq_domain *msi_create_irq_domain
 					 struct msi_domain_info *info,
 					 struct irq_domain *parent);
 int __msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev, struct msi_range *range);
-int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct device *dev,
-				       int nvec);
+int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct device *dev,  struct msi_range *range);
 int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 			  int nvec);
 void __msi_domain_free_irqs(struct irq_domain *domain, struct device *dev, struct msi_range *range);
-void msi_domain_free_irqs_descs_locked(struct irq_domain *domain, struct device *dev);
+void msi_domain_free_irqs_descs_locked(struct irq_domain *domain, struct device *dev, struct msi_range *range);
 void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev);
 struct msi_domain_info *msi_get_domain_info(struct irq_domain *domain);
 
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -956,22 +956,21 @@ static int msi_domain_add_simple_msi_des
  * Return: %0 on success or an error code.
  */
 int msi_domain_alloc_irqs_descs_locked(struct irq_domain *domain, struct device *dev,
-				       int nvec)
+				       struct msi_range *range)
 {
 	struct msi_domain_info *info = domain->host_data;
-	struct msi_range range = { .ndesc = nvec };
 	struct msi_domain_ops *ops = info->ops;
 	int ret;
 
 	lockdep_assert_held(&dev->msi.data->mutex);
 
-	ret = msi_domain_add_simple_msi_descs(info, dev, nvec);
+	ret = msi_domain_add_simple_msi_descs(info, dev, range->ndesc);
 	if (ret)
 		return ret;
 
-	ret = ops->domain_alloc_irqs(domain, dev, &range);
+	ret = ops->domain_alloc_irqs(domain, dev, range);
 	if (ret)
-		msi_domain_free_irqs_descs_locked(domain, dev);
+		msi_domain_free_irqs_descs_locked(domain, dev, range);
 	return ret;
 }
 
@@ -986,10 +985,11 @@ int msi_domain_alloc_irqs_descs_locked(s
  */
 int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev, int nvec)
 {
+	struct msi_range range = { .first = 0, .last = UINT_MAX, .ndesc = nvec, };
 	int ret;
 
 	msi_lock_descs(dev);
-	ret = msi_domain_alloc_irqs_descs_locked(domain, dev, nvec);
+	ret = msi_domain_alloc_irqs_descs_locked(domain, dev, &range);
 	msi_unlock_descs(dev);
 	return ret;
 }
@@ -1034,14 +1034,15 @@ static void msi_domain_free_msi_descs(st
  * pair. Use this for MSI irqdomains which implement their own vector
  * allocation.
  */
-void msi_domain_free_irqs_descs_locked(struct irq_domain *domain, struct device *dev)
+void msi_domain_free_irqs_descs_locked(struct irq_domain *domain, struct device *dev,
+				       struct msi_range *range)
 {
 	struct msi_domain_info *info = domain->host_data;
 	struct msi_domain_ops *ops = info->ops;
 
 	lockdep_assert_held(&dev->msi.data->mutex);
 
-	ops->domain_free_irqs(domain, dev, NULL);
+	ops->domain_free_irqs(domain, dev, range);
 	msi_domain_free_msi_descs(info, dev);
 }
 
@@ -1053,8 +1054,10 @@ void msi_domain_free_irqs_descs_locked(s
  */
 void msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
 {
+	struct msi_range range = { .first = 0, .last = UINT_MAX, };
+
 	msi_lock_descs(dev);
-	msi_domain_free_irqs_descs_locked(domain, dev);
+	msi_domain_free_irqs_descs_locked(domain, dev, &range);
 	msi_unlock_descs(dev);
 }
 

