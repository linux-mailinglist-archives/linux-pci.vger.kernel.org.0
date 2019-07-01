Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57834568F6
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2019 14:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfFZM2Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jun 2019 08:28:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42958 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727634AbfFZM2N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jun 2019 08:28:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=YDLkJcbbU4N/zfzWVPo9ZgCQKX5AsR9fCDGQSDpCCD0=; b=eqf0zYAqZkZeG8aDStJr1BpZ1P
        ESvtZ/x6goy5uCLOi8uh5odrF/jDvEPUaqDs779fgL8qsCyiCG2Ery24ccFf7Y0roHYb5/v+BzjZd
        xvJYhdsaPbrOrKlFB9NzVbHgKqVz953pfvNGqyyv5cMEWoHLfF9YDaBYwCVVotAmsfAouontNfJIt
        pC/KsdDr1ehz4StOtp3FSfKb+O6soSwumbQYEJcyvsfr9PEr8MVPAAeAHs4HYu/6nrrbmT2tdJj4K
        nauKDKfBWnolN5vCPrT8Befr6TTsUp5glW5APuxKXXVhJiU6XtHj2xrRMVBIAKAAazFHBbPh/Dc4n
        j7M/oClg==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hg721-0001X8-Jr; Wed, 26 Jun 2019 12:28:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 16/25] device-dax: use the dev_pagemap internal refcount
Date:   Wed, 26 Jun 2019 14:27:15 +0200
Message-Id: <20190626122724.13313-17-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190626122724.13313-1-hch@lst.de>
References: <20190626122724.13313-1-hch@lst.de>
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
index b4177aafbbd1..c915889d1769 100644
--- a/drivers/dax/dax-private.h
+++ b/drivers/dax/dax-private.h
@@ -43,8 +43,6 @@ struct dax_region {
  * @target_node: effective numa node if dev_dax memory range is onlined
  * @dev - device core
  * @pgmap - pgmap for memmap setup / lifetime (driver owned)
- * @ref: pgmap reference count (driver owned)
- * @cmp: @ref final put completion (driver owned)
  */
 struct dev_dax {
 	struct dax_region *region;
@@ -52,8 +50,6 @@ struct dev_dax {
 	int target_node;
 	struct device dev;
 	struct dev_pagemap pgmap;
-	struct percpu_ref ref;
-	struct completion cmp;
 };
 
 static inline struct dev_dax *to_dev_dax(struct device *dev)
diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index b5257038c188..1af823b2fe6b 100644
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
@@ -463,15 +428,7 @@ int dev_dax_probe(struct device *dev)
 		return -EBUSY;
 	}
 
-	init_completion(&dev_dax->cmp);
-	rc = percpu_ref_init(&dev_dax->ref, dev_dax_percpu_release, 0,
-			GFP_KERNEL);
-	if (rc)
-		return rc;
-
-	dev_dax->pgmap.ref = &dev_dax->ref;
 	dev_dax->pgmap.type = MEMORY_DEVICE_DEVDAX;
-	dev_dax->pgmap.ops = &dev_dax_pagemap_ops;
 	addr = devm_memremap_pages(dev, &dev_dax->pgmap);
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);
-- 
2.20.1

