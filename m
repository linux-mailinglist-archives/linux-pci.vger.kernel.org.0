Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 314FF48206
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 14:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbfFQM1q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 08:27:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42418 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFQM1q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 17 Jun 2019 08:27:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=GMyD4ZeUwEyX4TLbYH+teiOZCsmaS5so5bsDBHXs5VU=; b=nUM3O0j+v0YkuO+grtlLfHPwaH
        cV0WhQAmaitlmE6ROwsIKJCV/PlKqUn+0O2EWB1Hs1nEpKWW8txqk2fddXoiLre+dVvw9bHopOPj/
        gxJDRUoHl+//i7XrIMZT3FKhCTu/PdfOYJCLGgo7rTAcjPqy99/URAGv7WeM7qn8F0aLO8QPfe2cq
        07WYX982utWhvOtWHTzi5gbbLN1LvS1/WFqavQ6hw3qVrjla8/wu9w23XyHgB/5OiA5nsWfl2v27L
        xDnS8fKvcYcw4DwESFtDIxH0HLpADpbP4XBoQFGVGvrc38bZlNIwtghm8E94lATBAXFDfzbvWHgJL
        wMPWcrTA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hcqjd-0008Kg-IT; Mon, 17 Jun 2019 12:27:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 02/25] mm: remove the struct hmm_device infrastructure
Date:   Mon, 17 Jun 2019 14:27:10 +0200
Message-Id: <20190617122733.22432-3-hch@lst.de>
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

This code is a trivial wrapper around device model helpers, which
should have been integrated into the driver device model usage from
the start.  Assuming it actually had users, which it never had since
the code was added more than 1 1/2 years ago.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 include/linux/hmm.h | 20 ------------
 mm/hmm.c            | 80 ---------------------------------------------
 2 files changed, 100 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 7007123842ba..c92f353d701a 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -753,26 +753,6 @@ static inline unsigned long hmm_devmem_page_get_drvdata(const struct page *page)
 {
 	return page->hmm_data;
 }
-
-
-/*
- * struct hmm_device - fake device to hang device memory onto
- *
- * @device: device struct
- * @minor: device minor number
- */
-struct hmm_device {
-	struct device		device;
-	unsigned int		minor;
-};
-
-/*
- * A device driver that wants to handle multiple devices memory through a
- * single fake device can use hmm_device to do so. This is purely a helper and
- * it is not strictly needed, in order to make use of any HMM functionality.
- */
-struct hmm_device *hmm_device_new(void *drvdata);
-void hmm_device_put(struct hmm_device *hmm_device);
 #endif /* CONFIG_DEVICE_PRIVATE || CONFIG_DEVICE_PUBLIC */
 #else /* IS_ENABLED(CONFIG_HMM) */
 static inline void hmm_mm_destroy(struct mm_struct *mm) {}
diff --git a/mm/hmm.c b/mm/hmm.c
index 4c770a734c0d..f3350fc567ab 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -1525,84 +1525,4 @@ struct hmm_devmem *hmm_devmem_add_resource(const struct hmm_devmem_ops *ops,
 	return devmem;
 }
 EXPORT_SYMBOL_GPL(hmm_devmem_add_resource);
-
-/*
- * A device driver that wants to handle multiple devices memory through a
- * single fake device can use hmm_device to do so. This is purely a helper
- * and it is not needed to make use of any HMM functionality.
- */
-#define HMM_DEVICE_MAX 256
-
-static DECLARE_BITMAP(hmm_device_mask, HMM_DEVICE_MAX);
-static DEFINE_SPINLOCK(hmm_device_lock);
-static struct class *hmm_device_class;
-static dev_t hmm_device_devt;
-
-static void hmm_device_release(struct device *device)
-{
-	struct hmm_device *hmm_device;
-
-	hmm_device = container_of(device, struct hmm_device, device);
-	spin_lock(&hmm_device_lock);
-	clear_bit(hmm_device->minor, hmm_device_mask);
-	spin_unlock(&hmm_device_lock);
-
-	kfree(hmm_device);
-}
-
-struct hmm_device *hmm_device_new(void *drvdata)
-{
-	struct hmm_device *hmm_device;
-
-	hmm_device = kzalloc(sizeof(*hmm_device), GFP_KERNEL);
-	if (!hmm_device)
-		return ERR_PTR(-ENOMEM);
-
-	spin_lock(&hmm_device_lock);
-	hmm_device->minor = find_first_zero_bit(hmm_device_mask, HMM_DEVICE_MAX);
-	if (hmm_device->minor >= HMM_DEVICE_MAX) {
-		spin_unlock(&hmm_device_lock);
-		kfree(hmm_device);
-		return ERR_PTR(-EBUSY);
-	}
-	set_bit(hmm_device->minor, hmm_device_mask);
-	spin_unlock(&hmm_device_lock);
-
-	dev_set_name(&hmm_device->device, "hmm_device%d", hmm_device->minor);
-	hmm_device->device.devt = MKDEV(MAJOR(hmm_device_devt),
-					hmm_device->minor);
-	hmm_device->device.release = hmm_device_release;
-	dev_set_drvdata(&hmm_device->device, drvdata);
-	hmm_device->device.class = hmm_device_class;
-	device_initialize(&hmm_device->device);
-
-	return hmm_device;
-}
-EXPORT_SYMBOL(hmm_device_new);
-
-void hmm_device_put(struct hmm_device *hmm_device)
-{
-	put_device(&hmm_device->device);
-}
-EXPORT_SYMBOL(hmm_device_put);
-
-static int __init hmm_init(void)
-{
-	int ret;
-
-	ret = alloc_chrdev_region(&hmm_device_devt, 0,
-				  HMM_DEVICE_MAX,
-				  "hmm_device");
-	if (ret)
-		return ret;
-
-	hmm_device_class = class_create(THIS_MODULE, "hmm_device");
-	if (IS_ERR(hmm_device_class)) {
-		unregister_chrdev_region(hmm_device_devt, HMM_DEVICE_MAX);
-		return PTR_ERR(hmm_device_class);
-	}
-	return 0;
-}
-
-device_initcall(hmm_init);
 #endif /* CONFIG_DEVICE_PRIVATE || CONFIG_DEVICE_PUBLIC */
-- 
2.20.1

