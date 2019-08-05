Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9EA80FF8
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2019 03:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfHEBTR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 4 Aug 2019 21:19:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33380 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726709AbfHEBTR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 4 Aug 2019 21:19:17 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 822A5B2DC5;
        Mon,  5 Aug 2019 01:19:16 +0000 (UTC)
Received: from localhost (ovpn-8-20.pek2.redhat.com [10.72.8.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 59F81608A5;
        Mon,  5 Aug 2019 01:19:13 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>
Subject: [PATCH] genirq/affinity: create affinity mask for single vector
Date:   Mon,  5 Aug 2019 09:19:06 +0800
Message-Id: <20190805011906.5020-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Mon, 05 Aug 2019 01:19:16 +0000 (UTC)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since commit c66d4bd110a1f8 ("genirq/affinity: Add new callback for
(re)calculating interrupt sets"), irq_create_affinity_masks() returns
NULL in case of single vector. This change has caused regression on some
drivers, such as lpfc.

The problem is that single vector may be triggered in some generic cases:
1) kdump kernel 2) irq vectors resource is close to exhaustion.

If we don't create affinity mask for single vector, almost every caller
has to handle the special case.

So still create affinity mask for single vector, since irq_create_affinity_masks()
is capable of handling that.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Cc: linux-pci@vger.kernel.org
Cc: Keith Busch <keith.busch@intel.com>
Cc: Sumit Saxena <sumit.saxena@broadcom.com>
Cc: Kashyap Desai <kashyap.desai@broadcom.com>
Cc: Shivasharan Srikanteshwara <shivasharan.srikanteshwara@broadcom.com>
Fixes: c66d4bd110a1f8 ("genirq/affinity: Add new callback for (re)calculating interrupt sets")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/irq/affinity.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 4352b08ae48d..6fef48033f96 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -251,11 +251,9 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 	 * Determine the number of vectors which need interrupt affinities
 	 * assigned. If the pre/post request exhausts the available vectors
 	 * then nothing to do here except for invoking the calc_sets()
-	 * callback so the device driver can adjust to the situation. If there
-	 * is only a single vector, then managing the queue is pointless as
-	 * well.
+	 * callback so the device driver can adjust to the situation.
 	 */
-	if (nvecs > 1 && nvecs > affd->pre_vectors + affd->post_vectors)
+	if (nvecs > affd->pre_vectors + affd->post_vectors)
 		affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
 	else
 		affvecs = 0;
-- 
2.20.1

