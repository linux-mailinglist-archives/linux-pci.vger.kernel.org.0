Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B82848250
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 14:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728015AbfFQM2O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 08:28:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42736 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728007AbfFQM2O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 08:28:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=WoytrCxG5kt017Mi4r+qftdCcpzSPco9CT8jAnxV7AA=; b=cfjnQSuk0OePqkBqt1Zoo6BJSv
        YWzVaKyyvXJvGwKvelhIJkGt4h1MS45yu0wtaVOrOQWYQW9eQdRpwlluWo02xjodmYnwZgSZZt8+1
        jzywQKVxgLg1An5u3r79qC0eTU+LiFdbrO0B+smIqOb9mh1Yv64a7TiGQAYJn6+yuTiEu6beGOzX4
        PblogVq3IxXTL4MGO1JlQa7eryDUGRdrwy+ePIEKe0/njOwiXsi5TDAP2I6bETcHeOvI5IfFmsXAV
        It0kb/wuRPja6yBoYSJjboYG1k7cI0Koq9jvoZvICMYV+7UkSgs7yAO310r+FQswO/ZeVYTphiBrn
        eZrWu20w==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hcqk6-0000Fs-Fr; Mon, 17 Jun 2019 12:28:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 15/25] device-dax: use the dev_pagemap internal refcount
Date:   Mon, 17 Jun 2019 14:27:23 +0200
Message-Id: <20190617122733.22432-16-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190617122733.22432-1-hch@lst.de>
References: <20190617122733.22432-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The functionality is identical to the one currently open coded in
device-dax.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/dax/dax-private.h |  4 ----
 drivers/dax/device.c      | 43 ---------------------------------------
 2 files changed, 47 deletions(-)

diff --git a/drivers/dax/dax-private.h b/drivers/dax/dax-private.h
index a45612148ca0..ed04a18a35be 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -51,8 +51,6 @@ struct dax_region {
  * @target_node: effective numa node if dev_dax memory range is onlined
  * @dev - device core
  * @pgmap - pgmap for memmap setup / lifetime (driver owned)
- * @ref: pgmap reference count (driver owned)
- * @cmp: @ref final put completion (driver owned)
  */
 struct dev_dax {
 	struct dax_region *region;
@@ -60,8 +58,6 @@ struct dev_dax {
 	int target_node;
 	struct device dev;
 	struct dev_pagemap pgmap;
-	struct percpu_ref ref;
-	struct completion cmp;
 };
 
 static inline struct dev_dax *to_dev_dax(struct device *dev)
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 17b46c1a76b4..a9d7c90ecf1e 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -14,36 +14,6 @@
 #include "dax-private.h"
 #include "bus.h"
 
-static struct dev_dax *ref_to_dev_dax(struct percpu_ref *ref)
-{
-	return container_of(ref, struct dev_dax, ref);
-}
-
-static void dev_dax_percpu_release(struct percpu_ref *ref)
-{
-	struct dev_dax *dev_dax = ref_to_dev_dax(ref);
-
-	dev_dbg(&dev_dax->dev, "%s\n", __func__);
-	complete(&dev_dax->cmp);
-}
-
-static void dev_dax_percpu_exit(struct dev_pagemap *pgmap)
-{
-	struct dev_dax *dev_dax = container_of(pgmap, struct dev_dax, pgmap);
-
-	dev_dbg(&dev_dax->dev, "%s\n", __func__);
-	wait_for_completion(&dev_dax->cmp);
-	percpu_ref_exit(pgmap->ref);
-}
-
-static void dev_dax_percpu_kill(struct dev_pagemap *pgmap)
-{
-	struct dev_dax *dev_dax = container_of(pgmap, struct dev_dax, pgmap);
-
-	dev_dbg(&dev_dax->dev, "%s\n", __func__);
-	percpu_ref_kill(pgmap->ref);
-}
-
 static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 		const char *func)
 {
@@ -441,11 +411,6 @@ static void dev_dax_kill(void *dev_dax)
 	kill_dev_dax(dev_dax);
 }
 
-static const struct dev_pagemap_ops dev_dax_pagemap_ops = {
-	.kill		= dev_dax_percpu_kill,
-	.cleanup	= dev_dax_percpu_exit,
-};
-
 int dev_dax_probe(struct device *dev)
 {
 	struct dev_dax *dev_dax = to_dev_dax(dev);
@@ -463,14 +428,6 @@ int dev_dax_probe(struct device *dev)
 		return -EBUSY;
 	}
 
-	init_completion(&dev_dax->cmp);
-	rc = percpu_ref_init(&dev_dax->ref, dev_dax_percpu_release, 0,
-			GFP_KERNEL);
-	if (rc)
-		return rc;
-
-	dev_dax->pgmap.ref = &dev_dax->ref;
-	dev_dax->pgmap.ops = &dev_dax_pagemap_ops;
 	addr = devm_memremap_pages(dev, &dev_dax->pgmap);
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);
-- 
2.20.1

