Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1684345FB49
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 02:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347407AbhK0BiF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 20:38:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:40764 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352462AbhK0BgE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 20:36:04 -0500
Message-ID: <20211127000919.004572849@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=iXWx8ngjVm94paCMjL44qtncyzw3jmQTRYweVvwdUTE=;
        b=XMZ8+C4S5qdKr1Con79Z8ll6XVMM2fnwfUd6VibARMXKBZJmbzz2rdgHplVFzqQWoTjqXL
        a71t/1Td6DZLsRGHxaA0Xy69M6LynlfnUWWrPppwCpmvz1S4krQdufBQTGAqkoP0l3s8T3
        5/d33e6N4qMca0wqhegVl6SB4Kg+rkn1Q5Lq3ndlMN3YDCufaLN+bpKiuw5/eO8PEddKg7
        KXX4wVb7cTsJ2Tc/55bKjXTrqTb0PPVsc9nsJs/ZzoOSFGZaIbOseCSK90/VO3qoq0OR3S
        bX2HgbvnzX2XCKSBc8Aiz7O3JmG+aqKSvt2jQ+saMx9qcR/0zEVPXRcCgYtdXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=iXWx8ngjVm94paCMjL44qtncyzw3jmQTRYweVvwdUTE=;
        b=KqCEEAwQIQ5ub2ZhfoOhVriWcwZnFHllmQP6Q5tXV21krUdnjIG0tW2/eI3ljwxV7nF3wo
        hBnPVTOZ03C+6jDQ==
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
Subject: [patch 09/10] PCI/MSI: Provide pci_msix_expand_vectors[_at]()
References: <20211126233124.618283684@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:25:11 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Provide a new interface which allows to expand the MSI-X vector space if
the underlying irq domain implementation supports it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi/msi.c |   41 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h   |   13 +++++++++++++
 2 files changed, 54 insertions(+)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -1025,6 +1025,47 @@ int pci_alloc_irq_vectors_affinity(struc
 EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
 
 /**
+ * pci_msix_expand_vectors_at - Expand MSI-X interrupts for a device
+ *
+ * @dev:	PCI device to operate on
+ * @at:		Allocate at MSI-X index. If @at == PCI_MSI_EXPAND_AUTO
+ *		the function expands automatically after the last
+ *		active index.
+ * @nvec:	Number of vectors to allocate
+ *
+ * Expand the MSI-X vectors of a device after an initial enablement and
+ * allocation.
+ *
+ * Return: 0 if the allocation was successful, an error code otherwise.
+ */
+int pci_msix_expand_vectors_at(struct pci_dev *dev, unsigned int at, unsigned int nvec)
+{
+	struct msi_device_data *md = dev->dev.msi.data;
+	struct msi_range range = { .ndesc = nvec, };
+	unsigned int max_vecs;
+	int ret;
+
+	if (!pci_msi_enable || !dev || !dev->msix_enabled || !md)
+		return -ENOTSUPP;
+
+	if (!pci_msi_domain_supports_expand(dev))
+		return -ENOTSUPP;
+
+	max_vecs = pci_msix_vec_count(dev);
+	if (!nvec || nvec > max_vecs)
+		return -EINVAL;
+
+	range.first = at == PCI_MSIX_EXPAND_AUTO ? md->num_descs : at;
+
+	if (range.first >= max_vecs || nvec > max_vecs - range.first)
+		return -ENOSPC;
+
+	ret = msix_setup_interrupts(dev, dev->msix_base, &range, NULL, NULL, true);
+	return ret <= 0 ? ret : -ENOSPC;;
+}
+EXPORT_SYMBOL_GPL(pci_msix_expand_vectors_at);
+
+/**
  * pci_free_irq_vectors - free previously allocated IRQs for a device
  * @dev:		PCI device to operate on
  *
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1534,6 +1534,7 @@ static inline int pci_enable_msix_exact(
 int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 				   unsigned int max_vecs, unsigned int flags,
 				   struct irq_affinity *affd);
+int pci_msix_expand_vectors_at(struct pci_dev *dev, unsigned int at, unsigned int nvec);
 
 void pci_free_irq_vectors(struct pci_dev *dev);
 int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
@@ -1565,6 +1566,11 @@ pci_alloc_irq_vectors_affinity(struct pc
 	return -ENOSPC;
 }
 
+static inline int pci_msix_expand_vectors_at(struct pci_dev *dev, unsigned int at, unsigned int nvec)
+{
+	return -ENOTSUPP;
+}
+
 static inline void pci_free_irq_vectors(struct pci_dev *dev)
 {
 }
@@ -1582,6 +1588,13 @@ static inline const struct cpumask *pci_
 }
 #endif
 
+#define PCI_MSIX_EXPAND_AUTO	(UINT_MAX)
+
+static inline int pci_msix_expand_vectors(struct pci_dev *dev, unsigned int nvec)
+{
+	return pci_msix_expand_vectors_at(dev, PCI_MSIX_EXPAND_AUTO, nvec);
+}
+
 /**
  * pci_irqd_intx_xlate() - Translate PCI INTx value to an IRQ domain hwirq
  * @d: the INTx IRQ domain

