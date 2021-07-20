Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 690303CF3A9
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jul 2021 06:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236395AbhGTEGk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jul 2021 00:06:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48231 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346412AbhGTEBy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jul 2021 00:01:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626756141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fKQJw44KnWWw6kFQEoZm4t5SzBRdmsu+r00ClxkZDTU=;
        b=bkjI4SRosP9ZyBqbDAqKPvHhDrV2c640m6tPnLkAfdA89KquV92+aMaSLnAPSBVudKcV7d
        pDBLqndNZVQ8foMAlw6pE3QK9ehiYKAj0gzSW1bLyNd7gKf0DJ3G9fdZgr01SZbRY9a3pD
        //b1n5fOam+LXAJYSJlC/s/6LXrvFs4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-z2E0QqyCN_2Q9H9fHiqZ4A-1; Tue, 20 Jul 2021 00:42:19 -0400
X-MC-Unique: z2E0QqyCN_2Q9H9fHiqZ4A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABDBB800050;
        Tue, 20 Jul 2021 04:42:18 +0000 (UTC)
Received: from localhost (ovpn-12-178.pek2.redhat.com [10.72.12.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 260D860938;
        Tue, 20 Jul 2021 04:42:13 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V2] genirq/affinity: add helper of irq_affinity_calc_sets
Date:   Tue, 20 Jul 2021 12:42:09 +0800
Message-Id: <20210720044209.851141-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
index 4d89ad4fae3b..addd04d68d42 100644
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
+	if (!affd->calc_sets)
+		default_calc_sets(affd, affvecs);
+	else
+		affd->calc_sets(affd, affvecs);
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

