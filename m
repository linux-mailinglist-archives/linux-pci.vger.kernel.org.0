Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 623784F861E
	for <lists+linux-pci@lfdr.de>; Thu,  7 Apr 2022 19:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346250AbiDGR3y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Apr 2022 13:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346516AbiDGR1j (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 Apr 2022 13:27:39 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24A2100A5C;
        Thu,  7 Apr 2022 10:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Cc:To:From:content-disposition;
        bh=qwHhhptcjs675dAW5wV9iUf/ZWGXFcOtu4sOGzEzFjs=; b=EOT6Ow6UdVvIY4DKNDl28DKbdr
        XL5XBU0ol/6KJ5yyMeQNVEigE3hI5Hq4vvc9uqb7OcthVIfXm8w4RQpIMDrwoU1JA19vDtZcFnUxv
        l7jAKiqD9ealgWX/ab89zuM+BD85MGrlTeWGSadgaMFatmmm0Y/RkNARI8eHFX1+dzqYiaQLyxl20
        9DAAC0pIu2lI1X5Vo1nT8DW41LqG5BDQMmtDKYwT0g3x/8xszhQy7g+abnKiSf+qEbhvQuOU1qe3o
        SeUkhbs0C0A1KQMoBspjKBQVeW2vsuXxkiX5n3YFsn8s+JEHD0SNW9Y5gMID8PeWk3yZlXoJd2PpH
        ZryrM0ug==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ncUMM-002BBg-He; Thu, 07 Apr 2022 09:47:47 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1ncUMC-00021T-0m; Thu, 07 Apr 2022 09:47:36 -0600
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
        Ralph Campbell <rcampbell@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Date:   Thu,  7 Apr 2022 09:47:01 -0600
Message-Id: <20220407154717.7695-6-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220407154717.7695-1-logang@deltatee.com>
References: <20220407154717.7695-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, linux-block@vger.kernel.org, linux-pci@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux-foundation.org, sbates@raithlin.com, hch@lst.de, jgg@ziepe.ca, christian.koenig@amd.com, ddutile@redhat.com, willy@infradead.org, daniel.vetter@ffwll.ch, jason@jlekstrand.net, dave.hansen@linux.intel.com, helgaas@kernel.org, dan.j.williams@intel.com, andrzej.jakowski@intel.com, dave.b.minturn@intel.com, jianxin.xiong@intel.com, ira.weiny@intel.com, robin.murphy@arm.com, martin.oliveira@eideticom.com, ckulkarnilinux@gmail.com, logang@deltatee.com, jhubbard@nvidia.com, rcampbell@nvidia.com, jgg@nvidia.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Subject: [PATCH v6 05/21] dma-mapping: allow EREMOTEIO return code for P2PDMA transfers
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add EREMOTEIO error return to dma_map_sgtable() which will be used
by .map_sg() implementations that detect P2PDMA pages that the
underlying DMA device cannot access.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 kernel/dma/mapping.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index db7244291b74..9f65d1041638 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -197,7 +197,7 @@ static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
 	if (ents > 0)
 		debug_dma_map_sg(dev, sg, nents, ents, dir, attrs);
 	else if (WARN_ON_ONCE(ents != -EINVAL && ents != -ENOMEM &&
-			      ents != -EIO))
+			      ents != -EIO && ents != -EREMOTEIO))
 		return -EIO;
 
 	return ents;
@@ -255,6 +255,8 @@ EXPORT_SYMBOL(dma_map_sg_attrs);
  *		complete the mapping. Should succeed if retried later.
  *   -EIO	Legacy error code with an unknown meaning. eg. this is
  *		returned if a lower level call returned DMA_MAPPING_ERROR.
+ *   -EREMOTEIO	The DMA device cannot access P2PDMA memory specified in
+ *		the sg_table. This will not succeed if retried.
  */
 int dma_map_sgtable(struct device *dev, struct sg_table *sgt,
 		    enum dma_data_direction dir, unsigned long attrs)
-- 
2.30.2

