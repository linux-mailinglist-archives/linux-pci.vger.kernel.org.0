Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE4E85B4C6
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 08:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbfGAGVD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jul 2019 02:21:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48522 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727701AbfGAGVB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Jul 2019 02:21:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
        To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=K+5Y7Ez4pfTMCmPiyIGRChGh4O04+aapHsZzDHBkVJo=; b=PSbfEnpLRE8SG9bLML+fRlhf0
        HtVXUwpI1yGra8E8q+rwV6qJm4ONJSDzOZ753xm3ERQHmxUjdhHbZaiUebewXGu/ryXEdIqi7spGD
        Nlr6XlnU/i9TC0WMqh3qrx9cT7ITHZkOAeu54JXvWWQ2MaeC+xjlwX/7+GOXnST0/kVvSEpc1HmW/
        hO3augHviB0cDdLARWF6uP/j90BGjEpU45QJHn+ssAOFsyOrVWV8bsQFxpmwUu7D3kHoTQPtfD/+9
        h1Gpz4y5W71lm5fa5MIvKeZct6x0kCAYyPKLWFw3cLp1onhIVhjCvfTwvaeENThWQJ0FWVoyh0659
        oBUZxg5rA==;
Received: from [46.140.178.35] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hhpgO-00034k-I0; Mon, 01 Jul 2019 06:20:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-nvdimm@lists.01.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, John Hubbard <jhubbard@nvidia.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        Philip Yang <Philip.Yang@amd.com>
Subject: [PATCH 15/22] mm/hmm: Poison hmm_range during unregister
Date:   Mon,  1 Jul 2019 08:20:13 +0200
Message-Id: <20190701062020.19239-16-hch@lst.de>
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

Trying to misuse a range outside its lifetime is a kernel bug. Use poison
bytes to help detect this condition. Double unregister will reliably crash.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Jérôme Glisse <jglisse@redhat.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Acked-by: Souptick Joarder <jrdr.linux@gmail.com>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Tested-by: Philip Yang <Philip.Yang@amd.com>
---
 mm/hmm.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 2ef14b2b5505..c30aa9403dbe 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -925,19 +925,21 @@ void hmm_range_unregister(struct hmm_range *range)
 {
 	struct hmm *hmm = range->hmm;
 
-	/* Sanity check this really should not happen. */
-	if (hmm == NULL || range->end <= range->start)
-		return;
-
 	mutex_lock(&hmm->lock);
 	list_del_init(&range->list);
 	mutex_unlock(&hmm->lock);
 
 	/* Drop reference taken by hmm_range_register() */
-	range->valid = false;
 	mmput(hmm->mm);
 	hmm_put(hmm);
-	range->hmm = NULL;
+
+	/*
+	 * The range is now invalid and the ref on the hmm is dropped, so
+	 * poison the pointer.  Leave other fields in place, for the caller's
+	 * use.
+	 */
+	range->valid = false;
+	memset(&range->hmm, POISON_INUSE, sizeof(range->hmm));
 }
 EXPORT_SYMBOL(hmm_range_unregister);
 
-- 
2.20.1

