Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A34F25692B
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2019 14:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727498AbfFZM1u (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jun 2019 08:27:50 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42706 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbfFZM1u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jun 2019 08:27:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=0wBvIBHex+/cCiI1pboKPdW0nxKbhC7t4v1/DWHTWzI=; b=c6rggi27+6bcNfZZv1zIRlyPCG
        dTeW2W12t37x3woY9zWdBtIsP4n1E9dw47beifpdnx/fz2SnFKoQs6M0ObFbnzav7MGUD/YXjCZ/Y
        /nrVNGsZF9j5DfrhyO6TTdGG/hzYaJp6AQ98WUFsFTaB6Ol4fyNoNVg8mhvpvqgaxZEjbFL/UASiZ
        /3sLgB2UV5SSt6KHctKLOsDSch/tnc7UKteZTeFrWqxh0JqkYe6iQjKxxaOZL1CYQ9QXxFMmVhNNO
        27wXVoCLF43f+0c2qpIsvN2eFaGW98w89wJCDa2RWtuWV5oIL49PGwubBepu8AuvptmiewrxjXd5v
        6kqTr2hA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hg71Z-0001Lv-4k; Wed, 26 Jun 2019 12:27:41 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 05/25] mm: don't clear ->mapping in hmm_devmem_free
Date:   Wed, 26 Jun 2019 14:27:04 +0200
Message-Id: <20190626122724.13313-6-hch@lst.de>
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

->mapping isn't even used by HMM users, and the field at the same offset
in the zone_device part of the union is declared as pad.  (Which btw is
rather confusing, as DAX uses ->pgmap and ->mapping from two different
sides of the union, but DAX doesn't use hmm_devmem_free).

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/hmm.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 376159a769fb..e7dd2ab8f9ab 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -1383,8 +1383,6 @@ static void hmm_devmem_free(struct page *page, void *data)
 {
 	struct hmm_devmem *devmem = data;
 
-	page->mapping = NULL;
-
 	devmem->ops->free(devmem, page);
 }
 
-- 
2.20.1

