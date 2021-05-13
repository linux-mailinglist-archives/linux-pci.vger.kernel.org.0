Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A388538003A
	for <lists+linux-pci@lfdr.de>; Fri, 14 May 2021 00:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbhEMWdo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 May 2021 18:33:44 -0400
Received: from ale.deltatee.com ([204.191.154.188]:59270 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbhEMWdf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 May 2021 18:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=0So9SX+KFL5UGdS3JALTvYX2o53SL7VRdq+tjhsTXy0=; b=I4gtimz4ShXoyX5SWboyQE7w9W
        kswCvfBAelapFKYy/VPPbAd+QkaSuIAqHlXoTcAipI2SaLnx+SDRzveGPiIcMUB2G5CoYuZnBiUoK
        cu7iuEkqkWIX94CubpeWjdBSdOBEtxInnOWWGpZYeh2fTtHzv2DX0RLaoxvszUNHOBXykRVaHV6QD
        absF9Bc5hfqjFj0ZdNxXNkltgm9NTg4CaRK3DsGrUC+8wsLJm+BB++pNBn4hKlWSX9qI6taQGPqWr
        Bx62ylIINBEFIDpk3SjxAVzcVvEAlntfW9pr65kzz0z3wVqv2rZZkVz+M9yxmGuHDi6JPsTV0KHU0
        pKR3doDA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lhJsW-0000nF-GA; Thu, 13 May 2021 16:32:25 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.92)
        (envelope-from <gunthorp@deltatee.com>)
        id 1lhJsG-0001St-Vi; Thu, 13 May 2021 16:32:09 -0600
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
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 13 May 2021 16:31:50 -0600
Message-Id: <20210513223203.5542-10-logang@deltatee.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210513223203.5542-1-logang@deltatee.com>
References: <20210513223203.5542-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, jhubbard@nvidia.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_NO_TEXT autolearn=no autolearn_force=no version=3.4.2
Subject: [PATCH v2 09/22] dma-direct: Return appropriate error code from dma_direct_map_sg()
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Now that the map_sg() op expects error codes instead of return zero on
error, convert dma_direct_map_sg() to return an error code. The
only error to return presently is EINVAL if a page could not
be mapped.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 kernel/dma/direct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index f737e3347059..803ee9321170 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -411,7 +411,7 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
 
 out_unmap:
 	dma_direct_unmap_sg(dev, sgl, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
-	return 0;
+	return -EINVAL;
 }
 
 dma_addr_t dma_direct_map_resource(struct device *dev, phys_addr_t paddr,
-- 
2.20.1

