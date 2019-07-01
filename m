Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDD505B4A1
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 08:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfGAGUi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jul 2019 02:20:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48210 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727516AbfGAGUh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jul 2019 02:20:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=aDDV0kJ/bs5He1sJYNTcx8QRyDKaqv7PRbW2xYMan0w=; b=SRjdRB90aDp9ri+nwpQyyHN9q
        qGQh2uFv5+oBVnpCH4SJ+S82Wpl/5WlkHeVnbWe5AlpG9jmwibSgKOUPVlmKBymW6MzbzMs+Z5o5x
        Ggnd73UXr0J0EaH1JLkQ+tGELOwpt6iVaxq/8Lv9lorXyp9nYihVahCxuZEkCLErZAFZV/QTwiXbj
        oiqBjQ3hmd4hDDsYPsDc5xc2RtHEVg21y2T/8EgBWohFixCBg5aFXa4NXJZnpcyUlA/vxFRjuIkQg
        kNIQKzf0Emx+NwpXszIeVaqahmKQdjRNxfXxrmrM0Gmy6pasBag0nyerbXo0boyU6/Q3xNOwrjEQY
        5fLWM2pmQ==;
Received: from [46.140.178.35] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhpg1-0002tx-JM; Mon, 01 Jul 2019 06:20:33 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: [PATCH 05/22] mm/hmm: Only set FAULT_FLAG_ALLOW_RETRY for non-blocking
Date:   Mon,  1 Jul 2019 08:20:03 +0200
Message-Id: <20190701062020.19239-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190701062020.19239-1-hch@lst.de>
References: <20190701062020.19239-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: "Kuehling, Felix" <Felix.Kuehling@amd.com>

Don't set this flag by default in hmm_vma_do_fault. It is set
conditionally just a few lines below. Setting it unconditionally can lead
to handle_mm_fault doing a non-blocking fault, returning -EBUSY and
unlocking mmap_sem unexpectedly.

Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/hmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index dce4e70e648a..826816ab2377 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -328,7 +328,7 @@ struct hmm_vma_walk {
 static int hmm_vma_do_fault(struct mm_walk *walk, unsigned long addr,
 			    bool write_fault, uint64_t *pfn)
 {
-	unsigned int flags = FAULT_FLAG_ALLOW_RETRY | FAULT_FLAG_REMOTE;
+	unsigned int flags = FAULT_FLAG_REMOTE;
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
 	struct vm_area_struct *vma = walk->vma;
-- 
2.20.1

