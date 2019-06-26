Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25D9F5691D
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2019 14:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727668AbfFZM2U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jun 2019 08:28:20 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43014 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727660AbfFZM2T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jun 2019 08:28:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=wJ4xmBbrpfmUG188a6jPO21+BmohIhmVPW5AXcG365o=; b=qt1wzdpeXOioJoeLjcBGzBBVU/
        Sr6D01p4bOPlfFv7A/XbcaGQsl1IH01GeMcCCke5SJh7+fpyw5+rIKzgn9byxwe1kgVAu1j/h7ROQ
        4lvA5eeeukgmWSeBeKgEDuEBjjwRhGPDC9AIWQm+7dOYdaQhTinbVKVEskkE0Io3IDHriXiis+aB9
        8mEJ/G0aXx04YeP8uuuRQuTeOrRGeFyVQ4Rx8U+Noyv62xRv450IEmFtFO+E+MvzvI1V277cC6Z8i
        R9Dvb48L9i++e+EKM3J8sWleQK00iEHpItPQXvfVhC/OdM0WIglOrdTN/KRiePoYY842rwdj3ZwLW
        WRt9i5hw==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hg726-0001ZQ-Su; Wed, 26 Jun 2019 12:28:15 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 18/25] nouveau: use alloc_page_vma directly
Date:   Wed, 26 Jun 2019 14:27:17 +0200
Message-Id: <20190626122724.13313-19-hch@lst.de>
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

hmm_vma_alloc_locked_page is scheduled to go away, use the proper
mm function directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouveau/nouveau_dmem.c
index 40c47d6a7d78..a50f6fd2fe24 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -148,11 +148,12 @@ nouveau_dmem_fault_alloc_and_copy(struct vm_area_struct *vma,
 		if (!spage || !(src_pfns[i] & MIGRATE_PFN_MIGRATE))
 			continue;
 
-		dpage = hmm_vma_alloc_locked_page(vma, addr);
+		dpage = alloc_page_vma(GFP_HIGHUSER, vma, addr);
 		if (!dpage) {
 			dst_pfns[i] = MIGRATE_PFN_ERROR;
 			continue;
 		}
+		lock_page(dpage);
 
 		dst_pfns[i] = migrate_pfn(page_to_pfn(dpage)) |
 			      MIGRATE_PFN_LOCKED;
-- 
2.20.1

