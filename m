Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52C22D5FB3
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2019 12:04:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbfJNKEz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Oct 2019 06:04:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:49320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730880AbfJNKEz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 14 Oct 2019 06:04:55 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF3002084B;
        Mon, 14 Oct 2019 10:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571047494;
        bh=/dPCnM0sRa4kGSye3Rf0LjIhbgJ3x67VnI6L/yo5sgg=;
        h=Date:From:To:Cc:Subject:From;
        b=s3xAAtEtwoBVhhGugBYvNxTSIX8Uq3e5eJ2d6fH2Bq8fz9SJqspDwTiEqQoFdudnn
         gajGY+ZW6LtYxLL+jYRUsyOz53CO5VAu6lpbUt0i/WjQ9ccw2GdqtCtfwUh5pvZaqQ
         pAaqr+nXAbM7sbZZ4XQPtaMCnd/BqevExcZRUHjw=
Date:   Mon, 14 Oct 2019 12:04:52 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: msi: remove pci_irq_get_node() as no one is using it
Message-ID: <20191014100452.GA6699@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The function pci_irq_get_node() is not used by anyone in the tree, so
just delete it.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 0884bedcfc7a..f95fe23830f0 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1315,22 +1315,6 @@ const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
 }
 EXPORT_SYMBOL(pci_irq_get_affinity);
 
-/**
- * pci_irq_get_node - return the NUMA node of a particular MSI vector
- * @pdev:	PCI device to operate on
- * @vec:	device-relative interrupt vector index (0-based).
- */
-int pci_irq_get_node(struct pci_dev *pdev, int vec)
-{
-	const struct cpumask *mask;
-
-	mask = pci_irq_get_affinity(pdev, vec);
-	if (mask)
-		return local_memory_node(cpu_to_node(cpumask_first(mask)));
-	return dev_to_node(&pdev->dev);
-}
-EXPORT_SYMBOL(pci_irq_get_node);
-
 struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc)
 {
 	return to_pci_dev(desc->dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index f9088c89a534..755d8c0176b9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1454,7 +1454,6 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 void pci_free_irq_vectors(struct pci_dev *dev);
 int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
 const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev, int vec);
-int pci_irq_get_node(struct pci_dev *pdev, int vec);
 
 #else
 static inline int pci_msi_vec_count(struct pci_dev *dev) { return -ENOSYS; }
@@ -1497,11 +1496,6 @@ static inline const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev,
 {
 	return cpu_possible_mask;
 }
-
-static inline int pci_irq_get_node(struct pci_dev *pdev, int vec)
-{
-	return first_online_node;
-}
 #endif
 
 /**
