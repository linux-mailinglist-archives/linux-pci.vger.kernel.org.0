Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E939A3C9DA3
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jul 2021 13:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239525AbhGOLVg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 07:21:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29662 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240229AbhGOLVg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jul 2021 07:21:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626347923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ALRhOVcBk05in4fNQsx40YRimWBCLQdxg6jZkws4So0=;
        b=J8VT69JaGAsVznw78VTuCJO8GaaoMauUVDgmjxPRF2C7rbx5fW2EkGlih628Ty+0xQzTZB
        pJoi2XKliPSqYHt1oZyO81XjGwjQeIIyNM6rRhBGA/W8ib7vFleO/D+mtMhsZxe7aRINRq
        hHoKTH8GxYNUgAzCkRKbIqv3B1Belio=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-j-3-GxuYNSCT1ngrbO9ZCg-1; Thu, 15 Jul 2021 07:18:41 -0400
X-MC-Unique: j-3-GxuYNSCT1ngrbO9ZCg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 57E221084F4B;
        Thu, 15 Jul 2021 11:18:40 +0000 (UTC)
Received: from localhost (ovpn-12-61.pek2.redhat.com [10.72.12.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3C8DC19C45;
        Thu, 15 Jul 2021 11:18:35 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH] genirq/affinity: add helper of irq_affinity_calc_sets
Date:   Thu, 15 Jul 2021 19:18:27 +0800
Message-Id: <20210715111827.569756-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When driver requests to allocate irq affinity managed vectors,
pci_alloc_irq_vectors_affinity() may fallback to single vector
allocation. In this situation, we don't need to call
irq_create_affinity_masks for calling into ->calc_sets() for
avoiding potential memory leak, so add the helper for this purpose.

Fixes: c66d4bd110a1 ("genirq/affinity: Add new callback for (re)calculating interrupt sets")
Reported-by: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/pci/msi.c         |  3 ++-
 include/linux/interrupt.h |  7 +++++++
 kernel/irq/affinity.c     | 29 ++++++++++++++++++-----------
 3 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 9232255c8515..3d6db20d1b2b 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1224,7 +1224,8 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 			 * for the single interrupt case.
 			 */
 			if (affd)
-				irq_create_affinity_masks(1, affd);
+				WARN_ON_ONCE(irq_affinity_calc_sets(1, affd));
+
 			pci_intx(dev, 1);
 			return 1;
 		}
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 2ed65b01c961..c7ff84d60465 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -340,6 +340,7 @@ irq_create_affinity_masks(unsigned int nvec, struct irq_affinity *affd);
 
 unsigned int irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
 				       const struct irq_affinity *affd);
+int irq_affinity_calc_sets(unsigned int affvecs, struct irq_affinity *affd);
 
 #else /* CONFIG_SMP */
 
@@ -391,6 +392,12 @@ irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
 	return maxvec;
 }
 
+static inline int irq_affinity_calc_sets(unsigned int affvecs,
+					 struct irq_affinity *affd)
+{
+	return 0;
+}
+
 #endif /* CONFIG_SMP */
 
 /*
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 4d89ad4fae3b..735f697d7d15 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -405,6 +405,23 @@ static void default_calc_sets(struct irq_affinity *affd, unsigned int affvecs)
 	affd->set_size[0] = affvecs;
 }
 
+int irq_affinity_calc_sets(unsigned int affvecs, struct irq_affinity *affd)
+{
+	/*
+	 * Simple invocations do not provide a calc_sets() callback. Install
+	 * the generic one.
+	 */
+	if (!affd->calc_sets)
+		affd->calc_sets = default_calc_sets;
+
+	/* Recalculate the sets */
+	affd->calc_sets(affd, affvecs);
+
+	if (affd->nr_sets > IRQ_AFFINITY_MAX_SETS)
+		return -ERANGE;
+	return 0;
+}
+
 /**
  * irq_create_affinity_masks - Create affinity masks for multiqueue spreading
  * @nvecs:	The total number of vectors
@@ -429,17 +446,7 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 	else
 		affvecs = 0;
 
-	/*
-	 * Simple invocations do not provide a calc_sets() callback. Install
-	 * the generic one.
-	 */
-	if (!affd->calc_sets)
-		affd->calc_sets = default_calc_sets;
-
-	/* Recalculate the sets */
-	affd->calc_sets(affd, affvecs);
-
-	if (WARN_ON_ONCE(affd->nr_sets > IRQ_AFFINITY_MAX_SETS))
+	if (WARN_ON_ONCE(irq_affinity_calc_sets(affvecs, affd)))
 		return NULL;
 
 	/* Nothing to assign? */
-- 
2.31.1

