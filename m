Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649623C9E3C
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jul 2021 14:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbhGOMMA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 08:12:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41759 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232367AbhGOMMA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jul 2021 08:12:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626350946;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pMdTzJHNKVWe9GNkdImtqswTDriEuMcivsx+NF2L4oM=;
        b=gtrCt26qUN9OgMe+7FXfsMBvCQEWw9Ei7NmrhvZTybbXbzyKgftuU2aRJMQ0WH+4JVSqH0
        oJxgGQCP8sc7kqKRHJOOLXEWMsa+NkVlRO6yWEwVz7AY2QF5nHdM/TAQIbJb7RD1FyGPls
        szKpTwubk7iL5aMt06tv2vStarjSUYw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-176-OJhv6rFHMpmzMXH3APQCSQ-1; Thu, 15 Jul 2021 08:09:05 -0400
X-MC-Unique: OJhv6rFHMpmzMXH3APQCSQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF41D1835AC4;
        Thu, 15 Jul 2021 12:09:03 +0000 (UTC)
Received: from localhost (ovpn-12-61.pek2.redhat.com [10.72.12.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 71A2E1002D71;
        Thu, 15 Jul 2021 12:08:58 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 1/3] driver core: mark device as irq affinity managed if any irq is managed
Date:   Thu, 15 Jul 2021 20:08:42 +0800
Message-Id: <20210715120844.636968-2-ming.lei@redhat.com>
In-Reply-To: <20210715120844.636968-1-ming.lei@redhat.com>
References: <20210715120844.636968-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

irq vector allocation with managed affinity may be used by driver, and
blk-mq needs this info because managed irq will be shutdown when all
CPUs in the affinity mask are offline.

The info of using managed irq is often produced by drivers(pci subsystem,
platform device, ...), and it is consumed by blk-mq, so different subsystems
are involved in this info flow

Address this issue by adding one field of .irq_affinity_managed into
'struct device'.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/base/platform.c | 7 +++++++
 drivers/pci/msi.c       | 3 +++
 include/linux/device.h  | 1 +
 3 files changed, 11 insertions(+)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 8640578f45e9..d28cb91d5cf9 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -388,6 +388,13 @@ int devm_platform_get_irqs_affinity(struct platform_device *dev,
 				ptr->irq[i], ret);
 			goto err_free_desc;
 		}
+
+		/*
+		 * mark the device as irq affinity managed if any irq affinity
+		 * descriptor is managed
+		 */
+		if (desc[i].is_managed)
+			dev->dev.irq_affinity_managed = true;
 	}
 
 	devres_add(&dev->dev, ptr);
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 3d6db20d1b2b..7ddec90b711d 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1197,6 +1197,7 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 	if (flags & PCI_IRQ_AFFINITY) {
 		if (!affd)
 			affd = &msi_default_affd;
+		dev->dev.irq_affinity_managed = true;
 	} else {
 		if (WARN_ON(affd))
 			affd = NULL;
@@ -1215,6 +1216,8 @@ int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 			return nvecs;
 	}
 
+	dev->dev.irq_affinity_managed = false;
+
 	/* use legacy IRQ if allowed */
 	if (flags & PCI_IRQ_LEGACY) {
 		if (min_vecs == 1 && dev->irq) {
diff --git a/include/linux/device.h b/include/linux/device.h
index 59940f1744c1..9ec6e671279e 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -569,6 +569,7 @@ struct device {
 #ifdef CONFIG_DMA_OPS_BYPASS
 	bool			dma_ops_bypass : 1;
 #endif
+	bool			irq_affinity_managed : 1;
 };
 
 /**
-- 
2.31.1

