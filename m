Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F07740EE1E
	for <lists+linux-pci@lfdr.de>; Fri, 17 Sep 2021 01:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241811AbhIPXmt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Sep 2021 19:42:49 -0400
Received: from ale.deltatee.com ([204.191.154.188]:40788 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241747AbhIPXmj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Sep 2021 19:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=Yz7/Dg6RG5uFdKEWz7fCfOIaPt94X46Gov2AZcvx1yo=; b=Zs5M0NYfy/xXFIpoRhIv/Q09ZY
        ZNc/ktEXRqFRUQ+RWdFANpv1kwCS8ebErssaGlf7W80S5v4VxCqpX8RXs9LKkKbngodxeBilCfs5e
        CsjCMmoIudLnULI2ucZuyWZu1VJfOutGm7bhiIuXdjAXF8SnCtNM5TVY25JlXwPjkskE+Ks7mxijw
        53vbhVCYOixN7WhIzEfOTo1VcRJet7jxCqs8dGnKkVqyx+aiA/RPQsEPYPPEWgn4+cGJ0kksM+vhV
        fQjwR64UCzxdbE/QXaFFwtchbj0IzuJ8j8PuKTF3bP28hlTQS/NsojchbXUwKQn8+6YayRpq1UHsl
        JEwRTA/Q==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1mR10H-0008I1-GG; Thu, 16 Sep 2021 17:41:18 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1mR104-000Vr1-5i; Thu, 16 Sep 2021 17:41:04 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org
Cc:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        Chaitanya Kulkarni <ckulkarnilinux@gmail.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 16 Sep 2021 17:40:45 -0600
Message-Id: <20210916234100.122368-6-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210916234100.122368-1-logang@deltatee.com>
References: <20210916234100.122368-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_NO_TEXT autolearn=no autolearn_force=no version=3.4.2
Subject: [PATCH v3 05/20] dma-mapping: allow EREMOTEIO return code for P2PDMA transfers
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add EREMOTEIO error return to dma_map_sgtable() which will be used
by .map_sg() implementations that detect P2PDMA pages that the
underlying DMA device cannot access.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 kernel/dma/mapping.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index 7ee5284bff58..7315ae31cf1d 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -197,7 +197,7 @@ static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 	if (ents > 0)
 		debug_dma_map_sg(dev, sg, nents, ents, dir);
 	else if (WARN_ON_ONCE(ents != -EINVAL && ents != -ENOMEM &&
-			      ents != -EIO))
+			      ents != -EIO && ents != -EREMOTEIO))
 		return -EIO;
 
 	return ents;
@@ -248,12 +248,14 @@ EXPORT_SYMBOL(dma_map_sg_attrs);
  * Returns 0 on success or a negative error code on error. The following
  * error codes are supported with the given meaning:
  *
- *   -EINVAL - An invalid argument, unaligned access or other error
- *	       in usage. Will not succeed if retried.
- *   -ENOMEM - Insufficient resources (like memory or IOVA space) to
- *	       complete the mapping. Should succeed if retried later.
- *   -EIO    - Legacy error code with an unknown meaning. eg. this is
- *	       returned if a lower level call returned DMA_MAPPING_ERROR.
+ *   -EINVAL	- An invalid argument, unaligned access or other error
+ *		  in usage. Will not succeed if retried.
+ *   -ENOMEM	- Insufficient resources (like memory or IOVA space) to
+ *		  complete the mapping. Should succeed if retried later.
+ *   -EIO	- Legacy error code with an unknown meaning. eg. this is
+ *	          returned if a lower level call returned DMA_MAPPING_ERROR.
+ *   -EREMOTEIO	- The DMA device cannot access P2PDMA memory specified in
+ *		  the sg_table. This will not succeed if retried.
  */
 int dma_map_sgtable(struct device *dev, struct sg_table *sgt,
 		    enum dma_data_direction dir, unsigned long attrs)
-- 
2.30.2

