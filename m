Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C8EE15B4DA
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 08:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbfGAGVQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jul 2019 02:21:16 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48682 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727778AbfGAGVP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jul 2019 02:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=8byVWDDjomwL6qH7S0OtanLtekPodjhPaEDKqBoEUGs=; b=gymyO8jYdkpQB45FPyoqo5QVRO
        pxdxLE/pukS1Gk+9MEFhUMYN00wWfJtK9mHMqd13ChvWkK6i3fJFh5i3DGPvBqQ37V8+yF0igt9nN
        Y9V4N/egahV3v/1fcDcj6gtqMt3/1tKmCmBZNUOPuZDmSMXGT7uyE2F/3McRlbRBhxwK2jh6sWGos
        ctgD/8HuEKjDbXkk6fDiLK/fGApomgUO2pe9gIo2ZW5OLFiUrBVFWmZ11yFMq+imU7W5vNvpz+ObV
        JvmhVL1Q0WzgqBRzkrgih94Su6CSqN/FTPUhjuxgRAK49QrB82cKbelNL+xMhaE0alH06JPe6B65V
        JIyEF0zw==;
Received: from [46.140.178.35] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhpgd-0003Y2-QA; Mon, 01 Jul 2019 06:21:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 22/22] mm: remove the legacy hmm_pfn_* APIs
Date:   Mon,  1 Jul 2019 08:20:20 +0200
Message-Id: <20190701062020.19239-23-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701062020.19239-1-hch@lst.de>
References: <20190701062020.19239-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Switch the one remaining user in nouveau over to its replacement,
and remove all the wrappers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c |  2 +-
 include/linux/hmm.h                    | 36 --------------------------
 2 files changed, 1 insertion(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 40c47d6a7d78..534069ffe20a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -853,7 +853,7 @@ nouveau_dmem_convert_pfn(struct nouveau_drm *drm,
 		struct page *page;
 		uint64_t addr;
 
-		page = hmm_pfn_to_page(range, range->pfns[i]);
+		page = hmm_device_entry_to_page(range, range->pfns[i]);
 		if (page == NULL)
 			continue;
 
diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 3457cf9182e5..9799fde71f2e 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -290,42 +290,6 @@ static inline uint64_t hmm_device_entry_from_pfn(const struct hmm_range *range,
 		range->flags[HMM_PFN_VALID];
 }
 
-/*
- * Old API:
- * hmm_pfn_to_page()
- * hmm_pfn_to_pfn()
- * hmm_pfn_from_page()
- * hmm_pfn_from_pfn()
- *
- * This are the OLD API please use new API, it is here to avoid cross-tree
- * merge painfullness ie we convert things to new API in stages.
- */
-static inline struct page *hmm_pfn_to_page(const struct hmm_range *range,
-					   uint64_t pfn)
-{
-	return hmm_device_entry_to_page(range, pfn);
-}
-
-static inline unsigned long hmm_pfn_to_pfn(const struct hmm_range *range,
-					   uint64_t pfn)
-{
-	return hmm_device_entry_to_pfn(range, pfn);
-}
-
-static inline uint64_t hmm_pfn_from_page(const struct hmm_range *range,
-					 struct page *page)
-{
-	return hmm_device_entry_from_page(range, page);
-}
-
-static inline uint64_t hmm_pfn_from_pfn(const struct hmm_range *range,
-					unsigned long pfn)
-{
-	return hmm_device_entry_from_pfn(range, pfn);
-}
-
-
-
 #if IS_ENABLED(CONFIG_HMM_MIRROR)
 /*
  * Mirroring: how to synchronize device page table with CPU page table.
-- 
2.20.1

