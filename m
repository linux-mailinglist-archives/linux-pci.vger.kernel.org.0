Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75C525B49E
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 08:20:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727504AbfGAGUg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jul 2019 02:20:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48188 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfGAGUg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jul 2019 02:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ha0G2SIX3qJwQBHCJ94hXS+l70ON3HkLuGbICbqpRXk=; b=McY+jahORBX9m/je/bQ6Q38b0
        28WcXEPXZE6Hcjq+4+sHpTWSUUYsygvbEwNrGXLJDRekMZBBLHs2JA6d74Md5I104lXzbV968Av2Z
        J3DQ3Q8m0Co759Cpf29dQlJNwis3r3MTh0SnOtF3FTLzlzDD1UtJcPF1MrRi/lcAYx9uEtoYU6DI1
        zW2v8jIkosACsyQpdiePRz4xMw1/0Q20ytuHFjDVBFY4moXLnh+l4DZt9Ylgq8UV1BYJzXJjsmDli
        YQZuhtMWHmwqMewYBuiuiE9Re+8KsGcSZTxhoYiwxkwOqQWnvw8dyNpA8uGeK74XtpU4V04Cfy3z7
        hn4lvcOUg==;
Received: from [46.140.178.35] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhpfz-0002ta-A6; Mon, 01 Jul 2019 06:20:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Philip Yang <Philip.Yang@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>
Subject: [PATCH 04/22] mm/hmm: support automatic NUMA balancing
Date:   Mon,  1 Jul 2019 08:20:02 +0200
Message-Id: <20190701062020.19239-5-hch@lst.de>
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

From: Philip Yang <Philip.Yang@amd.com>

While the page is migrating by NUMA balancing, HMM failed to detect this
condition and still return the old page. Application will use the new page
migrated, but driver pass the old page physical address to GPU, this crash
the application later.

Use pte_protnone(pte) to return this condition and then hmm_vma_do_fault
will allocate new page.

Signed-off-by: Philip Yang <Philip.Yang@amd.com>
Signed-off-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 mm/hmm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 4db5dcf110ba..dce4e70e648a 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -548,7 +548,7 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk,
 
 static inline uint64_t pte_to_hmm_pfn_flags(struct hmm_range *range, pte_t pte)
 {
-	if (pte_none(pte) || !pte_present(pte))
+	if (pte_none(pte) || !pte_present(pte) || pte_protnone(pte))
 		return 0;
 	return pte_write(pte) ? range->flags[HMM_PFN_VALID] |
 				range->flags[HMM_PFN_WRITE] :
-- 
2.20.1

