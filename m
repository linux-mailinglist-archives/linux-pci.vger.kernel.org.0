Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 970FE43DE9
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 17:46:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732427AbfFMPpb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 11:45:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33318 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731803AbfFMJnr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jun 2019 05:43:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FEkGt+ty/uGWp0o9n/p7YTGA7bk3QKQR9GKnB3yrWi0=; b=L3WbZ0JSiDvBXJFsDUCJ02wcbX
        BVJRpc0UiDSz8hdf9PGCQmrkNO9cC3Ct9Euv83j64Pvqa+bMG7zPftv6Qc47ddagd0apxJ3S9LtxK
        YL0Gd6JRejUQjbVJguc5cGI104IqQQmLmGxj/QrnU1/8eCRFXHiVtvxgGKwlwToPy+mfQe5RgeuNc
        7YyFcHDGYRl8yFp9cwxZhKia1V56GYhuyZqZJ3NB32yZYe7DQM/hr05KkwXqr/uf34lWIk5VMshTf
        CpMaS4eanmRpQSDsR1G7yDdfQpx78Otwq1ePYvSywGpRHwk4jd2yXAVh0H6em6K2SgA7+4HrNyFnG
        Se1/PImw==;
Received: from mpp-cp1-natpool-1-198.ethz.ch ([82.130.71.198] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbMGl-0001l6-GH; Thu, 13 Jun 2019 09:43:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/22] mm: export alloc_pages_vma
Date:   Thu, 13 Jun 2019 11:43:08 +0200
Message-Id: <20190613094326.24093-6-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190613094326.24093-1-hch@lst.de>
References: <20190613094326.24093-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

noveau is currently using this through an odd hmm wrapper, and I plan
to switch it to the real thing later in this series.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/mempolicy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 01600d80ae01..f9023b5fba37 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2098,6 +2098,7 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 out:
 	return page;
 }
+EXPORT_SYMBOL_GPL(alloc_pages_vma);
 
 /**
  * 	alloc_pages_current - Allocate pages.
-- 
2.20.1

