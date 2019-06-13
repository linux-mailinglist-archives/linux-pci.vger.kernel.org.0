Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1222A43DCE
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 17:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389153AbfFMPpb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 11:45:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33252 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731796AbfFMJni (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jun 2019 05:43:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=kaMWV25JLh2oaHk6KDUPHO1aktYAmWaT94i0RYQYzUw=; b=SIOUKYPAoDNdv7dWJhGfW0ob9k
        SLpR4leODIPqaX5ZslP+W4SJcJ9U7DECzPF7id4CLr1TIXVk0TrdeRnB2mSBfkwHV0BwXM9hz+pAg
        MRIkDGTi/GEKbHR7IahvnzYVCFrGOql4J+HQbbAxBYnBDBvqLJf14fWFUzQPYx6sWG+RncvSxlFHs
        UVuWutw1NZcBceRsSHnUv96ep8AN6pJSCjApiFhahvIwVDcAXbo2avAu2oiRkulO4cM29bofUBPE/
        aJ6WgM8we7zOD5oK498LUnb7YTFkOzfiKswyBFy1ZCZiC3yGAwDX1/fPAToXlZJ0IO1qvMnAWyaKu
        nuFh1UuA==;
Received: from mpp-cp1-natpool-1-198.ethz.ch ([82.130.71.198] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbMGa-0001jn-7o; Thu, 13 Jun 2019 09:43:32 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/22] mm: remove the unused ARCH_HAS_HMM_DEVICE Kconfig option
Date:   Thu, 13 Jun 2019 11:43:04 +0200
Message-Id: <20190613094326.24093-2-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/Kconfig | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/mm/Kconfig b/mm/Kconfig
index f0c76ba47695..0d2ba7e1f43e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -675,16 +675,6 @@ config ARCH_HAS_HMM_MIRROR
 	depends on (X86_64 || PPC64)
 	depends on MMU && 64BIT
 
-config ARCH_HAS_HMM_DEVICE
-	bool
-	default y
-	depends on (X86_64 || PPC64)
-	depends on MEMORY_HOTPLUG
-	depends on MEMORY_HOTREMOVE
-	depends on SPARSEMEM_VMEMMAP
-	depends on ARCH_HAS_ZONE_DEVICE
-	select XARRAY_MULTI
-
 config ARCH_HAS_HMM
 	bool
 	default y
-- 
2.20.1

