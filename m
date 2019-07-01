Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F9FA5692A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2019 14:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727472AbfFZM1t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jun 2019 08:27:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42682 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfFZM1s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jun 2019 08:27:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=BPkZHHIHMHfLZtQnho6ADB3HOg0fG+ODbmu+2ZG5xyw=; b=jk74jAEbOrotcGBG5yTuu12mN9
        C7kyksJxP1KCYqUPKHazaYWg5kM7S7/Y93S1Dfun5FvBnkOn75aymSxIlC+REhc60+4tcuXRgTbBS
        H5faXnHQq7hSL832z10DovznO408+wuzv7SZabppvcvXXiPJG5+EAKioh0Sqov/x3VderuyLZ/f3J
        vJBmHaWcyJS9+qeWoVMZdkaOKi1XqR2KxkM7w9FwTgKp7Pu5xlHdH30hk8T+St23PY28xR1/Pkz4r
        au6n9mzTWdfrklWEZECBO0+bqRU2RIMg379zl8o++5ajUzWzEVtuOnrvMCrwHG3Us4QU4vqDgbMkG
        UbjgkTBg==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hg71b-0001M0-MI; Wed, 26 Jun 2019 12:27:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH 06/25] mm: export alloc_pages_vma
Date:   Wed, 26 Jun 2019 14:27:05 +0200
Message-Id: <20190626122724.13313-7-hch@lst.de>
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

nouveau is currently using this through an odd hmm wrapper, and I plan
to switch it to the real thing later in this series.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
---
 mm/mempolicy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 01600d80ae01..f48569aa1863 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2098,6 +2098,7 @@ alloc_pages_vma(gfp_t gfp, int order, struct vm_area_struct *vma,
 out:
 	return page;
 }
+EXPORT_SYMBOL(alloc_pages_vma);
 
 /**
  * 	alloc_pages_current - Allocate pages.
-- 
2.20.1

