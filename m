Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25F655B4E5
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 08:21:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfGAGVk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jul 2019 02:21:40 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48490 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727681AbfGAGU6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jul 2019 02:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=icobwArBtoR8ReDHxdM0OSV/BylGVPj9OXDCrOjLCSM=; b=lwamREa5NpF4Qy4jd8BtxYQJa
        nM99VD+71jHSg4TsNOy4V5G/VKSIbY7ElfpDGBN9sHF8BUifq4wO1dXZmE6pBZ4vL7wLR7K8dZ/gx
        6SulrBoI6nnYyGZydRsfQjI68/LqnectAYeHOE8Xn2orshZkeo9o8NZPwuHmQlHIEeAeqX00o+USL
        R4PXEYmlglHfipdXdcexTu/a3rT0JHtQiFUQO7u19oa9teCY4agjpix8VB7C1Umr4kK5eQIt5Pxsf
        rXLjXGbbtyfO/TWua4uZNeT4G8Lrq7IN8aXw4oJyDXtZLqX1hx9G3HmFSRTa30Cy96bwJq41j1Hry
        Xbg6lO60A==;
Received: from [46.140.178.35] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhpgM-00033L-98; Mon, 01 Jul 2019 06:20:54 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 14/22] mm/hmm: Remove racy protection against double-unregistration
Date:   Mon,  1 Jul 2019 08:20:12 +0200
Message-Id: <20190701062020.19239-15-hch@lst.de>
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

From: Jason Gunthorpe <jgg@mellanox.com>

No other register/unregister kernel API attempts to provide this kind of
protection as it is inherently racy, so just drop it.

Callers should provide their own protection, and it appears nouveau
already does.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Tested-by: Philip Yang <Philip.Yang@amd.com>
---
 mm/hmm.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 6f5dc6d568fe..2ef14b2b5505 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -276,17 +276,11 @@ EXPORT_SYMBOL(hmm_mirror_register);
  */
 void hmm_mirror_unregister(struct hmm_mirror *mirror)
 {
-	struct hmm *hmm = READ_ONCE(mirror->hmm);
-
-	if (hmm == NULL)
-		return;
+	struct hmm *hmm = mirror->hmm;
 
 	down_write(&hmm->mirrors_sem);
 	list_del_init(&mirror->list);
-	/* To protect us against double unregister ... */
-	mirror->hmm = NULL;
 	up_write(&hmm->mirrors_sem);
-
 	hmm_put(hmm);
 }
 EXPORT_SYMBOL(hmm_mirror_unregister);
-- 
2.20.1

