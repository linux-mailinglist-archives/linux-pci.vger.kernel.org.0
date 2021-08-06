Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C35D3E2596
	for <lists+linux-pci@lfdr.de>; Fri,  6 Aug 2021 10:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243787AbhHFIVF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Aug 2021 04:21:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53182 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244125AbhHFIUM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Aug 2021 04:20:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628237995;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ycQUvev7iFjmkY/FUwE/4xwJ5iynNiXFiSZ1F9WCv/o=;
        b=aD+/c5HNYLPZB45GiBAPwX4v9JDSGixsLiDBHjNx9ziHhwzh7Vlv0SXEIvc843846TsFtm
        uEE3zcEOhim86FasJV68c7MwZSpYgQTT8bSRhZnw5ulbqj8Wg2M0MyUtWNU0m4N13e/s0R
        XMwFzLey7GxKhWafp/iiV7WuOPlZ4Es=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-xwwM32WiOMqcgt5UyQLRSQ-1; Fri, 06 Aug 2021 04:19:52 -0400
X-MC-Unique: xwwM32WiOMqcgt5UyQLRSQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E10EC1006C80;
        Fri,  6 Aug 2021 08:19:50 +0000 (UTC)
Received: from localhost (ovpn-13-152.pek2.redhat.com [10.72.13.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 982141002D71;
        Fri,  6 Aug 2021 08:19:45 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: [RESEND PATCH V3] genirq/affinity: add helper of irq_affinity_calc_sets
Date:   Fri,  6 Aug 2021 16:19:37 +0800
Message-Id: <20210806081937.300166-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
V3:
	- avoid pointless negations
V2:
	- move WARN_ON_ONCE() into irq_affinity_calc_sets
	- don't install default calc_sets() callback as suggested by
	Christoph

 drivers/pci/msi.c         |  3 ++-
 include/linux/interrupt.h |  7 +++++++
 kernel/irq/affinity.c     | 28 +++++++++++++++++-----------
 3 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 9232255c8515..4e6fbdf0741c 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1224,7 +1224,8 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 			 * for the single interrupt case.
 			 */
 			if (affd)
-				irq_create_affinity_masks(1, affd);
+				irq_affinity_calc_sets(1, affd);
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
index 4d89ad4fae3b..2030770e8cff 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -405,6 +405,22 @@ static void default_calc_sets(struct irq_affinity *affd, unsigned int affvecs)
 	affd->set_size[0] = affvecs;
 }
 
+int irq_affinity_calc_sets(unsigned int affvecs, struct irq_affinity *affd)
+{
+	/*
+	 * Simple invocations do not provide a calc_sets() callback. Call
+	 * the generic one.
+	 */
+	if (affd->calc_sets)
+		affd->calc_sets(affd, affvecs);
+	else
+		default_calc_sets(affd, affvecs);
+
+	if (WARN_ON_ONCE(affd->nr_sets > IRQ_AFFINITY_MAX_SETS))
+		return -ERANGE;
+	return 0;
+}
+
 /**
  * irq_create_affinity_masks - Create affinity masks for multiqueue spreading
  * @nvecs:	The total number of vectors
@@ -429,17 +445,7 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
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
+	if (irq_affinity_calc_sets(affvecs, affd))
 		return NULL;
 
 	/* Nothing to assign? */
-- 
2.31.1

